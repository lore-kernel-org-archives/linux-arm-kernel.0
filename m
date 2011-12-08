From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 8 Dec 2011 09:28:33 +0800
Subject: [PATCH V2 1/2] ARM: mx51/53: correct misuse of _clk_max_enable and
 _clk_max_disable
In-Reply-To: <1323307714-21290-1-git-send-email-richard.zhao@linaro.org>
References: <1323307714-21290-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1323307714-21290-2-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

_clk_max_enable and _clk_max_disable should only be used by ahb_max_clk,
rather not unrelated clocks.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/mach-imx/clock-mx51-mx53.c |   40 +++++++++++++++++-----------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-imx/clock-mx51-mx53.c b/arch/arm/mach-imx/clock-mx51-mx53.c
index 0847050..716533b 100644
--- a/arch/arm/mach-imx/clock-mx51-mx53.c
+++ b/arch/arm/mach-imx/clock-mx51-mx53.c
@@ -1013,7 +1013,7 @@ static struct clk mipi_hsp_clk = {
 		.secondary	= s,			\
 	}
 
-#define DEFINE_CLOCK_MAX(name, i, er, es, pfx, p, s)	\
+#define DEFINE_CLOCK_ESDHC(name, i, er, es, pfx, p, s)	\
 	static struct clk name = {			\
 		.id		= i,			\
 		.enable_reg	= er,			\
@@ -1021,8 +1021,8 @@ static struct clk mipi_hsp_clk = {
 		.get_rate	= pfx##_get_rate,	\
 		.set_rate	= pfx##_set_rate,	\
 		.set_parent	= pfx##_set_parent,	\
-		.enable		= _clk_max_enable,	\
-		.disable	= _clk_max_disable,	\
+		.enable		= _clk_ccgr_enable,	\
+		.disable	= _clk_ccgr_disable,	\
 		.parent		= p,			\
 		.secondary	= s,			\
 	}
@@ -1341,18 +1341,18 @@ DEFINE_CLOCK(sdma_clk, 1, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG15_OFFSET,
 
 /* eSDHC */
 DEFINE_CLOCK_FULL(esdhc1_ipg_clk, 0, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG0_OFFSET,
-	NULL,  NULL, _clk_max_enable, _clk_max_disable, &ipg_clk, NULL);
-DEFINE_CLOCK_MAX(esdhc1_clk, 0, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG1_OFFSET,
+	NULL,  NULL, _clk_ccgr_enable, _clk_ccgr_disable, &ipg_clk, NULL);
+DEFINE_CLOCK_ESDHC(esdhc1_clk, 0, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG1_OFFSET,
 	clk_esdhc1, &pll2_sw_clk, &esdhc1_ipg_clk);
 DEFINE_CLOCK_FULL(esdhc2_ipg_clk, 1, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG2_OFFSET,
-	NULL,  NULL, _clk_max_enable, _clk_max_disable, &ipg_clk, NULL);
+	NULL,  NULL, _clk_ccgr_enable, _clk_ccgr_disable, &ipg_clk, NULL);
 DEFINE_CLOCK_FULL(esdhc3_ipg_clk, 2, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG4_OFFSET,
-	NULL,  NULL, _clk_max_enable, _clk_max_disable, &ipg_clk, NULL);
+	NULL,  NULL, _clk_ccgr_enable, _clk_ccgr_disable, &ipg_clk, NULL);
 DEFINE_CLOCK_FULL(esdhc4_ipg_clk, 3, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG6_OFFSET,
-	NULL,  NULL, _clk_max_enable, _clk_max_disable, &ipg_clk, NULL);
+	NULL,  NULL, _clk_ccgr_enable, _clk_ccgr_disable, &ipg_clk, NULL);
 
 /* mx51 specific */
-DEFINE_CLOCK_MAX(esdhc2_clk, 1, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG3_OFFSET,
+DEFINE_CLOCK_ESDHC(esdhc2_clk, 1, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG3_OFFSET,
 	clk_esdhc2, &pll2_sw_clk, &esdhc2_ipg_clk);
 
 static struct clk esdhc3_clk = {
@@ -1361,8 +1361,8 @@ static struct clk esdhc3_clk = {
 	.set_parent = clk_esdhc3_set_parent,
 	.enable_reg = MXC_CCM_CCGR3,
 	.enable_shift = MXC_CCM_CCGRx_CG5_OFFSET,
-	.enable  = _clk_max_enable,
-	.disable = _clk_max_disable,
+	.enable  = _clk_ccgr_enable,
+	.disable = _clk_ccgr_disable,
 	.secondary = &esdhc3_ipg_clk,
 };
 static struct clk esdhc4_clk = {
@@ -1371,8 +1371,8 @@ static struct clk esdhc4_clk = {
 	.set_parent = clk_esdhc4_set_parent,
 	.enable_reg = MXC_CCM_CCGR3,
 	.enable_shift = MXC_CCM_CCGRx_CG7_OFFSET,
-	.enable  = _clk_max_enable,
-	.disable = _clk_max_disable,
+	.enable  = _clk_ccgr_enable,
+	.disable = _clk_ccgr_disable,
 	.secondary = &esdhc4_ipg_clk,
 };
 
@@ -1383,12 +1383,12 @@ static struct clk esdhc2_mx53_clk = {
 	.set_parent = clk_esdhc2_mx53_set_parent,
 	.enable_reg = MXC_CCM_CCGR3,
 	.enable_shift = MXC_CCM_CCGRx_CG3_OFFSET,
-	.enable  = _clk_max_enable,
-	.disable = _clk_max_disable,
+	.enable  = _clk_ccgr_enable,
+	.disable = _clk_ccgr_disable,
 	.secondary = &esdhc3_ipg_clk,
 };
 
-DEFINE_CLOCK_MAX(esdhc3_mx53_clk, 2, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG5_OFFSET,
+DEFINE_CLOCK_ESDHC(esdhc3_mx53_clk, 2, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG5_OFFSET,
 	clk_esdhc3_mx53, &pll2_sw_clk, &esdhc2_ipg_clk);
 
 static struct clk esdhc4_mx53_clk = {
@@ -1397,17 +1397,17 @@ static struct clk esdhc4_mx53_clk = {
 	.set_parent = clk_esdhc4_mx53_set_parent,
 	.enable_reg = MXC_CCM_CCGR3,
 	.enable_shift = MXC_CCM_CCGRx_CG7_OFFSET,
-	.enable  = _clk_max_enable,
-	.disable = _clk_max_disable,
+	.enable  = _clk_ccgr_enable,
+	.disable = _clk_ccgr_disable,
 	.secondary = &esdhc4_ipg_clk,
 };
 
 static struct clk sata_clk = {
 	.parent = &ipg_clk,
-	.enable = _clk_max_enable,
+	.enable = _clk_ccgr_enable,
 	.enable_reg = MXC_CCM_CCGR4,
 	.enable_shift = MXC_CCM_CCGRx_CG1_OFFSET,
-	.disable = _clk_max_disable,
+	.disable = _clk_ccgr_disable,
 };
 
 static struct clk ahci_phy_clk = {
-- 
1.7.5.4
