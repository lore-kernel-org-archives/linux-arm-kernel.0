From: will.deacon@arm.com (Will Deacon)
Date: Tue, 1 Mar 2016 15:11:21 +0000
Subject: [PATCHv4] arm64: Rework valid_user_regs
In-Reply-To: <1456841930-16602-1-git-send-email-mark.rutland@arm.com>
References: <1456841930-16602-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20160301151121.GB14022@arm.com>
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
> ---
>  arch/arm64/include/asm/ptrace.h | 33 +++--------------
>  arch/arm64/kernel/ptrace.c      | 80 +++++++++++++++++++++++++++++++++++++++--
>  arch/arm64/kernel/signal.c      |  4 +--
>  arch/arm64/kernel/signal32.c    |  2 +-
>  4 files changed, 85 insertions(+), 34 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

We'll also need to backport this to the various stable trees.

Will
