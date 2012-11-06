From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 6 Nov 2012 06:17:02 -0600
Subject: [PATCH 1/5] ARM: EXYNOS: fix the hotplug for Cortex-A15
In-Reply-To: <1352182356-28989-2-git-send-email-a.kesavan@samsung.com>
References: <1352182356-28989-1-git-send-email-a.kesavan@samsung.com>
 <1352182356-28989-2-git-send-email-a.kesavan@samsung.com>
Message-ID: <5098FFBE.4080604@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 November 2012 12:12 AM, Abhilash Kesavan wrote:
> The sequence of cpu_enter_lowpower() for Cortex-A15
> is different from the sequence for Cortex-A9.
Are you sure ? Apart from integrated cache vs external, there
should be no change. And L2 doesn't need to come into picture
while powering down just a CPU.

> This patch implements cpu_enter_lowpower() for EXYNOS5
> SoC which has Cortex-A15 cores.
>
> Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Tested-by: Abhilash Kesavan <a.kesavan@samsung.com>
> ---
>   arch/arm/mach-exynos/hotplug.c |   45 +++++++++++++++++++++++++++++++++++++--
>   1 files changed, 42 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
> index f4d7dd2..8c06c4f 100644
> --- a/arch/arm/mach-exynos/hotplug.c
> +++ b/arch/arm/mach-exynos/hotplug.c
> @@ -20,10 +20,11 @@
>   #include <asm/smp_plat.h>
>
>   #include <mach/regs-pmu.h>
> +#include <plat/cpu.h>
>
>   #include "common.h"
>
> -static inline void cpu_enter_lowpower(void)
> +static inline void cpu_enter_lowpower_a9(void)
>   {
>   	unsigned int v;
>
> @@ -45,6 +46,35 @@ static inline void cpu_enter_lowpower(void)
>   	  : "cc");
>   }
>
> +static inline void cpu_enter_lowpower_a15(void)
> +{
> +	unsigned int v;
> +
> +	asm volatile(
> +	"	mrc	p15, 0, %0, c1, c0, 0\n"
> +	"	bic	%0, %0, %1\n"
> +	"	mcr	p15, 0, %0, c1, c0, 0\n"
> +	  : "=&r" (v)
> +	  : "Ir" (CR_C)
> +	  : "cc");
> +
> +	flush_cache_all();
> +
Why are flushing all the cache levels ?
flush_kern_louis() should be enough for CPU power
down.

> +	asm volatile(
> +	/*
> +	* Turn off coherency
> +	*/
> +	"	mrc	p15, 0, %0, c1, c0, 1\n"
> +	"	bic	%0, %0, %1\n"
> +	"	mcr	p15, 0, %0, c1, c0, 1\n"
> +	: "=&r" (v)
> +	: "Ir" (0x40)
> +	: "cc");
> +
> +	isb();
> +	dsb();
> +}
> +
The above sequence should work on A9 as well. In general you should have
CPU power down code under one code block and avoid making use of stack 
in between. Otherwise you will end up with stack corruption because of
the memory view change after C bit is disabled.

Regards
Santosh
