From: tony@atomide.com (Tony Lindgren)
Date: Fri, 29 Sep 2017 15:34:10 -0700
Subject: [PATCH 6/7] ARM: dts: Configure SmartReflex only to idle the
 interconnect target module
In-Reply-To: <20170929223411.9691-1-tony@atomide.com>
References: <20170929223411.9691-1-tony@atomide.com>
Message-ID: <20170929223411.9691-7-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The TRM has marked dra7 SmartReflex as reserved and we should not
touch those registers as pointed out by Nishanth Menon <nm@ti.com>.
We do still want to idle the related interconnect target modules on
init though.

Let's do this by only configuring the generic interconnect target modules
and not add the child SmartReflex devices.

Cc: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dra7.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1497,6 +1497,32 @@
 			};
 		};
 
+		target-module at 4a0dd000 {
+			compatible = "ti,sysc-omap4-sr";
+			ti,hwmods = "smartreflex_core";
+			reg = <0x4a0dd000 0x4>,
+			      <0x4a0dd008 0x4>;
+			reg-names = "rev", "sysc";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x4a0dd000 0x001000>;
+
+			/* SmartReflex child device marked reserved in TRM */
+		};
+
+		target-module at 4a0d9000 {
+			compatible = "ti,sysc-omap4-sr";
+			ti,hwmods = "smartreflex_mpu";
+			reg = <0x4a0d9000 0x4>,
+			      <0x4a0d9008 0x4>;
+			reg-names = "rev", "sysc";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x4a0d9000 0x001000>;
+
+			/* SmartReflex child device marked reserved in TRM */
+		};
+
 		omap_dwc3_1: omap_dwc3_1 at 48880000 {
 			compatible = "ti,dwc3";
 			ti,hwmods = "usb_otg_ss1";
-- 
2.14.2
