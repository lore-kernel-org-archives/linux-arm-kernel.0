From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 28 Mar 2016 12:35:21 +0900
Subject: [PATCH v6 04/21] PM / devfreq: Add new DEVFREQ_TRANSITION_NOTIFIER
 notifier
In-Reply-To: <190611333.27621459133690582.JavaMail.weblogic@epmlwas02a>
References: <190611333.27621459133690582.JavaMail.weblogic@epmlwas02a>
Message-ID: <56F8A679.5010009@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016? 03? 28? 11:54, MyungJoo Ham wrote:
>>   
>>  This patch adds the new DEVFREQ_TRANSITION_NOTIFIER notifier to send
>> the notification when the frequency of device is changed.
>> This notifier has two state as following:
>> - DEVFREQ_PRECHANGE  : Notify it before chaning the frequency of device
>> - DEVFREQ_POSTCHANGE : Notify it after changed the frequency of device
>>
>> And this patch adds the resourced-managed function to release the resource
>> automatically when error happen.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> [m.reichl and linux.amoon: Tested it on exynos4412-odroidu3 board]
>> Tested-by: Markus Reichl <m.reichl@fivetechno.de>
>> Tested-by: Anand Moon <linux.amoon@gmail.com>
>> ---
>>  drivers/devfreq/devfreq.c | 163 +++++++++++++++++++++++++++++++++++++++++++++-
>>  include/linux/devfreq.h   |  58 ++++++++++++++++-
>>  2 files changed, 219 insertions(+), 2 deletions(-)
> 
> []
> 
>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>> index aa0b8424ebc3..152ea342529c 100644
>> --- a/include/linux/devfreq.h
>> +++ b/include/linux/devfreq.h
>> @@ -19,6 +19,13 @@
>>  
>>  #define DEVFREQ_NAME_LEN 16
>>  
>> +/* DEVFREQ notifier interface */
>> +#define DEVFREQ_TRANSITION_NOTIFIER	(0)
>> +
>> +/* Transition notifiers of DEVFREQ_TRANSITION_NOTIFIER */
>> +#define	DEVFREQ_PRECHANGE		(0)
>> +#define DEVFREQ_POSTCHANGE		(1)
>> +
>>  struct devfreq;
>>  
>>  /**
>> @@ -177,6 +184,13 @@ struct devfreq {
>>  	unsigned int *trans_table;
>>  	unsigned long *time_in_state;
>>  	unsigned long last_stat_updated;
>> +
>> +	struct srcu_notifier_head transition_notifier_list;
>> +};
> 
> Like other properties of struct devfreq, please add
> descriptions above. Other than that, it looks good.

OK. I was missing the description. I'll add it.

Best Regards,
Chanwoo Choi
