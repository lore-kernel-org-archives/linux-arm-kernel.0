From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 25 Feb 2014 09:15:08 +0000
Subject: [PATCH 3/3] spi:fsl-dspi:add dspi dma transfer support
In-Reply-To: <1393311258-14380-3-git-send-email-b44548@freescale.com>
References: <1393311258-14380-1-git-send-email-b44548@freescale.com>
 <1393311258-14380-3-git-send-email-b44548@freescale.com>
Message-ID: <20140225091508.GP28555@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 06:54:18AM +0000, Chao Fu wrote:
> From: Chao Fu <B44548@freescale.com>
> 
> DSPI can transfer data in DMA mode or PIO mode.This patch will add the DMA
> transfer driver support. Add DMA reference functions and variables to form DMA
> transfer process.
> DSPI DMA mode need work with Freescale eDMA module together.
> 
> The software will be changed in two transfer methods as followwing:
>                  DMA                    PIO
> trigger write:   dspi_tx_dma            dspi_tx_pio
> write complete:  dspi_dma_tx_complete   irq_handle
> trigger read:    dspi_receive_dma       dspi_rx_pio
> read complete:   dspi_rx_dma            none
> 
> Remove bitbang:
> Add DMA funtions, DSPI module need get cs change information in a spi transfer.
> According cs change, DSPI will give last data the right flag. Bitbang provide
> cs change behind the last data in a transfer. DSPI can not deal the last data in
> every transfer properly, so remove the bitbang in driver.
> 
> Signed-off-by: Chao Fu      <b44548@freescale.com>
> ---
>  drivers/spi/Kconfig        |   1 -
>  drivers/spi/spi-fsl-dspi.c | 425 ++++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 360 insertions(+), 66 deletions(-)

[...]

> @@ -529,10 +816,18 @@ static int dspi_probe(struct platform_device *pdev)
>         }
>         clk_prepare_enable(dspi->clk);
> 
> +       dspi->use_dma = of_property_read_bool(np, "use-dma");
> +       if (dspi->use_dma)
> +               if (dspi_request_dma(dspi)) {
> +                       dspi->use_dma = 0;
> +                       dev_err(&pdev->dev, "request dma channel fail\n");
> +                       dspi_release_dma(dspi);
> +               }

Why have the use-dma property at all? You already fall back to PIO mode
if the DMAs are not present, so it's clearly not a requirement to use
DMA.

Why not always try to request he dmas you need? You already have the
fallback logic, the only difference would be changing the dev_err to
better describe the situation:

dev_info(&pdev->dev, "No 'tx' and/or 'rx' DMA(s), using PIO mode\n");

Cheers,
Mark.
