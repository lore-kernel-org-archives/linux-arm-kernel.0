From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 30 Jun 2014 15:20:54 +0100
Subject: [PATCH v10 2/2] dmaengine: sun6i: Add driver for the Allwinner
 A31 DMA controller
In-Reply-To: <1404134454-25513-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1404134454-25513-1-git-send-email-maxime.ripard@free-electrons.com>
 <1404134454-25513-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140630142054.GA8756@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Mon, Jun 30, 2014 at 02:20:54PM +0100, Maxime Ripard wrote:
> The Allwinner A31 has a 16 channels DMA controller that it shares with the
> newer A23. Although sharing some similarities with the DMA controller of the
> older Allwinner SoCs, it's significantly different, I don't expect it to be
> possible to share the driver for these two.
>
> The A31 Controller is able to memory-to-memory or memory-to-device transfers on
> the 16 channels in parallel.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/dma/Kconfig     |    8 +
>  drivers/dma/Makefile    |    1 +
>  drivers/dma/sun6i-dma.c | 1058 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1067 insertions(+)
>  create mode 100644 drivers/dma/sun6i-dma.c

[...]

> +       sdc->clk = devm_clk_get(&pdev->dev, NULL);
> +       if (IS_ERR(sdc->clk)) {
> +               dev_err(&pdev->dev, "No clock specified\n");
> +               return PTR_ERR(sdc->clk);
> +       }
> +
> +       mux = clk_get(NULL, "ahb1_mux");
> +       if (IS_ERR(mux)) {
> +               dev_err(&pdev->dev, "Couldn't get AHB1 Mux\n");
> +               return PTR_ERR(mux);
> +       }
> +
> +       pll6 = clk_get(NULL, "pll6");
> +       if (IS_ERR(pll6)) {
> +               dev_err(&pdev->dev, "Couldn't get PLL6\n");
> +               clk_put(mux);
> +               return PTR_ERR(pll6);
> +       }

I'm slightly confused. The binding listed a single unnamed clock (the
AHB clock). What is going on here?

> +       ret = clk_set_parent(mux, pll6);
> +       clk_put(pll6);
> +       clk_put(mux);
> +
> +       if (ret) {
> +               dev_err(&pdev->dev, "Couldn't reparent AHB1 on PLL6\n");
> +               return ret;
> +       }

Why do we need to reparent the mux?

Thanks,
Mark.
