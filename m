From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 20 Mar 2015 19:52:47 +0100
Subject: [PATCH 3/5] ARM: dts: sun5i: Add A13 and A10s SRAM and SRAM controller
In-Reply-To: <1426877569-11493-1-git-send-email-hdegoede@redhat.com>
References: <1426877569-11493-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1426877569-11493-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A13 / A10s has a few SRAM that can be mapped either to a device or to
the CPU, with the mapping being controlled by a SRAM controller.

Since most of the time these SRAM won't be accessible by the CPU,
we can't use the mmio-sram driver and compatible.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index de48692..eb5bce5 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -298,12 +298,46 @@
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
 		dma: dma-controller at 01c02000 {
 			compatible = "allwinner,sun4i-a10-dma";
 			reg = <0x01c02000 0x1000>;
-- 
2.3.3
