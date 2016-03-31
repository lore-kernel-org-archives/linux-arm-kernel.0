From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 31 Mar 2016 15:29:08 +0100
Subject: [PATCH v1] arm64: allow building with kcov coverage on ARM64
In-Reply-To: <57cb1b66d85b85eadea28ef3304a62b1327ded45.1459432254.git.glider@google.com>
References: <57cb1b66d85b85eadea28ef3304a62b1327ded45.1459432254.git.glider@google.com>
Message-ID: <20160331142908.GG26532@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 31, 2016 at 03:54:45PM +0200, Alexander Potapenko wrote:
> Add ARCH_HAS_KCOV to ARM64 config. Disable instrumentation of
> arch/arm64/lib/delay.c

Why do we disable instrumentation of delay.c?

What exactly does kcov instrumentation imply? Does it require certain
data to be mapped or certain functions to be callable while instrumented
functions are called?

We have some C code that is run outside of the normal kernel context
(e.g. EFI stub, KVM hyp code), and I suspect it may be necessary to
disable instrumentation for those also.

Thanks,
Mark.

> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
>  arch/arm64/Kconfig      | 1 +
>  arch/arm64/lib/Makefile | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 4f43622..c52aa61 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -7,6 +7,7 @@ config ARM64
>  	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>  	select ARCH_HAS_ELF_RANDOMIZE
>  	select ARCH_HAS_GCOV_PROFILE_ALL
> +	select ARCH_HAS_KCOV
>  	select ARCH_HAS_SG_CHAIN
>  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>  	select ARCH_USE_CMPXCHG_LOCKREF
> diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
> index c86b790..b407bc1 100644
> --- a/arch/arm64/lib/Makefile
> +++ b/arch/arm64/lib/Makefile
> @@ -1,3 +1,6 @@
> +# Produces uninteresting flaky coverage.
> +KCOV_INSTRUMENT_delay.o	:= n
> +
>  lib-y		:= bitops.o clear_user.o delay.o copy_from_user.o	\
>  		   copy_to_user.o copy_in_user.o copy_page.o		\
>  		   clear_page.o memchr.o memcpy.o memmove.o memset.o	\
> -- 
> 2.8.0.rc3.226.g39d4020
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
