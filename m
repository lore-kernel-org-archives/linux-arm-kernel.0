From: fu.wei@linaro.org (Fu Wei)
Date: Mon, 20 Mar 2017 21:38:16 +0800
Subject: [PATCH v21 11/13] acpi/arm64: Add memory-mapped timer support in
 GTDT driver
In-Reply-To: <20170317194055.GE15909@leverpostej>
References: <20170206185015.12296-1-fu.wei@linaro.org>
 <20170206185015.12296-12-fu.wei@linaro.org>
 <20170317194055.GE15909@leverpostej>
Message-ID: <CADyBb7s0Bwn17YMSEwxmhrZ6E1pOJLdifZ-JJL+vqRBRD+H-dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 18 March 2017 at 03:40, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> On Tue, Feb 07, 2017 at 02:50:13AM +0800, fu.wei at linaro.org wrote:
>> +static int __init gtdt_parse_timer_block(struct acpi_gtdt_timer_block *block,
>> +                                      struct arch_timer_mem *data)
>
> Please s/data/timer_mem/ here, to match the rest of the timer code.
>
>> +{
>> +     int i, j;
>> +     struct acpi_gtdt_timer_entry *frame;
>
> So as to make it clear what this is, and to make things a litlte simpler
> below, please s/frame/gtdt_frame/ here.
>
>> +
>> +     if (!block->timer_count) {
>> +             pr_err(FW_BUG "GT block present, but frame count is zero.");
>> +             return -ENODEV;
>> +     }
>> +
>> +     if (block->timer_count > ARCH_TIMER_MEM_MAX_FRAMES) {
>> +             pr_err(FW_BUG "GT block lists %d frames, ACPI spec only allows 8\n",
>> +                    block->timer_count);
>> +             return -EINVAL;
>> +     }
>> +
>> +     data->cntctlbase = (phys_addr_t)block->block_address;
>> +     /*
>> +      * According to "Table * CNTCTLBase memory map" of
>> +      * <ARM Architecture Reference Manual> for ARMv8,
>> +      * The size of the CNTCTLBase frame is 4KB(Offset 0x000 ? 0xFFC).
>> +      */
>
> As a general thing, please cite the version of the ARM ARM you're
> referring to, as over time the internal numbering (and the headings)
> change.
>
> e.g.
>         /*
>          * The CNTCTLBase frame is 4KB (register offsets 0x000 - 0xFFC).
>          * See ARM DDI 0487A.k_iss10775, page I1-5129, Table I1-3
>          * "CNTCTLBase memory map".
>          */
>
>> +     data->size = SZ_4K;
>> +
>> +     frame = (void *)block + block->timer_offset;
>> +     if (frame + block->timer_count != (void *)block + block->header.length)
>> +             return -EINVAL;
>> +
>> +     /*
>> +      * Get the GT timer Frame data for every GT Block Timer
>> +      */
>> +     for (i = 0, j = 0; i < block->timer_count; i++, frame++) {
>
> With the gtdt_frame rename as above, here we can do:
>
>         struct arch_timer_mem_frame *frame = &timer_mem->frame[j];
>
>> +             if (frame->common_flags & ACPI_GTDT_GT_IS_SECURE_TIMER)
>> +                     continue;
>> +
>> +             if (!frame->base_address || !frame->timer_interrupt)
>> +                     return -EINVAL;
>> +
>> +             data->frame[j].phys_irq = map_gt_gsi(frame->timer_interrupt,
>> +                                                  frame->timer_flags);
>
> ... allowing us to simplify lines like this.

Thanks, will follow all the suggestion above.
:-)

>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
