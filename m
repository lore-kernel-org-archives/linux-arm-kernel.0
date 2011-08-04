From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 4 Aug 2011 12:52:42 -0500
Subject: [PATCH 12/12] ARM: Remove mach-*/include/mach/timex.h
In-Reply-To: <20110804135445.GJ1019@plexity.net>
References: <cover.1312455035.git.dsaxena@linaro.org>
	<20110804135445.GJ1019@plexity.net>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F3882B8C28@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, August 04, 2011 6:55 AM, Deepak Saxena wrote:
> 
> We no longer use the global LATCH definition to drive
> any platform-specific timers so we can remove the
> timex.h files from all sub-arch include directories.
> 
> We still need to keep an ARM CLOCK_TICK_RATE due to
> jiffies.h depending on it to build but that will be
> removed in the future once all non-ARM references to
> LATCH are also removed.
> 
> Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
> ---

[snip]

> diff --git a/arch/arm/include/asm/timex.h b/arch/arm/include/asm/timex.h
> index 3be8de3..c4f4dac 100644
> --- a/arch/arm/include/asm/timex.h
> +++ b/arch/arm/include/asm/timex.h
> @@ -12,7 +12,10 @@
>  #ifndef _ASMARM_TIMEX_H
>  #define _ASMARM_TIMEX_H
>  
> -#include <mach/timex.h>
> +/* 
> + * Bogus value used to allow kernel to build
> + */
> +#define	CLOCK_TICK_RATE	1000000
>  
>  typedef unsigned long cycles_t;
>  

[snip]

> diff --git a/arch/arm/mach-ep93xx/include/mach/timex.h b/arch/arm/mach-ep93xx/include/mach/timex.h
> deleted file mode 100644
> index 6b3503b..0000000
> --- a/arch/arm/mach-ep93xx/include/mach/timex.h
> +++ /dev/null
> @@ -1,5 +0,0 @@
> -/*
> - * arch/arm/mach-ep93xx/include/mach/timex.h
> - */
> -
> -#define CLOCK_TICK_RATE		983040

Confused...

mach-ep93xx/core.c uses the CLOCK_TICK_RATE to determine TIMER4_TICKS_PER_JIFFY.
Timer 4 runs at 983.04 kHz, this patch changes this rate to 1 MHz.  Won't that
effect the sys_timer?

Regards,
Hartley
