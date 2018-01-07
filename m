From: cyrille.pitchen@wedev4u.fr (Cyrille Pitchen)
Date: Sun, 7 Jan 2018 19:03:46 +0100
Subject: [PATCH v2 2/2] mtd: spi-nor: cadence-quadspi: Add support for
 direct access mode
In-Reply-To: <20171229091103.14436-3-vigneshr@ti.com>
References: <20171229091103.14436-1-vigneshr@ti.com>
 <20171229091103.14436-3-vigneshr@ti.com>
Message-ID: <e4162aac-ebbf-9949-8d4b-24a314e44c48@wedev4u.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 29/12/2017 ? 10:11, Vignesh R a ?crit?:
> Cadence QSPI controller provides direct access mode through which flash
> can be accessed in a memory-mapped IO mode. This enables read/write to
> flash using memcpy*() functions. This mode provides higher throughput
> for both read/write operations when compared to current indirect mode of
> operation.
> 
> This patch therefore adds support to use QSPI in direct mode. If the
> window reserved in SoC's memory map for MMIO access is less that of
> flash size(like on most SoCFPGA variants), then the driver falls back
> to indirect mode of operation.
> 
> On TI's 66AK2G SoC, with ARM running at 600MHz and QSPI at 96MHz
> switching to direct mode improves read throughput from 3MB/s to 8MB/s.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>

Applied to the spi-nor/next branch of linux-mtd

Thanks!

> ---
> 
> v2: enable direct access controller during controller init.
> 
>  drivers/mtd/spi-nor/cadence-quadspi.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
> index becc7d714ab8..f693a57ebbd6 100644
> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
> @@ -58,6 +58,7 @@ struct cqspi_flash_pdata {
>  	u8		data_width;
>  	u8		cs;
>  	bool		registered;
> +	bool		use_direct_mode;
>  };
>  
>  struct cqspi_st {
> @@ -68,6 +69,7 @@ struct cqspi_st {
>  
>  	void __iomem		*iobase;
>  	void __iomem		*ahb_base;
> +	resource_size_t		ahb_size;
>  	struct completion	transfer_complete;
>  	struct mutex		bus_mutex;
>  
> @@ -103,6 +105,7 @@ struct cqspi_st {
>  /* Register map */
>  #define CQSPI_REG_CONFIG			0x00
>  #define CQSPI_REG_CONFIG_ENABLE_MASK		BIT(0)
> +#define CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL	BIT(7)
>  #define CQSPI_REG_CONFIG_DECODE_MASK		BIT(9)
>  #define CQSPI_REG_CONFIG_CHIPSELECT_LSB		10
>  #define CQSPI_REG_CONFIG_DMA_MASK		BIT(15)
> @@ -891,6 +894,8 @@ static int cqspi_set_protocol(struct spi_nor *nor, const int read)
>  static ssize_t cqspi_write(struct spi_nor *nor, loff_t to,
>  			   size_t len, const u_char *buf)
>  {
> +	struct cqspi_flash_pdata *f_pdata = nor->priv;
> +	struct cqspi_st *cqspi = f_pdata->cqspi;
>  	int ret;
>  
>  	ret = cqspi_set_protocol(nor, 0);
> @@ -901,7 +906,10 @@ static ssize_t cqspi_write(struct spi_nor *nor, loff_t to,
>  	if (ret)
>  		return ret;
>  
> -	ret = cqspi_indirect_write_execute(nor, to, buf, len);
> +	if (f_pdata->use_direct_mode)
> +		memcpy_toio(cqspi->ahb_base + to, buf, len);
> +	else
> +		ret = cqspi_indirect_write_execute(nor, to, buf, len);
>  	if (ret)
>  		return ret;
>  
> @@ -911,6 +919,8 @@ static ssize_t cqspi_write(struct spi_nor *nor, loff_t to,
>  static ssize_t cqspi_read(struct spi_nor *nor, loff_t from,
>  			  size_t len, u_char *buf)
>  {
> +	struct cqspi_flash_pdata *f_pdata = nor->priv;
> +	struct cqspi_st *cqspi = f_pdata->cqspi;
>  	int ret;
>  
>  	ret = cqspi_set_protocol(nor, 1);
> @@ -921,7 +931,10 @@ static ssize_t cqspi_read(struct spi_nor *nor, loff_t from,
>  	if (ret)
>  		return ret;
>  
> -	ret = cqspi_indirect_read_execute(nor, buf, from, len);
> +	if (f_pdata->use_direct_mode)
> +		memcpy_fromio(buf, cqspi->ahb_base + from, len);
> +	else
> +		ret = cqspi_indirect_read_execute(nor, buf, from, len);
>  	if (ret)
>  		return ret;
>  
> @@ -1056,6 +1069,8 @@ static int cqspi_of_get_pdata(struct platform_device *pdev)
>  
>  static void cqspi_controller_init(struct cqspi_st *cqspi)
>  {
> +	u32 reg;
> +
>  	cqspi_controller_enable(cqspi, 0);
>  
>  	/* Configure the remap address register, no remap */
> @@ -1078,6 +1093,11 @@ static void cqspi_controller_init(struct cqspi_st *cqspi)
>  	writel(cqspi->fifo_depth * cqspi->fifo_width / 8,
>  	       cqspi->iobase + CQSPI_REG_INDIRECTWRWATERMARK);
>  
> +	/* Enable Direct Access Controller */
> +	reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
> +	reg |= CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL;
> +	writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
> +
>  	cqspi_controller_enable(cqspi, 1);
>  }
>  
> @@ -1153,6 +1173,12 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi, struct device_node *np)
>  			goto err;
>  
>  		f_pdata->registered = true;
> +
> +		if (mtd->size <= cqspi->ahb_size) {
> +			f_pdata->use_direct_mode = true;
> +			dev_dbg(nor->dev, "using direct mode for %s\n",
> +				mtd->name);
> +		}
>  	}
>  
>  	return 0;
> @@ -1212,6 +1238,7 @@ static int cqspi_probe(struct platform_device *pdev)
>  		dev_err(dev, "Cannot remap AHB address.\n");
>  		return PTR_ERR(cqspi->ahb_base);
>  	}
> +	cqspi->ahb_size = resource_size(res_ahb);
>  
>  	init_completion(&cqspi->transfer_complete);
>  
> 
