From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 14 Feb 2011 14:59:47 +0000
Subject: [PATCH 2/2] P2V: Thumb2 support
In-Reply-To: <alpine.LFD.2.00.1102140935300.14920@xanadu.home>
References: <alpine.LFD.2.00.1102121331220.14920@xanadu.home>
	<AANLkTinK9JkCMJ4B1vZVMpCmROJK4NyEcFCL5+tNP0mW@mail.gmail.com>
	<alpine.LFD.2.00.1102140935300.14920@xanadu.home>
Message-ID: <AANLkTinG8gajAA+LU689xxZCRUdKX+LKwyUnN96R-pGR@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 14, 2011 at 2:48 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Mon, 14 Feb 2011, Dave Martin wrote:
>
>> On Sat, Feb 12, 2011 at 6:33 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
>> > ?__fixup_a_pv_table:
>> > +#ifdef CONFIG_THUMB2_KERNEL
>> > +#ifdef CONFIG_ARM_PATCH_PHYS_VIRT_16BIT
>> > + ? ? ? lsls ? ?r0, r6, #24
>> > + ? ? ? lsr ? ? r6, #8
>> > + ? ? ? beq ? ? 1f
>> > + ? ? ? clz ? ? r7, r0
>> > + ? ? ? lsrs ? ?r0, #24
>> > + ? ? ? lsls ? ?r0, r7
>> > + ? ? ? bic ? ? r0, 0x0080
>> > + ? ? ? lsrs ? ?r7, #1
>> > + ? ? ? orrcs ? r0, #0x0080
>> > + ? ? ? orr ? ? r0, r0, r7, lsl #12
>> > +#endif
>> > +1: ? ? lsls ? ?r6, #24
>> > + ? ? ? beq ? ? 4f
>> > + ? ? ? clz ? ? r7, r6
>> > + ? ? ? lsrs ? ?r6, #24
>> > + ? ? ? lsls ? ?r6, r7
>> > + ? ? ? bic ? ? r6, #0x0080
>> > + ? ? ? lsrs ? ?r7, #1
>> > + ? ? ? orrcs ? r6, #0x0080
>> > + ? ? ? orr ? ? r6, r6, r7, lsl #12
>> > + ? ? ? orr ? ? r6, #0x4000
>> > + ? ? ? b ? ? ? 4f
>>
>> We do almost the same, complex, operation twice here ... can it be
>> factorised with a macro or something? ?This may also help readability.
>> ?Not essential though.
>
> I'm not sure. ?There is potentially only 7 instructions which are common
> to both cases which would form a logical group. ?Hiding that behind a
> macro doesn't save much here.

I was thinking more of avoiding mis-maintanance by ensuring there's
only one copy of the code to edit.  It wouldn't be a saving as such.
Either way, I agree that it's not that important, since it's not a lot
of code.

>> > +2: ? ? add ? ? r7, r3
>> > +#ifdef CONFIG_ARM_PATCH_PHYS_VIRT_16BIT
>> > + ? ? ? ldrh ? ?ip, [r7]
>> > + ? ? ? tst ? ? ip, 0x0400 ? ? ?@ the i bit tells us LS or MS byte
>>
>> Might be helpful to comment that we rely on TST resetting the C flag?
>
> The tst instruction doesn't touch the C flag. ?It is already cleared by
> the loop condition. ?But yes, a comment to that effect might be good.

You're right ... the comment would have helped me, then :)

>
>> > + ? ? ? beq ? ? 3f
>> > + ? ? ? cmp ? ? r0, #0 ? ? ? ? ?@ set C flag, and ...
>> > + ? ? ? biceq ? ip, 0x0400 ? ? ?@ immediate zero value has a special encoding
>> > + ? ? ? streqh ?ip, [r7] ? ? ? ?@ that requires the i bit cleared
>> > +#endif
>> > +3: ? ? ldrh ? ?ip, [r7, #2]
>> > + ? ? ? and ? ? ip, 0x8f00
>> > + ? ? ? orrcc ? ip, r6 ?@ mask in offset bits 31-24
>> > + ? ? ? orrcs ? ip, r0 ?@ mask in offset bits 23-16
>> > + ? ? ? strh ? ?ip, [r7, #2]
>> > +4: ? ? cmp ? ? r4, r5
>> > + ? ? ? ?ldrcc ? r7, [r4], #4 ? @ use branch for delay slot
>> > + ? ? ? ?bcc ? ?2b
>> > + ? ? ? ?bx ? ? lr
>> > +#else
>> > ?#ifdef CONFIG_ARM_PATCH_PHYS_VIRT_16BIT
>> > ? ? ? ?and ? ? r0, r6, #255 ? ?@ offset bits 23-16
>> > ? ? ? ?mov ? ? r6, r6, lsr #8 ?@ offset bits 31-24
>> > @@ -513,6 +558,7 @@ __fixup_a_pv_table:
>> > ? ? ? ?ldrcc ? r7, [r4], #4 ? ?@ use branch for delay slot
>> > ? ? ? ?bcc ? ? 2b
>> > ? ? ? ?mov ? ? pc, lr
>> > +#endif
>> > ?ENDPROC(__fixup_a_pv_table)
>> >
>> > ?ENTRY(fixup_pv_table)
>> > --
>> > 1.7.4
>> >
>>
>> Not sure I entirely all the implications of this code, and I haven't
>> tested it yet, but it looks sound if I've understood it correctly.
>>
>> Reviewed-by: Dave Martin <dave.martin@linaro.org>
>
> Thanks. ?I'll also remove the s flag to those insns that don't need it
> for clarity.

OK, sounds fine.
---Dave
