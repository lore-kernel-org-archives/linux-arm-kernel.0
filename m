From: mars.cheng@mediatek.com (Mars Cheng)
Date: Tue, 17 Jul 2018 16:52:28 +0800
Subject: [PATCH v5 07/11] soc: mediatek: add MT6765 subdomain support
In-Reply-To: <1531817552-17221-1-git-send-email-mars.cheng@mediatek.com>
References: <1531817552-17221-1-git-send-email-mars.cheng@mediatek.com>
Message-ID: <1531817552-17221-8-git-send-email-mars.cheng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add extend data, parent_n for domain-subdomain corresponse.

Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
Signed-off-by: Owen Chen <owen.chen@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys-ext.c |  132 ++++++++++++++++++++++++++++++++-
 1 file changed, 131 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys-ext.c b/drivers/soc/mediatek/mtk-scpsys-ext.c
index 965e64d..e649a06 100644
--- a/drivers/soc/mediatek/mtk-scpsys-ext.c
+++ b/drivers/soc/mediatek/mtk-scpsys-ext.c
@@ -13,7 +13,7 @@
 #include <linux/regmap.h>
 #include <linux/soc/mediatek/infracfg.h>
 #include <linux/soc/mediatek/scpsys-ext.h>
-
+#include <dt-bindings/power/mt6765-power.h>
 
 #define MAX_CLKS		10
 #define INFRA			"infracfg"
@@ -65,6 +65,21 @@ struct bus_mask_ops {
 			   u32 sta_ofs, u32 mask);
 };
 
+static struct scpsys_ext_attr *__get_attr_node(const char *scpd_n)
+{
+	struct scpsys_ext_attr *attr;
+
+	if (!scpd_n)
+		return ERR_PTR(-EINVAL);
+
+	list_for_each_entry(attr, &ext_attr_map_list, attr_list) {
+		if (attr->scpd_n && !strcmp(scpd_n, attr->scpd_n))
+			return attr;
+	}
+
+	return ERR_PTR(-EINVAL);
+}
+
 static struct scpsys_ext_attr *__get_attr_parent(const char *parent_n)
 {
 	struct scpsys_ext_attr *attr;
@@ -353,8 +368,123 @@ int scpsys_ext_attr_init(const struct scpsys_ext_data *data)
 	return 0;
 }
 
+/*
+ * MT6765 extend power domain support
+ */
+
+#define INFRA_TOPAXI_PROTECTEN_SET_MT6765	0x02A0
+#define INFRA_TOPAXI_PROTECTEN_STA1_MT6765	0x0228
+#define INFRA_TOPAXI_PROTECTEN_CLR_MT6765	0x02A4
+
+#define INFRA_TOPAXI_PROTECTEN_1_SET_MT6765	0x02A8
+#define INFRA_TOPAXI_PROTECTEN_STA1_1_MT6765	0x0258
+#define INFRA_TOPAXI_PROTECTEN_1_CLR_MT6765	0x02AC
+
+#define SMI_COMMON_SMI_CLAMP_MT6765		0x03C0
+#define SMI_COMMON_SMI_CLAMP_SET_MT6765	0x03C4
+#define SMI_COMMON_SMI_CLAMP_CLR_MT6765	0x03C8
+
+static struct ext_reg_ctrl infra_bus_regs_0_mt6765 = {
+	.type = IFR_TYPE,
+	.set_ofs = INFRA_TOPAXI_PROTECTEN_SET_MT6765,
+	.clr_ofs = INFRA_TOPAXI_PROTECTEN_CLR_MT6765,
+	.sta_ofs = INFRA_TOPAXI_PROTECTEN_STA1_MT6765,
+};
+
+#define BUS_IFR0_MT6765(_mask) {				\
+		.regs = &infra_bus_regs_0_mt6765,		\
+		.mask = _mask,				\
+		.ops = &bus_mask_set_clr_ctrl,		\
+	}
+
+static struct ext_reg_ctrl infra_bus_regs_1_mt6765 = {
+	.type = IFR_TYPE,
+	.set_ofs = INFRA_TOPAXI_PROTECTEN_1_SET_MT6765,
+	.clr_ofs = INFRA_TOPAXI_PROTECTEN_1_CLR_MT6765,
+	.sta_ofs = INFRA_TOPAXI_PROTECTEN_STA1_1_MT6765,
+};
+
+#define BUS_IFR1_MT6765(_mask) {				\
+		.regs = &infra_bus_regs_1_mt6765,		\
+		.mask = _mask,				\
+		.ops = &bus_mask_set_clr_ctrl,		\
+	}
+
+static struct ext_reg_ctrl smi_bus_regs_0_mt6765 = {
+	.type = SMI_TYPE,
+	.set_ofs = SMI_COMMON_SMI_CLAMP_SET_MT6765,
+	.clr_ofs = SMI_COMMON_SMI_CLAMP_CLR_MT6765,
+	.sta_ofs = SMI_COMMON_SMI_CLAMP_MT6765,
+};
+
+#define BUS_SMI0_MT6765(_mask) {				\
+		.regs = &smi_bus_regs_0_mt6765,		\
+		.mask = _mask,				\
+		.ops = &bus_mask_set_clr_ctrl,		\
+	}
+
+static struct scpsys_ext_attr scp_ext_attr_mt6765[] = {
+	[MT6765_POWER_DOMAIN_ISP] = {
+		.scpd_n = "isp",
+		.mask =  {
+			BUS_IFR1_MT6765(BIT(20)),
+			BUS_SMI0_MT6765(BIT(2)),
+		},
+		.parent_n = "mm",
+		.bus_ops = &ext_bus_ctrl,
+		.cg_ops = &ext_cg_ctrl,
+	},
+	[MT6765_POWER_DOMAIN_MM] = {
+		.scpd_n = "mm",
+		.mask = {
+			BUS_IFR1_MT6765(BIT(16) | BIT(17)),
+			BUS_IFR0_MT6765(BIT(10) | BIT(11)),
+			BUS_IFR0_MT6765(BIT(1) | BIT(2)),
+		},
+		.bus_ops = &ext_bus_ctrl,
+		.cg_ops = &ext_cg_ctrl,
+	},
+	[MT6765_POWER_DOMAIN_CONN] = {
+		.scpd_n = "conn",
+		.mask = {
+			BUS_IFR0_MT6765(BIT(13)),
+			BUS_IFR1_MT6765(BIT(18)),
+			BUS_IFR0_MT6765(BIT(14) | BIT(16)),
+		},
+		.bus_ops = &ext_bus_ctrl,
+	},
+	[MT6765_POWER_DOMAIN_MFG] = {
+		.scpd_n = "mfg",
+		.mask = {
+			BUS_IFR0_MT6765(BIT(25)),
+			BUS_IFR0_MT6765(BIT(21) | BIT(22)),
+		},
+		.bus_ops = &ext_bus_ctrl,
+	},
+	[MT6765_POWER_DOMAIN_CAM] = {
+		.scpd_n = "cam",
+		.mask = {
+			BUS_IFR1_MT6765(BIT(19) | BIT(21)),
+			BUS_IFR0_MT6765(BIT(20)),
+			BUS_SMI0_MT6765(BIT(3)),
+		},
+		.parent_n = "mm",
+		.bus_ops = &ext_bus_ctrl,
+		.cg_ops = &ext_cg_ctrl,
+	},
+};
+
+static const struct scpsys_ext_data scp_ext_data_mt6765 = {
+	.attr = scp_ext_attr_mt6765,
+	.num_attr = ARRAY_SIZE(scp_ext_attr_mt6765),
+	.get_attr = __get_attr_node,
+};
+
 static const struct of_device_id of_scpsys_ext_match_tbl[] = {
 	{
+		.compatible = "mediatek,mt6765-scpsys",
+		.data = &scp_ext_data_mt6765,
+	}, {
 		/* sentinel */
 	}
 };
-- 
1.7.9.5
