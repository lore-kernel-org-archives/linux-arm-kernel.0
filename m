From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 15 Aug 2015 22:16:03 +0200
Subject: [PATCH] spi: Mediatek: fix endian warnings
In-Reply-To: <1439289789-29026-1-git-send-email-leilk.liu@mediatek.com>
References: <1439289789-29026-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1871097.B3YgX5rNy0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 August 2015 18:43:09 Leilk Liu wrote:
> @@ -359,9 +359,11 @@ static void mtk_spi_setup_dma_addr(struct spi_master *master,
>         struct mtk_spi *mdata = spi_master_get_devdata(master);
>  
>         if (mdata->tx_sgl)
> -               writel(cpu_to_le32(xfer->tx_dma), mdata->base + SPI_TX_SRC_REG);
> +               writel((__force u32)cpu_to_le32(xfer->tx_dma),
> +                      mdata->base + SPI_TX_SRC_REG);
>         if (mdata->rx_sgl)
> -               writel(cpu_to_le32(xfer->rx_dma), mdata->base + SPI_RX_DST_REG);
> +               writel((__force u32)cpu_to_le32(xfer->rx_dma),
> +                      mdata->base + SPI_RX_DST_REG);
>  }
> 

This looks wrong: writel takes a CPU-endian argument, so the value returned
from cpu_to_le32() is not appropriate.

The warning is correct, and you have to remove the cpu_to_le32() conversion
in order to get the driver to behave correctly when the kernel is built
as big-endian.

	Arnd
