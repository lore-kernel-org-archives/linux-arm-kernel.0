From: cyril@ti.com (Cyril Chemparathy)
Date: Tue, 16 Nov 2010 19:17:18 -0500
Subject: [PATCH v5 04/12] spi: add ti-ssp spi master driver
In-Reply-To: <AANLkTi=utWumLKo9QVWXpkC8WxpgaNJJs+dj=pa2eq-q@mail.gmail.com>
References: <1289848334-8695-1-git-send-email-cyril@ti.com>
	<1289848334-8695-5-git-send-email-cyril@ti.com>
	<20101116072225.GF4074@angua.secretlab.ca>
	<AANLkTi=utWumLKo9QVWXpkC8WxpgaNJJs+dj=pa2eq-q@mail.gmail.com>
Message-ID: <4CE31F0E.7050103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2010 02:47 AM, Grant Likely wrote:
> On Tue, Nov 16, 2010 at 12:22 AM, Grant Likely
> <grant.likely@secretlab.ca> wrote:
>> On Mon, Nov 15, 2010 at 02:12:06PM -0500, Cyril Chemparathy wrote:
>>> This patch adds an SPI master implementation that operates on top of an
>>> underlying TI-SSP port.
>>>
>>> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
>> [...]
>>> +static int __init ti_ssp_spi_init(void)
>>> +{
>>> +     return platform_driver_register(&ti_ssp_spi_driver);
>>> +}
>>> +subsys_initcall(ti_ssp_spi_init);
>>
>> After discussions about device init dependencies at plumbers, and
>> since this is the first SPI device driver I've reviewed since that
>> dicussion, this driver gets to be the first to implement the proposed
>> policy.  :-)
>>
>> Change this to module_initcall().  Many spi and i2c drivers use
>> module or subsys_initcall to try and influence driver probe order so
>> that certain regulator chips get registered before the devices that
>> try to use them.  This approach is insane.
>>
>> Instead, it is now incumbent on the board support code to ensure that
>> any device that depends on another device (including i2c or spi
>> regulators) will defer registration until the prerequisite devices are
>> bound to drivers.
>>
>> I don't *think* this change will affect anything in this particular
>> patch series, but if it does then let me know and I'll help you work out
>> how to fix it using a bus notifier.
> 
> Oh, wait, spoke too soon.  You do add a regulator in this series, so
> this change will require a fixup.  The solution is to register an
> bus_notifier to the spi bus type before you start registering devices.
> It also requires deferring the musb_hdrc.1 and tps6116x registrations
> until the bus_notifier callback gets called with an indication that
> the regulator is bound.  It will look something like this:
> 
> static int tnetv107x_spi_notifier_call(struct notifier_block *nb,
> 				unsigned long event, void *__dev)
> {
> 	struct device *dev = __dev;
> 
> 	if ((event == BUS_NOTIFY_BOUND_DRIVER) && (dev == (the-regulator))) {
> 		register-the-remaining-devices();
> 		return NOTIFY_STOP;
> 	};
> 	return NOTIFY_DONE;
> }
> 
> static struct notifier_block tnetv107x_spi_nb = {
> 	.notifier_call = tnetv107x_spi_notifier_call,
> };
> 
> and then in the device registration code, before registering the
> regulator:
> 
> 	bus_register_notifier(&spi_bus_type, &tnetv107x_spi_nb);
> 
> Let me know if you have any trouble.

The ability to wait on multiple devices may come handy.  In this
particular case the backlight driver depends on both ssp-gpio and
regulator devices.  Ideally, boards should be able to do something like...

platform_device_register_after(&backlight_device, "spi1.0");
platform_device_register_after(&backlight_device, "ti-ssp-gpio.0");

... and the device should get automatically registered once its
dependencies have been met.


Crude and incomplete code follows:

struct platform_device_depend {
	struct list_head node;
	const char *dev_name;
	struct platform_device *pdev;
};

LIST_HEAD(platform_device_depend);

static int platform_device_register_after(struct platform_device *pdev,
					  const char *dev_name)
{
	struct platform_device_depend *dep;

	dep = kzalloc(sizeof(*dep), GFP_KERNEL);
	if (!dep)
		return -ENOMEM;
	dep->dev_name = dev_name;
	dep->pdev = pdev;
	list_add_tail(&dep->node, &platform_device_depend);
	return 0;
}

static int platform_device_try_register(struct platform_device *pdev)
{
	struct platform_device_depend *dep;

	list_for_each_entry(dep, &platform_device_depend, node) {
		if (dep->pdev == pdev)
			return -EBUSY;
	}
	return platform_device_register(pdev);
}

static int bus_notifier_func(struct notifier_block *nb,
			     unsigned long event, void *__dev)
{
	struct platform_device_depend *dep, *tmp;
	struct device *dev = __dev;

	if (event != BUS_NOTIFY_BOUND_DRIVER)
		return NOTIFY_DONE;

	list_for_each_entry_safe(dep, tmp, &platform_device_depend,
				 node) {
		if (strcmp(dep->dev_name, dev_name(dev)) != 0)
			continue;
		list_del(&dep->node);
		platform_device_try_register(dep->pdev);
		kfree(dep);
	}

	return NOTIFY_OK;
}

Regards
Cyril.
