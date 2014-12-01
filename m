From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  1 Dec 2014 17:04:03 +0000
Subject: [PATCH] ARM: imx6: fix bogus use of irq_get_irq_data
Message-ID: <1417453443-9179-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx6 PM code seems to be quite creative in its use of irq_data,
using something something that is very much a hardware interrupt
number where we expect a virtual one.  Yes, it worked so far, but
that's only cheer luck, and it will definitely explode in 3.19.

Fix it by using a pair of helper functions that deal with the
actual hardware.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-imx/common.h  |  4 ++--
 arch/arm/mach-imx/gpc.c     | 34 ++++++++++++++++++++++------------
 arch/arm/mach-imx/pm-imx6.c |  5 ++---
 3 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 1dabf43..66662a1 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -108,8 +108,8 @@ void imx_gpc_pre_suspend(bool arm_power_off);
 void imx_gpc_post_resume(void);
 void imx_gpc_mask_all(void);
 void imx_gpc_restore_all(void);
-void imx_gpc_irq_mask(struct irq_data *d);
-void imx_gpc_irq_unmask(struct irq_data *d);
+void imx_gpc_hwirq_mask(unsigned int hwirq);
+void imx_gpc_hwirq_unmask(unsigned int hwirq);
 void imx_anatop_init(void);
 void imx_anatop_pre_suspend(void);
 void imx_anatop_post_resume(void);
diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index 1455829..5f3602e 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -91,34 +91,44 @@ void imx_gpc_restore_all(void)
 		writel_relaxed(gpc_saved_imrs[i], reg_imr1 + i * 4);
 }
 
-void imx_gpc_irq_unmask(struct irq_data *d)
+void imx_gpc_hwirq_unmask(unsigned int hwirq)
 {
 	void __iomem *reg;
 	u32 val;
 
-	/* Sanity check for SPI irq */
-	if (d->hwirq < 32)
-		return;
-
-	reg = gpc_base + GPC_IMR1 + (d->hwirq / 32 - 1) * 4;
+	reg = gpc_base + GPC_IMR1 + (hwirq / 32 - 1) * 4;
 	val = readl_relaxed(reg);
-	val &= ~(1 << d->hwirq % 32);
+	val &= ~(1 << hwirq % 32);
 	writel_relaxed(val, reg);
 }
 
-void imx_gpc_irq_mask(struct irq_data *d)
+void imx_gpc_hwirq_mask(unsigned int hwirq)
 {
 	void __iomem *reg;
 	u32 val;
 
+	reg = gpc_base + GPC_IMR1 + (hwirq / 32 - 1) * 4;
+	val = readl_relaxed(reg);
+	val |= 1 << (hwirq % 32);
+	writel_relaxed(val, reg);
+}
+
+static void imx_gpc_irq_unmask(struct irq_data *d)
+{
+	/* Sanity check for SPI irq */
+	if (d->hwirq < 32)
+		return;
+
+	imx_gpc_hwirq_unmask(d->hwirq);
+}
+
+static void imx_gpc_irq_mask(struct irq_data *d)
+{
 	/* Sanity check for SPI irq */
 	if (d->hwirq < 32)
 		return;
 
-	reg = gpc_base + GPC_IMR1 + (d->hwirq / 32 - 1) * 4;
-	val = readl_relaxed(reg);
-	val |= 1 << (d->hwirq % 32);
-	writel_relaxed(val, reg);
+	imx_gpc_hwirq_mask(d->hwirq);
 }
 
 void __init imx_gpc_init(void)
diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 5c3af8f..d815d1b 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -261,7 +261,6 @@ static void imx6q_enable_wb(bool enable)
 
 int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 {
-	struct irq_data *iomuxc_irq_data = irq_get_irq_data(32);
 	u32 val = readl_relaxed(ccm_base + CLPCR);
 
 	val &= ~BM_CLPCR_LPM;
@@ -316,9 +315,9 @@ int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 	 * 3) Software should mask IRQ #32 right after CCM Low-Power mode
 	 *    is set (set bits 0-1 of CCM_CLPCR).
 	 */
-	imx_gpc_irq_unmask(iomuxc_irq_data);
+	imx_gpc_hwirq_unmask(32);
 	writel_relaxed(val, ccm_base + CLPCR);
-	imx_gpc_irq_mask(iomuxc_irq_data);
+	imx_gpc_hwirq_mask(32);
 
 	return 0;
 }
-- 
2.1.3
