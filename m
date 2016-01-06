From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 6 Jan 2016 13:26:40 +0100
Subject: [PATCH 1/2] arm64: add macro to handle large immediates
In-Reply-To: <20160106122104.GF563@leverpostej>
References: <1452078327-9635-1-git-send-email-mark.rutland@arm.com>
 <CAKv+Gu_Oo1=Wwr9jRQBTn7bs2KVisSkwkFvJASocCS26taeo-w@mail.gmail.com>
 <20160106122104.GF563@leverpostej>
Message-ID: <CAKv+Gu95+F2HhoirhyfoKSs7oUY_5qBdDGcKfXmZi2sS8mERNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 January 2016 at 13:21, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Jan 06, 2016 at 12:15:14PM +0100, Ard Biesheuvel wrote:
>> On 6 January 2016 at 12:05, Mark Rutland <mark.rutland@arm.com> wrote:
>> > Sometimes we want to be able to load values greater than 0xff into a
>> > register, without placing said values in a literal pool. Arranging for
>> > the value to be split up across a number of movz and movk instructions
>> > is tedious and error-prone.
>> >
>> > Following the example of {adr,str,ldr}_l, this patch adds a new mov_l
>> > macro which can be used to load immediate values of up to 64 bits into a
>> > register.
>> >
>> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> > Cc: Catalin Marinas <catalin.marinas@arm.com>
>> > Cc: Marc Zyngier <marc.zyngier@arm.com>
>> > Cc: Will Deacon <will.deacon@arm.com>
>> > ---
>> >  arch/arm64/include/asm/assembler.h | 13 +++++++++++++
>> >  1 file changed, 13 insertions(+)
>> >
>> > diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
>> > index 12eff92..64fd0a2 100644
>> > --- a/arch/arm64/include/asm/assembler.h
>> > +++ b/arch/arm64/include/asm/assembler.h
>> > @@ -193,6 +193,19 @@ lr .req    x30             // link register
>> >         str     \src, [\tmp, :lo12:\sym]
>> >         .endm
>> >
>> > +       /*
>> > +        * Move a large immediate up to 64-bits.
>> > +        *
>> > +        * @dst: destination register (64 bit wide)
>> > +        * @val: value
>> > +        */
>> > +       .macro  mov_l, dst, val
>> > +       movz    \dst, :abs_g0_nc:\val
>> > +       movk    \dst, :abs_g1_nc:\val
>> > +       movk    \dst, :abs_g2_nc:\val
>> > +       movk    \dst, :abs_g3:\val
>> > +       .endm
>> > +
>>
>> Ack for the general idea, but for correctness, you should pair the
>> movk instructions with the _nc relocations (i.e., keep movz first, but
>> invert the order of the relocs)
>
> Ah, I hadn't spotted the restriction. I'll change that to:
>
>         movz    \dst, :abs_g3:\val
>         movk    \dst, :abs_g2:\val
>         movk    \dst, :abs_g1:\val
>         movk    \dst, :abs_g0:\val
>

Yes, but with the _nc suffix on the latter three.

> That raises a related question. Is it the linker's responsibility to
> fill in the shift encoding in the hw field as part of the g{3,2,1}
> relocs?
>

This

movz x0, :abs_g3:val
movk x0, :abs_g2_nc:val
movk x0, :abs_g1_nc:val
movk x0, :abs_g0_nc:val

assembles to

0000000000000000 <.text>:
   0: d2e00000 movz x0, #0x0, lsl #48
   4: f2c00000 movk x0, #0x0, lsl #32
   8: f2a00000 movk x0, #0x0, lsl #16
   c: f2800000 movk x0, #0x0

so it is in fact the assembler that sets the hw field.

> Mine seems to, but I don't know if that's strictly required or correct
> as the AArrch64 ELF spec only mentions the immediate field for *ABS_G*,
> and the shift is encoded in hw rather than imm16.
>
