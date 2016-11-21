From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Nov 2016 13:37:55 +0000
Subject: [PATCH] mfd: twl-core: export twl_get_regmap
In-Reply-To: <CAKP5S=28xVyNE=Q7hd2UbtOmT=12ayrcWM5m1OTvk5kGN5pZrw@mail.gmail.com>
References: <1478950693-13959-1-git-send-email-Nicolae_Rosia@mentor.com>
 <20161118185548.GA23246@dell.home>
 <CAKP5S=3quz8f1H0xnaffJ35L8qSOpSkBEGS8GsNhB5F=v3DoBg@mail.gmail.com>
 <20161121092339.GA32509@dell>
 <20161121093144.GE23750@n2100.armlinux.org.uk>
 <CAKP5S=28xVyNE=Q7hd2UbtOmT=12ayrcWM5m1OTvk5kGN5pZrw@mail.gmail.com>
Message-ID: <20161121133755.GF23750@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2016 at 12:03:03PM +0200, Nicolae Rosia wrote:
> On Mon, Nov 21, 2016 at 11:31 AM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > Passing data between drivers using *_set_drvdata() is a layering
> > violation:
> >
> > 1. Driver data is supposed to be driver private data associated with
> >    the currently bound driver.
> > 2. The driver data pointer is NULL'd when the driver unbinds from the
> >    device.  See __device_release_driver() and the
> >    dev_set_drvdata(dev, NULL).
> > 3. It will break with CONFIG_DEBUG_TEST_DRIVER_REMOVE enabled for a
> >    similar reason to (2).
> >
> > So, do not pass data between drivers using *_set_drvdata() - any
> > examples in the kernel already are founded on bad practice, are
> > fragile, and are already broken for some kernel configurations.
> 
> After inspecting mfd_add_device, it seems that it creates a
> platform_device which has the parent set to the driver calling the
> function.
> Isn't module unloading forbidden if there is a parent->child
> relationship in place and you're removing the parent?

Forget this idea that there's any connection between modules and
the struct device relationships - there isn't anything of the kind!

Each struct device is refcounted, and child devices will hold a
reference to their parent device, so the parent device doesn't get
freed before its children are all gone.

That's a completely separate issue to when a struct device is bound
to a struct device_driver - it's entirely possible for parent drivers
to be unbound at any time, even when there are child drivers in place.

There are cases where we want that to happen - think of any driver
which is a bus driver in itself - eg, PCMCIA, MMC, USB, etc.  These
drivers enumerate their children, and destroy their children when
the driver is unbound - but the driver has to be in the process of
being unbound for that to happen.  That process may very well start
with the child devices being bound to their drivers.

What makes the child drivers unbind is when the bus driver deletes
the child struct devices.

> What should be the best practice to share data between drivers?
> Reference counted data?

I guess so, but you will still have a race if you do something like:

	struct parent_private_data *parent_priv = dev_get_drvdata(dev->parent);

Yes, that'll get the parent's driver private data, but what you don't
know is whether the pointer remains valid, and even if you do as the
very next step:

	kref_get(&parent_priv->kref);

you don't know whether parent_priv was kfree()d between these two
statements.

However, if the parent driver creates the struct device that you're
using and deletes the struct device before it frees its private data,
then you can be sure that parent_priv will be valid, because the child
drivers will be unbound during the parent driver's ->remove function,
_before_ the private data is freed.

> In the case of TWL, the twl-core is just a simple container for
> regmaps - all other "sub devices" are using those regmaps to access
> the I2C device's registers, it makes no sense to remove the parent
> driver since it does *nothing*.

I can't comment on what twl-core is doing, I haven't looked at it in
ages, but most MFD drivers have the parent device creating and destroying
their children, so it should be fine.

My original comment was more along the lines of a parent device poking
driver-private data into the child devices it was creating for the
child drivers to pick up.  However, it's worth discussing the validity
cases of the parent's driver data too, as per the above.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
