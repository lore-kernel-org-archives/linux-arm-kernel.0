From: marc@cpdesign.com.au (Marc Reilly)
Date: Thu, 16 Dec 2010 19:30:17 +1100
Subject: [PATCHv2] mc13xxx: Add i2c support for mc13xxx-core
In-Reply-To: <20101216074730.GD1940@pengutronix.de>
References: <1292449675-20308-1-git-send-email-marc@cpdesign.com.au>
	<20101216074730.GD1940@pengutronix.de>
Message-ID: <201012161930.17299.marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Thanks for your comments. I have a couple of questions, but agree with all 
your comments on the whole.

> > 
> > -	struct spi_device *spidev;
> > +	union {
> > +		struct spi_device *spidev;
> > +		struct i2c_client *i2cclient;
> > +	};
> > +	struct device *pdev;
> 
> pdev is a usual name for 'struct platform_device's, so can you please
> use 'dev'?

no worries. 
(My old habit of putting a 'p' in front of every pointer name. But let's leave 
that there.. :)

> 
> > +	enum mc13xxx_id ictype;
> > +
> > 
> >  	struct mutex lock;
> >  	int irq;
> 
> Before your patch this member was unused.  And AFAICT you don't really
> need it.  (Whenever you need the number contained in it, you are in an
> spi or i2c specific function so you can use spidev->irq or
> i2cclient->irq.)  So can you please just drop this member?

no worries. (Last round of comments you suggested to do in a different patch).

> 
> > +	int (*read_dev)(struct mc13xxx*, unsigned int, u32*);
> > +	int (*write_dev)(struct mc13xxx*, unsigned int, u32);
> 
> space between type and asterisk?

Not sure which asterisk you're talking about. (Checkpatch.pl resulted in no 
errors/warnings, so I'm ignorant past that)


> > 
> > +	unsigned char buff[3] = {0, 0, 0};
> 
> buf is more usual I think

no worries.


> > 
> > +	/* get the generation ID from register 46, as apparently some older
> > +	 * ic revisions only have this info at this location. Newer ICs seem to
> > +	 * have both.
> > +	 * */
> 
> please put /* and */ on lines for themself, see chapter 8 in
> Documentation/CodingStyle

no worries. (have read, just forget :)



> > +	devid = spi_get_device_id(mc13xxx->spidev);
> > +	if (!devid || devid->driver_data != mc13xxx->ictype)
> > +		dev_warn(mc13xxx->pdev, "device id doesn't "
> > +					"match auto detection!\n");
> 
> Don't linebreak error strings please.

no worries.


> > +
> > +	dev_set_drvdata(&client->dev, mc13xxx);
> > +	mc13xxx->pdev = &client->dev;
> > +	mc13xxx->i2cclient = client;
> > +	mc13xxx->read_dev = mc13xxx_i2c_reg_read;
> > +	mc13xxx->write_dev = mc13xxx_i2c_reg_write;
> > +	mc13xxx->irq = client->irq;
> 
> I think that starting here the rest of the function can go to
> common_probe, doesn't it?  (OK, apart from the irq number, that would
> then go as a parameter to common_probe.)

agree.


> 
> > +
> > +	mutex_init(&mc13xxx->lock);
> > +	mc13xxx_lock(mc13xxx);
> > +
> > +	ret = mc13xxx_identify(mc13xxx);
> > +	if (ret || (mc13xxx->ictype == MC13XXX_ID_INVALID))
> > +		goto err_revision;
> > +
> > +	if (id->driver_data != mc13xxx->ictype)
> > +		dev_warn(mc13xxx->pdev, "device id doesn't "
> > +					"match auto detection!\n");
> 
> linebroken error string

no worries.


> >  static int __init mc13xxx_init(void)
> >  {
> > 
> > -	return spi_register_driver(&mc13xxx_driver);
> > +	int i2cret;
> > +	int spiret;
> > +	i2cret = i2c_add_driver(&mc13xxx_i2c_driver);
> > +	spiret = spi_register_driver(&mc13xxx_driver);
> > +
> > +	return (i2cret == 0) && (spiret == 0);
> 
> If i2c_add_driver succeeds but spi_register_driver you return
> -ESOMETHING, and the module is discarded while the i2c core keeps a
> reference to &mc13xxx_i2c_driver.  This is bad.
> I think you need to do:
> 
> 	ret = i2c_add_driver(..)
> 	if (ret)
> 		return ret;
> 
> 	ret = spi_register_driver(...)
> 	if (ret)
> 		i2c_del_driver(...)
> 
> 	return ret;
> 

This was my biggest reservation with this code too. I think it should try to 
register both, but should clean appropriately if one fails. (What to return 
from mc13xxx_init() in that case? Or maybe should it be split into separate 
files?).

Cheers
Marc
