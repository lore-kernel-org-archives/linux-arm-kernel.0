From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 16 Dec 2014 10:15:16 +0900
Subject: [RFC PATCHv3 2/7] devfreq: event: Add the list of supported
 devfreq-event type
In-Reply-To: <1418655206.20866.6.camel@AMDC1943>
References: <1418372852-12454-1-git-send-email-cw00.choi@samsung.com>
 <1418372852-12454-3-git-send-email-cw00.choi@samsung.com>
 <1418655206.20866.6.camel@AMDC1943>
Message-ID: <548F87A4.5060000@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 12/15/2014 11:53 PM, Krzysztof Kozlowski wrote:
> On pi?, 2014-12-12 at 17:27 +0900, Chanwoo Choi wrote:
>> This patch adds the list of supported devfreq-event type as following.
>> Each devfreq-event device driver would support the various devfreq-event type
>> for devfreq governor at the same time.
>> - DEVFREQ_EVENT_TYPE_RAW_DATA
>> - DEVFREQ_EVENT_TYPE_UTILIZATION
>> - DEVFREQ_EVENT_TYPE_BANDWIDTH
>> - DEVFREQ_EVENT_TYPE_LATENCY
>>
>> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
>> Cc: Kyungmin Park <kyungmin.park@samsung.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/devfreq/devfreq-event.c | 44 +++++++++++++++++++++++++++++++++++++----
>>  include/linux/devfreq.h         | 29 ++++++++++++++++++++++-----
>>  2 files changed, 64 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
>> index eaf59c1..9444f93 100644
>> --- a/drivers/devfreq/devfreq-event.c
>> +++ b/drivers/devfreq/devfreq-event.c
>> @@ -29,6 +29,9 @@
>>  #include <linux/of.h>
>>  #include "governor.h"
>>  
>> +#define EVENT_TYPE_RAW_DATA_MAX		U64_MAX
>> +#define EVENT_TYPE_UTILIZATION_MAX	100
>> +
>>  static struct class *devfreq_event_class;
>>  
>>  /* The list of all devfreq event list */
>> @@ -144,7 +147,8 @@ EXPORT_SYMBOL_GPL(devfreq_event_is_enabled);
>>   * Note that this function set the event to the devfreq-event device to start
>>   * for getting the event data which could be various event type.
>>   */
>> -int devfreq_event_set_event(struct devfreq_event_dev *edev)
>> +int devfreq_event_set_event(struct devfreq_event_dev *edev,
>> +				enum devfreq_event_type type)
>>  {
>>  	int ret;
>>  
>> @@ -158,7 +162,15 @@ int devfreq_event_set_event(struct devfreq_event_dev *edev)
>>  		return -EPERM;
>>  
>>  	mutex_lock(&edev->lock);
>> -	ret = edev->desc->ops->set_event(edev);
>> +
>> +	if ((edev->desc->type & type) == 0) {
>> +		dev_err(&edev->dev, "unsupported of devfreq-event type\n");
>> +		mutex_unlock(&edev->lock);
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = edev->desc->ops->set_event(edev, type);
>> +
>>  	mutex_unlock(&edev->lock);
>>  
>>  	return ret;
>> @@ -174,7 +186,9 @@ EXPORT_SYMBOL_GPL(devfreq_event_set_event);
>>   * current event data and total_event should be stored in second parameter
>>   * (total_event).
>>   */
>> -u64 devfreq_event_get_event(struct devfreq_event_dev *edev, u64 *total_event)
>> +u64 devfreq_event_get_event(struct devfreq_event_dev *edev,
>> +				enum devfreq_event_type type,
>> +				u64 *total_event)
>>  {
>>  	u64 event;
>>  
>> @@ -190,7 +204,27 @@ u64 devfreq_event_get_event(struct devfreq_event_dev *edev, u64 *total_event)
>>  		return 0;
>>  
>>  	mutex_lock(&edev->lock);
>> -	event = edev->desc->ops->get_event(edev, total_event);
>> +
>> +	if ((edev->desc->type & type) == 0) {
>> +		dev_err(&edev->dev, "unsupported of devfreq-event type\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	event = edev->desc->ops->get_event(edev, type, total_event);
>> +
>> +	switch (type) {
>> +	case DEVFREQ_EVENT_TYPE_RAW_DATA:
>> +	case DEVFREQ_EVENT_TYPE_BANDWIDTH:
>> +	case DEVFREQ_EVENT_TYPE_LATENCY:
>> +		if ((event > *total_event)
>> +			|| ((event > EVENT_TYPE_RAW_DATA_MAX) ||
>> +				*total_event > EVENT_TYPE_RAW_DATA_MAX))
>> +			event = 0;
> 
> missing break here.

My mistake. I'll add it and 'default' case statement.

Best Regards,
Chanwoo Choi
