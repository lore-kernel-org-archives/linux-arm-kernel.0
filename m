From: scott.shu@mediatek.com (Scott Shu)
Date: Tue, 4 Aug 2015 21:54:19 +0800
Subject: [PATCH v3 3/8] soc: Mediatek: Add SCPSYS CPU power domain driver
In-Reply-To: <1438696464-59858-1-git-send-email-scott.shu@mediatek.com>
References: <1438696464-59858-1-git-send-email-scott.shu@mediatek.com>
Message-ID: <1438696464-59858-4-git-send-email-scott.shu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a CPU power domain driver for the Mediatek SCPSYS unit on
MT6580.

Signed-off-by: Scott Shu <scott.shu@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c   |  250 +++++++++++++++++++++++++++++++++++
 include/linux/soc/mediatek/scpsys.h |    9 ++
 2 files changed, 259 insertions(+)
 create mode 100644 include/linux/soc/mediatek/scpsys.h

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index 43a79ed..ca0f2dd 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -15,18 +15,30 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
+#include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/regmap.h>
 #include <linux/soc/mediatek/infracfg.h>
+#include <linux/soc/mediatek/scpsys.h>
 #include <dt-bindings/power/mt8173-power.h>
 
+#define SPM_POWERON_CONFIG_SET		0x0000
+#define SPM_CA7_CPU0_PWR_CON		0x0200
 #define SPM_VDE_PWR_CON			0x0210
 #define SPM_MFG_PWR_CON			0x0214
+#define SPM_CA7_CPU1_PWR_CON		0x0218
+#define SPM_CA7_CPU2_PWR_CON		0x021c
+#define SPM_CA7_CPU3_PWR_CON		0x0220
 #define SPM_VEN_PWR_CON			0x0230
 #define SPM_ISP_PWR_CON			0x0238
 #define SPM_DIS_PWR_CON			0x023c
+#define SPM_CA7_CPU0_L1_PDN		0x025c
+#define SPM_CA7_CPU1_L1_PDN		0x0264
+#define SPM_CA7_CPU2_L1_PDN		0x026c
+#define SPM_CA7_CPU3_L1_PDN		0x0274
 #define SPM_VEN2_PWR_CON		0x0298
 #define SPM_AUDIO_PWR_CON		0x029c
 #define SPM_MFG_2D_PWR_CON		0x02c0
@@ -34,12 +46,20 @@
 #define SPM_USB_PWR_CON			0x02cc
 #define SPM_PWR_STATUS			0x060c
 #define SPM_PWR_STATUS_2ND		0x0610
+#define SPM_SLEEP_TIMER_STA		0x0720
 
+/* bit definition in SPM_CA7_CPUx_PWR_CON */
 #define PWR_RST_B_BIT			BIT(0)
 #define PWR_ISO_BIT			BIT(1)
 #define PWR_ON_BIT			BIT(2)
 #define PWR_ON_2ND_BIT			BIT(3)
 #define PWR_CLK_DIS_BIT			BIT(4)
+#define SRAM_CKISO_BIT			BIT(5)
+#define SRAM_ISOINT_B_BIT		BIT(6)
+
+/* bit definition in SPM_CA7_CPUx_L1_PDN */
+#define L1_PDN				BIT(0)
+#define L1_PDN_ACK			BIT(8)
 
 #define PWR_STATUS_DISP			BIT(3)
 #define PWR_STATUS_MFG			BIT(4)
@@ -52,6 +72,28 @@
 #define PWR_STATUS_AUDIO		BIT(24)
 #define PWR_STATUS_USB			BIT(25)
 
+#define MT6580_MAX_CPUS			4
+
+#ifdef CONFIG_SMP
+static DEFINE_SPINLOCK(spm_cpu_lock);
+
+static void __iomem *spm_cpu_base;
+
+static const u32 spm_cpu_pwr_con[MT6580_MAX_CPUS] = {
+	SPM_CA7_CPU0_PWR_CON,
+	SPM_CA7_CPU1_PWR_CON,
+	SPM_CA7_CPU2_PWR_CON,
+	SPM_CA7_CPU3_PWR_CON,
+};
+
+static const u32 spm_cpu_l1_pdn[MT6580_MAX_CPUS] = {
+	SPM_CA7_CPU0_L1_PDN,
+	SPM_CA7_CPU1_L1_PDN,
+	SPM_CA7_CPU2_L1_PDN,
+	SPM_CA7_CPU3_L1_PDN,
+};
+#endif
+
 enum clk_id {
 	MT8173_CLK_MM,
 	MT8173_CLK_MFG,
@@ -485,3 +527,211 @@ static struct platform_driver scpsys_drv = {
 };
 
 module_platform_driver_probe(scpsys_drv, scpsys_probe);
+
+#define SPM_REGWR_EN		BIT(0)
+#define SPM_PROJECT_CODE	0x0B16
+
+#ifdef CONFIG_SMP
+int spm_cpu_mtcmos_on(int cpu)
+{
+	unsigned long flags;
+	static u32 spmcpu_pwr_con, spmcpu_l1_pdn;
+	unsigned int cbit, temp;
+	int timeout = 10;
+	int ret = 0;
+
+	temp = (SPM_PROJECT_CODE << 16) | SPM_REGWR_EN;
+	writel_relaxed(temp, spm_cpu_base + SPM_POWERON_CONFIG_SET);
+
+	spmcpu_pwr_con = spm_cpu_pwr_con[cpu];
+	spmcpu_l1_pdn = spm_cpu_l1_pdn[cpu];
+
+	spin_lock_irqsave(&spm_cpu_lock, flags);
+
+	/* Set PWR_ON */
+	temp = readl_relaxed(spm_cpu_base + spmcpu_pwr_con);
+	temp |= PWR_ON_BIT;
+	writel_relaxed(temp, spm_cpu_base + spmcpu_pwr_con);
+
+	/* Wait for charging core power */
+	udelay(1);
+
+	/* Set PWR_ON_2ND */
+	temp = readl_relaxed(spm_cpu_base + spmcpu_pwr_con);
+	temp |= PWR_ON_2ND_BIT;
+	writel_relaxed(temp, spm_cpu_base + spmcpu_pwr_con);
+
+	/* Wait for the power-ack */
+	cbit = BIT(13 - cpu);
+	while (((readl_relaxed(spm_cpu_base + SPM_PWR_STATUS) &
+		 cbit) != cbit) ||
+	       (readl_relaxed(spm_cpu_base + SPM_PWR_STATUS_2ND) &
+		 cbit) != cbit) {
+		if (--timeout == 0) {
+			ret = -ENXIO;
+			goto fail;
+		}
+		udelay(1);
+	}
+
+	temp = readl_relaxed(spm_cpu_base + spmcpu_pwr_con);
+	temp &= ~PWR_ISO_BIT;
+	writel_relaxed(temp, spm_cpu_base + spmcpu_pwr_con);
+
+	/* L1 power on */
+	temp = readl_relaxed(spm_cpu_base + spmcpu_l1_pdn);
+	temp &= ~L1_PDN;
+	writel_relaxed(temp, spm_cpu_base + spmcpu_l1_pdn);
+	timeout = 10;
+	while ((readl_relaxed(spm_cpu_base + spmcpu_l1_pdn) &
+		L1_PDN_ACK) != 0) {
+		if (--timeout == 0) {
+			ret = -ENXIO;
+			goto fail;
+		}
+		udelay(1);
+	}
+
+	/* Wait for memory power ready */
+	udelay(1);
+
+	/* Set SRAM_ISOINT_B */
+	temp = readl_relaxed(spm_cpu_base + spmcpu_pwr_con);
+	temp |= SRAM_ISOINT_B_BIT;
+	writel_relaxed(temp, spm_cpu_base + spmcpu_pwr_con);
+
+	/* Clear SRAM_CKISO */
+	temp = readl_relaxed(spm_cpu_base + spmcpu_pwr_con);
+	temp &= ~SRAM_CKISO_BIT;
+	writel_relaxed(temp, spm_cpu_base + spmcpu_pwr_con);
+
+	/* Clear PWR_CLK_DIS */
+	temp = readl_relaxed(spm_cpu_base + spmcpu_pwr_con);
+	temp &= ~PWR_CLK_DIS_BIT;
+	writel_relaxed(temp, spm_cpu_base + spmcpu_pwr_con);
+
+	/* Set PWR_RST_B to finish power on and reset sequences */
+	temp = readl_relaxed(spm_cpu_base + spmcpu_pwr_con);
+	temp |= PWR_RST_B_BIT;
+	writel_relaxed(temp, spm_cpu_base + spmcpu_pwr_con);
+fail:
+	spin_unlock_irqrestore(&spm_cpu_lock, flags);
+
+	return ret;
+}
+
+int spm_cpu_mtcmos_off(int cpu, bool wfi)
+{
+	unsigned long flags;
+	static u32 spmcpu_pwr_con, spmcpu_l1_pdn;
+	unsigned int cbit, temp;
+	int timeout = 10;
+	int ret = 0;
+
+	temp = (SPM_PROJECT_CODE << 16) | SPM_REGWR_EN;
+	writel_relaxed(temp, spm_cpu_base + SPM_POWERON_CONFIG_SET);
+
+	spmcpu_pwr_con = spm_cpu_pwr_con[cpu];
+	spmcpu_l1_pdn = spm_cpu_l1_pdn[cpu];
+
+	if (wfi) {
+		while ((readl_relaxed(spm_cpu_base + SPM_SLEEP_TIMER_STA) &
+			(1U << (16 + cpu))) == 0) {
+			if (--timeout == 0)
+				return -ENXIO;
+			udelay(1);
+		}
+	}
+
+	spin_lock_irqsave(&spm_cpu_lock, flags);
+
+	/* Set PWR_ISO */
+	temp = readl_relaxed(spm_cpu_base + spmcpu_pwr_con);
+	temp |= PWR_ISO_BIT;
+	writel_relaxed(temp, spm_cpu_base + spmcpu_pwr_con);
+
+	/* Set SRAM_CKISO */
+	temp = readl_relaxed(spm_cpu_base + spmcpu_pwr_con);
+	temp |= SRAM_CKISO_BIT;
+	writel_relaxed(temp, spm_cpu_base + spmcpu_pwr_con);
+
+	/* Clear SRAM_ISOINT_B */
+	temp = readl_relaxed(spm_cpu_base + spmcpu_pwr_con);
+	temp &= ~SRAM_ISOINT_B_BIT;
+	writel_relaxed(temp, spm_cpu_base + spmcpu_pwr_con);
+
+	/* L1 power off */
+	temp = readl_relaxed(spm_cpu_base + spmcpu_l1_pdn);
+	temp |= L1_PDN;
+	writel_relaxed(temp, spm_cpu_base + spmcpu_l1_pdn);
+	timeout = 10;
+	while ((readl_relaxed(spm_cpu_base + spmcpu_l1_pdn) &
+		L1_PDN_ACK) != L1_PDN_ACK) {
+		if (--timeout == 0) {
+			ret = -ENXIO;
+			goto fail;
+		}
+		udelay(1);
+	}
+
+	/* Clear PWR_RST_B */
+	temp = readl_relaxed(spm_cpu_base + spmcpu_pwr_con);
+	temp &= ~PWR_RST_B_BIT;
+	writel_relaxed(temp, spm_cpu_base + spmcpu_pwr_con);
+
+	/* Set PWR_CLK_DIS */
+	temp = readl_relaxed(spm_cpu_base + spmcpu_pwr_con);
+	temp |= PWR_CLK_DIS_BIT;
+	writel_relaxed(temp, spm_cpu_base + spmcpu_pwr_con);
+
+	/* Clear PWR_ON */
+	temp = readl_relaxed(spm_cpu_base + spmcpu_pwr_con);
+	temp &= ~PWR_ON_BIT;
+	writel_relaxed(temp, spm_cpu_base + spmcpu_pwr_con);
+
+	/* Clear PWR_ON_2ND */
+	temp = readl_relaxed(spm_cpu_base + spmcpu_pwr_con);
+	temp &= ~PWR_ON_2ND_BIT;
+	writel_relaxed(temp, spm_cpu_base + spmcpu_pwr_con);
+
+	timeout = 10;
+	cbit = BIT(13 - cpu);
+	while (((readl_relaxed(spm_cpu_base + SPM_PWR_STATUS) & cbit) != 0) ||
+	       ((readl_relaxed(spm_cpu_base + SPM_PWR_STATUS_2ND) &
+		 cbit) != 0)) {
+		if (--timeout == 0) {
+			ret = -ENXIO;
+			goto fail;
+		}
+		udelay(1);
+	}
+fail:
+	spin_unlock_irqrestore(&spm_cpu_lock, flags);
+
+	return ret;
+}
+#endif /* CONFIG_SMP */
+
+static int __init mtk_scpsys_early_init(void)
+{
+	struct device_node *node;
+	struct resource regs;
+
+	node = of_find_compatible_node(NULL, NULL, "mediatek,mt6580-scpsys");
+	if (node) {
+		if (of_address_to_resource(node, 0, &regs) < 0) {
+			pr_err("Failed to get SCPSYS registers\n");
+			return -ENXIO;
+		}
+
+		spm_cpu_base = ioremap_nocache(regs.start,
+					       resource_size(&regs));
+		if (!spm_cpu_base) {
+			pr_err("%s: Unable to map I/O memory\n", __func__);
+			return -ENODEV;
+		}
+	}
+
+	return 0;
+}
+early_initcall(mtk_scpsys_early_init);
diff --git a/include/linux/soc/mediatek/scpsys.h b/include/linux/soc/mediatek/scpsys.h
new file mode 100644
index 0000000..a14b7a3
--- /dev/null
+++ b/include/linux/soc/mediatek/scpsys.h
@@ -0,0 +1,9 @@
+#ifndef __SOC_MEDIATEK_SCPSYS_H
+#define __SOC_MEDIATEK_SCPSYS_H
+
+#include <linux/kernel.h>
+
+int spm_cpu_mtcmos_on(int cpu);
+int spm_cpu_mtcmos_off(int cpu, bool wfi);
+
+#endif
-- 
1.7.9.5
