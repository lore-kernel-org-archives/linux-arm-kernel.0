From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Jan 2012 17:58:24 +0000
Subject: [PATCH 2/6] drivers/base: add bus for System-on-Chip devices
In-Reply-To: <20120128010534.GA20581@kroah.com>
References: <1327165687-4223-1-git-send-email-lee.jones@linaro.org>
 <1327165687-4223-3-git-send-email-lee.jones@linaro.org>
 <20120128010534.GA20581@kroah.com>
Message-ID: <201201301758.24531.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 28 January 2012, Greg KH wrote:
> On Sat, Jan 21, 2012 at 05:08:03PM +0000, Lee Jones wrote:
> > diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> > index 7be9f79..9aa618a 100644
> > --- a/drivers/base/Kconfig
> > +++ b/drivers/base/Kconfig
> > @@ -176,6 +176,9 @@ config GENERIC_CPU_DEVICES
> >  	bool
> >  	default n
> >  
> > +config SOC_BUS
> > +	bool
> 
> That's nice, but you do need some kind of help text here, right?

Wouldn't hurt, but most silent options have no help text, because that
would never be visible in the kconfig tools, only in the source code.

> > +
> > +static struct ida soc_ida;
> > +static spinlock_t soc_lock;
> > +
> > +static ssize_t soc_info_get(struct device *dev,
> > +			    struct device_attribute *attr,
> > +			    char *buf);
> > +
> 
> Why not put the whole function here, well a few lines lower, so no
> forward declaration is needed, saving a few extra lines.

You made the same comment in a previous review round and then agreed
that it's correct after all. A small comment why the forward declaration
is required here would probably be appropriate here, otherwise the
next person reading this would have the same thought.

> > +
> > +static mode_t soc_attribute_mode(struct kobject *kobj,
> > +                                 struct attribute *attr,
> > +                                 int index)
> > +{
> > +	struct device *dev = container_of(kobj, struct device, kobj);
> > +	struct soc_device *soc_dev = container_of(dev, struct soc_device, dev);
> > +
> > +	if ((attr == &dev_attr_machine.attr)
> > +	    && (soc_dev->attr->machine != NULL))
> > +		return attr->mode;
> > +	if ((attr == &dev_attr_family.attr)
> > +	    && (soc_dev->attr->family != NULL))
> > +		return attr->mode;
> > +	if ((attr == &dev_attr_revision.attr)
> > +	    && (soc_dev->attr->revision != NULL))
> > +		return attr->mode;
> > +	if ((attr == &dev_attr_soc_id.attr)
> > +	    && (soc_dev->attr->soc_id != NULL))
> > +	        return attr->mode;
> > +

FWIW, the function compares the attribute pointers, so it needs to
see their delarations, while the attribute definition requires the
declaration of the function to be visible.

	Arnd
