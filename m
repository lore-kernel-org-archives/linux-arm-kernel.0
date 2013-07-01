From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 1 Jul 2013 19:55:15 +0200 (CEST)
Subject: [PATCH v4] ARM: clocksource: add support for MOXA ART SoCs
In-Reply-To: <1372687359-18235-1-git-send-email-jonas.jensen@gmail.com>
References: <1372332203-30228-1-git-send-email-jonas.jensen@gmail.com>
 <1372687359-18235-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <alpine.DEB.2.02.1307011953390.4013@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 1 Jul 2013, Jonas Jensen wrote:
> +static int moxart_clkevt_next_event(unsigned long cycles,
> +				    struct clock_event_device *unused)
> +{
> +	u32 u;
> +
> +	u = readl(base + TIMER_CR) & ~TIMEREG_CR_1_ENABLE;

You should cache that value and avoid another readout below. You could
even cache it in general so you avoid all readouts.

> +	writel(u, base + TIMER_CR);
> +	u = readl(base + TIMER1_BASE + REG_COUNT) - cycles;
> +	writel(u, base + TIMER1_BASE + REG_MATCH1);
> +	u = readl(base + TIMER_CR) | TIMEREG_CR_1_ENABLE;
> +	writel(u, base + TIMER_CR);
> +	return 0;
> +}

Thanks,

	tglx
