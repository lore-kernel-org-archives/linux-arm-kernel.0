From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 12 Mar 2015 14:13:43 +0100
Subject: [PATCH RFC 2/3] ARM: sun7i: Add A20 SRAM and SRAM controller
In-Reply-To: <1426166024-24922-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1426166024-24922-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1426166024-24922-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A20 has a few SRAM that can be mapped either to a device or to the CPU,
with the mapping being controlled by an SRAM controller.

Since most of the time these SRAM won't be accessible by the CPU, we can't use
the mmio-sram driver and compatible.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index a1ebd80e6f24..a249828a1df5 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -522,12 +522,41 @@
 		};
 	};
 
-	soc at 01c00000 {
+	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
 
+		sram at 00000000 {
+			compatible = "allwinner,sun4i-a10-sram";
+			reg = <0x00000000 0x4000>;
+			allwinner,sram-name = "A1";
+		};
+
+		sram at 00004000 {
+			compatible = "allwinner,sun4i-a10-sram";
+			reg = <0x00004000 0x4000>;
+			allwinner,sram-name = "A2";
+		};
+
+		sram at 00008000 {
+			compatible = "allwinner,sun4i-a10-sram";
+			reg = <0x00008000 0x4000>;
+			allwinner,sram-name = "A3-A4";
+		};
+
+		sram at 00010000 {
+			compatible = "allwinner,sun4i-a10-sram";
+			reg = <0x00010000 0x1000>;
+			allwinner,sram-name = "D";
+		};
+
+		sram-controller at 01c00000 {
+			compatible = "allwinner,sun7i-a20-sram-controller";
+			reg = <0x01c00000 0x30>;
+		};
+
 		nmi_intc: interrupt-controller at 01c00030 {
 			compatible = "allwinner,sun7i-a20-sc-nmi";
 			interrupt-controller;
-- 
2.3.1
