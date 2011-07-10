From: rabin@rab.in (Rabin Vincent)
Date: Sun, 10 Jul 2011 14:20:27 +0530
Subject: function tracer on i.mx35 (pcm043)
In-Reply-To: <201107041909.27354.tim.sander@hbm.com>
References: <201107041909.27354.tim.sander@hbm.com>
Message-ID: <CAH+eYFCwVacjbmG+08y6+NO2dYkRd-9YRgaGoUnrJZwa8ki-WA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 4, 2011 at 22:39, Tim Sander <tim.sander@hbm.com> wrote:
> Using vanilla 2.6.39 on arm i.mx35 (pcm043) with trace-cmd 1.0.5,
> build with:
> arm-1136jfs-linux-gnueabi-gcc (OSELAS.Toolchain-2011.03.0) 4.5.2.
>
> I am currently trying to find the reason why the irq on the i.mx35 is somtimes
> up do 80?s delayed. I thought that the function tracer would help in solving
> that problem but unfortunately it crashes when using the function trace plugin.

I think your platform uses arch/arm/plat-mxc/time.c?  Oopses with the
function graph tracer are usually caused by recursion due to a missing
notrace annotation on sched_clock() or its called functions.

Could you please try the following change? (applies on 2.6.39)

diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
index 2237ff8..9c7c6dc 100644
--- a/arch/arm/plat-mxc/time.c
+++ b/arch/arm/plat-mxc/time.c
@@ -106,17 +106,17 @@ static void gpt_irq_acknowledge(void)
 		__raw_writel(V2_TSTAT_OF1, timer_base + V2_TSTAT);
 }

-static cycle_t dummy_get_cycles(struct clocksource *cs)
+static cycle_t notrace dummy_get_cycles(struct clocksource *cs)
 {
 	return 0;
 }

-static cycle_t mx1_2_get_cycles(struct clocksource *cs)
+static cycle_t notrace mx1_2_get_cycles(struct clocksource *cs)
 {
 	return __raw_readl(timer_base + MX1_2_TCN);
 }

-static cycle_t v2_get_cycles(struct clocksource *cs)
+static cycle_t notrace v2_get_cycles(struct clocksource *cs)
 {
 	return __raw_readl(timer_base + V2_TCN);
 }
