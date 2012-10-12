From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 12 Oct 2012 16:23:30 +0200
Subject: [PATCH 1/4] ARM: AT91: Add DT support to AT91RM9200 System Timer
In-Reply-To: <1349993126-9519-1-git-send-email-manabian@gmail.com>
References: <1349993126-9519-1-git-send-email-manabian@gmail.com>
Message-ID: <20121012142330.GD12801@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 00:05 Fri 12 Oct     , Joachim Eastwood wrote:
> Based on AT91 PIT DT patch from Jean-Christophe PLAGNIOL-VILLARD.
ok for this one
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---
>  .../devicetree/bindings/arm/atmel-at91.txt         |  6 +++
>  arch/arm/mach-at91/at91rm9200_time.c               | 63 +++++++++++++++++++++-
>  2 files changed, 67 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
> index ecc81e3..8adc9a8 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
> @@ -7,6 +7,12 @@ PIT Timer required properties:
>  - interrupts: Should contain interrupt for the PIT which is the IRQ line
>    shared across all System Controller members.
>  
> +System Timer (ST) required properties:
> +- compatible: Should be "atmel,at91rm9200-st"
> +- reg: Should contain registers location and length
> +- interrupts: Should contain interrupt for the ST which is the IRQ line
> +  shared across all System Controller members.
> +
>  TC/TCLIB Timer required properties:
>  - compatible: Should be "atmel,<chip>-pit".
>    <chip> can be "at91rm9200" or "at91sam9x5"
> diff --git a/arch/arm/mach-at91/at91rm9200_time.c b/arch/arm/mach-at91/at91rm9200_time.c
> index aaa443b..cafe988 100644
> --- a/arch/arm/mach-at91/at91rm9200_time.c
> +++ b/arch/arm/mach-at91/at91rm9200_time.c
> @@ -24,6 +24,9 @@
>  #include <linux/irq.h>
>  #include <linux/clockchips.h>
>  #include <linux/export.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
>  
>  #include <asm/mach/time.h>
>  
> @@ -91,7 +94,8 @@ static irqreturn_t at91rm9200_timer_interrupt(int irq, void *dev_id)
>  static struct irqaction at91rm9200_timer_irq = {
>  	.name		= "at91_tick",
>  	.flags		= IRQF_SHARED | IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
> -	.handler	= at91rm9200_timer_interrupt
> +	.handler	= at91rm9200_timer_interrupt,
> +	.irq		= NR_IRQS_LEGACY + AT91_ID_SYS,
>  };
>  
>  static cycle_t read_clk32k(struct clocksource *cs)
> @@ -179,8 +183,60 @@ static struct clock_event_device clkevt = {
>  void __iomem *at91_st_base;
>  EXPORT_SYMBOL_GPL(at91_st_base);
>  
> +#ifdef CONFIG_OF
> +static struct of_device_id at91rm9200_st_timer_ids[] = {
> +	{ .compatible = "atmel,at91rm9200-st" },
> +	{ /* sentinel */ }
> +};
> +
> +static int __init of_at91rm9200_st_init(void)
> +{
> +	struct device_node *np;
> +	int ret;
> +
> +	np = of_find_matching_node(NULL, at91rm9200_st_timer_ids);
> +	if (!np)
> +		goto err;
> +
> +	at91_st_base = of_iomap(np, 0);
> +	if (!at91_st_base)
> +		goto node_err;
> +
> +	/* Get the interrupts property */
> +	ret = irq_of_parse_and_map(np, 0);
> +	if (!ret)
> +		goto ioremap_err;
> +	at91rm9200_timer_irq.irq = ret;
> +
> +	of_node_put(np);
> +
> +	return 0;
> +
> +ioremap_err:
> +	iounmap(at91_st_base);
> +node_err:
> +	of_node_put(np);
> +err:
> +	return -EINVAL;
> +}
> +#else
> +static int __init of_at91rm9200_st_init(void)
> +{
> +	return -EINVAL;
> +}
> +#endif
> +
>  void __init at91rm9200_ioremap_st(u32 addr)
>  {
> +#ifdef CONFIG_OF
> +	struct device_node *np;
> +
> +	np = of_find_matching_node(NULL, at91rm9200_st_timer_ids);
> +	if (np) {
> +		of_node_put(np);
> +		return;
> +	}
> +#endif
>  	at91_st_base = ioremap(addr, 256);
>  	if (!at91_st_base)
>  		panic("Impossible to ioremap ST\n");
> @@ -191,13 +247,16 @@ void __init at91rm9200_ioremap_st(u32 addr)
>   */
>  void __init at91rm9200_timer_init(void)
>  {
> +	/* For device tree enabled device: initialize here */
> +	of_at91rm9200_st_init();
> +
>  	/* Disable all timer interrupts, and clear any pending ones */
>  	at91_st_write(AT91_ST_IDR,
>  		AT91_ST_PITS | AT91_ST_WDOVF | AT91_ST_RTTINC | AT91_ST_ALMS);
>  	at91_st_read(AT91_ST_SR);
>  
>  	/* Make IRQs happen for the system timer */
> -	setup_irq(NR_IRQS_LEGACY + AT91_ID_SYS, &at91rm9200_timer_irq);
> +	setup_irq(at91rm9200_timer_irq.irq, &at91rm9200_timer_irq);
>  
>  	/* The 32KiHz "Slow Clock" (tick every 30517.58 nanoseconds) is used
>  	 * directly for the clocksource and all clockevents, after adjusting
> -- 
> 1.7.12.2
> 
