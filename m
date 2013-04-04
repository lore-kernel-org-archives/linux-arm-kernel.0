From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  4 Apr 2013 11:25:07 +0200
Subject: [PATCH 4/6] ata: i.MX PATA: add devicetree support
In-Reply-To: <1365067509-10186-1-git-send-email-s.hauer@pengutronix.de>
References: <1365067509-10186-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1365067509-10186-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not much to do here, only the compatible entries have to be added.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 Documentation/devicetree/bindings/ata/imx-pata.txt | 17 +++++++++++++++++
 drivers/ata/pata_imx.c                             |  9 +++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/imx-pata.txt

diff --git a/Documentation/devicetree/bindings/ata/imx-pata.txt b/Documentation/devicetree/bindings/ata/imx-pata.txt
new file mode 100644
index 0000000..e38d734
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/imx-pata.txt
@@ -0,0 +1,17 @@
+* Freescale i.MX PATA Controller
+
+Required properties:
+- compatible: "fsl,imx27-pata"
+- reg: Address range of the PATA Controller
+- interrupts: The interrupt of the PATA Controller
+- clocks: the clocks for the PATA Controller
+
+Example:
+
+	pata: pata at 83fe0000 {
+		compatible = "fsl,imx51-pata", "fsl,imx27-pata";
+		reg = <0x83fe0000 0x4000>;
+		interrupts = <70>;
+		clocks = <&clks 161>;
+		status = "disabled";
+	};
diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
index adbb01d..aa3d166 100644
--- a/drivers/ata/pata_imx.c
+++ b/drivers/ata/pata_imx.c
@@ -230,11 +230,20 @@ static const struct dev_pm_ops pata_imx_pm_ops = {
 };
 #endif
 
+static const struct of_device_id imx_pata_dt_ids[] = {
+	{
+		.compatible = "fsl,imx27-pata",
+	}, {
+		/* sentinel */
+	}
+};
+
 static struct platform_driver pata_imx_driver = {
 	.probe		= pata_imx_probe,
 	.remove		= pata_imx_remove,
 	.driver = {
 		.name		= DRV_NAME,
+		.of_match_table	= imx_pata_dt_ids,
 		.owner		= THIS_MODULE,
 #ifdef CONFIG_PM
 		.pm		= &pata_imx_pm_ops,
-- 
1.8.2.rc2
