From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 30 Nov 2017 12:32:44 +0000
Subject: [PATCH] arm64: fpsimd: Fix failure to restore FPSIMD state after
 signals
In-Reply-To: <20171130120847.GC21983@arm.com>
References: <1512042997-25945-1-git-send-email-Dave.Martin@arm.com>
 <20171130120847.GC21983@arm.com>
Message-ID: <20171130123242.GN22781@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 30, 2017 at 12:08:47PM +0000, Will Deacon wrote:
> On Thu, Nov 30, 2017 at 11:56:37AM +0000, Dave Martin wrote:
> > The fpsimd_update_current_state() function is responsible for
> > loading the FPSIMD state from the user signal frame into the
> > current task during sigreturn.  When implementing support for SVE,
> > conditional code was added to this function in order to handle the
> > case where SVE state need to be loaded for the task and merged with
> > the FPSIMD data from the signal frame; however, the FPSIMD-only
> > case was unintentionally dropped.
> > 
> > As a result of this, sigreturn does not currently restore the
> > FPSIMD state of the task, except in the case where the system
> > supports SVE and the signal frame contains SVE state in addition to
> > FPSIMD state.
> > 
> > This patch fixes this bug by making the copy-in of the FPSIMD data
> > from the signal frame to thread_struct unconditional.
> > 
> > This remains a performance regression from v4.14, since the FPSIMD
> > state is now copied into thread_struct and then loaded back,
> > instead of _only_ being loaded into the CPU FPSIMD registers.
> > However, it is essential to call task_fpsimd_load() here anyway in
> > order to ensure that the SVE enable bit in CPACR_EL1 is set
> > correctly before returning to userspace.  This could use some
> > refactoring, but since sigreturn is not a fast path I have kept
> > this patch as a pure fix and left the refactoring for later.
> > 
> > Fixes: 8cd969d28fd2 ("arm64/sve: Signal handling support")
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > Reported-by: Alex Benn?e <alex.bennee@linaro.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> > 
> > Initial testing of this patch looks OK, but I will continue to bash it.
> > 
> > While debugging this issue, I also hit another possible register
> > corruption issue that I don't have an explanation for, but I wanted to
> > get this patch out first since this issue at least is fairly
> > straightforward and fixing it is required anyway.
> > 
> > I will continue to investigate.
> > 
> >  arch/arm64/kernel/fpsimd.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> > index 143b3e7..5084e69 100644
> > --- a/arch/arm64/kernel/fpsimd.c
> > +++ b/arch/arm64/kernel/fpsimd.c
> > @@ -1026,10 +1026,10 @@ void fpsimd_update_current_state(struct fpsimd_state *state)
> >  
> >  	local_bh_disable();
> >  
> > -	if (system_supports_sve() && test_thread_flag(TIF_SVE)) {
> > -		current->thread.fpsimd_state = *state;
> > +	current->thread.fpsimd_state = *state;
> > +	if (system_supports_sve() && test_thread_flag(TIF_SVE))
> >  		fpsimd_to_sve(current);
> > -	}
> > +
> 
> Curious, but does the order in which you set TIF_SVE matter? If not, you

Historically, yes, but now this flag is protected by local_bh_disable()
for running tasks, everywhere execpt in
signal.c:restore_sve_fpsimd_context() (see comments in that function for
explanation of that case).

(To be more precise, it's not TIF_SVE that's critical directly, but the
TIF_FOREIGN_FPSTATE stuff and related logic are bh-critical, and the
ordering of TIF_SVE against TIF_FOREIGN_FPSTATE et al. _is_ important.
So TIF_SVE is bh-critical-by-proxy as it were.)

> could move the TIF_SVE check into fpsimd_to_sve and reorder the flag setting
> in do_sve_acc so that we don't need to conditionalise all invocations of
> this.

This kind of thing will get sucked into future cleanup I want to do.  I
don't like to tweak this one thing by itself, because there is a wider
factoring issue to be looked at: there are many functions today that do
SVE-related things unconditionally and leave it to the caller to check
whether they should be called or not.

Eventually, I'd like to get rid of much of the local_bh_disable(), in
which case the exact ordering of checks would become important again.
I remained unsure whether baking these checks in was the correct thing
to do -- at the least it may result in duplicate checks on some code
paths.  For this particular function that's not an issue though.

I can take a look if you feel strongly about it, but it doesn't feel
like a priority right now.  Attacking it piecemeal is likely to create
more problems than it solves IMHO...

Cheers
---Dave
