From: fu.wei@linaro.org (Fu Wei)
Date: Fri, 7 Apr 2017 02:07:40 +0800
Subject: [PATCH v23 09/11] acpi/arm64: Add memory-mapped timer support in
 GTDT driver
In-Reply-To: <20170406175252.GB11871@leverpostej>
References: <20170331175105.8370-1-fu.wei@linaro.org>
 <20170331175105.8370-10-fu.wei@linaro.org>
 <20170405183808.GB27550@leverpostej>
 <CADyBb7sz6ongbyqR0FzBZybJBYwnLvqV+NsX1+W=6tv0_vLt1g@mail.gmail.com>
 <20170406172410.GA11871@leverpostej>
 <CADyBb7vEHQCpMoXhtBMGf_iou1qxsvVSJfxcYy5W33SNFyCwwA@mail.gmail.com>
 <20170406175252.GB11871@leverpostej>
Message-ID: <CADyBb7suSedttCma7Q6-RGfduJBOD5AWCpOA3pyvjDn6z+uSow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 7 April 2017 at 01:52, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Apr 07, 2017 at 01:39:09AM +0800, Fu Wei wrote:
>> On 7 April 2017 at 01:24, Mark Rutland <mark.rutland@arm.com> wrote:
>> > On Fri, Apr 07, 2017 at 12:47:47AM +0800, Fu Wei wrote:
>> >> On 6 April 2017 at 02:38, Mark Rutland <mark.rutland@arm.com> wrote:
>> >> > On Sat, Apr 01, 2017 at 01:51:03AM +0800, fu.wei at linaro.org wrote:
>
>> > However, I would prefer to simplify this such that we only free the
>> > IRQs in the error path.
>> >
>> > We should be able to iterate over all freams, freeing any non-zero
>> > interrupt, since !valid frames shouldn't have non-zero interrupts.
>>
>> Yes, that is what I am doing :
>>
>>  if (!frame->valid)
>>           continue;
>
> What I meant was that we won't look at the frame->valid flag at all;
> only the interrupts. e.g.
>
> for (int i = 0; i < ARCH_TIMER_MEM_MAX_FRAMES; i++) {
>         if (frame->phys_irq > 0)
>                 free_the_phys_irq_somehow();
>         if (frame->virt_irq > 0)
>                 free_the_virt_irq_somehow();
> }

Since we use "kcalloc" to allocate struct arch_timer_mem, this should be OK.

>
> ... where we somehow figure out the GSI, or we introduce an api like
> unregister_gsi_for_irq(irq).

Yes, If you are OK with introducing a new API , this problem is solved :-)

>
> Since the !valid frames should all have zero for their interrupt fields,
> no special handling is necessary.
>
> That way, we only free the IRQs in one place, it's obvious that we
> consistently free all of them, etc.
>
>> Lorenzo addressed the API issue, we may can fix it by getting GSI info
>> from DT, then register it until we figure the best frame.
>> It may need some big change in DT code
>
> I'd prefer to keep this constrained to the ACPI code. ;)
>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
