From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Jan 2018 17:09:13 +0000
Subject: [PATCH 2/4] efi/arm64: map the stack and entry wrapper into the
 UEFI page tables
In-Reply-To: <CAKv+Gu8CvZXZvxp75x5JL0dNMvEau5XuXxAObsJURs6ALU+nFg@mail.gmail.com>
References: <20180125103131.19168-1-ard.biesheuvel@linaro.org>
 <20180125103131.19168-3-ard.biesheuvel@linaro.org>
 <20180126165744.GD16008@arm.com>
 <CAKv+Gu8CvZXZvxp75x5JL0dNMvEau5XuXxAObsJURs6ALU+nFg@mail.gmail.com>
Message-ID: <20180126170912.GF16008@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 26, 2018 at 05:03:29PM +0000, Ard Biesheuvel wrote:
> On 26 January 2018 at 16:57, Will Deacon <will.deacon@arm.com> wrote:
> > On Thu, Jan 25, 2018 at 10:31:29AM +0000, Ard Biesheuvel wrote:
> >> As a preparatory step towards unmapping the kernel entirely while
> >> executing UEFI runtime services, move the stack and the entry
> >> wrapper routine mappings into the EFI page tables. Also, create a
> >> vector table that overrides the main one while executing in the
> >> firmware so we will be able to remap/unmap the kernel while taking
> >> interrupts.
> >
> > [...]
> >
> >> +     .macro  ventry
> >> +     .align  7
> >> +.Lv\@ :      stp     x29, x30, [sp, #-16]!           // preserve x29 and x30
> >> +     mrs     x29, elr_el1                    // preserve ELR
> >> +     adr     x30, .Lret                      // take return address
> >> +     msr     elr_el1, x30                    // set ELR to return address
> >
> > Oh man, are you really doing two ERETs for a single exception, or am I
> > missing something?
> >
> 
> Yes. I told you it was poetry.

We should organise a recital.

> >> +     ldr     x30, 2b                         // take address of 'vectors'
> >> +     msr     vbar_el1, x30                   // set VBAR to 'vectors'
> >> +     isb
> >> +     add     x30, x30, #.Lv\@ - __efi_rt_vectors
> >> +     br      x30
> >> +     .endm
> >> +
> >> +.Lret:       msr     elr_el1, x29
> >
> > If you take an IRQ here, aren't you toast?
> >
> 
> Yep. So we need to switch this with setting the VBAR below then.

Hmm, but the ELR will still be clobbered by an IRQ, so I don't see how you
can make this safe unless you hack SPSR before entering the kernel vectors
on the entry side.

> >> +__efi_rt_vectors:
> >> +     .rept   8
> >> +     ventry
> >> +     .endr
> >
> > Have you thought about SDEI at all? I can't see any code here to handle
> > that.
> >
> 
> Nope

Add JamesM to cc ;)

> >> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> >> index b34e717d7597..3bab6c60a12b 100644
> >> --- a/arch/arm64/kernel/entry.S
> >> +++ b/arch/arm64/kernel/entry.S
> >> @@ -204,6 +204,7 @@ alternative_if ARM64_HAS_PAN
> >>  alternative_else_nop_endif
> >>
> >>       .if     \el != 0
> >> +     tbz     x21, #63, 1f                    // skip if TTBR0 covers the stack
> >
> > So this is really a "detect EFI" check, right? Maybe comment it as such.
> > Also, probably want to check bit 55 just in case tagging ever takes off.
> >
> 
> Right. So just bit #55 should be sufficient then, right?

Yes, I think so.

Will
