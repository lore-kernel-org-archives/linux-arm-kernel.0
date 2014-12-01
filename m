From: stefan@agner.ch (Stefan Agner)
Date: Mon,  1 Dec 2014 18:03:08 +0100
Subject: [PATCH v2 2/3] ARM: dts: vf610: add system reset controller and
 syscon-reboot
In-Reply-To: <1417453389-1588-1-git-send-email-stefan@agner.ch>
References: <1417453389-1588-1-git-send-email-stefan@agner.ch>
Message-ID: <1417453389-1588-3-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the system reset controller (SRC) module and use syscon-reboot
to register a restart handler which restarts the SoC using the
SRC SW_RST bit.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf500.dtsi |  4 ++++
 arch/arm/boot/dts/vfxxx.dtsi | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/vf500.dtsi b/arch/arm/boot/dts/vf500.dtsi
index de67005..3f38f49 100644
--- a/arch/arm/boot/dts/vf500.dtsi
+++ b/arch/arm/boot/dts/vf500.dtsi
@@ -130,6 +130,10 @@
 	interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 };
 
+&src {
+	interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &uart0 {
 	interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 };
diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 505969a..3e696d7 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -43,6 +43,14 @@
 		clock-frequency = <32768>;
 	};
 
+	reboot: syscon-reboot {
+		compatible = "syscon-reboot";
+		regmap = <&src>;
+		offset = <0x0>;
+		mask = <0x1000>;
+		priority = <192>;
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -318,6 +326,11 @@
 				clocks = <&clks VF610_CLK_USBC0>;
 				status = "disabled";
 			};
+
+			src: src at 4006e000 {
+				compatible = "fsl,vf610-src", "syscon";
+				reg = <0x4006e000 0x1000>;
+			};
 		};
 
 		aips1: aips-bus at 40080000 {
-- 
2.1.3
