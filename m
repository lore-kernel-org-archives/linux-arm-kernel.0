From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:43:32 +0100
Subject: [PATCH 142/222] ahci_imx: add disable for spread-spectrum
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeXU-0007Ml-Qs@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Spread-spectrum doesn't work with Cubox-i hardware, so we have to
disable this feature.  Add a DT property so that platforms can
indicate that this feature should not be enabled.

Having it as a negative property keeps existing DT files working.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/imx6q-cubox-i.dts |  1 +
 drivers/ata/ahci_imx.c              | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-cubox-i.dts b/arch/arm/boot/dts/imx6q-cubox-i.dts
index 941365d7ee65..9efd8b0c8011 100644
--- a/arch/arm/boot/dts/imx6q-cubox-i.dts
+++ b/arch/arm/boot/dts/imx6q-cubox-i.dts
@@ -16,4 +16,5 @@
 	fsl,transmit-level-mV = <1104>;
 	fsl,transmit-boost-mdB = <0>;
 	fsl,transmit-atten-16ths = <9>;
+	fsl,no-spread-spectrum;
 };
diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index fa5755f8dff2..e4d5e0266fe0 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -208,6 +208,7 @@ struct reg_property {
 	const struct reg_value *values;
 	size_t num_values;
 	u32 def_value;
+	u32 set_value;
 };
 
 static const struct reg_value gpr13_tx_level[] = {
@@ -305,6 +306,10 @@ static const struct reg_property gpr13_props[] = {
 		.values = gpr13_rx_eq,
 		.num_values = ARRAY_SIZE(gpr13_rx_eq),
 		.def_value = IMX6Q_GPR13_SATA_RX_EQ_VAL_3_0_DB,
+	}, {
+		.name = "fsl,no-spread-spectrum",
+		.def_value = IMX6Q_GPR13_SATA_MPLL_SS_EN,
+		.set_value = 0,
 	},
 };
 
@@ -318,6 +323,14 @@ static u32 imx_ahci_parse_props(struct device *dev,
 	for (i = 0; i < num; i++, prop++) {
 		u32 of_val;
 
+		if (prop->num_values == 0) {
+			if (of_property_read_bool(np, prop->name))
+				reg_value |= prop->set_value;
+			else
+				reg_value |= prop->def_value;
+			continue;
+		}
+
 		if (of_property_read_u32(np, prop->name, &of_val)) {
 			dev_info(dev, "%s not specified, using %08x\n",
 				prop->name, prop->def_value);
@@ -388,7 +401,6 @@ static int imx_ahci_probe(struct platform_device *pdev)
 				   IMX6Q_GPR13_SATA_RX_LOS_LVL_SATA2M |
 				   IMX6Q_GPR13_SATA_RX_DPLL_MODE_2P_4F |
 				   IMX6Q_GPR13_SATA_SPD_MODE_3P0G |
-				   IMX6Q_GPR13_SATA_MPLL_SS_EN |
 				   reg_value;
 	}
 
-- 
1.8.3.1
