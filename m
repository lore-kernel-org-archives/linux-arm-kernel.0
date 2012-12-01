From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 1 Dec 2012 08:05:27 -0500
Subject: [PATCH] ARM: ixp4xx: Add "ask" handler for timer interrupts
In-Reply-To: <1354347213-22237-1-git-send-email-shc_work@mail.ru>
References: <1354347213-22237-1-git-send-email-shc_work@mail.ru>
Message-ID: <20121201130527.GD12509@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

On Sat, Dec 01, 2012 at 11:33:33AM +0400, Alexander Shiyan wrote:
> Rather than modify the EOI flags directly in the timer interrupt,
> let's deal with these flags in the "ask" procedure.

Please specify the procedure name instead of "ask", eg ixp4xx_irq_ack().
Same goes for the Subject line.

What brought about this change, is this part of a larger series?

thx,

Jason.

> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/mach-ixp4xx/common.c      |   34 +++++++++++++++++++++++++---------
>  drivers/input/misc/ixp4xx-beeper.c |    3 ---
>  2 files changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
> index 8c0c0e2..27046ec 100644
> --- a/arch/arm/mach-ixp4xx/common.c
> +++ b/arch/arm/mach-ixp4xx/common.c
> @@ -202,10 +202,28 @@ static void ixp4xx_irq_mask(struct irq_data *d)
>  
>  static void ixp4xx_irq_ack(struct irq_data *d)
>  {
> -	int line = (d->irq < 32) ? irq2gpio[d->irq] : -1;
> +	int line;
>  
> -	if (line >= 0)
> -		*IXP4XX_GPIO_GPISR = (1 << line);
> +	switch (d->irq) {
> +	case IRQ_IXP4XX_TIMER1:
> +		*IXP4XX_OSST = IXP4XX_OSST_TIMER_1_PEND;
> +		break;
> +	case IRQ_IXP4XX_TIMER2:
> +		*IXP4XX_OSST = IXP4XX_OSST_TIMER_2_PEND;
> +		break;
> +	case IRQ_IXP4XX_TIMESTAMP:
> +		*IXP4XX_OSST = IXP4XX_OSST_TIMER_TS_PEND;
> +		break;
> +	case IRQ_IXP4XX_WDOG:
> +		*IXP4XX_OSST = IXP4XX_OSST_TIMER_WDOG_PEND;
> +		break;
> +	default:
> +		line = (d->irq < 32) ? irq2gpio[d->irq] : -1;
> +
> +		if (line >= 0)
> +			*IXP4XX_GPIO_GPISR = (1 << line);
> +		break;
> +	}
>  }
>  
>  /*
> @@ -247,6 +265,10 @@ void __init ixp4xx_init_irq(void)
>  	/* Disable all interrupt */
>  	*IXP4XX_ICMR = 0x0; 
>  
> +	/* Clear Timer Pending Interrupts */
> +	*IXP4XX_OSST = IXP4XX_OSST_TIMER_1_PEND | IXP4XX_OSST_TIMER_2_PEND |
> +		       IXP4XX_OSST_TIMER_TS_PEND | IXP4XX_OSST_TIMER_WDOG_PEND;
> +
>  	if (cpu_is_ixp46x() || cpu_is_ixp43x()) {
>  		/* Route upper 32 sources to IRQ instead of FIQ */
>  		*IXP4XX_ICLR2 = 0x00;
> @@ -274,9 +296,6 @@ static irqreturn_t ixp4xx_timer_interrupt(int irq, void *dev_id)
>  {
>  	struct clock_event_device *evt = dev_id;
>  
> -	/* Clear Pending Interrupt by writing '1' to it */
> -	*IXP4XX_OSST = IXP4XX_OSST_TIMER_1_PEND;
> -
>  	evt->event_handler(evt);
>  
>  	return IRQ_HANDLED;
> @@ -294,9 +313,6 @@ void __init ixp4xx_timer_init(void)
>  	/* Reset/disable counter */
>  	*IXP4XX_OSRT1 = 0;
>  
> -	/* Clear Pending Interrupt by writing '1' to it */
> -	*IXP4XX_OSST = IXP4XX_OSST_TIMER_1_PEND;
> -
>  	/* Reset time-stamp counter */
>  	*IXP4XX_OSTS = 0;
>  
> diff --git a/drivers/input/misc/ixp4xx-beeper.c b/drivers/input/misc/ixp4xx-beeper.c
> index 6ab3dec..2923e47 100644
> --- a/drivers/input/misc/ixp4xx-beeper.c
> +++ b/drivers/input/misc/ixp4xx-beeper.c
> @@ -78,9 +78,6 @@ static int ixp4xx_spkr_event(struct input_dev *dev, unsigned int type, unsigned
>  
>  static irqreturn_t ixp4xx_spkr_interrupt(int irq, void *dev_id)
>  {
> -	/* clear interrupt */
> -	*IXP4XX_OSST = IXP4XX_OSST_TIMER_2_PEND;
> -
>  	/* flip the beeper output */
>  	*IXP4XX_GPIO_GPOUTR ^= (1 << (unsigned int) dev_id);
>  
> -- 
> 1.7.8.6
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
