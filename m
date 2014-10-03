From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 3 Oct 2014 09:54:41 +0200
Subject: [PATCH v8 1/2] i2c: imx: add DMA support for freescale i2c driver
In-Reply-To: <1411632689-31531-2-git-send-email-yao.yuan@freescale.com>
References: <1411632689-31531-1-git-send-email-yao.yuan@freescale.com>
 <1411632689-31531-2-git-send-email-yao.yuan@freescale.com>
Message-ID: <20141003075441.GA1349@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

thanks for this submission. Here is my review.

On Thu, Sep 25, 2014 at 04:11:28PM +0800, Yuan Yao wrote:
> Add dma support for i2c. This function depend on DMA driver.
> You can turn on it by write both the dmas and dma-name properties in dts node.
> DMA is optional, even DMA request unsuccessfully, i2c can also work well.
> 
> Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
> ---
>  drivers/i2c/busses/i2c-imx.c | 352 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 342 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 613069b..c643756 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -37,22 +37,27 @@
>  /** Includes *******************************************************************
>  *******************************************************************************/
>  
> -#include <linux/init.h>
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dmapool.h>
>  #include <linux/errno.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
> -#include <linux/delay.h>
>  #include <linux/i2c.h>
> +#include <linux/init.h>
>  #include <linux/io.h>
> -#include <linux/sched.h>
> -#include <linux/platform_device.h>
> -#include <linux/clk.h>
> -#include <linux/slab.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/of_dma.h>
>  #include <linux/platform_data/i2c-imx.h>
> +#include <linux/platform_device.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>

This is a seperate patch.

> @@ -432,6 +587,168 @@ static irqreturn_t i2c_imx_isr(int irq, void *dev_id)
>  	return IRQ_NONE;
>  }
>  
> +static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
> +					struct i2c_msg *msgs)
> +{
> +	int result;
> +	unsigned int temp = 0;
> +	unsigned long orig_jiffies = jiffies;
> +	struct imx_i2c_dma *dma = i2c_imx->dma;
> +	struct device *dev = &i2c_imx->adapter.dev;
> +
> +	dev_dbg(dev, "<%s> write slave address: addr=0x%x\n",
> +		__func__, msgs->addr << 1);

That debug should really go. We have other means to display ongoing I2C
transactions and their address.

> +
> +	dma->chan_using = dma->chan_tx;
> +	dma->dma_transfer_dir = DMA_MEM_TO_DEV;
> +	dma->dma_data_dir = DMA_TO_DEVICE;
> +	dma->dma_len = msgs->len - 1;
> +	result = i2c_imx_dma_xfer(i2c_imx, msgs);
> +	if (result)
> +		return result;
> +
> +	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> +	temp |= I2CR_DMAEN;
> +	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> +
> +	/*
> +	 * Write slave address.
> +	 * The first byte muse be transmitted by the CPU.

"must"

> +	 */
> +	imx_i2c_write_reg(msgs->addr << 1, i2c_imx, IMX_I2C_I2DR);
> +	reinit_completion(&i2c_imx->dma->cmd_complete);
> +	result = wait_for_completion_interruptible_timeout(
> +				&i2c_imx->dma->cmd_complete,
> +				msecs_to_jiffies(IMX_I2C_DMA_TIMEOUT));
> +	if (result <= 0) {
> +		dmaengine_terminate_all(dma->chan_using);
> +		if (result)
> +			return result;
> +		else
> +			return -ETIMEDOUT;
> +	}
> +
> +	/* Waiting for Transfer complete. */

"transfer"

> +	while (1) {
> +		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> +		if (temp & I2SR_ICF)
> +			break;
> +		if (time_after(jiffies, orig_jiffies +
> +				msecs_to_jiffies(IMX_I2C_DMA_TIMEOUT))) {
> +			dev_dbg(dev, "<%s> Timeout\n", __func__);
> +			return -ETIMEDOUT;
> +		}
> +		schedule();

That might have been asked before. Is there no interrupt for this?

> +	}
> +
> +	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> +	temp &= ~I2CR_DMAEN;
> +	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> +
> +	/* The last data byte must be transferred by the CPU. */
> +	imx_i2c_write_reg(msgs->buf[msgs->len-1],
> +				i2c_imx, IMX_I2C_I2DR);
> +	result = i2c_imx_trx_complete(i2c_imx);
> +	if (result)
> +		return result;
> +
> +	result = i2c_imx_acked(i2c_imx);
> +	if (result)
> +		return result;
> +
> +	return 0;
> +}
> +
> +static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
> +			struct i2c_msg *msgs, bool is_lastmsg)
> +{
> +	int result;
> +	unsigned int temp;
> +	unsigned long orig_jiffies;
> +	struct imx_i2c_dma *dma = i2c_imx->dma;
> +	struct device *dev = &i2c_imx->adapter.dev;
> +
> +	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> +	temp |= I2CR_DMAEN;
> +	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> +
> +	dma->chan_using = dma->chan_rx;
> +	dma->dma_transfer_dir = DMA_DEV_TO_MEM;
> +	dma->dma_data_dir = DMA_FROM_DEVICE;
> +	/* The last two data bytes must be transferred by the CPU. */
> +	dma->dma_len = msgs->len - 2;
> +	result = i2c_imx_dma_xfer(i2c_imx, msgs);
> +	if (result)
> +		return result;
> +
> +	reinit_completion(&i2c_imx->dma->cmd_complete);
> +	result = wait_for_completion_interruptible_timeout(
> +				&i2c_imx->dma->cmd_complete,
> +				msecs_to_jiffies(IMX_I2C_DMA_TIMEOUT));
> +	if (result <= 0) {
> +		dmaengine_terminate_all(dma->chan_using);
> +		if (result)
> +			return result;
> +		else
> +			return -ETIMEDOUT;

return result ?: -ETIMEDOUT;

> +	}
> +
> +	/* waiting for Transfer complete. */

"transfer"

> +	while (1) {
> +		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> +		if (temp & I2SR_ICF)
> +			break;
> +		if (time_after(jiffies, orig_jiffies +
> +				msecs_to_jiffies(IMX_I2C_DMA_TIMEOUT))) {
> +			dev_dbg(dev, "<%s> Timeout\n", __func__);
> +			return -ETIMEDOUT;
> +		}
> +		schedule();
> +	}
> +
> +	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> +	temp &= ~I2CR_DMAEN;
> +	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> +
> +	/* read n-1 byte data */
> +	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> +	temp |= I2CR_TXAK;
> +	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> +
> +	msgs->buf[msgs->len-2] = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
> +	/* read n byte data */
> +	result = i2c_imx_trx_complete(i2c_imx);
> +	if (result)
> +		return result;
> +
> +	if (is_lastmsg) {
> +		/*
> +		 * It must generate STOP before read I2DR to prevent
> +		 * controller from generating another clock cycle
> +		 */
> +		dev_dbg(dev, "<%s> clear MSTA\n", __func__);
> +		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> +		temp &= ~(I2CR_MSTA | I2CR_MTX);
> +		imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> +		i2c_imx_bus_busy(i2c_imx, 0);
> +		i2c_imx->stopped = 1;
> +	} else {
> +		/*
> +		 * For i2c master receiver repeat restart operation like:
> +		 * read -> repeat MSTA -> read/write
> +		 * The controller must set MTX before read the last byte in
> +		 * the first read operation, otherwise the first read cost
> +		 * one extra clock cycle.
> +		 */
> +		temp = readb(i2c_imx->base + IMX_I2C_I2CR);
> +		temp |= I2CR_MTX;
> +		writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
> +	}
> +	msgs->buf[msgs->len-1] = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
> +
> +	return 0;
> +}
> +
>  static int i2c_imx_write(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs)
>  {
>  	int i, result;
> @@ -501,6 +818,9 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs, bo
>  
>  	dev_dbg(&i2c_imx->adapter.dev, "<%s> read data\n", __func__);
>  
> +	if (i2c_imx->dma && msgs->len >= IMX_I2C_DMA_THRESHOLD && !block_data)
> +		return i2c_imx_dma_read(i2c_imx, msgs, is_lastmsg);
> +
>  	/* read data */
>  	for (i = 0; i < msgs->len; i++) {
>  		u8 len = 0;
> @@ -615,8 +935,12 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
>  #endif
>  		if (msgs[i].flags & I2C_M_RD)
>  			result = i2c_imx_read(i2c_imx, &msgs[i], is_lastmsg);
> -		else
> -			result = i2c_imx_write(i2c_imx, &msgs[i]);
> +		else {
> +			if (i2c_imx->dma && msgs[i].len >= IMX_I2C_DMA_THRESHOLD)
> +				result = i2c_imx_dma_write(i2c_imx, &msgs[i]);
> +			else
> +				result = i2c_imx_write(i2c_imx, &msgs[i]);
> +		}
>  		if (result)
>  			goto fail0;
>  	}
> @@ -651,6 +975,7 @@ static int i2c_imx_probe(struct platform_device *pdev)
>  	struct imxi2c_platform_data *pdata = dev_get_platdata(&pdev->dev);
>  	void __iomem *base;
>  	int irq, ret;
> +	dma_addr_t phy_addr;
>  
>  	dev_dbg(&pdev->dev, "<%s>\n", __func__);
>  
> @@ -661,6 +986,7 @@ static int i2c_imx_probe(struct platform_device *pdev)
>  	}
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	phy_addr = (dma_addr_t)res->start;

res can be NULL! Move it after it has been checked...

>  	base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);

...here.


> @@ -740,6 +1066,9 @@ static int i2c_imx_probe(struct platform_device *pdev)
>  		i2c_imx->adapter.name);
>  	dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
>  
> +	/* Init DMA config if support*/
> +	i2c_imx_dma_request(i2c_imx, phy_addr);
> +
>  	return 0;   /* Return OK */
>  }
>  
> @@ -751,6 +1080,9 @@ static int i2c_imx_remove(struct platform_device *pdev)
>  	dev_dbg(&i2c_imx->adapter.dev, "adapter removed\n");
>  	i2c_del_adapter(&i2c_imx->adapter);
>  
> +	if (i2c_imx->dma)
> +		i2c_imx_dma_free(i2c_imx);
> +

Looks mostly good, though.

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141003/42eebc93/attachment.sig>
