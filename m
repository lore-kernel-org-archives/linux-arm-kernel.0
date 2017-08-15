From: weiyi.lu@mediatek.com (weiyi.lu at mediatek.com)
Date: Tue, 15 Aug 2017 14:42:47 +0800
Subject: [PATCH v1 6/9] soc: mediatek: add bus protection extend API
In-Reply-To: <1502779370-30150-1-git-send-email-weiyi.lu@mediatek.com>
References: <1502779370-30150-1-git-send-email-weiyi.lu@mediatek.com>
Message-ID: <1502779370-30150-7-git-send-email-weiyi.lu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Weiyi Lu <weiyi.lu@mediatek.com>

MT2712 add "set/clear" bus control register to each control register set
instead of providing only one "enable" control register, we could avoid
the read-modify-write racing by using extend API with such new design.
Also there exists the second bus control register set, we could not access
this setting via original API rather than the extend API.
By improving the mtk-infracfg bus protection implementation to
support set/clear bus protection control method and second
register set while power on/off scpsys.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-infracfg.c   | 90 +++++++++++++++++++++++++++++++++--
 drivers/soc/mediatek/mtk-scpsys.c     | 36 ++++++++++++--
 include/linux/soc/mediatek/infracfg.h | 14 +++++-
 3 files changed, 132 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-infracfg.c b/drivers/soc/mediatek/mtk-infracfg.c
index dba3055..63898e4 100644
--- a/drivers/soc/mediatek/mtk-infracfg.c
+++ b/drivers/soc/mediatek/mtk-infracfg.c
@@ -17,9 +17,6 @@
 #include <linux/soc/mediatek/infracfg.h>
 #include <asm/processor.h>
 
-#define INFRA_TOPAXI_PROTECTEN		0x0220
-#define INFRA_TOPAXI_PROTECTSTA1	0x0228
-
 /**
  * mtk_infracfg_set_bus_protection - enable bus protection
  * @regmap: The infracfg regmap
@@ -89,3 +86,90 @@ int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask)
 
 	return 0;
 }
+
+/**
+ * mtk_infracfg_set_bus_protection_ext - enable bus protection
+ * @regmap: The infracfg regmap
+ * @mask: The mask containing the protection bits to be enabled.
+ * @reg_set: The register used to enable protection bits.
+ * @reg_sta: The register used to check the protection bits are enabled.
+ * @reg_en: The register used to enable protection bits when there doesn't
+ *          exist reg_set.
+ *
+ * This function enables the bus protection bits for disabled power
+ * domains so that the system does not hang when some unit accesses the
+ * bus while in power down.
+ */
+int mtk_infracfg_set_bus_protection_ext(struct regmap *infracfg, u32 mask,
+		u32 reg_set, u32 reg_sta, u32 reg_en)
+{
+	unsigned long expired;
+	u32 val;
+	int ret;
+
+	if (reg_set)
+		regmap_write(infracfg, reg_set, mask);
+	else
+		regmap_update_bits(infracfg, reg_en, mask, mask);
+
+	expired = jiffies + HZ;
+
+	while (1) {
+		ret = regmap_read(infracfg, reg_sta, &val);
+		if (ret)
+			return ret;
+
+		if ((val & mask) == mask)
+			break;
+
+		cpu_relax();
+		if (time_after(jiffies, expired))
+			return -EIO;
+	}
+
+	return 0;
+}
+
+/**
+ * mtk_infracfg_clear_bus_protection_ext - disable bus protection
+ * @regmap: The infracfg regmap
+ * @mask: The mask containing the protection bits to be disabled.
+ * @reg_clr: The register used to disable protection bits.
+ * @reg_sta: The register used to check the protection bits are disabled.
+ * @reg_en: The register used to disable protection bits when there doesn't
+ *          exist reg_clr.
+ *
+ * This function disables the bus protection bits previously enabled with
+ * mtk_infracfg_set_bus_protection.
+ */
+
+int mtk_infracfg_clear_bus_protection_ext(struct regmap *infracfg, u32 mask,
+		u32 reg_clr, u32 reg_sta, u32 reg_en)
+{
+	unsigned long expired;
+	int ret;
+
+	if (reg_clr)
+		regmap_write(infracfg, reg_clr, mask);
+	else
+		regmap_update_bits(infracfg, reg_en, mask, 0);
+
+	expired = jiffies + HZ;
+
+	while (1) {
+		u32 val;
+
+		ret = regmap_read(infracfg, reg_sta, &val);
+		if (ret)
+			return ret;
+
+		if (!(val & mask))
+			break;
+
+		cpu_relax();
+		if (time_after(jiffies, expired))
+			return -EIO;
+	}
+
+	return 0;
+}
diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index ceb2cc4..b181ef2 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -89,6 +89,13 @@ enum clk_id {
 
 #define MAX_CLKS	2
 
+struct bus_prot_ext {
+	u32 set_ofs;
+	u32 clr_ofs;
+	u32 en_ofs;
+	u32 sta_ofs;
+};
+
 struct scp_domain_data {
 	const char *name;
 	u32 sta_mask;
@@ -96,6 +103,7 @@ struct scp_domain_data {
 	u32 sram_pdn_bits;
 	u32 sram_pdn_ack_bits;
 	u32 bus_prot_mask;
+	struct bus_prot_ext bp_ext;
 	enum clk_id clk_id[MAX_CLKS];
 	bool active_wakeup;
 };
@@ -228,8 +236,18 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	}
 
 	if (scpd->data->bus_prot_mask) {
-		ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
-				scpd->data->bus_prot_mask);
+		if (((scpd->data->bp_ext.set_ofs && scpd->data->bp_ext.clr_ofs)
+			|| scpd->data->bp_ext.en_ofs)
+			&& scpd->data->bp_ext.sta_ofs)
+			ret = mtk_infracfg_clear_bus_protection_ext(
+					scp->infracfg,
+					scpd->data->bus_prot_mask,
+					scpd->data->bp_ext.clr_ofs,
+					scpd->data->bp_ext.sta_ofs,
+					scpd->data->bp_ext.en_ofs);
+		else
+			ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
+					scpd->data->bus_prot_mask);
 		if (ret)
 			goto err_pwr_ack;
 	}
@@ -263,8 +281,18 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	int i;
 
 	if (scpd->data->bus_prot_mask) {
-		ret = mtk_infracfg_set_bus_protection(scp->infracfg,
-				scpd->data->bus_prot_mask);
+		if (((scpd->data->bp_ext.set_ofs && scpd->data->bp_ext.clr_ofs)
+			|| scpd->data->bp_ext.en_ofs)
+			&& scpd->data->bp_ext.sta_ofs)
+			ret = mtk_infracfg_set_bus_protection_ext(
+					scp->infracfg,
+					scpd->data->bus_prot_mask,
+					scpd->data->bp_ext.set_ofs,
+					scpd->data->bp_ext.sta_ofs,
+					scpd->data->bp_ext.en_ofs);
+		else
+			ret = mtk_infracfg_set_bus_protection(scp->infracfg,
+					scpd->data->bus_prot_mask);
 		if (ret)
 			goto out;
 	}
diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
index a5714e9..d3fbb45 100644
--- a/include/linux/soc/mediatek/infracfg.h
+++ b/include/linux/soc/mediatek/infracfg.h
@@ -1,6 +1,15 @@
 #ifndef __SOC_MEDIATEK_INFRACFG_H
 #define __SOC_MEDIATEK_INFRACFG_H
 
+#define INFRA_TOPAXI_PROTECTEN		0x0220
+#define INFRA_TOPAXI_PROTECTSTA1	0x0228
+#define INFRA_TOPAXI_PROTECTEN1		0x0250
+#define INFRA_TOPAXI_PROTECTSTA3	0x0258
+#define INFRA_TOPAXI_PROTECTEN_SET	0x0260
+#define INFRA_TOPAXI_PROTECTEN_CLR	0x0264
+#define INFRA_TOPAXI_PROTECTEN1_SET	0x0270
+#define INFRA_TOPAXI_PROTECTEN1_CLR	0x0274
+
 #define MT8173_TOP_AXI_PROT_EN_MCI_M2		BIT(0)
 #define MT8173_TOP_AXI_PROT_EN_MM_M0		BIT(1)
 #define MT8173_TOP_AXI_PROT_EN_MM_M1		BIT(2)
@@ -22,5 +31,8 @@
 
 int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask);
 int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask);
-
+int mtk_infracfg_set_bus_protection_ext(struct regmap *infracfg, u32 mask,
+		u32 reg_set, u32 reg_sta, u32 reg_en);
+int mtk_infracfg_clear_bus_protection_ext(struct regmap *infracfg, u32 mask,
+		u32 reg_clr, u32 reg_sta, u32 reg_en);
 #endif /* __SOC_MEDIATEK_INFRACFG_H */
-- 
1.9.1
