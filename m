From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 30 Mar 2010 18:58:25 -0500
Subject: [PATCH 1/4] arm: msm: gpio support
In-Reply-To: <1269990717-2969-1-git-send-email-dwalker@codeaurora.org>
References: <> <1269990717-2969-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <0D753D10438DA54287A00B027084269763691C346E@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, March 30, 2010 4:12 PM, Daniel Walker wrote:
> From: Daniel Walker <c_dwalke@quicinc.com>
>
> This adds basic gpio support in MSM using gpiolib, as well as gpio
> interrupt support.
>
> Signed-off-by: Daniel Walker <c_dwalke@quicinc.com>
> ---
>  arch/arm/Kconfig                      |    1 +
>  arch/arm/mach-msm/Makefile            |    1 +
>  arch/arm/mach-msm/gpio.c              |  428 +++++++++++++++++++++++++++++++++
>  arch/arm/mach-msm/gpio_hw.h           |  187 ++++++++++++++
>  arch/arm/mach-msm/include/mach/gpio.h |   43 ++++
>  5 files changed, 660 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-msm/gpio.c
>  create mode 100644 arch/arm/mach-msm/gpio_hw.h
>  create mode 100644 arch/arm/mach-msm/include/mach/gpio.h
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index cadfe2e..5e29092 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -601,6 +601,7 @@ config ARCH_MSM
>       select CPU_V6
>       select GENERIC_TIME
>       select GENERIC_CLOCKEVENTS
> +     select ARCH_REQUIRE_GPIOLIB
>       help
>         Support for Qualcomm MSM7K based systems.  This runs on the ARM11
>         apps processor of the MSM7K and depends on a shared memory
> diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
> index 147339c..47d47cb 100644
> --- a/arch/arm/mach-msm/Makefile
> +++ b/arch/arm/mach-msm/Makefile
> @@ -4,6 +4,7 @@ obj-y += proc_comm.o
>  obj-y += vreg.o
>  obj-y += acpuclock-arm11.o
>  obj-y += clock.o clock-7x01a.o
> +obj-y += gpio.o
>
>  obj-$(CONFIG_MSM_SMD) += smd.o smd_debug.o
>  obj-$(CONFIG_MSM_SMD) += last_radio_log.o
> diff --git a/arch/arm/mach-msm/gpio.c b/arch/arm/mach-msm/gpio.c
> new file mode 100644
> index 0000000..5b95885
> --- /dev/null
> +++ b/arch/arm/mach-msm/gpio.c
> @@ -0,0 +1,428 @@
> +/* linux/arch/arm/mach-msm/gpio.c
> + *
> + * Copyright (C) 2007 Google, Inc.
> + * Copyright (c) 2010, Code Aurora Forum. All rights reserved.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +#include <asm/io.h>

#include <linux/io.h>

> +#include <asm/irq.h>

This one is not needed.

> +#include <linux/irq.h>

This includes the <asm/irq.h> for you.

> +#include <linux/module.h>
> +#include <linux/gpio.h>
> +#include "gpio_hw.h"
> +
> +#include "smd_private.h"
> +
> +static int msm_gpio_debug_mask;
> +module_param_named(debug_mask, msm_gpio_debug_mask, int,
> +                S_IRUGO | S_IWUSR | S_IWGRP);
> +
> +#define MSM_GPIO_BROKEN_INT_CLEAR 1
> +
> +/* private gpio_configure flags */
> +#define MSM_GPIOF_ENABLE_INTERRUPT      0x10000000
> +#define MSM_GPIOF_DISABLE_INTERRUPT     0x20000000
> +#define MSM_GPIOF_ENABLE_WAKE           0x40000000
> +#define MSM_GPIOF_DISABLE_WAKE          0x80000000
> +
> +static int gpio_chip_to_irq(struct gpio_chip *chip, unsigned offset);
> +static void gpio_chip_set(struct gpio_chip *chip, unsigned offset, int value);
> +static int gpio_chip_get(struct gpio_chip *chip, unsigned offset);
> +static int gpio_chip_direction_input(struct gpio_chip *chip, unsigned offset);
> +static int gpio_chip_direction_output(struct gpio_chip *chip, unsigned offset,
> +                                   int value);

Can the code be re-ordered to eliminate the prototypes?

> +
> +struct msm_gpio_regs {
> +     void __iomem *out;
> +     void __iomem *in;
> +     void __iomem *int_status;
> +     void __iomem *int_clear;
> +     void __iomem *int_en;
> +     void __iomem *int_edge;
> +     void __iomem *int_pos;
> +     void __iomem *oe;
> +};
> +
> +struct msm_gpio_chip {
> +     struct gpio_chip        chip;
> +     struct msm_gpio_regs    regs;
> +     spinlock_t              lock;
> +#if MSM_GPIO_BROKEN_INT_CLEAR
> +     unsigned                int_status_copy;
> +#endif
> +     unsigned int            both_edge_detect;
> +     unsigned int            int_enable[2]; /* 0: awake, 1: sleep */
> +};
> +
> +#define MSM_GPIO_BANK(name, reg_num, start, end)                     \
> +     {                                                               \
> +             .regs = {                                               \
> +                     .out =         GPIO_OUT_ ## reg_num,            \
> +                     .in =          GPIO_IN_ ## reg_num ,            \
> +                     .int_status =  GPIO_INT_STATUS_ ## reg_num,     \
> +                     .int_clear =   GPIO_INT_CLEAR_ ## reg_num,      \
> +                     .int_en =      GPIO_INT_EN_ ## reg_num,         \
> +                     .int_edge =    GPIO_INT_EDGE_ ## reg_num,       \
> +                     .int_pos =     GPIO_INT_POS_ ## reg_num,        \
> +                     .oe =          GPIO_OE_ ## reg_num,             \
> +             },                                                      \
> +             .chip = {                                               \
> +                     .label = name,                                  \
> +                     .ngpio = end - start + 1,                       \
> +                     .direction_input = gpio_chip_direction_input,   \
> +                     .direction_output = gpio_chip_direction_output, \
> +                     .get = gpio_chip_get,                           \
> +                     .set = gpio_chip_set,                           \
> +                     .to_irq = gpio_chip_to_irq,                     \
> +                     .base = start,                                  \
> +             }                                                       \
> +     }
> +
> +struct msm_gpio_chip msm_gpio_chips[] = {
> +     MSM_GPIO_BANK("bank0", 0, 0, 15),
> +     MSM_GPIO_BANK("bank1", 1, 16, 42),
> +     MSM_GPIO_BANK("bank2", 2, 43, 67),
> +     MSM_GPIO_BANK("bank3", 3, 68, 94),
> +#if defined(CONFIG_ARCH_QSD8X50)
> +     MSM_GPIO_BANK("bank4", 4, 95, 103),
> +     MSM_GPIO_BANK("bank5", 5, 104, 121),
> +     MSM_GPIO_BANK("bank6", 6, 122, 152),
> +     MSM_GPIO_BANK("bank7", 7, 153, 164),
> +#else
> +     MSM_GPIO_BANK("bank4", 4, 95, 106),
> +     MSM_GPIO_BANK("bank5", 5, 107, 121),
> +#endif
> +};
> +
> +#define to_msm_gpio_chip(c) container_of(c, struct msm_gpio_chip, chip)
> +
> +static int gpio_chip_direction_input(struct gpio_chip *chip, unsigned offset)
> +{
> +     struct msm_gpio_chip *old_chip = to_msm_gpio_chip(chip);
> +     unsigned long irq_flags;
> +     unsigned b = 1U << (offset);

The () around offset are not needed.

> +     unsigned v;
> +
> +     spin_lock_irqsave(&old_chip->lock, irq_flags);
> +     b = 1U << (offset);

Not needed.  You already did it above.

> +
> +     v = readl(old_chip->regs.oe);
> +     writel(v & (~b), old_chip->regs.oe);

Again, the () around ~b are not needed.  There are a number of these in this file.

> +
> +     spin_unlock_irqrestore(&old_chip->lock, irq_flags);
> +
> +     return 0;
> +}
> +
> +static int gpio_chip_get(struct gpio_chip *chip, unsigned offset)
> +{
> +     struct msm_gpio_chip *old_chip = to_msm_gpio_chip(chip);
> +     unsigned long irq_flags;
> +     int ret = -ENOTSUPP;
> +     unsigned b;
> +
> +     spin_lock_irqsave(&old_chip->lock, irq_flags);
> +     b = 1U << (offset);
> +
> +     ret = (readl(old_chip->regs.in)) & b ? 1 : 0;
> +
> +     spin_unlock_irqrestore(&old_chip->lock, irq_flags);
> +     return ret;
> +}
> +
> +static inline int
> +msm_gpio_write(struct msm_gpio_chip *chip, unsigned n, unsigned on)
> +{
> +     unsigned b = 1U << n;
> +     unsigned v;
> +
> +     v = readl(chip->regs.out);
> +     if (on)
> +             writel(v | b, chip->regs.out);
> +     else
> +             writel(v & (~b), chip->regs.out);
> +
> +     return 0;
> +}
> +
> +static int
> +gpio_chip_direction_output(struct gpio_chip *chip, unsigned offset, int value)
> +{
> +     struct msm_gpio_chip *old_chip = to_msm_gpio_chip(chip);
> +     unsigned long irq_flags;
> +     unsigned v;
> +
> +     spin_lock_irqsave(&old_chip->lock, irq_flags);
> +
> +     msm_gpio_write(old_chip, offset, value);
> +
> +     v = readl(old_chip->regs.oe);
> +     writel(v | offset, old_chip->regs.oe);
> +
> +     spin_unlock_irqrestore(&old_chip->lock, irq_flags);
> +
> +     return 0;
> +}
> +
> +static void gpio_chip_set(struct gpio_chip *chip, unsigned offset, int value)
> +{
> +     struct msm_gpio_chip *old_chip = to_msm_gpio_chip(chip);
> +     unsigned long irq_flags;
> +
> +     spin_lock_irqsave(&old_chip->lock, irq_flags);
> +
> +     msm_gpio_write(old_chip, offset, value);
> +
> +     spin_unlock_irqrestore(&old_chip->lock, irq_flags);
> +}
> +
> +static int gpio_chip_to_irq(struct gpio_chip *chip, unsigned offset)
> +{
> +     struct msm_gpio_chip *old_chip = to_msm_gpio_chip(chip);
> +     unsigned long irq_flags;
> +     int ret;
> +
> +     spin_lock_irqsave(&old_chip->lock, irq_flags);
> +     ret = MSM_GPIO_TO_INT(offset);
> +     spin_unlock_irqrestore(&old_chip->lock, irq_flags);
> +
> +     return ret;
> +}
> +
> +
> +static void msm_gpio_update_both_edge_detect(struct msm_gpio_chip *msm_chip)
> +{
> +     int loop_limit = 100;
> +     unsigned pol, val, val2, intstat;
> +     do {
> +             val = readl(msm_chip->regs.in);
> +             pol = readl(msm_chip->regs.int_pos);
> +             pol = (pol & ~msm_chip->both_edge_detect) |
> +                   (~val & msm_chip->both_edge_detect);
> +
> +             writel(pol, msm_chip->regs.int_pos);
> +
> +             intstat = readl(msm_chip->regs.int_status);
> +             val2 = readl(msm_chip->regs.in);
> +
> +             if (((val ^ val2) & msm_chip->both_edge_detect & ~intstat) == 0)
> +                     return;
> +     } while (loop_limit-- > 0);
> +     printk(KERN_ERR "msm_gpio_update_both_edge_detect, failed to reach stable state %x != %x\n", val, val2);
> +}
> +
> +static void msm_gpio_irq_ack(unsigned int irq)
> +{
> +     unsigned long irq_flags;
> +     struct msm_gpio_chip *msm_chip = get_irq_chip_data(irq);
> +     unsigned b;
> +
> +     spin_lock_irqsave(&msm_chip->lock, irq_flags);
> +
> +     b = 1U << (irq - FIRST_GPIO_IRQ - msm_chip->chip.base);

Urk... That's a bit confusing...

You might want to make this a macro or an inline function with some kind
of comment.

> +
> +#if MSM_GPIO_BROKEN_INT_CLEAR
> +     /* Save interrupts that already triggered before we loose them. */
> +     /* Any interrupt that triggers between the read of int_status */
> +     /* and the write to int_clear will still be lost though. */
> +     msm_chip->int_status_copy |= readl(msm_chip->regs.int_status);
> +     msm_chip->int_status_copy &= ~b;
> +#endif
> +     writel(b, msm_chip->regs.int_clear);
> +
> +     msm_gpio_update_both_edge_detect(msm_chip);
> +     spin_unlock_irqrestore(&msm_chip->lock, irq_flags);
> +}
> +
> +static void msm_gpio_irq_mask(unsigned int irq)
> +{
> +     unsigned long irq_flags;
> +     struct msm_gpio_chip *msm_chip = get_irq_chip_data(irq);
> +     unsigned b, v;
> +
> +     spin_lock_irqsave(&msm_chip->lock, irq_flags);
> +
> +     b = 1U << (irq - FIRST_GPIO_IRQ - msm_chip->chip.base);
> +
> +     v = readl(msm_chip->regs.int_edge);
> +     /* level triggered interrupts are also latched */
> +     if (!(v & b)) {
> +
> +     #if MSM_GPIO_BROKEN_INT_CLEAR

Align the #if/#endif to the first column.

> +             /* Save interrupts that already triggered before we loose
> +              * them. Any interrupt that triggers between the read of
> +              * int_status and the write to int_clear will still be
> +              * lost though.
> +              */
> +             msm_chip->int_status_copy |= readl(msm_chip->regs.int_status);
> +             msm_chip->int_status_copy &= ~b;
> +     #endif
> +             writel(b, msm_chip->regs.int_clear);
> +             msm_gpio_update_both_edge_detect(msm_chip);
> +     }
> +
> +     msm_chip->int_enable[0] &= ~b;
> +     writel(msm_chip->int_enable[0], msm_chip->regs.int_en);
> +
> +     spin_unlock_irqrestore(&msm_chip->lock, irq_flags);
> +}
> +
> +static void msm_gpio_irq_unmask(unsigned int irq)
> +{
> +     unsigned long irq_flags;
> +     struct msm_gpio_chip *msm_chip = get_irq_chip_data(irq);
> +     unsigned b, v;
> +
> +     spin_lock_irqsave(&msm_chip->lock, irq_flags);
> +
> +     b = 1U << (irq - FIRST_GPIO_IRQ - msm_chip->chip.base);
> +
> +     v = readl(msm_chip->regs.int_edge);
> +     /* level triggered interrupts are also latched */
> +     if (!(v & b)) {
> +
> +     #if MSM_GPIO_BROKEN_INT_CLEAR
> +             /* Save interrupts that already triggered before we loose
> +              * them. Any interrupt that triggers between the read of
> +              * int_status and the write to int_clear will still be
> +              * lost though.
> +              */
> +             msm_chip->int_status_copy |= readl(msm_chip->regs.int_status);
> +             msm_chip->int_status_copy &= ~b;
> +     #endif
> +             writel(b, msm_chip->regs.int_clear);
> +             msm_gpio_update_both_edge_detect(msm_chip);
> +     }
> +
> +     msm_chip->int_enable[0] |= b;
> +     writel(msm_chip->int_enable[0], msm_chip->regs.int_en);
> +
> +     spin_unlock_irqrestore(&msm_chip->lock, irq_flags);
> +}
> +
> +static int msm_gpio_irq_set_wake(unsigned int irq, unsigned int on)
> +{
> +     unsigned long irq_flags;
> +     struct msm_gpio_chip *msm_chip = get_irq_chip_data(irq);
> +     unsigned b;
> +
> +     spin_lock_irqsave(&msm_chip->lock, irq_flags);
> +
> +     b = 1U << (irq - FIRST_GPIO_IRQ - msm_chip->chip.base);
> +
> +     if (on)
> +             msm_chip->int_enable[1] |= b;
> +     else
> +             msm_chip->int_enable[1] &= ~b;
> +
> +     spin_unlock_irqrestore(&msm_chip->lock, irq_flags);
> +
> +     return 0;
> +}
> +
> +
> +static int msm_gpio_irq_set_type(unsigned int irq, unsigned int flow_type)
> +{
> +     unsigned long irq_flags;
> +     struct msm_gpio_chip *msm_chip = get_irq_chip_data(irq);
> +     unsigned b, v;
> +
> +     spin_lock_irqsave(&msm_chip->lock, irq_flags);
> +
> +     b = 1U << (irq - FIRST_GPIO_IRQ - msm_chip->chip.base);
> +
> +     v = readl(msm_chip->regs.int_edge);
> +     if (flow_type & (IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING)) {
> +             writel(v | b, msm_chip->regs.int_edge);
> +             irq_desc[MSM_GPIO_TO_INT(irq - FIRST_GPIO_IRQ)].handle_irq = handle_edge_irq;
> +     } else {
> +             writel(v & (~b), msm_chip->regs.int_edge);
> +             irq_desc[MSM_GPIO_TO_INT(irq - FIRST_GPIO_IRQ)].handle_irq = handle_level_irq;
> +     }
> +     if ((flow_type & (IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING)) ==
> +                      (IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING)) {
> +             msm_chip->both_edge_detect |= b;
> +             msm_gpio_update_both_edge_detect(msm_chip);
> +     } else {
> +             msm_chip->both_edge_detect &= ~b;
> +             v = readl(msm_chip->regs.int_pos);
> +             if (flow_type & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_HIGH))
> +                     writel(v | b, msm_chip->regs.int_pos);
> +             else
> +                     writel(v & (~b), msm_chip->regs.int_pos);
> +
> +     }
> +     spin_unlock_irqrestore(&msm_chip->lock, irq_flags);
> +     return 0;
> +}
> +
> +static void msm_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
> +{
> +     int i, j, m;
> +     unsigned v;
> +
> +     for (i = 0; i < ARRAY_SIZE(msm_gpio_chips); i++) {
> +             struct msm_gpio_chip *msm_chip = &msm_gpio_chips[i];
> +             v = readl(msm_chip->regs.int_status);
> +             v &= msm_chip->int_enable[0];
> +             while (v) {
> +                     m = v & -v;
> +                     j = fls(m) - 1;
> +                     v &= ~m;
> +                     generic_handle_irq(FIRST_GPIO_IRQ + msm_chip->chip.base + j);
> +             }
> +     }
> +     desc->chip->ack(irq);
> +}
> +
> +static struct irq_chip msm_gpio_irq_chip = {
> +     .name      = "msmgpio",
> +     .ack       = msm_gpio_irq_ack,
> +     .mask      = msm_gpio_irq_mask,
> +     .unmask    = msm_gpio_irq_unmask,
> +     .set_wake  = msm_gpio_irq_set_wake,
> +     .set_type  = msm_gpio_irq_set_type,
> +};
> +
> +static int __init msm_init_gpio(void)
> +{
> +     int i, j = 0;
> +     for (i = FIRST_GPIO_IRQ; i < FIRST_GPIO_IRQ + NR_GPIO_IRQS; i++) {
> +             if (i - FIRST_GPIO_IRQ > msm_gpio_chips[j].chip.ngpio - 1)
> +                     j++;
> +             set_irq_chip_data(i, &msm_gpio_chips[j]);
> +             set_irq_chip(i, &msm_gpio_irq_chip);
> +             set_irq_handler(i, handle_edge_irq);
> +             set_irq_flags(i, IRQF_VALID);
> +     }
> +
> +     for (i = 0; i < ARRAY_SIZE(msm_gpio_chips); i++) {
> +             writel(0, msm_gpio_chips[i].regs.int_en);
> +             spin_lock_init(&msm_gpio_chips[i].lock);
> +             gpiochip_add(&msm_gpio_chips[i].chip);
> +     }
> +
> +     set_irq_chained_handler(INT_GPIO_GROUP1, msm_gpio_irq_handler);
> +     set_irq_chained_handler(INT_GPIO_GROUP2, msm_gpio_irq_handler);
> +     set_irq_wake(INT_GPIO_GROUP1, 1);
> +     set_irq_wake(INT_GPIO_GROUP2, 2);
> +
> +     return 0;
> +}
> +
> +postcore_initcall(msm_init_gpio);
> diff --git a/arch/arm/mach-msm/gpio_hw.h b/arch/arm/mach-msm/gpio_hw.h
> new file mode 100644
> index 0000000..f7e1b5b
> --- /dev/null
> +++ b/arch/arm/mach-msm/gpio_hw.h
> @@ -0,0 +1,187 @@
> +/* arch/arm/mach-msm/gpio_hw.h
> + *
> + * Copyright (C) 2007 Google, Inc.
> + * Author: Brian Swetland <swetland@google.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#ifndef __ARCH_ARM_MACH_MSM_GPIO_HW_H
> +#define __ARCH_ARM_MACH_MSM_GPIO_HW_H
> +
> +#include <mach/msm_iomap.h>
> +
> +/* see 80-VA736-2 Rev C pp 695-751
> +**
> +** These are actually the *shadow* gpio registers, since the
> +** real ones (which allow full access) are only available to the
> +** ARM9 side of the world.
> +**
> +** Since the _BASE need to be page-aligned when we're mapping them
> +** to virtual addresses, adjust for the additional offset in these
> +** macros.
> +*/
> +

All the #define'd names in this file are pretty generic.  You should
probably add a prefix (MSM_ ?) to all of them.

Also, you should use tabs instead of spaces between the #define <name><tabs><something>

> +#define GPIO1_REG(off) (MSM_GPIO1_BASE + 0x800 + (off))
> +#define GPIO2_REG(off) (MSM_GPIO2_BASE + 0xC00 + (off))
> +
> +#if defined(CONFIG_ARCH_MSM7X00A)
> +
> +/* output value */
> +#define GPIO_OUT_0         GPIO1_REG(0x00)  /* gpio  15-0  */
> +#define GPIO_OUT_1         GPIO2_REG(0x00)  /* gpio  42-16 */
> +#define GPIO_OUT_2         GPIO1_REG(0x04)  /* gpio  67-43 */
> +#define GPIO_OUT_3         GPIO1_REG(0x08)  /* gpio  94-68 */
> +#define GPIO_OUT_4         GPIO1_REG(0x0C)  /* gpio 106-95 */
> +#define GPIO_OUT_5         GPIO1_REG(0x50)  /* gpio 107-121 */
> +
> +/* same pin map as above, output enable */
> +#define GPIO_OE_0          GPIO1_REG(0x10)
> +#define GPIO_OE_1          GPIO2_REG(0x08)
> +#define GPIO_OE_2          GPIO1_REG(0x14)
> +#define GPIO_OE_3          GPIO1_REG(0x18)
> +#define GPIO_OE_4          GPIO1_REG(0x1C)
> +#define GPIO_OE_5          GPIO1_REG(0x54)
> +
> +/* same pin map as above, input read */
> +#define GPIO_IN_0          GPIO1_REG(0x34)
> +#define GPIO_IN_1          GPIO2_REG(0x20)
> +#define GPIO_IN_2          GPIO1_REG(0x38)
> +#define GPIO_IN_3          GPIO1_REG(0x3C)
> +#define GPIO_IN_4          GPIO1_REG(0x40)
> +#define GPIO_IN_5          GPIO1_REG(0x44)
> +
> +/* same pin map as above, 1=edge 0=level interrup */
> +#define GPIO_INT_EDGE_0    GPIO1_REG(0x60)
> +#define GPIO_INT_EDGE_1    GPIO2_REG(0x50)
> +#define GPIO_INT_EDGE_2    GPIO1_REG(0x64)
> +#define GPIO_INT_EDGE_3    GPIO1_REG(0x68)
> +#define GPIO_INT_EDGE_4    GPIO1_REG(0x6C)
> +#define GPIO_INT_EDGE_5    GPIO1_REG(0xC0)
> +
> +/* same pin map as above, 1=positive 0=negative */
> +#define GPIO_INT_POS_0     GPIO1_REG(0x70)
> +#define GPIO_INT_POS_1     GPIO2_REG(0x58)
> +#define GPIO_INT_POS_2     GPIO1_REG(0x74)
> +#define GPIO_INT_POS_3     GPIO1_REG(0x78)
> +#define GPIO_INT_POS_4     GPIO1_REG(0x7C)
> +#define GPIO_INT_POS_5     GPIO1_REG(0xBC)
> +
> +/* same pin map as above, interrupt enable */
> +#define GPIO_INT_EN_0      GPIO1_REG(0x80)
> +#define GPIO_INT_EN_1      GPIO2_REG(0x60)
> +#define GPIO_INT_EN_2      GPIO1_REG(0x84)
> +#define GPIO_INT_EN_3      GPIO1_REG(0x88)
> +#define GPIO_INT_EN_4      GPIO1_REG(0x8C)
> +#define GPIO_INT_EN_5      GPIO1_REG(0xB8)
> +
> +/* same pin map as above, write 1 to clear interrupt */
> +#define GPIO_INT_CLEAR_0   GPIO1_REG(0x90)
> +#define GPIO_INT_CLEAR_1   GPIO2_REG(0x68)
> +#define GPIO_INT_CLEAR_2   GPIO1_REG(0x94)
> +#define GPIO_INT_CLEAR_3   GPIO1_REG(0x98)
> +#define GPIO_INT_CLEAR_4   GPIO1_REG(0x9C)
> +#define GPIO_INT_CLEAR_5   GPIO1_REG(0xB4)
> +
> +/* same pin map as above, 1=interrupt pending */
> +#define GPIO_INT_STATUS_0  GPIO1_REG(0xA0)
> +#define GPIO_INT_STATUS_1  GPIO2_REG(0x70)
> +#define GPIO_INT_STATUS_2  GPIO1_REG(0xA4)
> +#define GPIO_INT_STATUS_3  GPIO1_REG(0xA8)
> +#define GPIO_INT_STATUS_4  GPIO1_REG(0xAC)
> +#define GPIO_INT_STATUS_5  GPIO1_REG(0xB0)
> +
> +#endif
> +
> +#if defined(CONFIG_ARCH_QSD8X50)
> +/* output value */
> +#define GPIO_OUT_0         GPIO1_REG(0x00)  /* gpio  15-0   */
> +#define GPIO_OUT_1         GPIO2_REG(0x00)  /* gpio  42-16  */
> +#define GPIO_OUT_2         GPIO1_REG(0x04)  /* gpio  67-43  */
> +#define GPIO_OUT_3         GPIO1_REG(0x08)  /* gpio  94-68  */
> +#define GPIO_OUT_4         GPIO1_REG(0x0C)  /* gpio 103-95  */
> +#define GPIO_OUT_5         GPIO1_REG(0x10)  /* gpio 121-104 */
> +#define GPIO_OUT_6         GPIO1_REG(0x14)  /* gpio 152-122 */
> +#define GPIO_OUT_7         GPIO1_REG(0x18)  /* gpio 164-153 */
> +
> +/* same pin map as above, output enable */
> +#define GPIO_OE_0          GPIO1_REG(0x20)
> +#define GPIO_OE_1          GPIO2_REG(0x08)
> +#define GPIO_OE_2          GPIO1_REG(0x24)
> +#define GPIO_OE_3          GPIO1_REG(0x28)
> +#define GPIO_OE_4          GPIO1_REG(0x2C)
> +#define GPIO_OE_5          GPIO1_REG(0x30)
> +#define GPIO_OE_6          GPIO1_REG(0x34)
> +#define GPIO_OE_7          GPIO1_REG(0x38)
> +
> +/* same pin map as above, input read */
> +#define GPIO_IN_0          GPIO1_REG(0x50)
> +#define GPIO_IN_1          GPIO2_REG(0x20)
> +#define GPIO_IN_2          GPIO1_REG(0x54)
> +#define GPIO_IN_3          GPIO1_REG(0x58)
> +#define GPIO_IN_4          GPIO1_REG(0x5C)
> +#define GPIO_IN_5          GPIO1_REG(0x60)
> +#define GPIO_IN_6          GPIO1_REG(0x64)
> +#define GPIO_IN_7          GPIO1_REG(0x68)
> +
> +/* same pin map as above, 1=edge 0=level interrup */
> +#define GPIO_INT_EDGE_0    GPIO1_REG(0x70)
> +#define GPIO_INT_EDGE_1    GPIO2_REG(0x50)
> +#define GPIO_INT_EDGE_2    GPIO1_REG(0x74)
> +#define GPIO_INT_EDGE_3    GPIO1_REG(0x78)
> +#define GPIO_INT_EDGE_4    GPIO1_REG(0x7C)
> +#define GPIO_INT_EDGE_5    GPIO1_REG(0x80)
> +#define GPIO_INT_EDGE_6    GPIO1_REG(0x84)
> +#define GPIO_INT_EDGE_7    GPIO1_REG(0x88)
> +
> +/* same pin map as above, 1=positive 0=negative */
> +#define GPIO_INT_POS_0     GPIO1_REG(0x90)
> +#define GPIO_INT_POS_1     GPIO2_REG(0x58)
> +#define GPIO_INT_POS_2     GPIO1_REG(0x94)
> +#define GPIO_INT_POS_3     GPIO1_REG(0x98)
> +#define GPIO_INT_POS_4     GPIO1_REG(0x9C)
> +#define GPIO_INT_POS_5     GPIO1_REG(0xA0)
> +#define GPIO_INT_POS_6     GPIO1_REG(0xA4)
> +#define GPIO_INT_POS_7     GPIO1_REG(0xA8)
> +
> +/* same pin map as above, interrupt enable */
> +#define GPIO_INT_EN_0      GPIO1_REG(0xB0)
> +#define GPIO_INT_EN_1      GPIO2_REG(0x60)
> +#define GPIO_INT_EN_2      GPIO1_REG(0xB4)
> +#define GPIO_INT_EN_3      GPIO1_REG(0xB8)
> +#define GPIO_INT_EN_4      GPIO1_REG(0xBC)
> +#define GPIO_INT_EN_5      GPIO1_REG(0xC0)
> +#define GPIO_INT_EN_6      GPIO1_REG(0xC4)
> +#define GPIO_INT_EN_7      GPIO1_REG(0xC8)
> +
> +/* same pin map as above, write 1 to clear interrupt */
> +#define GPIO_INT_CLEAR_0   GPIO1_REG(0xD0)
> +#define GPIO_INT_CLEAR_1   GPIO2_REG(0x68)
> +#define GPIO_INT_CLEAR_2   GPIO1_REG(0xD4)
> +#define GPIO_INT_CLEAR_3   GPIO1_REG(0xD8)
> +#define GPIO_INT_CLEAR_4   GPIO1_REG(0xDC)
> +#define GPIO_INT_CLEAR_5   GPIO1_REG(0xE0)
> +#define GPIO_INT_CLEAR_6   GPIO1_REG(0xE4)
> +#define GPIO_INT_CLEAR_7   GPIO1_REG(0xE8)
> +
> +/* same pin map as above, 1=interrupt pending */
> +#define GPIO_INT_STATUS_0  GPIO1_REG(0xF0)
> +#define GPIO_INT_STATUS_1  GPIO2_REG(0x70)
> +#define GPIO_INT_STATUS_2  GPIO1_REG(0xF4)
> +#define GPIO_INT_STATUS_3  GPIO1_REG(0xF8)
> +#define GPIO_INT_STATUS_4  GPIO1_REG(0xFC)
> +#define GPIO_INT_STATUS_5  GPIO1_REG(0x100)
> +#define GPIO_INT_STATUS_6  GPIO1_REG(0x104)
> +#define GPIO_INT_STATUS_7  GPIO1_REG(0x108)
> +
> +#endif
> +
> +#endif
> diff --git a/arch/arm/mach-msm/include/mach/gpio.h b/arch/arm/mach-msm/include/mach/gpio.h
> new file mode 100644
> index 0000000..784e6f5
> --- /dev/null
> +++ b/arch/arm/mach-msm/include/mach/gpio.h
> @@ -0,0 +1,43 @@
> +/* linux/include/asm-arm/arch-msm/gpio.h
> + *
> + * Copyright (C) 2007 Google, Inc.
> + * Author: Mike Lockwood <lockwood@android.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#ifndef __ASM_ARCH_MSM_GPIO_H
> +#define __ASM_ARCH_MSM_GPIO_H
> +
> +#include <linux/interrupt.h>

Why is this included?

> +#include <asm-generic/gpio.h>
> +
> +static inline int gpio_get_value(unsigned gpio)
> +{
> +     return __gpio_get_value(gpio);
> +}
> +
> +static inline void gpio_set_value(unsigned gpio, int value)
> +{
> +     __gpio_set_value(gpio, value);
> +}
> +
> +static inline int gpio_cansleep(unsigned gpio)
> +{
> +     return __gpio_cansleep(gpio);
> +}
> +
> +static inline int gpio_to_irq(unsigned gpio)
> +{
> +     return __gpio_to_irq(gpio);
> +}
> +

These could all just be:

#define gpio_get_value  __gpio_get_value
#define gpio_set_value  __gpio_set_value
#define gpio_cansleep   __gpio_cansleep
#define gpio_to_irq     __gpio_to_irq

> +#endif

Regards,
Hartley
