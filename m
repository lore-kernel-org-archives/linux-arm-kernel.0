From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 26 Nov 2013 16:32:08 +0900
Subject: [PATCH RFC v2 06/17] ARM: shmobile: Sync Marzen DTS with Marzen
 reference DTS
In-Reply-To: <1385451139-29686-1-git-send-email-horms+renesas@verge.net.au>
References: <1385451139-29686-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1385451139-29686-7-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Copy the device nodes from Marzen reference into the Marzen device tree
file. This will allow us to use a single DTS file regarless of kernel
configuration. In case of legacy C board code the device nodes may or
may not be used, but in the multiplatform case all the DT device nodes
are used.

Based on a similar change for the Lager board by Laurent Pinchart.

Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779-marzen.dts | 81 ++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index ee3fb60..4e1a871 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -25,4 +25,85 @@
 		device_type = "memory";
 		reg = <0x60000000 0x40000000>;
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
+	lan0 at 18000000 {
+		compatible = "smsc,lan9220", "smsc,lan9115";
+		reg = <0x18000000 0x100>;
+		pinctrl-0 = <&lan0_pins>;
+		pinctrl-names = "default";
+
+		phy-mode = "mii";
+		interrupt-parent = <&irqpin0>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+		reg-io-width = <4>;
+		vddvario-supply = <&fixedregulator3v3>;
+		vdd33a-supply = <&fixedregulator3v3>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led2 {
+			gpios = <&gpio4 29 GPIO_ACTIVE_HIGH>;
+		};
+		led3 {
+			gpios = <&gpio4 30 GPIO_ACTIVE_HIGH>;
+		};
+		led4 {
+			gpios = <&gpio4 31 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+&irqpin0 {
+	status = "okay";
+};
+
+&pfc {
+	pinctrl-0 = <&scif2_pins &scif4_pins>;
+	pinctrl-names = "default";
+
+	lan0_pins: lan0 {
+		intc {
+			renesas,groups = "intc_irq1_b";
+			renesas,function = "intc";
+		};
+		lbsc {
+			renesas,groups = "lbsc_ex_cs0";
+			renesas,function = "lbsc";
+		};
+	};
+
+	scif2_pins: serial2 {
+		renesas,groups = "scif2_data_c";
+		renesas,function = "scif2";
+	};
+
+	scif4_pins: serial4 {
+		renesas,groups = "scif4_data";
+		renesas,function = "scif4";
+	};
+
+	sdhi0_pins: sd0 {
+		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd",
+				 "sdhi0_wp";
+		renesas,function = "sdhi0";
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
 };
-- 
1.8.4
