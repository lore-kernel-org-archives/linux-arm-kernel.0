From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 9 Jul 2014 09:11:16 -0700
Subject: timers & suspend
In-Reply-To: <2489e9cb-51c2-4901-9ab5-c952877d8a9d@BL2FFO11FD057.protection.gbl>
References: <f270ad9c-9906-445d-9e9a-4d3618787455@BY2FFO11FD039.protection.gbl>
 <2489e9cb-51c2-4901-9ab5-c952877d8a9d@BL2FFO11FD057.protection.gbl>
Message-ID: <380dd2ef-160a-4683-9783-ea4f964ca730@BL2FFO11FD037.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-07-08 at 04:50PM -0700, S?ren Brinkmann wrote:
> Let me extend the audience a bit.
> 
> On Mon, 2014-06-30 at 11:39AM -0700, S?ren Brinkmann wrote:
> > Hi,
> > 
> > I'm currently working on suspend for Zynq and try to track down some
> > spurious wakes. It looks like the spurious wakes are caused by timers,
> > hence I was wondering whether there are any special requirements for
> > timer drivers when it comes to suspend support or if I just missed
> > something.
> > 
> > Zynq sets the 'IRQCHIP_MASK_ON_SUSPEND' flag, which should mask all
> > interrupts but the wake source. Reading through kernel/irq/pm.c
> > indicates, that timer interrupts get some special treatment though.
> > Therefore I implemented some suspend/resume callbacks for the
> > cadence_ttc which disable and clear the timer's interrupts when going
> > into suspend. That seems to mitigate the issue quite a bit, but I still
> > saw spurious wakes - just a lot less often.
> > Digging a little deeper revealed, the spurious wakes are caused by the
> > ARM's smp_twd timer now. Given that that driver is probably used by a few
> > more ARM platforms, I get the feeling that I'm missing something.
> > 
> > It's probably worth mentioning that the suspend state in Zynq does not
> > power off the CPU cores. It just asserts the resets on secondary cores
> > and the primary one waits in wfi.
> 
> I think I found the issue. When going into suspend, all device
> interrupts get disabled, but timers are kept running until very late.
> Then in kernel/power/suspend.c:
>  - arch_suspend_disable_irqs() disables interrupts (locally)
>  - syscore_suspend is called, which disables timers through
>    tick_suspend()
> 
> I think what happens is: The interrupts get disabled locally, but the
> timers are still running and generating interrupts.
> Such an interrupt happens and stays pending since interrupts are already
> disabled and no longer handled.
> Then, since Zynq does not power off but only goes into wfi, it
> immediately resumes due to a pending timer IRQ.
> 
> Especially with the TTC this can happen quite often since it is only
> 16 bit wide. But I also see spurious wakes caused by the twd.
> 
> Does that sound like a possible scenario?

As another data point: I don't see any spurious wakes with the changes
below.

	S?ren

---------------8<------------------8<-----------------8<----------------8<------
diff --git a/drivers/clocksource/cadence_ttc_timer.c b/drivers/clocksource/cadence_ttc_timer.c
index e0a81327e10c..3abe2d7031ed 100644
--- a/drivers/clocksource/cadence_ttc_timer.c
+++ b/drivers/clocksource/cadence_ttc_timer.c
@@ -321,6 +321,19 @@ static int ttc_rate_change_clocksource_cb(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+static void ttc_ce_suspend(struct clock_event_device *ce)
+{
+	struct ttc_timer_clockevent *ttcce = to_ttc_timer_clkevent(ce);
+
+	readl_relaxed(ttcce->ttc.base_addr + TTC_ISR_OFFSET);
+	disable_irq(ce->irq);
+}
+
+static void ttc_ce_resume(struct clock_event_device *ce)
+{
+	enable_irq(ce->irq);
+}
+
 static void __init ttc_setup_clocksource(struct clk *clk, void __iomem *base)
 {
 	struct ttc_timer_clocksource *ttccs;
@@ -428,6 +441,8 @@ static void __init ttc_setup_clockevent(struct clk *clk,
 	ttcce->ce.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
 	ttcce->ce.set_next_event = ttc_set_next_event;
 	ttcce->ce.set_mode = ttc_set_mode;
+	ttcce->ce.suspend = ttc_ce_suspend;
+	ttcce->ce.resume = ttc_ce_resume;
 	ttcce->ce.rating = 200;
 	ttcce->ce.irq = irq;
 	ttcce->ce.cpumask = cpu_possible_mask;
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 6591e26fc13f..956d40d9281f 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -264,6 +264,18 @@ static void twd_get_clock(struct device_node *np)
 	twd_timer_rate = clk_get_rate(twd_clk);
 }
 
+static void twd_suspend(struct clock_event_device *ce)
+{
+	struct clock_event_device *clk = __this_cpu_ptr(twd_evt);
+	disable_percpu_irq(clk->irq);
+}
+
+static void twd_resume(struct clock_event_device *ce)
+{
+	struct clock_event_device *clk = __this_cpu_ptr(twd_evt);
+	enable_percpu_irq(clk->irq, 0);
+}
+
 /*
  * Setup the local clock events for a CPU.
  */
@@ -300,6 +312,8 @@ static void twd_timer_setup(void)
 	clk->set_next_event = twd_set_next_event;
 	clk->irq = twd_ppi;
 	clk->cpumask = cpumask_of(cpu);
+	clk->suspend = twd_suspend;
+	clk->resume = twd_resume;
 
 	clockevents_config_and_register(clk, twd_timer_rate,
 					0xf, 0xffffffff);
