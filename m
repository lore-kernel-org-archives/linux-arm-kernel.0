From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 4 May 2011 08:52:24 +0200
Subject: AT91: Interrupt handling independent of processor base-address
In-Reply-To: <1304291042.22966.12.camel@redbox>
References: <1304291042.22966.12.camel@redbox>
Message-ID: <20110504065224.GO11267@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01:04 Mon 02 May     , Andrew Victor wrote:
> For supporting multiple AT91 processors in a single kernel image, the
> base address of the AIC controller needs to be calculated in the
> processor initialization code and then provided to the AIC driver.
>  * Low-level IRQ hander in entry-macro.S also updated.
>  * AT91_AIC definitions renamed to AT91xxx_AIC.
the AIC is at the same place o nall soc 5series included

with my patch to have the same BASE_SYS across all at91 AIC
no need

Best Regards,
J.
> 
> All these patches are here:
>  git://github.com/at91linux/linux-2.6-at91.git/av-devel
> 
> Signed-off-by: Andrew Victor <linux@maxim.org.za>
> 
> 
> diff --git a/arch/arm/mach-at91/at572d940hf.c b/arch/arm/mach-at91/at572d940hf.c
> index cbf6e5b..461735c 100644
> --- a/arch/arm/mach-at91/at572d940hf.c
> +++ b/arch/arm/mach-at91/at572d940hf.c
> @@ -365,11 +365,13 @@ static unsigned int at572d940hf_default_irq_priority[NR_AIC_IRQS] __initdata = {
>  
>  void __init at572d940hf_init_interrupts(unsigned int priority[NR_AIC_IRQS])
>  {
> +	void __iomem* aic = (void __iomem *)AT91_VA_BASE_SYS + AT572D940HF_AIC;
> +
>  	if (!priority)
>  		priority = at572d940hf_default_irq_priority;
>  
>  	/* Initialize the AIC interrupt controller */
> -	at91_aic_init(priority);
> +	at91_aic_init(aic, priority);
>  
>  	/* Enable GPIO interrupts */
>  	at91_gpio_irq_setup();
> diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
> index 09e0354..ea2d820 100644
> --- a/arch/arm/mach-at91/at91cap9.c
> +++ b/arch/arm/mach-at91/at91cap9.c
> @@ -372,11 +372,13 @@ static unsigned int at91cap9_default_irq_priority[NR_AIC_IRQS] __initdata = {
>  
>  void __init at91cap9_init_interrupts(unsigned int priority[NR_AIC_IRQS])
>  {
> +	void __iomem* aic = (void __iomem *)AT91_VA_BASE_SYS + AT91CAP9_AIC;
> +
>  	if (!priority)
>  		priority = at91cap9_default_irq_priority;
>  
>  	/* Initialize the AIC interrupt controller */
> -	at91_aic_init(priority);
> +	at91_aic_init(aic, priority);
>  
>  	/* Enable GPIO interrupts */
>  	at91_gpio_irq_setup();
> diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
> index 428584f..efb081f 100644
> --- a/arch/arm/mach-at91/at91rm9200.c
> +++ b/arch/arm/mach-at91/at91rm9200.c
> @@ -336,11 +336,13 @@ static unsigned int at91rm9200_default_irq_priority[NR_AIC_IRQS] __initdata = {
>  
>  void __init at91rm9200_init_interrupts(unsigned int priority[NR_AIC_IRQS])
>  {
> +	void __iomem* aic = (void __iomem *)AT91_VA_BASE_SYS + AT91RM9200_AIC;
> +
>  	if (!priority)
>  		priority = at91rm9200_default_irq_priority;
>  
>  	/* Initialize the AIC interrupt controller */
> -	at91_aic_init(priority);
> +	at91_aic_init(aic, priority);
>  
>  	/* Enable GPIO interrupts */
>  	at91_gpio_irq_setup();
> diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
> index 24e0c84..741a2b5 100644
> --- a/arch/arm/mach-at91/at91sam9260.c
> +++ b/arch/arm/mach-at91/at91sam9260.c
> @@ -379,11 +379,13 @@ static unsigned int at91sam9260_default_irq_priority[NR_AIC_IRQS] __initdata = {
>  
>  void __init at91sam9260_init_interrupts(unsigned int priority[NR_AIC_IRQS])
>  {
> +	void __iomem* aic = (void __iomem *)AT91_VA_BASE_SYS + AT91SAM9260_AIC;
> +
>  	if (!priority)
>  		priority = at91sam9260_default_irq_priority;
>  
>  	/* Initialize the AIC interrupt controller */
> -	at91_aic_init(priority);
> +	at91_aic_init(aic, priority);
>  
>  	/* Enable GPIO interrupts */
>  	at91_gpio_irq_setup();
> diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
> index 7e6973e..192f983 100644
> --- a/arch/arm/mach-at91/at91sam9261.c
> +++ b/arch/arm/mach-at91/at91sam9261.c
> @@ -337,11 +337,13 @@ static unsigned int at91sam9261_default_irq_priority[NR_AIC_IRQS] __initdata = {
>  
>  void __init at91sam9261_init_interrupts(unsigned int priority[NR_AIC_IRQS])
>  {
> +	void __iomem* aic = (void __iomem *)AT91_VA_BASE_SYS + AT91SAM9261_AIC;
> +
>  	if (!priority)
>  		priority = at91sam9261_default_irq_priority;
>  
>  	/* Initialize the AIC interrupt controller */
> -	at91_aic_init(priority);
> +	at91_aic_init(aic, priority);
>  
>  	/* Enable GPIO interrupts */
>  	at91_gpio_irq_setup();
> diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
> index ddc172d..a9b3687 100644
> --- a/arch/arm/mach-at91/at91sam9263.c
> +++ b/arch/arm/mach-at91/at91sam9263.c
> @@ -342,11 +342,13 @@ static unsigned int at91sam9263_default_irq_priority[NR_AIC_IRQS] __initdata = {
>  
>  void __init at91sam9263_init_interrupts(unsigned int priority[NR_AIC_IRQS])
>  {
> +	void __iomem* aic = (void __iomem *)AT91_VA_BASE_SYS + AT91SAM9263_AIC;
> +
>  	if (!priority)
>  		priority = at91sam9263_default_irq_priority;
>  
>  	/* Initialize the AIC interrupt controller */
> -	at91_aic_init(priority);
> +	at91_aic_init(aic, priority);
>  
>  	/* Enable GPIO interrupts */
>  	at91_gpio_irq_setup();
> diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
> index c2ef6a4..7342c9b 100644
> --- a/arch/arm/mach-at91/at91sam9g45.c
> +++ b/arch/arm/mach-at91/at91sam9g45.c
> @@ -369,11 +369,13 @@ static unsigned int at91sam9g45_default_irq_priority[NR_AIC_IRQS] __initdata = {
>  
>  void __init at91sam9g45_init_interrupts(unsigned int priority[NR_AIC_IRQS])
>  {
> +	void __iomem* aic = (void __iomem *)AT91_VA_BASE_SYS + AT91SAM9G45_AIC;
> +
>  	if (!priority)
>  		priority = at91sam9g45_default_irq_priority;
>  
>  	/* Initialize the AIC interrupt controller */
> -	at91_aic_init(priority);
> +	at91_aic_init(aic, priority);
>  
>  	/* Enable GPIO interrupts */
>  	at91_gpio_irq_setup();
> diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
> index d0c1506..cdd3eab 100644
> --- a/arch/arm/mach-at91/at91sam9rl.c
> +++ b/arch/arm/mach-at91/at91sam9rl.c
> @@ -332,11 +332,13 @@ static unsigned int at91sam9rl_default_irq_priority[NR_AIC_IRQS] __initdata = {
>  
>  void __init at91sam9rl_init_interrupts(unsigned int priority[NR_AIC_IRQS])
>  {
> +	void __iomem* aic = (void __iomem *)AT91_VA_BASE_SYS + AT91SAM9RL_AIC;
> +
>  	if (!priority)
>  		priority = at91sam9rl_default_irq_priority;
>  
>  	/* Initialize the AIC interrupt controller */
> -	at91_aic_init(priority);
> +	at91_aic_init(aic, priority);
>  
>  	/* Enable GPIO interrupts */
>  	at91_gpio_irq_setup();
> diff --git a/arch/arm/mach-at91/at91x40.c b/arch/arm/mach-at91/at91x40.c
> index ad3ec85..4cf8444 100644
> --- a/arch/arm/mach-at91/at91x40.c
> +++ b/arch/arm/mach-at91/at91x40.c
> @@ -75,9 +75,11 @@ static unsigned int at91x40_default_irq_priority[NR_AIC_IRQS] __initdata = {
>  
>  void __init at91x40_init_interrupts(unsigned int priority[NR_AIC_IRQS])
>  {
> +	void __iomem* aic = (void __iomem *)AT91_VA_BASE_SYS + AT91X40_AIC;
> +
>  	if (!priority)
>  		priority = at91x40_default_irq_priority;
>  
> -	at91_aic_init(priority);
> +	at91_aic_init(aic, priority);
>  }
>  
> diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
> index ccbe6cb..f00ad37 100644
> --- a/arch/arm/mach-at91/generic.h
> +++ b/arch/arm/mach-at91/generic.h
> @@ -29,7 +29,7 @@ extern void __init at91sam9g45_init_interrupts(unsigned int priority[]);
>  extern void __init at91x40_init_interrupts(unsigned int priority[]);
>  extern void __init at91cap9_init_interrupts(unsigned int priority[]);
>  extern void __init at572d940hf_init_interrupts(unsigned int priority[]);
> -extern void __init at91_aic_init(unsigned int priority[]);
> +extern void __init at91_aic_init(void __iomem* regbase, unsigned int priority[]);
>  
>   /* Timer */
>  struct sys_timer;
> diff --git a/arch/arm/mach-at91/include/mach/at572d940hf.h b/arch/arm/mach-at91/include/mach/at572d940hf.h
> index fc97be0..c258e4d 100644
> --- a/arch/arm/mach-at91/include/mach/at572d940hf.h
> +++ b/arch/arm/mach-at91/include/mach/at572d940hf.h
> @@ -92,7 +92,7 @@
>  #define AT91_SDRAMC0	(0xffffea00 - AT91_BASE_SYS)
>  #define AT91_SMC	(0xffffec00 - AT91_BASE_SYS)
>  #define AT91_MATRIX	(0xffffee00 - AT91_BASE_SYS)
> -#define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
> +#define AT572D940HF_AIC		(0xfffff000 - AT91_BASE_SYS)
>  #define AT572D940HF_DBGU	(0xfffff200 - AT91_BASE_SYS)
>  #define AT572D940HF_PIOA	(0xfffff400 - AT91_BASE_SYS)
>  #define AT572D940HF_PIOB	(0xfffff600 - AT91_BASE_SYS)
> diff --git a/arch/arm/mach-at91/include/mach/at91_aic.h b/arch/arm/mach-at91/include/mach/at91_aic.h
> index 0356679..5001021 100644
> --- a/arch/arm/mach-at91/include/mach/at91_aic.h
> +++ b/arch/arm/mach-at91/include/mach/at91_aic.h
> @@ -16,7 +16,7 @@
>  #ifndef AT91_AIC_H
>  #define AT91_AIC_H
>  
> -#define AT91_AIC_SMR(n)		(AT91_AIC + ((n) * 4))	/* Source Mode Registers 0-31 */
> +#define AT91_AIC_SMR(n)		(0x00 + ((n) * 4))	/* Source Mode Registers 0-31 */
>  #define		AT91_AIC_PRIOR		(7 << 0)		/* Priority Level */
>  #define		AT91_AIC_SRCTYPE	(3 << 5)		/* Interrupt Source Type */
>  #define			AT91_AIC_SRCTYPE_LOW		(0 << 5)
> @@ -24,30 +24,30 @@
>  #define			AT91_AIC_SRCTYPE_HIGH		(2 << 5)
>  #define			AT91_AIC_SRCTYPE_RISING		(3 << 5)
>  
> -#define AT91_AIC_SVR(n)		(AT91_AIC + 0x80 + ((n) * 4))	/* Source Vector Registers 0-31 */
> -#define AT91_AIC_IVR		(AT91_AIC + 0x100)	/* Interrupt Vector Register */
> -#define AT91_AIC_FVR		(AT91_AIC + 0x104)	/* Fast Interrupt Vector Register */
> -#define AT91_AIC_ISR		(AT91_AIC + 0x108)	/* Interrupt Status Register */
> +#define AT91_AIC_SVR(n)		(0x80 + ((n) * 4))	/* Source Vector Registers 0-31 */
> +#define AT91_AIC_IVR		0x100			/* Interrupt Vector Register */
> +#define AT91_AIC_FVR		0x104			/* Fast Interrupt Vector Register */
> +#define AT91_AIC_ISR		0x108			/* Interrupt Status Register */
>  #define		AT91_AIC_IRQID		(0x1f << 0)		/* Current Interrupt Identifier */
>  
> -#define AT91_AIC_IPR		(AT91_AIC + 0x10c)	/* Interrupt Pending Register */
> -#define AT91_AIC_IMR		(AT91_AIC + 0x110)	/* Interrupt Mask Register */
> -#define AT91_AIC_CISR		(AT91_AIC + 0x114)	/* Core Interrupt Status Register */
> +#define AT91_AIC_IPR		0x10c			/* Interrupt Pending Register */
> +#define AT91_AIC_IMR		0x110			/* Interrupt Mask Register */
> +#define AT91_AIC_CISR		0x114			/* Core Interrupt Status Register */
>  #define		AT91_AIC_NFIQ		(1 << 0)		/* nFIQ Status */
>  #define		AT91_AIC_NIRQ		(1 << 1)		/* nIRQ Status */
>  
> -#define AT91_AIC_IECR		(AT91_AIC + 0x120)	/* Interrupt Enable Command Register */
> -#define AT91_AIC_IDCR		(AT91_AIC + 0x124)	/* Interrupt Disable Command Register */
> -#define AT91_AIC_ICCR		(AT91_AIC + 0x128)	/* Interrupt Clear Command Register */
> -#define AT91_AIC_ISCR		(AT91_AIC + 0x12c)	/* Interrupt Set Command Register */
> -#define AT91_AIC_EOICR		(AT91_AIC + 0x130)	/* End of Interrupt Command Register */
> -#define AT91_AIC_SPU		(AT91_AIC + 0x134)	/* Spurious Interrupt Vector Register */
> -#define AT91_AIC_DCR		(AT91_AIC + 0x138)	/* Debug Control Register */
> +#define AT91_AIC_IECR		0x120			/* Interrupt Enable Command Register */
> +#define AT91_AIC_IDCR		0x124			/* Interrupt Disable Command Register */
> +#define AT91_AIC_ICCR		0x128			/* Interrupt Clear Command Register */
> +#define AT91_AIC_ISCR		0x12c			/* Interrupt Set Command Register */
> +#define AT91_AIC_EOICR		0x130			/* End of Interrupt Command Register */
> +#define AT91_AIC_SPU		0x134			/* Spurious Interrupt Vector Register */
> +#define AT91_AIC_DCR		0x138			/* Debug Control Register */
>  #define		AT91_AIC_DCR_PROT	(1 << 0)		/* Protection Mode */
>  #define		AT91_AIC_DCR_GMSK	(1 << 1)		/* General Mask */
>  
> -#define AT91_AIC_FFER		(AT91_AIC + 0x140)	/* Fast Forcing Enable Register [SAM9 only] */
> -#define AT91_AIC_FFDR		(AT91_AIC + 0x144)	/* Fast Forcing Disable Register [SAM9 only] */
> -#define AT91_AIC_FFSR		(AT91_AIC + 0x148)	/* Fast Forcing Status Register [SAM9 only] */
> +#define AT91_AIC_FFER		0x140			/* Fast Forcing Enable Register [SAM9 only] */
> +#define AT91_AIC_FFDR		0x144			/* Fast Forcing Disable Register [SAM9 only] */
> +#define AT91_AIC_FFSR		0x148			/* Fast Forcing Status Register [SAM9 only] */
>  
>  #endif
> diff --git a/arch/arm/mach-at91/include/mach/at91cap9.h b/arch/arm/mach-at91/include/mach/at91cap9.h
> index 80566f6..3f9b00c 100644
> --- a/arch/arm/mach-at91/include/mach/at91cap9.h
> +++ b/arch/arm/mach-at91/include/mach/at91cap9.h
> @@ -90,7 +90,7 @@
>  #define AT91CAP9_CCFG	(0xffffeb10 - AT91_BASE_SYS)
>  #define AT91CAP9_DMA	(0xffffec00 - AT91_BASE_SYS)
>  #define AT91CAP9_DBGU	(0xffffee00 - AT91_BASE_SYS)
> -#define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
> +#define AT91CAP9_AIC	(0xfffff000 - AT91_BASE_SYS)
>  #define AT91CAP9_PIOA	(0xfffff200 - AT91_BASE_SYS)
>  #define AT91CAP9_PIOB	(0xfffff400 - AT91_BASE_SYS)
>  #define AT91CAP9_PIOC	(0xfffff600 - AT91_BASE_SYS)
> diff --git a/arch/arm/mach-at91/include/mach/at91rm9200.h b/arch/arm/mach-at91/include/mach/at91rm9200.h
> index f6eec4f..0da806f 100644
> --- a/arch/arm/mach-at91/include/mach/at91rm9200.h
> +++ b/arch/arm/mach-at91/include/mach/at91rm9200.h
> @@ -82,7 +82,7 @@
>  /*
>   * System Peripherals (offset from AT91_BASE_SYS)
>   */
> -#define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)	/* Advanced Interrupt Controller */
> +#define AT91RM9200_AIC	(0xfffff000 - AT91_BASE_SYS)	/* Advanced Interrupt Controller */
>  #define AT91RM9200_DBGU	(0xfffff200 - AT91_BASE_SYS)	/* Debug Unit */
>  #define AT91RM9200_PIOA	(0xfffff400 - AT91_BASE_SYS)	/* PIO Controller A */
>  #define AT91RM9200_PIOB	(0xfffff600 - AT91_BASE_SYS)	/* PIO Controller B */
> diff --git a/arch/arm/mach-at91/include/mach/at91sam9260.h b/arch/arm/mach-at91/include/mach/at91sam9260.h
> index 11a7920..c37b67e 100644
> --- a/arch/arm/mach-at91/include/mach/at91sam9260.h
> +++ b/arch/arm/mach-at91/include/mach/at91sam9260.h
> @@ -88,7 +88,7 @@
>  #define AT91_SMC	(0xffffec00 - AT91_BASE_SYS)
>  #define AT91_MATRIX	(0xffffee00 - AT91_BASE_SYS)
>  #define AT91SAM9260_CCFG	(0xffffef10 - AT91_BASE_SYS)
> -#define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
> +#define AT91SAM9260_AIC		(0xfffff000 - AT91_BASE_SYS)
>  #define AT91SAM9260_DBGU	(0xfffff200 - AT91_BASE_SYS)
>  #define AT91SAM9260_PIOA	(0xfffff400 - AT91_BASE_SYS)
>  #define AT91SAM9260_PIOB	(0xfffff600 - AT91_BASE_SYS)
> diff --git a/arch/arm/mach-at91/include/mach/at91sam9261.h b/arch/arm/mach-at91/include/mach/at91sam9261.h
> index 10565f3..aebd964 100644
> --- a/arch/arm/mach-at91/include/mach/at91sam9261.h
> +++ b/arch/arm/mach-at91/include/mach/at91sam9261.h
> @@ -71,7 +71,7 @@
>  #define AT91_SDRAMC0	(0xffffea00 - AT91_BASE_SYS)
>  #define AT91_SMC	(0xffffec00 - AT91_BASE_SYS)
>  #define AT91_MATRIX	(0xffffee00 - AT91_BASE_SYS)
> -#define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
> +#define AT91SAM9261_AIC		(0xfffff000 - AT91_BASE_SYS)
>  #define AT91SAM9261_DBGU	(0xfffff200 - AT91_BASE_SYS)
>  #define AT91SAM9261_PIOA	(0xfffff400 - AT91_BASE_SYS)
>  #define AT91SAM9261_PIOB	(0xfffff600 - AT91_BASE_SYS)
> diff --git a/arch/arm/mach-at91/include/mach/at91sam9263.h b/arch/arm/mach-at91/include/mach/at91sam9263.h
> index 30598de..df10b7e 100644
> --- a/arch/arm/mach-at91/include/mach/at91sam9263.h
> +++ b/arch/arm/mach-at91/include/mach/at91sam9263.h
> @@ -86,7 +86,7 @@
>  #define AT91_MATRIX	(0xffffec00 - AT91_BASE_SYS)
>  #define AT91SAM9263_CCFG	(0xffffed10 - AT91_BASE_SYS)
>  #define AT91SAM9263_DBGU	(0xffffee00 - AT91_BASE_SYS)
> -#define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
> +#define AT91SAM9263_AIC		(0xfffff000 - AT91_BASE_SYS)
>  #define AT91SAM9263_PIOA	(0xfffff200 - AT91_BASE_SYS)
>  #define AT91SAM9263_PIOB	(0xfffff400 - AT91_BASE_SYS)
>  #define AT91SAM9263_PIOC	(0xfffff600 - AT91_BASE_SYS)
> diff --git a/arch/arm/mach-at91/include/mach/at91sam9g45.h b/arch/arm/mach-at91/include/mach/at91sam9g45.h
> index 6e3639e..22fb598 100644
> --- a/arch/arm/mach-at91/include/mach/at91sam9g45.h
> +++ b/arch/arm/mach-at91/include/mach/at91sam9g45.h
> @@ -96,7 +96,7 @@
>  #define AT91_MATRIX	(0xffffea00 - AT91_BASE_SYS)
>  #define AT91SAM9G45_DMA		(0xffffec00 - AT91_BASE_SYS)
>  #define AT91SAM9G45_DBGU	(0xffffee00 - AT91_BASE_SYS)
> -#define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
> +#define AT91SAM9G45_AIC		(0xfffff000 - AT91_BASE_SYS)
>  #define AT91SAM9G45_PIOA	(0xfffff200 - AT91_BASE_SYS)
>  #define AT91SAM9G45_PIOB	(0xfffff400 - AT91_BASE_SYS)
>  #define AT91SAM9G45_PIOC	(0xfffff600 - AT91_BASE_SYS)
> diff --git a/arch/arm/mach-at91/include/mach/at91sam9rl.h b/arch/arm/mach-at91/include/mach/at91sam9rl.h
> index 6d11e5a..7920d96 100644
> --- a/arch/arm/mach-at91/include/mach/at91sam9rl.h
> +++ b/arch/arm/mach-at91/include/mach/at91sam9rl.h
> @@ -78,7 +78,7 @@
>  #define AT91_SMC	(0xffffec00 - AT91_BASE_SYS)
>  #define AT91_MATRIX	(0xffffee00 - AT91_BASE_SYS)
>  #define AT91SAM9RL_CCFG		(0xffffef10 - AT91_BASE_SYS)
> -#define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
> +#define AT91SAM9RL_AIC		(0xfffff000 - AT91_BASE_SYS)
>  #define AT91SAM9RL_DBGU		(0xfffff200 - AT91_BASE_SYS)
>  #define AT91SAM9RL_PIOA		(0xfffff400 - AT91_BASE_SYS)
>  #define AT91SAM9RL_PIOB		(0xfffff600 - AT91_BASE_SYS)
> diff --git a/arch/arm/mach-at91/include/mach/at91x40.h b/arch/arm/mach-at91/include/mach/at91x40.h
> index a93d473..07e4f6e 100644
> --- a/arch/arm/mach-at91/include/mach/at91x40.h
> +++ b/arch/arm/mach-at91/include/mach/at91x40.h
> @@ -42,7 +42,7 @@
>  #define AT91X40_PIOA	(0xffff0000 - AT91_BASE_SYS)	/* PIO Controller A */
>  #define AT91X40_PS	(0xffff4000 - AT91_BASE_SYS)	/* Power Save */
>  #define AT91X40_WD	(0xffff8000 - AT91_BASE_SYS)	/* Watchdog Timer */
> -#define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)	/* Advanced Interrupt Controller */
> +#define AT91X40_AIC	(0xfffff000 - AT91_BASE_SYS)	/* Advanced Interrupt Controller */
>  
>  /*
>   * The AT91x40 series doesn't have a debug unit like the other AT91 parts.
> diff --git a/arch/arm/mach-at91/include/mach/entry-macro.S b/arch/arm/mach-at91/include/mach/entry-macro.S
> index 7ab68f9..ed46ba5 100644
> --- a/arch/arm/mach-at91/include/mach/entry-macro.S
> +++ b/arch/arm/mach-at91/include/mach/entry-macro.S
> @@ -17,16 +17,17 @@
>  	.endm
>  
>  	.macro  get_irqnr_preamble, base, tmp
> -	ldr	\base, =(AT91_VA_BASE_SYS + AT91_AIC)		@ base virtual address of AIC peripheral
> +	ldr	\base, =at91_aic_base_addr		@ base virtual address of AIC peripheral
> +	ldr	\base, [\base]
>  	.endm
>  
>  	.macro  arch_ret_to_user, tmp1, tmp2
>  	.endm
>  
>  	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
> -	ldr	\irqnr, [\base, #(AT91_AIC_IVR - AT91_AIC)]	@ read IRQ vector register: de-asserts nIRQ to processor (and clears interrupt)
> -	ldr	\irqstat, [\base, #(AT91_AIC_ISR - AT91_AIC)]	@ read interrupt source number
> +	ldr	\irqnr, [\base, #(AT91_AIC_IVR)]	@ read IRQ vector register: de-asserts nIRQ to processor (and clears interrupt)
> +	ldr	\irqstat, [\base, #(AT91_AIC_ISR)]	@ read interrupt source number
>  	teq	\irqstat, #0					@ ISR is 0 when no current interrupt, or spurious interrupt
> -	streq	\tmp, [\base, #(AT91_AIC_EOICR - AT91_AIC)]	@ not going to be handled further, then ACK it now.
> +	streq	\tmp, [\base, #(AT91_AIC_EOICR)]	@ not going to be handled further, then ACK it now.
>  	.endm
>  
> diff --git a/arch/arm/mach-at91/include/mach/irqs.h b/arch/arm/mach-at91/include/mach/irqs.h
> index 2d510ee..c3d3330 100644
> --- a/arch/arm/mach-at91/include/mach/irqs.h
> +++ b/arch/arm/mach-at91/include/mach/irqs.h
> @@ -21,7 +21,6 @@
>  #ifndef __ASM_ARCH_IRQS_H
>  #define __ASM_ARCH_IRQS_H
>  
> -#include <linux/io.h>
>  #include <mach/at91_aic.h>
>  
>  #define NR_AIC_IRQS 32
> diff --git a/arch/arm/mach-at91/irq.c b/arch/arm/mach-at91/irq.c
> index aff808b..8b04b3c 100644
> --- a/arch/arm/mach-at91/irq.c
> +++ b/arch/arm/mach-at91/irq.c
> @@ -33,23 +33,26 @@
>  #include <asm/mach/irq.h>
>  #include <asm/mach/map.h>
>  
> +/* Base IO address of AIC */
> +void __iomem *at91_aic_base_addr __read_mostly;
> +
>  
>  static void at91_aic_mask_irq(struct irq_data *d)
>  {
>  	/* Disable interrupt on AIC */
> -	at91_sys_write(AT91_AIC_IDCR, 1 << d->irq);
> +	__raw_writel(1 << d->irq, at91_aic_base_addr + AT91_AIC_IDCR);
>  }
>  
>  static void at91_aic_unmask_irq(struct irq_data *d)
>  {
>  	/* Enable interrupt on AIC */
> -	at91_sys_write(AT91_AIC_IECR, 1 << d->irq);
> +	__raw_writel(1 << d->irq, at91_aic_base_addr + AT91_AIC_IECR);
>  }
>  
>  static void at91_aic_eoi(struct irq_data *d)
>  {
>  	/* Acknowledge with AIC after interrupt has been handled */
> -	at91_sys_write(AT91_AIC_EOICR, 0);	
> +	__raw_writel(0, at91_aic_base_addr + AT91_AIC_EOICR);
>  }
>  
>  unsigned int at91_extern_irq;
> @@ -83,8 +86,8 @@ static int at91_aic_set_type(struct irq_data *d, unsigned type)
>  		return -EINVAL;
>  	}
>  
> -	smr = at91_sys_read(AT91_AIC_SMR(d->irq)) & ~AT91_AIC_SRCTYPE;
> -	at91_sys_write(AT91_AIC_SMR(d->irq), smr | srctype);
> +	smr = __raw_readl(at91_aic_base_addr + AT91_AIC_SMR(d->irq)) & ~AT91_AIC_SRCTYPE;
> +	__raw_writel(smr | srctype, at91_aic_base_addr + AT91_AIC_SMR(d->irq));
>  	return 0;
>  }
>  
> @@ -108,15 +111,15 @@ static int at91_aic_set_wake(struct irq_data *d, unsigned value)
>  
>  void at91_irq_suspend(void)
>  {
> -	backups = at91_sys_read(AT91_AIC_IMR);
> -	at91_sys_write(AT91_AIC_IDCR, backups);
> -	at91_sys_write(AT91_AIC_IECR, wakeups);
> +	backups = __raw_readl(at91_aic_base_addr + AT91_AIC_IMR);
> +	__raw_writel(backups, at91_aic_base_addr + AT91_AIC_IDCR);
> +	__raw_writel(wakeups, at91_aic_base_addr + AT91_AIC_IECR);
>  }
>  
>  void at91_irq_resume(void)
>  {
> -	at91_sys_write(AT91_AIC_IDCR, wakeups);
> -	at91_sys_write(AT91_AIC_IECR, backups);
> +	__raw_writel(wakeups, at91_aic_base_addr + AT91_AIC_IDCR);
> +	__raw_writel(backups, at91_aic_base_addr + AT91_AIC_IECR);
>  }
>  
>  #else
> @@ -133,41 +136,45 @@ static struct irq_chip at91_aic_chip = {
>  	.irq_set_wake	= at91_aic_set_wake,
>  };
>  
> +
>  /*
>   * Initialize the AIC interrupt controller.
>   */
> -void __init at91_aic_init(unsigned int priority[NR_AIC_IRQS])
> +void __init at91_aic_init(void __iomem *regbase, unsigned int priority[NR_AIC_IRQS])
>  {
>  	unsigned int i;
>  
> +	/* Store base-address */
> +	at91_aic_base_addr = regbase;
> +
>  	/*
>  	 * The IVR is used by macro get_irqnr_and_base to read and verify.
>  	 * The irq number is NR_AIC_IRQS when a spurious interrupt has occurred.
>  	 */
>  	for (i = 0; i < NR_AIC_IRQS; i++) {
>  		/* Put irq number in Source Vector Register: */
> -		at91_sys_write(AT91_AIC_SVR(i), i);
> +		__raw_writel(i, at91_aic_base_addr + AT91_AIC_SVR(i));
>  		/* Active Low interrupt, with the specified priority */
> -		at91_sys_write(AT91_AIC_SMR(i), AT91_AIC_SRCTYPE_LOW | priority[i]);
> +		__raw_writel(AT91_AIC_SRCTYPE_LOW | priority[i], at91_aic_base_addr + AT91_AIC_SMR(i));
>  
>  		irq_set_chip_and_handler(i, &at91_aic_chip, handle_fasteoi_irq);
>  		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
>  
>  		/* Perform 8 End Of Interrupt Command to make sure AIC will not Lock out nIRQ */
>  		if (i < 8)
> -			at91_sys_write(AT91_AIC_EOICR, 0);
> +			__raw_writel(0, at91_aic_base_addr + AT91_AIC_EOICR);
>  	}
>  
>  	/*
>  	 * Spurious Interrupt ID in Spurious Vector Register is NR_AIC_IRQS
>  	 * When there is no current interrupt, the IRQ Vector Register reads the value stored in AIC_SPU
>  	 */
> -	at91_sys_write(AT91_AIC_SPU, NR_AIC_IRQS);
> +	__raw_writel(NR_AIC_IRQS, at91_aic_base_addr + AT91_AIC_SPU);
>  
>  	/* No debugging in AIC: Debug (Protect) Control Register */
> -	at91_sys_write(AT91_AIC_DCR, 0);
> +	__raw_writel(0, at91_aic_base_addr + AT91_AIC_DCR);
>  
>  	/* Disable and clear all interrupts initially */
> -	at91_sys_write(AT91_AIC_IDCR, 0xFFFFFFFF);
> -	at91_sys_write(AT91_AIC_ICCR, 0xFFFFFFFF);
> +	__raw_writel(0xFFFFFFFF, at91_aic_base_addr + AT91_AIC_IDCR);
> +	__raw_writel(0xFFFFFFFF, at91_aic_base_addr + AT91_AIC_ICCR);
>  }
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index ea53f4d..852c417 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -209,14 +209,14 @@ static int at91_pm_enter(suspend_state_t state)
>  	at91_gpio_suspend();
>  	at91_irq_suspend();
>  
> -	pr_debug("AT91: PM - wake mask %08x, pm state %d\n",
> -			/* remember all the always-wake irqs */
> -			(at91_sys_read(AT91_PMC_PCSR)
> -					| (1 << AT91_ID_FIQ)
> -					| (1 << AT91_ID_SYS)
> -					| (at91_extern_irq))
> -				& at91_sys_read(AT91_AIC_IMR),
> -			state);
> +//	pr_debug("AT91: PM - wake mask %08x, pm state %d\n",
> +//			/* remember all the always-wake irqs */
> +//			(at91_sys_read(AT91_PMC_PCSR)
> +//					| (1 << AT91_ID_FIQ)
> +//					| (1 << AT91_ID_SYS)
> +//					| (at91_extern_irq))
> +//				& at91_sys_read(AT91_AIC_IMR),
> +//			state);
>  
>  	switch (state) {
>  		/*
> @@ -282,8 +282,8 @@ static int at91_pm_enter(suspend_state_t state)
>  			goto error;
>  	}
>  
> -	pr_debug("AT91: PM - wakeup %08x\n",
> -			at91_sys_read(AT91_AIC_IPR) & at91_sys_read(AT91_AIC_IMR));
> +//	pr_debug("AT91: PM - wakeup %08x\n",
> +//			at91_sys_read(AT91_AIC_IPR) & at91_sys_read(AT91_AIC_IMR));
>  
>  error:
>  	target_state = PM_SUSPEND_ON;
> diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
> index 971271c..657820f 100644
> --- a/drivers/rtc/rtc-at91rm9200.c
> +++ b/drivers/rtc/rtc-at91rm9200.c
> @@ -28,6 +28,7 @@
>  #include <linux/ioctl.h>
>  #include <linux/completion.h>
>  #include <linux/slab.h>
> +#include <linux/io.h>
>  
>  #include <asm/uaccess.h>
>  
> 
