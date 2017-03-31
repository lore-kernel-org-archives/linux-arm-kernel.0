From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Sat,  1 Apr 2017 01:50:59 +0800
Subject: [PATCH v23 05/11] clocksource: arm_arch_timer: add structs to
 describe MMIO timer
In-Reply-To: <20170331175105.8370-1-fu.wei@linaro.org>
References: <20170331175105.8370-1-fu.wei@linaro.org>
Message-ID: <20170331175105.8370-6-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

In preparation for ACPI GTDT support, this patch adds structs to
describe the MMIO timers indepedent of the firmware interface.

Subsequent patches will use these to split the FW/HW probing logic, so
that the HW probing logic can be shared by ACPI and DT.

[Mark: reword commit message]

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 include/clocksource/arm_arch_timer.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index 4a98c06..cc805b7 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -57,6 +57,8 @@ enum arch_timer_spi_nr {
 #define ARCH_TIMER_MEM_PHYS_ACCESS	2
 #define ARCH_TIMER_MEM_VIRT_ACCESS	3
 
+#define ARCH_TIMER_MEM_MAX_FRAMES	8
+
 #define ARCH_TIMER_USR_PCT_ACCESS_EN	(1 << 0) /* physical counter */
 #define ARCH_TIMER_USR_VCT_ACCESS_EN	(1 << 1) /* virtual counter */
 #define ARCH_TIMER_VIRT_EVT_EN		(1 << 2)
@@ -72,6 +74,20 @@ struct arch_timer_kvm_info {
 	int virtual_irq;
 };
 
+struct arch_timer_mem_frame {
+	bool valid;
+	phys_addr_t cntbase;
+	size_t size;
+	int phys_irq;
+	int virt_irq;
+};
+
+struct arch_timer_mem {
+	phys_addr_t cntctlbase;
+	size_t size;
+	struct arch_timer_mem_frame frame[ARCH_TIMER_MEM_MAX_FRAMES];
+};
+
 #ifdef CONFIG_ARM_ARCH_TIMER
 
 extern u32 arch_timer_get_rate(void);
-- 
2.9.3
