From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon,  9 Mar 2015 09:10:01 +0100
Subject: [PATCH 2/4] soc: Mediatek: Add SCPSYS power domain driver
In-Reply-To: <1425888603-25800-1-git-send-email-s.hauer@pengutronix.de>
References: <1425888603-25800-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1425888603-25800-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/soc/mediatek/Kconfig             |   6 +
 drivers/soc/mediatek/Makefile            |   1 +
 drivers/soc/mediatek/mtk-scpsys.c        | 398 +++++++++++++++++++++++++++++++
 include/dt-bindings/power/mt8173-power.h |  15 ++
 4 files changed, 420 insertions(+)
 create mode 100644 drivers/soc/mediatek/mtk-scpsys.c
 create mode 100644 include/dt-bindings/power/mt8173-power.h

diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
index b91665a..4736f5b 100644
--- a/drivers/soc/mediatek/Kconfig
+++ b/drivers/soc/mediatek/Kconfig
@@ -9,3 +9,9 @@ config MTK_PMIC_WRAP
 	  Say yes here to add support for MediaTek PMIC Wrapper found
 	  on the MT8135 and MT8173 SoCs. The PMIC wrapper is a proprietary
 	  hardware to connect the PMIC.
+
+config MTK_SCPSYS
+	tristate "MediaTek SCPSYS Support"
+	help
+	  Say yes here to add support for the MediaTek SCPSYS power domain
+	  driver.
diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
index ecaf4de..ce88693 100644
--- a/drivers/soc/mediatek/Makefile
+++ b/drivers/soc/mediatek/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
+obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
new file mode 100644
index 0000000..8bbd2e8
--- /dev/null
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -0,0 +1,398 @@
+/*
+ * Copyright (c) 2015 Pengutronix, Sascha Hauer <kernel@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/pm_domain.h>
+#include <linux/delay.h>
+#include <dt-bindings/power/mt8173-power.h>
+#include <linux/mfd/syscon.h>
+
+#define SPM_VDE_PWR_CON			0x0210
+#define SPM_MFG_PWR_CON			0x0214
+#define SPM_VEN_PWR_CON			0x0230
+#define SPM_ISP_PWR_CON			0x0238
+#define SPM_DIS_PWR_CON			0x023c
+#define SPM_VEN2_PWR_CON		0x0298
+#define SPM_AUDIO_PWR_CON		0x029c
+#define SPM_MFG_2D_PWR_CON		0x02c0
+#define SPM_MFG_ASYNC_PWR_CON		0x02c4
+#define SPM_USB_PWR_CON			0x02cc
+#define SPM_PWR_STATUS			0x060c
+#define SPM_PWR_STATUS_2ND		0x0610
+
+#define PWR_RST_B_BIT			BIT(0)
+#define PWR_ISO_BIT			BIT(1)
+#define PWR_ON_BIT			BIT(2)
+#define PWR_ON_2ND_BIT			BIT(3)
+#define PWR_CLK_DIS_BIT			BIT(4)
+
+#define DIS_PWR_STA_MASK		BIT(3)
+#define MFG_PWR_STA_MASK		BIT(4)
+#define ISP_PWR_STA_MASK		BIT(5)
+#define VDE_PWR_STA_MASK		BIT(7)
+#define VEN2_PWR_STA_MASK		BIT(20)
+#define VEN_PWR_STA_MASK		BIT(21)
+#define MFG_2D_PWR_STA_MASK		BIT(22)
+#define MFG_ASYNC_PWR_STA_MASK		BIT(23)
+#define AUDIO_PWR_STA_MASK		BIT(24)
+#define USB_PWR_STA_MASK		BIT(25)
+
+/*
+ * The Infracfg unit has bus protection bits. We enable the bus protection
+ * for disabled power domains so that the system does not hang when some unit
+ * accesses the bus while in power down.
+ */
+#define INFRA_TOPAXI_PROTECTEN		0x0220
+#define INFRA_TOPAXI_PROTECTSTA1	0x0228
+
+#define TOP_AXI_PROT_EN_MFG_SNOOP_OUT	BIT(23)
+#define TOP_AXI_PROT_EN_MFG_M1		BIT(22)
+#define TOP_AXI_PROT_EN_MFG_M0		BIT(21)
+#define TOP_AXI_PROT_EN_IOMMU		BIT(20)
+#define TOP_AXI_PROT_EN_GCPU		BIT(19)
+#define TOP_AXI_PROT_EN_CQ_DMA		BIT(18)
+#define TOP_AXI_PROT_EN_DEBUGSYS	BIT(17)
+#define TOP_AXI_PROT_EN_PERI_M1		BIT(16)
+#define TOP_AXI_PROT_EN_PERI_M0		BIT(15)
+#define TOP_AXI_PROT_EN_MFG_S		BIT(14)
+#define TOP_AXI_PROT_EN_CCI_M2		BIT(13)
+#define TOP_AXI_PROT_EN_L2SS_ADD	BIT(12)
+#define TOP_AXI_PROT_EN_L2SS_SMI	BIT(11)
+#define TOP_AXI_PROT_EN_L2C_M2		BIT(9)
+#define TOP_AXI_PROT_EN_MMAPB_S		BIT(6)
+#define TOP_AXI_PROT_EN_MM_M1		BIT(2)
+#define TOP_AXI_PROT_EN_MM_M0		BIT(1)
+#define TOP_AXI_PROT_EN_MCI_M2		BIT(0)
+
+struct scp_domain_data {
+	const char *name;
+	u32 sta_mask;
+	int ctl_offs;
+	u32 sram_pdn_bits;
+	u32 sram_pdn_ack_bits;
+	u32 bus_prot_mask;
+	int id;
+};
+
+static struct scp_domain_data scp_domain_data[] = {
+	{
+		.id = MT8173_POWER_DOMAIN_VDE,
+		.name = "vde",
+		.sta_mask = VDE_PWR_STA_MASK,
+		.ctl_offs = SPM_VDE_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+	}, {
+		.id = MT8173_POWER_DOMAIN_MFG,
+		.name = "mfg",
+		.sta_mask = MFG_PWR_STA_MASK,
+		.ctl_offs = SPM_MFG_PWR_CON,
+		.sram_pdn_bits = GENMASK(13, 8),
+		.sram_pdn_ack_bits = GENMASK(21, 16),
+		.bus_prot_mask = TOP_AXI_PROT_EN_MFG_S | TOP_AXI_PROT_EN_MFG_M0 |
+			TOP_AXI_PROT_EN_MFG_M1 | TOP_AXI_PROT_EN_MFG_SNOOP_OUT,
+	}, {
+		.id = MT8173_POWER_DOMAIN_VEN,
+		.name = "ven",
+		.sta_mask = VEN_PWR_STA_MASK,
+		.ctl_offs = SPM_VEN_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+	}, {
+		.id = MT8173_POWER_DOMAIN_ISP,
+		.name = "isp",
+		.sta_mask = ISP_PWR_STA_MASK,
+		.ctl_offs = SPM_ISP_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+	}, {
+		.id = MT8173_POWER_DOMAIN_DIS,
+		.name = "dis",
+		.sta_mask = DIS_PWR_STA_MASK,
+		.ctl_offs = SPM_DIS_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bus_prot_mask = TOP_AXI_PROT_EN_MM_M0 | TOP_AXI_PROT_EN_MM_M1,
+	}, {
+		.id = MT8173_POWER_DOMAIN_VEN2,
+		.name = "ven2",
+		.sta_mask = VEN2_PWR_STA_MASK,
+		.ctl_offs = SPM_VEN2_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+	}, {
+		.id = MT8173_POWER_DOMAIN_AUDIO,
+		.name = "audio",
+		.sta_mask = AUDIO_PWR_STA_MASK,
+		.ctl_offs = SPM_AUDIO_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+	}, {
+		.id = MT8173_POWER_DOMAIN_MFG_2D,
+		.name = "mfg_2d",
+		.sta_mask = MFG_2D_PWR_STA_MASK,
+		.ctl_offs = SPM_MFG_2D_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+	}, {
+		.id = MT8173_POWER_DOMAIN_MFG_ASYNC,
+		.name = "mfg_async",
+		.sta_mask = MFG_ASYNC_PWR_STA_MASK,
+		.ctl_offs = SPM_MFG_ASYNC_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = 0,
+	}, {
+		.id = MT8173_POWER_DOMAIN_USB,
+		.name = "usb",
+		.sta_mask = USB_PWR_STA_MASK,
+		.ctl_offs = SPM_USB_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+	},
+};
+
+#define NUM_DOMAINS	ARRAY_SIZE(scp_domain_data)
+
+struct scp;
+
+struct scp_domain {
+	struct generic_pm_domain pmd;
+	struct scp_domain_data *data;
+	struct scp *scp;
+};
+
+struct scp {
+	struct scp_domain domains[NUM_DOMAINS];
+	struct generic_pm_domain *pmd[NUM_DOMAINS];
+	struct genpd_onecell_data pd_data;
+	void __iomem *base;
+	struct regmap *infracfg;
+};
+
+static int scpsys_power_on(struct generic_pm_domain *genpd)
+{
+	struct scp_domain *scpd = container_of(genpd, struct scp_domain, pmd);
+	struct scp *scp = scpd->scp;
+	struct scp_domain_data *data = scpd->data;
+	unsigned long expired;
+	void __iomem *ctl_addr = scpd->scp->base + data->ctl_offs;
+	u32 sram_pdn_ack = data->sram_pdn_ack_bits;
+	u32 val;
+	int ret;
+
+	val = readl(ctl_addr);
+	val |= PWR_ON_BIT;
+	writel(val, ctl_addr);
+	val |= PWR_ON_2ND_BIT;
+	writel(val, ctl_addr);
+
+	/* wait until PWR_ACK = 1 */
+	expired = jiffies + HZ;
+	while (!(readl(scp->base + SPM_PWR_STATUS) & data->sta_mask) ||
+			!(readl(scp->base + SPM_PWR_STATUS_2ND) & data->sta_mask)) {
+		cpu_relax();
+		if (time_after(jiffies, expired))
+			return -EIO;
+	}
+
+	val &= ~PWR_CLK_DIS_BIT;
+	writel(val, ctl_addr);
+
+	val &= ~PWR_ISO_BIT;
+	writel(val, ctl_addr);
+
+	val |= PWR_RST_B_BIT;
+	writel(val, ctl_addr);
+
+	val &= ~data->sram_pdn_bits;
+	writel(val, ctl_addr);
+
+	/* wait until SRAM_PDN_ACK all 0 */
+	expired = jiffies + HZ;
+	while (sram_pdn_ack && (readl(ctl_addr) & sram_pdn_ack)) {
+		cpu_relax();
+		if (time_after(jiffies, expired))
+			return -EIO;
+	}
+
+	/* Clear bus protection bits */
+	if (data->bus_prot_mask) {
+		u32 mask = data->bus_prot_mask;
+		struct regmap *infracfg = scp->infracfg;
+
+		regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask, 0);
+
+		expired = jiffies + HZ;
+
+		while (1) {
+			u32 val;
+
+			ret = regmap_read(infracfg, INFRA_TOPAXI_PROTECTSTA1, &val);
+			if (ret)
+				return ret;
+
+			if (!(val & mask))
+				break;
+
+			cpu_relax();
+			if (time_after(jiffies, expired))
+				return -EIO;
+		}
+	}
+
+	return 0;
+}
+
+static int scpsys_power_off(struct generic_pm_domain *genpd)
+{
+	struct scp_domain *scpd = container_of(genpd, struct scp_domain, pmd);
+	struct scp *scp = scpd->scp;
+	struct scp_domain_data *data = scpd->data;
+	unsigned long expired;
+	void __iomem *ctl_addr = scpd->scp->base + data->ctl_offs;
+	u32 sram_pdn_ack = data->sram_pdn_ack_bits;
+	u32 val;
+	int ret;
+
+	/* set bus protection bits */
+	if (data->bus_prot_mask) {
+		struct regmap *infracfg = scp->infracfg;
+		u32 mask = data->bus_prot_mask;
+
+		regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask, mask);
+
+		expired = jiffies + HZ;
+
+		while (1) {
+			ret = regmap_read(infracfg, INFRA_TOPAXI_PROTECTSTA1, &val);
+			if (ret)
+				return ret;
+
+			if ((val & mask) == mask)
+				break;
+
+			cpu_relax();
+			if (time_after(jiffies, expired))
+				return -EIO;
+		}
+	}
+
+	val = readl(ctl_addr);
+	val |= data->sram_pdn_bits;
+	writel(val, ctl_addr);
+
+	/* wait until SRAM_PDN_ACK all 1 */
+	expired = jiffies + HZ;
+	while ((readl(ctl_addr) & sram_pdn_ack) != sram_pdn_ack) {
+		cpu_relax();
+		if (time_after(jiffies, expired))
+			return -EIO;
+	}
+
+	val |= PWR_ISO_BIT;
+	writel(val, ctl_addr);
+
+	val &= ~PWR_RST_B_BIT;
+	writel(val, ctl_addr);
+
+	val |= PWR_CLK_DIS_BIT;
+	writel(val, ctl_addr);
+
+	val &= ~PWR_ON_BIT;
+	writel(val, ctl_addr);
+
+	val &= ~PWR_ON_2ND_BIT;
+	writel(val, ctl_addr);
+
+	/* wait until PWR_ACK = 0 */
+	expired = jiffies + HZ;
+	while ((readl(scp->base + SPM_PWR_STATUS) & data->sta_mask) ||
+			(readl(scp->base + SPM_PWR_STATUS_2ND) & data->sta_mask)) {
+		cpu_relax();
+		if (time_after(jiffies, expired))
+			return -EIO;
+	}
+
+	return 0;
+}
+
+static int scpsys_probe(struct platform_device *pdev)
+{
+	struct genpd_onecell_data *pd_data;
+	struct resource *res;
+	int i;
+	struct scp *scp = devm_kzalloc(&pdev->dev, sizeof(*scp), GFP_KERNEL);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	scp->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(scp->base))
+		return PTR_ERR(scp->base);
+
+	pd_data = &scp->pd_data;
+
+	scp->infracfg = syscon_regmap_lookup_by_compatible("mediatek,mt8173-infracfg");
+	if (IS_ERR(scp->infracfg))
+		return PTR_ERR(scp->infracfg);
+
+	pd_data->domains = scp->pmd;
+	pd_data->num_domains = NUM_DOMAINS;
+
+	for (i = 0; i < NUM_DOMAINS; i++) {
+		struct scp_domain *scpd = &scp->domains[i];
+		struct generic_pm_domain *pmd = &scpd->pmd;
+
+		scp->pmd[i] = pmd;
+		scpd->data = &scp_domain_data[i];
+		scpd->scp = scp;
+
+		pmd->name = scp_domain_data[i].name;
+		pmd->power_off = scpsys_power_off;
+		pmd->power_on = scpsys_power_on;
+		pmd->power_off_latency_ns = 20000;
+		pmd->power_on_latency_ns = 20000;
+
+		pd_data->domains[i] = pmd;
+		pm_genpd_init(pmd, NULL, 1);
+	}
+
+	return of_genpd_add_provider_onecell(pdev->dev.of_node, pd_data);
+}
+
+static struct of_device_id of_scpsys_match_tbl[] = {
+	{
+		.compatible = "mediatek,mt8173-scpsys",
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(of, of_scpsys_match_tbl);
+
+static struct platform_driver scpsys_drv = {
+	.driver = {
+		.name = "mtk-scpsys",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(of_scpsys_match_tbl),
+	},
+	.probe = scpsys_probe,
+};
+
+module_platform_driver(scpsys_drv);
+
+MODULE_AUTHOR("Sascha Hauer, Pengutronix");
+MODULE_DESCRIPTION("MediaTek MT8173 scpsys driver");
+MODULE_LICENSE("GPL");
diff --git a/include/dt-bindings/power/mt8173-power.h b/include/dt-bindings/power/mt8173-power.h
new file mode 100644
index 0000000..88715f2
--- /dev/null
+++ b/include/dt-bindings/power/mt8173-power.h
@@ -0,0 +1,15 @@
+#ifndef _DT_BINDINGS_POWER_MT8183_POWER_H
+#define _DT_BINDINGS_POWER_MT8183_POWER_H
+
+#define MT8173_POWER_DOMAIN_VDE		0
+#define MT8173_POWER_DOMAIN_MFG		1
+#define MT8173_POWER_DOMAIN_VEN		2
+#define MT8173_POWER_DOMAIN_ISP		3
+#define MT8173_POWER_DOMAIN_DIS		4
+#define MT8173_POWER_DOMAIN_VEN2	5
+#define MT8173_POWER_DOMAIN_AUDIO	6
+#define MT8173_POWER_DOMAIN_MFG_2D	7
+#define MT8173_POWER_DOMAIN_MFG_ASYNC	8
+#define MT8173_POWER_DOMAIN_USB		9
+
+#endif /* _DT_BINDINGS_POWER_MT8183_POWER_H */
-- 
2.1.4
