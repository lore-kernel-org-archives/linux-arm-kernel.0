From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 04 Dec 2012 19:54:55 -0700
Subject: [PATCH] ARM: bcm281xx: Add timer driver
In-Reply-To: <1354593324-21300-1-git-send-email-csd@broadcom.com>
References: <1354593324-21300-1-git-send-email-csd@broadcom.com>
Message-ID: <50BEB77F.10303@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2012 08:55 PM, Christian Daudt wrote:
> This adds support for the Broadcom timer, used in the following SoCs:
> BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
> 
> This patch needs the arm-soc/soc/next branch

I assume this is being applied for 3.9, so it'll want to be rebased on
the struct sys_timer removal, which I hope to get into linux-next very
early after 3.8-rc1.

> diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi

> +	timer at 35006000 {
> +		compatible = "bcm,kona-timer";

Is there DT binding documentation for this?

I'm slightly worried about "kona". Is it a well-known name outside
Broadcom for this HW block? If it really is the name though, it's fine I
guess, since it's within the "bcm," name-space here.

> diff --git a/drivers/clocksource/bcm_timer.c b/drivers/clocksource/bcm_timer.c

Is this timer HW used in every Broadcom chip? I wonder if the file
shouldn't be named bcm_kona_timer.c to allow co-existence with any others.

> +struct bcm_timers {
> +	int tmr_irq;
> +	void __iomem *tmr_regs;
> +};
> +
> +struct bcm_timers timers;

Should that be static?

> +/* We use the peripheral timers for system tick, the cpu global timer for
> + * profile tick
> + */

I think it's usual to leave the /* line empty, so that would be:

> +/*
> + * We use the peripheral timers for system tick, the cpu global timer for
> + * profile tick
> + */


> +static void timer_disable_and_clear(void __iomem *base)

> +	reg = 0;
> +
> +	/* Clear compare (0) interrupt */
> +	reg |= 1 << KONA_GPTIMER_STCS_TIMER_MATCH_SHIFT;
> +	/* disable compare */
> +	reg &= ~(1 << KONA_GPTIMER_STCS_COMPARE_ENABLE_SHIFT);

That bit isn't set anywhere; is there a need to clear it; should "reg =
0" above be a readl() of the register?

> +static void
> +timer_get_counter(void *timer_base, uint32_t *msw, uint32_t *lsw)

> +	while (1) {
> +		*msw = readl(base + KONA_GPTIMER_STCHI_OFFSET);
> +		*lsw = readl(base + KONA_GPTIMER_STCLO_OFFSET);
> +		if (*msw == readl(base + KONA_GPTIMER_STCHI_OFFSET))
> +			break;
> +	}

I guess it's very unlikely, but should there be a limit to the loop
count here, or a diagnostic if it runs too long?

> +static void __init timer_clockevents_init(void)

Can this function use clockevents_config_and_register() to avoid a bunch
of the manual calculations and assignments?

> diff --git a/drivers/clocksource/bcm_timer.h b/drivers/clocksource/bcm_timer.h

You may as well move these definitions into the .c file since they don't
need to be public?
