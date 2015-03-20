From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 20 Mar 2015 19:52:48 +0100
Subject: [PATCH 4/5] ARM: dts: sun7i: Add A20 SRAM and SRAM controller
In-Reply-To: <1426877569-11493-1-git-send-email-hdegoede@redhat.com>
References: <1426877569-11493-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1426877569-11493-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

The A20 has a few SRAM that can be mapped either to a device or to the CPU,
with the mapping being controlled by a SRAM controller.

Since most of the time these SRAM won't be accessible by the CPU,
we can't use the mmio-sram driver and compatible.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
[hdegoede at redhat.com: Do not change soc node name, change compatible to
 sun4i-a10-sram-controller to match the driver change]
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 4673c11..7c04a24 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -528,12 +528,46 @@
 		};
 	};
 
+	/*
+	 * Note we use the address were mmio registers start, not where the
+	 * SRAM blocks start, this cannot be changed because that would be
+	 * a devicetree ABI change.
+	 */
 	soc at 01c00000 {
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
+			compatible = "allwinner,sun4i-a10-sram-controller";
+			reg = <0x01c00000 0x30>;
+		};
+
 		nmi_intc: interrupt-controller at 01c00030 {
 			compatible = "allwinner,sun7i-a20-sc-nmi";
 			interrupt-controller;
-- 
2.3.3
