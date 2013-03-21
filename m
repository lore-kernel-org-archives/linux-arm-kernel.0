From: b20788@freescale.com (Anson Huang)
Date: Thu, 21 Mar 2013 10:58:06 -0400
Subject: [PATCH V3 3/3] ARM: imx: enable RBC to support anatop LPM mode
Message-ID: <1363877886-26538-1-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RBC is to control whether some ANATOP sub modules
can enter lpm mode when SOC is into STOP mode, if
RBC is enabled and PMIC_VSTBY_REQ is set, ANATOP
will have below behaviors:

1. Digital LDOs(CORE, SOC and PU) are bypassed;
2. Analog LDOs(1P1, 2P5, 3P0) are disabled;

As the 2P5 is necessary for DRAM IO pre-drive in
STOP mode, so we need to enable weak 2P5 in STOP
mode when 2P5 LDO is disabled.

For RBC settings, there are some rules as below
due to hardware design:

1. All interrupts must be masked during operating
   RBC registers;
2. At least 2 CKIL(32K) cycles is needed after the
   RBC setting is changed.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/mach-imx/anatop.c    |   19 ++++++++++++++++++
 arch/arm/mach-imx/clk-imx6q.c |   43 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/common.h    |    2 ++
 arch/arm/mach-imx/gpc.c       |   23 +++++++++++++++++++++-
 4 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
index b396b92..8b18b3c 100644
--- a/arch/arm/mach-imx/anatop.c
+++ b/arch/arm/mach-imx/anatop.c
@@ -19,17 +19,34 @@
 #define REG_SET		0x4
 #define REG_CLR		0x8
 
+#define ANADIG_REG_2P5		0x130
 #define ANADIG_REG_CORE		0x140
+#define ANADIG_ANA_MISC0	0x150
 #define ANADIG_USB1_CHRG_DETECT	0x1b0
 #define ANADIG_USB2_CHRG_DETECT	0x210
 #define ANADIG_DIGPROG		0x260
 
+#define BM_ANADIG_REG_2P5_ENABLE_WEAK_LINREG	0x40000
 #define BM_ANADIG_REG_CORE_FET_ODRIVE		0x20000000
+#define BM_ANADIG_ANA_MISC0_STOP_MODE_CONFIG	0x1000
 #define BM_ANADIG_USB_CHRG_DETECT_CHK_CHRG_B	0x80000
 #define BM_ANADIG_USB_CHRG_DETECT_EN_B		0x100000
 
 static struct regmap *anatop;
 
+static void imx_anatop_enable_weak2p5(bool enable)
+{
+	u32 reg, val;
+
+	regmap_read(anatop, ANADIG_ANA_MISC0, &val);
+
+	/* can only be enabled when stop_mode_config is clear. */
+	reg = ANADIG_REG_2P5;
+	reg += (enable && (val & BM_ANADIG_ANA_MISC0_STOP_MODE_CONFIG) == 0) ?
+		REG_SET : REG_CLR;
+	regmap_write(anatop, reg, BM_ANADIG_REG_2P5_ENABLE_WEAK_LINREG);
+}
+
 static void imx_anatop_enable_fet_odrive(bool enable)
 {
 	regmap_write(anatop, ANADIG_REG_CORE + (enable ? REG_SET : REG_CLR),
@@ -38,12 +55,14 @@ static void imx_anatop_enable_fet_odrive(bool enable)
 
 void imx_anatop_pre_suspend(void)
 {
+	imx_anatop_enable_weak2p5(true);
 	imx_anatop_enable_fet_odrive(true);
 }
 
 void imx_anatop_post_resume(void)
 {
 	imx_anatop_enable_fet_odrive(false);
+	imx_anatop_enable_weak2p5(false);
 }
 
 void imx_anatop_usb_chrg_detect_disable(void)
diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 96ed9a3..d20306c 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -25,6 +26,8 @@
 
 #define CCR				0x0
 #define BM_CCR_WB_COUNT			(0x7 << 16)
+#define BM_CCR_RBC_BYPASS_COUNT		(0x3f << 21)
+#define BM_CCR_RBC_EN			(0x1 << 27)
 
 #define CCGR0				0x68
 #define CCGR1				0x6c
@@ -70,6 +73,44 @@ void imx6q_set_chicken_bit(void)
 	writel_relaxed(val, ccm_base + CGPR);
 }
 
+static void imx6q_enable_rbc(bool enable)
+{
+	u32 val;
+	static bool last_rbc_mode;
+
+	if (last_rbc_mode == enable)
+		return;
+	/*
+	 * need to mask all interrupts in GPC before
+	 * operating RBC configurations
+	 */
+	imx_gpc_mask_all();
+
+	/* configure RBC enable bit */
+	val = readl_relaxed(ccm_base + CCR);
+	val &= ~BM_CCR_RBC_EN;
+	val |= enable ? BM_CCR_RBC_EN : 0;
+	writel_relaxed(val, ccm_base + CCR);
+
+	/* configure RBC count */
+	val = readl_relaxed(ccm_base + CCR);
+	val &= ~BM_CCR_RBC_BYPASS_COUNT;
+	val |= enable ? BM_CCR_RBC_BYPASS_COUNT : 0;
+	writel(val, ccm_base + CCR);
+
+	/*
+	 * need to delay@least 2 cycles of CKIL(32K)
+	 * due to hardware design requirement, which is
+	 * ~61us, here we use 65us for safe
+	 */
+	udelay(65);
+
+	/* restore GPC interrupt mask settings */
+	imx_gpc_restore_all();
+
+	last_rbc_mode = enable;
+}
+
 static void imx6q_enable_wb(bool enable)
 {
 	u32 val;
@@ -101,6 +142,7 @@ int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 	switch (mode) {
 	case WAIT_CLOCKED:
 		imx6q_enable_wb(false);
+		imx6q_enable_rbc(false);
 		break;
 	case WAIT_UNCLOCKED:
 		val |= 0x1 << BP_CLPCR_LPM;
@@ -120,6 +162,7 @@ int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 		val |= BM_CLPCR_VSTBY;
 		val |= BM_CLPCR_SBYOS;
 		imx6q_enable_wb(true);
+		imx6q_enable_rbc(true);
 		break;
 	default:
 		return -EINVAL;
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 69451a9..4494169 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -129,6 +129,8 @@ extern void imx_src_prepare_restart(void);
 extern void imx_gpc_init(void);
 extern void imx_gpc_pre_suspend(void);
 extern void imx_gpc_post_resume(void);
+extern void imx_gpc_mask_all(void);
+extern void imx_gpc_restore_all(void);
 extern void imx_anatop_init(void);
 extern void imx_anatop_pre_suspend(void);
 extern void imx_anatop_post_resume(void);
diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index a96ccc7..c20445c 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -1,5 +1,5 @@
 /*
- * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011-2013 Freescale Semiconductor, Inc.
  * Copyright 2011 Linaro Ltd.
  *
  * The code contained herein is licensed under the GNU General Public
@@ -68,6 +68,27 @@ static int imx_gpc_irq_set_wake(struct irq_data *d, unsigned int on)
 	return 0;
 }
 
+void imx_gpc_mask_all(void)
+{
+	void __iomem *reg_imr1 = gpc_base + GPC_IMR1;
+	int i;
+
+	for (i = 0; i < IMR_NUM; i++) {
+		gpc_saved_imrs[i] = readl_relaxed(reg_imr1 + i * 4);
+		writel_relaxed(~0, reg_imr1 + i * 4);
+	}
+
+}
+
+void imx_gpc_restore_all(void)
+{
+	void __iomem *reg_imr1 = gpc_base + GPC_IMR1;
+	int i;
+
+	for (i = 0; i < IMR_NUM; i++)
+		writel_relaxed(gpc_saved_imrs[i], reg_imr1 + i * 4);
+}
+
 static void imx_gpc_irq_unmask(struct irq_data *d)
 {
 	void __iomem *reg;
-- 
1.7.9.5
