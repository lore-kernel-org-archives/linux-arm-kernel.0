From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 05 May 2011 08:40:03 +1200
Subject: AT91: Interrupt handling independent of processor base-address
In-Reply-To: <1304291042.22966.12.camel@redbox>
References: <1304291042.22966.12.camel@redbox>
Message-ID: <4DC1B9A3.7050107@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/02/2011 11:04 AM, Andrew Victor wrote:
> For supporting multiple AT91 processors in a single kernel image, the
> base address of the AIC controller needs to be calculated in the
> processor initialization code and then provided to the AIC driver.
>  * Low-level IRQ hander in entry-macro.S also updated.
>  * AT91_AIC definitions renamed to AT91xxx_AIC.
> 
> All these patches are here:
>  git://github.com/at91linux/linux-2.6-at91.git/av-devel
> 
> Signed-off-by: Andrew Victor <linux@maxim.org.za>

Hi Andrew,

Patch looks good. Just a couple of comments below.

~Ryan

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

Nitpick, should be:

	void __iomem *aic

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

Since we eventually will have a number of these base addresses as
variables is it worth consolidating them into a single struct, i.e:

struct at91_sys {
	void __iomem *aic;
	void __iomem *dbgu;
	void __iomem *pioa;
	...
};

struct at91_sys at91_sys __read_mostly;

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

How come this is commented out? It should either be fixed or removed.

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

Same here.

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
