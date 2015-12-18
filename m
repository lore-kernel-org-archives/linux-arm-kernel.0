From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:19 +0100
Subject: [PATCH 06/69] time: Define dummy functions for the generic sched clock
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-6-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we try to compile a clocksource driver with the COMPILE_TEST option,
we can't select the GENERIC_SCHED_CLOCK because the sched_clock() symbol
will be duplicated with the one defined for the x86.

In order to fix that, we don't select the GENERIC_SCHED_CLOCK in the
driver Kconfig's file but we define some empty functions for the different
symbols in order to prevent the unresolved ones.

This patch fixes the COMPILE_TEST option for the compile test coverage for
the clocksource drivers. Without this patch, we can't add the COMPILE_TEST
option for the clocksource drivers using the GENERIC_SCHED_CLOCK.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/sched_clock.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched_clock.h b/include/linux/sched_clock.h
index efa931c..411b52e 100644
--- a/include/linux/sched_clock.h
+++ b/include/linux/sched_clock.h
@@ -10,11 +10,17 @@
 
 #ifdef CONFIG_GENERIC_SCHED_CLOCK
 extern void sched_clock_postinit(void);
-#else
-static inline void sched_clock_postinit(void) { }
-#endif
 
 extern void sched_clock_register(u64 (*read)(void), int bits,
 				 unsigned long rate);
+#else
+static inline void sched_clock_postinit(void) { }
+
+static inline void sched_clock_register(u64 (*read)(void), int bits,
+					unsigned long rate)
+{
+	;
+}
+#endif
 
 #endif
-- 
1.9.1
