From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 May 2011 09:19:38 +0100
Subject: [PATCH] ARM: EXYNOS4: Bugfix Hotplug
In-Reply-To: <1304470284-25770-1-git-send-email-myungjoo.ham@samsung.com>
References: <1304470284-25770-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <20110504081937.GA24071@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 04, 2011 at 09:51:24AM +0900, MyungJoo Ham wrote:
> When tested with "NURI" board, Exynos4 has not been working
> properly and showed error messages when the secondary core is being
> enabled with hotplug. The NURI board has Exynos4 of revision 1.

NAK.

> diff --git a/arch/arm/mach-exynos4/hotplug.c b/arch/arm/mach-exynos4/hotplug.c
> index 2b5909e..b81a24a 100644
> --- a/arch/arm/mach-exynos4/hotplug.c
> +++ b/arch/arm/mach-exynos4/hotplug.c
> @@ -30,13 +30,13 @@ static inline void cpu_enter_lowpower(void)
>  	 * Turn off coherency
>  	 */
>  	"	mrc	p15, 0, %0, c1, c0, 1\n"
> -	"	bic	%0, %0, %3\n"
> +	"	bic	%0, %0, #0x41\n"
>  	"	mcr	p15, 0, %0, c1, c0, 1\n"
>  	"	mrc	p15, 0, %0, c1, c0, 0\n"
> -	"	bic	%0, %0, %2\n"
> +	"	bic	%0, %0, #0x04\n"
>  	"	mcr	p15, 0, %0, c1, c0, 0\n"
>  	  : "=&r" (v)
> -	  : "r" (0), "Ir" (CR_C), "Ir" (0x40)
> +	  : "r" (0)

Why not just change the '0x40' to '0x41' ?

> @@ -45,14 +45,14 @@ static inline void cpu_leave_lowpower(void)
>  	unsigned int v;
>  
>  	asm volatile(
> -	"mrc	p15, 0, %0, c1, c0, 0\n"
> -	"	orr	%0, %0, %1\n"
> +	"	mrc	p15, 0, %0, c1, c0, 0\n"
> +	"	orr	%0, %0, #0x04\n"
>  	"	mcr	p15, 0, %0, c1, c0, 0\n"
>  	"	mrc	p15, 0, %0, c1, c0, 1\n"
> -	"	orr	%0, %0, %2\n"
> +	"	orr	%0, %0, #0x41\n"
>  	"	mcr	p15, 0, %0, c1, c0, 1\n"
>  	  : "=&r" (v)
> -	  : "Ir" (CR_C), "Ir" (0x40)
> +	  :

Same comment.
