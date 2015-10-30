From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Fri, 30 Oct 2015 12:29:00 +0000
Subject: [PATCH] ARM64: Enable multi-core scheduler support by default
In-Reply-To: <20151029171944.GS8899@e104818-lin.cambridge.arm.com>
References: <1445273749-16778-1-git-send-email-dietmar.eggemann@arm.com>
 <20151029171944.GS8899@e104818-lin.cambridge.arm.com>
Message-ID: <5633628C.1010200@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/29/2015 05:19 PM, Catalin Marinas wrote:
> On Mon, Oct 19, 2015 at 05:55:49PM +0100, Dietmar Eggemann wrote:
>> Make sure that the task scheduler domain hierarchy is set-up correctly
>> on systems with single or multi-cluster topology.
>>
>> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> ---
>>   arch/arm64/configs/defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index 34d71dd86781..dc70d715bc38 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -51,6 +51,7 @@ CONFIG_PCI=y
>>   CONFIG_PCI_MSI=y
>>   CONFIG_PCI_XGENE=y
>>   CONFIG_SMP=y
>> +CONFIG_SCHED_MC=y
>>   CONFIG_PREEMPT=y
>>   CONFIG_KSM=y
>>   CONFIG_TRANSPARENT_HUGEPAGE=y
>
> Question: does enabling this option have any (positive) effect on the
> vanilla kernel or it requires additional patches like EAS?

It improves the task scheduler decisions on multi-cluster systems. You 
have to iterate over all cpu's less frequently when gathering the sched 
group statistics e.g. during CFS load-balancing.

You essentially replace a flat (all cpus) with an hierarchical approach 
(lowest level: sched group eq. cpu, next level: sched group eq. cluster) 
and do CFS load balancing frequently between two cpu's of the same 
cluster (lowest level) and less frequently between two cpus from 
different cluster.

Not sure that I would see an effect on the performance score on a JUNO 
board when running hackbench. Could give it a try ... Probably easier to 
spot on a machine with >32 logical cpus.

EAS has to work with both approaches although we do all our tests with 
CONFIG_SCHED_MC=y. EAS operates on sched groups so the actual structure 
of the sched domain hierarchy is hidden. (at least in theory).

For me CONFIG_SCHED_MC=y is something I would expect when I evaluate the 
task scheduler on a multi-cluster system.

-- Dietmar

[...]
