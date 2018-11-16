From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 16 Nov 2018 16:49:27 +0100
Subject: [PATCH 3/3] soc: imx: gpcv2: add support for i.MX8MQ SoC
In-Reply-To: <20181116154927.16152-1-l.stach@pengutronix.de>
References: <20181116154927.16152-1-l.stach@pengutronix.de>
Message-ID: <20181116154927.16152-3-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPCv2 on the Freescale i.MX8MQ SoC works in the same way as the
GPCv2 on the i.MX7, but only controls more power domains with a
different mapping.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 .../bindings/power/fsl,imx-gpcv2.txt          |   7 +-
 drivers/soc/imx/Kconfig                       |   6 +-
 drivers/soc/imx/Makefile                      |   2 +-
 drivers/soc/imx/gpcv2.c                       | 208 +++++++++++++++++-
 include/dt-bindings/power/imx8mq-power.h      |  21 ++
 5 files changed, 237 insertions(+), 7 deletions(-)
 create mode 100644 include/dt-bindings/power/imx8mq-power.h

diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
index 9acce75b29ab..7c947a996df1 100644
--- a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
+++ b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
@@ -6,7 +6,9 @@ Control (PGC) for various power domains.
 
 Required properties:
 
-- compatible: Should be "fsl,imx7d-gpc"
+- compatible: Should be one of:
+	- "fsl,imx7d-gpc"
+	- "fsl,imx8mq-gpc"
 
 - reg: should be register base and length as documented in the
   datasheet
@@ -22,7 +24,8 @@ which, in turn, is expected to contain the following:
 Required properties:
 
 - reg: Power domain index. Valid values are defined in
-  include/dt-bindings/power/imx7-power.h
+  include/dt-bindings/power/imx7-power.h for fsl,imx7d-gpc and
+  include/dt-bindings/power/imx8m-power.h for fsl,imx8mq-gpc
 
 - #power-domain-cells: Should be 0
 
diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index a5b86a28f343..2112d18dbb7b 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -1,8 +1,8 @@
 menu "i.MX SoC drivers"
 
-config IMX7_PM_DOMAINS
-	bool "i.MX7 PM domains"
-	depends on SOC_IMX7D || (COMPILE_TEST && OF)
+config IMX_GPCV2_PM_DOMAINS
+	bool "i.MX GPCv2 PM domains"
+	depends on SOC_IMX7D || SOC_IMX8MQ || (COMPILE_TEST && OF)
 	depends on PM
 	select PM_GENERIC_DOMAINS
 	default y if SOC_IMX7D
diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index aab41a5cc317..506a6f3c2b9b 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
-obj-$(CONFIG_IMX7_PM_DOMAINS) += gpcv2.o
+obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index fe2cf6b61b05..8b4f48a2ca57 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -14,24 +14,55 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <dt-bindings/power/imx7-power.h>
+#include <dt-bindings/power/imx8mq-power.h>
 
 #define GPC_LPCR_A_CORE_BSC			0x000
 
 #define GPC_PGC_CPU_MAPPING		0x0ec
+
 #define IMX7_USB_HSIC_PHY_A_CORE_DOMAIN		BIT(6)
 #define IMX7_USB_OTG2_PHY_A_CORE_DOMAIN		BIT(5)
 #define IMX7_USB_OTG1_PHY_A_CORE_DOMAIN		BIT(4)
 #define IMX7_PCIE_PHY_A_CORE_DOMAIN		BIT(3)
 #define IMX7_MIPI_PHY_A_CORE_DOMAIN		BIT(2)
 
+#define IMX8M_PCIE2_A53_DOMAIN			BIT(15)
+#define IMX8M_MIPI_CSI2_A53_DOMAIN		BIT(14)
+#define IMX8M_MIPI_CSI1_A53_DOMAIN		BIT(13)
+#define IMX8M_DISP_A53_DOMAIN			BIT(12)
+#define IMX8M_HDMI_A53_DOMAIN			BIT(11)
+#define IMX8M_VPU_A53_DOMAIN			BIT(10)
+#define IMX8M_GPU_A53_DOMAIN			BIT(9)
+#define IMX8M_DDR2_A53_DOMAIN			BIT(8)
+#define IMX8M_DDR1_A53_DOMAIN			BIT(7)
+#define IMX8M_OTG2_A53_DOMAIN			BIT(5)
+#define IMX8M_OTG1_A53_DOMAIN			BIT(4)
+#define IMX8M_PCIE1_A53_DOMAIN			BIT(3)
+#define IMX8M_MIPI_A53_DOMAIN			BIT(2)
+
 #define GPC_PU_PGC_SW_PUP_REQ		0x0f8
 #define GPC_PU_PGC_SW_PDN_REQ		0x104
+
 #define IMX7_USB_HSIC_PHY_SW_Pxx_REQ		BIT(4)
 #define IMX7_USB_OTG2_PHY_SW_Pxx_REQ		BIT(3)
 #define IMX7_USB_OTG1_PHY_SW_Pxx_REQ		BIT(2)
 #define IMX7_PCIE_PHY_SW_Pxx_REQ		BIT(1)
 #define IMX7_MIPI_PHY_SW_Pxx_REQ		BIT(0)
 
+#define IMX8M_PCIE2_SW_Pxx_REQ			BIT(13)
+#define IMX8M_MIPI_CSI2_SW_Pxx_REQ		BIT(12)
+#define IMX8M_MIPI_CSI1_SW_Pxx_REQ		BIT(11)
+#define IMX8M_DISP_SW_Pxx_REQ			BIT(10)
+#define IMX8M_HDMI_SW_Pxx_REQ			BIT(9)
+#define IMX8M_VPU_SW_Pxx_REQ			BIT(8)
+#define IMX8M_GPU_SW_Pxx_REQ			BIT(7)
+#define IMX8M_DDR2_SW_Pxx_REQ			BIT(6)
+#define IMX8M_DDR1_SW_Pxx_REQ			BIT(5)
+#define IMX8M_OTG2_SW_Pxx_REQ			BIT(3)
+#define IMX8M_OTG1_SW_Pxx_REQ			BIT(2)
+#define IMX8M_PCIE1_SW_Pxx_REQ			BIT(1)
+#define IMX8M_MIPI_SW_Pxx_REQ			BIT(0)
+
 #define GPC_M4_PU_PDN_FLG		0x1bc
 
 /*
@@ -43,6 +74,19 @@
 #define IMX7_PGC_MIPI			16
 #define IMX7_PGC_PCIE			17
 #define IMX7_PGC_USB_HSIC		20
+
+#define IMX8M_PGC_MIPI			16
+#define IMX8M_PGC_PCIE1			17
+#define IMX8M_PGC_OTG1			18
+#define IMX8M_PGC_OTG2			19
+#define IMX8M_PGC_DDR1			21
+#define IMX8M_PGC_GPU			23
+#define IMX8M_PGC_VPU			24
+#define IMX8M_PGC_DISP			26
+#define IMX8M_PGC_MIPI_CSI1		27
+#define IMX8M_PGC_MIPI_CSI2		28
+#define IMX8M_PGC_PCIE2			29
+
 #define GPC_PGC_CTRL(n)			(0x800 + (n) * 0x40)
 #define GPC_PGC_SR(n)			(GPC_PGC_CTRL(n) + 0xc)
 
@@ -221,6 +265,167 @@ static const struct imx_pgc_domain_data imx7_pgc_domain_data = {
 	.reg_access_table = &imx7_access_table,
 };
 
+static const struct imx_pgc_domain imx8m_pgc_domains[] = {
+	[IMX8M_POWER_DOMAIN_MIPI] = {
+		.genpd = {
+			.name      = "mipi",
+		},
+		.bits  = {
+			.pxx = IMX8M_MIPI_SW_Pxx_REQ,
+			.map = IMX8M_MIPI_A53_DOMAIN,
+		},
+		.pgc	   = IMX8M_PGC_MIPI,
+	},
+
+	[IMX8M_POWER_DOMAIN_PCIE1] = {
+		.genpd = {
+			.name = "pcie1",
+		},
+		.bits  = {
+			.pxx = IMX8M_PCIE1_SW_Pxx_REQ,
+			.map = IMX8M_PCIE1_A53_DOMAIN,
+		},
+		.pgc   = IMX8M_PGC_PCIE1,
+	},
+
+	[IMX8M_POWER_DOMAIN_USB_OTG1] = {
+		.genpd = {
+			.name = "usb-otg1",
+		},
+		.bits  = {
+			.pxx = IMX8M_OTG1_SW_Pxx_REQ,
+			.map = IMX8M_OTG1_A53_DOMAIN,
+		},
+		.pgc   = IMX8M_PGC_OTG1,
+	},
+
+	[IMX8M_POWER_DOMAIN_USB_OTG2] = {
+		.genpd = {
+			.name = "usb-otg2",
+		},
+		.bits  = {
+			.pxx = IMX8M_OTG2_SW_Pxx_REQ,
+			.map = IMX8M_OTG2_A53_DOMAIN,
+		},
+		.pgc   = IMX8M_PGC_OTG2,
+	},
+
+	[IMX8M_POWER_DOMAIN_DDR1] = {
+		.genpd = {
+			.name = "ddr1",
+		},
+		.bits  = {
+			.pxx = IMX8M_DDR1_SW_Pxx_REQ,
+			.map = IMX8M_DDR2_A53_DOMAIN,
+		},
+		.pgc   = IMX8M_PGC_DDR1,
+	},
+
+	[IMX8M_POWER_DOMAIN_GPU] = {
+		.genpd = {
+			.name = "gpu",
+		},
+		.bits  = {
+			.pxx = IMX8M_GPU_SW_Pxx_REQ,
+			.map = IMX8M_GPU_A53_DOMAIN,
+		},
+		.pgc   = IMX8M_PGC_GPU,
+	},
+
+	[IMX8M_POWER_DOMAIN_VPU] = {
+		.genpd = {
+			.name = "vpu",
+		},
+		.bits  = {
+			.pxx = IMX8M_VPU_SW_Pxx_REQ,
+			.map = IMX8M_VPU_A53_DOMAIN,
+		},
+		.pgc   = IMX8M_PGC_VPU,
+	},
+
+	[IMX8M_POWER_DOMAIN_DISP] = {
+		.genpd = {
+			.name = "disp",
+		},
+		.bits  = {
+			.pxx = IMX8M_DISP_SW_Pxx_REQ,
+			.map = IMX8M_DISP_A53_DOMAIN,
+		},
+		.pgc   = IMX8M_PGC_DISP,
+	},
+
+	[IMX8M_POWER_DOMAIN_MIPI_CSI1] = {
+		.genpd = {
+			.name = "mipi-csi1",
+		},
+		.bits  = {
+			.pxx = IMX8M_MIPI_CSI1_SW_Pxx_REQ,
+			.map = IMX8M_MIPI_CSI1_A53_DOMAIN,
+		},
+		.pgc   = IMX8M_PGC_MIPI_CSI1,
+	},
+
+	[IMX8M_POWER_DOMAIN_MIPI_CSI2] = {
+		.genpd = {
+			.name = "mipi-csi2",
+		},
+		.bits  = {
+			.pxx = IMX8M_MIPI_CSI2_SW_Pxx_REQ,
+			.map = IMX8M_MIPI_CSI2_A53_DOMAIN,
+		},
+		.pgc   = IMX8M_PGC_MIPI_CSI2,
+	},
+
+	[IMX8M_POWER_DOMAIN_PCIE2] = {
+		.genpd = {
+			.name = "pcie2",
+		},
+		.bits  = {
+			.pxx = IMX8M_PCIE2_SW_Pxx_REQ,
+			.map = IMX8M_PCIE2_A53_DOMAIN,
+		},
+		.pgc   = IMX8M_PGC_PCIE2,
+	},
+};
+
+static const struct regmap_range imx8m_yes_ranges[] = {
+		regmap_reg_range(GPC_LPCR_A_CORE_BSC,
+				 GPC_M4_PU_PDN_FLG),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8M_PGC_MIPI),
+				 GPC_PGC_SR(IMX8M_PGC_MIPI)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8M_PGC_PCIE1),
+				 GPC_PGC_SR(IMX8M_PGC_PCIE1)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8M_PGC_OTG1),
+				 GPC_PGC_SR(IMX8M_PGC_OTG1)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8M_PGC_OTG2),
+				 GPC_PGC_SR(IMX8M_PGC_OTG2)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8M_PGC_DDR1),
+				 GPC_PGC_SR(IMX8M_PGC_DDR1)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8M_PGC_GPU),
+				 GPC_PGC_SR(IMX8M_PGC_GPU)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8M_PGC_VPU),
+				 GPC_PGC_SR(IMX8M_PGC_VPU)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8M_PGC_DISP),
+				 GPC_PGC_SR(IMX8M_PGC_DISP)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8M_PGC_MIPI_CSI1),
+				 GPC_PGC_SR(IMX8M_PGC_MIPI_CSI1)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8M_PGC_MIPI_CSI2),
+				 GPC_PGC_SR(IMX8M_PGC_MIPI_CSI2)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8M_PGC_PCIE2),
+				 GPC_PGC_SR(IMX8M_PGC_PCIE2)),
+};
+
+static const struct regmap_access_table imx8m_access_table = {
+	.yes_ranges	= imx8m_yes_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(imx8m_yes_ranges),
+};
+
+static const struct imx_pgc_domain_data imx8m_pgc_domain_data = {
+	.domains = imx8m_pgc_domains,
+	.domains_num = ARRAY_SIZE(imx8m_pgc_domains),
+	.reg_access_table = &imx8m_access_table,
+};
+
 static int imx_pgc_domain_probe(struct platform_device *pdev)
 {
 	struct imx_pgc_domain *domain = pdev->dev.platform_data;
@@ -235,7 +440,7 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 				dev_err(domain->dev, "Failed to get domain's regulator\n");
 			return PTR_ERR(domain->regulator);
 		}
-	} else {
+	} else if (domain->voltage) {
 		regulator_set_voltage(domain->regulator,
 				      domain->voltage, domain->voltage);
 	}
@@ -376,6 +581,7 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 
 static const struct of_device_id imx_gpcv2_dt_ids[] = {
 	{ .compatible = "fsl,imx7d-gpc", .data = &imx7_pgc_domain_data, },
+	{ .compatible = "fsl,imx8mq-gpc", .data = &imx8m_pgc_domain_data, },
 	{ }
 };
 
diff --git a/include/dt-bindings/power/imx8mq-power.h b/include/dt-bindings/power/imx8mq-power.h
new file mode 100644
index 000000000000..8a513bd9166e
--- /dev/null
+++ b/include/dt-bindings/power/imx8mq-power.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ *  Copyright (C) 2018 Pengutronix, Lucas Stach <kernel@pengutronix.de>
+ */
+
+#ifndef __DT_BINDINGS_IMX8MQ_POWER_H__
+#define __DT_BINDINGS_IMX8MQ_POWER_H__
+
+#define IMX8M_POWER_DOMAIN_MIPI		0
+#define IMX8M_POWER_DOMAIN_PCIE1	1
+#define IMX8M_POWER_DOMAIN_USB_OTG1	2
+#define IMX8M_POWER_DOMAIN_USB_OTG2	3
+#define IMX8M_POWER_DOMAIN_DDR1		4
+#define IMX8M_POWER_DOMAIN_GPU		5
+#define IMX8M_POWER_DOMAIN_VPU		6
+#define IMX8M_POWER_DOMAIN_DISP		7
+#define IMX8M_POWER_DOMAIN_MIPI_CSI1	8
+#define IMX8M_POWER_DOMAIN_MIPI_CSI2	9
+#define IMX8M_POWER_DOMAIN_PCIE2	10
+
+#endif
-- 
2.19.1
