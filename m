From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Nov 2011 14:13:36 +0000
Subject: [PATCH] spi/pl022: Enable clock in probe an use runtime_idle
In-Reply-To: <4EB29E59.4040509@stericsson.com>
References: <1319206124-17549-1-git-send-email-ulf.hansson@stericsson.com>
	<20111102141628.GG19187@n2100.arm.linux.org.uk>
	<4EB29E59.4040509@stericsson.com>
Message-ID: <20111103141336.GN12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2011 at 02:59:53PM +0100, Ulf Hansson wrote:
>>> @@ -2342,11 +2350,19 @@ static int pl022_runtime_resume(struct device *dev)
>>>   	return 0;
>>>  }
>>> +
>>> +static int pl022_runtime_idle(struct device *dev)
>>> +{
>>> +	pm_runtime_suspend(dev);
>>> +	return 0;
>>> +}
>>>  #endif
>>>   static const struct dev_pm_ops pl022_dev_pm_ops = {
>>>  	SET_SYSTEM_SLEEP_PM_OPS(pl022_suspend, pl022_resume)
>>> -	SET_RUNTIME_PM_OPS(pl022_runtime_suspend, pl022_runtime_resume, NULL)
>>> +	SET_RUNTIME_PM_OPS(pl022_runtime_suspend,
>>> +			   pl022_runtime_resume,
>>> +			   pl022_runtime_idle)
>>
>> This is an unnecessary change.
>>
>> The bus-level ops runtime PM ops call pm_generic_runtime_idle() when
>> its 'runtime_idle' operation is invoked.  Let's look at the code
>> there:
>>
>> int pm_generic_runtime_idle(struct device *dev)
>> {
>>         const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>>
>>         if (pm && pm->runtime_idle) {
>>                 int ret = pm->runtime_idle(dev);
>>                 if (ret)
>>                         return ret;
>>         }
>>
>>         pm_runtime_suspend(dev);
>>         return 0;
>> }
>>
>> If the driver has a NULL runtime idle, then generic code will call
>> pm_runtime_suspend() for the device.  So, adding a runtime_idle callback
>> to a driver to explicitly call pm_runtime_suspend() is not required.
>>
>
> You are somewhat correct. But the patch is still needed as is!

No it is not required, by any means shape or form.

> Reason is simply that after a probe, driver core is calling  
> pm_runtime_put_sync. This will not go through the  
> pm_generic_runtime_idle function, but directly to __pm_runtime_idle.

Let's look at the code:

static inline int pm_runtime_put_sync(struct device *dev)
{
        return __pm_runtime_idle(dev, RPM_GET_PUT);
}

int __pm_runtime_idle(struct device *dev, int rpmflags)
{
...
        spin_lock_irqsave(&dev->power.lock, flags);
        retval = rpm_idle(dev, rpmflags);
        spin_unlock_irqrestore(&dev->power.lock, flags);
...
}

static int rpm_idle(struct device *dev, int rpmflags)
{
        int (*callback)(struct device *);
...
        if (dev->pm_domain)
                callback = dev->pm_domain->ops.runtime_idle;
        else if (dev->type && dev->type->pm)
                callback = dev->type->pm->runtime_idle;
        else if (dev->class && dev->class->pm)
                callback = dev->class->pm->runtime_idle;
        else if (dev->bus && dev->bus->pm)
                callback = dev->bus->pm->runtime_idle;
        else
                callback = NULL;

        if (callback)
                __rpm_callback(callback, dev);
...
}

static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
        __releases(&dev->power.lock) __acquires(&dev->power.lock)
{
...
        retval = cb(dev);
...
}

Nothing in there calls down to the _driver_ level PM ops from the core
runtime PM code.  What will happen is that this statement will assign
the callback pointer:

	callback = dev->bus->pm->runtime_idle;

and dev->bus->pm will be &amba_pm.  Its runtime idle function will be
pm_generic_runtime_idle.  As I quoted above:

>> int pm_generic_runtime_idle(struct device *dev)
>> {
>>         const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>>
>>         if (pm && pm->runtime_idle) {
>>                 int ret = pm->runtime_idle(dev);
>>                 if (ret)
>>                         return ret;
>>         }
>>
>>         pm_runtime_suspend(dev);
>>         return 0;
>> }

This is the only way you get down to the driver-level pm->runtime_idle
callback.

Please describe what benefit having *THIS* pm->runtime_idle(dev) pointing
at your new function:

>>> +static int pl022_runtime_idle(struct device *dev)
>>> +{
>>> +	pm_runtime_suspend(dev);
>>> +	return 0;
>>> +}

gains us over the case where pm->runtime_idle is NULL inside
pm_generic_runtime_idle().
