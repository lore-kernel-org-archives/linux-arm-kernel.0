From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 16 Dec 2010 10:02:10 +0100
Subject: [PATCHv2] mc13xxx: Add i2c support for mc13xxx-core
In-Reply-To: <201012161930.17299.marc@cpdesign.com.au>
References: <1292449675-20308-1-git-send-email-marc@cpdesign.com.au>
	<20101216074730.GD1940@pengutronix.de>
	<201012161930.17299.marc@cpdesign.com.au>
Message-ID: <20101216090210.GE1940@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Marc,

> > pdev is a usual name for 'struct platform_device's, so can you please
> > use 'dev'?
> 
> no worries. 
> (My old habit of putting a 'p' in front of every pointer name. But let's leave 
> that there.. :)
You're not working for Microsoft, are you?

> > > +	enum mc13xxx_id ictype;
> > > +
> > > 
> > >  	struct mutex lock;
> > >  	int irq;
> > 
> > Before your patch this member was unused.  And AFAICT you don't really
> > need it.  (Whenever you need the number contained in it, you are in an
> > spi or i2c specific function so you can use spidev->irq or
> > i2cclient->irq.)  So can you please just drop this member?
> 
> no worries. (Last round of comments you suggested to do in a different patch).
Both is fine IMHO.  If you do it in one patch you should just note it in
the commit log.

> > > +	int (*read_dev)(struct mc13xxx*, unsigned int, u32*);
> > > +	int (*write_dev)(struct mc13xxx*, unsigned int, u32);
> > 
> > space between type and asterisk?
> 
> Not sure which asterisk you're talking about. (Checkpatch.pl resulted in no 
> errors/warnings, so I'm ignorant past that)
I want
int (*read_dev)(struct mc13xxx *, unsigned int, u32 *);

> > >  static int __init mc13xxx_init(void)
> > >  {
> > > 
> > > -	return spi_register_driver(&mc13xxx_driver);
> > > +	int i2cret;
> > > +	int spiret;
> > > +	i2cret = i2c_add_driver(&mc13xxx_i2c_driver);
> > > +	spiret = spi_register_driver(&mc13xxx_driver);
> > > +
> > > +	return (i2cret == 0) && (spiret == 0);
> > 
> > If i2c_add_driver succeeds but spi_register_driver you return
> > -ESOMETHING, and the module is discarded while the i2c core keeps a
> > reference to &mc13xxx_i2c_driver.  This is bad.
> > I think you need to do:
> > 
> > 	ret = i2c_add_driver(..)
> > 	if (ret)
> > 		return ret;
> > 
> > 	ret = spi_register_driver(...)
> > 	if (ret)
> > 		i2c_del_driver(...)
> > 
> > 	return ret;
> > 
> 
> This was my biggest reservation with this code too. I think it should try to 
> register both, but should clean appropriately if one fails. (What to return 
> from mc13xxx_init() in that case? Or maybe should it be split into separate 
> files?).
Don't split, in general your approach is fine.  And there are two
possibilities to handle spi vs. i2c:

  a) (as suggested above) do both, if at least one fails, do none
     This is easier and probably OK.
  b) You could still succeed if at least one registration doesn't fail.
     Then you need to remember which was successful and only clean this
     one up in the remove callback.  You could then even depend on I2C
     || SPI.
     (BTW, did you fix the dependencies?  Currently you need to depend
     on I2C && SPI.  (Not sure these are the correct names, you may want
     to double check that.))
     This is more flexible but IMHO not worth the effort.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
