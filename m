From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 15 May 2014 16:08:53 +0100
Subject: [PATCH v2] of: Keep track of populated platform devices
In-Reply-To: <20140514105657.CF966C4153D@trevor.secretlab.ca>
References: <1398858529.24255.3.camel@hornet>
 <1398866717-20268-1-git-send-email-pawel.moll@arm.com>
 <CAL_JsqL=mxqEKpAsXm7Du0vEDpKk4n+dp5-DyvbuGhTA6bP5Lg@mail.gmail.com>
 <20140501092635.05011C409DA@trevor.secretlab.ca>
 <CACxGe6usWdey1qQT2JF=7LuE62H-_xtd1QkRT9z_Tj2pxdQEjQ@mail.gmail.com>
 <1399473437.3706.25.camel@hornet>
 <20140514105657.CF966C4153D@trevor.secretlab.ca>
Message-ID: <1400166533.3672.3.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-05-14 at 11:56 +0100, Grant Likely wrote:
> > Agreed, but, unless I'm missing some fundamental issue, I believe we can
> > solve the flag clearing problem in a generic way:
> > 
> > --8<-----------
> > diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> > index 3cf61a1..0f489fb 100644
> > --- a/drivers/amba/bus.c
> > +++ b/drivers/amba/bus.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/pm_runtime.h>
> >  #include <linux/amba/bus.h>
> >  #include <linux/sizes.h>
> > +#include <linux/of_device.h>
> >  
> >  #include <asm/irq.h>
> >  
> > @@ -268,6 +269,7 @@ static void amba_device_release(struct device *dev)
> >  {
> >  	struct amba_device *d = to_amba_device(dev);
> >  
> > +	of_device_node_put(dev);
> >  	if (d->res.parent)
> >  		release_resource(&d->res);
> >  	kfree(d);
> > diff --git a/include/linux/of_device.h b/include/linux/of_device.h
> > index ef37021..fd14d46 100644
> > --- a/include/linux/of_device.h
> > +++ b/include/linux/of_device.h
> > @@ -41,6 +41,8 @@ extern int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env
> >  
> >  static inline void of_device_node_put(struct device *dev)
> >  {
> > +	if (dev->of_node)
> > +		of_node_clear_flag(dev->of_node, OF_POPULATED);
> >  	of_node_put(dev->of_node);
> >  }
> > --8<-----------
> > 
> > This will work even if one manually unregisters a DT-originating device,
> > because of_device_node_put() would be called in both amba and platform
> > device (kobj) release path.
> 
> Doing it that way will also catch platform_devices that were created
> apart from of_platform_populate() and manually attached to an of_node,
> which is done some times. It will also break whenever multiple devices
> reference the same node if they call of_device_node_put().
> 
> For example, a platform device providing an i2c bus will have a child
> device that represents the i2c bus, and that i2c device will point to
> the same node.

Yes, can I see it doing this. Without 

> The flag clear really does need to be kept in the
> platform_device_unpopulate path because it is only to be used internally
> by of_platform_{populate,depopulate}

Ok, will move it there.
 
> > By the way, the fact that today amba_device_release() doesn't do
> > of_device_node_put() seems like a bug to me? (node's reference counter
> > won't be decremented)
> 
> Yes, that is a bug. I want to get some unittests added to the DT code to
> verify that reference counts are being tracked correctly. Right now it
> is an utter mess.

Ok. If I move the flag, this bit is not longer an integral part of the
patch so will split it into a separate one, but merge the _depopulate()
one instead.

Thanks!

Pawe?
