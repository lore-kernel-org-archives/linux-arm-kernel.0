From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Mon, 30 Jun 2014 15:09:31 +0200
Subject: [PATCH v8 6/7] ARM: berlin: add the AHCI node for the BG2Q
In-Reply-To: <1404133772-11741-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1404133772-11741-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1404133772-11741-7-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BG2Q has an AHCI SATA controller. Add the corresponding nodes
(AHCI, PHY) into its device tree.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 635a16a64cb4..fa34ae6657ac 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -303,6 +303,45 @@
 			clock-names = "refclk";
 		};
 
+		ahci: sata at e90000 {
+			compatible = "generic-ahci";
+			reg = <0xe90000 0x1000>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&chip CLKID_SATA>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			sata0: sata-port at 0 {
+				reg = <0>;
+				phys = <&sata_phy 0>;
+				status = "disabled";
+			};
+
+			sata1: sata-port at 1 {
+				reg = <1>;
+				phys = <&sata_phy 1>;
+				status = "disabled";
+			};
+		};
+
+		sata_phy: phy at e900a0 {
+			compatible = "marvell,berlin2q-sata-phy";
+			reg = <0xe900a0 0x200>;
+			clocks = <&chip CLKID_SATA>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#phy-cells = <1>;
+			status = "disabled";
+
+			sata-phy at 0 {
+				reg = <0>;
+			};
+
+			sata-phy at 1 {
+				reg = <1>;
+			};
+		};
+
 		apb at fc0000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
-- 
1.9.1
