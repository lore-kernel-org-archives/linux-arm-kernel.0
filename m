From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 19 Oct 2012 11:37:48 +0200
Subject: Do we need to fix below dump during cpu hot plug operation?
In-Reply-To: <20121019045802.GA21078@S2101-09.ap.freescale.net>
References: <20121019015621.GA17360@nchen-desktop>
 <20121019045802.GA21078@S2101-09.ap.freescale.net>
Message-ID: <CACRpkdaS3bJwnJMJHRSEukiD4r+62h-0HzL7bKF_Ppa4TFy-xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2012 at 6:58 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> Linus, Russell,
> Does it seem to be a valid fix?

Yes, but this patch is very incomplete. It only accounts for handling
the fact that the *twd_clk has already been fetched.

If the clock .setup() and .stop() is going to be called repeatedly, look over
the entire .setup() and .stop() function pair and make it
reentrant, right now it's pure luck if it works.

There are obviously more things that need fixing here.

You need to move this_cpu_clk = __this_cpu_ptr(twd_evt);
and check that before trying to register the clockevent right,
because if setup() is called repeatedly, you will add a new
clockevent every time, which is a massive memory leak.

Isn't the easiest and most straigt-forward fix something
like this:

>From 202c411f3212f74a5d2525ca291b249e1599b64e Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 19 Oct 2012 11:30:47 +0200
Subject: [PATCH] ARM: SMP_TWD: make setup()/stop() reentrant

This makes the SMP_TWD clock .setup()/.stop() pair reentrant by
not re-fetching the clk and re-registering the clock event every
time .setup() is called. We also make sure to call the
clk_enable()/clk_disable() pair on subsequent calls.

As it has been brought to my knowledge that this pair is going
to be called from atomic contexts for CPU clusters coming and
going, the clk_prepare()/clk_unprepare() calls cannot be called
on subsequent .setup()/.stop() iterations.

The patch assumes that the code will make sure that
twd_set_mode() is called through .set_mode() on the clock
event *after* the .setup() call, so that the timer registers
are fully re-programmed after a new .setup() cycle.

Reported-by: Peter Chen <peter.chen@freescale.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/smp_twd.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index e1f9069..1ac637b 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -31,6 +31,7 @@ static void __iomem *twd_base;

 static struct clk *twd_clk;
 static unsigned long twd_timer_rate;
+static bool initial_setup_called;

 static struct clock_event_device __percpu **twd_evt;
 static int twd_ppi;
@@ -93,6 +94,8 @@ static void twd_timer_stop(struct clock_event_device *clk)
 {
 	twd_set_mode(CLOCK_EVT_MODE_UNUSED, clk);
 	disable_percpu_irq(clk->irq);
+	if (twd_clk)
+		clk_disable(twd_clk);
 }

 #ifdef CONFIG_COMMON_CLK
@@ -273,8 +276,21 @@ static int __cpuinit twd_timer_setup(struct
clock_event_device *clk)
 {
 	struct clock_event_device **this_cpu_clk;

-	if (!twd_clk)
-		twd_clk = twd_get_clock();
+	/*
+	 * If the basic setup has been done before, don't bother
+	 * with yet again looking up the clock and register the clock
+	 * source.
+	 */
+	if (initial_setup_called) {
+		if (twd_clk)
+			clk_enable(twd_clk);
+		__raw_writel(0, twd_base + TWD_TIMER_CONTROL);
+		enable_percpu_irq(clk->irq, 0);
+		return 0;
+	}
+	initial_setup_called = true;
+
+	twd_clk = twd_get_clock();

 	if (!IS_ERR_OR_NULL(twd_clk))
 		twd_timer_rate = clk_get_rate(twd_clk);
-- 
1.7.11.7

Can you please see if this solves your problem?

Yours,
Linus Walleij
