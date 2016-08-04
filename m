From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 4 Aug 2016 14:31:34 +0100
Subject: [PATCH 1/8] ARM: assembler: introduce adr_l, ldr_l and str_l
 macros
In-Reply-To: <CAKv+Gu_r4Rx=pvZWNaE1f-_QDiwyn62uS+MzPyNUqndE5jCS2Q@mail.gmail.com>
References: <1470238730-30038-1-git-send-email-ard.biesheuvel@linaro.org>
 <1470238730-30038-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160803180934.GK1041@n2100.armlinux.org.uk>
 <CAKv+Gu9Wyiu38J=K00WKXSeFoDF2vS-3TJAvbz9Yo616GBXSwQ@mail.gmail.com>
 <20160804093851.GD7147@e103592.cambridge.arm.com>
 <CAKv+Gu8_5-VcBxnjLrJxgKcJfVFb785qvVzbB6kryqhhkCfQbA@mail.gmail.com>
 <20160804110832.GF7147@e103592.cambridge.arm.com>
 <CAKv+Gu_JVX3erz6N64EGfu38TDi6PHsQVGY=nkfu7kF-8Hq=6Q@mail.gmail.com>
 <20160804113018.GH7147@e103592.cambridge.arm.com>
 <CAKv+Gu_r4Rx=pvZWNaE1f-_QDiwyn62uS+MzPyNUqndE5jCS2Q@mail.gmail.com>
Message-ID: <20160804133134.GJ7147@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2016 at 01:34:03PM +0200, Ard Biesheuvel wrote:
> On 4 August 2016 at 13:30, Dave Martin <Dave.Martin@arm.com> wrote:
> > On Thu, Aug 04, 2016 at 01:10:55PM +0200, Ard Biesheuvel wrote:
> >> On 4 August 2016 at 13:08, Dave Martin <Dave.Martin@arm.com> wrote:
> >
> > [...]
> >
> >> > or, for ldr_l:
> >> >
> >> > 0:      add     \dst, pc, #-8
> >> > 1:      add     \dst, \dst, #-4
> >> > 2:      ldr     [\dst, #0]
> >> >
> >> > .reloc  0b, R_ARM_ALU_PC_G0_NC, \sym
> >> > .reloc  1b, R_ARM_ALU_PC_G1_NC, \sym
> >> > .reloc  2b, R_ARM_LDR_PC_G2, \sym
> >> >
> >> > ... should produce precisely the same result at the .o stage.
> >> >
> >>
> >> Yes, but how is LD going to perform the arithmetic involved in

[...]

> >> handling these relocations? That's is the more interesting part, and
> >> that is not implemented either in binutils < 2.18
> >
> > What arithmetic?
> >
> 
> The arithmetic involved in populating the immediate fields of these
> instructions based on the actual offset between the Place and the
> Symbol in the final image.

<digression>

Just for interest...


For the linker this is just ordinary relocation processing -- there's
nothing unusual going on, except that neither GCC nor gas usually
emit these particular insn relocs automatically.

I think the ARM RVCT compiler could generate them for producing
ROM-able position independent code in some confgurations.  I suspect
they were supported by ld from the start though, or at least pretty
early on.


When you write

	add	\dst, pc, #:pc_g0_nc:\sym - (. + 8)

the arithmetic is somewhat bogus -- the assembler does not (and can't)
do it, because neither the value of \sym, nor of ., is known.  Only the
invariant bit (the - 8) can be processed at assembly time.  The
irreducible part (\sym - .) has to be emitted as a reloc.

Thus, the assembler really does emit 

.reloc  ., R_ARM_ALU_PC_G0_NC, \sym
	add     \dst, pc, #-8

(The "- ." is effectively part of the definition of R_ARM_ALU_PC_G0_NC
here).


For comparison:

$ as <<EOF -o a.o
	.reloc ., R_ARM_ALU_PC_G0_NC, foo
	add	r0, pc, #-8
	.reloc ., R_ARM_ALU_PC_G1_NC, foo
	add	r0, r0, #-4
	.reloc ., R_ARM_ALU_PC_G2, foo
	add	r0, r0, #0

	add	r0, pc, #:pc_g0_nc:foo - . - 8
	add	r0, r0, #:pc_g1_nc:foo - . - 4
	add	r0, r0, #:pc_g2:foo - .
EOF

$ objdump -dr a.o
00000000 <.text>:
   0:	e24f0008 	sub	r0, pc, #8
			0: R_ARM_ALU_PC_G0_NC	foo
   4:	e2400004 	sub	r0, r0, #4
			4: R_ARM_ALU_PC_G1_NC	foo
   8:	e2800000 	add	r0, r0, #0
			8: R_ARM_ALU_PC_G2	foo
   c:	e24f0008 	sub	r0, pc, #8
			c: R_ARM_ALU_PC_G0_NC	foo
  10:	e2400004 	sub	r0, r0, #4
			10: R_ARM_ALU_PC_G1_NC	foo
  14:	e2800000 	add	r0, r0, #0
			14: R_ARM_ALU_PC_G2	foo

$ ld --defsym foo=0x4000000 -o a a.o
$ objdump -dr a
00008054 <__bss_end__-0x8018>:
    8054:       e28f07ff        add     r0, pc, #66846720       ; 0x3fc0000
    8058:       e2800bdf        add     r0, r0, #228352 ; 0x37c00
    805c:       e2800fe9        add     r0, r0, #932    ; 0x3a4
    8060:       e28f07ff        add     r0, pc, #66846720       ; 0x3fc0000
    8064:       e2800bdf        add     r0, r0, #228352 ; 0x37c00
    8068:       e2800fe6        add     r0, r0, #920    ; 0x398


> Yes, .reloc is implemented, but that is not sufficient.

</digression>

Cheers
---Dave
