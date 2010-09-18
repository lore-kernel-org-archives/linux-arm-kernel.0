From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 18 Sep 2010 11:45:13 +0900
Subject: [PATCH 1/4] ARM: S5PV310: Update CMU registers for CPUFREQ
In-Reply-To: <1284777916-23257-1-git-send-email-kgene.kim@samsung.com>
References: <1284777916-23257-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1284777916-23257-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunyoung Kang <sy0816.kang@samsung.com>

This patch adds CMU(Clock Management Unit) registers for S5PV310/S5PC210
CPUFREQ driver and modifies some register names according to datasheet.

Signed-off-by: Sunyoung Kang <sy0816.kang@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv310/clock.c                   |   12 ++--
 arch/arm/mach-s5pv310/include/mach/regs-clock.h |   77 ++++++++++++++++++++++-
 2 files changed, 81 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-s5pv310/clock.c b/arch/arm/mach-s5pv310/clock.c
index 32146db..6b528fc 100644
--- a/arch/arm/mach-s5pv310/clock.c
+++ b/arch/arm/mach-s5pv310/clock.c
@@ -244,7 +244,7 @@ static struct clksrc_clk clk_mout_corebus = {
 		.id		= -1,
 	},
 	.sources	= &clkset_mout_corebus,
-	.reg_src	= { .reg = S5P_CLKSRC_CORE, .shift = 4, .size = 1 },
+	.reg_src	= { .reg = S5P_CLKSRC_DMC, .shift = 4, .size = 1 },
 };
 
 static struct clksrc_clk clk_sclk_dmc = {
@@ -253,7 +253,7 @@ static struct clksrc_clk clk_sclk_dmc = {
 		.id		= -1,
 		.parent		= &clk_mout_corebus.clk,
 	},
-	.reg_div	= { .reg = S5P_CLKDIV_CORE0, .shift = 12, .size = 3 },
+	.reg_div	= { .reg = S5P_CLKDIV_DMC0, .shift = 12, .size = 3 },
 };
 
 static struct clksrc_clk clk_aclk_cored = {
@@ -262,7 +262,7 @@ static struct clksrc_clk clk_aclk_cored = {
 		.id		= -1,
 		.parent		= &clk_sclk_dmc.clk,
 	},
-	.reg_div	= { .reg = S5P_CLKDIV_CORE0, .shift = 16, .size = 3 },
+	.reg_div	= { .reg = S5P_CLKDIV_DMC0, .shift = 16, .size = 3 },
 };
 
 static struct clksrc_clk clk_aclk_corep = {
@@ -271,7 +271,7 @@ static struct clksrc_clk clk_aclk_corep = {
 		.id		= -1,
 		.parent		= &clk_aclk_cored.clk,
 	},
-	.reg_div	= { .reg = S5P_CLKDIV_CORE0, .shift = 20, .size = 3 },
+	.reg_div	= { .reg = S5P_CLKDIV_DMC0, .shift = 20, .size = 3 },
 };
 
 static struct clksrc_clk clk_aclk_acp = {
@@ -280,7 +280,7 @@ static struct clksrc_clk clk_aclk_acp = {
 		.id		= -1,
 		.parent		= &clk_mout_corebus.clk,
 	},
-	.reg_div	= { .reg = S5P_CLKDIV_CORE0, .shift = 0, .size = 3 },
+	.reg_div	= { .reg = S5P_CLKDIV_DMC0, .shift = 0, .size = 3 },
 };
 
 static struct clksrc_clk clk_pclk_acp = {
@@ -289,7 +289,7 @@ static struct clksrc_clk clk_pclk_acp = {
 		.id		= -1,
 		.parent		= &clk_aclk_acp.clk,
 	},
-	.reg_div	= { .reg = S5P_CLKDIV_CORE0, .shift = 4, .size = 3 },
+	.reg_div	= { .reg = S5P_CLKDIV_DMC0, .shift = 4, .size = 3 },
 };
 
 /* Core list of CMU_TOP side */
diff --git a/arch/arm/mach-s5pv310/include/mach/regs-clock.h b/arch/arm/mach-s5pv310/include/mach/regs-clock.h
index 12e983c..5d0bb40 100644
--- a/arch/arm/mach-s5pv310/include/mach/regs-clock.h
+++ b/arch/arm/mach-s5pv310/include/mach/regs-clock.h
@@ -19,6 +19,12 @@
 
 #define S5P_INFORM0			S5P_CLKREG(0x800)
 
+#define S5P_CLKDIV_LEFTBUS		S5P_CLKREG(0x04500)
+#define S5P_CLKDIV_STAT_LEFTBUS		S5P_CLKREG(0x04600)
+
+#define S5P_CLKDIV_RIGHTBUS		S5P_CLKREG(0x08500)
+#define S5P_CLKDIV_STAT_RIGHTBUS	S5P_CLKREG(0x08600)
+
 #define S5P_EPLL_CON0			S5P_CLKREG(0x0C110)
 #define S5P_EPLL_CON1			S5P_CLKREG(0x0C114)
 #define S5P_VPLL_CON0			S5P_CLKREG(0x0C120)
@@ -58,6 +64,8 @@
 #define S5P_CLKSRC_MASK_PERIL0		S5P_CLKREG(0x0C350)
 #define S5P_CLKSRC_MASK_PERIL1		S5P_CLKREG(0x0C354)
 
+#define S5P_CLKDIV_STAT_TOP		S5P_CLKREG(0x0C610)
+
 #define S5P_CLKGATE_IP_CAM		S5P_CLKREG(0x0C920)
 #define S5P_CLKGATE_IP_IMAGE		S5P_CLKREG(0x0C930)
 #define S5P_CLKGATE_IP_LCD0		S5P_CLKREG(0x0C934)
@@ -66,8 +74,9 @@
 #define S5P_CLKGATE_IP_PERIL		S5P_CLKREG(0x0C950)
 #define S5P_CLKGATE_IP_PERIR		S5P_CLKREG(0x0C960)
 
-#define S5P_CLKSRC_CORE			S5P_CLKREG(0x10200)
-#define S5P_CLKDIV_CORE0		S5P_CLKREG(0x10500)
+#define S5P_CLKSRC_DMC			S5P_CLKREG(0x10200)
+#define S5P_CLKDIV_DMC0			S5P_CLKREG(0x10500)
+#define S5P_CLKDIV_STAT_DMC0		S5P_CLKREG(0x10600)
 
 #define S5P_APLL_LOCK			S5P_CLKREG(0x14000)
 #define S5P_MPLL_LOCK			S5P_CLKREG(0x14004)
@@ -84,4 +93,68 @@
 
 #define S5P_CLKGATE_SCLKCPU		S5P_CLKREG(0x14800)
 
+/* APLL_LOCK */
+#define S5P_APLL_LOCKTIME		(0x1C20)	/* 300us */
+
+/* APLL_CON0 */
+#define S5P_APLLCON0_ENABLE_SHIFT	(31)
+#define S5P_APLLCON0_LOCKED_SHIFT	(29)
+#define S5P_APLL_VAL_1000		((250 << 16) | (6 << 8) | 1)
+
+/* CLK_SRC_CPU */
+#define S5P_CLKSRC_CPU_MUXCORE_SHIFT	(16)
+#define S5P_CLKMUX_STATCPU_MUXCORE_MASK	(0x7 << S5P_CLKSRC_CPU_MUXCORE_SHIFT)
+
+/* CLKDIV_CPU0 */
+#define S5P_CLKDIV_CPU0_CORE_SHIFT	(0)
+#define S5P_CLKDIV_CPU0_CORE_MASK	(0x7 << S5P_CLKDIV_CPU0_CORE_SHIFT)
+#define S5P_CLKDIV_CPU0_COREM0_SHIFT	(4)
+#define S5P_CLKDIV_CPU0_COREM0_MASK	(0x7 << S5P_CLKDIV_CPU0_COREM0_SHIFT)
+#define S5P_CLKDIV_CPU0_COREM1_SHIFT	(8)
+#define S5P_CLKDIV_CPU0_COREM1_MASK	(0x7 << S5P_CLKDIV_CPU0_COREM1_SHIFT)
+#define S5P_CLKDIV_CPU0_PERIPH_SHIFT	(12)
+#define S5P_CLKDIV_CPU0_PERIPH_MASK	(0x7 << S5P_CLKDIV_CPU0_PERIPH_SHIFT)
+#define S5P_CLKDIV_CPU0_ATB_SHIFT	(16)
+#define S5P_CLKDIV_CPU0_ATB_MASK	(0x7 << S5P_CLKDIV_CPU0_ATB_SHIFT)
+#define S5P_CLKDIV_CPU0_PCLKDBG_SHIFT	(20)
+#define S5P_CLKDIV_CPU0_PCLKDBG_MASK	(0x7 << S5P_CLKDIV_CPU0_PCLKDBG_SHIFT)
+#define S5P_CLKDIV_CPU0_APLL_SHIFT	(24)
+#define S5P_CLKDIV_CPU0_APLL_MASK	(0x7 << S5P_CLKDIV_CPU0_APLL_SHIFT)
+
+/* CLKDIV_DMC0 */
+#define S5P_CLKDIV_DMC0_ACP_SHIFT	(0)
+#define S5P_CLKDIV_DMC0_ACP_MASK	(0x7 << S5P_CLKDIV_DMC0_ACP_SHIFT)
+#define S5P_CLKDIV_DMC0_ACPPCLK_SHIFT	(4)
+#define S5P_CLKDIV_DMC0_ACPPCLK_MASK	(0x7 << S5P_CLKDIV_DMC0_ACPPCLK_SHIFT)
+#define S5P_CLKDIV_DMC0_DPHY_SHIFT	(8)
+#define S5P_CLKDIV_DMC0_DPHY_MASK	(0x7 << S5P_CLKDIV_DMC0_DPHY_SHIFT)
+#define S5P_CLKDIV_DMC0_DMC_SHIFT	(12)
+#define S5P_CLKDIV_DMC0_DMC_MASK	(0x7 << S5P_CLKDIV_DMC0_DMC_SHIFT)
+#define S5P_CLKDIV_DMC0_DMCD_SHIFT	(16)
+#define S5P_CLKDIV_DMC0_DMCD_MASK	(0x7 << S5P_CLKDIV_DMC0_DMCD_SHIFT)
+#define S5P_CLKDIV_DMC0_DMCP_SHIFT	(20)
+#define S5P_CLKDIV_DMC0_DMCP_MASK	(0x7 << S5P_CLKDIV_DMC0_DMCP_SHIFT)
+#define S5P_CLKDIV_DMC0_COPY2_SHIFT	(24)
+#define S5P_CLKDIV_DMC0_COPY2_MASK	(0x7 << S5P_CLKDIV_DMC0_COPY2_SHIFT)
+#define S5P_CLKDIV_DMC0_CORETI_SHIFT	(28)
+#define S5P_CLKDIV_DMC0_CORETI_MASK	(0x7 << S5P_CLKDIV_DMC0_CORETI_SHIFT)
+
+/* CLKDIV_TOP */
+#define S5P_CLKDIV_TOP_ACLK200_SHIFT	(0)
+#define S5P_CLKDIV_TOP_ACLK200_MASK	(0x7 << S5P_CLKDIV_TOP_ACLK200_SHIFT)
+#define S5P_CLKDIV_TOP_ACLK100_SHIFT	(4)
+#define S5P_CLKDIV_TOP_ACLK100_MASK	(0xf << S5P_CLKDIV_TOP_ACLK100_SHIFT)
+#define S5P_CLKDIV_TOP_ACLK160_SHIFT	(8)
+#define S5P_CLKDIV_TOP_ACLK160_MASK	(0x7 << S5P_CLKDIV_TOP_ACLK160_SHIFT)
+#define S5P_CLKDIV_TOP_ACLK133_SHIFT	(12)
+#define S5P_CLKDIV_TOP_ACLK133_MASK	(0x7 << S5P_CLKDIV_TOP_ACLK133_SHIFT)
+#define S5P_CLKDIV_TOP_ONENAND_SHIFT	(16)
+#define S5P_CLKDIV_TOP_ONENAND_MASK	(0x7 << S5P_CLKDIV_TOP_ONENAND_SHIFT)
+
+/* CLKDIV_LEFTBUS / CLKDIV_RIGHTBUS*/
+#define S5P_CLKDIV_BUS_GDLR_SHIFT	(0)
+#define S5P_CLKDIV_BUS_GDLR_MASK	(0x7 << S5P_CLKDIV_BUS_GDLR_SHIFT)
+#define S5P_CLKDIV_BUS_GPLR_SHIFT	(4)
+#define S5P_CLKDIV_BUS_GPLR_MASK	(0x7 << S5P_CLKDIV_BUS_GPLR_SHIFT)
+
 #endif /* __ASM_ARCH_REGS_CLOCK_H */
-- 
1.6.2.5
