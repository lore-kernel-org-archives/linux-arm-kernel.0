From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Thu, 25 Jun 2015 17:41:45 +0300
Subject: [PATCH v2 2/2] spi: dw: Allow interface drivers to limit data
 I/O to word sizes
In-Reply-To: <1435163696-14767-3-git-send-email-michael@smart-africa.com>
References: <1434703435-25198-1-git-send-email-michael@smart-africa.com>
 <1435163696-14767-1-git-send-email-michael@smart-africa.com>
 <1435163696-14767-3-git-send-email-michael@smart-africa.com>
Message-ID: <1435243305.10393.103.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-06-24 at 18:34 +0200, Michael van der Westhuizen wrote:
> The commit dd11444327ce ("spi: dw-spi: Convert 16bit accesses to 
> 32bit
> accesses") changed all 16bit accesses in the DW_apb_ssi driver to 
> 32bit.
> This, unfortunately, breaks data register access on picoXcell, where 
> the
> DW IP needs data register accesses to be word accesses (all other
> accesses appear to be OK).
> 
> This change introduces a new master variable to allow interface 
> drivers
> to specify that 16bit data transfer I/O is required.  This change 
> also
> introduces the ability to set this variable via device tree bindings 
> in
> the MMIO interface driver.
> 
> Before this change, on a picoXcell pc3x3:
>  spi_master spi32766: interrupt_transfer: fifo overrun/underrun
>  m25p80 spi32766.0: error -5 reading 9f
>  m25p80: probe of spi32766.0 failed with error -5
> 
> After this change:
>  m25p80 spi32766.0: m25p40 (512 Kbytes)

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Fixes: dd11444327ce ("spi: dw-spi: Convert 16bit accesses to 32bit 
> accesses")
> Signed-off-by: Michael van der Westhuizen <michael@smart-africa.com>
> ---
> 
> Changes in v2:
>   - Incorporate review feedback from Andy Shevchenko
>     - Rework the DT bindings to accept an I/O register width as a
>       number of bytes rather than using a boolean spefifying the
>       width preference to be 16 bits.
>     - Add data register access wrapper functions and use them when
>       reading and writing the data register.
> 
>  drivers/spi/spi-dw-mmio.c |  4 ++++
>  drivers/spi/spi-dw.c      |  4 ++--
>  drivers/spi/spi-dw.h      | 35 +++++++++++++++++++++++++++++++++++
>  3 files changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index eb03e12..e76bf72 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -74,6 +74,10 @@ static int dw_spi_mmio_probe(struct 
> platform_device *pdev)
>  
>  	dws->max_freq = clk_get_rate(dwsmmio->clk);
>  
> +	if (pdev->dev.of_node)
> +		of_property_read_u32(pdev->dev.of_node, "snps,reg-io
> -width",
> +				     &dws->reg_io_width);
> +
>  	num_cs = 4;
>  
>  	if (pdev->dev.of_node)
> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> index 8d67d03..4fbfcdc 100644
> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -194,7 +194,7 @@ static void dw_writer(struct dw_spi *dws)
>  			else
>  				txw = *(u16 *)(dws->tx);
>  		}
> -		dw_writel(dws, DW_SPI_DR, txw);
> +		dw_write_io_reg(dws, DW_SPI_DR, txw);
>  		dws->tx += dws->n_bytes;
>  	}
>  }
> @@ -205,7 +205,7 @@ static void dw_reader(struct dw_spi *dws)
>  	u16 rxw;
>  
>  	while (max--) {
> -		rxw = dw_readl(dws, DW_SPI_DR);
> +		rxw = dw_read_io_reg(dws, DW_SPI_DR);
>  		/* Care rx only if the transfer's original "rx" is 
> not null */
>  		if (dws->rx_end - dws->len) {
>  			if (dws->n_bytes == 1)
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index 6c91391..b75ed32 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -109,6 +109,7 @@ struct dw_spi {
>  	u32			fifo_len;	/* depth of the FIFO 
> buffer */
>  	u32			max_freq;	/* max bus freq 
> supported */
>  
> +	u32			reg_io_width;	/* DR I/O width in 
> bytes */
>  	u16			bus_num;
>  	u16			num_cs;		/* supported 
> slave numbers */
>  
> @@ -145,11 +146,45 @@ static inline u32 dw_readl(struct dw_spi *dws, 
> u32 offset)
>  	return __raw_readl(dws->regs + offset);
>  }
>  
> +static inline u16 dw_readw(struct dw_spi *dws, u32 offset)
> +{
> +	return __raw_readw(dws->regs + offset);
> +}
> +
>  static inline void dw_writel(struct dw_spi *dws, u32 offset, u32 
> val)
>  {
>  	__raw_writel(val, dws->regs + offset);
>  }
>  
> +static inline void dw_writew(struct dw_spi *dws, u32 offset, u16 
> val)
> +{
> +	__raw_writew(val, dws->regs + offset);
> +}
> +
> +static inline u32 dw_read_io_reg(struct dw_spi *dws, u32 offset)
> +{
> +	switch (dws->reg_io_width) {
> +	case 2:
> +		return dw_readw(dws, offset);
> +	case 4:
> +	default:
> +		return dw_readl(dws, offset);
> +	}
> +}
> +
> +static inline void dw_write_io_reg(struct dw_spi *dws, u32 offset, 
> u32 val)
> +{
> +	switch (dws->reg_io_width) {
> +	case 2:
> +		dw_writew(dws, offset, val);
> +		break;
> +	case 4:
> +	default:
> +		dw_writel(dws, offset, val);
> +		break;
> +	}
> +}
> +
>  static inline void spi_enable_chip(struct dw_spi *dws, int enable)
>  {
>  	dw_writel(dws, DW_SPI_SSIENR, (enable ? 1 : 0));

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
