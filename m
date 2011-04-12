From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 12 Apr 2011 05:57:34 +0100
Subject: [PATCH] i2c: QUP based bus driver for Qualcomm MSM chipsets
In-Reply-To: <1302573749-15647-1-git-send-email-kheitke@codeaurora.org>
References: <1302573749-15647-1-git-send-email-kheitke@codeaurora.org>
Message-ID: <20110412045733.GA21059@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2011 at 08:02:27PM -0600, Kenneth Heitke wrote:

> mini-core. The driver supports FIFO mode (for low bandwidth applications)
> and block mode (interrupt generated for each block-size data transfer).
> The driver currently does not support DMA transfers.

> +static inline void qup_i2c_pwr_disable(struct qup_i2c_dev *dev)
> +{
> +	dev_dbg(dev->dev, "%s\n", __func__);
> +
> +	if (pm_runtime_enabled(dev->dev)) {
> +		pm_runtime_mark_last_busy(dev->dev);
> +		pm_runtime_put_sync(dev->dev);
> +	} else
> +		qup_i2c_clk_disable(dev);
> +}

What happens if someone changes the pm_runtime configuration in between
a pwr_disable() and the corresponding enable?

> +static void
> +qup_issue_read(struct qup_i2c_dev *dev, struct i2c_msg *msg, int *idx,
> +		uint32_t carry_over)
> +{
> +	uint16_t addr = (msg->addr << 1) | 1;
> +	/*
> +	 * QUP limit 256 bytes per read. By HW design, 0 in the 8-bit field
> +	 * is treated as 256 byte read.
> +	 */
> +	uint16_t rd_len = ((dev->cnt == 256) ? 0 : dev->cnt);

This is a substantila incompatibility with most I2C ccontrollers i the
kernel.  Is it possible for the driver to deal with this transparently,
for example by expanding into a number of continued transfers?  If not
we should add support to the I2C core for determining transfer limits,
the 256 bytes limit is pretty low.

> +		/* HW limits Read upto 256 bytes in 1 read without stop */
> +		if (dev->msg->flags & I2C_M_RD) {
> +			qup_set_read_mode(dev, dev->cnt);
> +			if (dev->cnt > 256)
> +				dev->cnt = 256;

This definitely seems buggy - there's no error returned to the caller?
