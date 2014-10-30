From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 30 Oct 2014 18:45:39 +0000
Subject: [PATCHv4 4/7] arm64: Move some head.text functions to executable
 section
In-Reply-To: <54526FFD.1070701@codeaurora.org>
References: <1414440752-9411-1-git-send-email-lauraa@codeaurora.org>
 <1414440752-9411-5-git-send-email-lauraa@codeaurora.org>
 <CAKv+Gu_KMeHQ8oxqxcD5jyr12gW2zTzyVJ4LHpgP4OOpLM3m6w@mail.gmail.com>
 <20141028111025.GC9796@leverpostej>
 <54526FFD.1070701@codeaurora.org>
Message-ID: <20141030184539.GE31629@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 05:06:05PM +0000, Laura Abbott wrote:
> On 10/28/2014 4:10 AM, Mark Rutland wrote:
> > On Tue, Oct 28, 2014 at 08:35:37AM +0000, Ard Biesheuvel wrote:
> >> On 27 October 2014 21:12, Laura Abbott <lauraa@codeaurora.org> wrote:
> >>> The head.text section is intended to be run at early bootup
> >>> before any of the regular kernel mappings have been setup.
> >>> Parts of head.text may be freed back into the buddy allocator
> >>> due to TEXT_OFFSET so for security requirements this memory
> >>> must not be executable. The suspend/resume/hotplug code path
> >>> requires some of these head.S functions to run however which
> >>> means they need to be executable. Support these conflicting
> >>> requirements by moving the few head.text functions that need
> >>> to be executable to the text section which has the appropriate
> >>> page table permissions.
> >>>
> >>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> >>> ---
> >>> v4: New apprach based on discussions with Mark
> >>> ---
> >>>   arch/arm64/kernel/head.S | 4 ++++
> >>>   1 file changed, 4 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> >>> index 10f5cc0..dc362da 100644
> >>> --- a/arch/arm64/kernel/head.S
> >>> +++ b/arch/arm64/kernel/head.S
> >>> @@ -432,12 +432,14 @@ ENTRY(secondary_startup)
> >>>          b       __enable_mmu
> >>>   ENDPROC(secondary_startup)
> >>>
> >>> +       .pushsection    .text, "ax"
> >>>   ENTRY(__secondary_switched)
> >>>          ldr     x0, [x21]                       // get secondary_data.stack
> >>>          mov     sp, x0
> >>>          mov     x29, #0
> >>>          b       secondary_start_kernel
> >>>   ENDPROC(__secondary_switched)
> >>> +       .popsection
> >>>   #endif /* CONFIG_SMP */
> >>>
> >>>   /*
> >>> @@ -471,11 +473,13 @@ ENDPROC(__enable_mmu)
> >>>    * table to map the entire function.
> >>>    */
> >>>          .align  4
> >>> +       .pushsection    .text, "ax"
> >>
> >> There is a comment before this .align that explains why it is
> >> separated from __enable_mmu, and I think jumping into another section
> >> right after it kind of defeats the purpose.
> >> Perhaps it is better to put the pushsection before __enable_mmu instead?
> >
> > To keep the alignment correct we just need to move the .align after the
> > pushsection. With that changed I think this patch is Ok.
> >
> > As __enable_mmu is only executed with the MMU off it doesn't need to be
> > moved into an executable section to prevent the MMU from blowing up in
> > our faces -- it would be wrong to call it with the MMU on anyway.
> >
> > However, this does raise a potential problem in that an attacker could
> > scribble over code executed before the MMU is on. Then they just have to
> > wait for the next CPU hotplug or suspend/resume for it to be executed.
> > So some functions including __enable_mmu and el2_setup aren't
> > necessarily safe in their current location.
> >
> > There are a few ways of solving that, either moving stuff around or
> > releasing less memory for allocation.
> >
> 
> My original version of the patch did move everything around to keep
> __enable_mmu and others into the text section so they couldn't
> be modified. It seemed rather unwieldy though so I went with this
> approach. Releasing less memory for allocation is less than optimal
> so I'd prefer if we moved code around to the appropriate section.
> Any opinions about going back to my original approach of moving things
> around vs. going with more pushsection annotations?

I guess moving things around is the way to go. That will create a clear
distinction between one-time boot code and the portions which get used
repeatedly (and perhaps we can release the memory used by the former).

Looking back at v3, I think we don't need to duplicate any functions
(e.g. enable_mmu) if we replace adr uses with adrp and a :lo12:
immediate, and I think we can place the reused portions straight in
.text rather than adding .latehead.text. That should make the diffstat a
little nicer.

Thanks,
Mark.
