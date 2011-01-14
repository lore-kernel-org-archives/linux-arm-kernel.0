From: viresh.kumar@st.com (viresh kumar)
Date: Fri, 14 Jan 2011 17:20:03 +0530
Subject: ARM: CPU hotplug: fix hard-coded control register constants
In-Reply-To: <4D303758.4060608@st.com>
References: <4D303758.4060608@st.com>
Message-ID: <4D30386B.7020200@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Russell,

I was just tracking latest changes in realview, for preparing SPEAr
support V4. I found below patch and didn't understood it very well.

> Subject: [PATCH] ARM: CPU hotplug: fix hard-coded control register constants
> 
> Use the definition we've provided in asm/system.h rather than
> numeric constants.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-realview/hotplug.c |    8 ++++----
>  arch/arm/mach-s5pv310/hotplug.c  |    8 ++++----
>  arch/arm/mach-tegra/hotplug.c    |    8 ++++----
>  3 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mach-realview/hotplug.c b/arch/arm/mach-realview/hotplug.c
> index b6387cf..a87523d 100644
> --- a/arch/arm/mach-realview/hotplug.c
> +++ b/arch/arm/mach-realview/hotplug.c
> @@ -31,10 +31,10 @@ static inline void cpu_enter_lowpower(void)
>  	"	bic	%0, %0, #0x20\n"
>  	"	mcr	p15, 0, %0, c1, c0, 1\n"
>  	"	mrc	p15, 0, %0, c1, c0, 0\n"
> -	"	bic	%0, %0, #0x04\n"
> +	"	bic	%0, %0, %2\n"
>  	"	mcr	p15, 0, %0, c1, c0, 0\n"
>  	  : "=&r" (v)
> -	  : "r" (0)
> +	  : "r" (0), "Ir" (CR_C)
>  	  : "cc");
>  }

This looks fine as you have replaced 0x04 with CR_C, which itself is (1 << 2).

>  
> @@ -43,13 +43,13 @@ static inline void cpu_leave_lowpower(void)
>  	unsigned int v;
>  
>  	asm volatile(	"mrc	p15, 0, %0, c1, c0, 0\n"
> -	"	orr	%0, %0, #0x04\n"
> +	"	orr	%0, %0, %1\n"
>  	"	mcr	p15, 0, %0, c1, c0, 0\n"
>  	"	mrc	p15, 0, %0, c1, c0, 1\n"
>  	"	orr	%0, %0, #0x20\n"
>  	"	mcr	p15, 0, %0, c1, c0, 1\n"
>  	  : "=&r" (v)
> -	  :
> +	  : "Ir" (CR_C)
>  	  : "cc");
>  }

fine here also.

>  
> diff --git a/arch/arm/mach-s5pv310/hotplug.c b/arch/arm/mach-s5pv310/hotplug.c
> index 951ba6d..afa5392 100644
> --- a/arch/arm/mach-s5pv310/hotplug.c
> +++ b/arch/arm/mach-s5pv310/hotplug.c
> @@ -30,13 +30,13 @@ static inline void cpu_enter_lowpower(void)
>  	 * Turn off coherency
>  	 */
>  	"	mrc	p15, 0, %0, c1, c0, 1\n"
> -	"	bic	%0, %0, #0x20\n"
> +	"	bic	%0, %0, %2\n"

but why replace 0x20 with CR_C instead of CR_D

>  	"	mcr	p15, 0, %0, c1, c0, 1\n"
>  	"	mrc	p15, 0, %0, c1, c0, 0\n"
>  	"	bic	%0, %0, #0x04\n"
>  	"	mcr	p15, 0, %0, c1, c0, 0\n"
>  	  : "=&r" (v)
> -	  : "r" (0)
> +	  : "r" (0), "Ir" (CR_C)
>  	  : "cc");
>  }
>  
> @@ -46,13 +46,13 @@ static inline void cpu_leave_lowpower(void)
>  
>  	asm volatile(
>  	"mrc	p15, 0, %0, c1, c0, 0\n"
> -	"	orr	%0, %0, #0x04\n"
> +	"	orr	%0, %0, %1\n"
>  	"	mcr	p15, 0, %0, c1, c0, 0\n"
>  	"	mrc	p15, 0, %0, c1, c0, 1\n"
>  	"	orr	%0, %0, #0x20\n"
>  	"	mcr	p15, 0, %0, c1, c0, 1\n"
>  	  : "=&r" (v)
> -	  :
> +	  : "Ir" (CR_C)
>  	  : "cc");
>  }
>  
> diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c
> index 17faf77..a5cb1ce 100644
> --- a/arch/arm/mach-tegra/hotplug.c
> +++ b/arch/arm/mach-tegra/hotplug.c
> @@ -26,13 +26,13 @@ static inline void cpu_enter_lowpower(void)
>  	 * Turn off coherency
>  	 */
>  	"	mrc	p15, 0, %0, c1, c0, 1\n"
> -	"	bic	%0, %0, #0x20\n"
> +	"	bic	%0, %0, %2\n"

here also.

Was this code wrong earlier??

-- 
viresh
