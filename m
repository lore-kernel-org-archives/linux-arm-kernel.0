From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 5 Feb 2016 19:30:30 +0100
Subject: [PATCH v3 1/3] reset: Make [of_]reset_control_get[_foo] functions
 wrappers
In-Reply-To: <1454604866.3356.78.camel@pengutronix.de>
References: <1453918516-3078-1-git-send-email-hdegoede@redhat.com>
 <1453918516-3078-2-git-send-email-hdegoede@redhat.com>
 <1454604866.3356.78.camel@pengutronix.de>
Message-ID: <56B4EA46.7060905@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04-02-16 17:54, Philipp Zabel wrote:
> Hi Hans,
>
> Am Mittwoch, den 27.01.2016, 19:15 +0100 schrieb Hans de Goede:
> [...]
>> +/**
>> + * reset_control_get - Lookup and obtain a reference to a reset controller.
>> + * @dev: device to be reset by the controller
>> + * @id: reset line name
>> + *
>> + * Returns a struct reset_control or IS_ERR() condition containing errno.
>> + *
>> + * Use of id names is optional.
>> + */
>> +static inline struct reset_control *__must_check reset_control_get(
>>   					struct device *dev, const char *id)
>>   {
>> -	return ERR_PTR(-ENOTSUPP);
>> +#ifndef CONFIG_RESET_CONTROLLER
>> +	WARN_ON(1);
>> +#endif
>> +	return __of_reset_control_get(dev ? dev->of_node : NULL, id, 0);
>
> Even though we are device tree only at this point, I'd prefer to keep an
> exported function that takes a struct device argument, for example:
>
> 	return __reset_control_get(dev, id, 0);

I don't really see a reason to do this, this is not userspace abi or some-such
we can always later re-introduce an exported function which takes a device
argument. But if you insist, you're the boss :)  Let me know if you really
want me to make this change for the next version, and I'll add it to v4 of this
set.

Regards,

Hans
