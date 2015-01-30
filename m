From: agross@codeaurora.org (Andy Gross)
Date: Fri, 30 Jan 2015 00:25:30 -0600
Subject: [Patch v2 1/6] soc: qcom: gsbi: Add support for ADM CRCI muxing
In-Reply-To: <1422599135-5588-1-git-send-email-agross@codeaurora.org>
References: <1422599135-5588-1-git-send-email-agross@codeaurora.org>
Message-ID: <1422599135-5588-2-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds automatic configuration for the ADM CRCI muxing required to
support DMA operations for GSBI clients.  The GSBI mode and instance determine
the correct TCSR ADM CRCI MUX value that must be programmed so that the DMA
works properly.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 .../devicetree/bindings/soc/qcom/qcom,gsbi.txt     |   18 ++-
 drivers/soc/qcom/Kconfig                           |    1 +
 drivers/soc/qcom/qcom_gsbi.c                       |  153 ++++++++++++++++++++
 3 files changed, 171 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,gsbi.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,gsbi.txt
index 4ce24d4..8fe7b37 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,gsbi.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,gsbi.txt
@@ -6,7 +6,7 @@ configuration settings.  The mode setting will govern the input/output mode of
 the 4 GSBI IOs.
 
 Required properties:
-- compatible: must contain "qcom,gsbi-v1.0.0" for APQ8064/IPQ8064
+- compatible:	Should contain "qcom,gsbi-v1.0.0"
 - reg: Address range for GSBI registers
 - clocks: required clock
 - clock-names: must contain "iface" entry
@@ -16,12 +16,16 @@ Required properties:
 Optional properties:
 - qcom,crci : indicates CRCI MUX value for QUP CRCI ports.  Please reference
   dt-bindings/soc/qcom,gsbi.h for valid CRCI mux values.
+- syscon-tcsr: indicates phandle of TCSR syscon node.  Required if child uses
+  dma.
 
 Required properties if child node exists:
 - #address-cells: Must be 1
 - #size-cells: Must be 1
 - ranges: Must be present
 
+Note: Each GSBI should have an alias correctly numbered in "aliases" node.
+
 Properties for children:
 
 A GSBI controller node can contain 0 or more child nodes representing serial
@@ -37,6 +41,10 @@ Example for APQ8064:
 
 #include <dt-bindings/soc/qcom,gsbi.h>
 
+	aliases {
+		gsbi4 = <&gsbi4>;
+	};
+
 	gsbi4 at 16300000 {
 		compatible = "qcom,gsbi-v1.0.0";
 		reg = <0x16300000 0x100>;
@@ -48,6 +56,8 @@ Example for APQ8064:
 		qcom,mode = <GSBI_PROT_I2C_UART>;
 		qcom,crci = <GSBI_CRCI_QUP>;
 
+		syscon-tcsr = <&tcsr>;
+
 		/* child nodes go under here */
 
 		i2c_qup4: i2c at 16380000 {
@@ -76,3 +86,9 @@ Example for APQ8064:
 		};
 	};
 
+	tcsr: syscon at 1a400000 {
+		compatible = "qcom,apq8064-tcsr", "syscon";
+		reg = <0x1a400000 0x100>;
+	};
+
+
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 7bd2c94..460b2db 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -4,6 +4,7 @@
 config QCOM_GSBI
         tristate "QCOM General Serial Bus Interface"
         depends on ARCH_QCOM
+        select MFD_SYSCON
         help
           Say y here to enable GSBI support.  The GSBI provides control
           functions for connecting the underlying serial UART, SPI, and I2C
diff --git a/drivers/soc/qcom/qcom_gsbi.c b/drivers/soc/qcom/qcom_gsbi.c
index 729425d..2208a3d 100644
--- a/drivers/soc/qcom/qcom_gsbi.c
+++ b/drivers/soc/qcom/qcom_gsbi.c
@@ -18,22 +18,129 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include <dt-bindings/soc/qcom,gsbi.h>
 
 #define GSBI_CTRL_REG		0x0000
 #define GSBI_PROTOCOL_SHIFT	4
+#define MAX_GSBI		12
+
+#define TCSR_ADM_CRCI_BASE	0x70
+
+struct crci_config {
+	u32 num_rows;
+	const u32 (*array)[MAX_GSBI];
+};
+
+static const u32 crci_ipq8064[][MAX_GSBI] = {
+	{
+		0x000003, 0x00000c, 0x000030, 0x0000c0,
+		0x000300, 0x000c00, 0x003000, 0x00c000,
+		0x030000, 0x0c0000, 0x300000, 0xc00000
+	},
+	{
+		0x000003, 0x00000c, 0x000030, 0x0000c0,
+		0x000300, 0x000c00, 0x003000, 0x00c000,
+		0x030000, 0x0c0000, 0x300000, 0xc00000
+	},
+};
+
+static const struct crci_config config_ipq8064 = {
+	.num_rows = ARRAY_SIZE(crci_ipq8064),
+	.array = crci_ipq8064,
+};
+
+static const unsigned int crci_apq8064[][MAX_GSBI] = {
+	{
+		0x001800, 0x006000, 0x000030, 0x0000c0,
+		0x000300, 0x000400, 0x000000, 0x000000,
+		0x000000, 0x000000, 0x000000, 0x000000
+	},
+	{
+		0x000000, 0x000000, 0x000000, 0x000000,
+		0x000000, 0x000020, 0x0000c0, 0x000000,
+		0x000000, 0x000000, 0x000000, 0x000000
+	},
+};
+
+static const struct crci_config config_apq8064 = {
+	.num_rows = ARRAY_SIZE(crci_apq8064),
+	.array = crci_apq8064,
+};
+
+static const unsigned int crci_msm8960[][MAX_GSBI] = {
+	{
+		0x000003, 0x00000c, 0x000030, 0x0000c0,
+		0x000300, 0x000400, 0x000000, 0x000000,
+		0x000000, 0x000000, 0x000000, 0x000000
+	},
+	{
+		0x000000, 0x000000, 0x000000, 0x000000,
+		0x000000, 0x000020, 0x0000c0, 0x000300,
+		0x001800, 0x006000, 0x000000, 0x000000
+	},
+};
+
+static const struct crci_config config_msm8960 = {
+	.num_rows = ARRAY_SIZE(crci_msm8960),
+	.array = crci_msm8960,
+};
+
+static const unsigned int crci_msm8660[][MAX_GSBI] = {
+	{	/* ADM 0 - B */
+		0x000003, 0x00000c, 0x000030, 0x0000c0,
+		0x000300, 0x000c00, 0x003000, 0x00c000,
+		0x030000, 0x0c0000, 0x300000, 0xc00000
+	},
+	{	/* ADM 0 - B */
+		0x000003, 0x00000c, 0x000030, 0x0000c0,
+		0x000300, 0x000c00, 0x003000, 0x00c000,
+		0x030000, 0x0c0000, 0x300000, 0xc00000
+	},
+	{	/* ADM 1 - A */
+		0x000003, 0x00000c, 0x000030, 0x0000c0,
+		0x000300, 0x000c00, 0x003000, 0x00c000,
+		0x030000, 0x0c0000, 0x300000, 0xc00000
+	},
+	{	/* ADM 1 - B */
+		0x000003, 0x00000c, 0x000030, 0x0000c0,
+		0x000300, 0x000c00, 0x003000, 0x00c000,
+		0x030000, 0x0c0000, 0x300000, 0xc00000
+	},
+};
+
+static const struct crci_config config_msm8660 = {
+	.num_rows = ARRAY_SIZE(crci_msm8660),
+	.array = crci_msm8660,
+};
 
 struct gsbi_info {
 	struct clk *hclk;
 	u32 mode;
 	u32 crci;
+	struct regmap *tcsr;
+};
+
+static const struct of_device_id tcsr_dt_match[] = {
+	{ .compatible = "qcom,tcsr-ipq8064", .data = &config_ipq8064},
+	{ .compatible = "qcom,tcsr-apq8064", .data = &config_apq8064},
+	{ .compatible = "qcom,tcsr-msm8960", .data = &config_msm8960},
+	{ .compatible = "qcom,tcsr-msm8660", .data = &config_msm8660},
+	{ },
 };
 
 static int gsbi_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
+	struct device_node *tcsr_node;
+	const struct of_device_id *match;
 	struct resource *res;
 	void __iomem *base;
 	struct gsbi_info *gsbi;
+	int i, gsbi_num;
+	u32 mask;
+	const struct crci_config *config = NULL;
 
 	gsbi = devm_kzalloc(&pdev->dev, sizeof(*gsbi), GFP_KERNEL);
 
@@ -45,6 +152,33 @@ static int gsbi_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
+	/* get the tcsr node and setup the config and regmap */
+	gsbi->tcsr = syscon_regmap_lookup_by_phandle(node, "syscon-tcsr");
+
+	if (!IS_ERR(gsbi->tcsr)) {
+		tcsr_node = of_parse_phandle(node, "syscon-tcsr", 0);
+		if (tcsr_node) {
+			match = of_match_node(tcsr_dt_match, tcsr_node);
+			if (match)
+				config = match->data;
+			else
+				dev_warn(&pdev->dev, "no matching TCSR\n");
+
+			of_node_put(tcsr_node);
+		}
+	}
+
+	gsbi_num = of_alias_get_id(node, "gsbi");
+	if (gsbi_num < 0) {
+		dev_err(&pdev->dev, "missing alias\n");
+		return -EINVAL;
+	}
+
+	if (!gsbi_num || gsbi_num > MAX_GSBI) {
+		dev_err(&pdev->dev, "invalid gsbi number\n");
+		return -EINVAL;
+	}
+
 	if (of_property_read_u32(node, "qcom,mode", &gsbi->mode)) {
 		dev_err(&pdev->dev, "missing mode configuration\n");
 		return -EINVAL;
@@ -64,6 +198,25 @@ static int gsbi_probe(struct platform_device *pdev)
 	writel_relaxed((gsbi->mode << GSBI_PROTOCOL_SHIFT) | gsbi->crci,
 				base + GSBI_CTRL_REG);
 
+	/*
+	 * modify tcsr to reflect mode and ADM CRCI mux
+	 * Each gsbi contains a pair of bits, one for RX and one for TX
+	 * SPI mode requires both bits cleared, otherwise they are set
+	 */
+	if (config) {
+		for (i = 0; i < config->num_rows; i++) {
+			mask = config->array[i][gsbi_num - 1];
+
+			if (gsbi->mode == GSBI_PROT_SPI)
+				regmap_update_bits(gsbi->tcsr,
+					TCSR_ADM_CRCI_BASE + 4 * i, mask, 0);
+			else
+				regmap_update_bits(gsbi->tcsr,
+					TCSR_ADM_CRCI_BASE + 4 * i, mask, mask);
+
+		}
+	}
+
 	/* make sure the gsbi control write is not reordered */
 	wmb();
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
