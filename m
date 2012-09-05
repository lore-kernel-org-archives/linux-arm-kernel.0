From: bryan.wu@canonical.com (Bryan Wu)
Date: Wed, 5 Sep 2012 11:06:22 +0800
Subject: [PATCH v2] leds: leds-gpio: adopt pinctrl support
In-Reply-To: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
Message-ID: <CAK5ve-Jqc1xpXa0VM7=+MN1cvm=8ysg9W9WRiG66yq7GRfh+Gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 1, 2012 at 4:16 PM, AnilKumar Ch <anilkumar@ti.com> wrote:
> Adopt pinctrl support to leds-gpio driver based on leds-gpio
> device pointer, pinctrl driver configure SoC pins to GPIO
> mode according to definitions provided in .dts file.
>

Thanks for this, actually Marek Vasut submitted a similar patch
before. I'm pretty fine with this patch.
But without proper DT setting, it will also give us warning I think.
or we can provide some dummy functions as a temp solution as Shawn
pointed out before.

-Bryan

> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
> Changes from v1:
>         - Seperated from "Add DT for AM33XX devices" patch series
>         - Incorporated Tony's comments on v1
>           * Changed to warning message instead od error return
>
>  drivers/leds/leds-gpio.c |    7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
> index c032b21..ad577f4 100644
> --- a/drivers/leds/leds-gpio.c
> +++ b/drivers/leds/leds-gpio.c
> @@ -20,6 +20,7 @@
>  #include <linux/slab.h>
>  #include <linux/workqueue.h>
>  #include <linux/module.h>
> +#include <linux/pinctrl/consumer.h>
>
>  struct gpio_led_data {
>         struct led_classdev cdev;
> @@ -236,8 +237,14 @@ static int __devinit gpio_led_probe(struct platform_device *pdev)
>  {
>         struct gpio_led_platform_data *pdata = pdev->dev.platform_data;
>         struct gpio_leds_priv *priv;
> +       struct pinctrl *pinctrl;
>         int i, ret = 0;
>
> +       pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> +       if (IS_ERR(pinctrl))
> +               dev_warn(&pdev->dev,
> +                       "pins are not configured from the driver\n");
> +
>         if (pdata && pdata->num_leds) {
>                 priv = devm_kzalloc(&pdev->dev,
>                                 sizeof_gpio_leds_priv(pdata->num_leds),
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-leds" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer    +86.186-168-78255 Mobile
Canonical Ltd.      www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
