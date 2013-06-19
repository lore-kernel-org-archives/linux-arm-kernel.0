From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed, 19 Jun 2013 23:54:37 +0400
Subject: [PATCH v2 6/7] drivers: bus: imx-weim: Add support for
 i.MX1/21/25/27/31/35/50/51/53
In-Reply-To: <1371671678-6345-1-git-send-email-shc_work@mail.ru>
References: <1371671678-6345-1-git-send-email-shc_work@mail.ru>
Message-ID: <1371671678-6345-6-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 Documentation/devicetree/bindings/bus/imx-weim.txt | 11 +++++++----
 drivers/bus/Kconfig                                |  4 ++--
 drivers/bus/imx-weim.c                             | 23 ++++++++++++++++++++++
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/imx-weim.txt b/Documentation/devicetree/bindings/bus/imx-weim.txt
index cedc2a9..99406e4 100644
--- a/Documentation/devicetree/bindings/bus/imx-weim.txt
+++ b/Documentation/devicetree/bindings/bus/imx-weim.txt
@@ -8,7 +8,7 @@ The actual devices are instantiated from the child nodes of a WEIM node.
 
 Required properties:
 
- - compatible:		Should be set to "fsl,imx6q-weim"
+ - compatible:		Should be set to "fsl,<soc>-weim"
  - reg:			A resource specifier for the register space
 			(see the example below)
  - clocks:		the clock, see the example below.
@@ -21,11 +21,14 @@ Required properties:
 
 Timing property for child nodes. It is mandatory, not optional.
 
- - fsl,weim-cs-timing:	The timing array, contains 6 timing values for the
+ - fsl,weim-cs-timing:	The timing array, contains timing values for the
 			child node. We can get the CS index from the child
-			node's "reg" property. This property contains the values
-			for the registers EIM_CSnGCR1, EIM_CSnGCR2, EIM_CSnRCR1,
+			node's "reg" property. For example, if i.MX6Q CPU
+			is used, this property contains the values for the
+			registers EIM_CSnGCR1, EIM_CSnGCR2, EIM_CSnRCR1,
 			EIM_CSnRCR2, EIM_CSnWCR1, EIM_CSnWCR2 in this order.
+			For other i.MX CPUs count of register and register
+			names may be different.
 
 Example for an imx6q-sabreauto board, the NOR flash connected to the WEIM:
 
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 1f70e84..4faedc21 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -8,10 +8,10 @@ config IMX_WEIM
 	bool "Freescale EIM DRIVER"
 	depends on ARCH_MXC
 	help
-	  Driver for i.MX6 WEIM controller.
+	  Driver for i.MX WEIM controller.
 	  The WEIM(Wireless External Interface Module) works like a bus.
 	  You can attach many different devices on it, such as NOR, onenand.
-	  But now, we only support the Parallel NOR.
+	  But now, we only support the "of_physmap" driver.
 
 config MVEBU_MBUS
 	bool
diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index b6479fb..77fa1d4 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -17,6 +17,17 @@ struct imx_weim_devtype {
 	unsigned int	cs_regs_count;
 	unsigned int	cs_stride;
 };
+static const struct imx_weim_devtype imx1_weim_devtype = {
+	.cs_count	= 6,
+	.cs_regs_count	= 2,
+	.cs_stride	= 0x08,
+};
+
+static const struct imx_weim_devtype imx25_weim_devtype = {
+	.cs_count	= 6,
+	.cs_regs_count	= 3,
+	.cs_stride	= 0x10,
+};
 
 static const struct imx_weim_devtype imx50_weim_devtype = {
 	.cs_count	= 4,
@@ -24,9 +35,21 @@ static const struct imx_weim_devtype imx50_weim_devtype = {
 	.cs_stride	= 0x18,
 };
 
+static const struct imx_weim_devtype imx51_weim_devtype = {
+	.cs_count	= 6,
+	.cs_regs_count	= 6,
+	.cs_stride	= 0x18,
+};
+
 static const struct of_device_id weim_id_table[] = {
+	/* i.MX1/21 */
+	{ .compatible = "fsl,imx1-weim", .data = &imx1_weim_devtype, },
+	/* i.MX25/27/31/35 */
+	{ .compatible = "fsl,imx25-weim", .data = &imx25_weim_devtype, },
 	/* i.MX50/53/6Q */
 	{ .compatible = "fsl,imx6q-weim", .data = &imx50_weim_devtype, },
+	/* i.MX51 */
+	{ .compatible = "fsl,imx51-weim", .data = &imx51_weim_devtype, },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, weim_id_table);
-- 
1.8.1.5
