From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 25 Mar 2013 17:19:49 +0800
Subject: [PATCH 3/8] ARM: sirf: move irq driver to drivers/irqchip
In-Reply-To: <1363779679-16880-4-git-send-email-arnd@arndb.de>
References: <1363779679-16880-1-git-send-email-arnd@arndb.de>
 <1363779679-16880-4-git-send-email-arnd@arndb.de>
Message-ID: <CAGsJ_4wUtgEGY9fc_RGq4m+=wzzgS1MxCOCLRm6Xh+-5kVMAdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/20, Arnd Bergmann <arnd@arndb.de>:
> This updates the irqchip drier for prima2 to the current practices by
> moving it into drivers/irqchip and integrating it into the irqchip_init
> infrastructure. We also now use a linear irq domain as a preparation
> for sparse IRQ suport.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/arm/mach-prima2/common.c |  10 +---
>  arch/arm/mach-prima2/irq.c    | 129
> ------------------------------------------
>  drivers/irqchip/Makefile      |   1 +
>  drivers/irqchip/irq-sirfsoc.c | 123
> ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 126 insertions(+), 137 deletions(-)
>  delete mode 100644 arch/arm/mach-prima2/irq.c
>  create mode 100644 drivers/irqchip/irq-sirfsoc.c
>
> diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
> index 72efb4f..15c14df 100644
> --- a/arch/arm/mach-prima2/common.c
> +++ b/arch/arm/mach-prima2/common.c
> @@ -46,11 +46,8 @@ static const char *atlas6_dt_match[] __initdata = {
>  DT_MACHINE_START(ATLAS6_DT, "Generic ATLAS6 (Flattened Device Tree)")
>  	/* Maintainer: Barry Song <baohua.song@csr.com> */
>  	.map_io         = sirfsoc_map_io,
> -	.init_irq	= sirfsoc_of_irq_init,
> +	.init_irq	= irqchip_init,
>  	.init_time	= sirfsoc_prima2_timer_init,
> -#ifdef CONFIG_MULTI_IRQ_HANDLER
> -	.handle_irq     = sirfsoc_handle_irq,
> -#endif
>  	.init_machine	= sirfsoc_mach_init,
>  	.init_late	= sirfsoc_init_late,
>  	.dt_compat      = atlas6_dt_match,
> @@ -67,11 +64,8 @@ static const char *prima2_dt_match[] __initdata = {
>  DT_MACHINE_START(PRIMA2_DT, "Generic PRIMA2 (Flattened Device Tree)")
>  	/* Maintainer: Barry Song <baohua.song@csr.com> */
>  	.map_io         = sirfsoc_map_io,
> -	.init_irq	= sirfsoc_of_irq_init,
> +	.init_irq	= irqchip_init,
>  	.init_time	= sirfsoc_prima2_timer_init,
> -#ifdef CONFIG_MULTI_IRQ_HANDLER
> -	.handle_irq     = sirfsoc_handle_irq,
> -#endif
>  	.dma_zone_size	= SZ_256M,
>  	.init_machine	= sirfsoc_mach_init,
>  	.init_late	= sirfsoc_init_late,
> diff --git a/arch/arm/mach-prima2/irq.c b/arch/arm/mach-prima2/irq.c
> deleted file mode 100644
> index 6c0f3e9..0000000
> --- a/arch/arm/mach-prima2/irq.c
> +++ /dev/null
> @@ -1,129 +0,0 @@
> -/*
> - * interrupt controller support for CSR SiRFprimaII
> - *
> - * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group
> company.
> - *
> - * Licensed under GPLv2 or later.
> - */
> -
> -#include <linux/init.h>
> -#include <linux/io.h>
> -#include <linux/irq.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/irqdomain.h>
> -#include <linux/syscore_ops.h>
> -#include <asm/mach/irq.h>
> -#include <asm/exception.h>
> -#include <mach/hardware.h>
> -
> -#define SIRFSOC_INT_RISC_MASK0          0x0018
> -#define SIRFSOC_INT_RISC_MASK1          0x001C
> -#define SIRFSOC_INT_RISC_LEVEL0         0x0020
> -#define SIRFSOC_INT_RISC_LEVEL1         0x0024
> -#define SIRFSOC_INIT_IRQ_ID		0x0038
> -
> -void __iomem *sirfsoc_intc_base;
> -
> -static __init void
> -sirfsoc_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int
> num)
> -{
> -	struct irq_chip_generic *gc;
> -	struct irq_chip_type *ct;
> -
> -	gc = irq_alloc_generic_chip("SIRFINTC", 1, irq_start, base,
> handle_level_irq);
> -	ct = gc->chip_types;
> -
> -	ct->chip.irq_mask = irq_gc_mask_clr_bit;
> -	ct->chip.irq_unmask = irq_gc_mask_set_bit;
> -	ct->regs.mask = SIRFSOC_INT_RISC_MASK0;
> -
> -	irq_setup_generic_chip(gc, IRQ_MSK(num), IRQ_GC_INIT_MASK_CACHE,
> IRQ_NOREQUEST, 0);
> -}
> -
> -static __init void sirfsoc_irq_init(void)
> -{
> -	sirfsoc_alloc_gc(sirfsoc_intc_base, 0, 32);
> -	sirfsoc_alloc_gc(sirfsoc_intc_base + 4, 32,
> -			SIRFSOC_INTENAL_IRQ_END + 1 - 32);
> -
> -	writel_relaxed(0, sirfsoc_intc_base + SIRFSOC_INT_RISC_LEVEL0);
> -	writel_relaxed(0, sirfsoc_intc_base + SIRFSOC_INT_RISC_LEVEL1);
> -
> -	writel_relaxed(0, sirfsoc_intc_base + SIRFSOC_INT_RISC_MASK0);
> -	writel_relaxed(0, sirfsoc_intc_base + SIRFSOC_INT_RISC_MASK1);
> -}
> -
> -asmlinkage void __exception_irq_entry sirfsoc_handle_irq(struct pt_regs
> *regs)
> -{
> -	u32 irqstat, irqnr;
> -
> -	irqstat = readl_relaxed(sirfsoc_intc_base + SIRFSOC_INIT_IRQ_ID);
> -	irqnr = irqstat & 0xff;
> -
> -	handle_IRQ(irqnr, regs);
> -}
> -
> -static struct of_device_id intc_ids[]  = {
> -	{ .compatible = "sirf,prima2-intc" },
> -	{},
> -};
> -
> -void __init sirfsoc_of_irq_init(void)
> -{
> -	struct device_node *np;
> -
> -	np = of_find_matching_node(NULL, intc_ids);
> -	if (!np)
> -		return;
> -
> -	sirfsoc_intc_base = of_iomap(np, 0);
> -	if (!sirfsoc_intc_base)
> -		panic("unable to map intc cpu registers\n");
> -
> -	irq_domain_add_legacy(np, SIRFSOC_INTENAL_IRQ_END + 1, 0, 0,
> -		&irq_domain_simple_ops, NULL);
> -
> -	of_node_put(np);
> -
> -	sirfsoc_irq_init();
> -}
> -
> -struct sirfsoc_irq_status {
> -	u32 mask0;
> -	u32 mask1;
> -	u32 level0;
> -	u32 level1;
> -};
> -
> -static struct sirfsoc_irq_status sirfsoc_irq_st;
> -
> -static int sirfsoc_irq_suspend(void)
> -{
> -	sirfsoc_irq_st.mask0 = readl_relaxed(sirfsoc_intc_base +
> SIRFSOC_INT_RISC_MASK0);
> -	sirfsoc_irq_st.mask1 = readl_relaxed(sirfsoc_intc_base +
> SIRFSOC_INT_RISC_MASK1);
> -	sirfsoc_irq_st.level0 = readl_relaxed(sirfsoc_intc_base +
> SIRFSOC_INT_RISC_LEVEL0);
> -	sirfsoc_irq_st.level1 = readl_relaxed(sirfsoc_intc_base +
> SIRFSOC_INT_RISC_LEVEL1);
> -
> -	return 0;
> -}
> -
> -static void sirfsoc_irq_resume(void)
> -{
> -	writel_relaxed(sirfsoc_irq_st.mask0, sirfsoc_intc_base +
> SIRFSOC_INT_RISC_MASK0);
> -	writel_relaxed(sirfsoc_irq_st.mask1, sirfsoc_intc_base +
> SIRFSOC_INT_RISC_MASK1);
> -	writel_relaxed(sirfsoc_irq_st.level0, sirfsoc_intc_base +
> SIRFSOC_INT_RISC_LEVEL0);
> -	writel_relaxed(sirfsoc_irq_st.level1, sirfsoc_intc_base +
> SIRFSOC_INT_RISC_LEVEL1);
> -}
> -
> -static struct syscore_ops sirfsoc_irq_syscore_ops = {
> -	.suspend	= sirfsoc_irq_suspend,
> -	.resume		= sirfsoc_irq_resume,
> -};
> -
> -static int __init sirfsoc_irq_pm_init(void)
> -{
> -	register_syscore_ops(&sirfsoc_irq_syscore_ops);
> -	return 0;
> -}
> -device_initcall(sirfsoc_irq_pm_init);
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 98e3b87..5cb6bd2 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -8,4 +8,5 @@ obj-$(CONFIG_ARCH_SUNXI)		+= irq-sunxi.o
>  obj-$(CONFIG_ARCH_SPEAR3XX)		+= spear-shirq.o
>  obj-$(CONFIG_ARM_GIC)			+= irq-gic.o
>  obj-$(CONFIG_ARM_VIC)			+= irq-vic.o
> +obj-$(CONFIG_SIRF_IRQ)			+= irq-sirfsoc.o
>  obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+= irq-versatile-fpga.o
> diff --git a/drivers/irqchip/irq-sirfsoc.c b/drivers/irqchip/irq-sirfsoc.c
> new file mode 100644
> index 0000000..9a6a925
> --- /dev/null
> +++ b/drivers/irqchip/irq-sirfsoc.c
> @@ -0,0 +1,123 @@
> +/*
> + * interrupt controller support for CSR SiRFprimaII
> + *
> + * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group
> company.
> + *
> + * Licensed under GPLv2 or later.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/irqdomain.h>
> +#include <linux/syscore_ops.h>
> +#include <asm/mach/irq.h>
> +#include <asm/exception.h>
> +#include "irqchip.h"
> +
> +#define SIRFSOC_INT_RISC_MASK0          0x0018
> +#define SIRFSOC_INT_RISC_MASK1          0x001C
> +#define SIRFSOC_INT_RISC_LEVEL0         0x0020
> +#define SIRFSOC_INT_RISC_LEVEL1         0x0024
> +#define SIRFSOC_INIT_IRQ_ID		0x0038
> +
> +#define SIRFSOC_NUM_IRQS		128
> +
> +static struct irq_domain *sirfsoc_irqdomain;
> +
> +static __init void
> +sirfsoc_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int
> num)
> +{
> +	struct irq_chip_generic *gc;
> +	struct irq_chip_type *ct;
> +
> +	gc = irq_alloc_generic_chip("SIRFINTC", 1, irq_start, base,
> handle_level_irq);
> +	ct = gc->chip_types;
> +
> +	ct->chip.irq_mask = irq_gc_mask_clr_bit;
> +	ct->chip.irq_unmask = irq_gc_mask_set_bit;
> +	ct->regs.mask = SIRFSOC_INT_RISC_MASK0;
> +
> +	irq_setup_generic_chip(gc, IRQ_MSK(num), IRQ_GC_INIT_MASK_CACHE,
> IRQ_NOREQUEST, 0);
> +}
> +
> +static asmlinkage void __exception_irq_entry sirfsoc_handle_irq(struct
> pt_regs *regs)
> +{
> +	void __iomem *base = sirfsoc_irqdomain->host_data;
> +	u32 irqstat, irqnr;
> +
> +	irqstat = readl_relaxed(base + SIRFSOC_INIT_IRQ_ID);
> +	irqnr = irq_find_mapping(sirfsoc_irqdomain, irqstat & 0xff);
> +
> +	handle_IRQ(irqnr, regs);
> +}
> +
> +static void __init sirfsoc_irq_init(struct device_node *np, struct
> device_node *parent)

this function should be changed from void to int.

> +{
> +	void __iomem *base = of_iomap(np, 0);
> +	if (!base)
> +		panic("unable to map intc cpu registers\n");
> +
> +	sirfsoc_irqdomain = irq_domain_add_linear(np, SIRFSOC_NUM_IRQS,
> +				 &irq_domain_simple_ops, base);

this breaks the hwirq and irq mapping. the hwirq 0 is mapped to
no_irqs, then setup_irq will fail in
drivers/clocksource/timer-prima2.c.

-barry
