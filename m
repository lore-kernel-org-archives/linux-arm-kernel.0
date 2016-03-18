From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Fri, 18 Mar 2016 16:00:49 +0800
Subject: [RESEND PATCH v4 1/5] clocksource: move some enums and marcos to
 header file for arm_arch_timer
In-Reply-To: <1458288053-29031-1-git-send-email-fu.wei@linaro.org>
References: <1458288053-29031-1-git-send-email-fu.wei@linaro.org>
Message-ID: <1458288053-29031-2-git-send-email-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

The patch sorts out the code for arm_arch_timer:
    (1)move enum ppi_nr to the header file
    (2)move "ARCH_*_TIMER" marcos to the header file
    (3)add enum spi_nr in the header file, and use it in the driver
    (4)add ARCH_WD_TIMER and ARCH_TIMER_MEM_MAX_FRAME marcos

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 15 ++-------------
 include/clocksource/arm_arch_timer.h | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 5152b38..11744c0 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -48,8 +48,6 @@
 #define CNTV_TVAL	0x38
 #define CNTV_CTL	0x3c
 
-#define ARCH_CP15_TIMER	BIT(0)
-#define ARCH_MEM_TIMER	BIT(1)
 static unsigned arch_timers_present __initdata;
 
 static void __iomem *arch_counter_base;
@@ -62,15 +60,6 @@ struct arch_timer {
 #define to_arch_timer(e) container_of(e, struct arch_timer, evt)
 
 static u32 arch_timer_rate;
-
-enum ppi_nr {
-	PHYS_SECURE_PPI,
-	PHYS_NONSECURE_PPI,
-	VIRT_PPI,
-	HYP_PPI,
-	MAX_TIMER_PPI
-};
-
 static int arch_timer_ppi[MAX_TIMER_PPI];
 
 static struct clock_event_device __percpu *arch_timer_evt;
@@ -834,9 +823,9 @@ static void __init arch_timer_mem_init(struct device_node *np)
 	}
 
 	if (arch_timer_mem_use_virtual)
-		irq = irq_of_parse_and_map(best_frame, 1);
+		irq = irq_of_parse_and_map(best_frame, VIRT_SPI);
 	else
-		irq = irq_of_parse_and_map(best_frame, 0);
+		irq = irq_of_parse_and_map(best_frame, PHYS_SPI);
 
 	if (!irq) {
 		pr_err("arch_timer: Frame missing %s irq",
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index 25d0914..3e060fc 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -19,6 +19,10 @@
 #include <linux/timecounter.h>
 #include <linux/types.h>
 
+#define ARCH_CP15_TIMER			BIT(0)
+#define ARCH_MEM_TIMER			BIT(1)
+#define ARCH_WD_TIMER			BIT(2)
+
 #define ARCH_TIMER_CTRL_ENABLE		(1 << 0)
 #define ARCH_TIMER_CTRL_IT_MASK		(1 << 1)
 #define ARCH_TIMER_CTRL_IT_STAT		(1 << 2)
@@ -34,11 +38,27 @@ enum arch_timer_reg {
 	ARCH_TIMER_REG_TVAL,
 };
 
+enum ppi_nr {
+	PHYS_SECURE_PPI,
+	PHYS_NONSECURE_PPI,
+	VIRT_PPI,
+	HYP_PPI,
+	MAX_TIMER_PPI
+};
+
+enum spi_nr {
+	PHYS_SPI,
+	VIRT_SPI,
+	MAX_TIMER_SPI
+};
+
 #define ARCH_TIMER_PHYS_ACCESS		0
 #define ARCH_TIMER_VIRT_ACCESS		1
 #define ARCH_TIMER_MEM_PHYS_ACCESS	2
 #define ARCH_TIMER_MEM_VIRT_ACCESS	3
 
+#define ARCH_TIMER_MEM_MAX_FRAME	8
+
 #define ARCH_TIMER_USR_PCT_ACCESS_EN	(1 << 0) /* physical counter */
 #define ARCH_TIMER_USR_VCT_ACCESS_EN	(1 << 1) /* virtual counter */
 #define ARCH_TIMER_VIRT_EVT_EN		(1 << 2)
-- 
2.5.0
