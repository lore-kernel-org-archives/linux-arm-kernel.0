From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Tue, 4 Nov 2014 09:58:35 +0100
Subject: [PATCH v8 08/10] sched: add SD_PREFER_SIBLING for SMT level
In-Reply-To: <5458462F.6000704@gmail.com>
References: <1414745252-4895-1-git-send-email-vincent.guittot@linaro.org>
 <1414745252-4895-9-git-send-email-vincent.guittot@linaro.org>
 <5458462F.6000704@gmail.com>
Message-ID: <CAKfTPtBcJYBuD-spy6Uq8UnisunUtTiO24JcSoYw+DF87TFLTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 November 2014 04:21, Wanpeng Li <kernellwp@gmail.com> wrote:
> Hi Vincent,
> On 14/10/31 ??4:47, Vincent Guittot wrote:
>>
>> Add the SD_PREFER_SIBLING flag for SMT level in order to ensure that
>> the scheduler will put at least 1 task per core.
>
>
> What's the behavior before this patch?

Before this patch, the capacity_factor was 1 at core level (whatever
the number of CPUs in the core) so the group that represents this core
was overloaded as soon as more than 1 task was running on this group.
So if a core has 2 tasks running in its group, it is seen as
overloaded and the scheduler will try to migrate 1 task on a group
that is idle

Regards,
Vincent

>
> Regards,
> Wanpeng Li
>
>
>>
>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>> Reviewed-by: Preeti U. Murthy <preeti@linux.vnet.ibm.com>
>> ---
>>   kernel/sched/core.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 37fb92c..731f2ad 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -6165,6 +6165,7 @@ sd_init(struct sched_domain_topology_level *tl, int
>> cpu)
>>          */
>>         if (sd->flags & SD_SHARE_CPUCAPACITY) {
>> +               sd->flags |= SD_PREFER_SIBLING;
>>                 sd->imbalance_pct = 110;
>>                 sd->smt_gain = 1178; /* ~15% */
>>
>
>
