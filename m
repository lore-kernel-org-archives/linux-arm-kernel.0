From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 30 Nov 2017 16:30:38 +0000
Subject: [PATCH] arm64: fpsimd: Fix failure to restore FPSIMD state after
 signals
In-Reply-To: <87374venpy.fsf@linaro.org>
References: <1512042997-25945-1-git-send-email-Dave.Martin@arm.com>
 <87374venpy.fsf@linaro.org>
Message-ID: <20171130163038.GP22781@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 30, 2017 at 04:27:21PM +0000, Alex Benn?e wrote:
> 
> Dave Martin <Dave.Martin@arm.com> writes:
> 
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
> 
> Tested-by: Alex Benn?e <alex.bennee@linaro.org>
> Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>

Awesome, thanks for the quick turn-around.

Will, will you pick with these tags or do you want me to repost?

Cheers
---Dave
