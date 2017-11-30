From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 30 Nov 2017 16:29:42 +0000
Subject: [PATCH] arm64: fpsimd: Fix failure to restore FPSIMD state after
 signals
In-Reply-To: <1512042997-25945-1-git-send-email-Dave.Martin@arm.com>
References: <1512042997-25945-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20171130162942.GO22781@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 30, 2017 at 11:56:37AM +0000, Dave Martin wrote:
> The fpsimd_update_current_state() function is responsible for
> loading the FPSIMD state from the user signal frame into the
> current task during sigreturn.  When implementing support for SVE,
> conditional code was added to this function in order to handle the
> case where SVE state need to be loaded for the task and merged with
> the FPSIMD data from the signal frame; however, the FPSIMD-only
> case was unintentionally dropped.
> 
> As a result of this, sigreturn does not currently restore the
> FPSIMD state of the task, except in the case where the system
> supports SVE and the signal frame contains SVE state in addition to
> FPSIMD state.
> 
> This patch fixes this bug by making the copy-in of the FPSIMD data
> from the signal frame to thread_struct unconditional.
> 
> This remains a performance regression from v4.14, since the FPSIMD
> state is now copied into thread_struct and then loaded back,
> instead of _only_ being loaded into the CPU FPSIMD registers.
> However, it is essential to call task_fpsimd_load() here anyway in
> order to ensure that the SVE enable bit in CPACR_EL1 is set
> correctly before returning to userspace.  This could use some
> refactoring, but since sigreturn is not a fast path I have kept
> this patch as a pure fix and left the refactoring for later.
> 
> Fixes: 8cd969d28fd2 ("arm64/sve: Signal handling support")
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Reported-by: Alex Benn?e <alex.bennee@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>
> ---

[...]

> While debugging this issue, I also hit another possible register
> corruption issue that I don't have an explanation for, but I wanted to
> get this patch out first since this issue at least is fairly
> straightforward and fixing it is required anyway.
> 
> I will continue to investigate.

I've now tracked this issue down to a unintended feature in my test, so
I believe this patch is sufficient to fix the observed problems (testing
still encouraged though).

Cheers
---Dave
