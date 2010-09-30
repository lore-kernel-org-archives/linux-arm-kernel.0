From: robherring2@gmail.com (Rob Herring)
Date: Thu, 30 Sep 2010 17:49:12 -0500
Subject: [PATCH 3/3] ARM: twd_smp: add clock api support
In-Reply-To: <1285886952-30888-1-git-send-email-robherring2@gmail.com>
References: <1285886952-30888-1-git-send-email-robherring2@gmail.com>
Message-ID: <1285886952-30888-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@smooth-stone.com>

The private timer freq is currently dynamically detected
using jiffies count to determine the rate. This method adds
a delay to boot-up, so use the clock api instead to get the
clock rate.

Signed-off-by: Rob Herring <rob.herring@smooth-stone.com>
---
 arch/arm/include/asm/smp_twd.h |    2 ++
 arch/arm/kernel/smp_twd.c      |    7 +++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
index 634f357..bafad52 100644
--- a/arch/arm/include/asm/smp_twd.h
+++ b/arch/arm/include/asm/smp_twd.h
@@ -19,11 +19,13 @@
 #define TWD_TIMER_CONTROL_IT_ENABLE	(1 << 2)
 
 struct clock_event_device;
+struct clk;
 
 extern void __iomem *twd_base;
 
 void twd_timer_stop(void);
 int twd_timer_ack(void);
 void twd_timer_setup(struct clock_event_device *);
+void twd_timer_init(void __iomem *base, struct clk *clk);
 
 #endif
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 35882fb..1a3c959 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -17,6 +17,7 @@
 #include <linux/clockchips.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/clk.h>
 
 #include <asm/smp_twd.h>
 #include <asm/hardware/gic.h>
@@ -151,6 +152,12 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 	clockevents_register_device(clk);
 }
 
+void __init twd_timer_init(void __iomem *base, struct clk *clk)
+{
+	twd_base = base;
+	twd_timer_rate = clk_get_rate(clk);
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 /*
  * take a local timer down
-- 
1.7.0.4
