From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 25 Aug 2014 16:30:24 +0900
Subject: [PATCHv4 3/4] thermal: exynos: Add support for TRIM_RELOAD feature at
 Exynos3250
In-Reply-To: <1408951825-2639-1-git-send-email-cw00.choi@samsung.com>
References: <1408951825-2639-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1408951825-2639-4-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add support for TRIM_RELOAD feature at Exynos3250. The TMu of
Exynos3250 has two TRIMINFO_CON register and must need to set RELOAD bit
before reading TRIMINFO register.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
Reviewed-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu_data.c | 11 +++++++++--
 drivers/thermal/samsung/exynos_tmu_data.h |  7 +++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
index 754c638..4006eb4 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.c
+++ b/drivers/thermal/samsung/exynos_tmu_data.c
@@ -95,6 +95,11 @@ static const struct exynos_tmu_registers exynos3250_tmu_registers = {
 	.triminfo_data = EXYNOS_TMU_REG_TRIMINFO,
 	.triminfo_25_shift = EXYNOS_TRIMINFO_25_SHIFT,
 	.triminfo_85_shift = EXYNOS_TRIMINFO_85_SHIFT,
+	.triminfo_ctrl[0] = EXYNOS_TMU_TRIMINFO_CON1,
+	.triminfo_ctrl[1] = EXYNOS_TMU_TRIMINFO_CON2,
+	.triminfo_ctrl_count = 2,
+	.triminfo_reload_shift = EXYNOS_TRIMINFO_RELOAD_SHIFT,
+	.triminfo_reload_mask = EXYNOS_TRIMINFO_RELOAD_MASK,
 	.tmu_ctrl = EXYNOS_TMU_REG_CONTROL,
 	.test_mux_addr_shift = EXYNOS4412_MUX_ADDR_SHIFT,
 	.buf_vref_sel_shift = EXYNOS_TMU_REF_VOLTAGE_SHIFT,
@@ -161,7 +166,9 @@ static const struct exynos_tmu_registers exynos3250_tmu_registers = {
 	}, \
 	.freq_tab_count = 2, \
 	.registers = &exynos3250_tmu_registers, \
-	.features = (TMU_SUPPORT_EMULATION | \
+	.triminfo_reload[0] = EXYNOS_TRIMINFO_RELOAD_ENABLE, \
+	.triminfo_reload[1] = EXYNOS_TRIMINFO_RELOAD_ENABLE, \
+	.features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_TRIM_RELOAD | \
 			TMU_SUPPORT_FALLING_TRIP | TMU_SUPPORT_READY_STATUS | \
 			TMU_SUPPORT_EMUL_TIME)
 #endif
@@ -184,7 +191,7 @@ static const struct exynos_tmu_registers exynos4412_tmu_registers = {
 	.triminfo_data = EXYNOS_TMU_REG_TRIMINFO,
 	.triminfo_25_shift = EXYNOS_TRIMINFO_25_SHIFT,
 	.triminfo_85_shift = EXYNOS_TRIMINFO_85_SHIFT,
-	.triminfo_ctrl[0] = EXYNOS_TMU_TRIMINFO_CON,
+	.triminfo_ctrl[0] = EXYNOS_TMU_TRIMINFO_CON2,
 	.triminfo_ctrl_count = 1,
 	.triminfo_reload_shift = EXYNOS_TRIMINFO_RELOAD_SHIFT,
 	.triminfo_reload_mask = EXYNOS_TRIMINFO_RELOAD_MASK,
diff --git a/drivers/thermal/samsung/exynos_tmu_data.h b/drivers/thermal/samsung/exynos_tmu_data.h
index 87454f63..f62fdde 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.h
+++ b/drivers/thermal/samsung/exynos_tmu_data.h
@@ -57,8 +57,11 @@
 #define EXYNOS4210_TMU_TRIG_LEVEL_MASK	0x1111
 #define EXYNOS4210_TMU_INTCLEAR_VAL	0x1111
 
-/* Exynos5250 and Exynos4412 specific registers */
-#define EXYNOS_TMU_TRIMINFO_CON	0x14
+/*  Exynos3250 specific registers */
+#define EXYNOS_TMU_TRIMINFO_CON1	0x10
+
+/* Exynos5250 ,Exynos4412 and Exynos3250 specific registers */
+#define EXYNOS_TMU_TRIMINFO_CON2	0x14
 #define EXYNOS_THD_TEMP_RISE		0x50
 #define EXYNOS_THD_TEMP_FALL		0x54
 #define EXYNOS_EMUL_CON		0x80
-- 
1.8.0
