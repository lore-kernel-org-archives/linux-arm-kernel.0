From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 29 Jul 2015 09:02:07 +0200
Subject: [PATCH 8/9] gpiolib-sysfs: Show gpio-name in
 /sys/class/gpio/gpio*/name
In-Reply-To: <20150728095337.GN28535@localhost>
References: <1437125570-28623-1-git-send-email-mpa@pengutronix.de>
 <1437125570-28623-9-git-send-email-mpa@pengutronix.de>
 <20150728095337.GN28535@localhost>
Message-ID: <20150729070207.GF30895@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 28, 2015 at 11:53:37AM +0200, Johan Hovold wrote:
> On Fri, Jul 17, 2015 at 11:32:49AM +0200, Markus Pargmann wrote:
> > This patch adds a sysfs attribute 'name' to gpios that were exported. It
> > exposes the newly added name property of gpio descriptors.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  drivers/gpio/gpiolib-sysfs.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
> > index c3b74440ca67..058019879bab 100644
> > --- a/drivers/gpio/gpiolib-sysfs.c
> > +++ b/drivers/gpio/gpiolib-sysfs.c
> > @@ -139,6 +139,25 @@ static ssize_t value_store(struct device *dev,
> >  }
> >  static DEVICE_ATTR_RW(value);
> >  
> > +static ssize_t gpio_name_show(struct device *dev,
> > +		struct device_attribute *attr, char *buf)
> > +{
> > +	struct gpio_desc	*desc = dev_get_drvdata(dev);
> > +	ssize_t			status;
> > +
> > +	mutex_lock(&sysfs_lock);
> > +
> > +	if (!test_bit(FLAG_EXPORT, &desc->flags))
> 
> No need to check flag export, and no need for the mutex either.
> 
> > +		status = -EIO;
> > +	else
> > +		status = sprintf(buf, "%s\n", desc->name);
> 
> Depending on sprintfs representation of NULL is not a good idea here.
> 
> > +
> > +	mutex_unlock(&sysfs_lock);
> > +	return status;
> > +}
> > +
> > +static DEVICE_ATTR(name, 0444, gpio_name_show, NULL);
> 
> DEVICE_ATTR_RO
> 
> > +
> >  static irqreturn_t gpio_sysfs_irq(int irq, void *priv)
> >  {
> >  	struct gpiod_data *data = priv;
> > @@ -377,6 +396,7 @@ static struct attribute *gpio_attrs[] = {
> >  	&dev_attr_edge.attr,
> >  	&dev_attr_value.attr,
> >  	&dev_attr_active_low.attr,
> > +	&dev_attr_name.attr,
> >  	NULL,
> >  };

Thanks, will fix all of them.

Best regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150729/f7122bb0/attachment-0001.sig>
