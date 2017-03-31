From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Sat,  1 Apr 2017 01:50:56 +0800
Subject: [PATCH v23 02/11] clocksource: arm_arch_timer: split dt-only rate
 handling
In-Reply-To: <20170331175105.8370-1-fu.wei@linaro.org>
References: <20170331175105.8370-1-fu.wei@linaro.org>
Message-ID: <20170331175105.8370-3-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

Currently Currently arch_timer_detect_rate() tried to handle both the
sysreg timer and MMIO timer, with DT-specific fallback code. This gets
in the way of implementing deterministic and correct rate probing when
using ACPI.

This patch moves this logic out into the (DT-specific) probe functions,
allowing different logic to be used in the ACPI case, and making it
easier to see which CNTFRQ register is being read in each case.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
[Mark: reword commit message, TODO: rework comments]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 58 +++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 843f923..1b6a7e6 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -560,30 +560,6 @@ static u32 arch_timer_mem_get_cntfrq(void __iomem *cntbase)
 	return readl_relaxed(cntbase + CNTFRQ);
 }
 
-static void
-arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
-{
-	/* Who has more than one independent system counter? */
-	if (arch_timer_rate)
-		return;
-
-	/*
-	 * Try to determine the frequency from the device tree or CNTFRQ,
-	 * if ACPI is enabled, get the frequency from CNTFRQ ONLY.
-	 */
-	if (!acpi_disabled ||
-	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate)) {
-		if (cntbase)
-			arch_timer_rate = arch_timer_mem_get_cntfrq(cntbase);
-		else
-			arch_timer_rate = arch_timer_get_cntfrq();
-	}
-
-	/* Check the timer frequency. */
-	if (arch_timer_rate == 0)
-		pr_warn("frequency not available\n");
-}
-
 static void arch_timer_banner(unsigned type)
 {
 	pr_info("%s%s%s timer(s) running at %lu.%02luMHz (%s%s%s).\n",
@@ -958,7 +934,17 @@ static int __init arch_timer_of_init(struct device_node *np)
 	for (i = ARCH_TIMER_PHYS_SECURE_PPI; i < ARCH_TIMER_MAX_TIMER_PPI; i++)
 		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
 
-	arch_timer_detect_rate(NULL, np);
+	/*
+	 * Determine the frequency of system counter:
+	 * Try to get the frequency from the device tree.
+	 * If fail, try the sysreg CNTFRQ. Then verify the frequency.
+	 */
+	if (of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
+		arch_timer_rate = arch_timer_get_cntfrq();
+	if (!arch_timer_rate) {
+		pr_err(FW_BUG "frequency not available.\n");
+		return -EINVAL;
+	}
 
 	arch_timer_c3stop = !of_property_read_bool(np, "always-on");
 
@@ -1069,7 +1055,19 @@ static int __init arch_timer_mem_init(struct device_node *np)
 		goto out;
 	}
 
-	arch_timer_detect_rate(base, np);
+	/*
+	 * Try to determine the frequency from the device tree,
+	 * if fail, get the frequency from the CNTFRQ reg of MMIO timer.
+	 */
+	if (!arch_timer_rate &&
+	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
+		arch_timer_rate = arch_timer_mem_get_cntfrq(base);
+	if (!arch_timer_rate) {
+		pr_err(FW_BUG "MMIO frequency not available.\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
 	ret = arch_timer_mem_register(base, irq);
 	if (ret)
 		goto out;
@@ -1130,8 +1128,12 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 		map_generic_timer_interrupt(gtdt->non_secure_el2_interrupt,
 		gtdt->non_secure_el2_flags);
 
-	/* Get the frequency from CNTFRQ */
-	arch_timer_detect_rate(NULL, NULL);
+	/* Get the frequency from the sysreg CNTFRQ */
+	arch_timer_rate = arch_timer_get_cntfrq();
+	if (!arch_timer_rate) {
+		pr_err(FW_BUG "frequency not available.\n");
+		return -EINVAL;
+	}
 
 	arch_timer_uses_ppi = arch_timer_select_ppi();
 	if (!arch_timer_ppi[arch_timer_uses_ppi]) {
-- 
2.9.3
