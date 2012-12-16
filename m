From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Sun, 16 Dec 2012 22:36:56 +0100 (CET)
Subject: [PATCH 6/7] ARM: mackerel: support booting with or without DT
In-Reply-To: <20121216204636.ACD283E0AE3@localhost>
References: <1355503531-7276-1-git-send-email-g.liakhovetski@gmx.de>
 <1355503531-7276-7-git-send-email-g.liakhovetski@gmx.de>
 <20121216204636.ACD283E0AE3@localhost>
Message-ID: <Pine.LNX.4.64.1212162224380.20059@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant

On Sun, 16 Dec 2012, Grant Likely wrote:

> On Fri, 14 Dec 2012 17:45:30 +0100, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> > This patch adds dynamic switching to booting either with or without DT.
> > So far only a part of the board initialisation can be done via DT. Devices,
> > that still need platform data are kept that way. Devices, that can be
> > initialised from DT will not be supplied from the platform data, if a DT
> > image is detected.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> >  
> > +static int mackerel_i2c_bus_notify(struct notifier_block *nb,
> > +				   unsigned long action, void *data)
> > +{
> > +	struct device *dev = data;
> > +
> > +	if (action != BUS_NOTIFY_ADD_DEVICE ||
> > +	    strcmp(dev_name(dev->parent), "fff20000.i2c"))
> > +		return NOTIFY_DONE;
> > +
> > +	i2c_new_device(to_i2c_adapter(dev), &i2c0_devices[1]);
> > +
> > +	return NOTIFY_OK;
> > +}
> > +
> > +static struct notifier_block mackerel_i2c_notifier = {
> > +	.notifier_call = mackerel_i2c_bus_notify,
> > +};
> 
> This looks dodgy. It appears that the purpose of this hook is to create
> the tca6408-keys device because it has some platform data. However,
> this hook will try to create the device every time BUS_NOTIFY_ADD_DEVICE
> happens on the fff20000.i2c bus *including* when the tca6408-keys device
> gets added.

I think, this is only called once, when the i2c adapter device is added in 
i2c_register_adapter(). I2C client devices have these adapter devices as 
their parents, and those devices have "i2c-%d" as their names. Since all 
client devices get destroyed when the adapter is unbound, the above should 
be safe.

> The correct approach when you need to add specific platform data is to
> still put the device into the device tree and make the notifier look for
> that specific device. Then the platform data pointer can be attached at
> BUS_NOTIFY_ADD_DEVICE time.
> 
> However, it doesn't look like you need a notifier at all. From what I
> can see the tca6408-keys device does have platform data, but it is all
> simple (no callback pointers). You should instead encode the platform
> data into device tree properties and extract them from the driver.

Yes, this is the ultimate goal. But the purpose of this patch series is to 
move whatever devices are possible right _now_ to DT. Ultimately all of 
them should be migrated. So, yes, we could try to begin with tca6408, 
because the above hack is certainly the ugliest one in this series, but in 
principle this is just one of several devices, that we have to keep in 
platform data for now and aim at removing these temporary hacks as soon as 
respective drivers implement sufficient DT support.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
