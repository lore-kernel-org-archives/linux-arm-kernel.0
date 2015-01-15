From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 15 Jan 2015 13:07:05 +0100
Subject: [PATCH v4 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
In-Reply-To: <20150115084119.GN22880@pengutronix.de>
References: <rjui@broadcom.com>
 <1421274213-3544-1-git-send-email-rjui@broadcom.com>
 <1421274213-3544-3-git-send-email-rjui@broadcom.com>
 <20150115084119.GN22880@pengutronix.de>
Message-ID: <20150115120704.GB2549@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > +	iproc_i2c->msg = msg;
> Can it happen that iproc_i2c->msg still holds an uncompleted message
> here or is this serialized by the core? Wolfram? Either here something

We have per-adapter locks serializing transfers, if you mean that?

> > +static int bcm_iproc_i2c_cfg_speed(struct bcm_iproc_i2c_dev *iproc_i2c)
> > +{
> > +	unsigned int bus_speed, speed_bit;
> > +	u32 val;
> > +	int ret = of_property_read_u32(iproc_i2c->device->of_node,
> > +				       "clock-frequency", &bus_speed);
> > +	if (ret < 0) {
> > +		dev_err(iproc_i2c->device,
> > +			"missing clock-frequency property\n");
> > +		return -ENODEV;
> Is a missing property the only situation where of_property_read_u32
> returns an error? Would it be sane to default to 100 kHz?

Default of 100kHz instead of -ENODEV sounds very reasonable.

> > +static int bcm_iproc_i2c_remove(struct platform_device *pdev)
> > +{
> > +	struct bcm_iproc_i2c_dev *iproc_i2c = platform_get_drvdata(pdev);
> > +
> > +	i2c_del_adapter(&iproc_i2c->adapter);
> You need to free the irq before i2c_del_adapter.

One could also keep using devm_request_irq and disable all interrupts
sources here?

Thanks for the reviews, Uwe!

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150115/a47a65af/attachment.sig>
