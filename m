From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Apr 2018 14:48:56 +0200
Subject: [PATCH] pinctrl: msm: fix gpio-hog related boot issues
In-Reply-To: <20180328180705.29147-1-chunkeey@gmail.com>
References: <20180328180705.29147-1-chunkeey@gmail.com>
Message-ID: <CACRpkdacDjzF=CR59by8Zd44wJD12Sr5FSTd=Ph_eSH2QYZudA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2018 at 8:07 PM, Christian Lamparter <chunkeey@gmail.com> wrote:

> This patch fixes the issue by adding the "gpio-ranges" property
> to the pinctrl device node of all upstream Qcom SoC, so the
> ranges are added by of_gpiochip_add_pin_range(), which is
> called by of_gpiochip_add() before the call to
> of_gpiochip_scan_gpios() happens.gpiochip_add_pin_range() is longer
> needed and removed (to prevent adding the same entry to the
> pinctrldev_list twice).

That's pretty neat!

>                         gpio-controller;
> +                       gpio-ranges = <&tlmm_pinmux 0 0 90>;

nice!

> -       ret = gpiochip_add_pin_range(&pctrl->chip, dev_name(pctrl->dev), 0, 0, chip->ngpio);
> -       if (ret) {
> -               dev_err(pctrl->dev, "Failed to add pin range\n");
> -               gpiochip_remove(&pctrl->chip);
> -               return ret;
> -       }

If you instead of deleteing this, just wrap it inside
something like:

if (!of_property_read_bool(np, "gpio-ranges") {
  (...)
}

You will stay compatible with elder device trees, solving Bj?rns
issue. You will only be adding hogs to newer device trees with
the ranges defined anyway.

Be genereous with comments in the code if you choose this
approach so everyone realize what is going on.

Yours,
Linus Walleij
