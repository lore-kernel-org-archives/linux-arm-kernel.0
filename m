From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 7 Aug 2013 21:24:57 -0400 (EDT)
Subject: Fwd: [PATCH 05/10] ARM: LPAE: Correct virt_to_phys patching for
 64 bit physical addresses
In-Reply-To: <52026637.5040005@ti.com>
References: <1375887551-8442-1-git-send-email-r.sricharan@ti.com>
 <52026637.5040005@ti.com>
Message-ID: <alpine.LFD.2.03.1308072118220.14472@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 7 Aug 2013, Sricharan R wrote:

> Hi Nicolas,
> 
> On Monday 05 August 2013 08:08 PM, Santosh Shilimkar wrote:
> > On Sunday 04 August 2013 01:32 AM, Nicolas Pitre wrote:
> >> On Sat, 3 Aug 2013, Santosh Shilimkar wrote:
> >>
> >>> On Saturday 03 August 2013 10:01 AM, Nicolas Pitre wrote:
> >>>> On Sat, 3 Aug 2013, Sricharan R wrote:
> >>>>
> >>>>> On Saturday 03 August 2013 08:58 AM, Nicolas Pitre wrote:
> >>>>>> ... meaning that, instead of using 0x81 for the stub value on the mov 
> >>>>>> instruction, it only has to be 0x83.  Bits 7 and 0 still act as anchors 
> >>>>>> for the rotation field in the opcode, while bit 1 indicates which value 
> >>>>>> to patch in.
> >>>>>   I started with this kind of augmenting with the immediate operand
> >>>>>   while starting V2. But the problem was, we do the runtime patching twice.
> >>>> Ahhh... Bummer.
> >>>>
> >>> Sorry if it wasn't clear but I thought we discussed why patching is
> >>> done twice.
> >> Yeah, I know the reasons.  I just had forgotten about the effects on the 
> >> anchor bits.
> >>
> > I see.
> >  
> >>> This was purely based on the discussion where RMK suggested to follow 
> >>> that approach to minimize code changes.
> >>>  
> >>> Looks like we need to revisit that now based on Russell's latest
> >>> comment.
> >> Note that my comments on this particular patch are still valid and 
> >> independent from whatever approach is used globally to deal with the 
> >> memory alias.  I do think that the value to patch should be selected 
> >> depending on the opcode's rotation field which makes it compatible with 
> >> a double patching approach as well.
> >>
> > Completely agree.
> >
> > Regards,
> > Santosh
> >
>    So i did the below inlined patch to addresses your comments,
>    as it was valid for both single/double patching approaches.
> 
> [PATCH 05/10] ARM: LPAE: Correct virt_to_phys patching for 64 bit physical addresses
> 
> The current phys_to_virt patching mechanism works only for 32 bit
> physical addresses and this patch extends the idea for 64bit physical
> addresses.
> 
> The 64bit v2p patching mechanism patches the higher 8 bits of physical
> address with a constant using 'mov' instruction and lower 32bits are patched
> using 'add'. While this is correct, in those platforms where the lowmem addressable
> physical memory spawns across 4GB boundary, a carry bit can be produced as a
> result of addition of lower 32bits. This has to be taken in to account and added
> in to the upper. The patched __pv_offset and va are added in lower 32bits, where
> __pv_offset can be in two's complement form when PA_START < VA_START and that can
> result in a false carry bit.
> 
> e.g
>     1) PA = 0x80000000; VA = 0xC0000000
>        __pv_offset = PA - VA = 0xC0000000 (2's complement)
> 
>     2) PA = 0x2 80000000; VA = 0xC000000
>        __pv_offset = PA - VA = 0x1 C0000000
> 
> So adding __pv_offset + VA should never result in a true overflow for (1).
> So in order to differentiate between a true carry, a __pv_offset is extended
> to 64bit and the upper 32bits will have 0xffffffff if __pv_offset is
> 2's complement. So 'mvn #0' is inserted instead of 'mov' while patching
> for the same reason. Since mov, add, sub instruction are to patched
> with different constants inside the same stub, the rotation field
> of the opcode is using to differentiate between them.
> 
> So the above examples for v2p translation becomes for VA=0xC0000000,
>     1) PA[63:32] = 0xffffffff
>        PA[31:0] = VA + 0xC0000000 --> results in a carry
>        PA[63:32] = PA[63:32] + carry
> 
>        PA[63:0] = 0x0 80000000
> 
>     2) PA[63:32] = 0x1
>        PA[31:0] = VA + 0xC0000000 --> results in a carry
>        PA[63:32] = PA[63:32] + carry
> 
>        PA[63:0] = 0x2 80000000
> 
> The above ideas were suggested by Nicolas Pitre <nico@linaro.org> as
> part of the review of first and second versions of the subject patch.

Still can be improved.

[...]

>  1:	ldr	ip, [r7, r3]
> -	bic	ip, ip, #0x000000ff
> -	orr	ip, ip, r6	@ mask in offset bits 31-24
> -	str	ip, [r7, r3]
> -2:	cmp	r4, r5
> +	bic	ip, ip, #0xff
> +	tst	ip, #0xf00	@ check the rotation field
> +	orrne	ip, ip, r6	@ mask in offset bits 31-24
> +	bne	2f
> +	bic	ip, ip, #0x400000	@ clear bit 22

Why?

> +	cmn	r0, #1
> +	orreq	ip, ip, #0x400000	@ set bit 22, mov to mvn instruction
> +	orrne	ip, ip, r0		@ mask in offset bits 7-0
> +2:	str	ip, [r7, r3]
> +3:	cmp	r4, r5

Instead of that "bne 2f", you should instead test r0 against 0xffffffff 
outside this loop and add bit 22 to r0 only once.  No need to pre-clear 
it from ip either.


Nicolas
