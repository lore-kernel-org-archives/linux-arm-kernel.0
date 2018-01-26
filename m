From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 26 Jan 2018 18:19:08 +0000
Subject: [PATCH] arm64: Fix TTBR + PAN + 52-bit PA logic in
 cpu_do_switch_mm
In-Reply-To: <611f40d5-ee64-ccab-065d-eaf3da03c5ee@arm.com>
References: <20180124082708.29038-1-steve.capper@arm.com>
 <20180124094548.daey56d2d54ij6f2@armageddon.cambridge.arm.com>
 <611f40d5-ee64-ccab-065d-eaf3da03c5ee@arm.com>
Message-ID: <20180126181908.6bhdagfsvgkqyqva@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 25, 2018 at 12:01:49PM +0000, Kristina Martsenko wrote:
> On 24/01/18 09:45, Catalin Marinas wrote:
> > On Wed, Jan 24, 2018 at 08:27:08AM +0000, Steve Capper wrote:
> >> In cpu_do_switch_mm(.) with ARM64_SW_TTBR0_PAN=y we apply phys_to_ttbr
> >> to a value that already has an ASID inserted into the upper bits. For
> >> 52-bit PA configurations this then can give us TTBR0_EL1 registers that
> >> cause translation table walks to attempt to access non-zero PA[51:48]
> >> spuriously. Ultimately leading to a Synchronous External Abort on level
> >> 1 translation.
> >>
> >> This patch re-arranges the logic in cpu_do_switch_mm(.) such that
> >> phys_to_ttbr is called before the ASID is inserted into the TTBR0 value.
> >>
> >> Signed-off-by: Steve Capper <steve.capper@arm.com>
> >>
> >> ---
> >>
> >> This applies to the arm64 for-next/core branch.
> >> ---
> >>  arch/arm64/mm/proc.S | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> >> index c6a12073ef46..9f177aac6390 100644
> >> --- a/arch/arm64/mm/proc.S
> >> +++ b/arch/arm64/mm/proc.S
> >> @@ -153,14 +153,14 @@ ENDPROC(cpu_do_resume)
> >>  ENTRY(cpu_do_switch_mm)
> >>  	mrs	x2, ttbr1_el1
> >>  	mmid	x1, x1				// get mm->context.id
> >> +	phys_to_ttbr x0, x3
> >>  #ifdef CONFIG_ARM64_SW_TTBR0_PAN
> >> -	bfi	x0, x1, #48, #16		// set the ASID field in TTBR0
> >> +	bfi	x3, x1, #48, #16		// set the ASID field in TTBR0
> >>  #endif
> >>  	bfi	x2, x1, #48, #16		// set the ASID
> >>  	msr	ttbr1_el1, x2			// in TTBR1 (since TCR.A1 is set)
> >>  	isb
> >> -	phys_to_ttbr x0, x2
> >> -	msr	ttbr0_el1, x2			// now update TTBR0
> >> +	msr	ttbr0_el1, x3			// now update TTBR0
> >>  	isb
> >>  	b	post_ttbr_update_workaround	// Back to C code...
> >>  ENDPROC(cpu_do_switch_mm)
> 
> Thanks for finding and fixing this Steve, the patch looks good to me and
> I can reproduce the issue as well as confirm that this patch fixes it:
> 
> Tested-by: Kristina Martsenko <kristina.martsenko@arm.com>
> Reviewed-by: Kristina Martsenko <kristina.martsenko@arm.com>
> 
> > Thanks Steve. It looks like I messed up the merge: 1f911c3a1140 ("Merge
> > branch 'for-next/52-bit-pa' into for-next/core").
> 
> The merge commit is fine, the bug was introduced in commit 6b88a32c7af6
> ("arm64: kpti: Fix the interaction between ASID switching and software
> PAN").

Good point. I was bouncing between two versions of this patch, one for
the kpti branch and the other for for-next/core (the former doesn't have
the 52-bit PA).

I'll amend the commit.

-- 
Catalin
