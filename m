From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 2 Mar 2016 16:00:25 +0000
Subject: [PATCHv4] arm64: Rework valid_user_regs
In-Reply-To: <1456841930-16602-1-git-send-email-mark.rutland@arm.com>
References: <1456841930-16602-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20160302160024.GA14434@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 01, 2016 at 02:18:50PM +0000, Mark Rutland wrote:
> We validate pstate using PSR_MODE32_BIT, which is part of the
> user-provided pstate (and cannot be trusted). Also, we conflate
> validation of AArch32 and AArch64 pstate values, making the code
> difficult to reason about.
> 
> Instead, validate the pstate value based on the associated task. The
> task may or may not be current (e.g. when using ptrace), so this must be
> passed explicitly by callers. To avoid circular header dependencies via
> sched.h, is_compat_task is pulled out of asm/ptrace.h.
> 
> To make the code possible to reason about, the AArch64 and AArch32
> validation is split into separate functions. Software must respect the
> RES0 policy for SPSR bits, and thus the kernel mirrors the hardware
> policy (RAZ/WI) for bits as-yet unallocated. When these acquire an
> architected meaning writes may be permitted (potentially with additional
> validation).
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Dave Martin <dave.martin@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>

Applied. Thanks.

(just remember, once it gets a bit more testing in -next and mainline,
to send a back-port to stable)

-- 
Catalin
