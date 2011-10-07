From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 07 Oct 2011 10:44:59 +0100
Subject: [PATCH 5/7] ARM: EXYNOS4: Add support external GIC
In-Reply-To: <4E8D645D.4020601@arm.com>
References: <1308555258-4322-1-git-send-email-chaos.youn@samsung.com>
	<1308555258-4322-6-git-send-email-chaos.youn@samsung.com>
	<4E8C61C4.9090709@arm.com>	<00ec01cc83f1$81f84430$85e8cc90$%kim@samsung.com>
	<4E8D645D.4020601@arm.com>
Message-ID: <4E8ECA1B.5010005@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/11 09:18, Marc Zyngier wrote:
> On 06/10/11 07:30, Kukjin Kim wrote:
>> Marc Zyngier wrote:
>>>
>>> Hi Changhwan,
>>>
>> Hi Marc,
>>
>> (Cc'ed Will Deacon and Russell King)
>>
>>> On 20/06/11 08:34, Changhwan Youn wrote:
>>>> For full support of power modes, this patch adds implementation
>>>> external GIC on EXYNOS4.
>>>>
>>>> External GIC of Exynos4 cannot support register banking so
>>>> several interrupt related code for CPU1 should be different
>>>> from that of CPU0.
>>>
>>> I just realized that patch has made it to mainline... Unfortunately, it
>>> seems quite broken to me:
>>>
>>>> Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
>>>> ---
>>>>  arch/arm/mach-exynos4/cpu.c                      |   10 ++++++++
>>>>  arch/arm/mach-exynos4/include/mach/entry-macro.S |    5 ++++
>>>>  arch/arm/mach-exynos4/include/mach/map.h         |    1 +
>>>>  arch/arm/mach-exynos4/platsmp.c                  |   27
>>> +++++++++++++++++++++-
>>>>  4 files changed, 42 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
>>>> index fa33294..40a866c 100644
>>>> --- a/arch/arm/mach-exynos4/cpu.c
>>>> +++ b/arch/arm/mach-exynos4/cpu.c
>>>> @@ -16,6 +16,7 @@
>>>>
>>>>  #include <asm/proc-fns.h>
>>>>  #include <asm/hardware/cache-l2x0.h>
>>>> +#include <asm/hardware/gic.h>
>>>>
>>>>  #include <plat/cpu.h>
>>>>  #include <plat/clock.h>
>>>> @@ -159,11 +160,20 @@ void __init exynos4_init_clocks(int xtal)
>>>>  	exynos4_setup_clocks();
>>>>  }
>>>>
>>>> +static void exynos4_gic_irq_eoi(struct irq_data *d)
>>>> +{
>>>> +	struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
>>>> +
>>>> +	gic_data->cpu_base = S5P_VA_GIC_CPU +
>>>> +			    (EXYNOS4_GIC_BANK_OFFSET *
>>> smp_processor_id());
>>>
>>> Here, you're overwriting a field that is shared among *all* the
>>> interrupts in the system.  What if an interrupt comes up on another CPU?
>>> If you look at the implementation of gic_eoi_irq(), you'll definitely
>>> see the race.
>>>
>> Hmm...as you can see in git log, the EXYNOS4210 cannot support register
>> banking in GIC so this is needed.
> 
> I don't dispute the need. I claim that the implementation is wrong, and
> will fail given the right timings.
> 
>>>> +}
>>>> +
>>>>  void __init exynos4_init_irq(void)
>>>>  {
>>>>  	int irq;
>>>>
>>>>  	gic_init(0, IRQ_LOCALTIMER, S5P_VA_GIC_DIST, S5P_VA_GIC_CPU);
>>>> +	gic_arch_extn.irq_eoi = exynos4_gic_irq_eoi;
>>>
>>> And here you're abusing the GIC extension feature.
>>>
>> I think gic_arch_extn.irq_eoi can be overwritten in each architecture to
>> support own specific extensions like in the EXYNOS4 case.
> 
> Sure. My point is you are diverting the GIC extension from its purpose,
> which is mostly to be able to control wake-up sources (as for example in
> the Tegra case). Here, you use this hooks to work around the fact that
> the GIC driver is written with banking in mind, which is quite a
> different thing.
> 
>>> I've also had a look at -next, and this has been extended further to
>>> support 4412. The problem with that is without banking, you're painfully
>>> working around the GIC driver. At that stage, I wonder if you wouldn't
>>> be better off with a separate driver instead of abusing the existing
>> one...
>>>
>> Well, in this case, you mean separate driver is better to us even though
>> there is a gic driver in arch/arm/common? I don't think so because separate
>> driver will probably have many duplicated codes and if common gic driver can
>> support every silicons which have different version's gic it's better to us
>> and should do.
> 
> If you really insist on using the GIC common code, then I'd suggest to
> adapt it to your needs instead of working around the problem.
> What about making cpu_base a percpu field inside struct gic_chip_data?
> No hook abuse, and no race conditions. You could also do that for
> dist_base, as it looks to be required for the 4412.

So to make my suggestion completely clear, here's a patch I'm now
carrying in my tree. It's only been test compiled on EXYNOS4, but works
nicely on my 11MP. It turns both dist_base and cpu_base into per-cpu
variables, removes these callbacks, removes your private copy of
gic_cpu_init, and makes struct gic_chip_data private again.

What do you think?

	M.
-- 
Jazz is not dead. It just smells funny...
