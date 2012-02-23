From: ashwinc@codeaurora.org (Ashwin Chaugule)
Date: Thu, 23 Feb 2012 11:00:45 -0500
Subject: [PATCH] ARM: perf: add PMU hotplug notifier
In-Reply-To: <4F4661E2.9020405@codeaurora.org>
References: <CAKHPGBaY1OFiVubic+f1vxxzNeKjmzibxraBg8eNxZnJbhYi+A@mail.gmail.com>
 <4F4661E2.9020405@codeaurora.org>
Message-ID: <4F4662AD.6030306@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gah. Messed up email addr.

On 2/23/2012 10:57 AM, Ashwin Chaugule wrote:
> Hi Will,
> 
> On Thu, Feb 23, 2012 at 10:41 AM, Will Deacon <will.deacon@arm.com> wrote:
>> From: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
>>
>> When a CPU is taken out of reset, either cold booted or hotplugged in,
>> some of its PMU registers can contain UNKNOWN values.
>>
>> This patch adds a hotplug notifier to ARM core perf code so that upon
>> CPU restart the PMU unit is reset and becomes ready to use again.
>>
>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> I was playing around with this stuff recently, but used the CPU PM code from
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/052829.html
> 
>> ---
>>  arch/arm/kernel/perf_event.c |   23 +++++++++++++++++++++++
>>  1 files changed, 23 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
>> index ab59c3b..fa30ff9 100644
>> --- a/arch/arm/kernel/perf_event.c
>> +++ b/arch/arm/kernel/perf_event.c
>> @@ -680,6 +680,28 @@ static void __init cpu_pmu_init(struct arm_pmu *armpmu)
>>  }
>>
>>  /*
>> + * PMU hardware loses all context when a CPU goes offline.
>> + * When a CPU is hotplugged back in, since some hardware registers are
>> + * UNKNOWN at reset, the PMU must be explicitly reset to avoid reading
>> + * junk values out of them.
>> + */
>> +static int __cpuinit pmu_cpu_notify(struct notifier_block *b,
>> +                                       unsigned long action, void *hcpu)
>> +{
>> +       if (action != CPU_UP_PREPARE)
>> +               return NOTIFY_DONE;
>> +
>> +       if (cpu_pmu && cpu_pmu->reset)
>> +               cpu_pmu->reset(NULL);
>> +
>> +       return NOTIFY_OK;
>> +}
>> +
> 
> I realized I needed to save the counters before going to sleep. In my
> case, the notifiers were being called from the idle thread, so I
> didn't know which "sleep state" I was going to go into. In the deepest
> idle state, the counters are completely reset. When we come out of
> sleep, unless there had been an explicit "read" earlier, we will have
> lost the cached value(event->count) of the counters. This manifests as
> counts reduced by an order of magnitude.
> 
> I'll send a link to my code once the git server is up. It's a bit flaky today.
> 
> 
> Cheers,
> Ashwin
> 


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
