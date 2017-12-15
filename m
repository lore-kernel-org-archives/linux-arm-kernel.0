From: nm@ti.com (Nishanth Menon)
Date: Fri, 15 Dec 2017 07:20:56 -0600
Subject: [PATCH 2/8] ARM: dts: keystone*: Use a single soc0 instance
In-Reply-To: <20171215132102.435-1-nm@ti.com>
References: <20171215132102.435-1-nm@ti.com>
Message-ID: <20171215132102.435-3-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide and soc0 node and reference the same to simplify dts. This also
resolves the following warnings when built with W=1:
arch/arm/boot/dts/keystone-k2hk-evm.dtb: Warning (unit_address_vs_reg): Node /soc has a reg or ranges property, but no unit name
arch/arm/boot/dts/keystone-k2l-evm.dtb: Warning (unit_address_vs_reg): Node /soc has a reg or ranges property, but no unit name
arch/arm/boot/dts/keystone-k2e-evm.dtb: Warning (unit_address_vs_reg): Node /soc has a reg or ranges property, but no unit name
arch/arm/boot/dts/keystone-k2g-evm.dtb: Warning (unit_address_vs_reg): Node /soc has a reg or ranges property, but no unit name
arch/arm/boot/dts/keystone-k2g-ice.dtb: Warning (unit_address_vs_reg): Node /soc has a reg or ranges property, but no unit name

NOTE: Though we can reformat files by reducing 1 level of indent due to
the use of soc0 phandle, we ommit that change to prevent un-necessary
churn in code base.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/keystone-k2e-evm.dts  |  4 +--
 arch/arm/boot/dts/keystone-k2e.dtsi     |  4 +--
 arch/arm/boot/dts/keystone-k2g.dtsi     |  2 +-
 arch/arm/boot/dts/keystone-k2hk-evm.dts | 50 ++++++++++++++++-----------------
 arch/arm/boot/dts/keystone-k2hk.dtsi    |  4 +--
 arch/arm/boot/dts/keystone-k2l-evm.dts  |  4 +--
 arch/arm/boot/dts/keystone-k2l.dtsi     |  4 +--
 arch/arm/boot/dts/keystone.dtsi         |  2 +-
 8 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/arch/arm/boot/dts/keystone-k2e-evm.dts b/arch/arm/boot/dts/keystone-k2e-evm.dts
index a7b9138cceb7..6cc29c5107b7 100644
--- a/arch/arm/boot/dts/keystone-k2e-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2e-evm.dts
@@ -25,8 +25,9 @@
 			status = "okay";
 		};
 	};
+};
 
-	soc {
+&soc0 {
 
 		clocks {
 			refclksys: refclksys {
@@ -50,7 +51,6 @@
 				clock-output-names = "refclk-ddr3a";
 			};
 		};
-	};
 };
 
 &usb_phy {
diff --git a/arch/arm/boot/dts/keystone-k2e.dtsi b/arch/arm/boot/dts/keystone-k2e.dtsi
index 34860c10fa4d..6d1e41c58c27 100644
--- a/arch/arm/boot/dts/keystone-k2e.dtsi
+++ b/arch/arm/boot/dts/keystone-k2e.dtsi
@@ -45,8 +45,9 @@
 	aliases {
 		rproc0 = &dsp0;
 	};
+};
 
-	soc {
+&soc0 {
 		/include/ "keystone-k2e-clocks.dtsi"
 
 		usb: usb at 2680000 {
@@ -191,5 +192,4 @@
 			bus_freq	= <2500000>;
 		};
 		/include/ "keystone-k2e-netcp.dtsi"
-	};
 };
diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index 0f3126e3ba77..369630b91b99 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -67,7 +67,7 @@
 		interrupts = <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>;
 	};
 
-	soc {
+	soc0: soc at 0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		#pinctrl-cells = <1>;
diff --git a/arch/arm/boot/dts/keystone-k2hk-evm.dts b/arch/arm/boot/dts/keystone-k2hk-evm.dts
index 2964aa67d264..e2b17057d240 100644
--- a/arch/arm/boot/dts/keystone-k2hk-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2hk-evm.dts
@@ -26,7 +26,31 @@
 		};
 	};
 
-	soc {
+	leds {
+		compatible = "gpio-leds";
+		debug1_1 {
+			label = "keystone:green:debug1";
+			gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>; /* 12 */
+		};
+
+		debug1_2 {
+			label = "keystone:red:debug1";
+			gpios = <&gpio0 13 GPIO_ACTIVE_HIGH>; /* 13 */
+		};
+
+		debug2 {
+			label = "keystone:blue:debug2";
+			gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>; /* 14 */
+		};
+
+		debug3 {
+			label = "keystone:blue:debug3";
+			gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>; /* 15 */
+		};
+	};
+};
+
+&soc0 {
 		clocks {
 			refclksys: refclksys {
 				#clock-cells = <0>;
@@ -63,30 +87,6 @@
 				clock-output-names = "refclk-ddr3b";
 			};
 		};
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		debug1_1 {
-			label = "keystone:green:debug1";
-			gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>; /* 12 */
-		};
-
-		debug1_2 {
-			label = "keystone:red:debug1";
-			gpios = <&gpio0 13 GPIO_ACTIVE_HIGH>; /* 13 */
-		};
-
-		debug2 {
-			label = "keystone:blue:debug2";
-			gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>; /* 14 */
-		};
-
-		debug3 {
-			label = "keystone:blue:debug3";
-			gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>; /* 15 */
-		};
-	};
 };
 
 &usb_phy {
diff --git a/arch/arm/boot/dts/keystone-k2hk.dtsi b/arch/arm/boot/dts/keystone-k2hk.dtsi
index 8f6cc98c0ef6..704203fed15a 100644
--- a/arch/arm/boot/dts/keystone-k2hk.dtsi
+++ b/arch/arm/boot/dts/keystone-k2hk.dtsi
@@ -52,8 +52,9 @@
 		rproc6 = &dsp6;
 		rproc7 = &dsp7;
 	};
+};
 
-	soc {
+&soc0 {
 		/include/ "keystone-k2hk-clocks.dtsi"
 
 		msm_ram: msmram at c000000 {
@@ -281,5 +282,4 @@
 			bus_freq	= <2500000>;
 		};
 		/include/ "keystone-k2hk-netcp.dtsi"
-	};
 };
diff --git a/arch/arm/boot/dts/keystone-k2l-evm.dts b/arch/arm/boot/dts/keystone-k2l-evm.dts
index bc60f1bd2a39..45edbaaf464a 100644
--- a/arch/arm/boot/dts/keystone-k2l-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2l-evm.dts
@@ -25,8 +25,9 @@
 			status = "okay";
 		};
 	};
+};
 
-	soc {
+&soc0 {
 		clocks {
 			refclksys: refclksys {
 				#clock-cells = <0>;
@@ -35,7 +36,6 @@
 				clock-output-names = "refclk-sys";
 			};
 		};
-	};
 };
 
 &usb_phy {
diff --git a/arch/arm/boot/dts/keystone-k2l.dtsi b/arch/arm/boot/dts/keystone-k2l.dtsi
index 20d2626fb054..e0c8354d3996 100644
--- a/arch/arm/boot/dts/keystone-k2l.dtsi
+++ b/arch/arm/boot/dts/keystone-k2l.dtsi
@@ -36,8 +36,9 @@
 		rproc2 = &dsp2;
 		rproc3 = &dsp3;
 	};
+};
 
-	soc {
+&soc0 {
 		/include/ "keystone-k2l-clocks.dtsi"
 
 		uart2: serial at 2348400 {
@@ -347,7 +348,6 @@
 			bus_freq	= <2500000>;
 		};
 		/include/ "keystone-k2l-netcp.dtsi"
-	};
 };
 
 &spi0 {
diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index ca2cc5d8e3b5..0e8d094515cc 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -67,7 +67,7 @@
 		cpu_on		= <0x84000003>;
 	};
 
-	soc {
+	soc0: soc at 0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "ti,keystone","simple-bus";
-- 
2.14.1
