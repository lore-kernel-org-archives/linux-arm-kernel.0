From: kbeldan@baylibre.com (Karl Beldan)
Date: Fri,  5 Aug 2016 14:59:43 +0000
Subject: [PATCH v3 1/3] ARM: dts: da850: Add basic DTS for the LCDK
In-Reply-To: <20160805145945.24315-1-kbeldan@baylibre.com>
References: <20160804144332.4841-1-kbeldan@baylibre.com>
 <20160805145945.24315-1-kbeldan@baylibre.com>
Message-ID: <20160805145945.24315-2-kbeldan@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LCDK is the successor to the late Hawkboard.
Among the differences are the flash (16bits vs 8bits) and some pins
(MMC, LEDs, buttons, some external connectors), however the main
components remain the same (eth. phy, audio codec, video decoder and
DAC) except for the main PMIC, different and hard-wired on the LCDK (the
LDOs and DCDCs are always on).
A DT-only boot with this addition gives functional UART, reboot via
watchdog, RTC, ethernet and MMC (I added the CD GPIO for the MMC
although davinci_mmc doesn't call the OF facilities of mmc core).

Cc: Sekhar Nori <nsekhar@ti.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
---
 Documentation/devicetree/bindings/arm/davinci.txt |  4 ++
 arch/arm/boot/dts/Makefile                        |  1 +
 arch/arm/boot/dts/da850-lcdk.dts                  | 70 +++++++++++++++++++++++
 arch/arm/mach-davinci/da8xx-dt.c                  |  1 +
 4 files changed, 76 insertions(+)
 create mode 100644 arch/arm/boot/dts/da850-lcdk.dts

diff --git a/Documentation/devicetree/bindings/arm/davinci.txt b/Documentation/devicetree/bindings/arm/davinci.txt
index cfaeda4..3bd60fd 100644
--- a/Documentation/devicetree/bindings/arm/davinci.txt
+++ b/Documentation/devicetree/bindings/arm/davinci.txt
@@ -5,6 +5,10 @@ DA850/OMAP-L138/AM18x Evaluation Module (EVM) board
 Required root node properties:
     - compatible = "ti,da850-evm", "ti,da850";
 
+DA850/OMAP-L138/AM18x LCDK board
+Required root node properties:
+    - compatible = "ti,da850-lcdk", "ti,da850";
+
 EnBW AM1808 based CMC board
 Required root node properties:
     - compatible = "enbw,cmc", "ti,da850;
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 414b427..c03e8d4 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -105,6 +105,7 @@ dtb-$(CONFIG_ARCH_BERLIN) += \
 dtb-$(CONFIG_ARCH_BRCMSTB) += \
 	bcm7445-bcm97445svmb.dtb
 dtb-$(CONFIG_ARCH_DAVINCI) += \
+	da850-lcdk.dtb \
 	da850-enbw-cmc.dtb \
 	da850-evm.dtb
 dtb-$(CONFIG_ARCH_DIGICOLOR) += \
diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
new file mode 100644
index 0000000..dbcca0b
--- /dev/null
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -0,0 +1,70 @@
+/*
+ * Copyright (c) 2016 BayLibre, Inc.
+ *
+ * Licensed under GPLv2.
+ */
+/dts-v1/;
+#include "da850.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "DA850/AM1808/OMAP-L138 LCDK";
+	compatible = "ti,da850-lcdk", "ti,da850";
+
+	aliases {
+		serial2 = &serial2;
+	};
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0xc0000000 0x08000000>;
+	};
+};
+
+&pmx_core {
+	status = "okay";
+};
+
+&serial2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&serial2_rxtx_pins>;
+	status = "okay";
+};
+
+&wdt {
+	status = "okay";
+};
+
+&rtc0 {
+	status = "okay";
+};
+
+&gpio {
+	status = "okay";
+};
+
+&mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mdio_pins>;
+	bus_freq = <2200000>;
+	status = "okay";
+};
+
+&eth0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mii_pins>;
+	status = "okay";
+};
+
+&mmc0 {
+	max-frequency = <50000000>;
+	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins>;
+	cd-gpios = <&gpio 64 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 754f478..ca99711 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -49,6 +49,7 @@ static void __init da850_init_machine(void)
 
 static const char *const da850_boards_compat[] __initconst = {
 	"enbw,cmc",
+	"ti,da850-lcdk",
 	"ti,da850-evm",
 	"ti,da850",
 	NULL,
-- 
2.9.0.rc1
