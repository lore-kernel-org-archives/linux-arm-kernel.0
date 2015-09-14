From: broonie@kernel.org (Mark Brown)
Date: Mon, 14 Sep 2015 19:26:00 +0100
Subject: [PATCH 2/5] spi: spi-ti-qspi: add mmap mode read support
In-Reply-To: <1441355402-6837-3-git-send-email-vigneshr@ti.com>
References: <1441355402-6837-1-git-send-email-vigneshr@ti.com>
 <1441355402-6837-3-git-send-email-vigneshr@ti.com>
Message-ID: <20150914182600.GC12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 04, 2015 at 01:59:59PM +0530, Vignesh R wrote:

> +static int ti_qspi_spi_mtd_mmap_read(struct  spi_device *spi,
> +				     loff_t from, size_t len,
> +				     size_t *retlen, u_char *buf,
> +				     u8 read_opcode, u8 addr_width,
> +				     u8 dummy_bytes)
> +{
> +	struct ti_qspi *qspi = spi_master_get_devdata(spi->master);
> +	int ret = 0;
> +
> +	spi_bus_lock(qspi->master);

I suspect I'm going to see the answer to this in another patch but the
fact that we're having to take this lock in a driver when it's an op the
core should be calling.

> +	ret = pm_runtime_get_sync(qspi->dev);
> +	if (ret < 0) {
> +		dev_err(qspi->dev, "pm_runtime_get_sync() failed\n");
> +		return ret;
> +	}

This would be better outside the lock, there's no need to have the lock
before we power on and this fixes the fact that you don't release the
lock here.

> +	memcpy(buf, (__force void *)(qspi->mmap_base + from), len);

The fact that you're having to cast here should be a warning that
there's someting wrong here.  I think you're looking for
memcpy_fromio().

> @@ -479,6 +576,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
>  	master->setup = ti_qspi_setup;
>  	master->auto_runtime_pm = true;
>  	master->transfer_one_message = ti_qspi_start_transfer_one;
> +	master->spi_mtd_mmap_read = ti_qspi_spi_mtd_mmap_read;
>  	master->dev.of_node = pdev->dev.of_node;
>  	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) |
>  				     SPI_BPW_MASK(8);

Don't we need to map a resource somewhere?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150914/f3c7975c/attachment.sig>
