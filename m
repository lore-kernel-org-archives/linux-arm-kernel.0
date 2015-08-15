From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 15 Aug 2015 22:46:14 +0200
Subject: [PATCH] spi: Mediatek: fixup cpu_to_le32 incorrect usage
In-Reply-To: <1439467601-10209-1-git-send-email-leilk.liu@mediatek.com>
References: <1439467601-10209-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <3523801.O835HG5rEa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 August 2015 20:06:41 Leilk Liu wrote:
> diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> index ae645fa..519f50c 100644
> --- a/drivers/spi/spi-mt65xx.c
> +++ b/drivers/spi/spi-mt65xx.c
> @@ -359,11 +359,9 @@ static void mtk_spi_setup_dma_addr(struct spi_master *master,
>         struct mtk_spi *mdata = spi_master_get_devdata(master);
>  
>         if (mdata->tx_sgl)
> -               writel((__force u32)cpu_to_le32(xfer->tx_dma),
> -                      mdata->base + SPI_TX_SRC_REG);
> +               writel(xfer->tx_dma, mdata->base + SPI_TX_SRC_REG);
>         if (mdata->rx_sgl)
> -               writel((__force u32)cpu_to_le32(xfer->rx_dma),
> -                      mdata->base + SPI_RX_DST_REG);
> +               writel(xfer->rx_dma, mdata->base + SPI_RX_DST_REG);
>  }
>  
>  static int mtk_spi_fifo_transfer(struct spi_master *master,
> -- 
> 

This change looks good, but after I've briefly looked at the current driver,
I found at least one more location that looks like an endianess bug:


+static int mtk_spi_fifo_transfer(struct spi_master *master,
+                                struct spi_device *spi,
+                                struct spi_transfer *xfer)
+{
...
+
+       for (i = 0; i < cnt; i++)
+               writel(*((u32 *)xfer->tx_buf + i),
+                      mdata->base + SPI_TX_DATA_REG);
+
+       mtk_spi_enable_transfer(master);
+
+       return 1;
+}

Here, you write data into a FIFO register using an accessor that converts
to little-endian. In contrast, the DMA based accessor apparently has
no byte swap, so most likely one of the two is broken on big-endian
systems. My guess is that the look above is wrong, and you need to
use iowrite32_rep() instead, so you always write into the FIFO in
the byte stream order (first byte to last byte) rather than swapping
32-bit entities.

The other suspicious part is this:

+       reg_val |= (chip_config->tx_endian << SPI_CMD_TX_ENDIAN_OFFSET);
+       reg_val |= (chip_config->rx_endian << SPI_CMD_RX_ENDIAN_OFFSET);

It's not clear what the tx_endian/rx_endian bits refer to and why you
can't just always set the register interface to little-endian. If it's
set to big-endian, you probably need to add more byte swaps in the
driver.

	Arnd
