From: tyler.baker@linaro.org (Tyler Baker)
Date: Tue, 31 Mar 2015 11:39:37 -0700
Subject: Build regression in next-20150331
Message-ID: <CANMBJr68RVNgVpkDohyOeH=wd=UgKBCFeuveqiUyNcQ_7vendQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas, Rafael,

I was notified this morning by the kernelci.org system that a new
build error has been detected in next-20150331[0][1][2]. It seems that
"clockevents: Remove CONFIG_GENERIC_CLOCKEVENTS_BUILD"
c9439b1d6eb4ada5c2faf3970ac0d2bc4bd20e14 is the culprit.

Initially, I reported these failures to John Stultz and his response is below.

*snip*

I suspect we either need to enable GENERIC_CLOCKEVENTS on those three
hardware types, or if that's not possible, rework the definitions.

Or something like (copy-paste whitespace corruption below.. only for
reference, don't apply):

diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 2a1563a..6da40c0 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -107,12 +107,13 @@ static inline void tick_resume_broadcast(void) { }
 static inline bool tick_resume_check_broadcast(void) { return false; }
 static inline void tick_broadcast_init(void) { }
 static inline int tick_broadcast_update_freq(struct
clock_event_device *dev, u32 freq) { return -ENODEV; }
-
+#ifdef CONFIG_GENERIC_CLOCKEVENTS
 /* Set the periodic handler in non broadcast mode */
 static inline void tick_set_periodic_handler(struct
clock_event_device *dev, int broadcast)
 {
        dev->event_handler = tick_handle_periodic;
 }
+#endif
 #endif /* !BROADCAST */

*snip*

Any chance either of you can reproduce this issue on your end?

Cheers,

Tyler

[0] http://storage.kernelci.org/next/next-20150331/arm-ep93xx_defconfig/build.log
[1] http://storage.kernelci.org/next/next-20150331/arm-ebsa110_defconfig/build.log
[2] http://storage.kernelci.org/next/next-20150331/arm-rpc_defconfig/build.log
