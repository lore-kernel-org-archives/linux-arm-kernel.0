From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 23 Jan 2017 18:09:41 +0100
Subject: [PATCH v4 9/9] clocksource/drivers/rockchip_timer: implement
 clocksource timer
In-Reply-To: <1480436092-10728-10-git-send-email-al.kochet@gmail.com>
References: <1480343486-25539-1-git-send-email-al.kochet@gmail.com>
 <1480436092-10728-1-git-send-email-al.kochet@gmail.com>
 <1480436092-10728-10-git-send-email-al.kochet@gmail.com>
Message-ID: <2966820.3ediQCxqSR@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 29. November 2016, 19:14:52 CET schrieb Alexander Kochetkov:
> The clock supplying the arm-global-timer on the rk3188 is coming from the
> the cpu clock itself and thus changes its rate everytime cpufreq adjusts
> the cpu frequency making this timer unsuitable as a stable clocksource
> and sched clock.
> 
> The rk3188, rk3288 and following socs share a separate timer block already
> handled by the rockchip-timer driver. Therefore adapt this driver to also
> be able to act as clocksource and sched clock on rk3188.
> 
> In order to test clocksource you can run following commands and check
> how much time it take in real. On rk3188 it take about ~45 seconds.
> 
>     cpufreq-set -f 1.6GHZ
>     date; sleep 60; date
> 
> In order to use the patch you need to declare two timers in the dts
> file. The first timer will be initialized as clockevent provider
> and the second one as clocksource. The clockevent must be from
> alive subsystem as it used as backup for the local timers at sleep
> time.
> 
> The patch does not break compatibility with older device tree files.
> The older device tree files contain only one timer. The timer
> will be initialized as clockevent, as expected.
> 
> rk3288 (and probably anything newer) is irrelevant to this patch,
> as it has the arch timer interface. This patch may be usefull
> for Cortex-A9/A5 based parts.
> 
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>

[...]

> @@ -120,13 +161,46 @@ static irqreturn_t rk_timer_interrupt(int irq, void
> *dev_id) return IRQ_HANDLED;
>  }
> 
> +static cycle_t rk_timer_clocksource_read(struct clocksource *cs)
^^
../drivers/clocksource/rockchip_timer.c:164:8: error: unknown type name ?cycle_t?
 static cycle_t rk_timer_clocksource_read(struct clocksource *cs)

looks like something in clocksources changed since november
