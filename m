From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 22 Oct 2012 18:17:56 +0800
Subject: [PATCH 2/5] ARM: at91: atmel-ssc: add device tree support
In-Reply-To: <1350901079-18307-1-git-send-email-voice.shen@atmel.com>
References: <1350901079-18307-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1350901079-18307-2-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Atmel SSC for device tree support.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 .../devicetree/bindings/misc/atmel-ssc.txt         |   15 ++++++
 arch/arm/boot/dts/at91sam9260.dtsi                 |    8 ++++
 arch/arm/boot/dts/at91sam9263.dtsi                 |   16 +++++++
 arch/arm/boot/dts/at91sam9g45.dtsi                 |   16 +++++++
 arch/arm/boot/dts/at91sam9x5.dtsi                  |    8 ++++
 arch/arm/mach-at91/at91rm9200.c                    |    3 ++
 arch/arm/mach-at91/at91sam9260.c                   |    1 +
 arch/arm/mach-at91/at91sam9261.c                   |    3 ++
 arch/arm/mach-at91/at91sam9263.c                   |    2 +
 arch/arm/mach-at91/at91sam9g45.c                   |    2 +
 arch/arm/mach-at91/at91sam9rl.c                    |    2 +
 arch/arm/mach-at91/at91sam9x5.c                    |    1 +
 drivers/misc/atmel-ssc.c                           |   48 ++++++++++++++++++--
 13 files changed, 122 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/atmel-ssc.txt

diff --git a/Documentation/devicetree/bindings/misc/atmel-ssc.txt b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
new file mode 100644
index 0000000..ff5ea22
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
@@ -0,0 +1,15 @@
+* Atmel SSC driver.
+
+Required properties:
+- compatible: "atmel,at91rm9200_ssc" or "atmel,at91sam9g45_ssc"
+	- atmel,at91rm9200_ssc: support pdc transfer
+	- atmel,at91sam9g45_ssc: support dma transfer
+- reg: Should contain SSC registers location and length
+- interrupts: Should contain SSC interrupt
+
+Example:
+ssc0: ssc at fffbc000 {
+	compatible = "atmel,at91rm9200-ssc";
+	reg = <0xfffbc000 0x4000>;
+	interrupts = <14 4 5>;
+};
diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index d410581..aaa42d8 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -29,6 +29,7 @@
 		tcb0 = &tcb0;
 		tcb1 = &tcb1;
 		i2c0 = &i2c0;
+		ssc0 = &ssc0;
 	};
 	cpus {
 		cpu at 0 {
@@ -212,6 +213,13 @@
 				status = "disabled";
 			};
 
+			ssc0: ssc at fffbc000 {
+				compatible = "atmel,at91rm9200-ssc";
+				reg = <0xfffbc000 0x4000>;
+				interrupts = <14 4 5>;
+				status = "disable";
+			};
+
 			adc0: adc at fffe0000 {
 				compatible = "atmel,at91sam9260-adc";
 				reg = <0xfffe0000 0x100>;
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 3e6e5c1..3b721ee 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -25,6 +25,8 @@
 		gpio4 = &pioE;
 		tcb0 = &tcb0;
 		i2c0 = &i2c0;
+		ssc0 = &ssc0;
+		ssc1 = &ssc1;
 	};
 	cpus {
 		cpu at 0 {
@@ -173,6 +175,20 @@
 				status = "disabled";
 			};
 
+			ssc0: ssc at fff98000 {
+				compatible = "atmel,at91rm9200-ssc";
+				reg = <0xfff98000 0x4000>;
+				interrupts = <16 4 5>;
+				status = "disable";
+			};
+
+			ssc1: ssc at fff9c000 {
+				compatible = "atmel,at91rm9200-ssc";
+				reg = <0xfff9c000 0x4000>;
+				interrupts = <17 4 5>;
+				status = "disable";
+			};
+
 			macb0: ethernet at fffbc000 {
 				compatible = "cdns,at32ap7000-macb", "cdns,macb";
 				reg = <0xfffbc000 0x100>;
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 3add030..cd9af7c 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -31,6 +31,8 @@
 		tcb1 = &tcb1;
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
+		ssc0 = &ssc0;
+		ssc1 = &ssc1;
 	};
 	cpus {
 		cpu at 0 {
@@ -226,6 +228,20 @@
 				status = "disabled";
 			};
 
+			ssc0: ssc at fff9c000 {
+				compatible = "atmel,at91sam9g45-ssc";
+				reg = <0xfff9c000 0x4000>;
+				interrupts = <16 4 5>;
+				status = "disable";
+			};
+
+			ssc0: ssc at fffa0000 {
+				compatible = "atmel,at91sam9g45-ssc";
+				reg = <0xfffa0000 0x4000>;
+				interrupts = <17 4 5>;
+				status = "disable";
+			};
+
 			adc0: adc at fffb0000 {
 				compatible = "atmel,at91sam9260-adc";
 				reg = <0xfffb0000 0x100>;
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 03fc136..69667d0 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -30,6 +30,7 @@
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
+		ssc0 = &ssc0;
 	};
 	cpus {
 		cpu at 0 {
@@ -87,6 +88,13 @@
 				interrupts = <1 4 7>;
 			};
 
+			ssc0: ssc at f0010000 {
+				compatible = "atmel,at91sam9g45-ssc";
+				reg = <0xf0010000 0x4000>;
+				interrupts = <28 4 5>;
+				status = "disable";
+			};
+
 			tcb0: timer at f8008000 {
 				compatible = "atmel,at91sam9x5-tcb";
 				reg = <0xf8008000 0x100>;
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 85d53c5..6d65feb 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -187,6 +187,9 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("pclk", "at91rm9200_ssc.0", &ssc0_clk),
 	CLKDEV_CON_DEV_ID("pclk", "at91rm9200_ssc.1", &ssc1_clk),
 	CLKDEV_CON_DEV_ID("pclk", "at91rm9200_ssc.2", &ssc2_clk),
+	CLKDEV_CON_DEV_ID("pclk", "fffd0000.ssc", &ssc0_clk),
+	CLKDEV_CON_DEV_ID("pclk", "fffd4000.ssc", &ssc1_clk),
+	CLKDEV_CON_DEV_ID("pclk", "fffd8000.ssc", &ssc2_clk),
 	CLKDEV_CON_DEV_ID(NULL, "i2c-at91rm9200", &twi_clk),
 	/* fake hclk clock */
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &ohci_clk),
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 2c8aab0..54d4aea 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -211,6 +211,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t1_clk", "atmel_tcb.1", &tc4_clk),
 	CLKDEV_CON_DEV_ID("t2_clk", "atmel_tcb.1", &tc5_clk),
 	CLKDEV_CON_DEV_ID("pclk", "at91rm9200_ssc.0", &ssc_clk),
+	CLKDEV_CON_DEV_ID("pclk", "fffbc000.ssc", &ssc_clk),
 	CLKDEV_CON_DEV_ID(NULL, "i2c-at91sam9260", &twi_clk),
 	CLKDEV_CON_DEV_ID(NULL, "i2c-at91sam9g20", &twi_clk),
 	/* more usart lookup table for DT entries */
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 4e8c56e..5c7a482 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -177,6 +177,9 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("pclk", "at91rm9200_ssc.0", &ssc0_clk),
 	CLKDEV_CON_DEV_ID("pclk", "at91rm9200_ssc.1", &ssc1_clk),
 	CLKDEV_CON_DEV_ID("pclk", "at91rm9200_ssc.2", &ssc2_clk),
+	CLKDEV_CON_DEV_ID("pclk", "fffbc000.ssc", &ssc0_clk),
+	CLKDEV_CON_DEV_ID("pclk", "fffc0000.ssc", &ssc1_clk),
+	CLKDEV_CON_DEV_ID("pclk", "fffc4000.ssc", &ssc2_clk),
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &hck0),
 	CLKDEV_CON_DEV_ID(NULL, "i2c-at91sam9261", &twi_clk),
 	CLKDEV_CON_DEV_ID(NULL, "i2c-at91sam9g10", &twi_clk),
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 95a5471..1f523de 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -188,6 +188,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_ID("hclk", &macb_clk),
 	CLKDEV_CON_DEV_ID("pclk", "at91rm9200_ssc.0", &ssc0_clk),
 	CLKDEV_CON_DEV_ID("pclk", "at91rm9200_ssc.1", &ssc1_clk),
+	CLKDEV_CON_DEV_ID("pclk", "fff98000.ssc", &ssc0_clk),
+	CLKDEV_CON_DEV_ID("pclk", "fff9c000.ssc", &ssc1_clk),
 	CLKDEV_CON_DEV_ID("mci_clk", "atmel_mci.0", &mmc0_clk),
 	CLKDEV_CON_DEV_ID("mci_clk", "atmel_mci.1", &mmc1_clk),
 	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.0", &spi0_clk),
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index f4f96a6..a4282d3 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -241,6 +241,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID(NULL, "i2c-at91sam9g10.1", &twi1_clk),
 	CLKDEV_CON_DEV_ID("pclk", "at91sam9g45_ssc.0", &ssc0_clk),
 	CLKDEV_CON_DEV_ID("pclk", "at91sam9g45_ssc.1", &ssc1_clk),
+	CLKDEV_CON_DEV_ID("pclk", "fff9c000.ssc", &ssc0_clk),
+	CLKDEV_CON_DEV_ID("pclk", "fffa0000.ssc", &ssc1_clk),
 	CLKDEV_CON_DEV_ID(NULL, "atmel-trng", &trng_clk),
 	CLKDEV_CON_DEV_ID(NULL, "atmel_sha", &aestdessha_clk),
 	CLKDEV_CON_DEV_ID(NULL, "atmel_tdes", &aestdessha_clk),
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 4110b54..b683fdc 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -186,6 +186,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t2_clk", "atmel_tcb.0", &tc2_clk),
 	CLKDEV_CON_DEV_ID("pclk", "at91rm9200_ssc.0", &ssc0_clk),
 	CLKDEV_CON_DEV_ID("pclk", "at91rm9200_ssc.1", &ssc1_clk),
+	CLKDEV_CON_DEV_ID("pclk", "fffc0000.ssc", &ssc0_clk),
+	CLKDEV_CON_DEV_ID("pclk", "fffc4000.ssc", &ssc1_clk),
 	CLKDEV_CON_DEV_ID(NULL, "i2c-at91sam9g20.0", &twi0_clk),
 	CLKDEV_CON_DEV_ID(NULL, "i2c-at91sam9g20.1", &twi1_clk),
 	CLKDEV_CON_ID("pioA", &pioA_clk),
diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
index e503538..18fbbb2 100644
--- a/arch/arm/mach-at91/at91sam9x5.c
+++ b/arch/arm/mach-at91/at91sam9x5.c
@@ -231,6 +231,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t0_clk", "f800c000.timer", &tcb0_clk),
 	CLKDEV_CON_DEV_ID("dma_clk", "ffffec00.dma-controller", &dma0_clk),
 	CLKDEV_CON_DEV_ID("dma_clk", "ffffee00.dma-controller", &dma1_clk),
+	CLKDEV_CON_DEV_ID("pclk", "f0010000.ssc", &ssc_clk),
 	CLKDEV_CON_DEV_ID(NULL, "f8010000.i2c", &twi0_clk),
 	CLKDEV_CON_DEV_ID(NULL, "f8014000.i2c", &twi1_clk),
 	CLKDEV_CON_DEV_ID(NULL, "f8018000.i2c", &twi2_clk),
diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index f40abd8..929d29a 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -18,6 +18,8 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 
+#include <linux/of.h>
+
 /* Serialize access to ssc_list and user count */
 static DEFINE_SPINLOCK(user_lock);
 static LIST_HEAD(ssc_list);
@@ -29,7 +31,13 @@ struct ssc_device *ssc_request(unsigned int ssc_num)
 
 	spin_lock(&user_lock);
 	list_for_each_entry(ssc, &ssc_list, list) {
-		if (ssc->pdev->id == ssc_num) {
+		if (ssc->pdev->dev.of_node) {
+			if (of_alias_get_id(ssc->pdev->dev.of_node, "ssc")
+				== ssc_num) {
+				ssc_valid = 1;
+				break;
+			}
+		} else if (ssc->pdev->id == ssc_num) {
 			ssc_valid = 1;
 			break;
 		}
@@ -88,10 +96,41 @@ static const struct platform_device_id atmel_ssc_devtypes[] = {
 	}
 };
 
+#ifdef CONFIG_OF
+static const struct of_device_id atmel_ssc_dt_ids[] = {
+	{
+		.compatible = "atmel,at91rm9200-ssc",
+		.data = &at91rm9200_config,
+	}, {
+		.compatible = "atmel,at91sam9g45-ssc",
+		.data = &at91sam9g45_config,
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(of, atmel_ssc_dt_ids);
+#endif
+
+static inline const struct atmel_ssc_platform_data * __init
+	atmel_ssc_get_driver_data(struct platform_device *pdev)
+{
+	if (pdev->dev.of_node) {
+		const struct of_device_id *match;
+		match = of_match_node(atmel_ssc_dt_ids, pdev->dev.of_node);
+		if (match == NULL)
+			return NULL;
+		return match->data;
+	}
+
+	return (struct atmel_ssc_platform_data *)
+		platform_get_device_id(pdev)->driver_data;
+}
+
 static int ssc_probe(struct platform_device *pdev)
 {
 	struct resource *regs;
 	struct ssc_device *ssc;
+	const struct atmel_ssc_platform_data *plat_dat;
 
 	ssc = devm_kzalloc(&pdev->dev, sizeof(struct ssc_device), GFP_KERNEL);
 	if (!ssc) {
@@ -100,8 +139,10 @@ static int ssc_probe(struct platform_device *pdev)
 	}
 
 	ssc->pdev = pdev;
-	ssc->pdata = (struct atmel_ssc_platform_data *)
-			platform_get_device_id(pdev)->driver_data;
+
+	plat_dat = atmel_ssc_get_driver_data(pdev);
+	if (!plat_dat)
+		return -ENODEV;
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!regs) {
@@ -160,6 +201,7 @@ static struct platform_driver ssc_driver = {
 	.driver		= {
 		.name		= "ssc",
 		.owner		= THIS_MODULE,
+		.of_match_table	= of_match_ptr(atmel_ssc_dt_ids),
 	},
 	.id_table	= atmel_ssc_devtypes,
 	.probe		= ssc_probe,
-- 
1.7.9.5
