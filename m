From: marex@denx.de (Marek Vasut)
Date: Mon, 11 Jun 2012 12:54:21 +0200
Subject: [PATCH 1/2 V3] MXS: Set I2C timing registers for mxs-i2c
In-Reply-To: <20120611063903.GD2552@S2101-09.ap.freescale.net>
References: <1339242351-8797-1-git-send-email-marex@denx.de>
 <20120611063903.GD2552@S2101-09.ap.freescale.net>
Message-ID: <201206111254.21766.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Sat, Jun 09, 2012 at 01:45:50PM +0200, Marek Vasut wrote:
> > This patch configures the I2C bus timing registers according
> > to information passed via DT. Currently, 100kHz and 400kHz
> > modes are supported.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> 
> I gave it a test on imx28-evk board with audio playback.  It seems
> the patch makes the first time playback non-functional, but the later
> playback is still working.

Any hints what can be the source of this issue? I tested it with i2c eeprom, saw 
no issues in there. I'll poke into it later.

> > +static int mxs_i2c_get_ofdata(struct mxs_i2c_dev *i2c)
> > +{
> > +	uint32_t speed;
> > +	struct device *dev = i2c->dev;
> > +	struct device_node *node = dev->of_node;
> > +
> > +	if (!node)
> > +		return -EINVAL;
> > +
> > +	i2c->speed = &mxs_i2c_95kHz_config;
> > +	ret = of_property_read_u32(node, "clock-frequency", &speed);
> 
> "ret" is undeclared.
> 
> > +	if (ret)
> > +		dev_warn(dev, "No I2C speed selected, using 100kHz\n");
> > +	else if (speed == 400000)
> > +		i2c->speed = &mxs_i2c_400kHz_config;
> > +	else if (speed != 100000)
> > +		dev_warn(dev, "Invalid I2C speed selected, using 100kHz\n");
> > +
> > +	return 0;
> > +}
> > +

Best regards,
Marek Vasut
