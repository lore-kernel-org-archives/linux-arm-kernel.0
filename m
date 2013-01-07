From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  7 Jan 2013 23:56:44 +0100
Subject: [PATCH 08/11] ARM: nomadik: migrate MMC/SD card support to device tree
Message-ID: <1357599404-7587-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves over the MMC/SD card support to the device tree probe
path. The special GPIO to bias the card detect line is kept,
but the pin property is moved to the device tree as part of
the MMC/SD card node.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-s8815.dts    |  7 +++++
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 13 ++++++++
 arch/arm/mach-nomadik/cpu-8815.c           | 48 +++++++++++++++++++++++++++++-
 3 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-s8815.dts b/arch/arm/boot/dts/ste-nomadik-s8815.dts
index ff8a440..a123971 100644
--- a/arch/arm/boot/dts/ste-nomadik-s8815.dts
+++ b/arch/arm/boot/dts/ste-nomadik-s8815.dts
@@ -24,4 +24,11 @@
 			interrupt-parent = <&gpio3>;
 		};
 	};
+
+	/* This GPIO needs to be driven to enable card detect */
+	amba {
+		mmcsd: sdi at 101f6000 {
+			cd-bias-gpios = <&gpio3 16 0x1>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index 43b6d8c..1a12f10 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -187,5 +187,18 @@
 			interrupt-parent = <&vica>;
 			interrupts = <10>;
 		};
+
+		mmcsd: sdi at 101f6000 {
+			compatible = "arm,pl18x", "arm,primecell";
+			reg = <0x101f6000 0x1000>;
+			interrupt-parent = <&vica>;
+			interrupts = <22>;
+			max-frequency = <48000000>;
+			bus-width = <4>;
+			mmc-cap-mmc-highspeed;
+			mmc-cap-sd-highspeed;
+			cd-gpios = <&gpio3 15 0x1>;
+			cd-inverted;
+		};
 	};
 };
diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index 06f9a5b..3078c1c 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -35,6 +35,7 @@
 #include <linux/of_platform.h>
 #include <linux/mtd/fsmc.h>
 #include <linux/gpio.h>
+#include <linux/amba/mmci.h>
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
@@ -310,6 +311,50 @@ static int __init cpu8815_eth_init(void)
 }
 device_initcall(cpu8815_eth_init);
 
+/*
+ * TODO:
+ * cannot be set from device tree, convert to a proper DT
+ * binding.
+ */
+static struct mmci_platform_data mmcsd_plat_data = {
+	.ocr_mask = MMC_VDD_29_30,
+};
+
+/*
+ * This GPIO pin turns on a line that is used to detect card insertion
+ * on this board.
+ */
+static int __init cpu8815_mmcsd_init(void)
+{
+	struct device_node *cdbias;
+	int gpio, err;
+
+	cdbias = of_find_node_by_path("/amba/sdi at 101f6000");
+	if (!cdbias) {
+		pr_info("could not find MMC/SD controller node\n");
+		return 0;
+	}
+	gpio = of_get_named_gpio(cdbias, "cd-bias-gpios", 0);
+	if (gpio < 0) {
+		pr_info("could not obtain MMC/SD controller GPIO\n");
+		return 0;
+	}
+	err = gpio_request(gpio, "card detect bias");
+	if (err) {
+		pr_info("failed to request card detect bias GPIO %d\n", gpio);
+		return -ENODEV;
+	}
+	err = gpio_direction_output(gpio, 0);
+	if (err){
+		pr_info("failed to set GPIO %d as output, low\n", gpio);
+		return err;
+	}
+	pr_info("enabled CD bias GPIO %d, low\n", gpio);
+	return 0;
+}
+device_initcall(cpu8815_mmcsd_init);
+
+
 /* These are mostly to get the right device names for the clock lookups */
 static struct of_dev_auxdata cpu8815_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("st,nomadik-gpio", NOMADIK_GPIO0_BASE,
@@ -332,7 +377,8 @@ static struct of_dev_auxdata cpu8815_auxdata_lookup[] __initdata = {
 		"rtc-pl031", NULL),
 	OF_DEV_AUXDATA("stericsson,fsmc-nand", NOMADIK_FSMC_BASE,
 		"fsmc-nand", &cpu8815_nand_data),
-
+	OF_DEV_AUXDATA("arm,primecell", NOMADIK_SDI_BASE,
+		"mmci", &mmcsd_plat_data),
 	{ /* sentinel */ },
 };
 
-- 
1.7.11.7
