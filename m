From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Jan 2011 09:20:44 +0000
Subject: [PATCH 3/6] i2c/pxa2xx: Add PCI support for PXA I2C controller
In-Reply-To: <20110105230834.GA26399@suse.de>
References: <1294246263-31960-1-git-send-email-bigeasy@linutronix.de>
	<1294246263-31960-4-git-send-email-bigeasy@linutronix.de>
	<20110105230342.GO8638@n2100.arm.linux.org.uk>
	<20110105230834.GA26399@suse.de>
Message-ID: <20110106092044.GT8638@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 05, 2011 at 03:08:34PM -0800, Greg KH wrote:
> On Wed, Jan 05, 2011 at 11:03:42PM +0000, Russell King - ARM Linux wrote:
> > On Wed, Jan 05, 2011 at 05:51:00PM +0100, Sebastian Andrzej Siewior wrote:
> > > +static void plat_dev_release(struct device *dev)
> > > +{
> > > +	struct ce4100_i2c_device *sd = container_of(dev,
> > > +			struct ce4100_i2c_device, pdev.dev);
> > > +
> > > +	of_device_node_put(&sd->pdev.dev);
> > > +}
> > > +static int add_i2c_device(struct pci_dev *dev, int bar,
> > > +		struct ce4100_i2c_device *sd)
> > > +{
> > > +	struct platform_device *pdev = &sd->pdev;
> > > +	struct i2c_pxa_platform_data *pdata = &sd->pdata;
> > ...
> > > +	pdev->name = "ce4100-i2c";
> > > +	pdev->dev.release = plat_dev_release;
> > > +	pdev->dev.parent = &dev->dev;
> > > +
> > > +	pdev->dev.platform_data = pdata;
> > > +	pdev->resource = sd->res;
> > ...
> > > +static int __devinit ce4100_i2c_probe(struct pci_dev *dev,
> > > +		const struct pci_device_id *ent)
> > > +{
> > > +	sds = kzalloc(sizeof(*sds), GFP_KERNEL);
> > > +	if (!sds)
> > > +		goto err_mem;
> > > +
> > > +	pci_set_drvdata(dev, sds);
> > > +
> > > +	for (i = 0; i < ARRAY_SIZE(sds->sd); i++) {
> > > +		ret = add_i2c_device(dev, i, &sds->sd[i]);
> > > +		if (ret) {
> > > +			while (--i >= 0)
> > > +				platform_device_unregister(&sds->sd[i].pdev);
> > ...
> > > +static void __devexit ce4100_i2c_remove(struct pci_dev *dev)
> > ...
> > > +	for (i = 0; i < ARRAY_SIZE(sds->sd); i++)
> > > +		platform_device_unregister(&sds->sd[i].pdev);
> > > +
> > > +	pci_disable_device(dev);
> > > +	kfree(sds);
> > > +}
> > 
> > I see we're still repeating the same mistakes with lifetime rules of
> > sysfs objects.
> > 
> > Any struct device which has been registered into the device model can
> > remain indefinitely live after it's been unregistered (by, eg, if
> > userspace holds a reference to it via sysfs.)
> 
> Actually this race is almost not possible these days with the rework
> that Tejun did on sysfs, so it's not easy to test for this anymore.

Is it wise to make such a problematical bug harder to trigger without
completely preventing it triggering?

A different approach was taken with IRQ handling where people were
registering handlers before the driver was ready for it to be called -
request_irq() would explicitly call the handler as soon as it was
registered to provoke bugs.

Surely for these lifetime violations a similar approach should be taken.
Make the kernel more likely to oops should a violation occur before the
developer can get the code out the door.  One way I can think of doing
that is when devices are unregistered but not yet released, place them
on a list which is periodically scanned, and not only is the device
dereferenced by also the release function.

When the use count drops to zero, don't immediately release, but wait
a number of polls.

If either goes away before the device has been released, then we
predictably oops, and the developer gets to know about his violation
of the rules immediately.
