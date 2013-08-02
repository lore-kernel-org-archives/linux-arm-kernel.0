From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 2 Aug 2013 11:57:54 +0100
Subject: [PATCH 07/10] ARM: clps711x: Add CLPS711X irqchip driver
In-Reply-To: <1374172501-26796-8-git-send-email-shc_work@mail.ru>
References: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
 <1374172501-26796-8-git-send-email-shc_work@mail.ru>
Message-ID: <20130802105754.GF2884@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 07:34:58PM +0100, Alexander Shiyan wrote:
> This adds the irqchip driver for Cirrus Logic CLPS711X series SoCs.
> Designed primarily for migration CLPS711X subarch for multiplatform & DT,
> for this as the "OF" and "not-OF" calls implemented.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  .../interrupt-controller/cirrus,clps711x-intc.txt  |  42 ++++
>  arch/arm/Kconfig                                   |   2 -
>  drivers/irqchip/Kconfig                            |   6 +
>  drivers/irqchip/Makefile                           |   1 +
>  drivers/irqchip/irq-clps711x.c                     | 277 +++++++++++++++++++++
>  5 files changed, 326 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/cirrus,clps711x-intc.txt
>  create mode 100644 drivers/irqchip/irq-clps711x.c
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/cirrus,clps711x-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/cirrus,clps711x-intc.txt
> new file mode 100644
> index 0000000..26f8983
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/cirrus,clps711x-intc.txt
> @@ -0,0 +1,42 @@
> +Cirrus Logic CLPS711X Interrupt Controller
> +
> +Required properties:
> +
> +- compatible: Should be "cirrus,clps711x-intc"
> +- reg: Specifies base physical address of the registers set
> +- interrupt-controller: Identifies the node as an interrupt controller
> +- #interrupt-cells: Specifies the number of cells needed to encode an
> +  interrupt source. The value shall be 1.
> +
> +The interrupt sources are as follows:
> +ID     Name    Description
> +---------------------------
> +1:     BLINT   Battery low (FIQ)
> +3:     MCINT   Media changed (FIQ)
> +4:     CSINT   CODEC sound
> +5:     EINT1   External 1
> +6:     EINT2   External 2
> +7:     EINT3   External 3
> +8:     TC1OI   TC1 under flow
> +9:     TC2OI   TC2 under flow
> +10:    RTCMI   RTC compare match
> +11:    TINT    64Hz tick
> +12:    UTXINT1 UART1 transmit FIFO half empty
> +13:    URXINT1 UART1 receive FIFO half full
> +14:    UMSINT  UART1 modem status changed
> +15:    SSEOTI  SSI1 end of transfer
> +16:    KBDINT  Keyboard
> +17:    SS2RX   SSI2 receive FIFO half or greater full
> +18:    SS2TX   SSI2 transmit FIFO less than half empty
> +28:    UTXINT2 UART2 transmit FIFO half empty
> +29:    URXINT2 UART2 receive FIFO half full
> +32:    DAIINT  DAI interface (FIQ)

Surely that's specific to the SoC the interrupt controller is used in,
not the interrupt controller IP itself?

> +
> +Example:
> +
> +intc: interrupt-controller {
> +       compatible = "cirrus,clps711x-intc";
> +       reg = <0x80000000 0>;

Zero length?

> +       interrupt-controller;
> +       #interrupt-cells = <1>;
> +};

[...]

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5c60cb7..6f0d238 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -373,8 +373,6 @@ config ARCH_CLPS711X
>         select COMMON_CLK
>         select CPU_ARM720T
>         select MFD_SYSCON
> -       select MULTI_IRQ_HANDLER
> -       select SPARSE_IRQ
>         help
>           Support for Cirrus Logic 711x/721x/731x based boards.
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 1fea003..c94d00a 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -30,6 +30,12 @@ config ARM_VIC_NR
>           The maximum number of VICs available in the system, for
>           power management.
> 
> +config CLPS711X_IRQCHIP
> +       def_bool y if ARCH_CLPS711X
> +       select IRQ_DOMAIN
> +       select MULTI_IRQ_HANDLER
> +       select SPARSE_IRQ
> +
>  config ORION_IRQCHIP
>         bool
>         select IRQ_DOMAIN
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index e65c41a..a80ff5b 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_ARCH_S3C24XX)              += irq-s3c24xx.o
>  obj-$(CONFIG_METAG)                    += irq-metag-ext.o
>  obj-$(CONFIG_METAG_PERFCOUNTER_IRQS)   += irq-metag.o
>  obj-$(CONFIG_ARCH_MOXART)              += irq-moxart.o
> +obj-$(CONFIG_CLPS711X_IRQCHIP)         += irq-clps711x.o
>  obj-$(CONFIG_ORION_IRQCHIP)            += irq-orion.o
>  obj-$(CONFIG_ARCH_SUNXI)               += irq-sun4i.o
>  obj-$(CONFIG_ARCH_SPEAR3XX)            += spear-shirq.o
> diff --git a/drivers/irqchip/irq-clps711x.c b/drivers/irqchip/irq-clps711x.c
> new file mode 100644
> index 0000000..819baa9
> --- /dev/null
> +++ b/drivers/irqchip/irq-clps711x.c
> @@ -0,0 +1,277 @@
> +/*
> + *  CLPS711X IRQ driver
> + *
> + *  Copyright (C) 2013 Alexander Shiyan <shc_work@mail.ru>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/slab.h>
> +
> +#include <asm/exception.h>
> +#include <asm/mach/irq.h>
> +
> +#include "irqchip.h"
> +
> +#define CLPS711X_INTSR1        (0x0240)
> +#define CLPS711X_INTMR1        (0x0280)
> +#define CLPS711X_BLEOI (0x0600)
> +#define CLPS711X_MCEOI (0x0640)
> +#define CLPS711X_TEOI  (0x0680)
> +#define CLPS711X_TC1EOI        (0x06c0)
> +#define CLPS711X_TC2EOI        (0x0700)
> +#define CLPS711X_RTCEOI        (0x0740)
> +#define CLPS711X_UMSEOI        (0x0780)
> +#define CLPS711X_COEOI (0x07c0)
> +#define CLPS711X_INTSR2        (0x1240)
> +#define CLPS711X_INTMR2        (0x1280)
> +#define CLPS711X_SRXEOF        (0x1600)
> +#define CLPS711X_KBDEOI        (0x1700)
> +#define CLPS711X_INTSR3        (0x2240)
> +#define CLPS711X_INTMR3        (0x2280)
> +
> +static const struct {
> +#define CLPS711X_FLAG_EN       (1 << 0)
> +#define CLPS711X_FLAG_FIQ      (1 << 1)
> +       unsigned int    flags;
> +       phys_addr_t     phys_eoi;
> +} clps711x_irqs[] __initconst = {
> +       [1]     = { CLPS711X_FLAG_FIQ, CLPS711X_BLEOI, },
> +       [3]     = { CLPS711X_FLAG_FIQ, CLPS711X_MCEOI, },
> +       [4]     = { CLPS711X_FLAG_EN, CLPS711X_COEOI, },
> +       [5]     = { CLPS711X_FLAG_EN, },
> +       [6]     = { CLPS711X_FLAG_EN, },
> +       [7]     = { CLPS711X_FLAG_EN, },
> +       [8]     = { CLPS711X_FLAG_EN, CLPS711X_TC1EOI, },
> +       [9]     = { CLPS711X_FLAG_EN, CLPS711X_TC2EOI, },
> +       [10]    = { CLPS711X_FLAG_EN, CLPS711X_RTCEOI, },
> +       [11]    = { CLPS711X_FLAG_EN, CLPS711X_TEOI, },
> +       [12]    = { CLPS711X_FLAG_EN, },
> +       [13]    = { CLPS711X_FLAG_EN, },
> +       [14]    = { CLPS711X_FLAG_EN, CLPS711X_UMSEOI, },
> +       [15]    = { CLPS711X_FLAG_EN, CLPS711X_SRXEOF, },
> +       [16]    = { CLPS711X_FLAG_EN, CLPS711X_KBDEOI, },
> +       [17]    = { CLPS711X_FLAG_EN, },
> +       [18]    = { CLPS711X_FLAG_EN, },
> +       [28]    = { CLPS711X_FLAG_EN, },
> +       [29]    = { CLPS711X_FLAG_EN, },
> +       [32]    = { CLPS711X_FLAG_FIQ, },
> +};

Isn't that SoC specific?

> +
> +static struct {
> +       struct irq_domain       *domain;
> +       phys_addr_t             phys_base;
> +       void __iomem            *intmr[3];
> +       void __iomem            *intsr[3];
> +       void __iomem            *eoi[ARRAY_SIZE(clps711x_irqs)];
> +} *clps711x_intc;
> +
> +
> +static inline u32 fls16(u32 x)
> +{
> +       u32 r = 15;
> +
> +       if (!(x & 0xff00)) {
> +               x <<= 8;
> +               r -= 8;
> +       }
> +       if (!(x & 0xf000)) {
> +               x <<= 4;
> +               r -= 4;
> +       }
> +       if (!(x & 0xc000)) {
> +               x <<= 2;
> +               r -= 2;
> +       }
> +       if (!(x & 0x8000))
> +               r--;
> +
> +       return r;
> +}

Why hand-roll this? There's already a generic fls in bitops.h (see
include/asm-generic/bitops/fls.h).

> +
> +static asmlinkage void __exception_irq_entry
> +clps711x_handle_irq(struct pt_regs *regs)
> +{
> +       do {
> +               u32 irqnr, irqstat;
> +
> +               irqstat = readw(clps711x_intc->intmr[0]) &
> +                         readw(clps711x_intc->intsr[0]);
> +               if (irqstat) {
> +                       irqnr = irq_find_mapping(clps711x_intc->domain,
> +                                                fls16(irqstat));
> +                       handle_IRQ(irqnr, regs);
> +               }
> +
> +               irqstat = readw(clps711x_intc->intmr[1]) &
> +                         readw(clps711x_intc->intsr[1]);
> +               if (irqstat) {
> +                       irqnr = irq_find_mapping(clps711x_intc->domain,
> +                                                fls16(irqstat) + 16);
> +                       handle_IRQ(irqnr, regs);
> +                       continue;
> +               }
> +
> +               break;
> +       } while (1);
> +}
> +
> +static void clps711x_intc_eoi(struct irq_data *d)
> +{
> +       irq_hw_number_t hwirq = irqd_to_hwirq(d);
> +
> +       writel(0, clps711x_intc->eoi[hwirq]);
> +}
> +
> +static void clps711x_intc_mask(struct irq_data *d)
> +{
> +       irq_hw_number_t hwirq = irqd_to_hwirq(d);
> +       void __iomem *intmr = clps711x_intc->intmr[hwirq / 16];
> +       u32 tmp;
> +
> +       tmp = readl(intmr);
> +       tmp &= ~(1 << (hwirq % 16));
> +       writel(tmp, intmr);
> +}
> +
> +static void clps711x_intc_unmask(struct irq_data *d)
> +{
> +       irq_hw_number_t hwirq = irqd_to_hwirq(d);
> +       void __iomem *intmr = clps711x_intc->intmr[hwirq / 16];
> +       u32 tmp;
> +
> +       tmp = readl(intmr);
> +       tmp |= 1 << (hwirq % 16);
> +       writel(tmp, intmr);
> +}
> +
> +static struct irq_chip clps711x_intc_chip = {
> +       .name           = "clps711x-intc",
> +       .irq_eoi        = clps711x_intc_eoi,
> +       .irq_mask       = clps711x_intc_mask,
> +       .irq_unmask     = clps711x_intc_unmask,
> +};
> +
> +static void __iomem __init *clps711x_ioremap_one(phys_addr_t reg)
> +{
> +       void __iomem *ret;
> +
> +       if (!request_mem_region(clps711x_intc->phys_base + reg, SZ_4, NULL))
> +               return ERR_PTR(-EBUSY);
> +
> +       ret = ioremap(clps711x_intc->phys_base + reg, SZ_4);
> +       if (!ret)
> +               return ERR_PTR(-ENOMEM);
> +
> +       return ret;
> +}
> +
> +static int __init clps711x_intc_irq_map(struct irq_domain *h, unsigned int virq,
> +                                       irq_hw_number_t hw)
> +{
> +       irq_flow_handler_t handler = handle_level_irq;
> +       unsigned int flags = IRQF_VALID | IRQF_PROBE;
> +
> +       if (!clps711x_irqs[hw].flags)
> +               return 0;
> +
> +       if (clps711x_irqs[hw].flags & CLPS711X_FLAG_FIQ) {
> +               handler = handle_bad_irq;
> +               flags |= IRQF_NOAUTOEN;
> +       } else if (clps711x_irqs[hw].phys_eoi) {
> +               handler = handle_fasteoi_irq;
> +
> +               clps711x_intc->eoi[hw] =
> +                       clps711x_ioremap_one(clps711x_irqs[hw].phys_eoi);
> +               if (IS_ERR_OR_NULL(clps711x_intc->eoi[hw]))
> +                       return PTR_ERR(clps711x_intc->eoi[hw]);

Wrong. What if it's NULL?

> +
> +               /* Clear down pending interrupt */
> +               writel(0, clps711x_intc->eoi[hw]);
> +       }
> +
> +       irq_set_chip_and_handler(virq, &clps711x_intc_chip, handler);
> +       set_irq_flags(virq, flags);
> +
> +       return 0;
> +}
> +
> +static struct irq_domain_ops clps711x_intc_ops = {
> +       .map    = clps711x_intc_irq_map,
> +       .xlate  = irq_domain_xlate_onecell,
> +};
> +
> +static void __init _clps711x_intc_init(phys_addr_t phys_base,
> +                                      struct device_node *np)
> +{
> +       clps711x_intc = kzalloc(sizeof(*clps711x_intc), GFP_KERNEL);
> +       BUG_ON(!clps711x_intc);
> +
> +       clps711x_intc->phys_base = phys_base;
> +
> +       clps711x_intc->intsr[0] = clps711x_ioremap_one(CLPS711X_INTSR1);
> +       BUG_ON(IS_ERR_OR_NULL(clps711x_intc->intsr[0]));
> +
> +       clps711x_intc->intmr[0] = clps711x_ioremap_one(CLPS711X_INTMR1);
> +       BUG_ON(IS_ERR_OR_NULL(clps711x_intc->intmr[0]));
> +
> +       clps711x_intc->intsr[1] = clps711x_ioremap_one(CLPS711X_INTSR2);
> +       BUG_ON(IS_ERR_OR_NULL(clps711x_intc->intsr[1]));
> +
> +       clps711x_intc->intmr[1] = clps711x_ioremap_one(CLPS711X_INTMR2);
> +       BUG_ON(IS_ERR_OR_NULL(clps711x_intc->intmr[1]));
> +
> +       clps711x_intc->intsr[2] = clps711x_ioremap_one(CLPS711X_INTSR3);
> +       BUG_ON(IS_ERR_OR_NULL(clps711x_intc->intsr[2]));
> +
> +       clps711x_intc->intmr[2] = clps711x_ioremap_one(CLPS711X_INTMR3);
> +       BUG_ON(IS_ERR_OR_NULL(clps711x_intc->intmr[2]));
> +
> +       /* Disable interrupts */
> +       writel(0, clps711x_intc->intmr[0]);
> +       writel(0, clps711x_intc->intmr[1]);
> +       writel(0, clps711x_intc->intmr[2]);
> +
> +       BUG_ON(IS_ERR_VALUE(irq_alloc_descs(-1, 0, ARRAY_SIZE(clps711x_irqs),
> +                                           numa_node_id())));
> +
> +       clps711x_intc->domain =
> +               irq_domain_add_legacy(np, ARRAY_SIZE(clps711x_irqs),
> +                                     0, 0, &clps711x_intc_ops, NULL);
> +       BUG_ON(!clps711x_intc->domain);
> +
> +       irq_set_default_host(clps711x_intc->domain);
> +       set_handle_irq(clps711x_handle_irq);
> +
> +#ifdef CONFIG_FIQ
> +       init_FIQ(0);
> +#endif
> +}
> +
> +void __init clps711x_intc_init(phys_addr_t phys_base)
> +{
> +       _clps711x_intc_init(phys_base, NULL);
> +}
> +
> +#ifdef CONFIG_IRQCHIP
> +static int __init clps711x_intc_init_dt(struct device_node *np,
> +                                       struct device_node *parent)
> +{
> +       struct resource res;
> +
> +       BUG_ON(of_address_to_resource(np, 0, &res));
> +
> +       _clps711x_intc_init(res.start, np);

Why not pass the whole resource?

> +
> +       return 0;
> +}
> +IRQCHIP_DECLARE(clps711x, "cirrus,clps711x-intc", clps711x_intc_init_dt);
> +#endif

Thanks,
Mark.
