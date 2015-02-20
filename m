From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 20 Feb 2015 17:26:49 +0530
Subject: [PATCH] clockevents: Add (missing) default case for switch blocks
In-Reply-To: <20150220114136.GA27483@gmail.com>
References: <6291e308ab77a480c6b1732e16108c5fe6f66afa.1424412815.git.viresh.kumar@linaro.org>
 <20150220083842.GA20387@gmail.com>
 <20150220084807.GJ21418@twins.programming.kicks-ass.net>
 <20150220093659.GA23469@gmail.com>
 <20150220113753.GP5029@twins.programming.kicks-ass.net>
 <20150220114136.GA27483@gmail.com>
Message-ID: <CAKohpokmCof2P8Un+i5eOS3BQhH_pMNATH4xkbbhw5TqJFEy9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 February 2015 at 17:11, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Peter Zijlstra <peterz@infradead.org> wrote:

>> Maybe we should break that enum into two; one for devices
>> and one for the core interface and avoid the problem that
>> way.
>
> Yeah, that would do the trick.

Thanks for your suggestions. Just to confirm (before I spam lists with
patches), is
this somewhat similar to what you are looking for ?

diff --git a/include/linux/clockchips.h b/include/linux/clockchips.h
index 59af26b54d15..80b669cb836d 100644
--- a/include/linux/clockchips.h
+++ b/include/linux/clockchips.h
@@ -32,17 +32,24 @@ enum clock_event_nofitiers {
 struct clock_event_device;
 struct module;

-/* Clock event mode commands */
+/* Clock event mode commands for legacy ->set_mode(): OBSOLETE */
 enum clock_event_mode {
        CLOCK_EVT_MODE_UNUSED = 0,
        CLOCK_EVT_MODE_SHUTDOWN,
        CLOCK_EVT_MODE_PERIODIC,
        CLOCK_EVT_MODE_ONESHOT,
        CLOCK_EVT_MODE_RESUME,
-
-       /* Legacy ->set_mode() callback doesn't support below modes */
 };

+/* Clock event modes, only for core's internal use */
+enum clock_event_dev_mode {
+       CLOCK_EVT_DEV_MODE_UNUSED = 0,
+       CLOCK_EVT_DEV_MODE_SHUTDOWN,
+       CLOCK_EVT_DEV_MODE_PERIODIC,
+       CLOCK_EVT_DEV_MODE_ONESHOT,
+       CLOCK_EVT_DEV_MODE_RESUME,
+       CLOCK_EVT_DEV_MODE_ONESHOT_STOPPED,  /* This would be the new
mode which I will add later */
+};
+
 /*
  * Clock event features
  */
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 489642b08d64..16555d3db94d 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -95,14 +95,18 @@ u64 clockevent_delta2ns(unsigned long latch,
struct clock_event_device *evt)
 EXPORT_SYMBOL_GPL(clockevent_delta2ns);

 static int __clockevents_set_mode(struct clock_event_device *dev,
-                                 enum clock_event_mode mode)
+                                 enum clock_event_dev_mode mode)
 {
        /* Transition with legacy set_mode() callback */
        if (dev->set_mode) {
                /* Legacy callback doesn't support new modes */
-               if (mode > CLOCK_EVT_MODE_RESUME)
+               if (mode > CLOCK_EVT_DEV_MODE_RESUME)
                        return -ENOSYS;
-               dev->set_mode(mode, dev);
+               /*
+                * 'clock_event_dev_mode' and 'clock_event_mode' have 1-to-1
+                * mapping until *_RESUME, and so a simple cast will work.
+                */
+               dev->set_mode((enum clock_event_mode)mode, dev);
                return 0;
        }

@@ -111,29 +115,29 @@ static int __clockevents_set_mode(struct
clock_event_device *dev,

        /* Transition with new mode-specific callbacks */
        switch (mode) {
-       case CLOCK_EVT_MODE_UNUSED:
+       case CLOCK_EVT_DEV_MODE_UNUSED:
                /*
                 * This is an internal state, which is guaranteed to go from
                 * SHUTDOWN to UNUSED. No driver interaction required.
                 */
                return 0;

-       case CLOCK_EVT_MODE_SHUTDOWN:
+       case CLOCK_EVT_DEV_MODE_SHUTDOWN:
                return dev->set_mode_shutdown(dev);

-       case CLOCK_EVT_MODE_PERIODIC:
+       case CLOCK_EVT_DEV_MODE_PERIODIC:
                /* Core internal bug */
                if (!(dev->features & CLOCK_EVT_FEAT_PERIODIC))
                        return -ENOSYS;
                return dev->set_mode_periodic(dev);

-       case CLOCK_EVT_MODE_ONESHOT:
+       case CLOCK_EVT_DEV_MODE_ONESHOT:
                /* Core internal bug */
                if (!(dev->features & CLOCK_EVT_FEAT_ONESHOT))
                        return -ENOSYS;
                return dev->set_mode_oneshot(dev);

-       case CLOCK_EVT_MODE_RESUME:
+       case CLOCK_EVT_DEV_MODE_RESUME:
                /* Optional callback */
                if (dev->set_mode_resume)
                        return dev->set_mode_resume(dev);



Ofcourse, we also need to replace 'clock_event_mode' with 'clock_event_dev_mode'
and 'CLOCK_EVT_MODE_*' with 'CLOCK_EVT_DEV_MODE_*' in all core code..

--
viresh
