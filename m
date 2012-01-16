From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 16 Jan 2012 13:52:37 +0000
Subject: [PATCH v3 12/15] ARM: smp_twd: remove old local timer interface
In-Reply-To: <1326721960-2224-1-git-send-email-marc.zyngier@arm.com>
References: <1326721960-2224-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1326721960-2224-13-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that all users of the previous local timer interface
have been converted to the runtime registration API, make
this interface the only one supported for this driver.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/localtimer.h |    8 --------
 arch/arm/include/asm/smp_twd.h    |    6 ------
 arch/arm/kernel/smp_twd.c         |   34 +++++-----------------------------
 3 files changed, 5 insertions(+), 43 deletions(-)

diff --git a/arch/arm/include/asm/localtimer.h b/arch/arm/include/asm/localtimer.h
index f088d63..955eed1 100644
--- a/arch/arm/include/asm/localtimer.h
+++ b/arch/arm/include/asm/localtimer.h
@@ -11,7 +11,6 @@
 #define __ASM_ARM_LOCALTIMER_H
 
 #include <linux/errno.h>
-#include <linux/interrupt.h>
 
 struct clock_event_device;
 
@@ -26,13 +25,6 @@ struct local_timer_ops {
 void percpu_timer_setup(void);
 
 #ifdef CONFIG_LOCAL_TIMERS
-
-#ifdef CONFIG_HAVE_ARM_TWD
-
-#include "smp_twd.h"
-
-#endif
-
 /*
  * Stop the local timer
  */
diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
index 23c5bc4..dae9db0 100644
--- a/arch/arm/include/asm/smp_twd.h
+++ b/arch/arm/include/asm/smp_twd.h
@@ -20,12 +20,6 @@
 
 #include <linux/ioport.h>
 
-struct clock_event_device;
-
-extern void __iomem *twd_base;
-
-int twd_timer_setup(struct clock_event_device *);
-
 struct twd_local_timer {
 	struct resource	res[2];
 };
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index d2dce64..66808c0 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -18,7 +18,7 @@
 #include <linux/smp.h>
 #include <linux/jiffies.h>
 #include <linux/clockchips.h>
-#include <linux/irq.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
@@ -28,7 +28,7 @@
 #include <asm/hardware/gic.h>
 
 /* set up by the platform code */
-void __iomem *twd_base;
+static void __iomem *twd_base;
 
 static struct clk *twd_clk;
 static unsigned long twd_timer_rate;
@@ -80,7 +80,7 @@ static int twd_set_next_event(unsigned long evt,
  * If a local timer interrupt has occurred, acknowledge and return 1.
  * Otherwise, return 0.
  */
-int twd_timer_ack(void)
+static int twd_timer_ack(void)
 {
 	if (__raw_readl(twd_base + TWD_TIMER_INTSTAT)) {
 		__raw_writel(1, twd_base + TWD_TIMER_INTSTAT);
@@ -96,11 +96,6 @@ static void twd_timer_stop(struct clock_event_device *clk)
 	disable_percpu_irq(clk->irq);
 }
 
-/* Temporary hack to be removed when all TWD users are converted to
-   the new registration interface */
-void local_timer_stop(struct clock_event_device *clk)
-	__attribute__ ((alias ("twd_timer_stop")));
-
 #ifdef CONFIG_CPU_FREQ
 
 /*
@@ -230,28 +225,10 @@ static struct clk *twd_get_clock(void)
 /*
  * Setup the local clock events for a CPU.
  */
-int __cpuinit twd_timer_setup(struct clock_event_device *clk)
+static int __cpuinit twd_timer_setup(struct clock_event_device *clk)
 {
 	struct clock_event_device **this_cpu_clk;
 
-	if (!twd_evt) {
-		int err;
-
-		twd_evt = alloc_percpu(struct clock_event_device *);
-		if (!twd_evt) {
-			pr_err("twd: can't allocate memory\n");
-			return -ENOMEM;
-		}
-
-		err = request_percpu_irq(clk->irq, twd_handler,
-					 "twd", twd_evt);
-		if (err) {
-			pr_err("twd: can't register interrupt %d (%d)\n",
-			       clk->irq, err);
-			return err;
-		}
-	}
-
 	if (!twd_clk)
 		twd_clk = twd_get_clock();
 
@@ -266,8 +243,7 @@ int __cpuinit twd_timer_setup(struct clock_event_device *clk)
 	clk->rating = 350;
 	clk->set_mode = twd_set_mode;
 	clk->set_next_event = twd_set_next_event;
-	if (!clk->irq)
-		clk->irq = twd_ppi;
+	clk->irq = twd_ppi;
 
 	this_cpu_clk = __this_cpu_ptr(twd_evt);
 	*this_cpu_clk = clk;
-- 
1.7.7.1
