From: maitysanchayan@gmail.com (maitysanchayan at gmail.com)
Date: Mon, 17 Oct 2016 11:53:08 +0530
Subject: [PATCH v2] spi: spi-fsl-dspi: Add DMA support for Vybrid
In-Reply-To: <607397542d083f13dc98909958672eeb0d326c79.1475578195.git.maitysanchayan@gmail.com>
References: <8ccf4f2f4e6739410d9e242f9d0e3f3bcc76d0e2.1475498805.git.maitysanchayan@gmail.com>
 <607397542d083f13dc98909958672eeb0d326c79.1475578195.git.maitysanchayan@gmail.com>
Message-ID: <20161017062308.GA3478@Sanchayan-Arch.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Ping?

Regards,
Sanchayan.

On 16-10-04 16:28:33, Sanchayan Maity wrote:
> Add DMA support for Vybrid.
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> ---
> Changes since v1:
> - Change in the dspi_dma_xfer function. Use more apt DSPI_FIFO_SIZE
> instead of sizeof(u32)
> - Do not set RSER on every iteration of loop
> 
> Tested on Toradex Colibri Vybrid VF61 module with spi based MCP CAN 251x
> and spidev using RX/TX loopback and based on shawn's for-next branch
> currently at 4.8-rc1.
> 
> Regards,
> Sanchayan.
> ---
>  drivers/spi/spi-fsl-dspi.c | 291 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 291 insertions(+)
> 
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 9e9dadb..0f81075 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -15,6 +15,8 @@
>  
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/err.h>
>  #include <linux/errno.h>
>  #include <linux/interrupt.h>
> @@ -40,6 +42,7 @@
>  #define TRAN_STATE_WORD_ODD_NUM	0x04
>  
>  #define DSPI_FIFO_SIZE			4
> +#define DSPI_DMA_BUFSIZE		(DSPI_FIFO_SIZE * 1024)
>  
>  #define SPI_MCR		0x00
>  #define SPI_MCR_MASTER		(1 << 31)
> @@ -71,6 +74,11 @@
>  #define SPI_SR_EOQF		0x10000000
>  #define SPI_SR_TCFQF		0x80000000
>  
> +#define SPI_RSER_TFFFE		BIT(25)
> +#define SPI_RSER_TFFFD		BIT(24)
> +#define SPI_RSER_RFDFE		BIT(17)
> +#define SPI_RSER_RFDFD		BIT(16)
> +
>  #define SPI_RSER		0x30
>  #define SPI_RSER_EOQFE		0x10000000
>  #define SPI_RSER_TCFQE		0x80000000
> @@ -108,6 +116,8 @@
>  
>  #define SPI_TCR_TCNT_MAX	0x10000
>  
> +#define DMA_COMPLETION_TIMEOUT	msecs_to_jiffies(3000)
> +
>  struct chip_data {
>  	u32 mcr_val;
>  	u32 ctar_val;
> @@ -117,6 +127,7 @@ struct chip_data {
>  enum dspi_trans_mode {
>  	DSPI_EOQ_MODE = 0,
>  	DSPI_TCFQ_MODE,
> +	DSPI_DMA_MODE,
>  };
>  
>  struct fsl_dspi_devtype_data {
> @@ -139,6 +150,22 @@ static const struct fsl_dspi_devtype_data ls2085a_data = {
>  	.max_clock_factor = 8,
>  };
>  
> +struct fsl_dspi_dma {
> +	u32 curr_xfer_len;
> +
> +	u32 *tx_dma_buf;
> +	struct dma_chan *chan_tx;
> +	dma_addr_t tx_dma_phys;
> +	struct completion cmd_tx_complete;
> +	struct dma_async_tx_descriptor *tx_desc;
> +
> +	u32 *rx_dma_buf;
> +	struct dma_chan *chan_rx;
> +	dma_addr_t rx_dma_phys;
> +	struct completion cmd_rx_complete;
> +	struct dma_async_tx_descriptor *rx_desc;
> +};
> +
>  struct fsl_dspi {
>  	struct spi_master	*master;
>  	struct platform_device	*pdev;
> @@ -165,6 +192,7 @@ struct fsl_dspi {
>  	u32			waitflags;
>  
>  	u32			spi_tcnt;
> +	struct fsl_dspi_dma	*dma;
>  };
>  
>  static inline int is_double_byte_mode(struct fsl_dspi *dspi)
> @@ -368,6 +396,259 @@ static void dspi_tcfq_read(struct fsl_dspi *dspi)
>  	dspi_data_from_popr(dspi, rx_word);
>  }
>  
> +static void dspi_tx_dma_callback(void *arg)
> +{
> +	struct fsl_dspi *dspi = arg;
> +	struct fsl_dspi_dma *dma = dspi->dma;
> +
> +	complete(&dma->cmd_tx_complete);
> +}
> +
> +static void dspi_rx_dma_callback(void *arg)
> +{
> +	struct fsl_dspi *dspi = arg;
> +	struct fsl_dspi_dma *dma = dspi->dma;
> +	int rx_word;
> +	int i, len;
> +	u16 d;
> +
> +	rx_word = is_double_byte_mode(dspi);
> +
> +	len = rx_word ? (dma->curr_xfer_len / 2) : dma->curr_xfer_len;
> +
> +	if (!(dspi->dataflags & TRAN_STATE_RX_VOID)) {
> +		for (i = 0; i < len; i++) {
> +			d = dspi->dma->rx_dma_buf[i];
> +			rx_word ? (*(u16 *)dspi->rx = d) :
> +						(*(u8 *)dspi->rx = d);
> +			dspi->rx += rx_word + 1;
> +		}
> +	}
> +
> +	complete(&dma->cmd_rx_complete);
> +}
> +
> +static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
> +{
> +	struct fsl_dspi_dma *dma = dspi->dma;
> +	struct device *dev = &dspi->pdev->dev;
> +	int time_left;
> +	int tx_word;
> +	int i, len;
> +	u16 val;
> +
> +	tx_word = is_double_byte_mode(dspi);
> +
> +	len = tx_word ? (dma->curr_xfer_len / 2) : dma->curr_xfer_len;
> +
> +	for (i = 0; i < len - 1; i++) {
> +		val = tx_word ? *(u16 *) dspi->tx : *(u8 *) dspi->tx;
> +		dspi->dma->tx_dma_buf[i] =
> +			SPI_PUSHR_TXDATA(val) | SPI_PUSHR_PCS(dspi->cs) |
> +			SPI_PUSHR_CTAS(0) | SPI_PUSHR_CONT;
> +		dspi->tx += tx_word + 1;
> +	}
> +
> +	val = tx_word ? *(u16 *) dspi->tx : *(u8 *) dspi->tx;
> +	dspi->dma->tx_dma_buf[i] = SPI_PUSHR_TXDATA(val) |
> +					SPI_PUSHR_PCS(dspi->cs) |
> +					SPI_PUSHR_CTAS(0);
> +	dspi->tx += tx_word + 1;
> +
> +	dma->tx_desc = dmaengine_prep_slave_single(dma->chan_tx,
> +					dma->tx_dma_phys,
> +					DSPI_DMA_BUFSIZE, DMA_MEM_TO_DEV,
> +					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +	if (!dma->tx_desc) {
> +		dev_err(dev, "Not able to get desc for DMA xfer\n");
> +		return -EIO;
> +	}
> +
> +	dma->tx_desc->callback = dspi_tx_dma_callback;
> +	dma->tx_desc->callback_param = dspi;
> +	if (dma_submit_error(dmaengine_submit(dma->tx_desc))) {
> +		dev_err(dev, "DMA submit failed\n");
> +		return -EINVAL;
> +	}
> +
> +	dma->rx_desc = dmaengine_prep_slave_single(dma->chan_rx,
> +					dma->rx_dma_phys,
> +					DSPI_DMA_BUFSIZE, DMA_DEV_TO_MEM,
> +					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +	if (!dma->rx_desc) {
> +		dev_err(dev, "Not able to get desc for DMA xfer\n");
> +		return -EIO;
> +	}
> +
> +	dma->rx_desc->callback = dspi_rx_dma_callback;
> +	dma->rx_desc->callback_param = dspi;
> +	if (dma_submit_error(dmaengine_submit(dma->rx_desc))) {
> +		dev_err(dev, "DMA submit failed\n");
> +		return -EINVAL;
> +	}
> +
> +	reinit_completion(&dspi->dma->cmd_rx_complete);
> +	reinit_completion(&dspi->dma->cmd_tx_complete);
> +
> +	dma_async_issue_pending(dma->chan_rx);
> +	dma_async_issue_pending(dma->chan_tx);
> +
> +	time_left = wait_for_completion_timeout(&dspi->dma->cmd_tx_complete,
> +					DMA_COMPLETION_TIMEOUT);
> +	if (time_left == 0) {
> +		dev_err(dev, "DMA tx timeout\n");
> +		dmaengine_terminate_all(dma->chan_tx);
> +		dmaengine_terminate_all(dma->chan_rx);
> +		return -ETIMEDOUT;
> +	}
> +
> +	time_left = wait_for_completion_timeout(&dspi->dma->cmd_rx_complete,
> +					DMA_COMPLETION_TIMEOUT);
> +	if (time_left == 0) {
> +		dev_err(dev, "DMA rx timeout\n");
> +		dmaengine_terminate_all(dma->chan_tx);
> +		dmaengine_terminate_all(dma->chan_rx);
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dspi_dma_xfer(struct fsl_dspi *dspi)
> +{
> +	struct fsl_dspi_dma *dma = dspi->dma;
> +	struct device *dev = &dspi->pdev->dev;
> +	int curr_remaining_bytes;
> +	int ret = 0;
> +
> +	curr_remaining_bytes = dspi->len;
> +	while (curr_remaining_bytes) {
> +		/* Check if current transfer fits the DMA buffer */
> +		dma->curr_xfer_len = curr_remaining_bytes;
> +		if (curr_remaining_bytes > DSPI_DMA_BUFSIZE / DSPI_FIFO_SIZE)
> +			dma->curr_xfer_len = DSPI_DMA_BUFSIZE / DSPI_FIFO_SIZE;
> +
> +		ret = dspi_next_xfer_dma_submit(dspi);
> +		if (ret) {
> +			dev_err(dev, "DMA transfer failed\n");
> +			goto exit;
> +
> +		} else {
> +			curr_remaining_bytes -= dma->curr_xfer_len;
> +			if (curr_remaining_bytes < 0)
> +				curr_remaining_bytes = 0;
> +			dspi->len = curr_remaining_bytes;
> +		}
> +	}
> +
> +exit:
> +	return ret;
> +}
> +
> +static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
> +{
> +	struct fsl_dspi_dma *dma;
> +	struct dma_slave_config cfg;
> +	struct device *dev = &dspi->pdev->dev;
> +	int ret;
> +
> +	dma = devm_kzalloc(dev, sizeof(*dma), GFP_KERNEL);
> +	if (!dma)
> +		return -ENOMEM;
> +
> +	dma->chan_rx = dma_request_slave_channel(dev, "rx");
> +	if (!dma->chan_rx) {
> +		dev_err(dev, "rx dma channel not available\n");
> +		ret = -ENODEV;
> +		return ret;
> +	}
> +
> +	dma->chan_tx = dma_request_slave_channel(dev, "tx");
> +	if (!dma->chan_tx) {
> +		dev_err(dev, "tx dma channel not available\n");
> +		ret = -ENODEV;
> +		goto err_tx_channel;
> +	}
> +
> +	dma->tx_dma_buf = dma_alloc_coherent(dev, DSPI_DMA_BUFSIZE,
> +					&dma->tx_dma_phys, GFP_KERNEL);
> +	if (!dma->tx_dma_buf) {
> +		ret = -ENOMEM;
> +		goto err_tx_dma_buf;
> +	}
> +
> +	dma->rx_dma_buf = dma_alloc_coherent(dev, DSPI_DMA_BUFSIZE,
> +					&dma->rx_dma_phys, GFP_KERNEL);
> +	if (!dma->rx_dma_buf) {
> +		ret = -ENOMEM;
> +		goto err_rx_dma_buf;
> +	}
> +
> +	cfg.src_addr = phy_addr + SPI_POPR;
> +	cfg.dst_addr = phy_addr + SPI_PUSHR;
> +	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	cfg.src_maxburst = 1;
> +	cfg.dst_maxburst = 1;
> +
> +	cfg.direction = DMA_DEV_TO_MEM;
> +	ret = dmaengine_slave_config(dma->chan_rx, &cfg);
> +	if (ret) {
> +		dev_err(dev, "can't configure rx dma channel\n");
> +		ret = -EINVAL;
> +		goto err_slave_config;
> +	}
> +
> +	cfg.direction = DMA_MEM_TO_DEV;
> +	ret = dmaengine_slave_config(dma->chan_tx, &cfg);
> +	if (ret) {
> +		dev_err(dev, "can't configure tx dma channel\n");
> +		ret = -EINVAL;
> +		goto err_slave_config;
> +	}
> +
> +	dspi->dma = dma;
> +	dspi->devtype_data->trans_mode = DSPI_DMA_MODE;
> +	init_completion(&dma->cmd_tx_complete);
> +	init_completion(&dma->cmd_rx_complete);
> +
> +	return 0;
> +
> +err_slave_config:
> +	devm_kfree(dev, dma->rx_dma_buf);
> +err_rx_dma_buf:
> +	devm_kfree(dev, dma->tx_dma_buf);
> +err_tx_dma_buf:
> +	dma_release_channel(dma->chan_tx);
> +err_tx_channel:
> +	dma_release_channel(dma->chan_rx);
> +
> +	devm_kfree(dev, dma);
> +	dspi->dma = NULL;
> +
> +	return ret;
> +}
> +
> +static void dspi_release_dma(struct fsl_dspi *dspi)
> +{
> +	struct fsl_dspi_dma *dma = dspi->dma;
> +	struct device *dev = &dspi->pdev->dev;
> +
> +	if (dma) {
> +		if (dma->chan_tx) {
> +			dma_unmap_single(dev, dma->tx_dma_phys,
> +					DSPI_DMA_BUFSIZE, DMA_TO_DEVICE);
> +			dma_release_channel(dma->chan_tx);
> +		}
> +
> +		if (dma->chan_rx) {
> +			dma_unmap_single(dev, dma->rx_dma_phys,
> +					DSPI_DMA_BUFSIZE, DMA_FROM_DEVICE);
> +			dma_release_channel(dma->chan_rx);
> +		}
> +	}
> +}
> +
>  static int dspi_transfer_one_message(struct spi_master *master,
>  		struct spi_message *message)
>  {
> @@ -424,6 +705,12 @@ static int dspi_transfer_one_message(struct spi_master *master,
>  			regmap_write(dspi->regmap, SPI_RSER, SPI_RSER_TCFQE);
>  			dspi_tcfq_write(dspi);
>  			break;
> +		case DSPI_DMA_MODE:
> +			regmap_write(dspi->regmap, SPI_RSER,
> +				SPI_RSER_TFFFE | SPI_RSER_TFFFD |
> +				SPI_RSER_RFDFE | SPI_RSER_RFDFD);
> +			status = dspi_dma_xfer(dspi);
> +			goto out;
>  		default:
>  			dev_err(&dspi->pdev->dev, "unsupported trans_mode %u\n",
>  				trans_mode);
> @@ -730,6 +1017,9 @@ static int dspi_probe(struct platform_device *pdev)
>  	}
>  	clk_prepare_enable(dspi->clk);
>  
> +	if (dspi_request_dma(dspi, res->start))
> +		dev_warn(&pdev->dev, "can't get dma channels\n");
> +
>  	master->max_speed_hz =
>  		clk_get_rate(dspi->clk) / dspi->devtype_data->max_clock_factor;
>  
> @@ -758,6 +1048,7 @@ static int dspi_remove(struct platform_device *pdev)
>  	struct fsl_dspi *dspi = spi_master_get_devdata(master);
>  
>  	/* Disconnect from the SPI framework */
> +	dspi_release_dma(dspi);
>  	clk_disable_unprepare(dspi->clk);
>  	spi_unregister_master(dspi->master);
>  	spi_master_put(dspi->master);
> -- 
> 2.10.0
> 
