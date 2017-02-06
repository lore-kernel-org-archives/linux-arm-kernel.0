From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Tue,  7 Feb 2017 02:50:03 +0800
Subject: [PATCH v21 01/13] clocksource: arm_arch_timer: introduce two
 functions to get the frequency from mmio and sysreg.
In-Reply-To: <20170206185015.12296-1-fu.wei@linaro.org>
References: <20170206185015.12296-1-fu.wei@linaro.org>
Message-ID: <20170206185015.12296-2-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

The patch introduce two new functions: arch_timer_get_sysreg_freq and
arch_timer_get_mmio_freq, and applys them in arch_timer_detect_rate.
These will be used for getting the frequency from mmio and sysreg to
prepare for reworking counter frequency detection.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 46a1709..1d273d6 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -554,6 +554,23 @@ static int arch_timer_starting_cpu(unsigned int cpu)
 	return 0;
 }
 
+static u32 arch_timer_get_sysreg_freq(void)
+{
+	/*
+	 * Try to get the frequency from the CNTFRQ of sysreg.
+	 */
+	return arch_timer_get_cntfrq();
+}
+
+static u32 arch_timer_get_mmio_freq(void __iomem *cntbase)
+{
+	/*
+	 * Try to get the frequency from the CNTFRQ of timer frame registers.
+	 * Note: please verify cntbase in caller.
+	 */
+	return readl_relaxed(cntbase + CNTFRQ);
+}
+
 static void
 arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
 {
@@ -568,9 +585,9 @@ arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
 	if (!acpi_disabled ||
 	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate)) {
 		if (cntbase)
-			arch_timer_rate = readl_relaxed(cntbase + CNTFRQ);
+			arch_timer_rate = arch_timer_get_mmio_freq(cntbase);
 		else
-			arch_timer_rate = arch_timer_get_cntfrq();
+			arch_timer_rate = arch_timer_get_sysreg_freq();
 	}
 
 	/* Check the timer frequency. */
-- 
2.9.3
