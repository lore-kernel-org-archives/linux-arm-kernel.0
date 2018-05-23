From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 23 May 2018 13:12:10 +0100
Subject: [PATCH RFC V2 2/6] hwmon: Add support for RPi voltage sensor
In-Reply-To: <723014352.17580.1527017480381@email.1und1.de>
References: <1526988112-4021-1-git-send-email-stefan.wahren@i2se.com>
 <1526988112-4021-3-git-send-email-stefan.wahren@i2se.com>
 <90a768aa-ee8c-1050-cf15-60637069dbdb@roeck-us.net>
 <659923372.11518.1526997096662@email.1und1.de>
 <bea3d6c7-a713-c4aa-8ae8-7fec80c5da5d@roeck-us.net>
 <723014352.17580.1527017480381@email.1und1.de>
Message-ID: <cbbdab47-cde3-7a7c-c797-c00d546e00d5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/05/18 20:31, Stefan Wahren wrote:
[...]
>>>>> +static int rpi_hwmon_probe(struct platform_device *pdev)
>>>>> +{
>>>>> +	struct device *dev = &pdev->dev;
>>>>> +	struct rpi_hwmon_data *data;
>>>>> +	int ret;
>>>>> +
>>>>> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>>>>> +	if (!data)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	data->fw = platform_get_drvdata(to_platform_device(dev->parent));
>>>>> +	if (!data->fw)
>>>>> +		return -EPROBE_DEFER;
>>>>> +
>>>>
>>>> I am a bit at loss here (and sorry I didn't bring this up before).
>>>> How would this ever be possible, given that the driver is registered
>>>> from the firmware driver ?
>>>
>>> Do you refer to the (wrong) return code, the assumption that the parent must be a platform driver or a possible race?
>>>
>>
>> The return code is one thing. My question was how the driver would ever be instantiated
>> with platform_get_drvdata(to_platform_device(dev->parent)) == NULL (but dev->parent != NULL),
>> so I referred to the race. But, sure, a second question would be how that would indicate
>> that the parent is not instantiated yet (which by itself seems like an odd question).
> 
> This shouldn't happen and worth a log error. In patch #3 the registration is called after the complete private data of the firmware driver is initialized. Did i missed something?
> 
> But i must confess that i didn't test all builtin/module combinations.

The point is that, by construction, a "raspberrypi-hwmon" device will 
only ever be created for this driver to bind to if the firmware device 
is both fully initialised and known to support the GET_THROTTLED call 
already. Thus trying to check those again from the hwmon driver is at 
best pointless, and at worst misleading. If somebody *does* manage to 
bind this driver to some random inappropriate device, you've still got 
no guarantee that dev->parent is valid or that 
dev_get_drvdata(dev->parent)) won't return something non-NULL that isn't 
a struct rpi_firmware pointer, at which point you're liable to pass the 
paranoid check yet still crash anyway.

IOW, you can't reasonably defend against incorrect operation, and under 
correct operation there's nothing to defend against, so either way it's 
pretty futile to waste effort trying.

Robin.
