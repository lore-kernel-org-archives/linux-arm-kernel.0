From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 17 Aug 2012 15:51:17 +0530
Subject: [PATCH v2 28/31] arm64: Generic timers support
In-Reply-To: <1344966752-16102-29-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-29-git-send-email-catalin.marinas@arm.com>
Message-ID: <502E1B1D.2030609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 August 2012 11:22 PM, Catalin Marinas wrote:
> From: Marc Zyngier<marc.zyngier@arm.com>
>
> This patch adds support for the ARM generic timers with A64 instructions
> for accessing the timer registers. It uses the physical counter as the
> clock source and the virtual counter as sched_clock.
>
> The timer frequency can be specified via DT or read from the CNTFRQ_EL0
> register. The physical counter is also accessible from user space
> allowing fast gettimeofday() implementation.
>
> Signed-off-by: Marc Zyngier<marc.zyngier@arm.com>
> Signed-off-by: Will Deacon<will.deacon@arm.com>
> Signed-off-by: Catalin Marinas<catalin.marinas@arm.com>
> ---

[..]

> diff --git a/drivers/clocksource/arm_generic.c b/drivers/clocksource/arm_generic.c
> new file mode 100644
> index 0000000..05c898c
> --- /dev/null
> +++ b/drivers/clocksource/arm_generic.c

[..]

> +
> +static void __cpuinit arch_timer_setup(struct clock_event_device *clk)
> +{
> +	/* Let's make sure the timer is off before doing anything else */
> +	arch_timer_stop();
> +
> +	clk->features = CLOCK_EVT_FEAT_ONESHOT;
Are these CPU timers wakeup capable or we need the wakeup capable
broadcast timer for low power wakeups ?
In that case C3STOP would be needed here.

Regards
santosh
