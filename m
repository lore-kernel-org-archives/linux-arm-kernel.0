From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Mar 2015 10:58:01 +0900
Subject: [PATCH 01/16] ARM: shmobile: r8a7778: synchronize dts with reference
 platform
In-Reply-To: <cover.1425518337.git.horms+renesas@verge.net.au>
References: <cover.1425518337.git.horms+renesas@verge.net.au>
Message-ID: <8c4892a633f08edbc54b6b59a673f76bd1cd7e94.1425518337.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

This moves everything to the legacy dts that is missing there to make it
suitable for use with multiplatform.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778-bockw.dts | 106 ++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index 46a884d..7347223 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -16,17 +16,123 @@
 
 /dts-v1/;
 #include "r8a7778.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "bockw";
 	compatible = "renesas,bockw", "renesas,r8a7778";
 
+	aliases {
+		serial0 = &scif0;
+	};
+
 	chosen {
 		bootargs = "console=ttySC0,115200 ignore_loglevel ip=dhcp root=/dev/nfs rw";
+		stdout-path = &scif0;
 	};
 
 	memory {
 		device_type = "memory";
 		reg = <0x60000000 0x10000000>;
 	};
+
+	fixedregulator3v3: fixedregulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	ethernet at 18300000 {
+		compatible = "smsc,lan9220", "smsc,lan9115";
+		reg = <0x18300000 0x1000>;
+
+		phy-mode = "mii";
+		interrupt-parent = <&irqpin>;
+		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
+		reg-io-width = <4>;
+		vddvario-supply = <&fixedregulator3v3>;
+		vdd33a-supply = <&fixedregulator3v3>;
+	};
+};
+
+&mmcif {
+	pinctrl-0 = <&mmc_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&fixedregulator3v3>;
+	bus-width = <8>;
+	broken-cd;
+	status = "okay";
+};
+
+&irqpin {
+	status = "okay";
+};
+
+&tmu0 {
+	status = "okay";
+};
+
+&pfc {
+	scif0_pins: serial0 {
+		renesas,groups = "scif0_data_a", "scif0_ctrl";
+		renesas,function = "scif0";
+	};
+
+	mmc_pins: mmc {
+		renesas,groups = "mmc_data8", "mmc_ctrl";
+		renesas,function = "mmc";
+	};
+
+	sdhi0_pins: sd0 {
+		renesas,groups = "sdhi0_data4", "sdhi0_ctrl",
+				  "sdhi0_cd";
+		renesas,function = "sdhi0";
+	};
+
+	hspi0_pins: hspi0 {
+		renesas,groups = "hspi0_a";
+		renesas,function = "hspi0";
+	};
+};
+
+&sdhi0 {
+	pinctrl-0 = <&sdhi0_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&fixedregulator3v3>;
+	bus-width = <4>;
+	status = "okay";
+	wp-gpios = <&gpio3 18 GPIO_ACTIVE_HIGH>;
+};
+
+&hspi0 {
+	pinctrl-0 = <&hspi0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	flash: flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,s25fl008k";
+		reg = <0>;
+		spi-max-frequency = <104000000>;
+		m25p,fast-read;
+
+		partition at 0 {
+			label = "data(spi)";
+			reg = <0x00000000 0x00100000>;
+		};
+	};
+};
+
+&scif0 {
+	pinctrl-0 = <&scif0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
 };
-- 
2.1.4
