From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 Dec 2017 11:42:11 +0100
Subject: [PATCH 4/4] [v4] pinctrl: qcom: qdf2xxx: add support for new ACPI
 HID QCOM8002
In-Reply-To: <1512170904-4749-5-git-send-email-timur@codeaurora.org>
References: <1512170904-4749-1-git-send-email-timur@codeaurora.org>
 <1512170904-4749-5-git-send-email-timur@codeaurora.org>
Message-ID: <CACRpkdYer_Q5R4XhWTX3=jwshcKZRSDY9=gOvSeUPsQHbUw6vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 2, 2017 at 12:28 AM, Timur Tabi <timur@codeaurora.org> wrote:

>         /* Query the number of GPIOs from ACPI */
>         ret = device_property_read_u32(&pdev->dev, "num-gpios", &num_gpios);
>         if (ret < 0) {
> -               dev_warn(&pdev->dev, "missing num-gpios property\n");
> +               dev_err(&pdev->dev, "missing 'num-gpios' property\n");
>                 return ret;
>         }

It's unfortunate that this driver uses the undocumented "num-gpios"
when the device tree bindings already has standardized "ngpios"
as the name for this.

Maybe it was not standardized back in 2015 when this driver was merged.

Or we were all sloppy :/

> +               /* The number of GPIOs in the approved list */
> +               ret = device_property_read_u16_array(&pdev->dev, "gpios",
> +                                                    NULL, 0);
> +               if (ret < 0) {
> +                       dev_err(&pdev->dev, "missing 'gpios' property\n");
> +                       return ret;
> +               }

This is in direct conflict with the existing "gpios" binding in device tree.

Where is this name coming from? ACPI standards?

If device tree and ACPI start defining things which are in direct conflict
we can just shut down this device_property() business altogether,
it will never work that way.

I would try to merge a DT bindings doc defining "valid-gpios" or something
like this, can we proceed like that?

Yours,
Linus Walleij
