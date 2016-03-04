From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Fri, 4 Mar 2016 12:39:23 +0200
Subject: [PATCH 5/9] spi: imx: add support for all SPI word width for DMA
In-Reply-To: <1456302033-25638-6-git-send-email-s.hauer@pengutronix.de>
References: <1456302033-25638-1-git-send-email-s.hauer@pengutronix.de>
 <1456302033-25638-6-git-send-email-s.hauer@pengutronix.de>
Message-ID: <56D965DB.8050707@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anton, Sascha,

On 24.02.2016 10:20, Sascha Hauer wrote:
> From: Anton Bondarenko <anton.bondarenko.sama@gmail.com>
> 
> DMA transfer for SPI was limited to up to 8 bits word size until now.
> Sync in SPI burst size and DMA bus width is necessary to correctly
> support 16 and 32 BPW.
> 
> Signed-off-by: Anton Bondarenko <anton.bondarenko.sama@gmail.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/spi/spi-imx.c | 118 ++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 91 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 567a242..15b23f0 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -89,11 +89,15 @@ struct spi_imx_data {
>  
>  	struct completion xfer_done;
>  	void __iomem *base;
> +	unsigned long base_phys;
> +
>  	struct clk *clk_per;
>  	struct clk *clk_ipg;
>  	unsigned long spi_clk;
>  	unsigned int spi_bus_clk;
>  
> +	unsigned int bytes_per_word;
> +
>  	unsigned int count;
>  	void (*tx)(struct spi_imx_data *);
>  	void (*rx)(struct spi_imx_data *);
> @@ -199,15 +203,35 @@ static unsigned int spi_imx_clkdiv_2(unsigned int fin,
>  	return 7;
>  }
>  
> +static int spi_imx_bytes_per_word(const int bpw)
> +{
> +	return DIV_ROUND_UP(bpw, BITS_PER_BYTE);
> +}
> +
>  static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
>  			 struct spi_transfer *transfer)
>  {
>  	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
> +	unsigned int bpw = transfer->bits_per_word;
> +
> +	if (!master->dma_rx)
> +		return false;
> +
> +	if (!bpw)
> +		bpw = spi->bits_per_word;
> +
> +	bpw = spi_imx_bytes_per_word(bpw);
> +
> +	if (bpw != 1 && bpw != 2 && bpw != 4)
> +		return false;
> +
> +	if (transfer->len < spi_imx->wml * bpw)
> +		return false;
> +
> +	if (transfer->len % (spi_imx->wml * bpw))
> +		return false;
>  
> -	if (master->dma_rx && transfer->len >= spi_imx->wml &&
> -	    (transfer->len % spi_imx->wml) == 0)
> -		return true;
> -	return false;
> +	return true;
>  }
>  
>  #define MX51_ECSPI_CTRL		0x08
> @@ -775,11 +799,63 @@ static irqreturn_t spi_imx_isr(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +static int spi_imx_dma_configure(struct spi_master *master,
> +				 int bytes_per_word)
> +{
> +	int ret;
> +	enum dma_slave_buswidth buswidth;
> +	struct dma_slave_config rx = {}, tx = {};
> +	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
> +
> +	if (bytes_per_word == spi_imx->bytes_per_word)
> +		/* Same as last time */
> +		return 0;
> +
> +	switch (bytes_per_word) {
> +	case 4:
> +		buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +		break;
> +	case 2:
> +		buswidth = DMA_SLAVE_BUSWIDTH_2_BYTES;
> +		break;
> +	case 1:
> +		buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	tx.direction = DMA_MEM_TO_DEV;
> +	tx.dst_addr = spi_imx->base_phys + MXC_CSPITXDATA;
> +	tx.dst_addr_width = buswidth;
> +	tx.dst_maxburst = spi_imx->wml;
> +	ret = dmaengine_slave_config(master->dma_tx, &tx);
> +	if (ret) {
> +		dev_err(spi_imx->dev, "TX dma configuration failed with %d\n", ret);
> +		return ret;
> +	}
> +
> +	rx.direction = DMA_DEV_TO_MEM;
> +	rx.src_addr = spi_imx->base_phys + MXC_CSPIRXDATA;
> +	rx.src_addr_width = buswidth;
> +	rx.src_maxburst = spi_imx->wml;
> +	ret = dmaengine_slave_config(master->dma_rx, &rx);
> +	if (ret) {
> +		dev_err(spi_imx->dev, "RX dma configuration failed with %d\n", ret);
> +		return ret;
> +	}
> +
> +	spi_imx->bytes_per_word = bytes_per_word;
> +
> +	return 0;
> +}
> +
>  static int spi_imx_setupxfer(struct spi_device *spi,
>  				 struct spi_transfer *t)
>  {
>  	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
>  	struct spi_imx_config config;
> +	int ret;
>  
>  	config.bpw = t ? t->bits_per_word : spi->bits_per_word;
>  	config.speed_hz  = t ? t->speed_hz : spi->max_speed_hz;
> @@ -808,6 +884,13 @@ static int spi_imx_setupxfer(struct spi_device *spi,
>  	else
>  		spi_imx->usedma = 0;
>  
> +	if (spi_imx->usedma) {
> +		ret = spi_imx_dma_configure(spi->master,
> +					    spi_imx_bytes_per_word(config.bpw));
> +		if (ret)
> +			return ret;
> +	}
> +
>  	spi_imx->devtype_data->config(spi_imx, &config);
>  
>  	return 0;
> @@ -829,10 +912,8 @@ static void spi_imx_sdma_exit(struct spi_imx_data *spi_imx)
>  }
>  
>  static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
> -			     struct spi_master *master,
> -			     const struct resource *res)
> +			     struct spi_master *master)
>  {
> -	struct dma_slave_config slave_config = {};
>  	int ret;
>  
>  	/* use pio mode for i.mx6dl chip TKT238285 */
> @@ -850,16 +931,6 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
>  		goto err;
>  	}
>  
> -	slave_config.direction = DMA_MEM_TO_DEV;
> -	slave_config.dst_addr = res->start + MXC_CSPITXDATA;
> -	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> -	slave_config.dst_maxburst = spi_imx->wml;
> -	ret = dmaengine_slave_config(master->dma_tx, &slave_config);
> -	if (ret) {
> -		dev_err(dev, "error in TX dma configuration.\n");
> -		goto err;
> -	}
> -
>  	/* Prepare for RX : */
>  	master->dma_rx = dma_request_slave_channel_reason(dev, "rx");
>  	if (IS_ERR(master->dma_rx)) {
> @@ -869,15 +940,7 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
>  		goto err;
>  	}
>  
> -	slave_config.direction = DMA_DEV_TO_MEM;
> -	slave_config.src_addr = res->start + MXC_CSPIRXDATA;
> -	slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> -	slave_config.src_maxburst = spi_imx->wml;
> -	ret = dmaengine_slave_config(master->dma_rx, &slave_config);
> -	if (ret) {
> -		dev_err(dev, "error in RX dma configuration.\n");
> -		goto err;
> -	}
> +	spi_imx_dma_configure(master, 1);

here it might make sense to check for returned error code.

>  
>  	init_completion(&spi_imx->dma_rx_completion);
>  	init_completion(&spi_imx->dma_tx_completion);
> @@ -1164,6 +1227,7 @@ static int spi_imx_probe(struct platform_device *pdev)
>  		ret = PTR_ERR(spi_imx->base);
>  		goto out_master_put;
>  	}
> +	spi_imx->base_phys = res->start;
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
> @@ -1204,7 +1268,7 @@ static int spi_imx_probe(struct platform_device *pdev)
>  	 * other chips.
>  	 */
>  	if (is_imx51_ecspi(spi_imx)) {
> -		ret = spi_imx_sdma_init(&pdev->dev, spi_imx, master, res);
> +		ret = spi_imx_sdma_init(&pdev->dev, spi_imx, master);
>  		if (ret == -EPROBE_DEFER)
>  			goto out_clk_put;
>  
> 

--
With best wishes,
Vladimir
