From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 26 Mar 2015 15:53:42 +0100
Subject: [PATCH v2 2/5] ARM: dts: sun4i: Add A10 SRAM and SRAM controller
In-Reply-To: <1427381625-6942-1-git-send-email-hdegoede@redhat.com>
References: <1427381625-6942-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1427381625-6942-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A10 has a few SRAM that can be mapped either to a device or to the CPU,
with the mapping being controlled by a SRAM controller.

Since most of the time these SRAM won't be accessible by the CPU,
we can't use the mmio-sram driver and compatible.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 59fc7f7..595b77c 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -451,12 +451,46 @@
 		};
 	};
 
+	/*
+	 * Note we use the address where the mmio registers start, not where
+	 * the SRAM blocks start, this cannot be changed because that would be
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
