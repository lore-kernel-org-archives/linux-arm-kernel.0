From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 19 Dec 2014 15:46:06 +0900
Subject: [PATCHv4 1/8] devfreq: event: Add new devfreq_event class to
 provide basic data for devfreq governor
In-Reply-To: <1107836838.16761418955089663.JavaMail.weblogic@epmlwas08d>
References: <1107836838.16761418955089663.JavaMail.weblogic@epmlwas08d>
Message-ID: <5493C9AE.1020202@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Myungjoo,

On 12/19/2014 11:11 AM, MyungJoo Ham wrote:
>>   
>>  Dear Myungjoo,
>>
>> Thanks for your review.
>>
>> On 12/18/2014 03:24 PM, MyungJoo Ham wrote:
>>> Hi Chanwoo,
>>>
>>> I love the idea and I now have a little mechanical issues in your code.
>>>
>>>> ---
>>>>  drivers/devfreq/Kconfig         |   2 +
>>>>  drivers/devfreq/Makefile        |   5 +-
>>>>  drivers/devfreq/devfreq-event.c | 449 ++++++++++++++++++++++++++++++++++++++++
>>>>  drivers/devfreq/event/Makefile  |   1 +
>>>>  include/linux/devfreq.h         | 160 ++++++++++++++
>>>>  5 files changed, 616 insertions(+), 1 deletion(-)
>>>>  create mode 100644 drivers/devfreq/devfreq-event.c
>>>>  create mode 100644 drivers/devfreq/event/Makefile
>>>>
> 
> []
> 
>>
>>>
>>>
>>> [snip]
>>>
>>>> diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
>>>> new file mode 100644
>>>> index 0000000..0e1948e
>>>> --- /dev/null
>>>> +++ b/drivers/devfreq/devfreq-event.c
>>>> @@ -0,0 +1,449 @@
>>>> +/*
>>>> + * devfreq-event: Generic DEVFREQ Event class driver
>>>
>>> DEVFREQ is a generic DVFS mechanism (or subsystem).
>>>
>>> Plus, I thought devfreq-event is considered to be a "framework"
>>> for devfreq event class drivers. Am I mistaken?
>>
>> You're right. just "class driver" description is not proper.
>> I'll modify the description of devfreq-event.c as following:
>> or If you have other opinion, would you please let me know about it?
>>
>> 	devfreq-event: DEVFREQ-Event Framework to provide raw data of Non-CPU Devices.
> 
> devfreq-event: a framework to provide raw data and events of devfreq devices
> 
> should be enough.

OK, I'll modify it.

> 
> 
> []
>>> [snip / reversed maybe.. sorry]
>>>
>>>> +/**
>>>> + * devfreq_event_is_enabled() - Check whether devfreq-event dev is enabled or
>>>> + *                             not.
>>>> + * @edev       : the devfreq-event device
>>>> + *
>>>> + * Note that this function check whether devfreq-event dev is enabled or not.
>>>> + * If return true, the devfreq-event dev is enabeld. If return false, the
>>>> + * devfreq-event dev is disabled.
>>>> + */
>>>> +bool devfreq_event_is_enabled(struct devfreq_event_dev *edev)
>>>> +{
>>>> +       bool enabled = false;
>>>> +
>>>> +       if (!edev || !edev->desc)
>>>> +               return enabled;
>>>> +
>>>> +       mutex_lock(&edev->lock);
>>>> +
>>>> +       if (edev->enable_count > 0)
>>>> +               enabled = true;
>>>> +
>>>> +       if (edev->desc->ops && edev->desc->ops->is_enabled)
>>>> +               enabled |= edev->desc->ops->is_enabled(edev);
>>>
>>> What does it mean when enabled_count > 0 and ops->is_enabled() is false? or..
>>> What does it mean when enabled_count = 0 and ops->is_enabled() is true?
>>>
>>> If you do enable_count in the subsystem, why would we rely on
>>> ops->is_enabled()? Are you assuming that a device MAY turn itself off
>>> without any kernel control (ops->disable()) and it is still a correct
>>> behabior?
>>
>> You're right. devfreq_event_is_enabled() has ambiguous operation according to your comment.
>>
>> I'll only control the enable_count in the subsystem without ops->is_enabled()
>> and then remove the is_enabled function in the structre devfreq_event_ops.
>>
>> Best Regards,
>> Chanwoo Choi
>>
> 
> [Off-Topic]
> 
> The name of devfreq-event may look quite intersecting with irq-driven governors,
> which are being proposed these days.
> 
> Although they may look intersecting, we can have them independently;
> this as a sub-class and that as a governor. And we can consider to
> provide a common infrastructure for irq-driven mechanisms in devfreq or
> devfreq-event when we irq-driven DVFS become more general, which I
> expect in 2 ~ 3 years.
> 
> So for now, both can go independently.

I understand your opinion.
I want to handle the devfreq-event framework independently from irq-driven governor.

After completing the devfreq-event and the support for exynos-busfreq dt,
If you agree, I'll consider how to implement irq-driven governor as the devfreq governor.

Best Regards,
Chanwoo Choi
