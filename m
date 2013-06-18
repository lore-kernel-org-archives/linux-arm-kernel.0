From: pavel@denx.de (Pavel Machek)
Date: Tue, 18 Jun 2013 17:02:44 +0200
Subject: [PATCH 0/2] Fix potential merge conflict for dw_apb_timer_of
In-Reply-To: <51BFABE8.5090504@linaro.org>
References: <1371514129-22801-1-git-send-email-dinguyen@altera.com>
 <51BFABE8.5090504@linaro.org>
Message-ID: <20130618150244.GC18055@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >The following 2 patches will eliminate the need for the patch in John
> >Stultz's tree. If there is to be merge of the 2 trees, then the
> >patch:
> >
> >dw_apb_timer_of.c: Remove parts that were picoxcell-specific
> >
> >can be removed from John's tree to avoid a merge-conflict.
> >
> >Based on arm-soc/for-next:
> >
> >PATCH[1/2] - Rename "dw-apb-timer-osc" and "dw-apb-timer-sp" bindings to just
> >"dw-apb-timer"
> >PATCH[2/2] - Fix user/system reporting by fixing read_sched_clock()
> 
> Pavel/Jamie: Can you take a look at these too and make sure these cover what you were doing.

[It seems like Heiko St?bner was not aware of patches in the clock
tree, so did pretty much equivalent patch.]

Dinh's changes look good to me, but

[PATCH v2 4/4] clocksource: dw_apb_timer_of: use clocksource_of_init

does not exactly look nice: (I'm sorry I did not see original series,
before it was merged to -soc.). The function counts number of times it
was called, and behaves differently in each case. It is not very
traditional kernel code at the very least.

+static int num_called;
+static void __init dw_apb_timer_init(struct device_node *timer)
 {
-       struct device_node *event_timer, *source_timer;
-
-       event_timer = of_find_matching_node(NULL, osctimer_ids);
-       if (!event_timer)
-               panic("No timer for clockevent");
-       add_clockevent(event_timer);
-       
-       source_timer = of_find_matching_node(event_timer,
osctimer_ids);
-       if (!source_timer)
-               panic("No timer for clocksource");
-       add_clocksource(source_timer);
-
-       of_node_put(source_timer);
+       switch (num_called) {
+       case 0:
+               pr_debug("%s: found clockevent timer\n", __func__);
+               add_clockevent(timer);
+               of_node_put(timer);
+               break;
+       case 1:
+               pr_debug("%s: found clocksource timer\n", __func__);
+               add_clocksource(timer);
+               of_node_put(timer);
+               init_sched_clock();
+               break;
+       default:
+               break;
+       }

-       init_sched_clock();
+       num_called++;
 }

Heiko, can you take a look at John Stultz tree? We modified this area
already... I understand you only have one timer on your silicon?

Would perhaps parameter on dw_apb_timer_init telling it what to do be
better solution? I don't like the "num_called" variable too much...

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
