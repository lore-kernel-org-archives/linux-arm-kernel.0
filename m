From: fu.wei@linaro.org (Fu Wei)
Date: Mon, 21 Nov 2016 17:45:56 +0800
Subject: [PATCH v16 06/15] clocksource/drivers/arm_arch_timer: separate
 out arch_timer_uses_ppi init code to prepare for GTDT.
In-Reply-To: <20161118193054.GK1197@leverpostej>
References: <1479304148-2965-1-git-send-email-fu.wei@linaro.org>
 <1479304148-2965-7-git-send-email-fu.wei@linaro.org>
 <20161118193054.GK1197@leverpostej>
Message-ID: <CADyBb7uaDjkovJYmWC+kt7mKyiy7tEo3_KHXf0cDawHTp5dGPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 19 November 2016 at 03:30, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Nov 16, 2016 at 09:48:59PM +0800, fu.wei at linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> The patch refactor original arch_timer_uses_ppi init code:
>> (1) Extract a subfunction: arch_timer_uses_ppi_init
>> (2) Use the new subfunction in arch_timer_of_init and
>> arch_timer_acpi_init
>
> This isn't a strict refactoring, since this now assigns
> ARCH_TIMER_PHYS_NONSECURE_PPI to arch_timer_uses_ppi, which we didn't do
> previously.
>
> As a general note, please write your commit messages as prose rather
> than a list of bullet points. Please also explain the rationale for the
> change, rather than enumerating the changes. Call out things which are
> important and/or likely to surprise reviewers, for example:
>
> * Can 32-bit ARM still use non-secure interrupts afer this change?
>
> * Does the "arm,cpu-registers-not-fw-configured"  proeprty still work?
>
> That will make it vastly easier to have this code reviewed, and it will
> be far more helpful for anyone looking at this in future.
>
> For example:
>
>   arm_arch_timer: rework PPI determination
>
>   Currently, the arch timer driver uses ARCH_TIMER_PHYS_SECURE_PPI to
>   mean the driver will use the secure PPI *and* potentialy also use the
>   non-secure PPI. This is somewhat confusing.
>
>   For arm64, where it never makes sense to use the secure PPI, this
>   means we must always request the useless secure PPI, adding to the
>   confusion. For ACPI, where we may not even have a valid secure PPI
>   number, this is additionally problematic. We need the driver to be
>   able to use *only* the non-secure PPI.
>
>   The logic to choose which PPI to use is intertwined with other logic
>   in arch_timer_init(). This patch factors the PPI determination out
>   into a new function, and then reworks it so that we can handle having
>   only a non-secure PPI.

Great thanks for your example, will use this,  :-)

maybe add :
For ARM32, it still can use non-secure interrupts after this change, and
the "arm,cpu-registers-not-fw-configured"  property still works.

>
> [...]
>
>> +/*
>> + * If HYP mode is available, we know that the physical timer
>> + * has been configured to be accessible from PL1. Use it, so
>> + * that a guest can use the virtual timer instead.
>> + *
>> + * If no interrupt provided for virtual timer, we'll have to
>> + * stick to the physical timer. It'd better be accessible...
>> + * On ARM64, we we only use ARCH_TIMER_PHYS_NONSECURE_PPI in Linux.
>
> It would be better to say that for arm64 we never use the secure
> interrupt.

For ARM64, we never use the secure interrupt, so it will be set to
ARCH_TIMER_PHYS_NONSECURE_PPI instead.

>
>> + *
>> + * On ARMv8.1 with VH extensions, the kernel runs in HYP. VHE
>> + * accesses to CNTP_*_EL1 registers are silently redirected to
>> + * their CNTHP_*_EL2 counterparts, and use a different PPI
>> + * number.
>> + */
>> +static int __init arch_timer_uses_ppi_init(void)
>
> It would be better to call this something like arch_timer_select_ppi().
> As it stands, the name is difficult to read.

Yes, good idea, will do

>
>> @@ -902,6 +904,10 @@ static int __init arch_timer_of_init(struct device_node *np)
>>           of_property_read_bool(np, "arm,cpu-registers-not-fw-configured"))
>>               arch_timer_uses_ppi = ARCH_TIMER_PHYS_SECURE_PPI;
>>
>> +     ret = arch_timer_uses_ppi_init();
>> +     if (ret)
>> +             return ret;
>
> This is clearly broken if you consider what the statement above is
> doing.

Maybe I misunderstand this, I tried to follow the original logic.

Are you saying: we should use arch_timer_select_ppi() first,
then (maybe) change arch_timer_uses_ppi according to
"arm,cpu-registers-not-fw-configured"?

Please correct me, if I misunderstand this.

>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
