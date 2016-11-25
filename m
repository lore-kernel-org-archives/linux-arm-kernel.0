From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Fri, 25 Nov 2016 16:46:09 +0800
Subject: [PATCH v17 01/15] clocksource/drivers/arm_arch_timer: Move enums and
 defines to header file
In-Reply-To: <20161125084623.22515-1-fu.wei@linaro.org>
References: <20161125084623.22515-1-fu.wei@linaro.org>
Message-ID: <20161125084623.22515-2-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

To support the arm_arch_timer via ACPI we need to share defines and enums
between the driver and the ACPI parser code.

Split out the relevant defines and enums into arm_arch_timer.h, and
change "enum ppi_nr" to "enum arch_timer_ppi_nr" to avoid the potential
name clashes.
Also switch "enum ppi_nr" to "enum arch_timer_ppi_nr" in
arm_arch_timer.c.
No functional change.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/clocksource/arm_arch_timer.c | 13 +------------
 include/clocksource/arm_arch_timer.h | 12 ++++++++++++
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 73c487d..21068be 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -51,8 +51,6 @@
 #define CNTV_TVAL	0x38
 #define CNTV_CTL	0x3c
 
-#define ARCH_CP15_TIMER	BIT(0)
-#define ARCH_MEM_TIMER	BIT(1)
 static unsigned arch_timers_present __initdata;
 
 static void __iomem *arch_counter_base;
@@ -65,20 +63,11 @@ struct arch_timer {
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
 
-static enum ppi_nr arch_timer_uses_ppi = VIRT_PPI;
+static enum arch_timer_ppi_nr arch_timer_uses_ppi = VIRT_PPI;
 static bool arch_timer_c3stop;
 static bool arch_timer_mem_use_virtual;
 
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index caedb74..557f869 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -16,9 +16,13 @@
 #ifndef __CLKSOURCE_ARM_ARCH_TIMER_H
 #define __CLKSOURCE_ARM_ARCH_TIMER_H
 
+#include <linux/bitops.h>
 #include <linux/timecounter.h>
 #include <linux/types.h>
 
+#define ARCH_CP15_TIMER			BIT(0)
+#define ARCH_MEM_TIMER			BIT(1)
+
 #define ARCH_TIMER_CTRL_ENABLE		(1 << 0)
 #define ARCH_TIMER_CTRL_IT_MASK		(1 << 1)
 #define ARCH_TIMER_CTRL_IT_STAT		(1 << 2)
@@ -34,6 +38,14 @@ enum arch_timer_reg {
 	ARCH_TIMER_REG_TVAL,
 };
 
+enum arch_timer_ppi_nr {
+	PHYS_SECURE_PPI,
+	PHYS_NONSECURE_PPI,
+	VIRT_PPI,
+	HYP_PPI,
+	MAX_TIMER_PPI
+};
+
 #define ARCH_TIMER_PHYS_ACCESS		0
 #define ARCH_TIMER_VIRT_ACCESS		1
 #define ARCH_TIMER_MEM_PHYS_ACCESS	2
-- 
2.9.3
