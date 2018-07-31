From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 31 Jul 2018 22:09:32 +0200
Subject: [PATCH v7 5/6] i2c: Add Actions Semiconductor Owl family S900
 I2C driver
In-Reply-To: <20180726154603.5089-6-manivannan.sadhasivam@linaro.org>
References: <20180726154603.5089-1-manivannan.sadhasivam@linaro.org>
 <20180726154603.5089-6-manivannan.sadhasivam@linaro.org>
Message-ID: <20180731200932.n7djds2rmqhclit5@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manivannan,

On Thu, Jul 26, 2018 at 09:16:02PM +0530, Manivannan Sadhasivam wrote:
> Add Actions Semiconductor Owl family S900 I2C driver.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Acked-by: Peter Rosin <peda@axentia.se>

Looks mostly good already. Thanks Peter for the initial review!

> +static irqreturn_t owl_i2c_interrupt(int irq, void *_dev)
> +{
> +	struct owl_i2c_dev *i2c_dev = _dev;
> +	struct i2c_msg *msg = i2c_dev->msg;
> +	unsigned long flags;
> +	unsigned int stat, fifostat;
> +
> +	spin_lock_irqsave(&i2c_dev->lock, flags);
> +
> +	fifostat = readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT);
> +	if (fifostat & OWL_I2C_FIFOSTAT_RNB) {
> +		dev_dbg(&i2c_dev->adap.dev, "received NACK from device\n");
> +		goto stop;
> +	}
> +
> +	stat = readl(i2c_dev->base + OWL_I2C_REG_STAT);
> +	if (stat & OWL_I2C_STAT_BEB) {
> +		dev_dbg(&i2c_dev->adap.dev, "bus error\n");
> +		goto stop;
> +	}

I wonder if you can't pass back the different errors to the upper
layers? Like -ENXIO for NACK and -EIO for bus error? We have a
convention for that and it seems your HW can support it. The different
error codes would then maybe also make the debug outputs obsolete.


> +	/*
> +	 * Here, -ENXIO will be returned if interrupt occurred but no
> +	 * read or write happened. Else if msg_ptr equals to message length,
> +	 * message count will be returned.
> +	 */
> +	ret = i2c_dev->msg_ptr == msg->len ? num : -ENXIO;

I'd think this kinda unusual construct could go then as well by just
returning the error code derived from the interrupt handler above.

> +static const struct i2c_adapter_quirks owl_i2c_quirks = {
> +	.flags		= I2C_AQ_COMB | I2C_AQ_COMB_WRITE_FIRST,
> +	.max_read_len   = 240,
> +	.max_write_len  = 240,
> +	.max_comb_1st_msg_len = 6,
> +	.max_comb_2nd_msg_len = 240,
> +};

Yay! Good use of the i2c_adapter_quirks struct :)

Regards,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180731/591d947b/attachment.sig>
