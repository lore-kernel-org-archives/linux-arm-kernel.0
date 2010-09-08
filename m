From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 08 Sep 2010 10:24:48 -0700
Subject: [PATCH 1/2] OMAP2+: PM: initial runtime PM core support
In-Reply-To: <20100908162143.GD3686@angua.secretlab.ca> (Grant Likely's
	message of "Wed, 8 Sep 2010 10:21:43 -0600")
References: <1283907282-986-1-git-send-email-khilman@deeprootsystems.com>
	<20100908162143.GD3686@angua.secretlab.ca>
Message-ID: <871v945esf.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant Likely <grant.likely@secretlab.ca> writes:

> On Tue, Sep 07, 2010 at 05:54:41PM -0700, Kevin Hilman wrote:
>> From: Kevin Hilman <khilman@ti.com>
>> 
>> Implement the new runtime PM framework as a thin layer on top of the
>> omap_device API.  OMAP specific runtime PM methods are registered with
>> the as custom methods on the platform_bus.
>> 
>> In order to determine if a device is an omap_device, its parent device
>> is checked.  All omap_devices have a new 'omap_bus' device as their
>> parent device, so checking for this parent is used to check for valid
>> omap_devices.  If a device is an omap_device, then the appropriate
>> omap_device functions are called for it.  If not, only the generic
>> runtime PM functions are called.
>> 
>> Device driver's ->runtime_idle() hook is called when the runtime PM
>> usecount reaches zero for that device.  Driver's ->runtime_suspend()
>> hooks are called just before the device is disabled (via
>> omap_device_idle()), and device driver ->runtime_resume() hooks are
>> called just after device has been enabled (via omap_device_enable().)
>> 
>> OMAP4 build support from Rajendra Nayak <rnayak@ti.com>.
>> 
>> Cc: Rajendra Nayak <rnayak@ti.com>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>

[...]

>> +static int __init omap_pm_runtime_init(void)
>> +{
>> +	const struct dev_pm_ops *pm;
>> +	struct dev_pm_ops *omap_pm;
>> +
>> +	pm = platform_bus_get_pm_ops();
>> +	if (!pm) {
>> +		pr_err("%s: unable to get dev_pm_ops from platform_bus\n",
>> +			__func__);
>> +		return -ENODEV;
>> +	}
>> +
>> +	omap_pm = kmemdup(pm, sizeof(struct dev_pm_ops), GFP_KERNEL);
>> +	if (!omap_pm) {
>> +		pr_err("%s: unable to alloc memory for new dev_pm_ops\n",
>> +			__func__);
>> +		return -ENOMEM;
>> +	}
>> +		
>> +	omap_pm->runtime_suspend = omap_pm_runtime_suspend;
>> +	omap_pm->runtime_resume = omap_pm_runtime_resume;
>
> This will fail to build when CONFIG_PM_RUNTIME is unset.  None of this
> file should be build when CONFIG_PM_RUNTIME=n.

FYI... Rather than not building the whole file, I'm fixing this by
adding an #else clause to the #ifdef:

#else
#define omap_pm_runtime_suspend NULL
#define omap_pm_runtime_resume NULL
#endif /* CONFIG_PM_RUNTIME */

This is because I'll also be building on this to hook up the
_[suspend|resume]_noirq() methods which are based on #ifdef
CONFIG_SUSPEND and not CONFIG_PM_RUNTIME.

Kevin
