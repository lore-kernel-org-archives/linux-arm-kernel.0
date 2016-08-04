From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 4 Aug 2016 12:08:33 +0100
Subject: [PATCH 1/8] ARM: assembler: introduce adr_l, ldr_l and str_l
 macros
In-Reply-To: <CAKv+Gu8_5-VcBxnjLrJxgKcJfVFb785qvVzbB6kryqhhkCfQbA@mail.gmail.com>
References: <1470238730-30038-1-git-send-email-ard.biesheuvel@linaro.org>
 <1470238730-30038-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160803180934.GK1041@n2100.armlinux.org.uk>
 <CAKv+Gu9Wyiu38J=K00WKXSeFoDF2vS-3TJAvbz9Yo616GBXSwQ@mail.gmail.com>
 <20160804093851.GD7147@e103592.cambridge.arm.com>
 <CAKv+Gu8_5-VcBxnjLrJxgKcJfVFb785qvVzbB6kryqhhkCfQbA@mail.gmail.com>
Message-ID: <20160804110832.GF7147@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2016 at 12:12:07PM +0200, Ard Biesheuvel wrote:
> On 4 August 2016 at 11:38, Dave Martin <Dave.Martin@arm.com> wrote:
> > On Thu, Aug 04, 2016 at 09:40:50AM +0200, Ard Biesheuvel wrote:
> >> On 3 August 2016 at 20:09, Russell King - ARM Linux
> >> <linux@armlinux.org.uk> wrote:
> >> > On Wed, Aug 03, 2016 at 05:38:43PM +0200, Ard Biesheuvel wrote:
> >> >> +     add     \dst, pc, #:pc_g0_nc:(\sym) - 8
> >> >> +     add     \dst, \dst, #:pc_g1_nc:(\sym) - 4
> >> >> +     add     \dst, \dst, #:pc_g2:(\sym)
> >> >
> >> > What's this :pc_g0_nc: stuff?  What binutils versions is it supported
> >> > in?  It doesn't appear documented in gas 2.23.91, so I don't think we
> >> > can use it.
> >> >
> >>
> >> binutils 2.18 and up
> >
> > I think this was contemporary with GCC 4.<some middling version>, which
> > may be newer than the minimimum compiler we require for the kernel,
> > particular for earlier arch versions.
> >
> > Using .reloc probably allows the same thing to be done in a more
> > backwards-compatible way.
> >
> 
> I don't see how LD would know how to handle these relocations if we do
> manage to emit them from GAS in this way.

0:	add	\dst, pc, #-8
1:	add	\dst, \dst, #-4
2:	add	\dst, \dst, #0

.reloc	0b, R_ARM_ALU_PC_G0_NC, \sym
.reloc	1b, R_ARM_ALU_PC_G1_NC, \sym
.reloc	2b, R_ARM_ALU_PC_G2, \sym

or, for ldr_l:

0:	add	\dst, pc, #-8
1:	add	\dst, \dst, #-4
2:	ldr	[\dst, #0]

.reloc	0b, R_ARM_ALU_PC_G0_NC, \sym
.reloc	1b, R_ARM_ALU_PC_G1_NC, \sym
.reloc	2b, R_ARM_LDR_PC_G2, \sym

... should produce precisely the same result at the .o stage.


This #:reloc: stuff is mostly a shorthand/convenience feature as I
understand it -- however, you do have to know how to force the correct
instruction encoding to be emitted to match the reloc type -- with
#:reloc:, the assembler should take care of that.

The reloc/insn match issue also means that the Thumb2 relocs are
totally different (R_ARM_THM_<blah>).  


For OABI, it would no doubt be different again.  I know nothing about
OABI relocs.

And we're still limited to <32-bit offset ranges.

Cheers
---Dave
