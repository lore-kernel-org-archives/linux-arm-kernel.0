From: hzpeterchen@gmail.com (Peter Chen)
Date: Wed, 29 Jun 2016 09:53:24 +0800
Subject: [PATCH 02/21] usb: ulpi: Support device discovery via DT
In-Reply-To: <20160628114205.GA3378@kuha.fi.intel.com>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-3-stephen.boyd@linaro.org>
 <20160627143422.GB21398@kuha.fi.intel.com>
 <146706544012.30684.15569003844798199881@sboyd-linaro>
 <20160628114205.GA3378@kuha.fi.intel.com>
Message-ID: <20160629015324.GA25236@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2016 at 02:42:05PM +0300, Heikki Krogerus wrote:
> On Mon, Jun 27, 2016 at 03:10:40PM -0700, Stephen Boyd wrote:
> > Quoting Heikki Krogerus (2016-06-27 07:34:22)
> > > Hi,
> > > 
> > > I'm fine with most of the patch, except..
> > > 
> > > On Sun, Jun 26, 2016 at 12:28:19AM -0700, Stephen Boyd wrote:
> > > > @@ -39,7 +42,10 @@ static int ulpi_match(struct device *dev, struct device_driver *driver)
> > > >       struct ulpi *ulpi = to_ulpi_dev(dev);
> > > >       const struct ulpi_device_id *id;
> > > >  
> > > > -     for (id = drv->id_table; id->vendor; id++)
> > > > +     if (of_driver_match_device(dev, driver))
> > > > +             return 1;
> > > 
> > > I don't like this part. We should match separately like that only
> > > if the bus does not support native enumeration, and of course ULPI
> > > with its vendor and product IDs does. There really should always be
> > > IDs to match with here. So exceptions have to be solved before we
> > > attempt matching.
> > > 
> > > Since we also have to support platforms where the PHY is initially
> > > powered off and reading the IDs from the registers is not possible
> > > because of that, I think we should consider getting the product and
> > > vendor IDs optionally from device properties. Something like this:
> > 
> > Ok, I'm a little worried about conflating the powered off problem with
> > this product/vendor ID missing problem. But if you're ok with that I'll
> > combine the two patches into one using your approach below.
> > 
> > > 
> > > 
> > > diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
> > > index 01c0c04..6228a85 100644
> > > --- a/drivers/usb/common/ulpi.c
> > > +++ b/drivers/usb/common/ulpi.c
> > > @@ -152,7 +152,7 @@ EXPORT_SYMBOL_GPL(ulpi_unregister_driver);
> > >  
> > >  /* -------------------------------------------------------------------------- */
> > >  
> > > -static int ulpi_register(struct device *dev, struct ulpi *ulpi)
> > > +static int ulpi_read_id(struct ulpi *ulpi)
> > >  {
> > >         int ret;
> > >  
> > > @@ -174,6 +174,21 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
> > >         ulpi->id.product = ulpi_read(ulpi, ULPI_PRODUCT_ID_LOW);
> > >         ulpi->id.product |= ulpi_read(ulpi, ULPI_PRODUCT_ID_HIGH) << 8;
> > >  
> > > +       return 0;
> > > +}
> > > +
> > > +static int ulpi_register(struct device *dev, struct ulpi *ulpi)
> > > +{
> > > +       int ret;
> > > +
> > > +       ret = device_property_read_u16(dev, "ulpi-vendor", &ulpi->id.vendor);
> > > +       ret |= device_property_read_u16(dev, "ulpi-product", &ulpi->id.product);
> > > +       if (ret) {
> > > +               ret = ulpi_read_id(ulpi);
> > > +               if (ret)
> > > +                       return ret;
> > > +       }
> > > +
> > >         ulpi->dev.parent = dev;
> > >         ulpi->dev.bus = &ulpi_bus;
> > >         ulpi->dev.type = &ulpi_dev_type;
> > > 
> > > 
> > > That should cover both cases. You would just have to create the IDs
> > > yourself in this case.
> > > 
> > 
> > Right, I would have to make up some IDs in this case. I suppose I can
> > use the qcom vendor ID 0x05c6 and then product ids 0 and 1 for HS phy
> > and HSIC phy? That doesn't make me feel great because it's all made up,
> > but I guess there's no other option. I hope they don't decide to start
> > populating these ids in the future though and then we may have
> > conflicting product ids. If that happens I suppose we can do a
> > workaround based on compatible strings in the DT node. Fun!
> > 
> > Nice side effect of all that is I can drop requesting the module by DT
> > aliases and things become simpler. I'll try this out.
> 
> I was hoping that we could manage with product id 0 as an exception (I
> failed to consider that you have multiple PHYs to deal with). I don't
> think we can just come up with product id > 0.
> 
> I guess we should have the of_driver_match_device() call after all.
> Let's just call it conditionally, only in cases where there is no
> product ID, to make me feel a bit more better. I don't want to make it
> too easy to use.
> 
> The properties for the vendor and product ID are still something that
> we need to introduce in any case. We have the powered off problem on
> all kinds of platforms, and not all of them use DT.

I am thinking power sequence framework, how power sequence elements
(eg, clock, reset-gpios) can get for non-DT platform? Does ACPI does power
sequence for x86 platforms?

-- 

Best Regards,
Peter Chen
