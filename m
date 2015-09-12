From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 12 Sep 2015 20:04:49 -0300
Subject: [PATCH 4/6] hwrng: st: Add support for ST's HW Random Number
 Generator
In-Reply-To: <1442002110-28733-5-git-send-email-lee.jones@linaro.org>
References: <1442002110-28733-1-git-send-email-lee.jones@linaro.org>
 <1442002110-28733-5-git-send-email-lee.jones@linaro.org>
Message-ID: <CAOMZO5CWywFHd1HE2=G-KEvQZpu_rJibmJL4fL5yCWRsnpi05Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 11, 2015 at 5:08 PM, Lee Jones <lee.jones@linaro.org> wrote:

> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       base = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       clk = devm_clk_get(&pdev->dev, NULL);
> +       if (!clk)
> +               return -EINVAL;

This should be:

    if (IS_ERR(clk))
        return PTR_ERR(clk);

> +
> +       clk_prepare_enable(clk);

This may fail, so better check its return value and propagate it on error.

> +
> +       ddata->ops.priv = (unsigned long)ddata;
> +       ddata->ops.read = st_rng_read;
> +       ddata->ops.name = pdev->name;
> +       ddata->base     = base;
> +       ddata->clk      = clk;
> +
> +       dev_set_drvdata(&pdev->dev, ddata);
> +
> +       ret = hwrng_register(&ddata->ops);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed to register HW RNG\n");
> +               return ret;
> +       }
> +
> +       dev_info(&pdev->dev, "Successfully registered HW RNG\n");

No need to put this info.
