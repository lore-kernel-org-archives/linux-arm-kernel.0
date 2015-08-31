From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 31 Aug 2015 12:03:42 +0300
Subject: [PATCH] gpio: omap: Fix gpiochip_add() handling for deferred probe
In-Reply-To: <1440787489-15992-1-git-send-email-tony@atomide.com>
References: <1440787489-15992-1-git-send-email-tony@atomide.com>
Message-ID: <55E4186E.7090605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 08/28/2015 09:44 PM, Tony Lindgren wrote:
> Currently we gpio-omap breaks if gpiochip_add() returns -EPROBE_DEFER:
>
> [    0.570000] gpiochip_add: GPIOs 0..31 (gpio) failed to register
> [    0.570000] omap_gpio 48310000.gpio: Could not register gpio chip -517
> ...
> [    3.670000] omap_gpio 48310000.gpio: Unbalanced pm_runtime_enable!

I have no objection to the patch itself.

But I curious, How have you got this error output? Was it simulated?

>
> Let's fix the issue by adding the missing pm_runtime_put() on error.
>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>   drivers/gpio/gpio-omap.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index b0c57d5..f09bf0b 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1232,8 +1232,11 @@ static int omap_gpio_probe(struct platform_device *pdev)
>   	omap_gpio_mod_init(bank);
>
>   	ret = omap_gpio_chip_init(bank, irqc);
> -	if (ret)
> +	if (ret) {
> +		pm_runtime_put_sync(bank->dev);
> +		pm_runtime_disable(bank->dev);
>   		return ret;
> +	}
>
>   	omap_gpio_show_rev(bank);
>
>


-- 
regards,
-grygorii
