From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 4 Jan 2018 18:19:11 +0000
Subject: [PATCH] arm64: fpsimd: Fix state leakage when migrating after
 sigreturn
In-Reply-To: <1513362878-8787-1-git-send-email-Dave.Martin@arm.com>
References: <1513362878-8787-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180104181911.p7gvcwqzoey4fnof@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 15, 2017 at 06:34:38PM +0000, Dave P Martin wrote:
> When refactoring the sigreturn code to handle SVE, I changed the
> sigreturn implementation to store the new FPSIMD state from the
> user sigframe into task_struct before reloading the state into the
> CPU regs.  This makes it easier to convert the data for SVE when
> needed.
> 
> However, it turns out that the fpsimd_state structure passed into
> fpsimd_update_current_state is not fully initialised, so assigning
> the structure as a whole corrupts current->thread.fpsimd_state.cpu
> with uninitialised data.
> 
> This means that if the garbage data written to .cpu happens to be a
> valid cpu number, and the task is subsequently migrated to the cpu
> identified by the that number, and then tries to enter userspace,
> the CPU FPSIMD regs will be assumed to be correct for the task and
> not reloaded as they should be.  This can result in returning to
> userspace with the FPSIMD registers containing data that is stale or
> that belongs to another task or to the kernel.
> 
> Knowingly handing around a kernel structure that is incompletely
> initialised with user data is a potential source of mistakes,
> especially across source file boundaries.  To help avoid a repeat
> of this issue, this patch adapts the relevant internal API to hand
> around the user-accessible subset only: struct user_fpsimd_state.
> 
> To avoid future surprises, this patch also converts all uses of
> struct fpsimd_state that really only access the user subset, to use
> struct user_fpsimd_state.  A few missing consts are added to
> function prototypes for good measure.
> 
> Thanks to Will for spotting the cause of the bug here.
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: 8cd969d28fd2 ("arm64/sve: Signal handling support")
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>

I've queued this patch for 4.16 but do we actually need "Fixes:" here?
AFAICT, mainline already has the fix, the latest being a45448313706
"arm64: fpsimd: Fix copying of FP state from signal frame into task
struct" in -rc4 (for-next/core is based on -rc3).

-- 
Catalin
