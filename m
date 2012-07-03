From: andrew@lunn.ch (Andrew Lunn)
Date: Tue,  3 Jul 2012 16:22:43 +0200
Subject: [PATCH v2 10/12] ATA: sata_mv: Add device tree support
In-Reply-To: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
Message-ID: <1341325365-21393-11-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for instantiating this driver from device tree, and add
the necassary DT information to the kirkwood.dtsi file.

This is based on previous work by Michael Walle and Jason Cooper.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 Documentation/devicetree/bindings/ata/marvell.txt |   16 ++++++++
 arch/arm/boot/dts/kirkwood.dtsi                   |    7 ++++
 arch/arm/mach-kirkwood/board-dt.c                 |    1 +
 drivers/ata/sata_mv.c                             |   42 ++++++++++++++-------
 4 files changed, 53 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/marvell.txt

diff --git a/Documentation/devicetree/bindings/ata/marvell.txt b/Documentation/devicetree/bindings/ata/marvell.txt
new file mode 100644
index 0000000..b5cdd20
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/marvell.txt
@@ -0,0 +1,16 @@
+* Marvell Orion SATA
+
+Required Properties:
+- compatibility : "marvell,orion-sata"
+- reg           : Address range of controller
+- interrupts    : Interrupt controller is using
+- nr-ports      : Number of SATA ports in use.
+
+Example:
+
+	sata at 80000 {
+		compatible = "marvell,orion-sata";
+		reg = <0x80000 0x5000>;
+		interrupts = <21>;
+		nr-ports = <2>;
+	}
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index be8e127..ec31b8b 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -75,6 +75,13 @@
 			status = "okay";
 		};
 
+		sata at 80000 {
+			compatible = "marvell,orion-sata";
+			reg = <0x80000 0x5000>;
+			interrupts = <21>;
+			status = "disabled";
+		};
+
 		nand at 3000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 73e75cf..d0ad250 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -31,6 +31,7 @@ struct of_dev_auxdata kirkwood_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("marvell,mv64xxx-i2c", 0xf1011000, "mv64xxx_i2c.0",
 		       NULL),
 	OF_DEV_AUXDATA("marvell,orion-wdt", 0xf1020300, "orion_wdt", NULL),
+	OF_DEV_AUXDATA("marvell,orion-sata", 0xf1080000, "sata_mv.0", NULL),
 	{},
 };
 
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 24712ad..8282367 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -65,6 +65,8 @@
 #include <linux/mbus.h>
 #include <linux/bitops.h>
 #include <linux/gfp.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_device.h>
@@ -4026,7 +4028,7 @@ static int mv_platform_probe(struct platform_device *pdev)
 	struct ata_host *host;
 	struct mv_host_priv *hpriv;
 	struct resource *res;
-	int n_ports = 0;
+	int n_ports = 0, irq = 0;
 	int rc;
 #if defined(CONFIG_HAVE_CLK)
 	int port;
@@ -4050,8 +4052,14 @@ static int mv_platform_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	/* allocate host */
-	mv_platform_data = pdev->dev.platform_data;
-	n_ports = mv_platform_data->n_ports;
+	if (pdev->dev.of_node) {
+		of_property_read_u32(pdev->dev.of_node, "nr-ports", &n_ports);
+		irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
+	} else {
+		mv_platform_data = pdev->dev.platform_data;
+		n_ports = mv_platform_data->n_ports;
+		irq = platform_get_irq(pdev, 0);
+	}
 
 	host = ata_host_alloc_pinfo(&pdev->dev, ppi, n_ports);
 	hpriv = devm_kzalloc(&pdev->dev, sizeof(*hpriv), GFP_KERNEL);
@@ -4109,8 +4117,7 @@ static int mv_platform_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "slots %u ports %d\n",
 		 (unsigned)MV_MAX_Q_DEPTH, host->n_ports);
 
-	rc = ata_host_activate(host, platform_get_irq(pdev, 0), mv_interrupt,
-			       IRQF_SHARED, &mv6_sht);
+	rc = ata_host_activate(host, irq, mv_interrupt, IRQF_SHARED, &mv6_sht);
 	if (!rc)
 		return 0;
 
@@ -4205,15 +4212,24 @@ static int mv_platform_resume(struct platform_device *pdev)
 #define mv_platform_resume NULL
 #endif
 
+#ifdef CONFIG_OF
+static struct of_device_id mv_sata_dt_ids[] __devinitdata = {
+	{ .compatible = "marvell,orion-sata", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mvsdio_dt_ids);
+#endif
+
 static struct platform_driver mv_platform_driver = {
-	.probe			= mv_platform_probe,
-	.remove			= __devexit_p(mv_platform_remove),
-	.suspend		= mv_platform_suspend,
-	.resume			= mv_platform_resume,
-	.driver			= {
-				   .name = DRV_NAME,
-				   .owner = THIS_MODULE,
-				  },
+	.probe		= mv_platform_probe,
+	.remove		= __devexit_p(mv_platform_remove),
+	.suspend	= mv_platform_suspend,
+	.resume		= mv_platform_resume,
+	.driver		= {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(mv_sata_dt_ids),
+	},
 };
 
 
-- 
1.7.10
