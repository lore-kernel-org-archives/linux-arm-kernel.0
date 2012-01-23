From: hs@denx.de (Heiko Schocher)
Date: Mon, 23 Jan 2012 09:56:06 +0100
Subject: [RFC PATCH 6/7] ARM: mtd: nand: davinci: add OF support for davinci
 nand controller
In-Reply-To: <1327308967-8092-1-git-send-email-hs@denx.de>
References: <1327308967-8092-1-git-send-email-hs@denx.de>
Message-ID: <1327308967-8092-7-git-send-email-hs@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add OF support for the davinci nand controller.

Signed-off-by: Heiko Schocher <hs@denx.de>
Cc: davinci-linux-open-source at linux.davincidsp.com
Cc: linux-arm-kernel at lists.infradead.org
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-mtd at lists.infradead.org
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Wolfgang Denk <wd@denx.de>
---
 .../devicetree/bindings/arm/davinci/nand.txt       |   72 ++++++++++++++++++
 drivers/mtd/nand/davinci_nand.c                    |   78 +++++++++++++++++++-
 2 files changed, 148 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/davinci/nand.txt

diff --git a/Documentation/devicetree/bindings/arm/davinci/nand.txt b/Documentation/devicetree/bindings/arm/davinci/nand.txt
new file mode 100644
index 0000000..7e8d6db
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/davinci/nand.txt
@@ -0,0 +1,72 @@
+* Texas Instruments Davinci NAND
+
+This file provides information, what the device node for the
+davinci nand interface contain.
+
+Required properties:
+- compatible: "ti,davinci-nand";
+- reg : contain 2 offset/length values:
+        - offset and length for the access window
+        - offset and length for accessing the aemif control registers
+- id: id of the controller
+
+Recommended properties :
+- mask_ale: mask for ale
+- mask_cle: mask for cle
+- mask_chipsel: mask for chipselect
+- ecc_mode: ECC mode, see NAND_ECC_* defines
+- ecc_bits: used ECC bits
+- options: nand options, defined in
+           include/linux/mtd/nand.h, grep for NAND_NO_AUTOINCR
+- bbt_options: NAND_BBT_* defines
+
+Optional properties:
+- pinmux-handle: contains a handle to configure the pinmux settings.
+- timing-handle: contains a handle to setup aemif timing.
+
+Example (enbw_cmc board):
+aemif at 60000000 {
+	compatible = "ti,davinci-aemif";
+	#address-cells = <2>;
+	#size-cells = <1>;
+	reg = <0x68000000 0x80000>;
+	ranges = <2 0 0x60000000 0x02000000
+		  3 0 0x62000000 0x02000000
+		  4 0 0x64000000 0x02000000
+		  5 0 0x66000000 0x02000000
+		  6 0 0x68000000 0x02000000>;
+	nand_cs: cs3 at 68000000 {
+		compatible = "ti,davinci-cs";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		/* all timings in nanoseconds */
+		cs = <3>;
+		asize = <0>;
+		ta = <0>;
+		rhold = <7>;
+		rstrobe = <42>;
+		rsetup = <7>;
+		whold = <7>;
+		wstrobe = <14>;
+		wsetup = <7>;
+		ew = <0>;
+		ss = <0>;
+	};
+	nandflash at 3,0 {
+		compatible = "ti,davinci-nand";
+		reg = <3 0x0 0x807ff
+			6 0x0 0x8000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		id = <1>;
+		mask_ale = <0>;
+		mask_cle = <0>;
+		mask_chipsel = <0>;
+		ecc_mode = <2>;
+		ecc_bits = <4>;
+		options = <0>;
+		bbt_options = <0x20000>;
+		pinmux-handle = <&nand_pins>;
+		timing-handle = <&nand_cs>;
+	};
+};
diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
index 6e56615..a1946c3 100644
--- a/drivers/mtd/nand/davinci_nand.c
+++ b/drivers/mtd/nand/davinci_nand.c
@@ -33,9 +33,12 @@
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/slab.h>
+#include <linux/of_i2c.h>
+#include <linux/of_device.h>
 
 #include <mach/nand.h>
 #include <mach/aemif.h>
+#include <mach/mux.h>
 
 /*
  * This is a device driver for the NAND flash controller found on the
@@ -518,9 +521,76 @@ static struct nand_ecclayout hwecc4_2048 __initconst = {
 	},
 };
 
+#if defined(CONFIG_OF)
+static const struct of_device_id davinci_nand_of_match[] = {
+	{.compatible = "ti,davinci-nand", },
+	{},
+}
+MODULE_DEVICE_TABLE(of, davinci_nand_of_match);
+
+static struct davinci_nand_pdata
+	*nand_davinci_get_pdata(struct platform_device *pdev)
+{
+	if ((pdev->dev.platform_data == NULL) &&
+		(pdev->dev.of_node)) {
+		struct device_node *tmp_np;
+		struct davinci_nand_pdata *pdata;
+		u32 prop;
+
+		pdata =  kzalloc(sizeof(struct davinci_nand_pdata),
+				GFP_KERNEL);
+		pdev->dev.platform_data = pdata;
+		if (!pdata)
+			return NULL;
+		if (!of_property_read_u32(pdev->dev.of_node, "id",
+			&prop))
+			pdev->id = prop;
+		if (!of_property_read_u32(pdev->dev.of_node, "mask_ale",
+			&prop))
+			pdata->mask_ale = prop;
+		if (!of_property_read_u32(pdev->dev.of_node, "mask_cle",
+			&prop))
+			pdata->mask_cle = prop;
+		if (!of_property_read_u32(pdev->dev.of_node, "mask_chipsel",
+			&prop))
+			pdata->mask_chipsel = prop;
+		if (!of_property_read_u32(pdev->dev.of_node, "ecc_mode",
+			&prop))
+			pdata->ecc_mode = prop;
+		if (!of_property_read_u32(pdev->dev.of_node, "ecc_bits",
+			&prop))
+			pdata->ecc_bits = prop;
+		if (!of_property_read_u32(pdev->dev.of_node, "options",
+			&prop))
+			pdata->options = prop;
+		if (!of_property_read_u32(pdev->dev.of_node, "bbt_options",
+			&prop))
+			pdata->bbt_options = prop;
+		tmp_np = of_parse_phandle(pdev->dev.of_node,
+				"pinmux-handle", 0);
+		if (tmp_np)
+			davinci_cfg_reg_of(tmp_np);
+
+		tmp_np = of_parse_phandle(pdev->dev.of_node,
+				"timing-handle", 0);
+		if (tmp_np)
+			davinci_aemif_setup_timing_of(tmp_np);
+	}
+
+	return pdev->dev.platform_data;
+}
+#else
+#define davinci_nand_of_match NULL
+static struct davinci_nand_pdata
+	*nand_davinci_get_pdata(struct platform_device *pdev)
+{
+	return pdev->dev.platform_data;
+}
+#endif
+
 static int __init nand_davinci_probe(struct platform_device *pdev)
 {
-	struct davinci_nand_pdata	*pdata = pdev->dev.platform_data;
+	struct davinci_nand_pdata	*pdata;
 	struct davinci_nand_info	*info;
 	struct resource			*res1;
 	struct resource			*res2;
@@ -530,6 +600,7 @@ static int __init nand_davinci_probe(struct platform_device *pdev)
 	uint32_t			val;
 	nand_ecc_modes_t		ecc_mode;
 
+	pdata = nand_davinci_get_pdata(pdev);
 	/* insist on board-specific configuration */
 	if (!pdata)
 		return -ENODEV;
@@ -812,16 +883,19 @@ static int __exit nand_davinci_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver nand_davinci_driver = {
+	.probe		= nand_davinci_probe,
 	.remove		= __exit_p(nand_davinci_remove),
 	.driver		= {
 		.name	= "davinci_nand",
+		.owner	= THIS_MODULE,
+		.of_match_table = davinci_nand_of_match,
 	},
 };
 MODULE_ALIAS("platform:davinci_nand");
 
 static int __init nand_davinci_init(void)
 {
-	return platform_driver_probe(&nand_davinci_driver, nand_davinci_probe);
+	return platform_driver_register(&nand_davinci_driver);
 }
 module_init(nand_davinci_init);
 
-- 
1.7.7.5
