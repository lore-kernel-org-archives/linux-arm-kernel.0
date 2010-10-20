From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 20 Oct 2010 13:24:44 -0500
Subject: [PATCH 1/5] ARM: remove dependency of platform code on
	CLOCK_TICK_RATE / LATCH defines
In-Reply-To: <20101020045121.GX12979@mail.wantstofly.org>
References: <20101020045121.GX12979@mail.wantstofly.org>
Message-ID: <0D753D10438DA54287A00B02708426976450E993B3@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, October 19, 2010 9:51 PM, Lennert Buytenhek wrote:
>
> One of the things preventing building an ARM multiplatform kernel
> image is the fact that CLOCK_TICK_RATE (and as a consequence, LATCH)
> is defined differently for each platform.
>
> CLOCK_TICK_RATE is mostly unused beyond some usage in the various
> ARM platform support code directories themselves (and a couple of
> bogus uses elsewhere, such as in drivers/input/joystick/analog.c).
>
> Therefore, for those ARM platforms that use their own definition
> of CLOCK_TICK_RATE (for example, in their timer setup code), copy
> the definition of CLOCK_TICK_RATE into the platform code, renaming
> it to TICK_RATE in the process.
>
> Also, for those ARM platforms that use the LATCH define (which is
> derived from CLOCK_TICK_RATE), give them a private definition, named
> TIMER_LATCH, based on the now locally defined TICK_RATE.
>
> This gets rid of platform code dependencies on mach/timex.h's
> CLOCK_TICK_RATE definition, and allows killing all mach/timex.h in
> a subsequent patch.
>
> Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
> ---

[snip]

> arch/arm/mach-ep93xx/core.c          |    3 ++-

[snip]

> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
> index 4cb55d3..3d6d015 100644
> --- a/arch/arm/mach-ep93xx/core.c
> +++ b/arch/arm/mach-ep93xx/core.c
> @@ -111,7 +111,8 @@ void __init ep93xx_map_io(void)
>  #define EP93XX_TIMER4_CLOCK		983040
>  
>  #define TIMER1_RELOAD			((EP93XX_TIMER123_CLOCK / HZ) - 1)
> -#define TIMER4_TICKS_PER_JIFFY		DIV_ROUND_CLOSEST(CLOCK_TICK_RATE, HZ)
> +#define TIMER4_TICKS_PER_JIFFY		\
> +		DIV_ROUND_CLOSEST(EP93XX_TIMER4_CLOCK, HZ)
>  
>  static unsigned int last_jiffy_time;

For ep93xx.

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
