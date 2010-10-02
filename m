From: robherring2@gmail.com (Rob Herring)
Date: Sat,  2 Oct 2010 09:34:46 -0500
Subject: [PATCH v2 3/3] ARM: twd_smp: add clock api support
In-Reply-To: <1286030086-25556-1-git-send-email-robherring2@gmail.com>
References: <1286030086-25556-1-git-send-email-robherring2@gmail.com>
Message-ID: <1286030086-25556-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@smooth-stone.com>

The private timer freq is currently dynamically detected
using jiffies count to determine the rate. This method adds
a delay to boot-up, so use the clock api instead to get the
clock rate.

Signed-off-by: Rob Herring <rob.herring@smooth-stone.com>
---
 arch/arm/include/asm/smp_twd.h |    1 +
 arch/arm/kernel/smp_twd.c      |   11 +++++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
index 634f357..99383d5 100644
--- a/arch/arm/include/asm/smp_twd.h
+++ b/arch/arm/include/asm/smp_twd.h
@@ -25,5 +25,6 @@ extern void __iomem *twd_base;
 void twd_timer_stop(void);
 int twd_timer_ack(void);
 void twd_timer_setup(struct clock_event_device *);
+void twd_timer_init(void __iomem *base);
 
 #endif
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 35882fb..be0983c 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -8,6 +8,8 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/clk.h>
+#include <linux/err.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
@@ -151,6 +153,15 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 	clockevents_register_device(clk);
 }
 
+void __init twd_timer_init(void __iomem *base)
+{
+	struct clk *clk = clk_get_sys("smp_twd", NULL);
+	if (!IS_ERR(clk))
+		twd_timer_rate = clk_get_rate(clk);
+
+	twd_base = base;
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 /*
  * take a local timer down
-- 
1.7.0.4
