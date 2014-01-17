From: carlo.caione@gmail.com (Carlo Caione)
Date: Fri, 17 Jan 2014 09:54:55 +0100
Subject: [PATCH v3 1/3] ARM: sun7i/sun6i: irqchip: Add irqchip driver for
 NMI controller
In-Reply-To: <20140116123940.GE31779@lukather>
References: <1389453548-10665-1-git-send-email-carlo.caione@gmail.com>
 <1389453548-10665-2-git-send-email-carlo.caione@gmail.com>
 <20140116123940.GE31779@lukather>
Message-ID: <CAOQ7t2ay6UM-YAUSypRzC=_oSY=0L5RhD6FziG96j4aoK6RHsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 1:39 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Carlo,
>
> On Sat, Jan 11, 2014 at 04:19:06PM +0100, Carlo Caione wrote:
>> Allwinner A20/A31 SoCs have special registers to control / (un)mask /
>> acknowledge NMI. This NMI controller is separated and independent from GIC.
>> This patch adds a new irqchip to manage NMI.
>>
>> Signed-off-by: Carlo Caione <carlo.caione@gmail.com>
>> ---
>>  drivers/irqchip/Makefile        |   1 +
>>  drivers/irqchip/irq-sunxi-nmi.c | 228 ++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 229 insertions(+)
>>  create mode 100644 drivers/irqchip/irq-sunxi-nmi.c
>>
>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>> index c60b901..e31d4d6 100644
>> --- a/drivers/irqchip/Makefile
>> +++ b/drivers/irqchip/Makefile
>> @@ -11,6 +11,7 @@ obj-$(CONFIG_METAG_PERFCOUNTER_IRQS)        += irq-metag.o
>>  obj-$(CONFIG_ARCH_MOXART)            += irq-moxart.o
>>  obj-$(CONFIG_ORION_IRQCHIP)          += irq-orion.o
>>  obj-$(CONFIG_ARCH_SUNXI)             += irq-sun4i.o
>> +obj-$(CONFIG_ARCH_SUNXI)             += irq-sunxi-nmi.o
>>  obj-$(CONFIG_ARCH_SPEAR3XX)          += spear-shirq.o
>>  obj-$(CONFIG_ARM_GIC)                        += irq-gic.o
>>  obj-$(CONFIG_ARM_NVIC)                       += irq-nvic.o
>> diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
>> new file mode 100644
>> index 0000000..a2b7373
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-sunxi-nmi.c
>> @@ -0,0 +1,228 @@
>> +/*
>> + * Allwinner A20/A31 SoCs NMI IRQ chip driver.
>> + *
>> + * Carlo Caione <carlo.caione@gmail.com>
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2.  This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +
>> +#include <linux/bitops.h>
>> +#include <linux/device.h>
>> +#include <linux/io.h>
>> +#include <linux/irq.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/irqdomain.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/irqchip/chained_irq.h>
>> +#include "irqchip.h"
>> +
>> +#define SUNXI_NMI_SRC_TYPE_MASK      0x00000003
>> +
>> +enum {
>> +     SUNXI_SRC_TYPE_LEVEL_LOW = 0,
>> +     SUNXI_SRC_TYPE_EDGE_FALLING,
>> +     SUNXI_SRC_TYPE_LEVEL_HIGH,
>> +     SUNXI_SRC_TYPE_EDGE_RISING,
>> +};
>> +
>> +struct sunxi_sc_nmi_reg_offs {
>> +     u32 ctrl;
>> +     u32 pend;
>> +     u32 enable;
>> +};
>> +
>> +static struct sunxi_sc_nmi_reg_offs sun7i_reg_offs = {
>> +     .ctrl   = 0x00,
>> +     .pend   = 0x04,
>> +     .enable = 0x08,
>> +};
>> +
>> +static struct sunxi_sc_nmi_reg_offs sun6i_reg_offs = {
>> +     .ctrl   = 0x00,
>> +     .pend   = 0x04,
>> +     .enable = 0x34,
>> +};
>> +
>> +/*
>> + * Ack level interrupts right before unmask
>> + *
>> + * In case of level-triggered interrupt, IRQ line must be acked before it
>> + * is unmasked or else a double-interrupt is triggered
>> + */
>> +
>> +static void sunxi_sc_nmi_ack_and_unmask(struct irq_data *d)
>> +{
>> +     struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
>> +     struct irq_chip_type *ct = irq_data_get_chip_type(d);
>> +     u32 mask = d->mask;
>> +
>> +     if (irqd_get_trigger_type(d) & IRQ_TYPE_LEVEL_MASK)
>> +             ct->chip.irq_ack(d);
>> +
>> +     irq_gc_lock(gc);
>> +     irq_reg_writel(mask, gc->reg_base + ct->regs.mask);
>> +     irq_gc_unlock(gc);
>> +}
>
> Hmmm, handle_level_irq seems to be doing exactly that already. It
> first masks and acks the interrupts, and then unmask it, so we should
> be fine, don't we?

We don't, or at least handle_level_irq doesn't work for all the cases.
Let's say (i.e. this is the cubieboard2 case) that to the irqchip is
connected to the IRQ line of a PMIC accessed by I2C. In this case we
cannot mask/ack the interrupt on the originating device in the hard
interrupt handler (in which handle_level_irq is) since we need to
access the I2C bus in an non-interrupt context. ACKing the IRQ in
handle_level_irq at this point is pretty much useless since we still
have to ACK the IRQs on the originating device and this will be done
in a IRQ thread started after the hard IRQ handler.
sunxi_sc_nmi_ack_and_unmask is therefore called (by
irq_finalize_oneshot) after the IRQ thread has been executed. After
the IRQ thread has ACKed the IRQs on the originating device we can
finally ACK and unmask again the NMI.

>> +static inline void sunxi_sc_nmi_write(struct irq_chip_generic *gc, u32 off,
>> +                                   u32 val)
>> +{
>> +     irq_reg_writel(val, gc->reg_base + off);
>> +}
>> +
>> +static inline u32 sunxi_sc_nmi_read(struct irq_chip_generic *gc, u32 off)
>> +{
>> +     return irq_reg_readl(gc->reg_base + off);
>> +}
>> +
>> +static void sunxi_sc_nmi_handle_irq(unsigned int irq, struct irq_desc *desc)
>> +{
>> +     struct irq_domain *domain = irq_desc_get_handler_data(desc);
>> +     struct irq_chip *chip = irq_get_chip(irq);
>> +     unsigned int virq = irq_find_mapping(domain, 0);
>> +
>> +     chained_irq_enter(chip, desc);
>> +     generic_handle_irq(virq);
>> +     chained_irq_exit(chip, desc);
>> +}
>> +
>> +static int sunxi_sc_nmi_set_type(struct irq_data *data, unsigned int flow_type)
>> +{
>> +     struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
>> +     struct irq_chip_type *ct = gc->chip_types;
>> +     u32 src_type_reg;
>> +     u32 ctrl_off = ct->regs.type;
>> +     unsigned int src_type;
>> +     unsigned int i;
>> +
>> +     irq_gc_lock(gc);
>> +
>> +     switch (flow_type & IRQF_TRIGGER_MASK) {
>> +     case IRQ_TYPE_EDGE_FALLING:
>> +             src_type = SUNXI_SRC_TYPE_EDGE_FALLING;
>> +             break;
>> +     case IRQ_TYPE_EDGE_RISING:
>> +             src_type = SUNXI_SRC_TYPE_EDGE_RISING;
>> +             break;
>> +     case IRQ_TYPE_LEVEL_HIGH:
>> +             src_type = SUNXI_SRC_TYPE_LEVEL_HIGH;
>> +             break;
>> +     case IRQ_TYPE_NONE:
>> +     case IRQ_TYPE_LEVEL_LOW:
>> +             src_type = SUNXI_SRC_TYPE_LEVEL_LOW;
>> +             break;
>> +     default:
>> +             irq_gc_unlock(gc);
>> +             pr_err("%s: Cannot assign multiple trigger modes to IRQ %d.\n",
>> +                     __func__, data->irq);
>> +             return -EBADR;
>> +     }
>> +
>> +     irqd_set_trigger_type(data, flow_type);
>> +     irq_setup_alt_chip(data, flow_type);
>> +
>> +     for (i = 0; i <= gc->num_ct; i++, ct++)
>> +             if (ct->type & flow_type)
>> +                     ctrl_off = ct->regs.type;
>> +
>> +     src_type_reg = sunxi_sc_nmi_read(gc, ctrl_off);
>> +     src_type_reg &= ~SUNXI_NMI_SRC_TYPE_MASK;
>> +     src_type_reg |= src_type;
>> +     sunxi_sc_nmi_write(gc, ctrl_off, src_type_reg);
>> +
>> +     irq_gc_unlock(gc);
>> +
>> +     return IRQ_SET_MASK_OK;
>> +}
>> +
>> +static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
>> +                                     struct sunxi_sc_nmi_reg_offs *reg_offs)
>> +{
>> +     struct irq_domain *domain;
>> +     struct irq_chip_generic *gc;
>> +     unsigned int irq;
>> +     unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
>> +     int ret;
>> +
>> +
>> +     domain = irq_domain_add_linear(node, 1, &irq_generic_chip_ops, NULL);
>> +     if (!domain) {
>> +             pr_err("%s: Could not register interrupt domain.\n", node->name);
>> +             return -ENOMEM;
>> +     }
>> +
>> +     ret = irq_alloc_domain_generic_chips(domain, 1, 2, node->name,
>> +                                          handle_level_irq, clr, 0,
>> +                                          IRQ_GC_INIT_MASK_CACHE);
>> +     if (ret) {
>> +              pr_err("%s: Could not allocate generic interrupt chip.\n",
>> +                      node->name);
>> +              goto fail_irqd_remove;
>> +     }
>> +
>> +     irq = irq_of_parse_and_map(node, 0);
>> +     if (irq <= 0) {
>> +             pr_err("%s: unable to parse irq\n", node->name);
>> +             ret = -EINVAL;
>> +             goto fail_irqd_remove;
>> +     }
>> +
>> +     gc = irq_get_domain_generic_chip(domain, 0);
>> +     gc->reg_base = of_iomap(node, 0);
>> +     if (!gc->reg_base) {
>> +             pr_err("%s: unable to map resource\n", node->name);
>> +             ret = -ENOMEM;
>> +             goto fail_irqd_remove;
>> +     }
>> +
>> +     gc->chip_types[0].type                  = IRQ_TYPE_LEVEL_MASK;
>> +     gc->chip_types[0].chip.irq_ack          = irq_gc_ack_set_bit;
>> +     gc->chip_types[0].chip.irq_mask         = irq_gc_mask_clr_bit;
>> +     gc->chip_types[0].chip.irq_unmask       = sunxi_sc_nmi_ack_and_unmask;
>> +     gc->chip_types[0].chip.irq_set_type     = sunxi_sc_nmi_set_type;
>> +     gc->chip_types[0].regs.ack              = reg_offs->pend;
>> +     gc->chip_types[0].regs.mask             = reg_offs->enable;
>> +     gc->chip_types[0].regs.type             = reg_offs->ctrl;
>> +
>> +     gc->chip_types[1].type                  = IRQ_TYPE_EDGE_BOTH;
>> +     gc->chip_types[1].chip.name             = gc->chip_types[0].chip.name;
>> +     gc->chip_types[1].chip.irq_ack          = irq_gc_ack_set_bit;
>> +     gc->chip_types[1].chip.irq_mask         = irq_gc_mask_clr_bit;
>> +     gc->chip_types[1].chip.irq_unmask       = sunxi_sc_nmi_ack_and_unmask;
>> +     gc->chip_types[1].chip.irq_set_type     = sunxi_sc_nmi_set_type;
>> +     gc->chip_types[1].regs.ack              = reg_offs->pend;
>> +     gc->chip_types[1].regs.mask             = reg_offs->enable;
>> +     gc->chip_types[1].regs.type             = reg_offs->ctrl;
>> +     gc->chip_types[1].handler               = handle_edge_irq;
>> +
>> +     irq_set_handler_data(irq, domain);
>> +     irq_set_chained_handler(irq, sunxi_sc_nmi_handle_irq);
>> +
>> +     sunxi_sc_nmi_write(gc, reg_offs->enable, 0);
>> +     sunxi_sc_nmi_write(gc, reg_offs->pend, 0x1);
>
> I really wonder whether it makes sense to have a generic chip here. It
> seems to be much more complicated than it should. It's only about a
> single interrupt interrupt chip here.

I agree but is there any other way to manage the NMI without the
driver of the device connected to NMI having to worry about
acking/masking/unmasking/ etc..?

>> +
>> +     return 0;
>> +
>> +fail_irqd_remove:
>> +     irq_domain_remove(domain);
>> +
>> +     return ret;
>> +}
>> +
>> +static int __init sun6i_sc_nmi_irq_init(struct device_node *node,
>> +                                     struct device_node *parent)
>> +{
>> +     return sunxi_sc_nmi_irq_init(node, &sun6i_reg_offs);
>> +}
>> +IRQCHIP_DECLARE(sun6i_sc_nmi, "allwinner,sun6i-sc-nmi", sun6i_sc_nmi_irq_init);
>
> I'm curious, where did you get these infos on the A31? :)

Ehm actually it was in the mail exchange we have had with the
Allwinner engineers :)

>
>> +static int __init sun7i_sc_nmi_irq_init(struct device_node *node,
>> +                                     struct device_node *parent)
>> +{
>> +     return sunxi_sc_nmi_irq_init(node, &sun7i_reg_offs);
>> +}
>> +IRQCHIP_DECLARE(sun7i_sc_nmi, "allwinner,sun7i-sc-nmi", sun7i_sc_nmi_irq_init);
>
> The compatibles should be sun6i-a31-* and sun7i-a20-*.

Fix in v4.

Thanks,

--
Carlo Caione
