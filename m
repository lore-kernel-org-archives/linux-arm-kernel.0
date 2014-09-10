From: b38343@freescale.com (Robin Gong)
Date: Wed, 10 Sep 2014 13:46:22 +0800
Subject: [PATCH v5] spi: spi-imx: add DMA support
In-Reply-To: <540FD084.6000805@gmail.com>
References: <1410312604-31949-1-git-send-email-b38343@freescale.com>
 <540FD084.6000805@gmail.com>
Message-ID: <20140910054621.GA29307@Robin-OptiPlex-780>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 09:46:04AM +0530, Varka Bhadram wrote:
> On 09/10/2014 07:00 AM, Robin Gong wrote:
> >Enable DMA support on i.mx6. The read speed can increase from 600KB/s
> >to 1.2MB/s on i.mx6q. You can disable or enable dma function in dts.
> 
> (...)
> 
> >+
> >+static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
> >+			     struct spi_master *master,
> >+			     const struct resource *res)
> >+{
> >+	struct dma_slave_config slave_config = {};
> >+	int ret;
> >+
> >+	/* Prepare for TX DMA: */
> >+	master->dma_tx = dma_request_slave_channel(dev, "tx");
> >+	if (!master->dma_tx) {
> >+		dev_err(dev, "cannot get the TX DMA channel!\n");
> >+		ret = -EINVAL;
> >+		goto err;
> >+	}
> >+
> >+	slave_config.direction = DMA_MEM_TO_DEV;
> >+	slave_config.dst_addr = res->start + MXC_CSPITXDATA;
> >+	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> >+	slave_config.dst_maxburst = spi_imx_get_fifosize(spi_imx) / 2;
> >+	ret = dmaengine_slave_config(master->dma_tx, &slave_config);
> >+	if (ret) {
> >+		dev_err(dev, "error in TX dma configuration.");
> >+		
> 
> Missed terminating new line..
>
You mean lack "\n" in the print info? If yes, I can improve it in v6.
> -- 
> Regards,
> Varka Bhadram.
> 
