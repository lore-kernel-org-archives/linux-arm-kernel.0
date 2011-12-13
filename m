From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 13 Dec 2011 12:24:57 +0100
Subject: [PATCH 3/4 v2] ARM: smp_twd: get the rate from a clock
Message-ID: <1323775497-28218-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This break-out from Colin Cross' cpufreq-aware TWD patch will
optionally retrieve the clock rate of the TWD from an external
clock. A variant of this patch has been proposed by Rob Herring
as well.

The basic idea is to avoid recalibrating the rate of the clock
at boot if the platform already know what rate the clock to the
TWD block has.

ChangeLog v1->v2: added clk_[prepare|unprepare] calls.

Signed-off-by: Colin Cross <ccross@android.com>
Cc: Russell King <linux@arm.linux.org.uk>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rob Herring <rob.herring@calxeda.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
[Broke out of larger SMP TWD patch]
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/smp_twd.c |   40 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 39 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 20cce4e..8327989 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -10,8 +10,10 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/smp.h>
 #include <linux/jiffies.h>
 #include <linux/clockchips.h>
@@ -26,6 +28,7 @@
 /* set up by the platform code */
 void __iomem *twd_base;
 
+static struct clk *twd_clk;
 static unsigned long twd_timer_rate;
 static DEFINE_PER_CPU(struct clock_event_device *, twd_ce);
 
@@ -142,6 +145,35 @@ static irqreturn_t twd_handler(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
+static struct clk *twd_get_clock(void)
+{
+	struct clk *clk;
+	int err;
+
+	clk = clk_get_sys("smp_twd", NULL);
+	if (IS_ERR(clk)) {
+		pr_err("smp_twd: clock not found: %d\n", (int)PTR_ERR(clk));
+		return clk;
+	}
+
+	err = clk_prepare(clk);
+	if (err) {
+		pr_err("smp_twd: clock failed to prepare: %d\n", err);
+		clk_put(clk);
+		return ERR_PTR(err);
+	}
+
+	err = clk_enable(clk);
+	if (err) {
+		pr_err("smp_twd: clock failed to enable: %d\n", err);
+		clk_unprepare(clk);
+		clk_put(clk);
+		return ERR_PTR(err);
+	}
+
+	return clk;
+}
+
 /*
  * Setup the local clock events for a CPU.
  */
@@ -167,7 +199,13 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 		}
 	}
 
-	twd_calibrate_rate();
+	if (!twd_clk)
+		twd_clk = twd_get_clock();
+
+	if (!IS_ERR_OR_NULL(twd_clk))
+		twd_timer_rate = clk_get_rate(twd_clk);
+	else
+		twd_calibrate_rate();
 
 	clk->name = "local_timer";
 	clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
-- 
1.7.3.2
