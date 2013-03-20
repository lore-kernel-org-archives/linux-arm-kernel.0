From: b20788@freescale.com (Anson Huang)
Date: Wed, 20 Mar 2013 19:39:43 -0400
Subject: [PATCH V2 2/3] ARM: imx: enable periphery well bias for suspend
In-Reply-To: <1363822784-12700-1-git-send-email-b20788@freescale.com>
References: <1363822784-12700-1-git-send-email-b20788@freescale.com>
Message-ID: <1363822784-12700-2-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable periphery charge pump for well biasing
at suspend to reduce periphery leakage.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/mach-imx/clk-imx6q.c |   30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 2f9ff93..96ed9a3 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -1,5 +1,5 @@
 /*
- * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011-2013 Freescale Semiconductor, Inc.
  * Copyright 2011 Linaro Ltd.
  *
  * The code contained herein is licensed under the GNU General Public
@@ -23,6 +23,9 @@
 #include "clk.h"
 #include "common.h"
 
+#define CCR				0x0
+#define BM_CCR_WB_COUNT			(0x7 << 16)
+
 #define CCGR0				0x68
 #define CCGR1				0x6c
 #define CCGR2				0x70
@@ -67,6 +70,29 @@ void imx6q_set_chicken_bit(void)
 	writel_relaxed(val, ccm_base + CGPR);
 }
 
+static void imx6q_enable_wb(bool enable)
+{
+	u32 val;
+	static bool last_wb_mode;
+
+	if (last_wb_mode == enable)
+		return;
+
+	/* configure well bias enable bit */
+	val = readl_relaxed(ccm_base + CLPCR);
+	val &= ~BM_CLPCR_WB_PER_AT_LPM;
+	val |= enable ? BM_CLPCR_WB_PER_AT_LPM : 0;
+	writel_relaxed(val, ccm_base + CLPCR);
+
+	/* configure well bias count */
+	val = readl_relaxed(ccm_base + CCR);
+	val &= ~BM_CCR_WB_COUNT;
+	val |= enable ? BM_CCR_WB_COUNT : 0;
+	writel_relaxed(val, ccm_base + CCR);
+
+	last_wb_mode = enable;
+}
+
 int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 {
 	u32 val = readl_relaxed(ccm_base + CLPCR);
@@ -74,6 +100,7 @@ int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 	val &= ~BM_CLPCR_LPM;
 	switch (mode) {
 	case WAIT_CLOCKED:
+		imx6q_enable_wb(false);
 		break;
 	case WAIT_UNCLOCKED:
 		val |= 0x1 << BP_CLPCR_LPM;
@@ -92,6 +119,7 @@ int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 		val |= 0x3 << BP_CLPCR_STBY_COUNT;
 		val |= BM_CLPCR_VSTBY;
 		val |= BM_CLPCR_SBYOS;
+		imx6q_enable_wb(true);
 		break;
 	default:
 		return -EINVAL;
-- 
1.7.9.5
