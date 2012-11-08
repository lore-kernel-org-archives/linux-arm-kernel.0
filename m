From: rmallon@gmail.com (Ryan Mallon)
Date: Fri, 09 Nov 2012 10:06:15 +1100
Subject: [PATCH 04/11] ARM: set arch_gettimeoffset directly
In-Reply-To: <1352408516-21988-6-git-send-email-swarren@wwwdotorg.org>
References: <1352408516-21988-1-git-send-email-swarren@wwwdotorg.org>
 <1352408516-21988-6-git-send-email-swarren@wwwdotorg.org>
Message-ID: <509C3AE7.7030703@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/12 08:01, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> remove ARM's struct sys_timer .offset function pointer, and instead
> directly set the arch_gettimeoffset function pointer when the timer
> driver is initialized. This requires multiplying all function results
> by 1000, since the removed arm_gettimeoffset() did this. Also,
> s/unsigned long/u32/ just to make the function prototypes exactly
> match that of arch_gettimeoffset.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Andrew Victor <linux@maxim.org.za>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <rmallon@gmail.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  arch/arm/include/asm/mach/time.h  |    3 ---
>  arch/arm/kernel/time.c            |   14 --------------
>  arch/arm/mach-at91/at91x40_time.c |    8 +++++---
>  arch/arm/mach-ebsa110/core.c      |    7 ++++---
>  arch/arm/mach-ep93xx/core.c       |   23 ++++++++++++-----------
>  arch/arm/mach-h720x/common.c      |    6 +++---
>  arch/arm/mach-h720x/common.h      |    2 +-
>  arch/arm/mach-h720x/cpu-h7201.c   |    3 ++-
>  arch/arm/mach-h720x/cpu-h7202.c   |    3 ++-
>  arch/arm/mach-rpc/time.c          |    6 +++---
>  arch/arm/plat-samsung/time.c      |    7 ++++---
>  11 files changed, 36 insertions(+), 46 deletions(-)

<snip>

> +static u32 ep93xx_gettimeoffset(void)
> +{
> +	int offset;
> +
> +	offset = __raw_readl(EP93XX_TIMER4_VALUE_LOW) - last_jiffy_time;
> +
> +	/* Calculate (1000000 / 983040) * offset.  */

This comment is now incorrect, it should say:

	/* Calculate (1000000000 / 983040) * offset */

or perhaps to better explain what is being done:

	/*
	 * Timer 4 is based on a 983.04 kHz reference clock,
	 * so dividing by 983040 gives a milli-second value.
	 * Refactor the calculation to avoid overflow.
	 */

> +	return (offset + (53 * offset / 3072)) * 1000;
> +}

~Ryan
