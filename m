From: robherring2@gmail.com (Rob Herring)
Date: Tue, 24 Apr 2012 16:01:49 -0500
Subject: [PATCH v4] plat-versatile: modernize FPGA IRQ controller
In-Reply-To: <1334690647-12346-1-git-send-email-linus.walleij@linaro.org>
References: <1334690647-12346-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <4F9714BD.4060103@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/2012 02:24 PM, Linus Walleij wrote:
> This does two things to the FPGA IRQ controller in the versatile
> family:
> 
> - Convert to MULTI_IRQ_HANDLER so we can drop the entry macro
>   from the Integrator. The C IRQ handler was inspired from
>   arch/arm/common/vic.c, recent bug discovered in this handler was
>   accounted for.
> - Convert to using IRQ domains so we can get rid of the NO_IRQ
>   mess and proceed with device tree and such stuff.
> 
> As part of the exercise, bump all the low IRQ numbers on the
> Integrator PIC to start from 1 rather than 0, since IRQ 0 is
> now NO_IRQ. The Linux IRQ numbers are thus entirely decoupled
> from the hardware IRQ numbers in this controller.
> 
> I was unable to split this patch. The main reason is the half-done
> conversion to device tree in Versatile.
> 
> Tested on Integrator/AP and Integrator/CP.
> 
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Looks good.

Acked-by: Rob Herring <rob.herring@calxeda.com>

Rob

> ---
> ChangeLog v3->v4:
> - Get rid of the awkward host_data solution, Rob told me how
>   to do it.
> ChangeLog v2->v3:
> - After som hints from Rob Herring and meditating about the
>   mapping function I figured out how to do the mapping properly.
> - Introduce a custom mapping function that will skip over the
>   holes in the valid map.
> - No need to bump the platform NR_IRQS since we handle holes in
>   the map gracefully.
> - Renumbered the Integrator PIC IRQs to avoid using IRQ 0 which
>   is now invalid.
> - Redefined IRQ_PIC_END to the last used PIC IRQ in analogy
>   with the other IRQ numbers. The previous definition was the
>   last HW IRQ number on the PIC and this is no longer relevant.
> - Use a file-local pointer to pass the pointer to the handler
>   data to the mapping function, the alternative is to modify
>   the mapping functions to take an opaque parameter as well.
> - Number Integrator/AP IRQs starting from IRQ_PIC_START as
>   well, not 0 as before.
> ChangeLog v1->v2:
> - Drop the patch messing with the masks in prev [1/3] patch.
> - Squash the movement of the main struct, it I can split it out
>   again if desired.
> - Fix the entry-level handler to account for the bug recently
>   discovered in the VIC code and thus avoid to bring that over
>   to this driver as well.
> - Extend the number of IRQs on each platform to account for
>   the "no holes" problem mentioned in the commit info.
> - Introduce a cic_mask variable to make Integrator/CP
>   IRQ setup it a little more readable.
> - Drop excess paretheses in mask/unmask
> - Fix typos, edit commit message.
> ---
>  arch/arm/Kconfig                                   |    1 +
>  .../arm/mach-integrator/include/mach/entry-macro.S |   39 -------
>  arch/arm/mach-integrator/include/mach/irqs.h       |   63 +++++------
>  arch/arm/mach-integrator/integrator_ap.c           |   10 +-
>  arch/arm/mach-integrator/integrator_cp.c           |   33 ++----
>  arch/arm/mach-versatile/core.c                     |   13 +--
>  arch/arm/plat-versatile/Kconfig                    |    6 +
>  arch/arm/plat-versatile/fpga-irq.c                 |  116 +++++++++++++++++---
>  arch/arm/plat-versatile/include/plat/fpga-irq.h    |   11 +-
>  9 files changed, 162 insertions(+), 130 deletions(-)
>  delete mode 100644 arch/arm/mach-integrator/include/mach/entry-macro.S
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index cf006d4..2f67f6c 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -280,6 +280,7 @@ config ARCH_INTEGRATOR
>  	select NEED_MACH_IO_H
>  	select NEED_MACH_MEMORY_H
>  	select SPARSE_IRQ
> +	select MULTI_IRQ_HANDLER
>  	help
>  	  Support for ARM's Integrator platform.
>  
> diff --git a/arch/arm/mach-integrator/include/mach/entry-macro.S b/arch/arm/mach-integrator/include/mach/entry-macro.S
> deleted file mode 100644
> index 5cc7b85..0000000
> --- a/arch/arm/mach-integrator/include/mach/entry-macro.S
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -/*
> - * arch/arm/mach-integrator/include/mach/entry-macro.S
> - *
> - * Low-level IRQ helper macros for Integrator platforms
> - *
> - * This file is licensed under  the terms of the GNU General Public
> - * License version 2. This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -#include <mach/hardware.h>
> -#include <mach/platform.h>
> -#include <mach/irqs.h>
> -
> -		.macro  get_irqnr_preamble, base, tmp
> -		.endm
> -
> -		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
> -/* FIXME: should not be using soo many LDRs here */
> -		ldr	\base, =IO_ADDRESS(INTEGRATOR_IC_BASE)
> -		mov	\irqnr, #IRQ_PIC_START
> -		ldr	\irqstat, [\base, #IRQ_STATUS]		@ get masked status
> -		ldr	\base, =IO_ADDRESS(INTEGRATOR_HDR_BASE)
> -		teq	\irqstat, #0
> -		ldreq	\irqstat, [\base, #(INTEGRATOR_HDR_IC_OFFSET+IRQ_STATUS)]
> -		moveq	\irqnr, #IRQ_CIC_START
> -
> -1001:		tst	\irqstat, #15
> -		bne	1002f
> -		add	\irqnr, \irqnr, #4
> -		movs	\irqstat, \irqstat, lsr #4
> -		bne	1001b
> -1002:		tst	\irqstat, #1
> -		bne	1003f
> -		add	\irqnr, \irqnr, #1
> -		movs	\irqstat, \irqstat, lsr #1
> -		bne	1002b
> -1003:		/* EQ will be set if no irqs pending */
> -		.endm
> -
> diff --git a/arch/arm/mach-integrator/include/mach/irqs.h b/arch/arm/mach-integrator/include/mach/irqs.h
> index a19a1a2..7371018 100644
> --- a/arch/arm/mach-integrator/include/mach/irqs.h
> +++ b/arch/arm/mach-integrator/include/mach/irqs.h
> @@ -22,37 +22,37 @@
>  /* 
>   *  Interrupt numbers
>   */
> -#define IRQ_PIC_START			0
> -#define IRQ_SOFTINT			0
> -#define IRQ_UARTINT0			1
> -#define IRQ_UARTINT1			2
> -#define IRQ_KMIINT0			3
> -#define IRQ_KMIINT1			4
> -#define IRQ_TIMERINT0			5
> -#define IRQ_TIMERINT1			6
> -#define IRQ_TIMERINT2			7
> -#define IRQ_RTCINT			8
> -#define IRQ_AP_EXPINT0			9
> -#define IRQ_AP_EXPINT1			10
> -#define IRQ_AP_EXPINT2			11
> -#define IRQ_AP_EXPINT3			12
> -#define IRQ_AP_PCIINT0			13
> -#define IRQ_AP_PCIINT1			14
> -#define IRQ_AP_PCIINT2			15
> -#define IRQ_AP_PCIINT3			16
> -#define IRQ_AP_V3INT			17
> -#define IRQ_AP_CPINT0			18
> -#define IRQ_AP_CPINT1			19
> -#define IRQ_AP_LBUSTIMEOUT 		20
> -#define IRQ_AP_APCINT			21
> -#define IRQ_CP_CLCDCINT			22
> -#define IRQ_CP_MMCIINT0			23
> -#define IRQ_CP_MMCIINT1			24
> -#define IRQ_CP_AACIINT			25
> -#define IRQ_CP_CPPLDINT			26
> -#define IRQ_CP_ETHINT			27
> -#define IRQ_CP_TSPENINT			28
> -#define IRQ_PIC_END			31
> +#define IRQ_PIC_START			1
> +#define IRQ_SOFTINT			1
> +#define IRQ_UARTINT0			2
> +#define IRQ_UARTINT1			3
> +#define IRQ_KMIINT0			4
> +#define IRQ_KMIINT1			5
> +#define IRQ_TIMERINT0			6
> +#define IRQ_TIMERINT1			7
> +#define IRQ_TIMERINT2			8
> +#define IRQ_RTCINT			9
> +#define IRQ_AP_EXPINT0			10
> +#define IRQ_AP_EXPINT1			11
> +#define IRQ_AP_EXPINT2			12
> +#define IRQ_AP_EXPINT3			13
> +#define IRQ_AP_PCIINT0			14
> +#define IRQ_AP_PCIINT1			15
> +#define IRQ_AP_PCIINT2			16
> +#define IRQ_AP_PCIINT3			17
> +#define IRQ_AP_V3INT			18
> +#define IRQ_AP_CPINT0			19
> +#define IRQ_AP_CPINT1			20
> +#define IRQ_AP_LBUSTIMEOUT 		21
> +#define IRQ_AP_APCINT			22
> +#define IRQ_CP_CLCDCINT			23
> +#define IRQ_CP_MMCIINT0			24
> +#define IRQ_CP_MMCIINT1			25
> +#define IRQ_CP_AACIINT			26
> +#define IRQ_CP_CPPLDINT			27
> +#define IRQ_CP_ETHINT			28
> +#define IRQ_CP_TSPENINT			29
> +#define IRQ_PIC_END			29
>  
>  #define IRQ_CIC_START			32
>  #define IRQ_CM_SOFTINT			32
> @@ -80,4 +80,3 @@
>  
>  #define NR_IRQS_INTEGRATOR_AP		34
>  #define NR_IRQS_INTEGRATOR_CP		47
> -
> diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
> index 871f148..c857501 100644
> --- a/arch/arm/mach-integrator/integrator_ap.c
> +++ b/arch/arm/mach-integrator/integrator_ap.c
> @@ -162,12 +162,6 @@ static void __init ap_map_io(void)
>  
>  #define INTEGRATOR_SC_VALID_INT	0x003fffff
>  
> -static struct fpga_irq_data sc_irq_data = {
> -	.base		= VA_IC_BASE,
> -	.irq_start	= 0,
> -	.chip.name	= "SC",
> -};
> -
>  static void __init ap_init_irq(void)
>  {
>  	/* Disable all interrupts initially. */
> @@ -178,7 +172,8 @@ static void __init ap_init_irq(void)
>  	writel(-1, VA_IC_BASE + IRQ_ENABLE_CLEAR);
>  	writel(-1, VA_IC_BASE + FIQ_ENABLE_CLEAR);
>  
> -	fpga_irq_init(-1, INTEGRATOR_SC_VALID_INT, &sc_irq_data);
> +	fpga_irq_init(VA_IC_BASE, "SC", IRQ_PIC_START,
> +		-1, INTEGRATOR_SC_VALID_INT, NULL);
>  }
>  
>  #ifdef CONFIG_PM
> @@ -478,6 +473,7 @@ MACHINE_START(INTEGRATOR, "ARM-Integrator")
>  	.nr_irqs	= NR_IRQS_INTEGRATOR_AP,
>  	.init_early	= integrator_init_early,
>  	.init_irq	= ap_init_irq,
> +	.handle_irq	= fpga_handle_irq,
>  	.timer		= &ap_timer,
>  	.init_machine	= ap_init,
>  	.restart	= integrator_restart,
> diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
> index 48a115a..a56c536 100644
> --- a/arch/arm/mach-integrator/integrator_cp.c
> +++ b/arch/arm/mach-integrator/integrator_cp.c
> @@ -143,30 +143,14 @@ static void __init intcp_map_io(void)
>  	iotable_init(intcp_io_desc, ARRAY_SIZE(intcp_io_desc));
>  }
>  
> -static struct fpga_irq_data cic_irq_data = {
> -	.base		= INTCP_VA_CIC_BASE,
> -	.irq_start	= IRQ_CIC_START,
> -	.chip.name	= "CIC",
> -};
> -
> -static struct fpga_irq_data pic_irq_data = {
> -	.base		= INTCP_VA_PIC_BASE,
> -	.irq_start	= IRQ_PIC_START,
> -	.chip.name	= "PIC",
> -};
> -
> -static struct fpga_irq_data sic_irq_data = {
> -	.base		= INTCP_VA_SIC_BASE,
> -	.irq_start	= IRQ_SIC_START,
> -	.chip.name	= "SIC",
> -};
> -
>  static void __init intcp_init_irq(void)
>  {
> -	u32 pic_mask, sic_mask;
> +	u32 pic_mask, cic_mask, sic_mask;
>  
> +	/* These masks are for the HW IRQ registers */
>  	pic_mask = ~((~0u) << (11 - IRQ_PIC_START));
>  	pic_mask |= (~((~0u) << (29 - 22))) << 22;
> +	cic_mask = ~((~0u) << (1 + IRQ_CIC_END - IRQ_CIC_START));
>  	sic_mask = ~((~0u) << (1 + IRQ_SIC_END - IRQ_SIC_START));
>  
>  	/*
> @@ -179,12 +163,14 @@ static void __init intcp_init_irq(void)
>  	writel(sic_mask, INTCP_VA_SIC_BASE + IRQ_ENABLE_CLEAR);
>  	writel(sic_mask, INTCP_VA_SIC_BASE + FIQ_ENABLE_CLEAR);
>  
> -	fpga_irq_init(-1, pic_mask, &pic_irq_data);
> +	fpga_irq_init(INTCP_VA_PIC_BASE, "PIC", IRQ_PIC_START,
> +		      -1, pic_mask, NULL);
>  
> -	fpga_irq_init(-1, ~((~0u) << (1 + IRQ_CIC_END - IRQ_CIC_START)),
> -		&cic_irq_data);
> +	fpga_irq_init(INTCP_VA_CIC_BASE, "CIC", IRQ_CIC_START,
> +		      -1, cic_mask, NULL);
>  
> -	fpga_irq_init(IRQ_CP_CPPLDINT, sic_mask, &sic_irq_data);
> +	fpga_irq_init(INTCP_VA_SIC_BASE, "SIC", IRQ_SIC_START,
> +		      IRQ_CP_CPPLDINT, sic_mask, NULL);
>  }
>  
>  /*
> @@ -467,6 +453,7 @@ MACHINE_START(CINTEGRATOR, "ARM-IntegratorCP")
>  	.nr_irqs	= NR_IRQS_INTEGRATOR_CP,
>  	.init_early	= intcp_init_early,
>  	.init_irq	= intcp_init_irq,
> +	.handle_irq	= fpga_handle_irq,
>  	.timer		= &cp_timer,
>  	.init_machine	= intcp_init,
>  	.restart	= integrator_restart,
> diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
> index 6bbd74e..6f5fb46 100644
> --- a/arch/arm/mach-versatile/core.c
> +++ b/arch/arm/mach-versatile/core.c
> @@ -66,12 +66,6 @@
>  #define VA_VIC_BASE		__io_address(VERSATILE_VIC_BASE)
>  #define VA_SIC_BASE		__io_address(VERSATILE_SIC_BASE)
>  
> -static struct fpga_irq_data sic_irq = {
> -	.base		= VA_SIC_BASE,
> -	.irq_start	= IRQ_SIC_START,
> -	.chip.name	= "SIC",
> -};
> -
>  #if 1
>  #define IRQ_MMCI0A	IRQ_VICSOURCE22
>  #define IRQ_AACI	IRQ_VICSOURCE24
> @@ -105,8 +99,11 @@ void __init versatile_init_irq(void)
>  
>  	writel(~0, VA_SIC_BASE + SIC_IRQ_ENABLE_CLEAR);
>  
> -	fpga_irq_init(IRQ_VICSOURCE31, ~PIC_MASK, &sic_irq);
> -	irq_domain_generate_simple(sic_of_match, VERSATILE_SIC_BASE, IRQ_SIC_START);
> +	np = of_find_matching_node_by_address(NULL, sic_of_match,
> +					      VERSATILE_SIC_BASE);
> +
> +	fpga_irq_init(VA_SIC_BASE, "SIC", IRQ_SIC_START,
> +		IRQ_VICSOURCE31, ~PIC_MASK, np);
>  
>  	/*
>  	 * Interrupts on secondary controller from 0 to 8 are routed to
> diff --git a/arch/arm/plat-versatile/Kconfig b/arch/arm/plat-versatile/Kconfig
> index 043f7b0..81ee7cc 100644
> --- a/arch/arm/plat-versatile/Kconfig
> +++ b/arch/arm/plat-versatile/Kconfig
> @@ -5,6 +5,12 @@ config PLAT_VERSATILE_CLCD
>  
>  config PLAT_VERSATILE_FPGA_IRQ
>  	bool
> +	select IRQ_DOMAIN
> +
> +config PLAT_VERSATILE_FPGA_IRQ_NR
> +       int
> +       default 4
> +       depends on PLAT_VERSATILE_FPGA_IRQ
>  
>  config PLAT_VERSATILE_LEDS
>  	def_bool y if LEDS_CLASS
> diff --git a/arch/arm/plat-versatile/fpga-irq.c b/arch/arm/plat-versatile/fpga-irq.c
> index f0cc8e1..6e70d03 100644
> --- a/arch/arm/plat-versatile/fpga-irq.c
> +++ b/arch/arm/plat-versatile/fpga-irq.c
> @@ -3,7 +3,10 @@
>   */
>  #include <linux/irq.h>
>  #include <linux/io.h>
> +#include <linux/irqdomain.h>
> +#include <linux/module.h>
>  
> +#include <asm/exception.h>
>  #include <asm/mach/irq.h>
>  #include <plat/fpga-irq.h>
>  
> @@ -12,10 +15,32 @@
>  #define IRQ_ENABLE_SET		0x08
>  #define IRQ_ENABLE_CLEAR	0x0c
>  
> +/**
> + * struct fpga_irq_data - irq data container for the FPGA IRQ controller
> + * @base: memory offset in virtual memory
> + * @irq_start: first IRQ number handled by this instance
> + * @chip: chip container for this instance
> + * @domain: IRQ domain for this instance
> + * @valid: mask for valid IRQs on this controller
> + * @used_irqs: number of active IRQs on this controller
> + */
> +struct fpga_irq_data {
> +	void __iomem *base;
> +	unsigned int irq_start;
> +	struct irq_chip chip;
> +	u32 valid;
> +	struct irq_domain *domain;
> +	u8 used_irqs;
> +};
> +
> +/* we cannot allocate memory when the controllers are initially registered */
> +static struct fpga_irq_data fpga_irq_devices[CONFIG_PLAT_VERSATILE_FPGA_IRQ_NR];
> +static int fpga_irq_id;
> +
>  static void fpga_irq_mask(struct irq_data *d)
>  {
>  	struct fpga_irq_data *f = irq_data_get_irq_chip_data(d);
> -	u32 mask = 1 << (d->irq - f->irq_start);
> +	u32 mask = 1 << d->hwirq;
>  
>  	writel(mask, f->base + IRQ_ENABLE_CLEAR);
>  }
> @@ -23,7 +48,7 @@ static void fpga_irq_mask(struct irq_data *d)
>  static void fpga_irq_unmask(struct irq_data *d)
>  {
>  	struct fpga_irq_data *f = irq_data_get_irq_chip_data(d);
> -	u32 mask = 1 << (d->irq - f->irq_start);
> +	u32 mask = 1 << d->hwirq;
>  
>  	writel(mask, f->base + IRQ_ENABLE_SET);
>  }
> @@ -41,32 +66,93 @@ static void fpga_irq_handle(unsigned int irq, struct irq_desc *desc)
>  	do {
>  		irq = ffs(status) - 1;
>  		status &= ~(1 << irq);
> -
> -		generic_handle_irq(irq + f->irq_start);
> +		generic_handle_irq(irq_find_mapping(f->domain, irq));
>  	} while (status);
>  }
>  
> -void __init fpga_irq_init(int parent_irq, u32 valid, struct fpga_irq_data *f)
> +/*
> + * Handle each interrupt in a single FPGA IRQ controller.  Returns non-zero
> + * if we've handled at least one interrupt.  This does a single read of the
> + * status register and handles all interrupts in order from LSB first.
> + */
> +static int handle_one_fpga(struct fpga_irq_data *f, struct pt_regs *regs)
> +{
> +	int handled = 0;
> +	int irq;
> +	u32 status;
> +
> +	while ((status  = readl(f->base + IRQ_STATUS))) {
> +		irq = ffs(status) - 1;
> +		handle_IRQ(irq_find_mapping(f->domain, irq), regs);
> +		handled = 1;
> +	}
> +
> +	return handled;
> +}
> +
> +/*
> + * Keep iterating over all registered FPGA IRQ controllers until there are
> + * no pending interrupts.
> + */
> +asmlinkage void __exception_irq_entry fpga_handle_irq(struct pt_regs *regs)
>  {
> -	unsigned int i;
> +	int i, handled;
>  
> +	do {
> +		for (i = 0, handled = 0; i < fpga_irq_id; ++i)
> +			handled |= handle_one_fpga(&fpga_irq_devices[i], regs);
> +	} while (handled);
> +}
> +
> +static int fpga_irqdomain_map(struct irq_domain *d, unsigned int irq,
> +		irq_hw_number_t hwirq)
> +{
> +	struct fpga_irq_data *f = d->host_data;
> +
> +	/* Skip invalid IRQs, only register handlers for the real ones */
> +	if (!(f->valid & (1 << hwirq)))
> +		return -ENOTSUPP;
> +	irq_set_chip_data(irq, f);
> +	irq_set_chip_and_handler(irq, &f->chip,
> +				handle_level_irq);
> +	set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
> +	f->used_irqs++;
> +	return 0;
> +}
> +
> +static struct irq_domain_ops fpga_irqdomain_ops = {
> +	.map = fpga_irqdomain_map,
> +	.xlate = irq_domain_xlate_onetwocell,
> +};
> +
> +void __init fpga_irq_init(void __iomem *base, const char *name, int irq_start,
> +			  int parent_irq, u32 valid, struct device_node *node)
> +{
> +	struct fpga_irq_data *f;
> +
> +	if (fpga_irq_id >= ARRAY_SIZE(fpga_irq_devices)) {
> +		printk(KERN_ERR "%s: too few FPGA IRQ controllers, increase CONFIG_PLAT_VERSATILE_FPGA_IRQ_NR\n", __func__);
> +		return;
> +	}
> +
> +	f = &fpga_irq_devices[fpga_irq_id];
> +	f->base = base;
> +	f->irq_start = irq_start;
> +	f->chip.name = name;
>  	f->chip.irq_ack = fpga_irq_mask;
>  	f->chip.irq_mask = fpga_irq_mask;
>  	f->chip.irq_unmask = fpga_irq_unmask;
> +	f->valid = valid;
>  
>  	if (parent_irq != -1) {
>  		irq_set_handler_data(parent_irq, f);
>  		irq_set_chained_handler(parent_irq, fpga_irq_handle);
>  	}
>  
> -	for (i = 0; i < 32; i++) {
> -		if (valid & (1 << i)) {
> -			unsigned int irq = f->irq_start + i;
> +	f->domain = irq_domain_add_legacy(node, fls(valid), f->irq_start, 0,
> +					  &fpga_irqdomain_ops, f);
> +	pr_info("FPGA IRQ chip %d \"%s\" @ %p, %u irqs\n",
> +		fpga_irq_id, name, base, f->used_irqs);
>  
> -			irq_set_chip_data(irq, f);
> -			irq_set_chip_and_handler(irq, &f->chip,
> -						 handle_level_irq);
> -			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
> -		}
> -	}
> +	fpga_irq_id++;
>  }
> diff --git a/arch/arm/plat-versatile/include/plat/fpga-irq.h b/arch/arm/plat-versatile/include/plat/fpga-irq.h
> index 627fafd..91bcfb6 100644
> --- a/arch/arm/plat-versatile/include/plat/fpga-irq.h
> +++ b/arch/arm/plat-versatile/include/plat/fpga-irq.h
> @@ -1,12 +1,11 @@
>  #ifndef PLAT_FPGA_IRQ_H
>  #define PLAT_FPGA_IRQ_H
>  
> -struct fpga_irq_data {
> -	void __iomem *base;
> -	unsigned int irq_start;
> -	struct irq_chip chip;
> -};
> +struct device_node;
> +struct pt_regs;
>  
> -void fpga_irq_init(int, u32, struct fpga_irq_data *);
> +void fpga_handle_irq(struct pt_regs *regs);
> +void fpga_irq_init(void __iomem *, const char *, int, int, u32,
> +		struct device_node *node);
>  
>  #endif
