From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 17 Oct 2013 11:17:13 +0800
Subject: [PATCH 3/4] ARM: imx: ensure dsm_request signal is not asserted when
 setting LPM
In-Reply-To: <1381979834-20998-1-git-send-email-shawn.guo@linaro.org>
References: <1381979834-20998-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1381979834-20998-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a defect in imx6 LPM design.  When SW tries to enter low power
mode with following sequence, the chip will enter low power mode before
A9 CPU execute WFI instruction:

1. Set CCM_CLPCR[1:0] to 2'b00;
2. ARM CPU enters WFI;
3. ARM CPU wakeup from an interrupt event, which is masked by GPC or not
   visible to GPC, such as interrupt from local timer;
4. Set CCM_CLPCR[1:0] to 2'b01 or 2'b10;
5. ARM CPU execute WFI.

Before the last step, the chip will enter WAIT mode if CCM_CLPCR[1:0] is
set to 2'b01, or enter STOP mode if CCM_CLPCR[1:0] is set to 2'b10.

The patch implements a recommended workaround for this issue.

1. SW triggers irq #32(IOMUX) to be always pending manually by setting
   IOMUX_GPR1_GINT bit;
2. SW should then unmask it in GPC before setting CCM LPM;
3. SW should mask it right after CCM LPM is set (bit0-1 of CCM_CLPCR).

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/common.h   |    3 +++
 arch/arm/mach-imx/gpc.c      |    4 ++--
 arch/arm/mach-imx/pm-imx6q.c |   26 ++++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 2b4ce09..ce81962 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -13,6 +13,7 @@
 
 #include <linux/reboot.h>
 
+struct irq_data;
 struct platform_device;
 struct pt_regs;
 struct clk;
@@ -140,6 +141,8 @@ void imx_gpc_pre_suspend(void);
 void imx_gpc_post_resume(void);
 void imx_gpc_mask_all(void);
 void imx_gpc_restore_all(void);
+void imx_gpc_irq_mask(struct irq_data *d);
+void imx_gpc_irq_unmask(struct irq_data *d);
 void imx_anatop_init(void);
 void imx_anatop_pre_suspend(void);
 void imx_anatop_post_resume(void);
diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index 44a65e9..586e017 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -90,7 +90,7 @@ void imx_gpc_restore_all(void)
 		writel_relaxed(gpc_saved_imrs[i], reg_imr1 + i * 4);
 }
 
-static void imx_gpc_irq_unmask(struct irq_data *d)
+void imx_gpc_irq_unmask(struct irq_data *d)
 {
 	void __iomem *reg;
 	u32 val;
@@ -105,7 +105,7 @@ static void imx_gpc_irq_unmask(struct irq_data *d)
 	writel_relaxed(val, reg);
 }
 
-static void imx_gpc_irq_mask(struct irq_data *d)
+void imx_gpc_irq_mask(struct irq_data *d)
 {
 	void __iomem *reg;
 	u32 val;
diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
index fb7d90d..f303b56 100644
--- a/arch/arm/mach-imx/pm-imx6q.c
+++ b/arch/arm/mach-imx/pm-imx6q.c
@@ -13,8 +13,12 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/regmap.h>
 #include <linux/suspend.h>
 #include <asm/cacheflush.h>
 #include <asm/proc-fns.h>
@@ -116,6 +120,7 @@ static void imx6q_enable_wb(bool enable)
 
 int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 {
+	struct irq_desc *iomuxc_irq_desc;
 	u32 val = readl_relaxed(ccm_base + CLPCR);
 
 	val &= ~BM_CLPCR_LPM;
@@ -144,7 +149,16 @@ int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 		return -EINVAL;
 	}
 
+	/*
+	 * Unmask the always pending IOMUXC interrupt #32 as wakeup source to
+	 * deassert dsm_request signal, so that we can ensure dsm_request
+	 * is not asserted when we're going to write CLPCR register to set LPM.
+	 * After setting up LPM bits, we need to mask this wakeup source.
+	 */
+	iomuxc_irq_desc = irq_to_desc(32);
+	imx_gpc_irq_unmask(&iomuxc_irq_desc->irq_data);
 	writel_relaxed(val, ccm_base + CLPCR);
+	imx_gpc_irq_mask(&iomuxc_irq_desc->irq_data);
 
 	return 0;
 }
@@ -193,8 +207,20 @@ void __init imx6q_pm_set_ccm_base(void __iomem *base)
 
 void __init imx6q_pm_init(void)
 {
+	struct regmap *gpr;
+
 	WARN_ON(!ccm_base);
 
+	/*
+	 * Force IOMUXC irq pending, so that the interrupt to GPC can be
+	 * used to deassert dsm_request signal when the signal gets
+	 * asserted unexpectedly.
+	 */
+	gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
+	if (!IS_ERR(gpr))
+		regmap_update_bits(gpr, IOMUXC_GPR1, IMX6Q_GPR1_GINT,
+				   IMX6Q_GPR1_GINT);
+
 	/* Set initial power mode */
 	imx6q_set_lpm(WAIT_CLOCKED);
 
-- 
1.7.9.5
