From: skannan@codeaurora.org (Saravana Kannan)
Date: Thu, 29 Apr 2010 19:51:02 -0700
Subject: [PATCH] [ARM] Add ARCH_PROVIDES_UDELAY config option
In-Reply-To: <1272532104-20074-1-git-send-email-ccross@android.com>
References: <> <1272532104-20074-1-git-send-email-ccross@android.com>
Message-ID: <4BDA4596.9060905@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

You beat me to it :-) I was thinking of doing this for now before trying 
to find the *perfect* fix with the cpufreq maintainers.

If you want, you can also add in details about how using a constant freq 
counter would also avoid the issue of CPU freq switching while we are 
delay looping.

The current ARM implementation doesn't handle this either.

If my opinion matters, I think this is a good patch.

-Saravana

Colin Cross wrote:
> On SMP kernels, the loops_per_jiffy value is not scaled, leading to
> udelays that are too long if the CPU frequency is scaled down from
> the frequency at loops_per_jiffy calibration, or too short if the
> frequency is scaled up.  Some SOCs have a timer with a constant tick
> rate that can be used to time udelays, similar to the TSC on x86.
> Provide a config flag to allow these SOCs to override the default
> ARM udelay implementation.
> 
> Signed-off-by: Colin Cross <ccross@android.com>
> ---
>  arch/arm/Kconfig             |    3 +++
>  arch/arm/include/asm/delay.h |    4 ++++
>  arch/arm/lib/Makefile        |    6 +++++-
>  3 files changed, 12 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 33d2825..d9923b0 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -175,6 +175,9 @@ config ARM_L1_CACHE_SHIFT_6
>  	help
>  	  Setting ARM L1 cache line size to 64 Bytes.
>  
> +config ARCH_PROVIDES_UDELAY
> +  bool
> +
>  if OPROFILE
>  
>  config OPROFILE_ARMV6
> diff --git a/arch/arm/include/asm/delay.h b/arch/arm/include/asm/delay.h
> index b2deda1..57f1fa0 100644
> --- a/arch/arm/include/asm/delay.h
> +++ b/arch/arm/include/asm/delay.h
> @@ -8,6 +8,9 @@
>  
>  #include <asm/param.h>	/* HZ */
>  
> +#ifdef CONFIG_ARCH_PROVIDES_UDELAY
> +#include <mach/delay.h>
> +#else
>  extern void __delay(int loops);
>  
>  /*
> @@ -40,5 +43,6 @@ extern void __const_udelay(unsigned long);
>  			__const_udelay((n) * ((2199023U*HZ)>>11))) :	\
>  	  __udelay(n))
>  
> +#endif /* defined(ARCH_PROVIDES_UDELAY) */
>  #endif /* defined(_ARM_DELAY_H) */
>  
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index 030ba72..aa449e3 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -6,7 +6,7 @@
>  
>  lib-y		:= backtrace.o changebit.o csumipv6.o csumpartial.o   \
>  		   csumpartialcopy.o csumpartialcopyuser.o clearbit.o \
> -		   delay.o findbit.o memchr.o memcpy.o		      \
> +		   findbit.o memchr.o memcpy.o                        \
>  		   memmove.o memset.o memzero.o setbit.o              \
>  		   strncpy_from_user.o strnlen_user.o                 \
>  		   strchr.o strrchr.o                                 \
> @@ -17,6 +17,10 @@ lib-y		:= backtrace.o changebit.o csumipv6.o csumpartial.o   \
>  
>  mmu-y	:= clear_user.o copy_page.o getuser.o putuser.o
>  
> +ifneq ($(CONFIG_ARCH_PROVIDES_UDELAY),y)
> +  lib-y += delay.o
> +endif
> +
>  # the code in uaccess.S is not preemption safe and
>  # probably faster on ARMv3 only
>  ifeq ($(CONFIG_PREEMPT),y)
