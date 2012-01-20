From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 20 Jan 2012 12:03:48 +0000
Subject: [PATCH v4 01/15] ARM: smp_twd: make local_timer_stop a symbol instead
 of a #define
In-Reply-To: <1327061042-14857-1-git-send-email-marc.zyngier@arm.com>
References: <1327061042-14857-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1327061042-14857-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_HAVE_ARM_TWD is selected, local_timer_stop is a #define,
while all other local timers are using a real function.

Convert it to an alias of twd_timer_stop, as it helps converting
all local timers to another internal API in a sane way.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/localtimer.h |    6 +-----
 arch/arm/include/asm/smp_twd.h    |    1 -
 arch/arm/kernel/smp_twd.c         |    7 ++++++-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/localtimer.h b/arch/arm/include/asm/localtimer.h
index c6a1842..7e1b2c5 100644
--- a/arch/arm/include/asm/localtimer.h
+++ b/arch/arm/include/asm/localtimer.h
@@ -26,17 +26,13 @@ void percpu_timer_setup(void);
 
 #include "smp_twd.h"
 
-#define local_timer_stop(c)	twd_timer_stop((c))
-
-#else
+#endif
 
 /*
  * Stop the local timer
  */
 void local_timer_stop(struct clock_event_device *);
 
-#endif
-
 /*
  * Setup a local timer interrupt for a CPU.
  */
diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
index ef9ffba9..bf8449d 100644
--- a/arch/arm/include/asm/smp_twd.h
+++ b/arch/arm/include/asm/smp_twd.h
@@ -23,6 +23,5 @@ struct clock_event_device;
 extern void __iomem *twd_base;
 
 void twd_timer_setup(struct clock_event_device *);
-void twd_timer_stop(struct clock_event_device *);
 
 #endif
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index c8e9385..95a0c14 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -87,12 +87,17 @@ int twd_timer_ack(void)
 	return 0;
 }
 
-void twd_timer_stop(struct clock_event_device *clk)
+static void twd_timer_stop(struct clock_event_device *clk)
 {
 	twd_set_mode(CLOCK_EVT_MODE_UNUSED, clk);
 	disable_percpu_irq(clk->irq);
 }
 
+/* Temporary hack to be removed when all TWD users are converted to
+   the new registration interface */
+void local_timer_stop(struct clock_event_device *clk)
+	__attribute__ ((alias ("twd_timer_stop")));
+
 #ifdef CONFIG_CPU_FREQ
 
 /*
-- 
1.7.7.1
