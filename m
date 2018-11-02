From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 2 Nov 2018 10:32:37 +0100
Subject: [PATCH V3 04/10] gpio: vf610: add optional clock support
In-Reply-To: <1540996688-23681-5-git-send-email-aisheng.dong@nxp.com>
References: <1540996688-23681-1-git-send-email-aisheng.dong@nxp.com>
 <1540996688-23681-5-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CACRpkda2XUXBCvb5mYgDrYtCL8dA24uQXaBrHrMLH4PFNdq_MQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2018 at 3:43 PM A.s. Dong <aisheng.dong@nxp.com> wrote:

> +       clk_port = devm_clk_get(&pdev->dev, "port");
> +       if (clk_port == ERR_PTR(-EPROBE_DEFER))
> +               return -EPROBE_DEFER;
> +
> +       clk_gpio = devm_clk_get(&pdev->dev, "gpio");
> +       if (clk_gpio == ERR_PTR(-EPROBE_DEFER))
> +               return -EPROBE_DEFER;
> +
> +       if (!IS_ERR_OR_NULL(clk_port)) {
> +               ret = clk_prepare_enable(clk_port);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       if (!IS_ERR_OR_NULL(clk_gpio)) {
> +               ret = clk_prepare_enable(clk_gpio);
> +               if (ret) {
> +                       clk_disable_unprepare(clk_port);
> +                       return ret;
> +               }
> +       }

I think IS_ERR_OR_NULL() is considered harmful among other
things.

What about this pattern:

        clk = devm_clk_get(dev, "foo");
        if (!IS_ERR(clk)) {
                ret = clk_prepare_enable(clk);
                if (ret)
                        return ret;
        } else if (PTR_ERR(clk) == -EPROBE_DEFER) {
                /*
                 * Percolate deferrals, for anything else,
                 * just live without the clocking.
                 */
                return PTR_ERR(clk);
        }

You also need to introduce code to disable the clock on
.remove() or the clock will always be on after this module
has probed. This applies also to builtin drivers, unless
you suppress the sysfs attributes and use
platform_driver_probe()

Yours,
Linus Walleij
