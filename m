From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 16 Mar 2012 17:49:41 +1100
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20120316174941.40421ba160741a0f6aab6611@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-msm/timer.c between commit f8e56c42e4e3 ("msm: timer:
Support sched_clock()") from the arm tree and commit 5ca709c16d0f ("ARM:
local timers: convert MSM to runtime registration interface") from the
arm-soc tree.

I fixed it up (see below) and can carry the fax as necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-msm/timer.c
index 61983da,75f4be4..0000000
--- a/arch/arm/mach-msm/timer.c
+++ b/arch/arm/mach-msm/timer.c
@@@ -128,11 -127,45 +128,50 @@@ static struct clocksource msm_clocksour
  	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
  };
  
 +static notrace u32 msm_sched_clock_read(void)
 +{
 +	return msm_clocksource.read(&msm_clocksource);
 +}
 +
+ #ifdef CONFIG_LOCAL_TIMERS
+ static int __cpuinit msm_local_timer_setup(struct clock_event_device *evt)
+ {
+ 	/* Use existing clock_event for cpu 0 */
+ 	if (!smp_processor_id())
+ 		return 0;
+ 
+ 	writel_relaxed(0, event_base + TIMER_ENABLE);
+ 	writel_relaxed(0, event_base + TIMER_CLEAR);
+ 	writel_relaxed(~0, event_base + TIMER_MATCH_VAL);
+ 	evt->irq = msm_clockevent.irq;
+ 	evt->name = "local_timer";
+ 	evt->features = msm_clockevent.features;
+ 	evt->rating = msm_clockevent.rating;
+ 	evt->set_mode = msm_timer_set_mode;
+ 	evt->set_next_event = msm_timer_set_next_event;
+ 	evt->shift = msm_clockevent.shift;
+ 	evt->mult = div_sc(GPT_HZ, NSEC_PER_SEC, evt->shift);
+ 	evt->max_delta_ns = clockevent_delta2ns(0xf0000000, evt);
+ 	evt->min_delta_ns = clockevent_delta2ns(4, evt);
+ 
+ 	*__this_cpu_ptr(msm_evt.percpu_evt) = evt;
+ 	clockevents_register_device(evt);
+ 	enable_percpu_irq(evt->irq, 0);
+ 	return 0;
+ }
+ 
+ static void msm_local_timer_stop(struct clock_event_device *evt)
+ {
+ 	evt->set_mode(CLOCK_EVT_MODE_UNUSED, evt);
+ 	disable_percpu_irq(evt->irq);
+ }
+ 
+ static struct local_timer_ops msm_local_timer_ops __cpuinitdata = {
+ 	.setup	= msm_local_timer_setup,
+ 	.stop	= msm_local_timer_stop,
+ };
+ #endif /* CONFIG_LOCAL_TIMERS */
+ 
  static void __init msm_timer_init(void)
  {
  	struct clock_event_device *ce = &msm_clockevent;
@@@ -195,44 -232,8 +238,10 @@@ err
  	res = clocksource_register_hz(cs, dgt_hz);
  	if (res)
  		pr_err("clocksource_register failed\n");
 +	setup_sched_clock(msm_sched_clock_read,
 +			cpu_is_msm7x01() ? 32 - MSM_DGT_SHIFT : 32, dgt_hz);
  }
  
- #ifdef CONFIG_LOCAL_TIMERS
- int __cpuinit local_timer_setup(struct clock_event_device *evt)
- {
- 	/* Use existing clock_event for cpu 0 */
- 	if (!smp_processor_id())
- 		return 0;
- 
- 	writel_relaxed(0, event_base + TIMER_ENABLE);
- 	writel_relaxed(0, event_base + TIMER_CLEAR);
- 	writel_relaxed(~0, event_base + TIMER_MATCH_VAL);
- 	evt->irq = msm_clockevent.irq;
- 	evt->name = "local_timer";
- 	evt->features = msm_clockevent.features;
- 	evt->rating = msm_clockevent.rating;
- 	evt->set_mode = msm_timer_set_mode;
- 	evt->set_next_event = msm_timer_set_next_event;
- 	evt->shift = msm_clockevent.shift;
- 	evt->mult = div_sc(GPT_HZ, NSEC_PER_SEC, evt->shift);
- 	evt->max_delta_ns = clockevent_delta2ns(0xf0000000, evt);
- 	evt->min_delta_ns = clockevent_delta2ns(4, evt);
- 
- 	*__this_cpu_ptr(msm_evt.percpu_evt) = evt;
- 	clockevents_register_device(evt);
- 	enable_percpu_irq(evt->irq, 0);
- 	return 0;
- }
- 
- void local_timer_stop(struct clock_event_device *evt)
- {
- 	evt->set_mode(CLOCK_EVT_MODE_UNUSED, evt);
- 	disable_percpu_irq(evt->irq);
- }
- #endif /* CONFIG_LOCAL_TIMERS */
- 
  struct sys_timer msm_timer = {
  	.init = msm_timer_init
  };
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120316/09540dd9/attachment.sig>
