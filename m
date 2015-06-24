From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Wed, 24 Jun 2015 14:57:44 +0300
Subject: [PATCH 1/2] spi: dw: Allow interface drivers to limit data I/O
 to word sizes
In-Reply-To: <1434703435-25198-3-git-send-email-michael@smart-africa.com>
References: <1434703435-25198-1-git-send-email-michael@smart-africa.com>
 <1434703435-25198-3-git-send-email-michael@smart-africa.com>
Message-ID: <1435147064.10393.100.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-06-19 at 10:43 +0200, Michael van der Westhuizen wrote:
> The commit dd11444327ce ("spi: dw-spi: Convert 16bit accesses to 
> 32bit
> accesses") changed all 16bit accesses in the DW_apb_ssi driver to 
> 32bit.
> This, unfortunately, breaks data register access on picoXcell, where 
> the
> DW IP needs data register accesses to be word accesses (all other
> accesses appear to be OK).

Thanks for the patch. My comments below.

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
> 

Please, add Fixes: tag as well.

> Signed-off-by: Michael van der Westhuizen <michael@smart-africa.com>
> ---
>  drivers/spi/spi-dw-mmio.c |  5 +++++
>  drivers/spi/spi-dw.c      | 13 +++++++++++--
>  drivers/spi/spi-dw.h      | 11 +++++++++++
>  3 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index eb03e12..1397424 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -74,6 +74,11 @@ static int dw_spi_mmio_probe(struct 
> platform_device *pdev)
>  
>  	dws->max_freq = clk_get_rate(dwsmmio->clk);
>  
> +	if (pdev->dev.of_node)
> +		dws->data_io_16bit =

I don't like "flexibility" in the  DeviceTree data base and thus I
would prefer to see what we already have in naming there, i.e.
reg-io-width = 2 or 4.

> +			of_property_read_bool(pdev->dev.of_node,
> +					      "snps,data-io-16bit");
> +
>  	num_cs = 4;
>  
>  	if (pdev->dev.of_node)
> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> index 8d67d03..862b001 100644
> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -194,7 +194,12 @@ static void dw_writer(struct dw_spi *dws)
>  			else
>  				txw = *(u16 *)(dws->tx);
>  		}
> -		dw_writel(dws, DW_SPI_DR, txw);
> +
> +		if (dws->data_io_16bit)
> +			dw_writew(dws, DW_SPI_DR, txw);
> +		else
> +			dw_writel(dws, DW_SPI_DR, txw);
> +
>  		dws->tx += dws->n_bytes;
>  	}
>  }
> @@ -205,7 +210,11 @@ static void dw_reader(struct dw_spi *dws)
>  	u16 rxw;
>  
>  	while (max--) {
> -		rxw = dw_readl(dws, DW_SPI_DR);
> +		if (dws->data_io_16bit)
> +			rxw = dw_readw(dws, DW_SPI_DR);
> +		else
> +			rxw = dw_readl(dws, DW_SPI_DR);
> +
>  		/* Care rx only if the transfer's original "rx" is 
> not null */
>  		if (dws->rx_end - dws->len) {
>  			if (dws->n_bytes == 1)
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index 6c91391..ced276a 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -109,6 +109,7 @@ struct dw_spi {
>  	u32			fifo_len;	/* depth of the FIFO 
> buffer */
>  	u32			max_freq;	/* max bus freq 
> supported */
>  
> +	bool			data_io_16bit;	/* DR is only 16 
> bits wide */
>  	u16			bus_num;
>  	u16			num_cs;		/* supported 
> slave numbers */
>  
> @@ -145,11 +146,21 @@ static inline u32 dw_readl(struct dw_spi *dws, 
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
>  static inline void spi_enable_chip(struct dw_spi *dws, int enable)
>  {
>  	dw_writel(dws, DW_SPI_SSIENR, (enable ? 1 : 0));

Regarding to above comment what about something like

static inline u32 dw_read_reg(dws, offset)
{
 switch (reg_io_width)
 case 2:
  return dw_readw();
 case 4:
 default:
  return dw_readl();
}


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
