From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu,  9 Feb 2012 11:07:20 +0100
Subject: [PATCH][V2] ux500 : decouple/recouple gic from the PRCMU
Message-ID: <1328782040-7786-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows to decouple and recouple the gic from the PRCMU.
This is needed to put the A9 core in retention mode with the cpuidle
driver.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/mfd/db8500-prcmu.c       |   29 +++++++++++++++++++++++++++++
 include/linux/mfd/db8500-prcmu.h |    2 ++
 include/linux/mfd/dbx500-prcmu.h |   16 ++++++++++++++++
 3 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index af8e0ef..70f39a1 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -787,6 +787,35 @@ int db8500_prcmu_set_power_state(u8 state, bool keep_ulp_clk, bool keep_ap_pll)
 	return 0;
 }
 
+#define PRCMU_A9_MASK_REQ               0x00000328
+#define PRCMU_A9_MASK_REQ_MASK          0x00000001
+#define PRCMU_GIC_DELAY                 1
+
+/* This function decouple the gic from the prcmu */
+void db8500_prcmu_gic_decouple(void)
+{
+	u32 val = readl(_PRCMU_BASE + PRCMU_A9_MASK_REQ);
+
+	/* Set bit 0 register value to 1 */
+	writel((val & ~PRCMU_A9_MASK_REQ_MASK) | PRCMU_A9_MASK_REQ_MASK,
+	       _PRCMU_BASE + PRCMU_A9_MASK_REQ);
+
+	/* Make sure the register is updated */
+	readl(_PRCMU_BASE + PRCMU_A9_MASK_REQ);
+
+	/* Wait a few cycles for the gic mask completion */
+	udelay(PRCMU_GIC_DELAY);
+}
+
+/* This function recouple the gic with the prcmu */
+void db8500_prcmu_gic_recouple(void)
+{
+	u32 val = readl(_PRCMU_BASE + PRCMU_A9_MASK_REQ);
+
+	/* Set bit 0 register value to 0 */
+	writel((val & ~PRCMU_A9_MASK_REQ_MASK), _PRCMU_BASE + PRCMU_A9_MASK_REQ);
+}
+
 /* This function should only be called while mb0_transfer.lock is held. */
 static void config_wakeups(void)
 {
diff --git a/include/linux/mfd/db8500-prcmu.h b/include/linux/mfd/db8500-prcmu.h
index 60d27f7..4a1032c 100644
--- a/include/linux/mfd/db8500-prcmu.h
+++ b/include/linux/mfd/db8500-prcmu.h
@@ -536,6 +536,8 @@ int prcmu_load_a9wdog(u8 id, u32 val);
 
 void db8500_prcmu_system_reset(u16 reset_code);
 int db8500_prcmu_set_power_state(u8 state, bool keep_ulp_clk, bool keep_ap_pll);
+void db8500_prcmu_gic_disable(void);
+void db8500_prcmu_gic_enable(void);
 void db8500_prcmu_enable_wakeups(u32 wakeups);
 int db8500_prcmu_set_epod(u16 epod_id, u8 epod_state);
 int db8500_prcmu_request_clock(u8 clock, bool enable);
diff --git a/include/linux/mfd/dbx500-prcmu.h b/include/linux/mfd/dbx500-prcmu.h
index bac942f..a5fee69 100644
--- a/include/linux/mfd/dbx500-prcmu.h
+++ b/include/linux/mfd/dbx500-prcmu.h
@@ -237,6 +237,22 @@ static inline int prcmu_set_power_state(u8 state, bool keep_ulp_clk,
 			keep_ap_pll);
 }
 
+static inline void prcmu_gic_disable(void)
+{
+	if (machine_is_u5500())
+		return;
+	else
+		return db8500_prcmu_gic_disable();
+}
+
+static inline void prcmu_gic_enable(void)
+{
+	if (machine_is_u5500())
+		return;
+	else
+		return db8500_prcmu_gic_enable();
+}
+
 static inline int prcmu_set_epod(u16 epod_id, u8 epod_state)
 {
 	if (machine_is_u5500())
-- 
1.7.5.4
