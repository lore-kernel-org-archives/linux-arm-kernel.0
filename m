From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 21 Jul 2016 09:15:36 -0600
Subject: [PATCH 03/10] coresight: etm-perf: configuring filters from perf
 core
In-Reply-To: <d711d4da-a356-3a71-c594-785efb1ae752@arm.com>
References: <1468871491-10997-1-git-send-email-mathieu.poirier@linaro.org>
 <1468871491-10997-4-git-send-email-mathieu.poirier@linaro.org>
 <d711d4da-a356-3a71-c594-785efb1ae752@arm.com>
Message-ID: <CANLsYkzUrRVZbCrhsV=X-2EhbtBpX5fX16g2pOdsRc3XF8+8Rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 July 2016 at 10:07, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
> On 18/07/16 20:51, Mathieu Poirier wrote:
>>
>> This patch implements the required API needed to access
>> and retrieve range and start/stop filters from the perf core.
>>
>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> ---
>>  drivers/hwtracing/coresight/coresight-etm-perf.c | 146
>> ++++++++++++++++++++---
>>  drivers/hwtracing/coresight/coresight-etm-perf.h |  32 +++++
>>  2 files changed, 162 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c
>> b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> index 78a1bc0013a2..fde7f42149c5 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> @@ -29,6 +29,7 @@
>>  #include <linux/workqueue.h>
>>
>>  #include "coresight-priv.h"
>> +#include "coresight-etm-perf.h"
>>
>>  static struct pmu etm_pmu;
>>  static bool etm_perf_up;
>> @@ -83,12 +84,44 @@ static const struct attribute_group
>> *etm_pmu_attr_groups[] = {
>>
>>  static void etm_event_read(struct perf_event *event) {}
>>
>> +static int etm_addr_filters_alloc(struct perf_event *event)
>> +{
>
>
> ...
>
>> +       return 0;
>> +}
>> +
>
>
>
>> +
>>  static int etm_event_init(struct perf_event *event)
>>  {
>> +       int ret;
>> +
>>         if (event->attr.type != etm_pmu.type)
>>                 return -ENOENT;
>>
>> -       return 0;
>> +       ret = etm_addr_filters_alloc(event);
>
>
>
>>  }
>>
>>  static void free_event_data(struct work_struct *work)
>> @@ -456,6 +489,85 @@ static void etm_free_drv_configs(struct perf_event
>> *event)
>>         }
>>  }
>>
>> +static int etm_addr_filters_validate(struct list_head *filters)
>> +{
>
>
>> +
>> +       return 0;
>> +}
>> +
>> +static void etm_addr_filters_sync(struct perf_event *event)
>> +{
>> +       struct perf_addr_filters_head *head =
>> perf_event_addr_filters(event);
>> +       unsigned long start, stop, *offs = event->addr_filters_offs;
>> +       struct etm_filters *filters = event->hw.addr_filters;
>> +       struct perf_addr_filter *filter;
>> +       int i = 0;
>
>
> Is it possible to delay the etm_addr_filters_alloc() until this point ?
> I understand that this function cannot report back failures if we fail
> to allocate memory. Or may be do a lazy allocation from
> addr_filters_validate(),
> when we get the first filter added.

Humm... You want to avoid allocating memory that may never be used if
filters aren't specified.  Ok, let's do the allocation in
addr_filters_validate().

>
> Of course this could be done as a follow up patch to improve things once
> we get the initial framework in.
>
>
>
>> +
>> +       list_for_each_entry(filter, &head->list, entry) {
>> +               start = filter->offset + offs[i];
>> +               stop = start + filter->size;
>> +
>> +               if (filter->range == 1) {
>> +                       filters->filter[i].start_addr = start;
>> +                       filters->filter[i].stop_addr = stop;
>> +                       filters->filter[i].type = ETM_ADDR_TYPE_RANGE;
>> +               } else {
>> +                       if (filter->filter == 1) {
>> +                               filters->filter[i].start_addr = start;
>> +                               filters->filter[i].type =
>> ETM_ADDR_TYPE_START;
>> +                       } else {
>> +                               filters->filter[i].stop_addr = stop;
>> +                               filters->filter[i].type =
>> ETM_ADDR_TYPE_STOP;
>> +                       }
>> +               }
>> +               i++;
>> +       }
>> +
>> +       filters->nr_filters = i;
>> +/**
>> + * struct etm_filters - set of filters for a session
>> + * @etm_filter:        All the filters for this session.
>> + * @nr_filters:        Number of filters
>> + * @ssstatus:  Status of the start/stop logic.
>> + */
>> +struct etm_filters {
>> +       struct etm_filter       filter[ETM_ADDR_CMP_MAX];
>
>
> nit: having the variable renamed to etm_filter will make the code a bit more
> readable
> where we populate/validate the filters.

Very well.

Thanks,
Mathieu

>
> Otherwise looks good
>
> Suzuki
