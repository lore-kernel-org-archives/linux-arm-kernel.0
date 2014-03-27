From: cooloney@gmail.com (Bryan Wu)
Date: Thu, 27 Mar 2014 15:28:32 -0700
Subject: [PATCH 1/2] leds: add DT support for LEDs wired to supply and
 default brightness
In-Reply-To: <E1WJUvl-0003wc-0S@rmk-PC.arm.linux.org.uk>
References: <E1WJUvl-0003wc-0S@rmk-PC.arm.linux.org.uk>
Message-ID: <CAK5ve-+K+R=c7Lp+JaTCOcq9LYHTszQQg9Xp1fQHxqcQ2cVHHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 28, 2014 at 1:25 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> Some PWM outputs are wired such that the LED they're controlling is
> connected to supply rather than ground.  Therefore, the duty cycle
> needs to be inverted to make the LED behave as it should do.
>
> We also provide a way to specify the default brightness when a
> trigger is not specified.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  Documentation/devicetree/bindings/leds/leds-pwm.txt |  3 +++
>  drivers/leds/leds-pwm.c                             | 15 +++++++++++----
>  2 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/leds/leds-pwm.txt b/Documentation/devicetree/bindings/leds/leds-pwm.txt
> index 7297107cf832..ffcb74ab61fd 100644
> --- a/Documentation/devicetree/bindings/leds/leds-pwm.txt
> +++ b/Documentation/devicetree/bindings/leds/leds-pwm.txt
> @@ -13,6 +13,9 @@ node's name represents the name of the corresponding LED.
>    For the pwms and pwm-names property please refer to:
>    Documentation/devicetree/bindings/pwm/pwm.txt
>  - max-brightness : Maximum brightness possible for the LED
> +- default-brightness : (optional) Default brightness for the LED
> +- active-low : (optional) For PWMs where the LED is wired to supply
> +  rather than ground.
>  - label :  (optional)
>    see Documentation/devicetree/bindings/leds/common.txt
>  - linux,default-trigger :  (optional)

Why remove "max-brightness", "label" and "linux,default-trigger" here?
I believe you're still using them in your second patch like

+               front {
+                       active-low;
+                       default-brightness = <128>;
+                       label = "imx6:red:front";
+                       max-brightness = <248>;
+                       pwms = <&pwm1 0 50000>;
+               };

Others are good to me.

Thierry, could you please review this patchset?

Thanks,
-Bryan

> diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
> index 605047428b5a..fe2cd849b593 100644
> --- a/drivers/leds/leds-pwm.c
> +++ b/drivers/leds/leds-pwm.c
> @@ -70,6 +70,10 @@ static void led_pwm_set(struct led_classdev *led_cdev,
>
>         duty *= brightness;
>         do_div(duty, max);
> +
> +       if (led_dat->active_low)
> +               duty = led_dat->period - duty;
> +
>         led_dat->duty = duty;
>
>         if (led_dat->can_sleep)
> @@ -93,6 +97,10 @@ static int led_pwm_create_of(struct platform_device *pdev,
>         for_each_child_of_node(pdev->dev.of_node, child) {
>                 struct led_pwm_data *led_dat = &priv->leds[priv->num_leds];
>
> +               led_dat->cdev.brightness_set = led_pwm_set;
> +               led_dat->cdev.brightness = LED_OFF;
> +               led_dat->cdev.flags |= LED_CORE_SUSPENDRESUME;
> +
>                 led_dat->cdev.name = of_get_property(child, "label",
>                                                      NULL) ? : child->name;
>
> @@ -110,10 +118,9 @@ static int led_pwm_create_of(struct platform_device *pdev,
>                                                 "linux,default-trigger", NULL);
>                 of_property_read_u32(child, "max-brightness",
>                                      &led_dat->cdev.max_brightness);
> -
> -               led_dat->cdev.brightness_set = led_pwm_set;
> -               led_dat->cdev.brightness = LED_OFF;
> -               led_dat->cdev.flags |= LED_CORE_SUSPENDRESUME;
> +               of_property_read_u32(child, "default-brightness",
> +                                    &led_dat->cdev.brightness);
> +               led_dat->active_low = of_property_read_bool(child, "active-low");
>
>                 led_dat->can_sleep = pwm_can_sleep(led_dat->pwm);
>                 if (led_dat->can_sleep)
> --
> 1.8.3.1
>
