From: mporter@ti.com (Matt Porter)
Date: Thu, 11 Oct 2012 15:04:41 -0400
Subject: [RFC PATCH v2 16/16] ARM: dts: add AM33XX SPI support
In-Reply-To: <1349982281-10785-1-git-send-email-mporter@ti.com>
References: <1349982281-10785-1-git-send-email-mporter@ti.com>
Message-ID: <1349982281-10785-17-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds AM33XX SPI support to the am33xx.dtsi and the BeagleBone
dts.

Signed-off-by: Matt Porter <mporter@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts |   17 +++++++++++++++
 arch/arm/boot/dts/am33xx.dtsi     |   43 +++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 5510979..23edfd8 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -18,6 +18,17 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 
+	am3358_pinmux: pinmux at 44e10800 {
+		spi1_pins: pinmux_spi1_pins {
+			pinctrl-single,pins = <
+				0x190 0x13	/* mcasp0_aclkx.spi1_sclk, OUTPUT_PULLUP | MODE3 */
+				0x194 0x33	/* mcasp0_fsx.spi1_d0, INPUT_PULLUP | MODE3 */
+				0x198 0x13	/* mcasp0_axr0.spi1_d1, OUTPUT_PULLUP | MODE3 */
+				0x19c 0x13	/* mcasp0_ahclkr.spi1_cs0, OUTPUT_PULLUP | MODE3 */
+			>;
+		};
+	};
+
 	ocp {
 		uart1: serial at 44e09000 {
 			status = "okay";
@@ -84,3 +95,9 @@
 &mmc1 {
 	vmmc-supply = <&ldo3_reg>;
 };
+
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_pins>;
+};
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index ef8e105..854235e 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -40,6 +40,15 @@
 		};
 	};
 
+	am3358_pinmux: pinmux at 44e10800 {
+		compatible = "pinctrl-single";
+		reg = <0x44e10800 0x0238>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x7f>;
+	};
+
 	/*
 	 * XXX: Use a flat representation of the AM33XX interconnect.
 	 * The real AM33XX interconnect network is quite complex.Since
@@ -260,6 +269,40 @@
 			status = "disabled";
 		};
 
+		spi0: spi at 48030000 {
+			compatible = "ti,omap4-mcspi";
+			ti,hwmods = "spi0";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x48030000 0x400>;
+			interrupt-parent = <&intc>;
+			interrupt = <65>;
+			dmas = <&edma 16
+				&edma 17
+				&edma 18
+				&edma 19>;
+			dma-names = "tx0", "rx0", "tx1", "rx1";
+			ti,spi-num-cs = <2>;
+			status = "disabled";
+		};
+
+		spi1: spi at 481a0000 {
+			compatible = "ti,omap4-mcspi";
+			ti,hwmods = "spi1";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x481a0000 0x400>;
+			interrupt-parent = <&intc>;
+			interrupt = <125>;
+			dmas = <&edma 42
+				&edma 43
+				&edma 44
+				&edma 45>;
+			dma-names = "tx0", "rx0", "tx1", "rx1";
+			ti,spi-num-cs = <2>;
+			status = "disabled";
+		};
+
 		wdt2: wdt at 44e35000 {
 			compatible = "ti,omap3-wdt";
 			ti,hwmods = "wd_timer2";
-- 
1.7.9.5
