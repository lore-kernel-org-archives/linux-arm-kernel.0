From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 25 Jun 2012 10:22:24 -0300
Subject: [PATCH 7/7] ARM: mxs: Add SPI driver for mx233/mx28
In-Reply-To: <1340477033-2761-7-git-send-email-marex@denx.de>
References: <1340477033-2761-1-git-send-email-marex@denx.de>
 <1340477033-2761-7-git-send-email-marex@denx.de>
Message-ID: <CAOMZO5BYoU5=tJCUH1nkT24FJhhXXhNwF46yYREGJj7G33HdVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Sat, Jun 23, 2012 at 3:43 PM, Marek Vasut <marex@denx.de> wrote:

> + ? ? ? ssp->clk = clk_get(&pdev->dev, NULL);
> + ? ? ? if (IS_ERR(ssp->clk)) {
> + ? ? ? ? ? ? ? ret = PTR_ERR(ssp->clk);
> + ? ? ? ? ? ? ? goto out_spi_free;
> + ? ? ? }

You could use devm_clk_get here instead,


> +
> + ? ? ? clk_prepare_enable(ssp->clk);
> + ? ? ? ssp->clk_rate = clk_get_rate(ssp->clk) / 1000;
> +
> + ? ? ? stmp_reset_block(ssp->base);
> +
> + ? ? ? platform_set_drvdata(pdev, host);
> +
> + ? ? ? ret = spi_register_master(host);
> + ? ? ? if (ret) {
> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "Cannot register SPI master, %d\n", ret);
> + ? ? ? ? ? ? ? goto out_clk_put;
> + ? ? ? }
> +
> + ? ? ? return 0;
> +
> +out_clk_put:
> + ? ? ? clk_disable_unprepare(ssp->clk);
> + ? ? ? clk_put(ssp->clk);

,and then you would not need this clk_put here.

Driver looks good. Thanks for working on it.

Regards,

Fabio Estevam
