From: mcuos.com@gmail.com (Wan ZongShun)
Date: Fri, 20 Nov 2009 17:21:22 +0800
Subject: RFC [PATCH 3/9] Added core lpc32xx architecture files
In-Reply-To: <083DF309106F364B939360100EC290F804F54D560C@eu1rdcrdc1wx030.exi.nxp.com>
References: <Acppfl8B5sxQgWHXQe2vep+y99aVVQ==>
	<083DF309106F364B939360100EC290F804F54D560C@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <e68bb3470911200121j1bc7b5f0qeba51908990c621@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/11/20 Kevin Wells <kevin.wells@nxp.com>:
> Added core lpc32xx architecture files
>
> Signed-off-by: Kevin Wells <kevin.wells@nxp.com>
> ---
> ?arch/arm/mach-lpc32xx/common.c ?| ?284 +++++++++++++++++++++++
> ?arch/arm/mach-lpc32xx/common.h ?| ? 51 ++++
> ?arch/arm/mach-lpc32xx/gpiolib.c | ?483 +++++++++++++++++++++++++++++++++++++++
> ?arch/arm/mach-lpc32xx/irq.c ? ? | ?247 ++++++++++++++++++++
> ?arch/arm/mach-lpc32xx/serial.c ?| ?211 +++++++++++++++++
> ?arch/arm/mach-lpc32xx/timer.c ? | ?194 ++++++++++++++++
> ?6 files changed, 1470 insertions(+), 0 deletions(-)
> ?create mode 100644 arch/arm/mach-lpc32xx/common.c
> ?create mode 100644 arch/arm/mach-lpc32xx/common.h
> ?create mode 100644 arch/arm/mach-lpc32xx/gpiolib.c
> ?create mode 100644 arch/arm/mach-lpc32xx/irq.c
> ?create mode 100644 arch/arm/mach-lpc32xx/serial.c
> ?create mode 100644 arch/arm/mach-lpc32xx/timer.c
>
> diff --git a/arch/arm/mach-lpc32xx/common.c b/arch/arm/mach-lpc32xx/common.c
> new file mode 100644
> index 0000000..f0fb643
> --- /dev/null
> +++ b/arch/arm/mach-lpc32xx/common.c
> @@ -0,0 +1,284 @@
> +/*
> + * ?linux/arch/arm/mach-lpc32xx/common.c
> + *
> + * ?Copyright (C) 2009 NXP Semiconductors
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA ?02111-1307 ?USA
> + */
> +
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/sysdev.h>
> +#include <linux/amba/bus.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/i2c.h>
> +#include <linux/i2c-pnx.h>
> +
> +#include <mach/hardware.h>
> +#include <asm/setup.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/irq.h>
> +#include <asm/mach/irq.h>
> +#include <asm/mach/map.h>
> +#include <mach/platform.h>
> +#include <mach/i2c.h>
> +
> +#include <mach/clock.h>
> +#include <mach/board.h>
> +#include "common.h"
> +
> +/*
> + * Watchdog timer
> + */
> +static struct resource watchdog_resources[] = {
> + ? ? ? [0] = {
> + ? ? ? ? ? ? ? .start = WDTIM_BASE,
> + ? ? ? ? ? ? ? .end = WDTIM_BASE + SZ_4K - 1,
> + ? ? ? ? ? ? ? .flags = IORESOURCE_MEM,
> + ? ? ? },
> +};
> +
> +struct platform_device watchdog_device = {
> + ? ? ? .name = "watchdog",
> + ? ? ? .id = -1,
> + ? ? ? .num_resources = ARRAY_SIZE(watchdog_resources),
> + ? ? ? .resource = watchdog_resources,
> +};
> +
> +/*
> + * I2C busses
> + */
> +static void i2c_clock_get_name(char *name, int id)
> +{
> + ? ? ? snprintf(name, 10, "i2c%d_ck", id);
> +}
> +
> +static int i2c_set_clock_run(struct platform_device *pdev)
> +{
> + ? ? ? struct clk *clk;
> + ? ? ? char name[10];
> + ? ? ? int retval = 0;
> +
> + ? ? ? i2c_clock_get_name(name, pdev->id);
> + ? ? ? clk = clk_get(&pdev->dev, name);
> + ? ? ? if (!IS_ERR(clk)) {
> + ? ? ? ? ? ? ? clk_set_rate(clk, 1);
> + ? ? ? ? ? ? ? clk_put(clk);
> + ? ? ? } else
> + ? ? ? ? ? ? ? retval = -ENOENT;
> +
> + ? ? ? return retval;
> +}
> +
> +static int i2c_set_clock_stop(struct platform_device *pdev)
> +{
> + ? ? ? struct clk *clk;
> + ? ? ? char name[10];
> + ? ? ? int retval = 0;
> +
> + ? ? ? i2c_clock_get_name(name, pdev->id);
> + ? ? ? clk = clk_get(&pdev->dev, name);
> + ? ? ? if (!IS_ERR(clk)) {
> + ? ? ? ? ? ? ? clk_set_rate(clk, 0);
> + ? ? ? ? ? ? ? clk_put(clk);
> + ? ? ? } else
> + ? ? ? ? ? ? ? retval = -ENOENT;
> +
> + ? ? ? return retval;
> +}
> +
> +static int i2c_lpc32xx_suspend(struct platform_device *pdev,
> + ? ? ? pm_message_t state)
> +{
> + ? ? ? int retval = 0;
> +#ifdef CONFIG_PM
> + ? ? ? retval = i2c_set_clock_run(pdev);
> +#endif
> + ? ? ? return retval;
> +}
> +
> +static int i2c_lpc32xx_resume(struct platform_device *pdev)
> +{
> + ? ? ? int retval = 0;
> +#ifdef CONFIG_PM
> + ? ? ? retval = i2c_set_clock_run(pdev);
> +#endif
> + ? ? ? return retval;
> +}
> +
> +static u32 i2c_calculate_input_freq(struct platform_device *pdev)
> +{
> + ? ? ? struct clk *clk;
> + ? ? ? char name[10];
> + ? ? ? u32 clkrate = MAIN_OSC_FREQ;
> +
> + ? ? ? i2c_clock_get_name(name, pdev->id);
> + ? ? ? clk = clk_get(&pdev->dev, name);
> + ? ? ? if (!IS_ERR(clk)) {
> + ? ? ? ? ? ? ? /* Just get the parent rate, as the I2C driver hasn't
> + ? ? ? ? ? ? ? ? ?actually enabled the clock prior to querying it, so
> + ? ? ? ? ? ? ? ? ?it will always return 0! */
> + ? ? ? ? ? ? ? clkrate = clk_get_rate(clk->parent);
> + ? ? ? ? ? ? ? clk_put(clk);
> + ? ? ? }
> +
> + ? ? ? /* Unlike other drivers, the PNX driver requires the rate
> + ? ? ? ? ?in MHz */
> + ? ? ? clkrate ?= clkrate / (1000 * 1000);
> +
> + ? ? ? return clkrate;
> +}
> +
> +static struct i2c_pnx_algo_data lpc32xx_algo_data0 = {
> + ? ? ? .base = I2C1_BASE,
> + ? ? ? .irq = IRQ_I2C_1,
> +};
> +
> +static struct i2c_adapter lpc32xx_adapter0 = {
> + ? ? ? .name = I2C_CHIP_NAME "0",
> + ? ? ? .algo_data = &lpc32xx_algo_data0,
> +};
> +
> +static struct i2c_pnx_data i2c0_data = {
> + ? ? ? .suspend = i2c_lpc32xx_suspend,
> + ? ? ? .resume = i2c_lpc32xx_resume,
> + ? ? ? .calculate_input_freq = i2c_calculate_input_freq,
> + ? ? ? .set_clock_run = i2c_set_clock_run,
> + ? ? ? .set_clock_stop = i2c_set_clock_stop,
> + ? ? ? .adapter = &lpc32xx_adapter0,
> +};
> +
> +struct platform_device i2c0_device = {
> + ? ? ? .name = "pnx-i2c",
> + ? ? ? .id = 0,
> + ? ? ? .dev = {
> + ? ? ? ? ? ? ? .platform_data = &i2c0_data,
> + ? ? ? },
> +};
> +
> +static struct i2c_pnx_algo_data lpc32xx_algo_data1 = {
> + ? ? ? .base = I2C2_BASE,
> + ? ? ? .irq = IRQ_I2C_2,
> +};
> +
> +static struct i2c_adapter lpc32xx_adapter1 = {
> + ? ? ? .name = I2C_CHIP_NAME "1",
> + ? ? ? .algo_data = &lpc32xx_algo_data1,
> +};
> +
> +static struct i2c_pnx_data i2c1_data = {
> + ? ? ? .suspend = i2c_lpc32xx_suspend,
> + ? ? ? .resume = i2c_lpc32xx_resume,
> + ? ? ? .calculate_input_freq = i2c_calculate_input_freq,
> + ? ? ? .set_clock_run = i2c_set_clock_run,
> + ? ? ? .set_clock_stop = i2c_set_clock_stop,
> + ? ? ? .adapter = &lpc32xx_adapter1,
> +};
> +
> +struct platform_device i2c1_device = {
> + ? ? ? .name = "pnx-i2c",
> + ? ? ? .id = 1,
> + ? ? ? .dev = {
> + ? ? ? ? ? ? ? .platform_data = &i2c1_data,
> + ? ? ? },
> +};
> +
> +static struct i2c_pnx_algo_data lpc32xx_algo_data2 = {
> + ? ? ? .base = OTG_I2C_BASE,
> + ? ? ? .irq = IRQ_USB_I2C,
> +};
> +
> +static struct i2c_adapter lpc32xx_adapter2 = {
> + ? ? ? .name = "USB-I2C",
> + ? ? ? .algo_data = &lpc32xx_algo_data2,
> +};
> +
> +static struct i2c_pnx_data i2c2_data = {
> + ? ? ? .suspend = i2c_lpc32xx_suspend,
> + ? ? ? .resume = i2c_lpc32xx_resume,
> + ? ? ? .calculate_input_freq = i2c_calculate_input_freq,
> + ? ? ? .set_clock_run = i2c_set_clock_run,
> + ? ? ? .set_clock_stop = i2c_set_clock_stop,
> + ? ? ? .adapter = &lpc32xx_adapter2,
> +};
> +
> +struct platform_device i2c2_device = {
> + ? ? ? .name = "pnx-i2c",
> + ? ? ? .id = 2,
> + ? ? ? .dev = {
> + ? ? ? ? ? ? ? .platform_data = &i2c2_data,
> + ? ? ? },
> +};
> +
> +/*
> + * Returns the unique ID for the device
> + */
> +void lpc32xx_get_uid(u32 devid[4])
> +{
> + ? ? ? int i;
> +
> + ? ? ? for (i = 0; i < 4; i++)
> + ? ? ? ? ? ? ? devid[i] = readl(CLKPWR_DEVID(CLKPWR_IOBASE, (i << 2)));
> +}
> +
> +static int __init lpc32xx_display_uid(void)
> +{
> + ? ? ? u32 uid[4];
> +
> + ? ? ? lpc32xx_get_uid(uid);
> +
> + ? ? ? printk(KERN_INFO "LPC32XX unique ID: %08x%08x%08x%08x\n",
> + ? ? ? ? ? ? ? uid[3], uid[2], uid[1], uid[0]);
> +
> + ? ? ? return 1;
> +}
> +arch_initcall(lpc32xx_display_uid);
> +
> +static struct map_desc lpc32xx_io_desc[] __initdata = {
> + ? ? ? {
> + ? ? ? ? ? ? ? .virtual ? ? ? ?= io_p2v(AHB0_START),
> + ? ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(AHB0_START),
> + ? ? ? ? ? ? ? .length ? ? ? ? = AHB0_SIZE,
> + ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .virtual ? ? ? ?= io_p2v(AHB1_START),
> + ? ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(AHB1_START),
> + ? ? ? ? ? ? ? .length ? ? ? ? = AHB1_SIZE,
> + ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .virtual ? ? ? ?= io_p2v(FABAPB_START),
> + ? ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(FABAPB_START),
> + ? ? ? ? ? ? ? .length ? ? ? ? = FABAPB_SIZE,
> + ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .virtual ? ? ? ?= io_p2v(IRAM_BASE),
> + ? ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(IRAM_BASE),
> + ? ? ? ? ? ? ? .length ? ? ? ? = (SZ_64K * 4),
> + ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE
> + ? ? ? },
> +};
> +
> +void __init lpc32xx_map_io(void)
> +{
> + ? ? ? iotable_init (lpc32xx_io_desc, ARRAY_SIZE (lpc32xx_io_desc));
> +}
> diff --git a/arch/arm/mach-lpc32xx/common.h b/arch/arm/mach-lpc32xx/common.h
> new file mode 100644
> index 0000000..545b15d
> --- /dev/null
> +++ b/arch/arm/mach-lpc32xx/common.h
> @@ -0,0 +1,51 @@
> +/*
> + * ?linux/arch/arm/mach-lpc32xx/common.h
> + *
> + * ?Copyright (C) 2009 NXP Semiconductors
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA ?02111-1307 ?USA
> + */
> +
> +#ifndef __SYS_LPC32XX_H
> +#define __SYS_PLC32XX_H
> +
> +#include <linux/platform_device.h>
> +#include <linux/sysdev.h>
> +#include <linux/io.h>
> +
> +#include <mach/platform.h>
> +#include <mach/board.h>
> +
> +#define CLKPWR_IOBASE io_p2v(CLK_PM_BASE)
> +
> +/*
> + * Arch specific platform device structures
> + */
> +extern struct platform_device watchdog_device;
> +extern struct platform_device i2c0_device;
> +extern struct platform_device i2c1_device;
> +extern struct platform_device i2c2_device;
> +
> +/*
> + * Other arch specific structures and functions
> + */
> +extern struct sys_timer lpc32xx_timer;
> +extern void __init lpc32xx_init_irq(void);
> +extern void __init serial_init(void);
> +extern void __init lpc32xx_map_io(void);
> +extern int __init clk_init(void);
> +extern void __init lpc32xx_gpio_init(void);
> +
> +#endif
> diff --git a/arch/arm/mach-lpc32xx/gpiolib.c b/arch/arm/mach-lpc32xx/gpiolib.c
> new file mode 100644
> index 0000000..774fbf6
> --- /dev/null
> +++ b/arch/arm/mach-lpc32xx/gpiolib.c
> @@ -0,0 +1,483 @@
> +/*
> + * linux/arch/arm/mach-lpc32xx/gpiolib.c
> + *
> + * Author: Kevin Wells <kevin.wells@nxp.com>
> + *
> + * Copyright (C) 2009 NXP Semiconductors
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA ?02111-1307 ?USA
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/irq.h>
> +#include <linux/module.h>
> +#include <linux/spinlock.h>
> +#include <linux/bitops.h>
> +#include <linux/io.h>
> +#include <linux/gpio.h>
> +
> +#include <mach/platform.h>
> +#include "common.h"
> +
> +#define GPIO_IOBASE io_p2v(GPIO_BASE)
> +
> +static DEFINE_SPINLOCK(gpio_lock);
> +
> +struct gpio_regs {
> + ? ? ? u32 inp_state;
> + ? ? ? u32 outp_set;
> + ? ? ? u32 outp_clr;
> + ? ? ? u32 dir_set;
> + ? ? ? u32 dir_clr;
> + ? ? ? int pgroup;
> +};
> +
> +/*
> + * GPIO names
> + */
> +static char *gpio_p0_names[GPIO_P0_MAX] = {
> + ? ? ? "p0.0", "p0.1", "p0.2", "p0.3",
> + ? ? ? "p0.4", "p0.5", "p0.6", "p0.7"
> +};
> +
> +static char *gpio_p1_names[GPIO_P1_MAX] = {
> + ? ? ? "p1.0", "p1.1", "p1.2", "p1.3",
> + ? ? ? "p1.4", "p1.5", "p1.6", "p1.7",
> + ? ? ? "p1.8", "p1.9", "p1.10", "p1.11",
> + ? ? ? "p1.12", "p1.13", "p1.14", "p1.15",
> + ? ? ? "p1.16", "p1.17", "p1.18", "p1.19",
> + ? ? ? "p1.20", "p1.21", "p1.22", "p1.23",
> +};
> +
> +static char *gpio_p2_names[GPIO_P2_MAX] = {
> + ? ? ? "p2.0", "p2.1", "p2.2", "p2.3",
> + ? ? ? "p2.4", "p2.5", "p2.6", "p2.7",
> + ? ? ? "p2.8", "p2.9", "p2.10", "p2.11",
> + ? ? ? "p2.12"
> +};
> +
> +static char *gpio_p3_names[GPIO_P3_MAX] = {
> + ? ? ? "gpi000", "gpio01", "gpio02", "gpio03",
> + ? ? ? "gpio04", "gpio05"
> +};
> +
> +static char *gpi_p3_names[GPI_P3_MAX] = {
> + ? ? ? "gpi00", "gpi01", "gpi02", "gpi03",
> + ? ? ? "gpi04", "gpi05", "gpi06", "gpi07",
> + ? ? ? "gpi08", "gpi09", ?NULL, ? ?NULL,
> + ? ? ? ?NULL, ? ?NULL, ? ?NULL, ? "gpi15",
> + ? ? ? "gpi16", "gpi17", "gpi18", "gpi19",
> + ? ? ? "gpi20", "gpi21", "gpi22", "gpi23",
> + ? ? ? "gpi24", "gpi25", "gpi26", "gpi27"
> +};
> +
> +static char *gpo_p3_names[GPO_P3_MAX] = {
> + ? ? ? "gpo00", "gpo01", "gpo02", "gpo03",
> + ? ? ? "gpo04", "gpo05", "gpo06", "gpo07",
> + ? ? ? "gpo08", "gpo09", "gpo10", "gpo11",
> + ? ? ? "gpo12", "gpo13", "gpo14", "gpo15",
> + ? ? ? "gpo16", "gpo17", "gpo18", "gpo19",
> + ? ? ? "gpo20", "gpo21", "gpo22", "gpo23"
> +};
> +
> +static struct gpio_regs gpio_grp_regs[] = {
> + ? ? ? {
> + ? ? ? ? ? ? ? .inp_state ? ? ?= GPIO_P0_INP_STATE(GPIO_IOBASE),
> + ? ? ? ? ? ? ? .outp_set ? ? ? = GPIO_P0_OUTP_SET(GPIO_IOBASE),
> + ? ? ? ? ? ? ? .outp_clr ? ? ? = GPIO_P0_OUTP_CLR(GPIO_IOBASE),
> + ? ? ? ? ? ? ? .dir_set ? ? ? ?= GPIO_P0_DIR_SET(GPIO_IOBASE),
> + ? ? ? ? ? ? ? .dir_clr ? ? ? ?= GPIO_P0_DIR_CLR(GPIO_IOBASE),
> + ? ? ? ? ? ? ? .pgroup ? ? ? ? = 0,
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .inp_state ? ? ?= GPIO_P1_INP_STATE(GPIO_IOBASE),
> + ? ? ? ? ? ? ? .outp_set ? ? ? = GPIO_P1_OUTP_SET(GPIO_IOBASE),
> + ? ? ? ? ? ? ? .outp_clr ? ? ? = GPIO_P1_OUTP_CLR(GPIO_IOBASE),
> + ? ? ? ? ? ? ? .dir_set ? ? ? ?= GPIO_P1_DIR_SET(GPIO_IOBASE),
> + ? ? ? ? ? ? ? .dir_clr ? ? ? ?= GPIO_P1_DIR_CLR(GPIO_IOBASE),
> + ? ? ? ? ? ? ? .pgroup ? ? ? ? = 1,
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .inp_state ? ? ?= GPIO_P2_INP_STATE(GPIO_IOBASE),
> + ? ? ? ? ? ? ? .outp_set ? ? ? = GPIO_P2_OUTP_SET(GPIO_IOBASE),
> + ? ? ? ? ? ? ? .outp_clr ? ? ? = GPIO_P2_OUTP_CLR(GPIO_IOBASE),
> + ? ? ? ? ? ? ? .dir_set ? ? ? ?= GPIO_P2_DIR_SET(GPIO_IOBASE),
> + ? ? ? ? ? ? ? .dir_clr ? ? ? ?= GPIO_P2_DIR_CLR(GPIO_IOBASE),
> + ? ? ? ? ? ? ? .pgroup ? ? ? ? = 2,
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .inp_state ? ? ?= GPIO_P3_INP_STATE(GPIO_IOBASE),
> + ? ? ? ? ? ? ? .outp_set ? ? ? = GPIO_P3_OUTP_SET(GPIO_IOBASE),
> + ? ? ? ? ? ? ? .outp_clr ? ? ? = GPIO_P3_OUTP_CLR(GPIO_IOBASE),
> + ? ? ? ? ? ? ? .dir_set ? ? ? ?= GPIO_P2_DIR_SET(GPIO_IOBASE),
> + ? ? ? ? ? ? ? .dir_clr ? ? ? ?= GPIO_P2_DIR_CLR(GPIO_IOBASE),
> + ? ? ? ? ? ? ? .pgroup ? ? ? ? = 3,
> + ? ? ? },
> +};
> +
> +struct lpc32xx_gpio_chip {
> + ? ? ? struct gpio_chip ? ? ? ?chip;
> + ? ? ? struct gpio_regs ? ? ? ?*gpio_grp;
> +};
> +
> +static inline struct lpc32xx_gpio_chip *to_lpc32xx_gpio(
> + ? ? ? struct gpio_chip *gpc)
> +{
> + ? ? ? return container_of(gpc, struct lpc32xx_gpio_chip, chip);
> +}
> +
> +static inline void __set_gpio_dir_p012(struct lpc32xx_gpio_chip *group,
> + ? ? ? unsigned pin, int input)
> +{
> + ? ? ? if (input)
> + ? ? ? ? ? ? ? writel((1 << pin), group->gpio_grp->dir_clr);
> + ? ? ? else
> + ? ? ? ? ? ? ? writel((1 << pin), group->gpio_grp->dir_set);
> +}
> +
> +static inline void __set_gpio_dir_p3(struct lpc32xx_gpio_chip *group,
> + ? ? ? unsigned pin, int input)
> +{
> + ? ? ? u32 u;
> +
> + ? ? ? /* P3 GPIO pins are offset in the register to pin mapping */
> + ? ? ? u = (1 << (pin + 25));
> +
> + ? ? ? if (input)
> + ? ? ? ? ? ? ? writel(u, group->gpio_grp->dir_clr);
> + ? ? ? else
> + ? ? ? ? ? ? ? writel(u, group->gpio_grp->dir_set);
> +}
> +
> +static void __set_gpio_level_p012(struct lpc32xx_gpio_chip *group,
> + ? ? ? unsigned pin, int high)
> +{
> + ? ? ? if (high)
> + ? ? ? ? ? ? ? writel((1 << pin), group->gpio_grp->outp_set);
> + ? ? ? else
> + ? ? ? ? ? ? ? writel((1 << pin), group->gpio_grp->outp_clr);
> +}
> +
> +static void __set_gpio_level_p3(struct lpc32xx_gpio_chip *group,
> + ? ? ? unsigned pin, int high)
> +{
> + ? ? ? u32 u;
> +
> + ? ? ? /* P3 GPIO pins are offset in the register to pin mapping */
> + ? ? ? u = (1 << (pin + 25));
> +
> + ? ? ? if (high)
> + ? ? ? ? ? ? ? writel(u, group->gpio_grp->outp_set);
> + ? ? ? else
> + ? ? ? ? ? ? ? writel(u, group->gpio_grp->outp_clr);
> +}
> +
> +static void __set_gpo_level_p3(struct lpc32xx_gpio_chip *group,
> + ? ? ? unsigned pin, int high)
> +{
> + ? ? ? if (high)
> + ? ? ? ? ? ? ? writel((1 << pin), group->gpio_grp->outp_set);
> + ? ? ? else
> + ? ? ? ? ? ? ? writel((1 << pin), group->gpio_grp->outp_clr);
> +}
> +
> +static int __get_gpio_state_p012(struct lpc32xx_gpio_chip *group,
> + ? ? ? unsigned pin)
> +{
> + ? ? ? int state;
> +
> + ? ? ? state = ?(int) readl(group->gpio_grp->inp_state);
> + ? ? ? state = (state >> pin) & 1;
> +
> + ? ? ? return state;
> +}
> +
> +static int __get_gpio_state_p3(struct lpc32xx_gpio_chip *group,
> + ? ? ? unsigned pin)
> +{
> + ? ? ? int state;
> +
> + ? ? ? state = ?(int) readl(group->gpio_grp->inp_state);
> +
> + ? ? ? /* P3 GPIO pin input mapping is not contiguous */
> + ? ? ? if (pin == 5)
> + ? ? ? ? ? ? ? state = (state >> 24) & 1;
> + ? ? ? else
> + ? ? ? ? ? ? ? state = (state >> (10 + pin)) & 1;
> +
> + ? ? ? return state;
> +}
> +
> +static int __get_gpi_state_p3(struct lpc32xx_gpio_chip *group,
> + ? ? ? unsigned pin)
> +{
> + ? ? ? int state;
> +
> + ? ? ? state = ?(int) readl(group->gpio_grp->inp_state);
> + ? ? ? state = (state >> pin) & 1;
> +
> + ? ? ? return state;
> +}
> +
> +/*
> + * GENERIC_GPIO primitives.
> + */
> +static int lpc32xx_gpio_dir_input(struct gpio_chip *chip,
> + ? ? ? unsigned pin)
> +{
> + ? ? ? unsigned long flags;
> + ? ? ? struct lpc32xx_gpio_chip *group = to_lpc32xx_gpio(chip);
> +
> + ? ? ? if (pin >= chip->ngpio)
> + ? ? ? ? ? ? ? return -EINVAL;
> +
> + ? ? ? spin_lock_irqsave(&gpio_lock, flags);
> +
> + ? ? ? if (group->gpio_grp->pgroup <= 2)
> + ? ? ? ? ? ? ? __set_gpio_dir_p012(group, pin, 1);
> + ? ? ? else
> + ? ? ? ? ? ? ? __set_gpio_dir_p3(group, pin, 1);
> +
> + ? ? ? spin_unlock_irqrestore(&gpio_lock, flags);
> +
> + ? ? ? return 0;
> +}
> +
> +static int lpc32xx_gpio_dir_in_always(struct gpio_chip *chip,
> + ? ? ? unsigned pin)
> +{
> + ? ? ? return 0;
> +}
> +
> +static int lpc32xx_gpio_dir_in_none(struct gpio_chip *chip,
> + ? ? ? unsigned pin)
> +{
> + ? ? ? return -EINVAL;
> +}
> +
> +static int lpc32xx_gpio_get_value(struct gpio_chip *chip, unsigned pin)
> +{
> + ? ? ? int val = 0;
> + ? ? ? struct lpc32xx_gpio_chip *group = to_lpc32xx_gpio(chip);
> +
> + ? ? ? if (pin < chip->ngpio) {
> + ? ? ? ? ? ? ? if (group->gpio_grp->pgroup <= 2)
> + ? ? ? ? ? ? ? ? ? ? ? val = __get_gpio_state_p012(group, pin);
> + ? ? ? ? ? ? ? else
> + ? ? ? ? ? ? ? ? ? ? ? val = __get_gpio_state_p3(group, pin);
> + ? ? ? }
> +
> + ? ? ? return val;
> +}
> +
> +static int lpc32xx_gpio_get_none(struct gpio_chip *chip, unsigned pin)
> +{
> + ? ? ? return 0;
> +}
> +
> +static int lpc32xx_gpi_get_value(struct gpio_chip *chip, unsigned pin)
> +{
> + ? ? ? int val = 0;
> + ? ? ? struct lpc32xx_gpio_chip *group = to_lpc32xx_gpio(chip);
> +
> + ? ? ? if (pin < chip->ngpio)
> + ? ? ? ? ? ? ? val = __get_gpi_state_p3(group, pin);
> +
> + ? ? ? return val;
> +}
> +
> +static int lpc32xx_gpio_dir_output(struct gpio_chip *chip, unsigned pin,
> + ? ? ? int value)
> +{
> + ? ? ? unsigned long flags;
> + ? ? ? struct lpc32xx_gpio_chip *group = to_lpc32xx_gpio(chip);
> +
> + ? ? ? if (pin >= chip->ngpio)
> + ? ? ? ? ? ? ? return -EINVAL;
> +
> + ? ? ? spin_lock_irqsave(&gpio_lock, flags);
> +
> + ? ? ? if (group->gpio_grp->pgroup <= 2) {
> + ? ? ? ? ? ? ? __set_gpio_dir_p012(group, pin, 0);
> + ? ? ? }
> + ? ? ? else {
> + ? ? ? ? ? ? ? __set_gpio_dir_p3(group, pin, 0);
> + ? ? ? }
> +
> + ? ? ? spin_unlock_irqrestore(&gpio_lock, flags);
> +
> + ? ? ? return 0;
> +}
> +
> +static int lpc32xx_gpio_dir_out_none(struct gpio_chip *chip, unsigned pin,
> + ? ? ? int value)
> +{
> + ? ? ? return -EINVAL;
> +}
> +
> +static int lpc32xx_gpio_dir_out_always(struct gpio_chip *chip, unsigned pin,
> + ? ? ? int value)
> +{
> + ? ? ? return 0;
> +}
> +
> +static void lpc32xx_gpio_set_value(struct gpio_chip *chip, unsigned pin,
> + ? ? ? int value)
> +{
> + ? ? ? unsigned long flags;
> + ? ? ? struct lpc32xx_gpio_chip *group = to_lpc32xx_gpio(chip);
> +
> + ? ? ? if (pin < chip->ngpio) {
> + ? ? ? ? ? ? ? spin_lock_irqsave(&gpio_lock, flags);
> +
> + ? ? ? ? ? ? ? if (group->gpio_grp->pgroup <= 2)
> + ? ? ? ? ? ? ? ? ? ? ? __set_gpio_level_p012(group, pin, value);
> + ? ? ? ? ? ? ? else
> + ? ? ? ? ? ? ? ? ? ? ? __set_gpio_level_p3(group, pin, value);
> +
> + ? ? ? ? ? ? ? spin_unlock_irqrestore(&gpio_lock, flags);
> + ? ? ? }
> +}
> +
> +static void lpc32xx_gpo_set_value(struct gpio_chip *chip, unsigned pin,
> + ? ? ? int value)
> +{
> + ? ? ? unsigned long flags;
> + ? ? ? struct lpc32xx_gpio_chip *group = to_lpc32xx_gpio(chip);
> +
> + ? ? ? if (pin < chip->ngpio) {
> + ? ? ? ? ? ? ? spin_lock_irqsave(&gpio_lock, flags);
> +
> + ? ? ? ? ? ? ? __set_gpo_level_p3(group, pin, value);
> +
> + ? ? ? ? ? ? ? spin_unlock_irqrestore(&gpio_lock, flags);
> + ? ? ? }
> +}
> +
> +static void lpc32xx_gpo_set_none(struct gpio_chip *chip, unsigned pin,
> + ? ? ? int value)
> +{
> + ? ? ? /* NULL function for GPI only pins */
> +}
> +
> +static int lpc32xx_gpio_request(struct gpio_chip *chip, unsigned pin)
> +{
> + ? ? ? if (pin < chip->ngpio)
> + ? ? ? ? ? ? ? return 0;
> +
> + ? ? ? return -EINVAL;
> +}
> +
> +static struct lpc32xx_gpio_chip lpc32xx_gpiochip[] = {
> + ? ? ? {
> + ? ? ? ? ? ? ? .chip = {
> + ? ? ? ? ? ? ? ? ? ? ? .label ? ? ? ? ? ? ? ? ?= "gpio_p0",
> + ? ? ? ? ? ? ? ? ? ? ? .direction_input ? ? ? ?= lpc32xx_gpio_dir_input,
> + ? ? ? ? ? ? ? ? ? ? ? .get ? ? ? ? ? ? ? ? ? ?= lpc32xx_gpio_get_value,
> + ? ? ? ? ? ? ? ? ? ? ? .direction_output ? ? ? = lpc32xx_gpio_dir_output,
> + ? ? ? ? ? ? ? ? ? ? ? .set ? ? ? ? ? ? ? ? ? ?= lpc32xx_gpio_set_value,
> + ? ? ? ? ? ? ? ? ? ? ? .request ? ? ? ? ? ? ? ?= lpc32xx_gpio_request,
> + ? ? ? ? ? ? ? ? ? ? ? .base ? ? ? ? ? ? ? ? ? = GPIO_P0_GRP,
> + ? ? ? ? ? ? ? ? ? ? ? .ngpio ? ? ? ? ? ? ? ? ?= GPIO_P0_MAX,
> + ? ? ? ? ? ? ? ? ? ? ? .names ? ? ? ? ? ? ? ? ?= gpio_p0_names,
> + ? ? ? ? ? ? ? ? ? ? ? .can_sleep ? ? ? ? ? ? ?= 0,
> + ? ? ? ? ? ? ? },
> + ? ? ? ? ? ? ? .gpio_grp = &gpio_grp_regs[0],
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .chip = {
> + ? ? ? ? ? ? ? ? ? ? ? .label ? ? ? ? ? ? ? ? ?= "gpio_p1",
> + ? ? ? ? ? ? ? ? ? ? ? .direction_input ? ? ? ?= lpc32xx_gpio_dir_input,
> + ? ? ? ? ? ? ? ? ? ? ? .get ? ? ? ? ? ? ? ? ? ?= lpc32xx_gpio_get_value,
> + ? ? ? ? ? ? ? ? ? ? ? .direction_output ? ? ? = lpc32xx_gpio_dir_output,
> + ? ? ? ? ? ? ? ? ? ? ? .set ? ? ? ? ? ? ? ? ? ?= lpc32xx_gpio_set_value,
> + ? ? ? ? ? ? ? ? ? ? ? .request ? ? ? ? ? ? ? ?= lpc32xx_gpio_request,
> + ? ? ? ? ? ? ? ? ? ? ? .base ? ? ? ? ? ? ? ? ? = GPIO_P1_GRP,
> + ? ? ? ? ? ? ? ? ? ? ? .ngpio ? ? ? ? ? ? ? ? ?= GPIO_P1_MAX,
> + ? ? ? ? ? ? ? ? ? ? ? .names ? ? ? ? ? ? ? ? ?= gpio_p1_names,
> + ? ? ? ? ? ? ? ? ? ? ? .can_sleep ? ? ? ? ? ? ?= 0,
> + ? ? ? ? ? ? ? },
> + ? ? ? ? ? ? ? .gpio_grp = &gpio_grp_regs[1],
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .chip = {
> + ? ? ? ? ? ? ? ? ? ? ? .label ? ? ? ? ? ? ? ? ?= "gpio_p2",
> + ? ? ? ? ? ? ? ? ? ? ? .direction_input ? ? ? ?= lpc32xx_gpio_dir_input,
> + ? ? ? ? ? ? ? ? ? ? ? .get ? ? ? ? ? ? ? ? ? ?= lpc32xx_gpio_get_value,
> + ? ? ? ? ? ? ? ? ? ? ? .direction_output ? ? ? = lpc32xx_gpio_dir_output,
> + ? ? ? ? ? ? ? ? ? ? ? .set ? ? ? ? ? ? ? ? ? ?= lpc32xx_gpio_set_value,
> + ? ? ? ? ? ? ? ? ? ? ? .request ? ? ? ? ? ? ? ?= lpc32xx_gpio_request,
> + ? ? ? ? ? ? ? ? ? ? ? .base ? ? ? ? ? ? ? ? ? = GPIO_P2_GRP,
> + ? ? ? ? ? ? ? ? ? ? ? .ngpio ? ? ? ? ? ? ? ? ?= GPIO_P2_MAX,
> + ? ? ? ? ? ? ? ? ? ? ? .names ? ? ? ? ? ? ? ? ?= gpio_p2_names,
> + ? ? ? ? ? ? ? ? ? ? ? .can_sleep ? ? ? ? ? ? ?= 0,
> + ? ? ? ? ? ? ? },
> + ? ? ? ? ? ? ? .gpio_grp = &gpio_grp_regs[2],
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .chip = {
> + ? ? ? ? ? ? ? ? ? ? ? .label ? ? ? ? ? ? ? ? ?= "gpio_p3",
> + ? ? ? ? ? ? ? ? ? ? ? .direction_input ? ? ? ?= lpc32xx_gpio_dir_input,
> + ? ? ? ? ? ? ? ? ? ? ? .get ? ? ? ? ? ? ? ? ? ?= lpc32xx_gpio_get_value,
> + ? ? ? ? ? ? ? ? ? ? ? .direction_output ? ? ? = lpc32xx_gpio_dir_output,
> + ? ? ? ? ? ? ? ? ? ? ? .set ? ? ? ? ? ? ? ? ? ?= lpc32xx_gpio_set_value,
> + ? ? ? ? ? ? ? ? ? ? ? .request ? ? ? ? ? ? ? ?= lpc32xx_gpio_request,
> + ? ? ? ? ? ? ? ? ? ? ? .base ? ? ? ? ? ? ? ? ? = GPIO_P3_GRP,
> + ? ? ? ? ? ? ? ? ? ? ? .ngpio ? ? ? ? ? ? ? ? ?= GPIO_P3_MAX,
> + ? ? ? ? ? ? ? ? ? ? ? .names ? ? ? ? ? ? ? ? ?= gpio_p3_names,
> + ? ? ? ? ? ? ? ? ? ? ? .can_sleep ? ? ? ? ? ? ?= 0,
> + ? ? ? ? ? ? ? },
> + ? ? ? ? ? ? ? .gpio_grp = &gpio_grp_regs[3],
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .chip = {
> + ? ? ? ? ? ? ? ? ? ? ? .label ? ? ? ? ? ? ? ? ?= "gpi_p3",
> + ? ? ? ? ? ? ? ? ? ? ? .direction_input ? ? ? ?= lpc32xx_gpio_dir_in_always,
> + ? ? ? ? ? ? ? ? ? ? ? .get ? ? ? ? ? ? ? ? ? ?= lpc32xx_gpi_get_value,
> + ? ? ? ? ? ? ? ? ? ? ? .direction_output ? ? ? = lpc32xx_gpio_dir_out_none,
> + ? ? ? ? ? ? ? ? ? ? ? .set ? ? ? ? ? ? ? ? ? ?= lpc32xx_gpo_set_none,
> + ? ? ? ? ? ? ? ? ? ? ? .request ? ? ? ? ? ? ? ?= lpc32xx_gpio_request,
> + ? ? ? ? ? ? ? ? ? ? ? .base ? ? ? ? ? ? ? ? ? = GPI_P3_GRP,
> + ? ? ? ? ? ? ? ? ? ? ? .ngpio ? ? ? ? ? ? ? ? ?= GPI_P3_MAX,
> + ? ? ? ? ? ? ? ? ? ? ? .names ? ? ? ? ? ? ? ? ?= gpi_p3_names,
> + ? ? ? ? ? ? ? ? ? ? ? .can_sleep ? ? ? ? ? ? ?= 0,
> + ? ? ? ? ? ? ? },
> + ? ? ? ? ? ? ? .gpio_grp = &gpio_grp_regs[3],
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .chip = {
> + ? ? ? ? ? ? ? ? ? ? ? .label ? ? ? ? ? ? ? ? ?= "gpo_p3",
> + ? ? ? ? ? ? ? ? ? ? ? .direction_input ? ? ? ?= lpc32xx_gpio_dir_in_none,
> + ? ? ? ? ? ? ? ? ? ? ? .get ? ? ? ? ? ? ? ? ? ?= lpc32xx_gpio_get_none,
> + ? ? ? ? ? ? ? ? ? ? ? .direction_output ? ? ? = lpc32xx_gpio_dir_out_always,
> + ? ? ? ? ? ? ? ? ? ? ? .set ? ? ? ? ? ? ? ? ? ?= lpc32xx_gpo_set_value,
> + ? ? ? ? ? ? ? ? ? ? ? .request ? ? ? ? ? ? ? ?= lpc32xx_gpio_request,
> + ? ? ? ? ? ? ? ? ? ? ? .base ? ? ? ? ? ? ? ? ? = GPO_P3_GRP,
> + ? ? ? ? ? ? ? ? ? ? ? .ngpio ? ? ? ? ? ? ? ? ?= GPO_P3_MAX,
> + ? ? ? ? ? ? ? ? ? ? ? .names ? ? ? ? ? ? ? ? ?= gpo_p3_names,
> + ? ? ? ? ? ? ? ? ? ? ? .can_sleep ? ? ? ? ? ? ?= 0,
> + ? ? ? ? ? ? ? },
> + ? ? ? ? ? ? ? .gpio_grp = &gpio_grp_regs[3],
> + ? ? ? },
> +};
> +
> +void __init lpc32xx_gpio_init(void)
> +{
> + ? ? ? int i;
> +
> + ? ? ? for (i = 0; i < ARRAY_SIZE(lpc32xx_gpiochip); i++)
> + ? ? ? ? ? ? ? gpiochip_add(&lpc32xx_gpiochip[i].chip);
> +}
> diff --git a/arch/arm/mach-lpc32xx/irq.c b/arch/arm/mach-lpc32xx/irq.c
> new file mode 100644
> index 0000000..44772ce
> --- /dev/null
> +++ b/arch/arm/mach-lpc32xx/irq.c
> @@ -0,0 +1,247 @@
> +/*
> + * ?linux/arch/arm/mach-lpc32xx/irq.c
> + *
> + * ?Copyright (C) 2009 NXP Semiconductors
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA ?02111-1307 ?USA
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/mm.h>
> +#include <linux/interrupt.h>
> +#include <linux/list.h>
> +#include <linux/init.h>
> +#include <linux/ioport.h>
> +#include <linux/device.h>
> +#include <linux/irq.h>
> +#include <mach/hardware.h>
> +#include <asm/io.h>
> +#include <asm/setup.h>
> +#include <asm/mach-types.h>
> +#include <asm/pgtable.h>
> +#include <asm/page.h>
> +#include <asm/system.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/irq.h>
> +#include <asm/mach/map.h>
> +#include <mach/irqs.h>
> +#include <mach/platform.h>
> +
> +/*
> + * Default value represeting the Activation polarity of all internal
> + * interrupt sources
> + */
> +#define MIC_APR_DEFAULT ? ? ? ? ? ? ? ?0x3FF0EFE0
> +#define SIC1_APR_DEFAULT ? ? ? 0xFBD27186
> +#define SIC2_APR_DEFAULT ? ? ? 0x801810C0
> +
> +/*
> + * Default value represeting the Activation Type of all internal
> + * interrupt sources. All are level senesitive.
> + */
> +#define MIC_ATR_DEFAULT ? ? ? ? ? ? ? ?0x00000000
> +#define SIC1_ATR_DEFAULT ? ? ? 0x00026000
> +#define SIC2_ATR_DEFAULT ? ? ? 0x00000000
> +
> +static void get_controller(unsigned int irq, unsigned int *base,
> + ? ? ? unsigned int *irqbit)
> +{
> + ? ? ? if (irq < 32) {
> + ? ? ? ? ? ? ? *base = io_p2v(MIC_BASE);
> + ? ? ? ? ? ? ? *irqbit = 1 << irq;
> + ? ? ? }
> + ? ? ? else if (irq < 64) {
> + ? ? ? ? ? ? ? *base = io_p2v(SIC1_BASE);
> + ? ? ? ? ? ? ? *irqbit = 1 << (irq - 32);
> + ? ? ? }
> + ? ? ? else {
> + ? ? ? ? ? ? ? *base = io_p2v(SIC2_BASE);
> + ? ? ? ? ? ? ? *irqbit = 1 << (irq - 64);
> + ? ? ? }
> +}
> +
> +static void lpc32xx_mask_irq(unsigned int irq)
> +{
> + ? ? ? unsigned int reg, ctrl, mask;
> +
> + ? ? ? get_controller(irq, &ctrl, &mask);
> +
> + ? ? ? reg = readl(ctrl + INTC_MASK);
> + ? ? ? reg &= ~mask;
> + ? ? ? writel(reg, (ctrl + INTC_MASK));
> +}
> +
> +static void lpc32xx_unmask_irq(unsigned int irq)
> +{
> + ? ? ? unsigned int reg, ctrl, mask;
> +
> + ? ? ? get_controller(irq, &ctrl, &mask);
> +
> + ? ? ? reg = readl(ctrl + INTC_MASK);
> + ? ? ? reg |= mask;
> + ? ? ? writel(reg, (ctrl + INTC_MASK));
> +}
> +
> +static void lpc32xx_mask_ack_irq(unsigned int irq)
> +{
> + ? ? ? unsigned int ctrl, mask;
> +
> + ? ? ? get_controller(irq, &ctrl, &mask);
> +
> + ? ? ? writel(mask, (ctrl + INTC_RAW_STAT));
> +}
> +
> +static int lpc32xx_set_irq_type(unsigned int irq, unsigned int type)
> +{
> + ? ? ? unsigned int reg, ctrl, mask;
> +
> + ? ? ? get_controller(irq, &ctrl, &mask);
> +
> + ? ? ? switch (type) {
> + ? ? ? case IRQ_TYPE_EDGE_RISING:
> + ? ? ? ? ? ? ? /* Rising edge sensitive */
> + ? ? ? ? ? ? ? reg = readl(ctrl + INTC_POLAR);
> + ? ? ? ? ? ? ? reg |= mask;
> + ? ? ? ? ? ? ? writel(reg, (ctrl + INTC_POLAR));
> + ? ? ? ? ? ? ? reg = readl(ctrl + INTC_ACT_TYPE);
> + ? ? ? ? ? ? ? reg |= mask;
> + ? ? ? ? ? ? ? writel(reg, (ctrl + INTC_ACT_TYPE));
> + ? ? ? ? ? ? ? set_irq_handler(irq, handle_edge_irq);
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case IRQ_TYPE_EDGE_FALLING:
> + ? ? ? ? ? ? ? /* Falling edge sensitive */
> + ? ? ? ? ? ? ? reg = readl(ctrl + INTC_POLAR);
> + ? ? ? ? ? ? ? reg &= ~mask;
> + ? ? ? ? ? ? ? writel(reg, (ctrl + INTC_POLAR));
> + ? ? ? ? ? ? ? reg = readl(ctrl + INTC_ACT_TYPE);
> + ? ? ? ? ? ? ? reg |= mask;
> + ? ? ? ? ? ? ? writel(reg, (ctrl + INTC_ACT_TYPE));
> + ? ? ? ? ? ? ? set_irq_handler(irq, handle_edge_irq);
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case IRQ_TYPE_LEVEL_LOW:
> + ? ? ? ? ? ? ? /* Low level sensitive */
> + ? ? ? ? ? ? ? reg = readl(ctrl + INTC_POLAR);
> + ? ? ? ? ? ? ? reg &= ~mask;
> + ? ? ? ? ? ? ? writel(reg, (ctrl + INTC_POLAR));
> + ? ? ? ? ? ? ? reg = readl(ctrl + INTC_ACT_TYPE);
> + ? ? ? ? ? ? ? reg &= ~mask;
> + ? ? ? ? ? ? ? writel(reg, (ctrl + INTC_ACT_TYPE));
> + ? ? ? ? ? ? ? set_irq_handler(irq, handle_level_irq);
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case IRQ_TYPE_LEVEL_HIGH:
> + ? ? ? ? ? ? ? /* High level sensitive */
> + ? ? ? ? ? ? ? reg = readl(ctrl + INTC_POLAR);
> + ? ? ? ? ? ? ? reg |= mask;
> + ? ? ? ? ? ? ? writel(reg, (ctrl + INTC_POLAR));
> + ? ? ? ? ? ? ? reg = readl(ctrl + INTC_ACT_TYPE);
> + ? ? ? ? ? ? ? reg &= ~mask;
> + ? ? ? ? ? ? ? writel(reg, (ctrl + INTC_ACT_TYPE));
> + ? ? ? ? ? ? ? set_irq_handler(irq, handle_level_irq);
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? /* IRQT_BOTHEDGE is not supported */
> + ? ? ? default:
> + ? ? ? ? ? ? ? return -1;

Please use a proper error code, as Russell said , Never, ever, use a
literal "-1" as
an error indicator in the kernel.

> + ? ? ? }
> + ? ? ? return 0;
> +}
> +
> +static void __init lpc32xx_set_default_mappings(unsigned int base,
> + ? ? ? unsigned int apr, unsigned int atr, unsigned int offset)
> +{
> + ? ? ? unsigned int i, lvl, type;
> +
> + ? ? ? /* Set activation levels for each interrupt */
> + ? ? ? i = 0;
> + ? ? ? while (i < 32) ?{
> + ? ? ? ? ? ? ? lvl = ((apr >> i) & 0x1) | (((atr >> i) & 0x1) << 1);
> + ? ? ? ? ? ? ? switch (lvl) {
> + ? ? ? ? ? ? ? case 0x0: /* Low polarity and level operation */
> + ? ? ? ? ? ? ? ? ? ? ? type = IRQ_TYPE_LEVEL_LOW;
> + ? ? ? ? ? ? ? ? ? ? ? break;
> +
> + ? ? ? ? ? ? ? case 0x1: /* High polarity and level operation */
> + ? ? ? ? ? ? ? ? ? ? ? type = IRQ_TYPE_LEVEL_HIGH;
> + ? ? ? ? ? ? ? ? ? ? ? break;
> +
> + ? ? ? ? ? ? ? case 0x2: /* Low polarity and edge operation */
> + ? ? ? ? ? ? ? ? ? ? ? type = IRQ_TYPE_EDGE_FALLING;
> + ? ? ? ? ? ? ? ? ? ? ? break;
> +
> + ? ? ? ? ? ? ? case 0x3: /* High polarity and edge operation */
> + ? ? ? ? ? ? ? default:
> + ? ? ? ? ? ? ? ? ? ? ? type = IRQ_TYPE_EDGE_RISING;
> + ? ? ? ? ? ? ? ? ? ? ? break;
> + ? ? ? ? ? ? ? }
> +
> + ? ? ? ? ? ? ? lpc32xx_set_irq_type((offset + i), type);
> + ? ? ? ? ? ? ? i++;
> + ? ? ? }
> +}
> +
> +static struct irq_chip lpc32xx_irq_chip = {
> + ? ? ? .ack = lpc32xx_mask_ack_irq,
> + ? ? ? .mask = lpc32xx_mask_irq,
> + ? ? ? .unmask = lpc32xx_unmask_irq,
> + ? ? ? .set_type = lpc32xx_set_irq_type,
> +};
> +
> +void __init lpc32xx_init_irq(void)
> +{
> + ? ? ? unsigned int i, vloc;
> +
> + ? ? ? /* Setup MIC */
> + ? ? ? vloc = io_p2v(MIC_BASE);
> + ? ? ? writel(0, (vloc + INTC_MASK));
> + ? ? ? writel(MIC_APR_DEFAULT, (vloc + INTC_POLAR));
> + ? ? ? writel(MIC_ATR_DEFAULT, (vloc + INTC_ACT_TYPE));
> +
> + ? ? ? /* Setup SIC1 */
> + ? ? ? vloc = io_p2v(SIC1_BASE);
> + ? ? ? writel(0, (vloc + INTC_MASK));
> + ? ? ? writel(SIC1_APR_DEFAULT, (vloc + INTC_POLAR));
> + ? ? ? writel(SIC1_ATR_DEFAULT, (vloc + INTC_ACT_TYPE));
> +
> + ? ? ? /* Setup SIC2 */
> + ? ? ? vloc = io_p2v(SIC2_BASE);
> + ? ? ? writel(0, (vloc + INTC_MASK));
> + ? ? ? writel(SIC2_APR_DEFAULT, (vloc + INTC_POLAR));
> + ? ? ? writel(SIC2_ATR_DEFAULT, (vloc + INTC_ACT_TYPE));
> +
> + ? ? ? /* Configure supported IRQ's */
> + ? ? ? for (i = 0; i < NR_IRQS; i++) {
> + ? ? ? ? ? ? ? set_irq_flags(i, IRQF_VALID);
> + ? ? ? ? ? ? ? set_irq_chip(i, &lpc32xx_irq_chip);
> + ? ? ? }
> +
> + ? ? ? /* Set default mappings */
> + ? ? ? lpc32xx_set_default_mappings(io_p2v(MIC_BASE), MIC_APR_DEFAULT,
> + ? ? ? ? ? ? ? MIC_ATR_DEFAULT, 0);
> + ? ? ? lpc32xx_set_default_mappings(io_p2v(SIC1_BASE), SIC1_APR_DEFAULT,
> + ? ? ? ? ? ? ? SIC1_ATR_DEFAULT, INTC_SIC1_OFFS);
> + ? ? ? lpc32xx_set_default_mappings(io_p2v(SIC2_BASE), SIC2_APR_DEFAULT,
> + ? ? ? ? ? ? ? SIC2_ATR_DEFAULT, INTC_SIC2_OFFS);
> +
> + ? ? ? /* mask all interrupts except SUBIRQA and SUBFIQ */
> + ? ? ? writel((1 << IRQ_SUB1IRQ) | (1 << IRQ_SUB2IRQ) |
> + ? ? ? ? ? ? ? ? ? ? ? (1 << IRQ_SUB1FIQ) | (1 << IRQ_SUB2FIQ),
> + ? ? ? ? ? ? ? (io_p2v(MIC_BASE) + INTC_MASK));
> + ? ? ? writel(0, (io_p2v(SIC1_BASE) + INTC_MASK));
> + ? ? ? writel(0, (io_p2v(SIC2_BASE) + INTC_MASK));
> +}
> diff --git a/arch/arm/mach-lpc32xx/serial.c b/arch/arm/mach-lpc32xx/serial.c
> new file mode 100644
> index 0000000..e2bfe49
> --- /dev/null
> +++ b/arch/arm/mach-lpc32xx/serial.c
> @@ -0,0 +1,211 @@
> +/*
> + * ?linux/arch/arm/mach-lpc32xx/serial.c
> + *
> + * ?Copyright (C) 2009 NXP Semiconductors
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA ?02111-1307 ?USA
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/serial.h>
> +#include <linux/serial_core.h>
> +#include <linux/serial_reg.h>
> +#include <linux/serial_8250.h>
> +#include <linux/clk.h>
> +
> +#include <mach/platform.h>
> +#include <mach/io.h>
> +#include "common.h"
> +
> +#define UARTCTL_CLKMODE(x) ? ? (x + 0x04)
> +
> +/* Standard 8250/16550 compatible serial ports */
> +static struct plat_serial8250_port serial_std_platform_data[] = {
> +#if defined (CONFIG_MACH_LPC32XX_UART5_ENABLE)
> + ? ? ? {
> + ? ? ? ? ? ? ? .membase ? ? ? ?= (void *) io_p2v(UART5_BASE),
> + ? ? ? ? ? ? ? .mapbase ? ? ? ?= UART5_BASE,
> + ? ? ? ? ? ? ? .irq ? ? ? ? ? ?= IRQ_UART_IIR5,
> + ? ? ? ? ? ? ? .uartclk ? ? ? ?= MAIN_OSC_FREQ,
> + ? ? ? ? ? ? ? .regshift ? ? ? = 2,
> + ? ? ? ? ? ? ? .iotype ? ? ? ? = UPIO_MEM32,
> + ? ? ? ? ? ? ? .flags ? ? ? ? ?= UPF_BOOT_AUTOCONF | UPF_BUGGY_UART |
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? UPF_SKIP_TEST,
> + ? ? ? },
> +#endif
> +#if defined (CONFIG_MACH_LPC32XX_UART3_ENABLE)
> + ? ? ? {
> + ? ? ? ? ? ? ? .membase ? ? ? ?= (void *) io_p2v(UART3_BASE),
> + ? ? ? ? ? ? ? .mapbase ? ? ? ?= UART3_BASE,
> + ? ? ? ? ? ? ? .irq ? ? ? ? ? ?= IRQ_UART_IIR3,
> + ? ? ? ? ? ? ? .uartclk ? ? ? ?= MAIN_OSC_FREQ,
> + ? ? ? ? ? ? ? .regshift ? ? ? = 2,
> + ? ? ? ? ? ? ? .iotype ? ? ? ? = UPIO_MEM32,
> + ? ? ? ? ? ? ? .flags ? ? ? ? ?= UPF_BOOT_AUTOCONF | UPF_BUGGY_UART |
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? UPF_SKIP_TEST,
> + ? ? ? },
> +#endif
> +#if defined (CONFIG_MACH_LPC32XX_UART4_ENABLE)
> + ? ? ? {
> + ? ? ? ? ? ? ? .membase ? ? ? ?= (void *) io_p2v(UART4_BASE),
> + ? ? ? ? ? ? ? .mapbase ? ? ? ?= UART4_BASE,
> + ? ? ? ? ? ? ? .irq ? ? ? ? ? ?= IRQ_UART_IIR4,
> + ? ? ? ? ? ? ? .uartclk ? ? ? ?= MAIN_OSC_FREQ,
> + ? ? ? ? ? ? ? .regshift ? ? ? = 2,
> + ? ? ? ? ? ? ? .iotype ? ? ? ? = UPIO_MEM32,
> + ? ? ? ? ? ? ? .flags ? ? ? ? ?= UPF_BOOT_AUTOCONF | UPF_BUGGY_UART |
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? UPF_SKIP_TEST,
> + ? ? ? },
> +#endif
> +#if defined (CONFIG_MACH_LPC32XX_UART6_ENABLE)
> + ? ? ? {
> + ? ? ? ? ? ? ? .membase ? ? ? ?= (void *) io_p2v(UART6_BASE),
> + ? ? ? ? ? ? ? .mapbase ? ? ? ?= UART6_BASE,
> + ? ? ? ? ? ? ? .irq ? ? ? ? ? ?= IRQ_UART_IIR6,
> + ? ? ? ? ? ? ? .uartclk ? ? ? ?= MAIN_OSC_FREQ,
> + ? ? ? ? ? ? ? .regshift ? ? ? = 2,
> + ? ? ? ? ? ? ? .iotype ? ? ? ? = UPIO_MEM32,
> + ? ? ? ? ? ? ? .flags ? ? ? ? ?= UPF_BOOT_AUTOCONF | UPF_BUGGY_UART |
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? UPF_SKIP_TEST,
> + ? ? ? },
> +#endif
> + ? ? ? { },
> +};
> +
> +static struct platform_device serial_std_platform_device = {
> + ? ? ? .name ? ? ? ? ? ? ? ? ? = "serial8250",
> + ? ? ? .id ? ? ? ? ? ? ? ? ? ? = 0,
> + ? ? ? .dev ? ? ? ? ? ? ? ? ? ?= {
> + ? ? ? ? ? ? ? .platform_data ?= serial_std_platform_data,
> + ? ? ? },
> +};
> +
> +static struct platform_device* lpc32xx_serial_devs[] = {
> + ? ? ? &serial_std_platform_device,
> +};
> +
> +void __init serial_init(void)
> +{
> + ? ? ? u32 tmp, rate;
> + ? ? ? struct clk *clk;
> + ? ? ? int i;
> +
> + ? ? ? /* Get the current peripheral clock - if the clock can't be fetched,
> + ? ? ? ? ?use the main oscillator as the base clock. */
> + ? ? ? clk = clk_get(NULL, "pclk_ck");
> + ? ? ? if (IS_ERR(clk))
> + ? ? ? ? ? ? ? rate = MAIN_OSC_FREQ;
> + ? ? ? else
> + ? ? ? {
> + ? ? ? ? ? ? ? rate = clk_get_rate(clk);
> + ? ? ? ? ? ? ? clk_put(clk);
> + ? ? ? }
> + ? ? ? if (rate == 0)
> + ? ? ? ? ? ? ? rate = MAIN_OSC_FREQ;
> +
> + ? ? ? /* Update rate for the UARTs */
> + ? ? ? for (i = 0; i < ARRAY_SIZE(serial_std_platform_data); i++)
> + ? ? ? ? ? ? ? serial_std_platform_data[i].uartclk = rate;
> +
> + ? ? ? /* All pre-UART block dividers set to 1 */
> + ? ? ? writel(0x0101, CLKPWR_UART3_CLK_CTRL(CLKPWR_IOBASE));
> + ? ? ? writel(0x0101, CLKPWR_UART4_CLK_CTRL(CLKPWR_IOBASE));
> + ? ? ? writel(0x0101, CLKPWR_UART5_CLK_CTRL(CLKPWR_IOBASE));
> + ? ? ? writel(0x0101, CLKPWR_UART6_CLK_CTRL(CLKPWR_IOBASE));
> +
> + ? ? ? /* Enable UART clocking in clock and power control */
> + ? ? ? tmp = 0;
> +#if defined (CONFIG_MACH_LPC32XX_UART3_ENABLE) || defined (CONFIG_DEBUGO_U3)
> + ? ? ? tmp |= CLKPWR_UARTCLKCTRL_UART3_EN;
> +#endif
> +#if defined (CONFIG_MACH_LPC32XX_UART4_ENABLE) || defined (CONFIG_DEBUGO_U4)
> + ? ? ? tmp |= CLKPWR_UARTCLKCTRL_UART4_EN;
> +#endif
> +#if defined (CONFIG_MACH_LPC32XX_UART5_ENABLE) || defined (CONFIG_DEBUGO_U5)
> + ? ? ? tmp |= CLKPWR_UARTCLKCTRL_UART5_EN;
> +#endif
> +#if defined (CONFIG_MACH_LPC32XX_UART6_ENABLE) || defined (CONFIG_DEBUGO_U6)
> + ? ? ? tmp |= CLKPWR_UARTCLKCTRL_UART6_EN;
> +#endif
> + ? ? ? writel(tmp, CLKPWR_UART_CLK_CTRL(CLKPWR_IOBASE));
> +
> + ? ? ? /* Setup UART clock modes, disable autoclock */
> + ? ? ? tmp = 0;
> +#if defined (CONFIG_MACH_LPC32XX_UART3_ENABLE) || defined (CONFIG_DEBUGO_U3)
> + ? ? ? tmp |= UART_CLKMODE_LOAD(UART_CLKMODE_ON, 3);
> +#endif
> +#if defined (CONFIG_MACH_LPC32XX_UART4_ENABLE) || defined (CONFIG_DEBUGO_U4)
> + ? ? ? tmp |= UART_CLKMODE_LOAD(UART_CLKMODE_ON, 4);
> +#endif
> +#if defined (CONFIG_MACH_LPC32XX_UART5_ENABLE) || defined (CONFIG_DEBUGO_U5)
> + ? ? ? tmp |= UART_CLKMODE_LOAD(UART_CLKMODE_ON, 5);
> +#endif
> +#if defined (CONFIG_MACH_LPC32XX_UART6_ENABLE) || defined (CONFIG_DEBUGO_U6)
> + ? ? ? tmp |= UART_CLKMODE_LOAD(UART_CLKMODE_ON, 6);
> +#endif
> +
> + ? ? ? /* Enable UART clocks, disable autoclock */
> + ? ? ? writel(tmp, UARTCTL_CLKMODE(io_p2v(UART_CTRL_BASE)));
> +
> + ? ? ? /* Force a flush of the RX FIFOs to work around a HW bug */
> +#if defined (CONFIG_MACH_LPC32XX_UART3_ENABLE) || defined (CONFIG_DEBUGO_U3)
> + ? ? ? writel(0xC1, UART_IIR_FCR(io_p2v(UART3_BASE)));
> + ? ? ? writel(0x00, UART_DLL_FIFO(io_p2v(UART3_BASE)));
> + ? ? ? rate = 64;
> + ? ? ? while (rate--)
> + ? ? ? ? ? ? ? tmp = readl(UART_DLL_FIFO(io_p2v(UART3_BASE)));
> + ? ? ? writel(0, UART_IIR_FCR(io_p2v(UART3_BASE)));
> +#endif
> +
> +#if defined (CONFIG_MACH_LPC32XX_UART4_ENABLE) || defined (CONFIG_DEBUGO_U4)
> + ? ? ? writel(0xC1, UART_IIR_FCR(io_p2v(UART4_BASE)));
> + ? ? ? writel(0x00, UART_DLL_FIFO(io_p2v(UART4_BASE)));
> + ? ? ? rate = 64;
> + ? ? ? while (rate--)
> + ? ? ? ? ? ? ? tmp = readl(UART_DLL_FIFO(io_p2v(UART4_BASE)));
> + ? ? ? writel(0, UART_IIR_FCR(io_p2v(UART4_BASE)));
> +#endif
> +
> +#if defined (CONFIG_MACH_LPC32XX_UART5_ENABLE) || defined (CONFIG_DEBUGO_U5)
> + ? ? ? writel(0xC1, UART_IIR_FCR(io_p2v(UART5_BASE)));
> + ? ? ? writel(0x00, UART_DLL_FIFO(io_p2v(UART5_BASE)));
> + ? ? ? rate = 64;
> + ? ? ? while (rate--)
> + ? ? ? ? ? ? ? tmp = readl(UART_DLL_FIFO(io_p2v(UART5_BASE)));
> + ? ? ? writel(0, UART_IIR_FCR(io_p2v(UART5_BASE)));
> +#endif
> +
> +#if defined (CONFIG_MACH_LPC32XX_UART6_ENABLE) || defined (CONFIG_DEBUGO_U6)
> + ? ? ? writel(0xC1, UART_IIR_FCR(io_p2v(UART6_BASE)));
> + ? ? ? writel(0x00, UART_DLL_FIFO(io_p2v(UART6_BASE)));
> + ? ? ? rate = 64;
> + ? ? ? while (rate--)
> + ? ? ? ? ? ? ? tmp = readl(UART_DLL_FIFO(io_p2v(UART6_BASE)));
> + ? ? ? writel(0, UART_IIR_FCR(io_p2v(UART6_BASE)));
> +#endif
> +
> + ? ? ? tmp = readl(UARTCTL_CTRL(io_p2v(UART_CTRL_BASE)));
> +#if defined(MACH_LPC32XX_UART6_IRDAMODE)
> + ? ? ? tmp &= ~UART_UART6_IRDAMOD_BYPASS;
> +#else
> + ? ? ? tmp |= UART_UART6_IRDAMOD_BYPASS;
> +#endif
> + ? ? ? writel(tmp, UARTCTL_CTRL(io_p2v(UART_CTRL_BASE)));
> +
> + ? ? ? platform_add_devices(lpc32xx_serial_devs,
> + ? ? ? ? ? ? ? ARRAY_SIZE(lpc32xx_serial_devs));
> +}
> +
> diff --git a/arch/arm/mach-lpc32xx/timer.c b/arch/arm/mach-lpc32xx/timer.c
> new file mode 100644
> index 0000000..0f434b0
> --- /dev/null
> +++ b/arch/arm/mach-lpc32xx/timer.c
> @@ -0,0 +1,194 @@
> +/*
> + * ?linux/arch/arm/mach-lpc32xx/timer.c
> + *
> + * ?Copyright (C) 2009 NXP Semiconductors
> + * ?Copyright (C) 2009 Fontys University of Applied Sciences, Eindhoven
> + * ? ? ? ? ? ? ? ? ? ? Ed Schouten <e.schouten@fontys.nl>
> + * ? ? ? ? ? ? ? ? ? ? Laurens Timmermans <l.timmermans@fontys.nl>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA ?02111-1307 ?USA
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/time.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/clockchips.h>
> +#include <linux/clocksource.h>
> +
> +#include <mach/hardware.h>
> +#include <asm/io.h>
> +#include <asm/irq.h>
> +
> +#include <asm/mach/time.h>
> +
> +#include <mach/platform.h>
> +#include <mach/clock.h>
> +#include "common.h"
> +
> +#define TIMER0_IOBASE io_p2v(TIMER0_BASE)
> +#define TIMER1_IOBASE io_p2v(TIMER1_BASE)
> +
> +extern int clk_is_sysclk_mainosc(void);
> +extern u32 local_clk_get_pllrate_from_reg(u32 inputclk, u32 regval);
> +extern u32 clk_get_pclk_div(void);
> +
> +static struct clock_event_device lpc32xx_clkevt;
> +
> +static cycle_t lpc32xx_clksrc_read(struct clocksource *cs)
> +{
> + ? ? ? return (cycle_t)readl(TIMER_TC(TIMER1_IOBASE));
> +}
> +
> +static struct clocksource lpc32xx_clksrc = {
> + ? ? ? .name ? = "lpc32xx_clksrc",
> + ? ? ? .shift ?= 24,
> + ? ? ? .rating = 300,
> + ? ? ? .read ? = lpc32xx_clksrc_read,
> + ? ? ? .mask ? = CLOCKSOURCE_MASK(32),
> + ? ? ? .flags ?= CLOCK_SOURCE_IS_CONTINUOUS,
> +};
> +
> +static int lpc32xx_clkevt_next_event(unsigned long delta,
> + ? ?struct clock_event_device *dev)
> +{
> + ? ? ? unsigned long flags;
> +
> + ? ? ? if (delta < 1)
> + ? ? ? ? ? ? ? return -ETIME;
> +
> + ? ? ? local_irq_save(flags);
> +
> + ? ? ? writel(TIMER_CNTR_TCR_RESET, TIMER_TCR(TIMER0_IOBASE));
> + ? ? ? writel(delta, TIMER_PR(TIMER0_IOBASE));
> + ? ? ? writel(TIMER_CNTR_TCR_EN, TIMER_TCR(TIMER0_IOBASE));
> +
> + ? ? ? local_irq_restore(flags);
> +
> + ? ? ? return 0;
> +}
> +
> +static void lpc32xx_clkevt_mode(enum clock_event_mode mode,
> + ? ?struct clock_event_device *dev)
> +{
> + ? ? ? switch (mode) {
> + ? ? ? case CLOCK_EVT_MODE_PERIODIC:
> + ? ? ? ? ? ? ? WARN_ON(1);
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case CLOCK_EVT_MODE_ONESHOT:
> + ? ? ? case CLOCK_EVT_MODE_SHUTDOWN:
> + ? ? ? ? ? ? ? /*
> + ? ? ? ? ? ? ? ?* Disable the timer. When using oneshot, we must also
> + ? ? ? ? ? ? ? ?* disable the timer to wait for the first call to
> + ? ? ? ? ? ? ? ?* set_next_event().
> + ? ? ? ? ? ? ? ?*/
> + ? ? ? ? ? ? ? writel(0, TIMER_TCR(TIMER0_IOBASE));
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case CLOCK_EVT_MODE_UNUSED:
> + ? ? ? case CLOCK_EVT_MODE_RESUME:
> + ? ? ? ? ? ? ? break;
> + ? ? ? }
> +}
> +
> +static struct clock_event_device lpc32xx_clkevt = {
> + ? ? ? .name ? ? ? ? ? = "lpc32xx_clkevt",
> + ? ? ? .features ? ? ? = CLOCK_EVT_FEAT_ONESHOT,
> + ? ? ? .shift ? ? ? ? ?= 32,
> + ? ? ? .rating ? ? ? ? = 300,
> + ? ? ? .set_next_event = lpc32xx_clkevt_next_event,
> + ? ? ? .set_mode ? ? ? = lpc32xx_clkevt_mode,
> +};
> +
> +static irqreturn_t lpc32xx_timer_interrupt(int irq, void *dev_id)
> +{
> + ? ? ? struct clock_event_device *evt = &lpc32xx_clkevt;
> +
> + ? ? ? /* Clear match */
> + ? ? ? writel(TIMER_CNTR_MTCH_BIT(0), TIMER_IR(TIMER0_IOBASE));
> +
> + ? ? ? evt->event_handler(evt);
> +
> + ? ? ? return IRQ_HANDLED;
> +}
> +
> +static struct irqaction lpc32xx_timer_irq = {
> + ? ? ? .name ? ? ? ? ? = "LPC32XX Timer Tick",
> + ? ? ? .flags ? ? ? ? ?= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
> + ? ? ? .handler ? ? ? ?= lpc32xx_timer_interrupt,
> +};
> +
> +static void __init lpc32xx_timer_init (void)
> +{
> + ? ? ? u32 clkrate, pllreg;
> +
> + ? ? ? /* Enable timer clock */
> + ? ? ? writel(
> + ? ? ? ? ? ? ? (CLKPWR_TMRPWMCLK_TIMER0_EN | CLKPWR_TMRPWMCLK_TIMER1_EN),
> + ? ? ? ? ? ? ? CLKPWR_TIMERS_PWMS_CLK_CTRL_1(CLKPWR_IOBASE));
> +
> + ? ? ? /* The clock driver isn't initialized at this point. So determine if
> + ? ? ? ? ?the SYSCLK is driven from the PLL397 or main oscillator and then use
> + ? ? ? ? ?it to compute the PLL frequency and the PCLK divider to get the base
> + ? ? ? ? ?timer 0 rate */
> + ? ? ? if (clk_is_sysclk_mainosc() != 0)
> + ? ? ? ? ? ? ? clkrate = MAIN_OSC_FREQ;
> + ? ? ? else
> + ? ? ? ? ? ? ? clkrate = 397 * CLOCK_OSC_FREQ;
> +
> + ? ? ? /* Get ARM HCLKPLL register and convert it into a frequency*/
> + ? ? ? pllreg = readl(CLKPWR_HCLKPLL_CTRL(CLKPWR_IOBASE)) & 0x1FFFF;
> + ? ? ? clkrate = local_clk_get_pllrate_from_reg(clkrate, pllreg);
> +
> + ? ? ? /* Get PCLK divider and divide ARM PLL clock by it to get timer rate */
> + ? ? ? clkrate = clkrate / clk_get_pclk_div();
> +
> + ? ? ? /* Initial timer setup */
> + ? ? ? writel(0, TIMER_TCR(TIMER0_IOBASE));
> + ? ? ? writel(TIMER_CNTR_MTCH_BIT(0), TIMER_IR(TIMER0_IOBASE));
> + ? ? ? writel(1, TIMER_MR0(TIMER0_IOBASE));
> + ? ? ? writel(TIMER_CNTR_MCR_MTCH(0) | TIMER_CNTR_MCR_STOP(0) |
> + ? ? ? ? ? TIMER_CNTR_MCR_RESET(0), TIMER_MCR(TIMER0_IOBASE));
> +
> + ? ? ? /* Setup tick interrupt */
> + ? ? ? setup_irq (IRQ_TIMER0, &lpc32xx_timer_irq);
> +
> + ? ? ? /* Setup the clockevent structure. */
> + ? ? ? lpc32xx_clkevt.mult = div_sc(clkrate, NSEC_PER_SEC,
> + ? ? ? ? ? ? ? lpc32xx_clkevt.shift);
> + ? ? ? lpc32xx_clkevt.max_delta_ns = clockevent_delta2ns(-1,
> + ? ? ? ? ? ? ? &lpc32xx_clkevt);
> + ? ? ? lpc32xx_clkevt.min_delta_ns = clockevent_delta2ns(1, &lpc32xx_clkevt);
> + ? ? ? lpc32xx_clkevt.cpumask = cpumask_of(0);
> + ? ? ? clockevents_register_device(&lpc32xx_clkevt);
> +
> + ? ? ? /* Use timer1 as clock source. */
> + ? ? ? writel(TIMER_CNTR_TCR_RESET, TIMER_TCR(TIMER1_IOBASE));
> + ? ? ? writel(0, TIMER_PR(TIMER1_IOBASE));
> + ? ? ? writel(0, TIMER_MCR(TIMER1_IOBASE));
> + ? ? ? writel(TIMER_CNTR_TCR_EN, TIMER_TCR(TIMER1_IOBASE));
> + ? ? ? lpc32xx_clksrc.mult = clocksource_hz2mult(clkrate,
> + ? ? ? ? ? ? ? lpc32xx_clksrc.shift);
> + ? ? ? clocksource_register(&lpc32xx_clksrc);
> +}
> +
> +struct sys_timer lpc32xx_timer = {
> + ? ? ? .init ? ? ? ? ? = &lpc32xx_timer_init,
> +};
> +
> --
> 1.6.0.6
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
