From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Wed, 22 Mar 2017 00:31:12 +0800
Subject: [PATCH v22 01/11] clocksource: arm_arch_timer: introduce a wrapper
 function to get the frequency from mmio.
In-Reply-To: <20170321163122.9183-1-fu.wei@linaro.org>
References: <20170321163122.9183-1-fu.wei@linaro.org>
Message-ID: <20170321163122.9183-2-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

The patch introduce a new functions: arch_timer_mem_get_cntfrq, and applies
it in arch_timer_detect_rate.
This function will be used for getting the frequency from mmio to prepare
for reworking counter frequency detection.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 3faed19..843f923 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -555,6 +555,11 @@ static int arch_timer_starting_cpu(unsigned int cpu)
 	return 0;
 }
 
+static u32 arch_timer_mem_get_cntfrq(void __iomem *cntbase)
+{
+	return readl_relaxed(cntbase + CNTFRQ);
+}
+
 static void
 arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
 {
@@ -569,7 +574,7 @@ arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
 	if (!acpi_disabled ||
 	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate)) {
 		if (cntbase)
-			arch_timer_rate = readl_relaxed(cntbase + CNTFRQ);
+			arch_timer_rate = arch_timer_mem_get_cntfrq(cntbase);
 		else
 			arch_timer_rate = arch_timer_get_cntfrq();
 	}
-- 
2.9.3
