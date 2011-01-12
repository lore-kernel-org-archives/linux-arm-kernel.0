From: robherring2@gmail.com (Rob Herring)
Date: Wed, 12 Jan 2011 17:32:02 -0600
Subject: [PATCH 6/7] ARM: smp_twd: add clock api support
In-Reply-To: <1294875123-14086-1-git-send-email-robherring2@gmail.com>
References: <1294875123-14086-1-git-send-email-robherring2@gmail.com>
Message-ID: <1294875123-14086-7-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

The private timer freq is currently dynamically detected
using jiffies count to determine the rate. This method adds
a delay to boot-up, so use the clock api instead to get the
clock rate.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/include/asm/smp_twd.h |    1 +
 arch/arm/kernel/smp_twd.c      |   11 +++++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
index fed9981..6b0f591 100644
--- a/arch/arm/include/asm/smp_twd.h
+++ b/arch/arm/include/asm/smp_twd.h
@@ -24,5 +24,6 @@ extern void __iomem *twd_base;
 
 int twd_timer_ack(void);
 void twd_timer_setup(struct clock_event_device *);
+void twd_timer_init(void __iomem *base);
 
 #endif
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index dd79074..9a20729 100644
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
@@ -145,3 +147,12 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 
 	clockevents_register_device(clk);
 }
+
+void __init twd_timer_init(void __iomem *base)
+{
+	struct clk *clk = clk_get_sys("smp_twd", NULL);
+	if (!IS_ERR(clk))
+		twd_timer_rate = clk_get_rate(clk);
+
+	twd_base = base;
+}
-- 
1.7.1
