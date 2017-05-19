From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 May 2017 18:08:12 +0100
Subject: [PATCH] arm: boot/compressed: fix decompressor header layout for
 v7-M
In-Reply-To: <CAKv+Gu-yAT+kZ_oMT_+n6_RSOKOoqkZtGYjBKq=Wwhj31BgUgQ@mail.gmail.com>
References: <20170519145959.26569-1-ard.biesheuvel@linaro.org>
 <20170519164603.GH3559@e103592.cambridge.arm.com>
 <CAKv+Gu-yAT+kZ_oMT_+n6_RSOKOoqkZtGYjBKq=Wwhj31BgUgQ@mail.gmail.com>
Message-ID: <20170519170812.GV22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 05:59:47PM +0100, Ard Biesheuvel wrote:
> On 19 May 2017 at 17:46, Dave Martin <Dave.Martin@arm.com> wrote:
> > On Fri, May 19, 2017 at 03:59:59PM +0100, Ard Biesheuvel wrote:
> >> As reported by Patrice, the header layout of the decompressor is
> >> incorrect when building for v7-M. In this case, the __nop macro
> >> resolves to 'mov r0, r0', which is emitted as a narrow encoding,
> >> resulting in the header data fields to end up at lower offsets than
> >> required.
> >>
> >> Given the variety of targets we need to support with the same code,
> >> the startup sequence is a bit of a jumble, and uses instructions
> >> and macros whose encoding width cannot be specified (badr), or only
> >> exists in a narrow encoding (bx)
> >>
> >> So force the use of a wide encoding in __nop, and replace the start
> >> sequence with a simple jump to the label marking the start of code,
> >> preceded by a Thumb2 mode switch if required (using explicit wide
> >> encodings where appropriate). The label itself can be moved to the
> >> start of code [where it belongs] due to the larger range of branch
> >> instructions as compared to adr instructions.
> >>
> >> Reported-by: Patrice CHOTARD <patrice.chotard@st.com>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >>  arch/arm/boot/compressed/efi-header.S |  4 +---
> >>  arch/arm/boot/compressed/head.S       | 14 +++++++-------
> >>  2 files changed, 8 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/arch/arm/boot/compressed/efi-header.S b/arch/arm/boot/compressed/efi-header.S
> >> index 9d5dc4fda3c1..3f7d1b74c5e0 100644
> >> --- a/arch/arm/boot/compressed/efi-header.S
> >> +++ b/arch/arm/boot/compressed/efi-header.S
> >> @@ -17,14 +17,12 @@
> >>               @ there.
> >>               .inst   'M' | ('Z' << 8) | (0x1310 << 16)   @ tstne r0, #0x4d000
> >>  #else
> >> -             mov     r0, r0
> >> +             W(mov)  r0, r0
> >>  #endif
> >>               .endm
> >>
> >>               .macro  __EFI_HEADER
> >>  #ifdef CONFIG_EFI_STUB
> >> -             b       __efi_start
> >> -
> >>               .set    start_offset, __efi_start - start
> >>               .org    start + 0x3c
> >>               @
> >> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> >> index 7c711ba61417..8c336a6da210 100644
> >> --- a/arch/arm/boot/compressed/head.S
> >> +++ b/arch/arm/boot/compressed/head.S
> >> @@ -130,19 +130,19 @@ start:
> >>               .rept   7
> >>               __nop
> >>               .endr
> >> -   ARM(              mov     r0, r0          )
> >> -   ARM(              b       1f              )
> >> - THUMB(              badr    r12, 1f         )
> >> - THUMB(              bx      r12             )
> >> +      ARM(   b       1f              )
> >> + AR_CLASS(   sub     pc, pc, #3      )       @ A/R: switch to Thumb2 mode
> >> +  M_CLASS(   nop.w                   )       @ M: already in Thumb2 mode
> >> +    THUMB(   .thumb                  )
> >> +    THUMB(   b.w     1f              )
> >
> > It's not so easy to see that this always assembles to two words, or that
> > the "sub pc, pc, #3" is assembled but not executed in an ARM kernel.
> >
> > Spelling it out might be more readable:
> >
> >    ARM(                 mov     r0, r0          )
> >    ARM(                 mov     r0, r0          )
> >
> >  THUMB( AR_CLASS(       sub     pc, pc, #3      ))
> >  THUMB( M_CLASS(        nop.w                   ))
> >  THUMB(                 .thumb                  )
> >  THUMB(                 b.w     1f              )
> >
> > But I guess it works either way.
> >
> 
> Indeed. Apart from the error in the second line, this sequence should
> be equivalent, but the nested macro invocations don't make it clearer
> imo.

If we're getting to this level of complexity, then maybe going back to
ifdefs will help rather than nesting the magic macros:

#ifndef CONFIG_THUMB2_KERNEL
		mov	r0, r0
		b	1f
#else
 AR_CLASS(	sub.w	pc, pc, #3	)
  M_CLASS(	nop.w			)
		.thumb
		b.w	1f
#endif

This looks pretty clear to me.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
