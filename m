From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Thu, 3 Nov 2011 14:59:53 +0100
Subject: [PATCH] spi/pl022: Enable clock in probe an use runtime_idle
In-Reply-To: <20111102141628.GG19187@n2100.arm.linux.org.uk>
References: <1319206124-17549-1-git-send-email-ulf.hansson@stericsson.com>
	<20111102141628.GG19187@n2100.arm.linux.org.uk>
Message-ID: <4EB29E59.4040509@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> @@ -2342,11 +2350,19 @@ static int pl022_runtime_resume(struct device *dev)
>>  
>>  	return 0;
>>  }
>> +
>> +static int pl022_runtime_idle(struct device *dev)
>> +{
>> +	pm_runtime_suspend(dev);
>> +	return 0;
>> +}
>>  #endif
>>  
>>  static const struct dev_pm_ops pl022_dev_pm_ops = {
>>  	SET_SYSTEM_SLEEP_PM_OPS(pl022_suspend, pl022_resume)
>> -	SET_RUNTIME_PM_OPS(pl022_runtime_suspend, pl022_runtime_resume, NULL)
>> +	SET_RUNTIME_PM_OPS(pl022_runtime_suspend,
>> +			   pl022_runtime_resume,
>> +			   pl022_runtime_idle)
> 
> This is an unnecessary change.
> 
> The bus-level ops runtime PM ops call pm_generic_runtime_idle() when
> its 'runtime_idle' operation is invoked.  Let's look at the code
> there:
> 
> int pm_generic_runtime_idle(struct device *dev)
> {
>         const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> 
>         if (pm && pm->runtime_idle) {
>                 int ret = pm->runtime_idle(dev);
>                 if (ret)
>                         return ret;
>         }
> 
>         pm_runtime_suspend(dev);
>         return 0;
> }
> 
> If the driver has a NULL runtime idle, then generic code will call
> pm_runtime_suspend() for the device.  So, adding a runtime_idle callback
> to a driver to explicitly call pm_runtime_suspend() is not required.
> 

You are somewhat correct. But the patch is still needed as is!

Reason is simply that after a probe, driver core is calling 
pm_runtime_put_sync. This will not go through the 
pm_generic_runtime_idle function, but directly to __pm_runtime_idle.
