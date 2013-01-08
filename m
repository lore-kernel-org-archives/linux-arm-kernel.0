From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 08 Jan 2013 12:32:32 -0700
Subject: [v2 3/9] ARM: tegra: # of CPU cores detection w/ & w/o
 HAVE_ARM_SCU
In-Reply-To: <20130108162056.GA28618@e106331-lin.cambridge.arm.com>
References: <1357649263-1098-1-git-send-email-hdoyu@nvidia.com>
 <1357649263-1098-4-git-send-email-hdoyu@nvidia.com>
 <20130108142828.GD2718@e106331-lin.cambridge.arm.com>
 <20130108.165342.1996373920678167735.hdoyu@nvidia.com>
 <20130108162056.GA28618@e106331-lin.cambridge.arm.com>
Message-ID: <50EC7450.4070806@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/2013 09:21 AM, Mark Rutland wrote:
> On Tue, Jan 08, 2013 at 02:53:42PM +0000, Hiroshi Doyu wrote:
>> Mark Rutland <mark.rutland@arm.com> wrote @ Tue, 8 Jan 2013 15:28:28 +0100:
>>> On Tue, Jan 08, 2013 at 12:47:37PM +0000, Hiroshi Doyu wrote:
>>>> The method to detect the number of CPU cores on Cortex-A9 MPCore and
>>>> Cortex-A15 MPCore is different. On Cortex-A9 MPCore we can get this
>>>> information from the Snoop Control Unit(SCU). On Cortex-A15 MPCore we
>>>> have to read it from the system coprocessor(CP15), because the SCU on
>>>> Cortex-A15 MPCore does not have software readable registers. This
>>>> patch selects the correct method at runtime based on the CPU ID.
...
>>>>  static void __init tegra_smp_init_cpus(void)
>>>>  {
>>>> -	unsigned int i, ncores = scu_get_core_count(scu_base);
>>>> +	unsigned int i, cpu_id, ncores;
>>>> +	u32 l2ctlr;
>>>> +	phys_addr_t pa;
>>>> +
>>>> +	cpu_id = read_cpuid(CPUID_ID) & CPU_MASK;
>>>> +	switch (cpu_id) {
>>>> +	case CPU_CORTEX_A15:
>>>> +		asm("mrc p15, 1, %0, c9, c0, 2\n" : "=r" (l2ctlr));
>>>> +		ncores = ((l2ctlr >> 24) & 3) + 1;
>>>> +		break;
>>>
>>> [...]
>>>
>>> As mentioned last time [1], you should get this information from the dt
>>> instead.
>>
>> Most of platsmp.c:.smp_init_cpus() implementations seem just to
>> overwrite # of cores by SCU/MRC detection. Is there any implementation
>> to use the DT's # and skip SCU/MRC detection in .smp_init_cpus()?
> 
> As far as I can see, there's no other platform which just relies on
> arm_dt_init_cpu_maps. Until recently, it didn't exist, so that makes some
> sense. As far as I can see, for the Tegra 114 you only need your smp_init_cpus
> to call set_smp_cross_call(gic_raise_softirq). Everything else you do seems to
> be handled by arm_dt_init_cpus.
> 
> I think the best option would be to have a separate smp_ops for your dt
> platforms where we know cpu nodes are populated (e.g. Tegra 114), where
> smp_init_cpus is different to that for non-dt platforms. That way non dt
> platforms can keep the SCU hack for now, and won't be broken, and the dt
> platforms are far removed from the SCU hack and just use common infrastructure.

Tegra doesn't have any non-DT support now.

If we're going to make Tegra114 read the CPU information from DT, then
I'd rather just switch over all Tegra platforms to requiring CPU nodes
in the DT. We have few enough SoC variants that it should be easy to
switch everything to DT before adding Tegra114 support without causing
any problems.

But that all said, I'm not convinced it's a good idea to force the
information to be present in DT when it's just duplicating stuff that
can be runtime-probed from the HW...
