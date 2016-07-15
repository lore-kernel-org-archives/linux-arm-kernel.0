From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 15 Jul 2016 11:25:19 +0200
Subject: [PATCH 6/7] ARM: dts: at91: sama5d3x: separate motherboard gmac and
 emac definitions
In-Reply-To: <1468574720-24296-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1468574720-24296-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1468574720-24296-6-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Separate the definitions for the emac and the gmac in different files and
include them in the final board dts that uses them.

Solves:
Warning (unit_address_vs_reg): Node /ahb/apb/ethernet at f0028000 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /ahb/apb/ethernet at f802c000 has a unit name, but no reg property

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/sama5d31ek.dts       |  1 +
 arch/arm/boot/dts/sama5d33ek.dts       |  1 +
 arch/arm/boot/dts/sama5d34ek.dts       |  1 +
 arch/arm/boot/dts/sama5d35ek.dts       |  2 ++
 arch/arm/boot/dts/sama5d36ek.dts       |  2 ++
 arch/arm/boot/dts/sama5d3xcm.dtsi      | 34 ------------------------
 arch/arm/boot/dts/sama5d3xmb.dtsi      | 12 ---------
 arch/arm/boot/dts/sama5d3xmb_emac.dtsi | 26 ++++++++++++++++++
 arch/arm/boot/dts/sama5d3xmb_gmac.dtsi | 48 ++++++++++++++++++++++++++++++++++
 9 files changed, 81 insertions(+), 46 deletions(-)
 create mode 100644 arch/arm/boot/dts/sama5d3xmb_emac.dtsi
 create mode 100644 arch/arm/boot/dts/sama5d3xmb_gmac.dtsi

diff --git a/arch/arm/boot/dts/sama5d31ek.dts b/arch/arm/boot/dts/sama5d31ek.dts
index 04eec0dfcf7d..25e4c0b2d786 100644
--- a/arch/arm/boot/dts/sama5d31ek.dts
+++ b/arch/arm/boot/dts/sama5d31ek.dts
@@ -9,6 +9,7 @@
 /dts-v1/;
 #include "sama5d31.dtsi"
 #include "sama5d3xmb.dtsi"
+#include "sama5d3xmb_emac.dtsi"
 #include "sama5d3xdm.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/sama5d33ek.dts b/arch/arm/boot/dts/sama5d33ek.dts
index cbd6a3ff1545..c517b87a1de2 100644
--- a/arch/arm/boot/dts/sama5d33ek.dts
+++ b/arch/arm/boot/dts/sama5d33ek.dts
@@ -9,6 +9,7 @@
 /dts-v1/;
 #include "sama5d33.dtsi"
 #include "sama5d3xmb.dtsi"
+#include "sama5d3xmb_gmac.dtsi"
 #include "sama5d3xdm.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/sama5d34ek.dts b/arch/arm/boot/dts/sama5d34ek.dts
index 878aa164275a..c8b8449fdc3e 100644
--- a/arch/arm/boot/dts/sama5d34ek.dts
+++ b/arch/arm/boot/dts/sama5d34ek.dts
@@ -9,6 +9,7 @@
 /dts-v1/;
 #include "sama5d34.dtsi"
 #include "sama5d3xmb.dtsi"
+#include "sama5d3xmb_gmac.dtsi"
 #include "sama5d3xdm.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/sama5d35ek.dts b/arch/arm/boot/dts/sama5d35ek.dts
index e812f5c1bf70..6e261fcf576c 100644
--- a/arch/arm/boot/dts/sama5d35ek.dts
+++ b/arch/arm/boot/dts/sama5d35ek.dts
@@ -9,6 +9,8 @@
 /dts-v1/;
 #include "sama5d35.dtsi"
 #include "sama5d3xmb.dtsi"
+#include "sama5d3xmb_emac.dtsi"
+#include "sama5d3xmb_gmac.dtsi"
 
 / {
 	model = "Atmel SAMA5D35-EK";
diff --git a/arch/arm/boot/dts/sama5d36ek.dts b/arch/arm/boot/dts/sama5d36ek.dts
index 59576c6f9826..cd458b85a205 100644
--- a/arch/arm/boot/dts/sama5d36ek.dts
+++ b/arch/arm/boot/dts/sama5d36ek.dts
@@ -10,6 +10,8 @@
 #include "sama5d36.dtsi"
 #include "sama5d3xmb.dtsi"
 #include "sama5d3xdm.dtsi"
+#include "sama5d3xmb_emac.dtsi"
+#include "sama5d3xmb_gmac.dtsi"
 
 / {
 	model = "Atmel SAMA5D36-EK";
diff --git a/arch/arm/boot/dts/sama5d3xcm.dtsi b/arch/arm/boot/dts/sama5d3xcm.dtsi
index 2cf9c3611db6..b5e111b29da1 100644
--- a/arch/arm/boot/dts/sama5d3xcm.dtsi
+++ b/arch/arm/boot/dts/sama5d3xcm.dtsi
@@ -34,40 +34,6 @@
 			spi0: spi at f0004000 {
 				cs-gpios = <&pioD 13 0>, <0>, <0>, <0>;
 			};
-
-			macb0: ethernet at f0028000 {
-				phy-mode = "rgmii";
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				ethernet-phy at 1 {
-					reg = <0x1>;
-					interrupt-parent = <&pioB>;
-					interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
-					txen-skew-ps = <800>;
-					txc-skew-ps = <3000>;
-					rxdv-skew-ps = <400>;
-					rxc-skew-ps = <3000>;
-					rxd0-skew-ps = <400>;
-					rxd1-skew-ps = <400>;
-					rxd2-skew-ps = <400>;
-					rxd3-skew-ps = <400>;
-				};
-
-				ethernet-phy at 7 {
-					reg = <0x7>;
-					interrupt-parent = <&pioB>;
-					interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
-					txen-skew-ps = <800>;
-					txc-skew-ps = <3000>;
-					rxdv-skew-ps = <400>;
-					rxc-skew-ps = <3000>;
-					rxd0-skew-ps = <400>;
-					rxd1-skew-ps = <400>;
-					rxd2-skew-ps = <400>;
-					rxd3-skew-ps = <400>;
-				};
-			};
 		};
 
 		nand0: nand at 60000000 {
diff --git a/arch/arm/boot/dts/sama5d3xmb.dtsi b/arch/arm/boot/dts/sama5d3xmb.dtsi
index 89010422812d..6d252ad050f6 100644
--- a/arch/arm/boot/dts/sama5d3xmb.dtsi
+++ b/arch/arm/boot/dts/sama5d3xmb.dtsi
@@ -117,18 +117,6 @@
 				status = "okay";
 			};
 
-			macb1: ethernet at f802c000 {
-				phy-mode = "rmii";
-
-				#address-cells = <1>;
-				#size-cells = <0>;
-				phy0: ethernet-phy at 1 {
-					interrupt-parent = <&pioE>;
-					interrupts = <30 IRQ_TYPE_EDGE_FALLING>;
-					reg = <1>;
-				};
-			};
-
 			pinctrl at fffff200 {
 				board {
 					pinctrl_mmc0_cd: mmc0_cd {
diff --git a/arch/arm/boot/dts/sama5d3xmb_emac.dtsi b/arch/arm/boot/dts/sama5d3xmb_emac.dtsi
new file mode 100644
index 000000000000..2fd14f371a04
--- /dev/null
+++ b/arch/arm/boot/dts/sama5d3xmb_emac.dtsi
@@ -0,0 +1,26 @@
+/*
+ * sama5d3xmb_emac.dts - Device Tree Include file for SAMA5D3x mother board
+ * Ethernet
+ *
+ *  Copyright (C) 2016 Atmel,
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+/ {
+	ahb {
+		apb {
+			macb1: ethernet at f802c000 {
+				phy-mode = "rmii";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+				phy0: ethernet-phy at 1 {
+					interrupt-parent = <&pioE>;
+					interrupts = <30 IRQ_TYPE_EDGE_FALLING>;
+					reg = <1>;
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/sama5d3xmb_gmac.dtsi b/arch/arm/boot/dts/sama5d3xmb_gmac.dtsi
new file mode 100644
index 000000000000..65aea7a75b1d
--- /dev/null
+++ b/arch/arm/boot/dts/sama5d3xmb_gmac.dtsi
@@ -0,0 +1,48 @@
+/*
+ * sama5d3xmb_gmac.dtsi - Device Tree Include file for SAMA5D3x motherboard
+ * Gigabit Ethernet
+ *
+ *  Copyright (C) 2016 Atmel,
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+/ {
+	ahb {
+		apb {
+			macb0: ethernet at f0028000 {
+				phy-mode = "rgmii";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ethernet-phy at 1 {
+					reg = <0x1>;
+					interrupt-parent = <&pioB>;
+					interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+					txen-skew-ps = <800>;
+					txc-skew-ps = <3000>;
+					rxdv-skew-ps = <400>;
+					rxc-skew-ps = <3000>;
+					rxd0-skew-ps = <400>;
+					rxd1-skew-ps = <400>;
+					rxd2-skew-ps = <400>;
+					rxd3-skew-ps = <400>;
+				};
+
+				ethernet-phy at 7 {
+					reg = <0x7>;
+					interrupt-parent = <&pioB>;
+					interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+					txen-skew-ps = <800>;
+					txc-skew-ps = <3000>;
+					rxdv-skew-ps = <400>;
+					rxc-skew-ps = <3000>;
+					rxd0-skew-ps = <400>;
+					rxd1-skew-ps = <400>;
+					rxd2-skew-ps = <400>;
+					rxd3-skew-ps = <400>;
+				};
+			};
+		};
+	};
+};
-- 
2.8.1
