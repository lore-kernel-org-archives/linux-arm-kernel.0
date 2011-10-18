From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 18 Oct 2011 12:14:51 +0100
Subject: [PATCH 2/6] drivers/base: add bus for System-on-Chip devices
In-Reply-To: <20111017161854.GB5108@suse.de>
References: <1318852378-14180-1-git-send-email-lee.jones@linaro.org>
	<1318852378-14180-3-git-send-email-lee.jones@linaro.org>
	<20111017161854.GB5108@suse.de>
Message-ID: <4E9D5FAB.2080605@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/10/11 17:18, Greg KH wrote:
> On Mon, Oct 17, 2011 at 12:52:54PM +0100, Lee Jones wrote:
>> +void soc_device_unregister(struct device *dev)
> 
> Ick, no, pass in the struct soc_device, which the register function
> should return, not a "raw" struct device.

Okay.

>> +{
>> +	struct soc_device *soc_dev =
>> +		container_of(dev, struct soc_device, dev);
>> +
>> +	sysfs_remove_group(&dev->kobj, &soc_attr_group);
>> +
>> +	if (device_is_registered(dev))
>> +		device_unregister(dev);
> 
> Why is this call needed?

To unregister a previously unregistered device?

Is that wrong?

>> +
>> +	bus_unregister(&soc_bus_type);
> 
> What happens if you have more than one SOC device?  I think you just
> oopsed.

I think you're right.

When to you suggest we unregister the bus?

>> +
>> +	kfree(soc_dev->attr);
>> +	kfree(soc_dev);
> 
> Nope, you just failed again.  I can tell you never tried this code path,
> otherwise you would have noticed the HUGE warnings that the kernel spit
> back at you.  Please fix this.

I'll look into it.

Thanks.

Kind regards,
Lee
