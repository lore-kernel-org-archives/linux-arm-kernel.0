From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 28 Oct 2014 11:10:25 +0000
Subject: [PATCHv4 4/7] arm64: Move some head.text functions to executable
 section
In-Reply-To: <CAKv+Gu_KMeHQ8oxqxcD5jyr12gW2zTzyVJ4LHpgP4OOpLM3m6w@mail.gmail.com>
References: <1414440752-9411-1-git-send-email-lauraa@codeaurora.org>
 <1414440752-9411-5-git-send-email-lauraa@codeaurora.org>
 <CAKv+Gu_KMeHQ8oxqxcD5jyr12gW2zTzyVJ4LHpgP4OOpLM3m6w@mail.gmail.com>
Message-ID: <20141028111025.GC9796@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 08:35:37AM +0000, Ard Biesheuvel wrote:
> On 27 October 2014 21:12, Laura Abbott <lauraa@codeaurora.org> wrote:
> > The head.text section is intended to be run at early bootup
> > before any of the regular kernel mappings have been setup.
> > Parts of head.text may be freed back into the buddy allocator
> > due to TEXT_OFFSET so for security requirements this memory
> > must not be executable. The suspend/resume/hotplug code path
> > requires some of these head.S functions to run however which
> > means they need to be executable. Support these conflicting
> > requirements by moving the few head.text functions that need
> > to be executable to the text section which has the appropriate
> > page table permissions.
> >
> > Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> > ---
> > v4: New apprach based on discussions with Mark
> > ---
> >  arch/arm64/kernel/head.S | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> > index 10f5cc0..dc362da 100644
> > --- a/arch/arm64/kernel/head.S
> > +++ b/arch/arm64/kernel/head.S
> > @@ -432,12 +432,14 @@ ENTRY(secondary_startup)
> >         b       __enable_mmu
> >  ENDPROC(secondary_startup)
> >
> > +       .pushsection    .text, "ax"
> >  ENTRY(__secondary_switched)
> >         ldr     x0, [x21]                       // get secondary_data.stack
> >         mov     sp, x0
> >         mov     x29, #0
> >         b       secondary_start_kernel
> >  ENDPROC(__secondary_switched)
> > +       .popsection
> >  #endif /* CONFIG_SMP */
> >
> >  /*
> > @@ -471,11 +473,13 @@ ENDPROC(__enable_mmu)
> >   * table to map the entire function.
> >   */
> >         .align  4
> > +       .pushsection    .text, "ax"
> 
> There is a comment before this .align that explains why it is
> separated from __enable_mmu, and I think jumping into another section
> right after it kind of defeats the purpose.
> Perhaps it is better to put the pushsection before __enable_mmu instead?

To keep the alignment correct we just need to move the .align after the
pushsection. With that changed I think this patch is Ok.

As __enable_mmu is only executed with the MMU off it doesn't need to be
moved into an executable section to prevent the MMU from blowing up in
our faces -- it would be wrong to call it with the MMU on anyway.

However, this does raise a potential problem in that an attacker could
scribble over code executed before the MMU is on. Then they just have to
wait for the next CPU hotplug or suspend/resume for it to be executed.
So some functions including __enable_mmu and el2_setup aren't
necessarily safe in their current location.

There are a few ways of solving that, either moving stuff around or
releasing less memory for allocation.

Mark.

> 
> >  __turn_mmu_on:
> >         msr     sctlr_el1, x0
> >         isb
> >         br      x27
> >  ENDPROC(__turn_mmu_on)
> > +       .popsection
> >
> >  /*
> >   * Calculate the start of physical memory.
> > --
> > Qualcomm Innovation Center, Inc.
> > Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
