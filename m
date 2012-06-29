From: marex@denx.de (Marek Vasut)
Date: Fri, 29 Jun 2012 11:33:09 +0200
Subject: [PATCH 1/2] MXS: Set I2C timing registers for mxs-i2c
In-Reply-To: <20120629090602.GI5844@shlinux2.ap.freescale.net>
References: <1340958243-2332-1-git-send-email-marex@denx.de>
 <20120629090602.GI5844@shlinux2.ap.freescale.net>
Message-ID: <201206291133.09379.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Dong Aisheng,

> Hi Marek,
> 
> On Fri, Jun 29, 2012 at 04:24:02PM +0800, Marek Vasut wrote:
> > This patch configures the I2C bus timing registers according
> > to information passed via DT. Currently, 100kHz and 400kHz
> > modes are supported.
> > 
> > The TIMING2 register value is wrong in the documentation for
> > 
> > i.MX28! This was found and fixed by:
> >   Shawn Guo <shawn.guo@linaro.org>
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Detlev Zundel <dzu@denx.de>
> > CC: Dong Aisheng <b29396@freescale.com>
> > CC: Fabio Estevam <fabio.estevam@freescale.com>
> > Cc: Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
> > Cc: linux-i2c at vger.kernel.org
> > CC: Sascha Hauer <s.hauer@pengutronix.de>
> > CC: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Stefano Babic <sbabic@denx.de>
> > CC: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > Cc: Wolfgang Denk <wd@denx.de>
> > Cc: Wolfram Sang <w.sang@pengutronix.de>
> > ---
> > 
> >  Documentation/devicetree/bindings/i2c/i2c-mxs.txt |    1 +
> >  arch/arm/boot/dts/imx28.dtsi                      |    2 +
> >  drivers/i2c/busses/i2c-mxs.c                      |   56
> >  +++++++++++++++++++++ 3 files changed, 59 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> > b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt index
> > 1bfc02d..d2bf750 100644
> > --- a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> > 
> > @@ -4,6 +4,7 @@ Required properties:
> >  - compatible: Should be "fsl,<chip>-i2c"
> >  - reg: Should contain registers location and length
> >  - interrupts: Should contain ERROR and DMA interrupts
> > 
> > +- clock-frequency: desired I2C bus clock frequency in Hz.
> 
> Is this required properties?
> If yes, it may be good to also update examples.

Good point

> 
> >  Examples:
> > diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> > index ee3778a..832d30a 100644
> > --- a/arch/arm/boot/dts/imx28.dtsi
> > +++ b/arch/arm/boot/dts/imx28.dtsi
> > @@ -419,6 +419,7 @@
> > 
> >  				compatible = "fsl,imx28-i2c";
> >  				reg = <0x80058000 2000>;
> >  				interrupts = <111 68>;
> > 
> > +				clock-frequency = <400000>;
> > 
> >  				status = "disabled";
> >  			
> >  			};
> > 
> > @@ -428,6 +429,7 @@
> > 
> >  				compatible = "fsl,imx28-i2c";
> >  				reg = <0x8005a000 2000>;
> >  				interrupts = <110 69>;
> > 
> > +				clock-frequency = <400000>;
> > 
> >  				status = "disabled";
> >  			
> >  			};
> > 
> > diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
> > index 04eb441..cdcfd3f 100644
> > --- a/drivers/i2c/busses/i2c-mxs.c
> > +++ b/drivers/i2c/busses/i2c-mxs.c
> > @@ -46,6 +46,10 @@
> > 
> >  #define MXS_I2C_CTRL0_DIRECTION			0x00010000
> >  #define MXS_I2C_CTRL0_XFER_COUNT(v)		((v) & 0x0000FFFF)
> > 
> > +#define MXS_I2C_TIMING0		(0x10)
> > +#define MXS_I2C_TIMING1		(0x20)
> > +#define MXS_I2C_TIMING2		(0x30)
> > +
> > 
> >  #define MXS_I2C_CTRL1		(0x40)
> >  #define MXS_I2C_CTRL1_SET	(0x44)
> >  #define MXS_I2C_CTRL1_CLR	(0x48)
> > 
> > @@ -97,6 +101,25 @@
> > 
> >  #define MXS_CMD_I2C_READ	(MXS_I2C_CTRL0_SEND_NAK_ON_LAST | \
> >  
> >  				 MXS_I2C_CTRL0_MASTER_MODE)
> > 
> > +struct mxs_i2c_speed_config {
> > +	uint32_t	timing0;
> > +	uint32_t	timing1;
> > +	uint32_t	timing2;
> > +};
> > +
> > +/* Timing values for the default 24MHz clock supplied into the i2c
> > block. */
> 
> I did not check spec,
> is it possible the supplied clock changed?

It's possible indeed ... Shawn?

> > +const struct mxs_i2c_speed_config mxs_i2c_95kHz_config = {
> 
> Do we need static for it?

MX28 datasheet 27.5.2 - 27.5.4 ... there was a discussion about these in the 
thread under older patches. Those shall explain your questions below.

> > +	.timing0	= 0x00780030,
> > +	.timing1	= 0x00800030,
> > +	.timing2	= 0x00300030,
> > +};
> > +
> > +const struct mxs_i2c_speed_config mxs_i2c_400kHz_config = {
> 
> ditto
> 
> > +	.timing0	= 0x000f0007,
> > +	.timing1	= 0x001f000f,
> > +	.timing2	= 0x00300030,
> > +};
> > +
> > 
> >  /**
> >  
> >   * struct mxs_i2c_dev - per device, private MXS-I2C data
> >   *
> > 
> > @@ -112,11 +135,17 @@ struct mxs_i2c_dev {
> > 
> >  	struct completion cmd_complete;
> >  	u32 cmd_err;
> >  	struct i2c_adapter adapter;
> > 
> > +	const struct mxs_i2c_speed_config *speed;
> > 
> >  };
> >  
> >  static void mxs_i2c_reset(struct mxs_i2c_dev *i2c)
> >  {
> >  
> >  	stmp_reset_block(i2c->regs);
> > 
> > +
> > +	writel(i2c->speed->timing0, i2c->regs + MXS_I2C_TIMING0);
> > +	writel(i2c->speed->timing1, i2c->regs + MXS_I2C_TIMING1);
> > +	writel(i2c->speed->timing2, i2c->regs + MXS_I2C_TIMING2);
> > +
> > 
> >  	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_SET);
> >  	writel(MXS_I2C_QUEUECTRL_PIO_QUEUE_MODE,
> >  	
> >  			i2c->regs + MXS_I2C_QUEUECTRL_SET);
> > 
> > @@ -319,6 +348,28 @@ static const struct i2c_algorithm mxs_i2c_algo = {
> > 
> >  	.functionality = mxs_i2c_func,
> >  
> >  };
> > 
> > +static int mxs_i2c_get_ofdata(struct mxs_i2c_dev *i2c)
> > +{
> > +	uint32_t speed;
> > +	struct device *dev = i2c->dev;
> > +	struct device_node *node = dev->of_node;
> > +	int ret;
> > +
> > +	if (!node)
> > +		return -EINVAL;
> > +
> > +	i2c->speed = &mxs_i2c_95kHz_config;
> 
> Can you explain why here is 95khz rather than 100kh?
> It seems this is for 100khz below.
> 
> > +	ret = of_property_read_u32(node, "clock-frequency", &speed);
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
> > 
> >  static int __devinit mxs_i2c_probe(struct platform_device *pdev)
> >  {
> >  
> >  	struct device *dev = &pdev->dev;
> > 
> > @@ -358,6 +409,11 @@ static int __devinit mxs_i2c_probe(struct
> > platform_device *pdev)
> > 
> >  		return err;
> >  	
> >  	i2c->dev = dev;
> > 
> > +
> > +	err = mxs_i2c_get_ofdata(i2c);
> > +	if (err)
> > +		return err;
> > +
> > 
> >  	platform_set_drvdata(pdev, i2c);
> >  	
> >  	/* Do reset to enforce correct startup after pinmuxing */
> 
> Regards
> Dong Aisheng
