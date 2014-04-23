From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 23 Apr 2014 13:25:21 +0200
Subject: [PATCH v2 22/38] ARM: orion: switch to a per-platform handle_irq()
 function
In-Reply-To: <1398202002-28530-23-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1398202002-28530-23-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5357A321.8090904@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2014 11:26 PM, Thomas Petazzoni wrote:
> Moving to the Device Tree implies having CONFIG_MULTI_IRQ_HANDLER
> enabled, even for non-DT platforms (if we want both DT and non-DT
> platforms to be supported in a single kernel).
>
> However, the common CONFIG_MULTI_IRQ_HANDLER handler for non-DT
> platforms in plat-orion/irq.c doesn't match the needs of
> Orion5x. Also, it doesn't make much sense for orion_irq_init() to
> register the multi-IRQ handler: orion_irq_init() is called once for
> each IRQ cause/mask tuple, while the multi-IRQ handler only needs to
> be registered once.
>
> To solve this problem, we move the multi-IRQ handle in per-platform
> code: mach-kirkwood/irq.c and mach-dove/irq.c. The Orion5x variant
> will be introduced in a followup commit. Of course, this code will
> ultimately be completely removed once all boards are converted to the
> Device Tree.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

I definitely agree on this, as you made clear that this temporary
solution will ease removing plat-orion later.

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> ---
>   arch/arm/mach-dove/irq.c     | 36 +++++++++++++++++++++++++++++++++++
>   arch/arm/mach-kirkwood/irq.c | 36 +++++++++++++++++++++++++++++++++++
>   arch/arm/plat-orion/irq.c    | 45 --------------------------------------------
>   3 files changed, 72 insertions(+), 45 deletions(-)
>
> diff --git a/arch/arm/mach-dove/irq.c b/arch/arm/mach-dove/irq.c
> index bc4344a..4a5a7ae 100644
> --- a/arch/arm/mach-dove/irq.c
> +++ b/arch/arm/mach-dove/irq.c
> @@ -108,6 +108,38 @@ static int __initdata gpio2_irqs[4] = {
>   	0,
>   };
>
> +#ifdef CONFIG_MULTI_IRQ_HANDLER
> +/*
> + * Compiling with both non-DT and DT support enabled, will
> + * break asm irq handler used by non-DT boards. Therefore,
> + * we provide a C-style irq handler even for non-DT boards,
> + * if MULTI_IRQ_HANDLER is set.
> + */
> +
> +static void __iomem *dove_irq_base = IRQ_VIRT_BASE;
> +
> +static asmlinkage void
> +__exception_irq_entry dove_legacy_handle_irq(struct pt_regs *regs)
> +{
> +	u32 stat;
> +
> +	stat = readl_relaxed(dove_irq_base + IRQ_CAUSE_LOW_OFF);
> +	stat &= readl_relaxed(dove_irq_base + IRQ_MASK_LOW_OFF);
> +	if (stat) {
> +		unsigned int hwirq = __fls(stat);
> +		handle_IRQ(hwirq, regs);
> +		return;
> +	}
> +	stat = readl_relaxed(dove_irq_base + IRQ_CAUSE_HIGH_OFF);
> +	stat &= readl_relaxed(dove_irq_base + IRQ_MASK_HIGH_OFF);
> +	if (stat) {
> +		unsigned int hwirq = 32 + __fls(stat);
> +		handle_IRQ(hwirq, regs);
> +		return;
> +	}
> +}
> +#endif
> +
>   void __init dove_init_irq(void)
>   {
>   	int i;
> @@ -115,6 +147,10 @@ void __init dove_init_irq(void)
>   	orion_irq_init(0, IRQ_VIRT_BASE + IRQ_MASK_LOW_OFF);
>   	orion_irq_init(32, IRQ_VIRT_BASE + IRQ_MASK_HIGH_OFF);
>
> +#ifdef CONFIG_MULTI_IRQ_HANDLER
> +	set_handle_irq(dove_legacy_handle_irq);
> +#endif
> +
>   	/*
>   	 * Initialize gpiolib for GPIOs 0-71.
>   	 */
> diff --git a/arch/arm/mach-kirkwood/irq.c b/arch/arm/mach-kirkwood/irq.c
> index 2a97a2e..c9dd860 100644
> --- a/arch/arm/mach-kirkwood/irq.c
> +++ b/arch/arm/mach-kirkwood/irq.c
> @@ -30,11 +30,47 @@ static int __initdata gpio1_irqs[4] = {
>   	0,
>   };
>
> +#ifdef CONFIG_MULTI_IRQ_HANDLER
> +/*
> + * Compiling with both non-DT and DT support enabled, will
> + * break asm irq handler used by non-DT boards. Therefore,
> + * we provide a C-style irq handler even for non-DT boards,
> + * if MULTI_IRQ_HANDLER is set.
> + */
> +
> +static void __iomem *kirkwood_irq_base = IRQ_VIRT_BASE;
> +
> +asmlinkage void
> +__exception_irq_entry kirkwood_legacy_handle_irq(struct pt_regs *regs)
> +{
> +	u32 stat;
> +
> +	stat = readl_relaxed(kirkwood_irq_base + IRQ_CAUSE_LOW_OFF);
> +	stat &= readl_relaxed(kirkwood_irq_base + IRQ_MASK_LOW_OFF);
> +	if (stat) {
> +		unsigned int hwirq = __fls(stat);
> +		handle_IRQ(hwirq, regs);
> +		return;
> +	}
> +	stat = readl_relaxed(kirkwood_irq_base + IRQ_CAUSE_HIGH_OFF);
> +	stat &= readl_relaxed(kirkwood_irq_base + IRQ_MASK_HIGH_OFF);
> +	if (stat) {
> +		unsigned int hwirq = 32 + __fls(stat);
> +		handle_IRQ(hwirq, regs);
> +		return;
> +	}
> +}
> +#endif
> +
>   void __init kirkwood_init_irq(void)
>   {
>   	orion_irq_init(0, IRQ_VIRT_BASE + IRQ_MASK_LOW_OFF);
>   	orion_irq_init(32, IRQ_VIRT_BASE + IRQ_MASK_HIGH_OFF);
>
> +#ifdef CONFIG_MULTI_IRQ_HANDLER
> +	set_handle_irq(kirkwood_legacy_handle_irq);
> +#endif
> +
>   	/*
>   	 * Initialize gpiolib for GPIOs 0-49.
>   	 */
> diff --git a/arch/arm/plat-orion/irq.c b/arch/arm/plat-orion/irq.c
> index 807df14..27ec18b 100644
> --- a/arch/arm/plat-orion/irq.c
> +++ b/arch/arm/plat-orion/irq.c
> @@ -20,47 +20,6 @@
>   #include <plat/orion-gpio.h>
>   #include <mach/bridge-regs.h>
>
> -#ifdef CONFIG_MULTI_IRQ_HANDLER
> -/*
> - * Compiling with both non-DT and DT support enabled, will
> - * break asm irq handler used by non-DT boards. Therefore,
> - * we provide a C-style irq handler even for non-DT boards,
> - * if MULTI_IRQ_HANDLER is set.
> - *
> - * Notes:
> - * - this is prepared for Kirkwood and Dove only, update
> - *   accordingly if you add Orion5x or MV78x00.
> - * - Orion5x uses different macro names and has only one
> - *   set of CAUSE/MASK registers.
> - * - MV78x00 uses the same macro names but has a third
> - *   set of CAUSE/MASK registers.
> - *
> - */
> -
> -static void __iomem *orion_irq_base = IRQ_VIRT_BASE;
> -
> -asmlinkage void
> -__exception_irq_entry orion_legacy_handle_irq(struct pt_regs *regs)
> -{
> -	u32 stat;
> -
> -	stat = readl_relaxed(orion_irq_base + IRQ_CAUSE_LOW_OFF);
> -	stat &= readl_relaxed(orion_irq_base + IRQ_MASK_LOW_OFF);
> -	if (stat) {
> -		unsigned int hwirq = __fls(stat);
> -		handle_IRQ(hwirq, regs);
> -		return;
> -	}
> -	stat = readl_relaxed(orion_irq_base + IRQ_CAUSE_HIGH_OFF);
> -	stat &= readl_relaxed(orion_irq_base + IRQ_MASK_HIGH_OFF);
> -	if (stat) {
> -		unsigned int hwirq = 32 + __fls(stat);
> -		handle_IRQ(hwirq, regs);
> -		return;
> -	}
> -}
> -#endif
> -
>   void __init orion_irq_init(unsigned int irq_start, void __iomem *maskaddr)
>   {
>   	struct irq_chip_generic *gc;
> @@ -78,10 +37,6 @@ void __init orion_irq_init(unsigned int irq_start, void __iomem *maskaddr)
>   	ct->chip.irq_unmask = irq_gc_mask_set_bit;
>   	irq_setup_generic_chip(gc, IRQ_MSK(32), IRQ_GC_INIT_MASK_CACHE,
>   			       IRQ_NOREQUEST, IRQ_LEVEL | IRQ_NOPROBE);
> -
> -#ifdef CONFIG_MULTI_IRQ_HANDLER
> -	set_handle_irq(orion_legacy_handle_irq);
> -#endif
>   }
>
>   #ifdef CONFIG_OF
>
