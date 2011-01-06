From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu, 6 Jan 2011 11:50:51 +0100
Subject: [PATCH 3/6] i2c/pxa2xx: Add PCI support for PXA I2C controller
In-Reply-To: <20110105230834.GA26399@suse.de>
References: <1294246263-31960-1-git-send-email-bigeasy@linutronix.de>
	<1294246263-31960-4-git-send-email-bigeasy@linutronix.de>
	<20110105230342.GO8638@n2100.arm.linux.org.uk>
	<20110105230834.GA26399@suse.de>
Message-ID: <20110106105051.GA12146@www.tglx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Greg KH | 2011-01-05 15:08:34 [-0800]:

>On Wed, Jan 05, 2011 at 11:03:42PM +0000, Russell King - ARM Linux wrote:
>> On Wed, Jan 05, 2011 at 05:51:00PM +0100, Sebastian Andrzej Siewior wrote:
>> > +static void plat_dev_release(struct device *dev)
>> > +{
>> > +	struct ce4100_i2c_device *sd = container_of(dev,
>> > +			struct ce4100_i2c_device, pdev.dev);
>> > +
>> > +	of_device_node_put(&sd->pdev.dev);
>> > +}
>> > +static int add_i2c_device(struct pci_dev *dev, int bar,
>> > +		struct ce4100_i2c_device *sd)
>> > +{
>> > +	struct platform_device *pdev = &sd->pdev;
>> > +	struct i2c_pxa_platform_data *pdata = &sd->pdata;
>> ...
>> > +	pdev->name = "ce4100-i2c";
>> > +	pdev->dev.release = plat_dev_release;
>> > +	pdev->dev.parent = &dev->dev;
>> > +
>> > +	pdev->dev.platform_data = pdata;
>> > +	pdev->resource = sd->res;
>> ...
>> > +static int __devinit ce4100_i2c_probe(struct pci_dev *dev,
>> > +		const struct pci_device_id *ent)
>> > +{
>> > +	sds = kzalloc(sizeof(*sds), GFP_KERNEL);
>> > +	if (!sds)
>> > +		goto err_mem;
>> > +
>> > +	pci_set_drvdata(dev, sds);
>> > +
>> > +	for (i = 0; i < ARRAY_SIZE(sds->sd); i++) {
>> > +		ret = add_i2c_device(dev, i, &sds->sd[i]);
>> > +		if (ret) {
>> > +			while (--i >= 0)
>> > +				platform_device_unregister(&sds->sd[i].pdev);
>> ...
>> > +static void __devexit ce4100_i2c_remove(struct pci_dev *dev)
>> ...
>> > +	for (i = 0; i < ARRAY_SIZE(sds->sd); i++)
>> > +		platform_device_unregister(&sds->sd[i].pdev);
>> > +
>> > +	pci_disable_device(dev);
>> > +	kfree(sds);
>> > +}
>> 

>> I think you should be trying to use the platform_device_alloc()
>> interfaces here, rather than trying to reinvent them.  The only issue I
>> see with that is the of_device_node_put() call.  Maybe OF/DT/device model
>> people can provide some pointers?  Adding Greg for the device model
>> maintainer view.
>
>Don't reinvent functions that the core already provides, that's not a
>good idea.
>
>Sebastian, why didn't those functions work for you?
which functions are you talking about? I allocated one piece of memory
which contained a platform device, ressources, platform data. It looked
better than allocating multiple small chunks. I registered it with
platform_device_register() and platform_device_unregister() complained
about a missing ->release function.

So I now I'm going to rework it and use platform_device_alloc() instead.

>thanks,
>
>greg k-h

Sebastian
