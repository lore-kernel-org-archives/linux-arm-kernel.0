From: nicstange@gmail.com (Nicolai Stange)
Date: Thu, 30 Mar 2017 22:10:21 +0200
Subject: [PATCH] clockevents/drivers/atlas7: set ->min_delta_ticks and
 ->max_delta_ticks
In-Reply-To: <20170326134403.16226-1-nicstange@gmail.com>
References: <20170326134403.16226-1-nicstange@gmail.com>
Message-ID: <20170330201022.8548-1-nicstange@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for making the clockevents core NTP correction aware,
all clockevent device drivers must set ->min_delta_ticks and
->max_delta_ticks rather than ->min_delta_ns and ->max_delta_ns: a
clockevent device's rate is going to change dynamically and thus, the
ratio of ns to ticks ceases to stay invariant.

Make the timer-atlas7 clockevent driver initialize these fields properly.

This patch alone doesn't introduce any change in functionality as the
clockevents core still looks exclusively at the (untouched) ->min_delta_ns
and ->max_delta_ns. As soon as this has changed, a followup patch will
purge the initialization of ->min_delta_ns and ->max_delta_ns from this
driver.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---

Notes:
    This prerequisite patch is part of a larger effort to feed NTP
    corrections into the clockevent devices' frequencies and thus
    avoiding their notion of time to diverge from the system's
    one. If you're interested, the current state of the whole series
    can be found at [1].
    
    If you haven't got any objections and these prerequisites get
    merged by 4.12 everywhere, I'll proceed with the remainder of
    this series in 4.13.
    
    Applicable to next-20170324 as well as to John' Stultz tree [2].
    
    [1]
      git://nicst.de/linux.git cev-freq-adj.v10.fortglx-4.12-time
      https://nicst.de/git/?p=linux.git;a=shortlog;h=refs/heads/cev-freq-adj.v10.fortglx-4.12-time
    
    [2]
      https://git.linaro.org/people/john.stultz/linux.git fortglx/4.12/time

 drivers/clocksource/timer-atlas7.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/timer-atlas7.c b/drivers/clocksource/timer-atlas7.c
index 3d8a181f0252..50300eec4a39 100644
--- a/drivers/clocksource/timer-atlas7.c
+++ b/drivers/clocksource/timer-atlas7.c
@@ -192,7 +192,9 @@ static int sirfsoc_local_timer_starting_cpu(unsigned int cpu)
 	ce->set_next_event = sirfsoc_timer_set_next_event;
 	clockevents_calc_mult_shift(ce, atlas7_timer_rate, 60);
 	ce->max_delta_ns = clockevent_delta2ns(-2, ce);
+	ce->max_delta_ticks = (unsigned long)-2;
 	ce->min_delta_ns = clockevent_delta2ns(2, ce);
+	ce->min_delta_ticks = 2;
 	ce->cpumask = cpumask_of(cpu);
 
 	action->dev_id = ce;
-- 
2.12.0
