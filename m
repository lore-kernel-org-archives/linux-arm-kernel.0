From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Wed, 22 Mar 2017 00:31:16 +0800
Subject: [PATCH v22 05/11] clocksource: arm_arch_timer: introduce some new
 structs to prepare for GTDT
In-Reply-To: <20170321163122.9183-1-fu.wei@linaro.org>
References: <20170321163122.9183-1-fu.wei@linaro.org>
Message-ID: <20170321163122.9183-6-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

The patch introduce two new structs: arch_timer_mem, arch_timer_mem_frame.
And also introduce a new define: ARCH_TIMER_MEM_MAX_FRAMES

These will be used for refactoring the memory-mapped timer init code to
prepare for GTDT

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 include/clocksource/arm_arch_timer.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index 4a98c06..b7dd185 100644
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
@@ -72,6 +74,21 @@ struct arch_timer_kvm_info {
 	int virtual_irq;
 };
 
+struct arch_timer_mem_frame {
+	int frame_nr;
+	phys_addr_t cntbase;
+	size_t size;
+	int phys_irq;
+	int virt_irq;
+};
+
+struct arch_timer_mem {
+	phys_addr_t cntctlbase;
+	size_t size;
+	int num_frames;
+	struct arch_timer_mem_frame frame[ARCH_TIMER_MEM_MAX_FRAMES];
+};
+
 #ifdef CONFIG_ARM_ARCH_TIMER
 
 extern u32 arch_timer_get_rate(void);
-- 
2.9.3
