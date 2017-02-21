From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 21 Feb 2017 23:23:25 +0100
Subject: [PATCH v7 3/3] i2c: zx2967: add i2c controller driver for ZTE's
 zx2967 family
In-Reply-To: <1487224844-10973-3-git-send-email-baoyou.xie@linaro.org>
References: <1487224844-10973-1-git-send-email-baoyou.xie@linaro.org>
 <1487224844-10973-3-git-send-email-baoyou.xie@linaro.org>
Message-ID: <20170221222325.7w2h3w2qp2n2gzte@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> +static int
> +zx2967_i2c_xfer_read_bytes(struct zx2967_i2c_info *zx_i2c, u32 bytes)
> +{
> +	unsigned long time_left;
> +
> +	reinit_completion(&zx_i2c->complete);
> +	zx2967_i2c_writel(zx_i2c, bytes - 1, REG_RDCONF);
> +	zx2967_i2c_start_ctrl(zx_i2c);
> +
> +	time_left = wait_for_completion_timeout(&zx_i2c->complete,
> +				I2C_TIMEOUT);
> +	if (time_left == 0) {
> +		dev_err(DEV(zx_i2c), "read i2c transfer timed out\n");
> +		disable_irq(zx_i2c->irq);
> +		zx2967_i2c_reset_hardware(zx_i2c);
> +		return -EIO;
> +	}
> +
> +	return zx2967_i2c_empty_rx_fifo(zx_i2c, bytes);
> +}

Timeouts do happen on an I2C bus (e.g. when an EEPROM is in an erase
cycle). Or try 'i2cdetect -r'. At least, the dev_err should go. But I
also wonder if you really need to reset the hardware?

> +static int zx2967_i2c_xfer_read(struct zx2967_i2c_info *zx_i2c)
> +{
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < zx_i2c->access_cnt; i++) {
> +		ret = zx2967_i2c_xfer_read_bytes(zx_i2c, I2C_FIFO_MAX);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (zx_i2c->residue > 0) {
> +		ret = zx2967_i2c_xfer_read_bytes(zx_i2c, zx_i2c->residue);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	zx_i2c->residue = 0;
> +	zx_i2c->access_cnt = 0;
> +	return 0;
> +}
> +

This function...

> +static int zx2967_i2c_xfer_write(struct zx2967_i2c_info *zx_i2c)
> +{
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < zx_i2c->access_cnt; i++) {
> +		ret = zx2967_i2c_xfer_write_bytes(zx_i2c, I2C_FIFO_MAX);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (zx_i2c->residue > 0) {
> +		ret = zx2967_i2c_xfer_write_bytes(zx_i2c, zx_i2c->residue);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	zx_i2c->residue = 0;
> +	zx_i2c->access_cnt = 0;
> +	return 0;
> +}

... and this are one example where the read- and write-counterparts are
very similar. I wonder if we would do better having just one function
and handle the difference with some if(). Example here: If you'd unify
zx2967_i2c_xfer_write_bytes() and zx2967_i2c_xfer_read_bytes() into one
generic function then zx2967_i2c_xfer_write() and zx2967_i2c_xfer_read
automatically become identical AFAICS. Thoughts?

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170221/d95b05b1/attachment.sig>
