From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 12 Jan 2015 20:17:20 +0900
Subject: [PATCHv7 02/10] devfreq: event: Add the list of supported
 devfreq-event type
In-Reply-To: <768125446.886831421046952335.JavaMail.weblogic@epmlwas09a>
References: <768125446.886831421046952335.JavaMail.weblogic@epmlwas09a>
Message-ID: <54B3AD40.3040308@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Myungjoo,

On 01/12/2015 04:15 PM, MyungJoo Ham wrote:
>>   
>>  This patch adds the list of supported devfreq-event type as following.
>> Each devfreq-event device driver would support the various devfreq-event type
>> for devfreq governor at the same time.
>> - DEVFREQ_EVENT_TYPE_RAW_DATA
>> - DEVFREQ_EVENT_TYPE_UTILIZATION
>> - DEVFREQ_EVENT_TYPE_BANDWIDTH
>> - DEVFREQ_EVENT_TYPE_LATENCY
> 
> Did you try to say:
> 
> A devfreq-event device may support multiple devfreq-event types
> simultaneously.

I think that one devfreq-event device can support multiple devfreq-event types.
but, devfreq-event device might provide only value at one point.

But,
This patch is ambiguous and includes a bug according to your comment
(below switch statement). I'll drop this patch on next patch-set.

This patch will be posted on further patch-set after resolving some issue.

Best Regards,
Chanwoo Choi

> 
> If so, your switch expressions are going to screw up.
> 
> 
>>
>> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
>> Cc: Kyungmin Park <kyungmin.park@samsung.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/devfreq/devfreq-event.c | 58 ++++++++++++++++++++++++++++++++++++-----
>>  include/linux/devfreq-event.h   | 25 +++++++++++++++---
>>  2 files changed, 73 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
>> index 81448ba..64c1764 100644
>> --- a/drivers/devfreq/devfreq-event.c
>> +++ b/drivers/devfreq/devfreq-event.c
>>  
> []
>> -	mutex_lock(&edev->lock);
>> -	ret = edev->desc->ops->get_event(edev, edata);
>> -	mutex_unlock(&edev->lock);
>> +	switch (type) {
> 
> Bitwise value with switch? (what if type = RAW_DATA | BANDWIDTH, meaning
> this is raw data of the bandwitdh.)
> 
>> +	case DEVFREQ_EVENT_TYPE_RAW_DATA:
>> +	case DEVFREQ_EVENT_TYPE_BANDWIDTH:
>> +	case DEVFREQ_EVENT_TYPE_LATENCY:
>> +		if ((edata->event > EVENT_TYPE_RAW_DATA_MAX) ||
>> +			(edata->total_event > EVENT_TYPE_RAW_DATA_MAX)) {
> 
> Is it possible for unsigned long edata->event/total_event to be
>   > EVENT_TYPE_RAW_DATA_MAX = ULONG_MAX?
> 
> What was your intention?
> 
> If you were trying to detect overflow, you need to rethink about it.
> If not, (overflow is harmless or not going to happen) you don't need to
> check it.
> 
> 
>> +			edata->event = edata->total_event = 0;
>> +			ret = -EINVAL;
>> +		}
>> +		break;
>> +	case DEVFREQ_EVENT_TYPE_UTILIZATION:
>> +		edata->total_event = EVENT_TYPE_UTILIZATION_MAX;
>>  
>> -	if ((edata->total_event <= 0)
>> -		|| (edata->event > edata->total_event)) {
>> +		if (edata->event > EVENT_TYPE_UTILIZATION_MAX) {
>> +			edata->event = edata->total_event = 0;
>> +			ret = -EINVAL;
>> +		}
>> +		break;
>> +	default:
>>  		edata->event = edata->total_event = 0;
>>  		ret = -EINVAL;
>> +		break;
>>  	}
>>  
>> +	mutex_unlock(&edev->lock);
>> +
>>  	return ret;
>>  }
>>  EXPORT_SYMBOL_GPL(devfreq_event_get_event);
>> diff --git a/include/linux/devfreq-event.h b/include/linux/devfreq-event.h
>> index b7363f5..13a5703 100644
>> --- a/include/linux/devfreq-event.h
>> +++ b/include/linux/devfreq-event.h
>> @@ -36,6 +36,14 @@ struct devfreq_event_dev {
>>  	const struct devfreq_event_desc *desc;
>>  };
>>  
>> +/* The supported type by devfreq-event device */
>> +enum devfreq_event_type {
>> +	DEVFREQ_EVENT_TYPE_RAW_DATA	= BIT(0),
>> +	DEVFREQ_EVENT_TYPE_UTILIZATION	= BIT(1),
>> +	DEVFREQ_EVENT_TYPE_BANDWIDTH	= BIT(2),
>> +	DEVFREQ_EVENT_TYPE_LATENCY	= BIT(3),
>> +};
>> +
> 
> (Being curious) Is it possible to have multiple types
> simultaneously?
> 
> 
> []
> N?????r??y???b?X???v?^?)?{.n?+????{?????x,??????}????z?&j:+v???????zZ+??+zf???h???~????i???z?
?w????????&?)?fl===
> 
