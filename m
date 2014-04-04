From: marex@denx.de (Marek Vasut)
Date: Fri, 4 Apr 2014 16:28:55 +0200
Subject: [PATCH v4 1/2] i2c: add DMA support for freescale i2c driver
In-Reply-To: <1396579272-19542-2-git-send-email-yao.yuan@freescale.com>
References: <1396579272-19542-1-git-send-email-yao.yuan@freescale.com>
 <1396579272-19542-2-git-send-email-yao.yuan@freescale.com>
Message-ID: <201404041628.55471.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, April 04, 2014 at 04:41:11 AM, Yuan Yao wrote:
> Add dma support for i2c. This function depend on DMA driver.
> You can turn on it by write both the dmas and dma-name properties in dts
> node.
> 
> Signed-off-by: Yuan Yao <yao.yuan@freescale.com>

[...]

Since you will be fixing that superfluous return 0; (I actually wonder, did you 
really test the driver at all before submitting it?) ...

> +static int i2c_imx_dma_xfer(struct imx_i2c_struct *i2c_imx,
> +					struct i2c_msg *msgs)
> +{
> +	struct imx_i2c_dma *dma = i2c_imx->dma;
> +	struct dma_async_tx_descriptor *txdesc;
> +	struct device *dev = &i2c_imx->adapter.dev;
> +
> +	dma->dma_buf = dma_map_single(dma->chan_using->device->dev, msgs->buf,

Please fix this "noodle" here too, the chain of pointers is quite long, you can 
just define a variable for that.

> +					dma->dma_len, dma->dma_data_dir);
> +	if (dma_mapping_error(dma->chan_using->device->dev, dma->dma_buf)) {
> +		dev_err(dev, "DMA mapping failed\n");
> +		return -EINVAL;
> +	}
> +
> +	txdesc = dmaengine_prep_slave_single(dma->chan_using, dma->dma_buf,
> +					dma->dma_len, dma->dma_transfer_dir,
> +					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +	if (!txdesc) {
> +		dev_err(dev, "Not able to get desc for DMA xfer\n");
> +		dma_unmap_single(dma->chan_using->device->dev, dma->dma_buf,
> +					dma->dma_len, dma->dma_data_dir);
> +		return -EINVAL;
> +	}
> +
> +	txdesc->callback = i2c_imx_dma_callback;
> +	txdesc->callback_param = i2c_imx;
> +	dmaengine_submit(txdesc);
> +	dma_async_issue_pending(dma->chan_using);
> +
> +	return 0;
> +}
[...]

Other than those two things,

Reviewed-by: Marek Vasut <marex@denx.de>
