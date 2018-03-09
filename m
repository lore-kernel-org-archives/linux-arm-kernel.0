From: skannan@codeaurora.org (Saravana Kannan)
Date: Fri, 09 Mar 2018 14:49:00 -0800
Subject: [PATCH v11 8/8] perf: ARM DynamIQ Shared Unit PMU support
In-Reply-To: <20180309133531.fepm2suvdmvm4muv@lakrids.cambridge.arm.com>
References: <20180102112533.13640-1-suzuki.poulose@arm.com>
 <20180102112533.13640-9-suzuki.poulose@arm.com>
 <5AA1CE48.5030203@codeaurora.org>
 <a466d82b-2a0f-ffba-f9f7-c76c6c787bb5@arm.com>
 <20180309133531.fepm2suvdmvm4muv@lakrids.cambridge.arm.com>
Message-ID: <5AA30F5C.2010402@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/2018 05:35 AM, Mark Rutland wrote:
> On Fri, Mar 09, 2018 at 10:53:14AM +0000, Suzuki K Poulose wrote:
>> + Cc: Lorenzo, Charles.
>>
>> On 08/03/18 23:59, Saravana Kannan wrote:
>>> On 01/02/2018 03:25 AM, Suzuki K Poulose wrote:
>>>> Add support for the Cluster PMU part of the ARM DynamIQ Shared Unit (DSU).
>>>> The DSU integrates one or more cores with an L3 memory system, control
>>>> logic, and external interfaces to form a multicore cluster. The PMU
>>>> allows counting the various events related to L3, SCU etc, along with
>>>> providing a cycle counter.
>>>>
>>>> The PMU can be accessed via system registers, which are common
>>>> to the cores in the same cluster. The PMU registers follow the
>>>> semantics of the ARMv8 PMU, mostly, with the exception that
>>>> the counters record the cluster wide events.
>>>>
>>>> This driver is mostly based on the ARMv8 and CCI PMU drivers.
>>>> The driver only supports ARM64 at the moment. It can be extended
>>>> to support ARM32 by providing register accessors like we do in
>>>> arch/arm64/include/arm_dsu_pmu.h.
>>>>
>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>
>> [...]
>>
>>>
>>> Looking at the code, I didn't see any specific handling of cluster power collapse. AFAIK, the HW counters do not retain config (what event they are counting) or value (the current count) across power collapse. Wouldn't you need to register for some kind of PM_ENTER/EXIT notifiers to handle that?
>>
>> Good point, yes *somebody* needs to save-restore the registers. But who ? As far
>> as the kernel is concerned, it doesn't control the DSU states. Also, as of now
>> there is no reliable way to get the "ENTER/EXIT" notifications for the DSU power
>> domain state changes. All we do is use the PMU, assuming it is available. AFAIT,
>> it should really be done at EL3, which manages the DSU, but may be I am wrong.
>
> Given this can happen behind the back of the kernel, if FW doesn't
> save/restore this state, we'll have to inhibit cpuidle on a CPU
> associated with the DSU PMU whenever it has active events, which would
> keep the cluster online.
>

Using PMUs should be designed to have the least impact on 
power/performance. Otherwise, using them to profile and debug issues 
becomes impossible. Disabling cpuidle would significantly affect power 
and performance.

Why not use CPU_CLUSTER_PM_ENTER similar to how arm-pmu.c uses 
CPU_PM_ENTER for saving and restoring the counters? Technically a lot of 
stuff could be pushed to FW. Doesn't mean we should. At worst, we'll 
save and restore for a few cases where we didn't need to.

Thanks,
Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
