From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 25 Mar 2018 00:19:10 +0100
Subject: [PATCH v5 2/2] i2c: add support for Socionext SynQuacer I2C
 controller
In-Reply-To: <20180302083123.7259-3-ard.biesheuvel@linaro.org>
References: <20180302083123.7259-1-ard.biesheuvel@linaro.org>
 <20180302083123.7259-3-ard.biesheuvel@linaro.org>
Message-ID: <20180324231910.unzvwty3xia4mqu2@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

> +static int synquacer_i2c_master_start(struct synquacer_i2c *i2c,
> +				      struct i2c_msg *pmsg)
> +{
> +	unsigned char bsr, bcr;
> +
> +	if (pmsg->flags & I2C_M_RD)
> +		writeb((pmsg->addr << 1) | 1,
> +		       i2c->base + SYNQUACER_I2C_REG_DAR);
> +	else
> +		writeb(pmsg->addr << 1,
> +		       i2c->base + SYNQUACER_I2C_REG_DAR);

writeb(i2c_8bit_addr_from_msg(pmsg), i2c->base + SYNQUACER_I2C_REG_DAR);

?

> +static int synquacer_i2c_master_recover(struct synquacer_i2c *i2c)
> +{

This is the bus recovery mechanism with toggling SCL pulses, right?
That should be implemented using a 'struct i2c_bus_recovery_info' and
the core helpers.

> +static int synquacer_i2c_doxfer(struct synquacer_i2c *i2c,
> +				struct i2c_msg *msgs, int num)
> +{
> +	unsigned char bsr;
> +	unsigned long timeout, bb_timeout;
> +	int ret;
> +
> +	if (i2c->is_suspended)
> +		return -EBUSY;
> +
> +	synquacer_i2c_hw_init(i2c);
> +	bsr = readb(i2c->base + SYNQUACER_I2C_REG_BSR);
> +	if (bsr & SYNQUACER_I2C_BSR_BB) {
> +		dev_err(i2c->dev, "cannot get bus (bus busy)\n");
> +		return -EBUSY;
> +	}
> +
> +	init_completion(&i2c->completion);

reinit_completion? And init_completion() in probe()?

> +	/* ensure the stop has been through the bus */
> +	bb_timeout = jiffies + HZ;
> +	do {
> +		bsr = readb(i2c->base + SYNQUACER_I2C_REG_BSR);
> +		if (!(bsr & SYNQUACER_I2C_BSR_BB))
> +			return 0;
> +	} while (time_before(jiffies, bb_timeout));

Busy looping for one second? And won't the bus_free detection at the
beginning of a transfer do?

> +static int synquacer_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> +			      int num)
> +{
> +	struct synquacer_i2c *i2c;
> +	int retry;
> +	int ret;
> +
> +	if (!msgs)
> +		return -EINVAL;
> +	if (num <= 0)
> +		return -EINVAL;

Hmm, this should be done by the core. I am surprised it doesn't do that yet :/

> +
> +	i2c = i2c_get_adapdata(adap);
> +	i2c->timeout_ms = calc_timeout_ms(i2c, msgs, num);
> +
> +	dev_dbg(i2c->dev, "calculated timeout %d ms\n", i2c->timeout_ms);
> +
> +	for (retry = 0; retry < adap->retries; retry++) {
> +
> +		ret = synquacer_i2c_doxfer(i2c, msgs, num);
> +		if (ret != -EAGAIN)
> +			return ret;
> +
> +		dev_dbg(i2c->dev, "Retrying transmission (%d)\n", retry);
> +
> +		synquacer_i2c_master_recover(i2c);

Recovery is only when SDA is stuck low, held by a client. That is
nothing you should do just on any error.

If you want the driver in v4.17, I'd suggest to drop
synquacer_i2c_master_recover() now and add it incrementally later, using
the existing recovery infrastructure. The rest is only minor stuff and
needs not much further discussion IMO.

Regards,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180325/d7e0d664/attachment-0001.sig>
