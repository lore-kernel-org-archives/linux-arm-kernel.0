From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 09 Jan 2013 09:17:15 -0700
Subject: [v2 3/9] ARM: tegra: # of CPU cores detection w/ & w/o
 HAVE_ARM_SCU
In-Reply-To: <20130109113432.GA22147@e102568-lin.cambridge.arm.com>
References: <20130108.165342.1996373920678167735.hdoyu@nvidia.com>
 <20130108162056.GA28618@e106331-lin.cambridge.arm.com>
 <50EC7450.4070806@wwwdotorg.org>
 <20130109.074946.1167125688535781408.hdoyu@nvidia.com>
 <20130109113432.GA22147@e102568-lin.cambridge.arm.com>
Message-ID: <50ED980B.9060909@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/2013 04:34 AM, Lorenzo Pieralisi wrote:
> On Wed, Jan 09, 2013 at 05:49:46AM +0000, Hiroshi Doyu wrote:
>> Hi,
>>
>> Stephen Warren <swarren@wwwdotorg.org> wrote @ Tue, 8 Jan 2013 20:32:32 +0100:
>>
>>> On 01/08/2013 09:21 AM, Mark Rutland wrote:
>>>> On Tue, Jan 08, 2013 at 02:53:42PM +0000, Hiroshi Doyu wrote:
>>>>> Mark Rutland <mark.rutland@arm.com> wrote @ Tue, 8 Jan 2013 15:28:28 +0100:
>>>>>> On Tue, Jan 08, 2013 at 12:47:37PM +0000, Hiroshi Doyu wrote:
>>>>>>> The method to detect the number of CPU cores on Cortex-A9 MPCore and
>>>>>>> Cortex-A15 MPCore is different. On Cortex-A9 MPCore we can get this
>>>>>>> information from the Snoop Control Unit(SCU). On Cortex-A15 MPCore we
>>>>>>> have to read it from the system coprocessor(CP15), because the SCU on
>>>>>>> Cortex-A15 MPCore does not have software readable registers. This
>>>>>>> patch selects the correct method at runtime based on the CPU ID.
>>> ...
>>>>>>>  static void __init tegra_smp_init_cpus(void)
>>>>>>>  {
>>>>>>> -	unsigned int i, ncores = scu_get_core_count(scu_base);
>>>>>>> +	unsigned int i, cpu_id, ncores;
>>>>>>> +	u32 l2ctlr;
>>>>>>> +	phys_addr_t pa;
>>>>>>> +
>>>>>>> +	cpu_id = read_cpuid(CPUID_ID) & CPU_MASK;
>>>>>>> +	switch (cpu_id) {
>>>>>>> +	case CPU_CORTEX_A15:
>>>>>>> +		asm("mrc p15, 1, %0, c9, c0, 2\n" : "=r" (l2ctlr));
>>>>>>> +		ncores = ((l2ctlr >> 24) & 3) + 1;
>>>>>>> +		break;
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>> As mentioned last time [1], you should get this information from the dt
>>>>>> instead.
>>>>>
>>>>> Most of platsmp.c:.smp_init_cpus() implementations seem just to
>>>>> overwrite # of cores by SCU/MRC detection. Is there any implementation
>>>>> to use the DT's # and skip SCU/MRC detection in .smp_init_cpus()?
>>>>
>>>> As far as I can see, there's no other platform which just relies on
>>>> arm_dt_init_cpu_maps. Until recently, it didn't exist, so that makes some
>>>> sense. As far as I can see, for the Tegra 114 you only need your smp_init_cpus
>>>> to call set_smp_cross_call(gic_raise_softirq). Everything else you do seems to
>>>> be handled by arm_dt_init_cpus.
>>
>> True.
>>
>>>> I think the best option would be to have a separate smp_ops for your dt
>>>> platforms where we know cpu nodes are populated (e.g. Tegra 114), where
>>>> smp_init_cpus is different to that for non-dt platforms. That way non dt
>>>> platforms can keep the SCU hack for now, and won't be broken, and the dt
>>>> platforms are far removed from the SCU hack and just use common
>>>> infrastructure.
>>>
>>> Tegra doesn't have any non-DT support now.
>>
>> What about falling down to SCU/MRC hack only when DT detection fails
>> or no /cpus entry in DT?
>>
>> Can arm_dt_init_cpu_maps() return if it suceeds or not?
> 
> I think the best solution to this problem consists in /me adding a
> function, say, arm_dt_nb_cores(), that returns an error if DT probing
> failed and the number of cores if it succeeded.

Well, if the primary mechanism needs to be DT-based going forward, I'd
say just require the DT nodes to be present to use the new function, and
outright fail if they aren't. That way, everything always works one way.
It shouldn't be hard to add the CPU nodes for Tegra, right?
