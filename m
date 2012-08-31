From: tony@atomide.com (Tony Lindgren)
Date: Fri, 31 Aug 2012 09:04:04 -0700
Subject: [PATCH 4/5] leds: leds-gpio: adopt pinctrl support
In-Reply-To: <1346405361-29711-5-git-send-email-anilkumar@ti.com>
References: <1346405361-29711-1-git-send-email-anilkumar@ti.com>
 <1346405361-29711-5-git-send-email-anilkumar@ti.com>
Message-ID: <20120831160402.GN1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* AnilKumar Ch <anilkumar@ti.com> [120831 02:30]:
> Adopt pinctrl support to leds-gpio driver, based on the device
> pointer (leds-gpio) pinctrl driver configure SoC pins to GPIO
> mode.
> 
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  drivers/leds/leds-gpio.c |   31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
> index c032b21..d98dfb9 100644
> --- a/drivers/leds/leds-gpio.c
> +++ b/drivers/leds/leds-gpio.c
> @@ -20,6 +20,7 @@
>  #include <linux/slab.h>
>  #include <linux/workqueue.h>
>  #include <linux/module.h>
> +#include <linux/pinctrl/consumer.h>
>  
>  struct gpio_led_data {
>  	struct led_classdev cdev;
> @@ -236,14 +237,23 @@ static int __devinit gpio_led_probe(struct platform_device *pdev)
>  {
>  	struct gpio_led_platform_data *pdata = pdev->dev.platform_data;
>  	struct gpio_leds_priv *priv;
> -	int i, ret = 0;
> +	struct pinctrl *pinctrl;
> +	int i = 0;
> +	int ret = 0;
> +
> +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> +	if (IS_ERR(pinctrl)) {
> +		return PTR_ERR(pinctrl);
> +	}

I think you need to just print out a warning here as most systems don't
have the pinctrl implemented. And some people just do static pinmuxing
in the bootloader.

Regards,

Tony
