From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 22 Oct 2012 13:13:25 +0800
Subject: [PATCH v2] ARM: SMP_TWD: make setup()/stop() reentrant
In-Reply-To: <1350640589-31821-1-git-send-email-linus.walleij@linaro.org>
References: <1350640589-31821-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20121022051319.GA19107@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2012 at 11:56:29AM +0200, Linus Walleij wrote:
> This makes the SMP_TWD clock .setup()/.stop() pair reentrant by
> not re-fetching the clk and re-registering the clock event every
> time .setup() is called. We also make sure to call the
> clk_enable()/clk_disable() pair on subsequent calls.
> 
> As it has been brought to my knowledge that this pair is going
> to be called from atomic contexts for CPU clusters coming and
> going, the clk_prepare()/clk_unprepare() calls cannot be called
> on subsequent .setup()/.stop() iterations.
> 
> The patch assumes that the code will make sure that
> twd_set_mode() is called through .set_mode() on the clock
> event *after* the .setup() call, so that the timer registers
> are fully re-programmed after a new .setup() cycle.
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Reported-by: Peter Chen <peter.chen@freescale.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Peter/Shawn: can you please respond with a Tested-by from your
> system(s) to indicate if this works as expected?

I have seen two problems with the patch.

1. twd_timer_setup() is called on per-cpu path, and initial_setup_called
   should be a per-cpu variable.

2. When secondary cores get off-line, the clockevent devices for
   the cores will be released.  So when they become online, the
   clockevent devices should be registered again.

I can only have my system work as expected with the following changes.

Shawn

8<----

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 5c2d85b..b826bf0 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -31,7 +31,7 @@ static void __iomem *twd_base;

 static struct clk *twd_clk;
 static unsigned long twd_timer_rate;
-static bool initial_setup_called;
+static DEFINE_PER_CPU(bool, initial_setup_called);

 static struct clock_event_device __percpu **twd_evt;
 static int twd_ppi;
@@ -275,20 +275,22 @@ static struct clk *twd_get_clock(void)
 static int __cpuinit twd_timer_setup(struct clock_event_device *clk)
 {
        struct clock_event_device **this_cpu_clk;
+       int cpu = smp_processor_id();

        /*
         * If the basic setup has been done before, don't bother
         * with yet again looking up the clock and register the clock
         * source.
         */
-       if (initial_setup_called) {
+       if (per_cpu(initial_setup_called, cpu)) {
                if (!IS_ERR(twd_clk))
                        clk_enable(twd_clk);
                __raw_writel(0, twd_base + TWD_TIMER_CONTROL);
+               clockevents_register_device(*__this_cpu_ptr(twd_evt));
                enable_percpu_irq(clk->irq, 0);
                return 0;
        }
-       initial_setup_called = true;
+       per_cpu(initial_setup_called, cpu) = true;

        twd_clk = twd_get_clock();
