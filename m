From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 2 May 2013 10:44:44 +0800
Subject: [PATCH] gpio: mxs: Use set and clear capabilities of the gpio
 controller
In-Reply-To: <1367244438-5322-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1367244438-5322-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130502024443.GE3442@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 29, 2013 at 04:07:18PM +0200, Maxime Ripard wrote:
> The current driver doesn't use the set and clear registers found on the
> mxs gpio controller.
> 
> This leads the generic gpio controller to be using some internal value
> to avoid looking up the value stored in the registers, making it behave
> pretty much like a cache.
> 
> This raises some coherency problem when a gpio is not modified by the
> gpio controller, while it can easily be fixed by using the set and clear
> registers.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  drivers/gpio/gpio-mxs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
> index 25000b0..f8e6af2 100644
> --- a/drivers/gpio/gpio-mxs.c
> +++ b/drivers/gpio/gpio-mxs.c
> @@ -326,7 +326,8 @@ static int mxs_gpio_probe(struct platform_device *pdev)
>  
>  	err = bgpio_init(&port->bgc, &pdev->dev, 4,
>  			 port->base + PINCTRL_DIN(port),
> -			 port->base + PINCTRL_DOUT(port), NULL,
> +			 port->base + PINCTRL_DOUT(port) + MXS_SET,
> +			 port->base + PINCTRL_DOUT(port) + MXS_CLR,
>  			 port->base + PINCTRL_DOE(port), NULL, 0);
>  	if (err)
>  		goto out_irqdesc_free;
> -- 
> 1.8.1.2
> 
