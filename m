From: fu.wei@linaro.org (Fu Wei)
Date: Fri, 7 Apr 2017 00:47:47 +0800
Subject: [PATCH v23 09/11] acpi/arm64: Add memory-mapped timer support in
 GTDT driver
In-Reply-To: <20170405183808.GB27550@leverpostej>
References: <20170331175105.8370-1-fu.wei@linaro.org>
 <20170331175105.8370-10-fu.wei@linaro.org>
 <20170405183808.GB27550@leverpostej>
Message-ID: <CADyBb7sz6ongbyqR0FzBZybJBYwnLvqV+NsX1+W=6tv0_vLt1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 6 April 2017 at 02:38, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> I tried to fix the issue that Lornzo raised, such that I could queue
> these patches. From looking at this patch in more detail however, I
> think there are further issues that need to be addressed.
>
> On Sat, Apr 01, 2017 at 01:51:03AM +0800, fu.wei at linaro.org wrote:
>> +     /*
>> +      * Get the GT timer Frame data for every GT Block Timer
>> +      */
>> +     for (i = 0; i < block->timer_count; i++, gtdt_frame++) {
>> +             if (gtdt_frame->common_flags & ACPI_GTDT_GT_IS_SECURE_TIMER)
>> +                     continue;
>> +
>> +             if (!gtdt_frame->base_address || !gtdt_frame->timer_interrupt)
>> +                     goto error;
>> +
>> +             frame = &timer_mem->frame[gtdt_frame->frame_number];
>> +             frame->phys_irq = map_gt_gsi(gtdt_frame->timer_interrupt,
>> +                                          gtdt_frame->timer_flags);
>> +             if (frame->phys_irq <= 0) {
>> +                     pr_warn("failed to map physical timer irq in frame %d.\n",
>> +                             gtdt_frame->frame_number);
>> +                     goto error;
>> +             }
>> +
>> +             if (gtdt_frame->virtual_timer_interrupt) {
>> +                     frame->virt_irq =
>> +                             map_gt_gsi(gtdt_frame->virtual_timer_interrupt,
>> +                                        gtdt_frame->virtual_timer_flags);
>> +                     if (frame->virt_irq <= 0) {
>> +                             pr_warn("failed to map virtual timer irq in frame %d.\n",
>> +                                     gtdt_frame->frame_number);
>> +                             acpi_unregister_gsi(gtdt_frame->timer_interrupt);
>> +                             goto error;
>> +                     }
>> +             } else {
>> +                     frame->virt_irq = 0;
>> +                     pr_debug("virtual timer in frame %d not implemented.\n",
>> +                              gtdt_frame->frame_number);
>> +             }
>> +
>> +             frame->cntbase = gtdt_frame->base_address;
>> +             /*
>> +              * The CNTBaseN frame is 4KB (register offsets 0x000 - 0xFFC).
>> +              * See ARM DDI 0487A.k_iss10775, page I1-5130, Table I1-4
>> +              * "CNTBaseN memory map".
>> +              */
>> +             frame->size = SZ_4K;
>> +             frame->valid = true;
>> +     }
>> +
>> +     return 0;
>> +
>> +error:
>> +     for (i = 0; i < ARCH_TIMER_MEM_MAX_FRAMES; i++) {
>> +             frame = &timer_mem->frame[i];
>> +             if (!frame->valid)
>> +                     continue;
>> +             irq_dispose_mapping(frame->phys_irq);
>> +             if (frame->virt_irq)
>> +                     irq_dispose_mapping(frame->virt_irq);
>> +     }
>
> We assign interrupts and may goto error before setting valid, so here we

yes, I mean to do it.(setting valid at the end of loop)

> won't free the interrupts of the last frame we parsed.

that won't  be a problem, we may assign two interrupts in a round:
First of all, if  the assignment goes  wrong, that means the current
interrupt haven't been successfully assigned.
(1)if the first goes wrong, the we goto error to unwind  the irqs
assigned in previous rounds.
(2)if the second one goes wrong , we acpi_unregister_gsi the first one
and then  goto error to unwind  the irqs assigned in previous rounds.
(3)If the two assignments are successful, set up valid flag

So we won't miss freeing the interrupts of the last frame we parsed.

Did I miss something?

Thanks!

>
>> +     return -EINVAL;
>> +}
>> +
>> +/**
>> + * acpi_arch_timer_mem_init() - Get the info of all GT blocks in GTDT table.
>> + * @timer_mem:       The pointer to the array of struct arch_timer_mem for returning
>> + *           the result of parsing. The element number of this array should
>> + *           be platform_timer_count(the total number of platform timers).
>> + * @timer_count: It points to a integer variable which is used for storing the
>> + *           number of GT blocks we have parsed.
>> + *
>> + * Return: 0 if success, -EINVAL/-ENODEV if error.
>> + */
>> +int __init acpi_arch_timer_mem_init(struct arch_timer_mem *timer_mem,
>> +                                 int *timer_count)
>> +{
>> +     int ret;
>> +     void *platform_timer;
>> +
>> +     *timer_count = 0;
>> +     for_each_platform_timer(platform_timer) {
>> +             if (is_timer_block(platform_timer)) {
>> +                     ret = gtdt_parse_timer_block(platform_timer, timer_mem);
>> +                     if (ret)
>> +                             return ret;
>> +                     timer_mem++;
>> +                     (*timer_count)++;
>> +             }
>> +     }
>
> If we were to have multiple GT blocks, this would leave timer_mem in an
> inconsistent state. In gtdt_parse_timer_block we'll blat any existing
> timer_mem->cntctlbase, and blat some arbitrary set of frames. however,
> *some* frames may have been held over from a previous iteration.
>
> My understanding was that the system level timer had a single CNTCTLBase
> frame, and hence we should only have a single GT block.
>
> Judging by ARM DDI 0487A.k_iss10775, I1.3 "Memory-mapped timer
> components" and I3.4 "Generic Timer memory-mapped registers overview",
> it does appear that the system should only have one CNTCTLBase frame.
>
> What's going on here?
>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
