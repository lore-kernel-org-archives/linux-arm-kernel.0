From: john.garry@huawei.com (John Garry)
Date: Fri, 12 Oct 2018 14:25:49 +0100
Subject: [PATCH] perf tools: Store ids for events with their own cpus
 perf_event__synthesize_event_update_cpus
In-Reply-To: <20181009100049.GF6499@krava>
References: <712b7c31-f681-7737-71e7-c028b8d2bba5@huawei.com>
 <20180927160210.GF6916@krava>
 <4ac88076-60fa-4509-7fa0-2f99d73174d2@huawei.com>
 <20181002111621.GA6357@krava> <20181003113643.GA31725@krava>
 <594506a2-8cb3-3d09-82ab-5cb6d8c31ed0@huawei.com>
 <20181003141627.GA6341@krava> <20181003212052.GA32371@krava>
 <d071bb27-5533-da2f-9f8f-808183e04794@huawei.com>
 <20181009100049.GF6499@krava>
Message-ID: <31101407-0bcd-2fbf-361e-43cbcb81cd19@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/2018 11:00, Jiri Olsa wrote:
> On Thu, Oct 04, 2018 at 10:20:39AM +0100, John Garry wrote:
>
> SNIP
>
>>> We synthesize an update event that needs to touch the evsel
>>> id array, which is not defined at that time. Fixing this by
>>> forcing the id allocation for events with theeir own cpus.

/s/theeir/their/

>>>
>>> Reported-by: John Garry <john.garry@huawei.com>
>>> Link: http://lkml.kernel.org/n/tip-8x4n7o34yheigoxm1jibflm6 at git.kernel.org
>>
>> Tested-by: John Garry <john.garry@huawei.com>
>>
>> In terms of adding to stable, LT v4.14 is not affected, but 4.18.x is.
>>
>> Thanks,
>> John
>
> Arnaldo, could you please pick up this one
>

Just a friendly reminder on this patch.

How about re-send with an updated commit message also?

Thanks,
John

> thanks,
> jirka
>
>>
>>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>>> ---
>>>  tools/perf/builtin-report.c | 1 +
>>>  tools/perf/util/evsel.c     | 3 +++
>>>  2 files changed, 4 insertions(+)
>>>
>>> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
>>> index c0703979c51d..257c9c18cb7e 100644
>>> --- a/tools/perf/builtin-report.c
>>> +++ b/tools/perf/builtin-report.c
>>> @@ -980,6 +980,7 @@ int cmd_report(int argc, const char **argv)
>>>  			.id_index	 = perf_event__process_id_index,
>>>  			.auxtrace_info	 = perf_event__process_auxtrace_info,
>>>  			.auxtrace	 = perf_event__process_auxtrace,
>>> +			.event_update	 = perf_event__process_event_update,
>>>  			.feature	 = process_feature_event,
>>>  			.ordered_events	 = true,
>>>  			.ordering_requires_timestamps = true,
>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>>> index ac6cfb8b085e..7a0d5fbaf3c1 100644
>>> --- a/tools/perf/util/evsel.c
>>> +++ b/tools/perf/util/evsel.c
>>> @@ -1088,6 +1088,9 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
>>>  		attr->exclude_user   = 1;
>>>  	}
>>>
>>> +	if (evsel->own_cpus)
>>> +		evsel->attr.read_format |= PERF_FORMAT_ID;
>>> +
>>>  	/*
>>>  	 * Apply event specific term settings,
>>>  	 * it overloads any global configuration.
>>>
>>
>>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> .
>
