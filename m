From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 7 Jun 2012 10:21:35 +0800
Subject: [PATCH] gpio/mxc: make irqs work for fsl,imx21-gpio devices
In-Reply-To: <1338976163-23001-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1338976163-23001-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120607022133.GH2667@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 06, 2012 at 11:49:23AM +0200, Uwe Kleine-K?nig wrote:
> The chained handler was set for the platform device with id == 0.
> When the gpio devices are instantiated by a device tree, all have id ==
> -1 and so the handler was unset resulting in unusable gpio irqs on
> i.MX21 and i.MX27 (when using oftree).
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Hi Uwe,

Thanks for fixing this up. 

Acked-by: Shawn Guo <shawn.guo@linaro.org>

Regards,
Shawn

> ---
> Hello,
> 
> I'm not sure this is material for stable because it never worked before.
> 
> Best regards
> Uwe
> 
>  drivers/gpio/gpio-mxc.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
> index e791476..5c42daf 100644
> --- a/drivers/gpio/gpio-mxc.c
> +++ b/drivers/gpio/gpio-mxc.c
> @@ -398,10 +398,12 @@ static int __devinit mxc_gpio_probe(struct platform_device *pdev)
>  	writel(~0, port->base + GPIO_ISR);
>  
>  	if (mxc_gpio_hwtype == IMX21_GPIO) {
> -		/* setup one handler for all GPIO interrupts */
> -		if (pdev->id == 0)
> -			irq_set_chained_handler(port->irq,
> -						mx2_gpio_irq_handler);
> +		/*
> +		 * Setup one handler for all GPIO interrupts. Actually setting
> +		 * the handler is needed only once, but doing it for every port
> +		 * is more robust and easier.
> +		 */
> +		irq_set_chained_handler(port->irq, mx2_gpio_irq_handler);
>  	} else {
>  		/* setup one handler for each entry */
>  		irq_set_chained_handler(port->irq, mx3_gpio_irq_handler);
> -- 
> 1.7.10
> 
