From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Wed, 28 Mar 2018 16:02:38 +0200
Subject: [PATCH] sched: support dynamiQ cluster
In-Reply-To: <20180328091226.GD28871@arm.com>
References: <1522223215-23524-1-git-send-email-vincent.guittot@linaro.org>
 <20180328091226.GD28871@arm.com>
Message-ID: <CAKfTPtCXPM75N27WzDHSc7rkaNEo8cTU4YO9h1X6ckL-=WkL_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 March 2018 at 11:12, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Mar 28, 2018 at 09:46:55AM +0200, Vincent Guittot wrote:

>>
>> The SD_ASYM_PACKING flag is disabled by default and I'm preparing another patch
>> to enable this dynamically at boot time by detecting the system topology.
>>
>>  arch/arm64/kernel/topology.c | 30 ++++++++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>> index 2186853..cb6705e5 100644
>> --- a/arch/arm64/kernel/topology.c
>> +++ b/arch/arm64/kernel/topology.c
>> @@ -296,6 +296,33 @@ static void __init reset_cpu_topology(void)
>>       }
>>  }
>>
>> +#ifdef CONFIG_SCHED_MC
>> +unsigned int __read_mostly arm64_sched_asym_enabled;
>> +
>> +int arch_asym_cpu_priority(int cpu)
>> +{
>> +     return topology_get_cpu_scale(NULL, cpu);
>> +}
>> +
>> +static inline int arm64_sched_dynamiq(void)
>> +{
>> +     return arm64_sched_asym_enabled ? SD_ASYM_PACKING : 0;
>> +}
>> +
>> +static int arm64_core_flags(void)
>> +{
>> +     return cpu_core_flags() | arm64_sched_dynamiq();
>> +}
>> +#endif
>> +
>> +static struct sched_domain_topology_level arm64_topology[] = {
>> +#ifdef CONFIG_SCHED_MC
>> +     { cpu_coregroup_mask, arm64_core_flags, SD_INIT_NAME(MC) },
>
> Maybe stick this in a macro to avoid the double #ifdef?

ok, I will do that in next version

Vincent

>
> Will
