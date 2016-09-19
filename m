From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Sep 2016 12:19:33 +0200
Subject: [PATCH] spi: dw: use relaxed IO accessor
In-Reply-To: <20160919090041.4024-1-jszhang@marvell.com>
References: <20160919090041.4024-1-jszhang@marvell.com>
Message-ID: <5512851.aA4Sb0uIYP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, September 19, 2016 5:00:41 PM CEST Jisheng Zhang wrote:
> Using the __raw functions is discouraged.  Update the driver to use the
> relaxed functions.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

This should mention that it fixes the driver for big-endian kernels.

However, it seems that the fix is only correct for the MMIO
registers, while the polled FIFO access is now wrong AFAICT,
both reader and writer:

static void dw_reader(struct dw_spi *dws)
{
        u32 max = rx_max(dws);
        u16 rxw;

        while (max--) {
                rxw = dw_read_io_reg(dws, DW_SPI_DR);
                /* Care rx only if the transfer's original "rx" is not null */
                if (dws->rx_end - dws->len) {
                        if (dws->n_bytes == 1)
                                *(u8 *)(dws->rx) = rxw;
                        else
                                *(u16 *)(dws->rx) = rxw;
                }
                dws->rx += dws->n_bytes;
        }
}

As the FIFO is a byte stream, we have to use a non-swapping
accessor here, such as readsl() which would also take care of the
loop. The "n_bytes == 1" case probably should look like e.g.

	*(u8 *)(dws->rx) = *(u8 *)&rxw;

so you are sure to get the first byte of the rxw variable
rather than the lower 8 bits.

> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index 61bc3cb..2cfdc4d 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -143,22 +143,22 @@ struct dw_spi {
>  
>  static inline u32 dw_readl(struct dw_spi *dws, u32 offset)
>  {
> -	return __raw_readl(dws->regs + offset);
> +	return readl_relaxed(dws->regs + offset);
>  }
>  
>  static inline u16 dw_readw(struct dw_spi *dws, u32 offset)
>  {
> -	return __raw_readw(dws->regs + offset);
> +	return readw_relaxed(dws->regs + offset);
>  }
>  

What is the reason for using readl_relaxed() rather than the
normal readl() here? In almost all instances that these are
called, you don't care about the added latency and should just
default to the normal I/O functions.

	Arnd
