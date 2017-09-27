From: will.deacon@arm.com (Will Deacon)
Date: Wed, 27 Sep 2017 10:21:49 +0100
Subject: [PATCH] arm64: avoid instrumenting atomic_ll_sc.o
In-Reply-To: <1506448987-31070-1-git-send-email-mark.rutland@arm.com>
References: <1506448987-31070-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20170927092149.GB19753@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 26, 2017 at 07:03:07PM +0100, Mark Rutland wrote:
> Our out-of-line atomics are built with a special calling convention,
> preventing pointless stack spilling, and allowing us to patch call sites
> with ARMv8.1 atomic instructions.
> 
> Instrumentation inserted by the compiler may result in calls to
> functions not following this special calling convention, resulting in
> registers being unexpectedly clobbered, and various problems resulting
> from this.
> 
> For example, if a kernel is built with KCOV and ARM64_LSE_ATOMICS, the
> compiler inserts calls to __sanitizer_cov_trace_pc in the prologues of
> the atomic functions. This has been observed to result in spurious
> cmpxchg failures, leading to a hang early on in the boot process.
> 
> This patch avoids such issues by preventing instrumentation of our
> out-of-line atomics.

Why doesn't decorating them with "notrace" like we do via the __LL_SC_INLINE
macro help here? Do we just need to extend that somehow?

> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/lib/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
> index a0abc14..8fea178 100644
> --- a/arch/arm64/lib/Makefile
> +++ b/arch/arm64/lib/Makefile
> @@ -17,5 +17,9 @@ CFLAGS_atomic_ll_sc.o	:= -fcall-used-x0 -ffixed-x1 -ffixed-x2		\
>  		   -fcall-saved-x10 -fcall-saved-x11 -fcall-saved-x12	\
>  		   -fcall-saved-x13 -fcall-saved-x14 -fcall-saved-x15	\
>  		   -fcall-saved-x18
> +GCOV_PROFILE_atomic_ll_sc.o	:= n
> +KASAN_SANITIZE_atomic_ll_sc.o	:= n
> +KCOV_INSTRUMENT_atomic_ll_sc.o	:= n
> +UBSAN_SANITIZE_atomic_ll_sc.o	:= n

Hmm... do we need similar things for the vDSO? I can only spot the GCOV
entry, and other architectures have a mixed bag of these. It would be
nice if there was something a little less ad-hoc and error prone provided
by kbuild.

Will
