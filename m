From: bjorn@kryo.se (Bjorn Andersson)
Date: Tue, 24 Mar 2015 17:50:07 +0100
Subject: [PATCH 3/5] leds: syscon: instantiate from platform device
In-Reply-To: <1425375148-4369-4-git-send-email-linus.walleij@linaro.org>
References: <1425375148-4369-1-git-send-email-linus.walleij@linaro.org>
 <1425375148-4369-4-git-send-email-linus.walleij@linaro.org>
Message-ID: <CAJAp7Oih5e1qc8FJ5=w4Zm6fWxm4oH3QpjdE6KBDq2ZmWj-AqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 3, 2015 at 10:32 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
[..]
> +static int syscon_led_remove(struct platform_device *pdev)
>  {
> -       struct device_node *np;
> -
> -       for_each_of_allnodes(np) {
> -               struct platform_device *pdev;
> -               struct regmap *map;
> -               int ret;
> +       struct syscon_led *sled = platform_get_drvdata(pdev);
>
> -               if (!of_device_is_compatible(np, "syscon"))
> -                       continue;
> +       led_classdev_unregister(&sled->cdev);
> +       /* Turn it off */
> +       regmap_update_bits(sled->map, sled->offset, sled->mask, 0);

led_classdev_unregister() should have called your brightness_set op
already to disable the LED - see led-class.c line 279. So you
shouldn't need this.
I like the rest and have been missing "simple-mfd" in other use cases...

So part of the extra disable:
Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Regards,
Bjorn
