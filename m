From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 17 Aug 2016 08:41:23 +0100
Subject: [PATCH] ARM: irq_work: Do not attempt to IPI on non IPI-capable HW
In-Reply-To: <CAL411-pUUdxN_d76FaXYGtEd7Seewnrin=x2mFEbi1Z48zSRvg@mail.gmail.com>
References: <1471361210-29914-1-git-send-email-marc.zyngier@arm.com>
 <CAL411-pUUdxN_d76FaXYGtEd7Seewnrin=x2mFEbi1Z48zSRvg@mail.gmail.com>
Message-ID: <57B41523.6030202@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/08/16 04:15, Peter Chen wrote:
> On Tue, Aug 16, 2016 at 11:26 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> Not all of the ARM HW is IPI capable (i.e. most of the non-SMP
>> systems). Unfortunately, some systems do advertise being SMP
>> capable, even if they have a single core and do not define
>> a cross call method.
> 
> Could you example it? I find all current set_smp_cross_call is defined
> under CONFIG_SMP.

This doesn't mean that the system will be SMP at runtime (SMP_ON_UP).

> Or you will change gic code to define set_smp_cross_call at runtime?

No. Also, the GIC is not a universally adopted interrupt controller, as
plenty of system don't have one.

> 
>> In this case, irq_work_queue dies
>> as arch_irq_work_has_interrupt() fails to detect this
>> particular case.
>>
>> Let's redefine arch_irq_work_has_interrupt() to actually check
>> if we're IPI capable instead of simply being SMP. This sidesteps
>> the issue entierely.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm/include/asm/irq_work.h | 6 +++++-
>>  arch/arm/include/asm/smp_plat.h | 2 ++
>>  arch/arm/kernel/smp.c           | 2 +-
>>  3 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/irq_work.h b/arch/arm/include/asm/irq_work.h
>> index 712d03e..3ba3583 100644
>> --- a/arch/arm/include/asm/irq_work.h
>> +++ b/arch/arm/include/asm/irq_work.h
>> @@ -5,7 +5,11 @@
>>
>>  static inline bool arch_irq_work_has_interrupt(void)
>>  {
>> -       return is_smp();
>> +#ifdef CONFIG_SMP
> 
> Why not using is_smp as condition, it is more strict.
> 
> if (is_smp())
>     return !!__smp_cross_call;
> else
>     return false;

What's the gain? We're trying to check whether we can actually deliver
an IPI. Why should we gate it by finding out whether we're smp_on_up or not?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
