From: anurupvasu@gmail.com (Anurup M)
Date: Wed, 3 Aug 2016 06:04:45 +0530
Subject: [PATCH 8/8] arm64:perf: L3 cache(LLC) event listing in perf
In-Reply-To: <20160628110125.GG31744@leverpostej>
References: <1467107429-55477-1-git-send-email-anurup.m@huawei.com>
 <1467107429-55477-9-git-send-email-anurup.m@huawei.com>
 <20160628110125.GG31744@leverpostej>
Message-ID: <57A13C25.6060903@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Tuesday 28 June 2016 04:31 PM, Mark Rutland wrote:
> On Tue, Jun 28, 2016 at 05:50:29AM -0400, Anurup M wrote:
>> 	1. Add L3 caches events to /sys/devices/hisi_l3c/events/
>> 	   The events can be selected as shown in perf list
>> 	   e.g.: For LLC_READ_ALLOCATE event for Super CPU cluster 2 the
>> 		 event format is
>> 		 -e "hisi_l3c/l3c_read_allocate,bank=0xf,cluster=0x2/"
>>
>> Signed-off-by: Anurup M <anurup.m@huawei.com>
>> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
>> ---
>>   drivers/perf/hisilicon/hisi_uncore_llc.c | 75 +++++++++++++++++++++++++++++++-
>>   drivers/perf/hisilicon/hisi_uncore_pmu.c | 12 +++++
>>   drivers/perf/hisilicon/hisi_uncore_pmu.h | 16 +++++++
>>   3 files changed, 101 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/perf/hisilicon/hisi_uncore_llc.c b/drivers/perf/hisilicon/hisi_uncore_llc.c
>> index a771e1a..316167a 100644
>> --- a/drivers/perf/hisilicon/hisi_uncore_llc.c
>> +++ b/drivers/perf/hisilicon/hisi_uncore_llc.c
>> @@ -25,11 +25,11 @@
>>   #include "hisi_uncore_llc.h"
>>   
>>   /* Map cfg_en values for LLC Banks */
>> -const int llc_cfgen_map[] = { HISI_LLC_BANK0_CFGEN, HISI_LLC_BANK1_CFGEN,
>> +static const int llc_cfgen_map[] = { HISI_LLC_BANK0_CFGEN, HISI_LLC_BANK1_CFGEN,
>>   				HISI_LLC_BANK2_CFGEN, HISI_LLC_BANK3_CFGEN
>>   };
>>   
>> -struct hisi_pmu *hisi_uncore_llc;
>> +static struct hisi_pmu *hisi_uncore_llc;
>>   
>>   static inline int hisi_llc_counter_valid(int idx)
>>   {
>> @@ -442,6 +442,76 @@ static void hisi_free_llc_data(struct hisi_hwmod_unit *punit)
>>   	kfree(punit->hwmod_data);
>>   }
>>   
>> +PMU_FORMAT_ATTR(event, "config:0-11");
>> +PMU_FORMAT_ATTR(bank, "config:12-15");
>> +PMU_FORMAT_ATTR(module, "config:16-19");
>> +PMU_FORMAT_ATTR(cluster, "config:20-23");
>> +PMU_FORMAT_ATTR(socket, "config:24-25");
>> +
>> +#define HISI_UNCORE_EVENT_DESC(_name, _config)			\
>> +{								\
>> +	.attr   = __ATTR(_name, 0444, uncore_event_show, NULL), \
>> +	.config = _config,					\
>> +}
>> +
>> +static struct attribute *hisi_llc_format_attr[] = {
>> +	&format_attr_event.attr,
>> +	&format_attr_bank.attr,
>> +	&format_attr_module.attr,
>> +	&format_attr_cluster.attr,
>> +	&format_attr_socket.attr,
>> +	NULL,
>> +};
> Pleas use the compound literal trick I describe in [1].
Thanks, I have modified them, shall send the revised patchset.

Thanks,
Anurup
>> +
>> +static struct attribute_group hisi_llc_format_group = {
>> +	.name = "format",
>> +	.attrs = hisi_llc_format_attr,
>> +};
>> +
>> +EVENT_ATTR_STR(l3c_read_allocate,
>> +			"event=0x301,bank=?,module=0x4,cluster=?,socket=0x1");
>> +EVENT_ATTR_STR(l3c_write_allocate,
>> +			"event=0x302,bank=?,module=0x4,cluster=?,socket=0x1");
>> +EVENT_ATTR_STR(l3c_read_noallocate,
>> +			"event=0x303,bank=?,module=0x4,cluster=?,socket=0x1");
>> +EVENT_ATTR_STR(l3c_write_noallocate,
>> +			"event=0x304,bank=?,module=0x4,cluster=?,socket=0x1");
>> +EVENT_ATTR_STR(l3c_read_hit,
>> +			"event=0x305,bank=?,module=0x4,cluster=?,socket=0x1");
>> +EVENT_ATTR_STR(l3c_write_hit,
>> +			"event=0x306,bank=?,module=0x4,cluster=?,socket=0x1");
>> +
>> +
>> +static struct attribute *hisi_llc_events_attr[] = {
>> +	EVENT_PTR(l3c_read_allocate),
>> +	EVENT_PTR(l3c_write_allocate),
>> +	EVENT_PTR(l3c_read_noallocate),
>> +	EVENT_PTR(l3c_write_noallocate),
>> +	EVENT_PTR(l3c_read_hit),
>> +	EVENT_PTR(l3c_write_hit),
>> +	NULL,
>> +};
> Again, please use the compound literal trick.
>
> Regardless of this sysfs data, the format needs documenting, as I
> commented in the last patch.
>
> Thanks,
> Mark.
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-June/438742.html
