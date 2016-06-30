From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 30 Jun 2016 07:51:00 -0700
Subject: [3/3] hwmon: iio_hwmon: defer probe when no channel is found
In-Reply-To: <6FBFD60A-4D68-4B60-AB34-5077BE6BD586@jic23.retrosnub.co.uk>
References: <1467101897-15946-4-git-send-email-quentin.schulz@free-electrons.com>
 <20160630034725.GA26484@roeck-us.net>
 <6FBFD60A-4D68-4B60-AB34-5077BE6BD586@jic23.retrosnub.co.uk>
Message-ID: <577531D4.1090106@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/30/2016 06:59 AM, Jonathan Cameron wrote:
>
>
> On 30 June 2016 04:47:25 BST, Guenter Roeck <linux@roeck-us.net> wrote:
>> On Tue, Jun 28, 2016 at 10:18:17AM +0200, Quentin Schulz wrote:
>>> iio_channel_get_all returns -ENODEV when it cannot find either
>> phandles and
>>> properties in the Device Tree or channels whose consumer_dev_name
>> matches
>>> iio_hwmon in iio_map_list. The iio_map_list is filled in by iio
>> drivers
>>> which might be probed after iio_hwmon.
>>>
>>> It is better to defer the probe of iio_hwmon if such error is
>> returned by
>>> iio_channel_get_all in order to let a chance to iio drivers to expose
>>> channels in iio_map_list.
>>>
>>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>>> ---
>>>   drivers/hwmon/iio_hwmon.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
>>> index b550ba5..c0da4d9 100644
>>> --- a/drivers/hwmon/iio_hwmon.c
>>> +++ b/drivers/hwmon/iio_hwmon.c
>>> @@ -73,8 +73,11 @@ static int iio_hwmon_probe(struct platform_device
>> *pdev)
>>>   		name = dev->of_node->name;
>>>
>>>   	channels = iio_channel_get_all(dev);
>>> -	if (IS_ERR(channels))
>>> +	if (IS_ERR(channels)) {
>>> +		if (PTR_ERR(channels) == -ENODEV)
>>> +			return -EPROBE_DEFER;
>>
>> The problem, as I see it, is with iio, which should return
>> -EPROBE_DEFER
>> in this situation.
> Agreed. New fangled stuff this deferred probing :)
>>
>> We can not convert -ENODEV to -EPROBE_DEFER without risking that the
>> channels are _really_ not there, which would result in endless
>> "deferred"
>> messages.
> Hmm not entirely sure how we prevent that happening wherever it is done..
>

Outch. Better at the source, though. I didn't look at the iio code recently,
but can you detect the defer situation at least with devicetree ?

For non-devicetree situations, the only option I can think of would be
to replace the module initcall with a later initcall. That should solve
the problem if both iio_hwmon and and underlying drivers are built
into the kernel. If iio_hwmon is modular, the only real option I can
see is to make sure that all drivers it needs are loaded first.

Does this make sense ?

Guenter

>>
>> Guenter
>>
>>>   		return PTR_ERR(channels);
>>> +	}
>>>
>>>   	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
>>>   	if (st == NULL) {
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
