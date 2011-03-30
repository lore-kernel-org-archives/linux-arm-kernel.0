From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 30 Mar 2011 09:57:02 +0100
Subject: [PATCH 1/1] ARM: imx: Add sched_clock support to i.mx platform
In-Reply-To: <1301472471-5826-1-git-send-email-Frank.Li@freescale.com>
References: <1301472471-5826-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20110330085702.GA29121@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2011 at 04:07:51PM +0800, Frank Li wrote:
> From: Xinyu Chen <xinyu.chen@freescale.com>
> 
> Add sched_clock() implement for i.mx platform to support nanosecond
> resolution time for sched clock used by scheduler.

NAK.

> diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
> index 9f0c261..de8a04f 100644
> --- a/arch/arm/plat-mxc/time.c
> +++ b/arch/arm/plat-mxc/time.c
> @@ -123,6 +123,15 @@ static struct clocksource clocksource_mxc = {
>  	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
>  };
>  
> +unsigned long long sched_clock(void)
> +{
> +	if (!timer_base)
> +		return 0;
> +
> +	return clocksource_cyc2ns(clocksource_mxc.read(&clocksource_mxc),
> +			clocksource_mxc.mult, clocksource_mxc.shift);
> +}

This is buggy because it won't scale to the full 64-bit value which
sched_clock() requires.  Please use the sched_clock() support I have
provided which ensures that a 32-bit counter is properly extended to
a full 64-bit value for sched_clock() - see arch/arm/kernel/sched_clock.c
and arch/arm/include/asm/sched_clock.h.
