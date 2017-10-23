From: weiyi.lu@mediatek.com (Weiyi Lu)
Date: Mon, 23 Oct 2017 12:10:37 +0800
Subject: [PATCH v6 6/9] soc: mediatek: extend bus protection API
In-Reply-To: <1508731840-4231-1-git-send-email-weiyi.lu@mediatek.com>
References: <1508731840-4231-1-git-send-email-weiyi.lu@mediatek.com>
Message-ID: <1508731840-4231-7-git-send-email-weiyi.lu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MT2712 add "set/clear" bus control register to each control register set
instead of providing only one "enable" control register, we could avoid
the read-modify-write racing by declaring "bus_prot_reg_update" as "false"
in scp_soc_data or declaring as "true" to use the legacy update method.
By improving the mtk-infracfg bus protection implementation to
support set/clear bus protection control method by IC configuration.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-infracfg.c   | 26 ++++++++++++++++++++++----
 drivers/soc/mediatek/mtk-scpsys.c     | 28 ++++++++++++++++++++--------
 include/linux/soc/mediatek/infracfg.h |  7 ++++---
 3 files changed, 46 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-infracfg.c b/drivers/soc/mediatek/mtk-infracfg.c
index dba3055..8c310de 100644
--- a/drivers/soc/mediatek/mtk-infracfg.c
+++ b/drivers/soc/mediatek/mtk-infracfg.c
@@ -19,23 +19,33 @@
 
 #define INFRA_TOPAXI_PROTECTEN		0x0220
 #define INFRA_TOPAXI_PROTECTSTA1	0x0228
+#define INFRA_TOPAXI_PROTECTEN_SET	0x0260
+#define INFRA_TOPAXI_PROTECTEN_CLR	0x0264
 
 /**
  * mtk_infracfg_set_bus_protection - enable bus protection
  * @regmap: The infracfg regmap
  * @mask: The mask containing the protection bits to be enabled.
+ * @reg_update: The boolean flag determines to set the protection bits
+ *              by regmap_update_bits with enable register(PROTECTEN) or
+ *              by regmap_write with set register(PROTECTEN_SET).
  *
  * This function enables the bus protection bits for disabled power
  * domains so that the system does not hang when some unit accesses the
  * bus while in power down.
  */
-int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask)
+int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
+		bool reg_update)
 {
 	unsigned long expired;
 	u32 val;
 	int ret;
 
-	regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask, mask);
+	if (reg_update)
+		regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask,
+				mask);
+	else
+		regmap_write(infracfg, INFRA_TOPAXI_PROTECTEN_SET, mask);
 
 	expired = jiffies + HZ;
 
@@ -59,16 +69,24 @@ int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask)
  * mtk_infracfg_clear_bus_protection - disable bus protection
  * @regmap: The infracfg regmap
  * @mask: The mask containing the protection bits to be disabled.
+ * @reg_update: The boolean flag determines to clear the protection bits
+ *              by regmap_update_bits with enable register(PROTECTEN) or
+ *              by regmap_write with clear register(PROTECTEN_CLR).
  *
  * This function disables the bus protection bits previously enabled with
  * mtk_infracfg_set_bus_protection.
  */
-int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask)
+
+int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask,
+		bool reg_update)
 {
 	unsigned long expired;
 	int ret;
 
-	regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask, 0);
+	if (reg_update)
+		regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask, 0);
+	else
+		regmap_write(infracfg, INFRA_TOPAXI_PROTECTEN_CLR, mask);
 
 	expired = jiffies + HZ;
 
diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index e1ce8b1..ba552de 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -134,6 +134,7 @@ struct scp {
 	void __iomem *base;
 	struct regmap *infracfg;
 	struct scp_ctrl_reg ctrl_reg;
+	bool bus_prot_reg_update;
 };
 
 struct scp_subdomain {
@@ -147,6 +148,7 @@ struct scp_soc_data {
 	const struct scp_subdomain *subdomains;
 	int num_subdomains;
 	const struct scp_ctrl_reg regs;
+	bool bus_prot_reg_update;
 };
 
 static int scpsys_domain_is_on(struct scp_domain *scpd)
@@ -254,7 +256,8 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 
 	if (scpd->data->bus_prot_mask) {
 		ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
-				scpd->data->bus_prot_mask);
+				scpd->data->bus_prot_mask,
+				scp->bus_prot_reg_update);
 		if (ret)
 			goto err_pwr_ack;
 	}
@@ -289,7 +292,8 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 
 	if (scpd->data->bus_prot_mask) {
 		ret = mtk_infracfg_set_bus_protection(scp->infracfg,
-				scpd->data->bus_prot_mask);
+				scpd->data->bus_prot_mask,
+				scp->bus_prot_reg_update);
 		if (ret)
 			goto out;
 	}
@@ -382,7 +386,8 @@ static void init_clks(struct platform_device *pdev, struct clk **clk)
 
 static struct scp *init_scp(struct platform_device *pdev,
 			const struct scp_domain_data *scp_domain_data, int num,
-			const struct scp_ctrl_reg *scp_ctrl_reg)
+			const struct scp_ctrl_reg *scp_ctrl_reg,
+			bool bus_prot_reg_update)
 {
 	struct genpd_onecell_data *pd_data;
 	struct resource *res;
@@ -397,6 +402,8 @@ static struct scp *init_scp(struct platform_device *pdev,
 	scp->ctrl_reg.pwr_sta_offs = scp_ctrl_reg->pwr_sta_offs;
 	scp->ctrl_reg.pwr_sta2nd_offs = scp_ctrl_reg->pwr_sta2nd_offs;
 
+	scp->bus_prot_reg_update = bus_prot_reg_update;
+
 	scp->dev = &pdev->dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -816,7 +823,8 @@ static void mtk_register_power_domains(struct platform_device *pdev,
 	.regs = {
 		.pwr_sta_offs = SPM_PWR_STATUS,
 		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
-	}
+	},
+	.bus_prot_reg_update = true,
 };
 
 static const struct scp_soc_data mt6797_data = {
@@ -827,7 +835,8 @@ static void mtk_register_power_domains(struct platform_device *pdev,
 	.regs = {
 		.pwr_sta_offs = SPM_PWR_STATUS_MT6797,
 		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND_MT6797
-	}
+	},
+	.bus_prot_reg_update = true,
 };
 
 static const struct scp_soc_data mt7622_data = {
@@ -836,7 +845,8 @@ static void mtk_register_power_domains(struct platform_device *pdev,
 	.regs = {
 		.pwr_sta_offs = SPM_PWR_STATUS,
 		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
-	}
+	},
+	.bus_prot_reg_update = true,
 };
 
 static const struct scp_soc_data mt8173_data = {
@@ -847,7 +857,8 @@ static void mtk_register_power_domains(struct platform_device *pdev,
 	.regs = {
 		.pwr_sta_offs = SPM_PWR_STATUS,
 		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
-	}
+	},
+	.bus_prot_reg_update = true,
 };
 
 /*
@@ -884,7 +895,8 @@ static int scpsys_probe(struct platform_device *pdev)
 	match = of_match_device(of_scpsys_match_tbl, &pdev->dev);
 	soc = (const struct scp_soc_data *)match->data;
 
-	scp = init_scp(pdev, soc->domains, soc->num_domains, &soc->regs);
+	scp = init_scp(pdev, soc->domains, soc->num_domains, &soc->regs,
+			soc->bus_prot_reg_update);
 	if (IS_ERR(scp))
 		return PTR_ERR(scp);
 
diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
index a0182ec..67baca2 100644
--- a/include/linux/soc/mediatek/infracfg.h
+++ b/include/linux/soc/mediatek/infracfg.h
@@ -27,7 +27,8 @@
 #define MT7622_TOP_AXI_PROT_EN_WB		(BIT(2) | BIT(6) | \
 						 BIT(7) | BIT(8))
 
-int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask);
-int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask);
-
+int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
+		bool reg_update);
+int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask,
+		bool reg_update);
 #endif /* __SOC_MEDIATEK_INFRACFG_H */
-- 
1.9.1
