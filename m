From: tony@atomide.com (Tony Lindgren)
Date: Thu, 14 Nov 2013 16:09:48 -0800
Subject: [PATCH 01/11] ARM: dts: Add basic device tree support for omap2430 sdp
In-Reply-To: <1384474198-20756-1-git-send-email-tony@atomide.com>
References: <1384474198-20756-1-git-send-email-tony@atomide.com>
Message-ID: <1384474198-20756-2-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I doubt that there are many people using 2430 sdp, but as
that's been historically an important acid test platform
for omap2+ related changes, let's add minimal device
tree support for it.

If anybody is using it beyond minimal boot testing, patches
for more complete device tree support are welcome.

Cc: devicetree at vger.kernel.org
Cc: "Beno?t Cousson" <bcousson@baylibre.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/Makefile         |  1 +
 arch/arm/boot/dts/omap2430-sdp.dts | 49 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap2430-sdp.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d57c1a6..73022b1 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -173,6 +173,7 @@ dtb-$(CONFIG_ARCH_NSPIRE) += nspire-cx.dtb \
 	nspire-tp.dtb \
 	nspire-clp.dtb
 dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
+	omap2430-sdp.dtb \
 	omap3430-sdp.dtb \
 	omap3-beagle.dtb \
 	omap3-devkit8000.dtb \
diff --git a/arch/arm/boot/dts/omap2430-sdp.dts b/arch/arm/boot/dts/omap2430-sdp.dts
new file mode 100644
index 0000000..2c90d29
--- /dev/null
+++ b/arch/arm/boot/dts/omap2430-sdp.dts
@@ -0,0 +1,49 @@
+/*
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+#include "omap2430.dtsi"
+
+/ {
+	model = "TI OMAP2430 SDP";
+	compatible = "ti,omap2430-sdp", "ti,omap2430", "ti,omap2";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x8000000>; /* 128 MB */
+	};
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+
+	twl: twl at 48 {
+		reg = <0x48>;
+		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
+	};
+};
+
+#include "twl4030.dtsi"
+
+&mmc1 {
+	vmmc-supply = <&vmmc1>;
+	bus-width = <4>;
+};
+
+&gpmc {
+	ranges = <5 0 0x08000000 0x01000000>;
+	ethernet at gpmc {
+		compatible = "smsc,lan91c94";
+		interrupt-parent = <&gpio5>;
+		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;	/* gpio149 */
+		reg = <5 0x300 0xf>;
+		bank-width = <2>;
+		gpmc,mux-add-data;
+        };
+};
+
-- 
1.8.1.1
