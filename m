From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Oct 2011 20:03:42 +0200
Subject: [PATCH 2/6] drivers/base: add bus for System-on-Chip devices
In-Reply-To: <20111017161616.GA5108@suse.de>
References: <1318852378-14180-1-git-send-email-lee.jones@linaro.org>
	<1318852378-14180-3-git-send-email-lee.jones@linaro.org>
	<20111017161616.GA5108@suse.de>
Message-ID: <2152965.Ns7xt0yLIG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 October 2011 09:16:16 Greg KH wrote:
> On Mon, Oct 17, 2011 at 12:52:54PM +0100, Lee Jones wrote:

> > +static ssize_t soc_info_get(struct device *dev,
> > +                         struct device_attribute *attr,
> > +                         char *buf);
> > +
> > +static DEVICE_ATTR(machine,  S_IRUGO, soc_info_get,  NULL);
> > +static DEVICE_ATTR(family,   S_IRUGO, soc_info_get,  NULL);
> > +static DEVICE_ATTR(soc_id,   S_IRUGO, soc_info_get,  NULL);
> > +static DEVICE_ATTR(revision, S_IRUGO, soc_info_get,  NULL);
> > +
> > +static ssize_t soc_info_get(struct device *dev,
> > +                         struct device_attribute *attr,
> > +                         char *buf)
> > +{
> > +     struct soc_device *soc_dev =
> > +             container_of(dev, struct soc_device, dev);
> > +
> > +     if (attr == &dev_attr_machine)
> > +             return sprintf(buf, "%s\n", soc_dev->attr->machine);
> > +     if (attr == &dev_attr_family)
> > +             return sprintf(buf, "%s\n", soc_dev->attr->family);
> > +     if (attr == &dev_attr_revision)
> > +             return sprintf(buf, "%s\n", soc_dev->attr->revision);
> > +     if (attr == &dev_attr_soc_id)
> > +             return sprintf(buf, "%s\n", soc_dev->attr->soc_id);
> > +
> > +     return -EINVAL;
> > +
> > +}
> 
> If you move around things a bit here, you can save 4 lines of code,
> please do so.

I don't think that works: the DEVICE_ATTR definitions require a prototype
for the function, and the function compares the device attribute.

An earlier version of this patch avoided the forward declaration by doing
a more expensive strcmp instead of the pointer comparison, which avoided
this problem, and I recommended against that.

> > +
> > +struct soc_device {
> > +     struct device dev;
> > +     struct soc_device_attribute *attr;
> > +};
> 
> Why is this needed to be defined here?  It should be in the .c file as
> no external code needs to know what it looks like.

You also commented that the argument to soc_device_unregister should
be a soc_device (as, consequently, the return type of soc_device_register).
Agree with that comment, but it means that the definition of struct
soc_device needs to remain visible in order to be used as the parent
for other devices.

	Arnd
