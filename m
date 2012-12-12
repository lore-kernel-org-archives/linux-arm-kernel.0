From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 12 Dec 2012 12:58:28 +0100
Subject: [PATCH] drivers/pinctrl: grab default handles from device core
In-Reply-To: <20121211181336.GD25714@kroah.com>
References: <1355233246-16694-1-git-send-email-linus.walleij@stericsson.com>
 <20121211181336.GD25714@kroah.com>
Message-ID: <20121212115828.GJ4398@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:13 Tue 11 Dec     , Greg Kroah-Hartman wrote:
> On Tue, Dec 11, 2012 at 02:40:46PM +0100, Linus Walleij wrote:
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index 86ef6ab..dc399ab 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -21,6 +21,7 @@
> >  #include <linux/compiler.h>
> >  #include <linux/types.h>
> >  #include <linux/mutex.h>
> > +#include <linux/pinctrl/devinfo.h>
> >  #include <linux/pm.h>
> >  #include <linux/atomic.h>
> >  #include <linux/ratelimit.h>
> > @@ -605,6 +606,8 @@ struct device_dma_parameters {
> >   * @pm_domain:	Provide callbacks that are executed during system suspend,
> >   * 		hibernation, system resume and during runtime PM transitions
> >   * 		along with subsystem-level and driver-level callbacks.
> > + * @pins:	For device pin management.
> > + *		See Documentation/pinctrl.txt for details.
> >   * @numa_node:	NUMA node this device is close to.
> >   * @dma_mask:	Dma mask (if dma'ble device).
> >   * @coherent_dma_mask: Like dma_mask, but for alloc_coherent mapping as not all
> > @@ -656,6 +659,10 @@ struct device {
> >  	struct dev_pm_info	power;
> >  	struct dev_pm_domain	*pm_domain;
> >  
> > +#ifdef CONFIG_PINCTRL
> > +	struct dev_pin_info	pins;
> > +#endif
> 
> Can't you just make this a * to the structure, saving a bit of space for
> those that don't use this structure?  Ok, it's only saving one pointer,
> so it's really not a big deal to me if you don't want to do this, just
> asking...
> 
> Also, this will have to wait until after 3.8-rc1 before I can consider
> merging it, I'm a bit busy for the next two weeks at the least...
can do do not put ifdef in the struct as if will force us to put ifdef in the
c code too instead of just use a inline function

Best Regards,
J.
> 
> thanks,
> 
> greg k-h
