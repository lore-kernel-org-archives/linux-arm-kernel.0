From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 12 Oct 2012 15:04:20 -0600
Subject: [PATCH 7/7] ARM: tegra30: cpuidle: add LP2 driver for CPU0
In-Reply-To: <1350025676.20241.82.camel@jlo-ubuntu-64.nvidia.com>
References: <1349691981-31038-1-git-send-email-josephl@nvidia.com>
 <1349691981-31038-8-git-send-email-josephl@nvidia.com>
 <5074AA0E.2080508@wwwdotorg.org>
 <1349954685.19413.207.camel@jlo-ubuntu-64.nvidia.com>
 <5076F5CB.4020200@wwwdotorg.org>
 <1350025676.20241.82.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <507885D4.10604@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/2012 01:07 AM, Joseph Lo wrote:
> On Fri, 2012-10-12 at 00:37 +0800, Stephen Warren wrote:
>> On 10/11/2012 05:24 AM, Joseph Lo wrote:
>>> On Wed, 2012-10-10 at 06:49 +0800, Stephen Warren wrote:
>>>> On 10/08/2012 04:26 AM, Joseph Lo wrote:
>>>>> The cpuidle LP2 is a power gating idle mode. It support power gating
>>>>> vdd_cpu rail after all cpu cores in LP2. For Tegra30, the CPU0 must
>>>>> be last one to go into LP2. We need to take care and make sure whole
>>>>> secondary CPUs were in LP2 by checking CPU and power gate status.
>>>>> After that, the CPU0 can go into LP2 safely. Then power gating the
>>>>> CPU rail.
>>>>
>>>>> diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
>>>>
>>>>> +static bool tegra30_idle_enter_lp2_cpu_0(struct cpuidle_device *dev,
>>>>> +					 struct cpuidle_driver *drv,
>>>>> +					 int index)
>>>>> +{
>>>>> +	struct cpuidle_state *state = &drv->states[index];
>>>>> +	u32 cpu_on_time = state->exit_latency;
>>>>> +	u32 cpu_off_time = state->target_residency - state->exit_latency;
>>>>> +
>>>>> +	if (num_online_cpus() > 1 && !tegra_cpu_rail_off_ready()) {
>>>>
>>>> Should that be || not &&?
>>>>
>>>> Isn't the "num_online_cpus() > 1" condition effectively checked at the
>>>> call site, i.e. in tegra30_idle_lp2() below via the if (last_cpu) check?
>>>>
>>>
>>> Should be "&&" here.
>>> Because we need to check if there are still multi CPUs online, then we
>>> need to make sure all the secondary CPUs be power gated first. After all
>>> the secondary CPUs been power gated, the CPU0 could go into LP2 and the
>>> CPU rail could be shut off.
>>> If all the secondary CPUs been hot plugged, then the "num_online_cpus()
>>>> 1" would be always false. Then the CPU0 can go into LP2 directly.
>>>
>>> So it was used to check are there multi cpus online or not? It's
>>> difference with the last_cpu check below. The last_cpu was used to check
>>> all the CPUs were in LP2 process or not. If the CPU0 is the last one
>>> went into LP2 process, then it would be true.
>>>
>>> So the point here is. We can avoid to check the power status of the
>>> secodarys CPUs if they be unplugged.
>>
>> OK, so this condition is about ignoring the result of
>> tegra_cpu_rail_off_ready() if there is only 1 CPU online. That makes
>> sense, since we know in that case there cannot be any other CPUs to
>> check if they're in LP2 or not.
>>
>> But what about the case where 2 CPUs are online and 2 offline. In that
>> case, num_online_cpus() > 1, so the call to tegra_cpu_rail_off_ready()
>> is skipped.

Uggh. I'm not thinking straight, so what I said there was backwards.

>> b) If CPUn can't trigger rail-gating, then when CPUn is the last to
>> enter LP2 of the whole complex, it needs to IPI to CPU0 to tell it to
>> rail-gate, and simply power-gate itself. I believe this IPI interaction
>> is exactly what coupled cpuidle is about, isn't it?
> 
> Yes, indeed. Actually, I had tried the coupled cpuidle on Tegra20. I
> knew it a lot. But I met issues when porting it. It looks like a race
> condition and becomes a dead lock caused by IPI missing. Anyway, we can
> talk about it more detail when I try to upstream the coupled cpuidle
> support for Tegra later.

Hmm. That sounds a little churny. Why can't we just use coupled cpuidle
right from the start if the plan is to use it eventually anyway? From
other comments, it sounds like you even already have the code basically
working, but just need to iron out a bug or two?
