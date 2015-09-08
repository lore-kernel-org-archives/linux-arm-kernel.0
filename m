From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 8 Sep 2015 16:42:38 +0200
Subject: [PATCH-v2 4/7] mmc: sdhci-pxav3: Add pinctl setting according to
 bus clock
In-Reply-To: <1441624721-15612-5-git-send-email-vaibhav.hiremath@linaro.org>
References: <1441624721-15612-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1441624721-15612-5-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <CACRpkdY59roEBgUd9TR39yNgfhw393+WmHQQAeLkOEZLChOcWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 7, 2015 at 1:18 PM, Vaibhav Hiremath
<vaibhav.hiremath@linaro.org> wrote:

> Different bus clock may need different pin setting.
> For example, fast bus clock like 208Mhz need pin drive fast
> while slow bus clock prefer pin drive slow to guarantee
> signal quality.
>
> So this patch creates two states,
>   - Default (slow/normal) pin state
>   - And fast pin state for higher freq bus speed.
>
> And selection of pin state is done based on timing mode.
>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> Signed-off-by: Kevin Liu <kliu5@marvell.com>
(...)
> +       pxa->pinctrl = devm_pinctrl_get(dev);
> +       if (!IS_ERR(pxa->pinctrl)) {
> +               pxa->pins_default = pinctrl_lookup_state(pxa->pinctrl, "default");
> +               if (IS_ERR(pxa->pins_default))
> +                       dev_err(dev, "could not get default pinstate\n");
> +               pxa->pins_fast = pinctrl_lookup_state(pxa->pinctrl, "fast");
> +               if (IS_ERR(pxa->pins_fast))
> +                       dev_info(dev, "could not get fast pinstate\n");
> +       }

This is exactly how I think it should be used from a pin control
point of view.

If you depended on CONFIG_PM you could use
pinctrl_pm_select_default_state() but for this simple scenario
this is fine.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>From a pinctrl point of view.

Yours,
Linus Walleij
