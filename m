From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Fri, 6 Jul 2018 15:38:15 +0200
Subject: [PATCH] mtd: spi-nor: cadence-quadspi: Fix direct mode write
 timeouts
In-Reply-To: <20180630105421.550-1-vigneshr@ti.com>
References: <20180630105421.550-1-vigneshr@ti.com>
Message-ID: <20180706153815.741e2403@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 30 Jun 2018 16:24:21 +0530
Vignesh R <vigneshr@ti.com> wrote:

> Sometimes when writing large size files to flash in direct/memory mapped
> mode, it is seen that flash write enable command times out with error:
> [  503.146293] cadence-qspi 47040000.ospi: Flash command execution timed out.
> 
> This is because, we need to make sure previous direct write operation
> is complete by polling for IDLE bit in CONFIG_REG before starting the
> next operation.
> 
> Fix this by polling for IDLE bit after memory mapped write.
> 
> Fixes: a27f2eaf2b27 ("mtd: spi-nor: cadence-quadspi: Add support for direct access mode")
> Cc: stable at vger.kernel.org
> Signed-off-by: Vignesh R <vigneshr@ti.com>

Applied.

Thanks,

Boris

> ---
>  drivers/mtd/spi-nor/cadence-quadspi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
> index c3f7aaa5d18f..d7e10b36a0b9 100644
> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
> @@ -926,10 +926,12 @@ static ssize_t cqspi_write(struct spi_nor *nor, loff_t to,
>  	if (ret)
>  		return ret;
>  
> -	if (f_pdata->use_direct_mode)
> +	if (f_pdata->use_direct_mode) {
>  		memcpy_toio(cqspi->ahb_base + to, buf, len);
> -	else
> +		ret = cqspi_wait_idle(cqspi);
> +	} else {
>  		ret = cqspi_indirect_write_execute(nor, to, buf, len);
> +	}
>  	if (ret)
>  		return ret;
>  
