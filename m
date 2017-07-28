From: s-anna@ti.com (Suman Anna)
Date: Fri, 28 Jul 2017 18:19:14 -0500
Subject: [PATCH 2/6] ARM: dts: keystone-k2l: Add DSP nodes
In-Reply-To: <20170728231918.16778-1-s-anna@ti.com>
References: <20170728231918.16778-1-s-anna@ti.com>
Message-ID: <20170728231918.16778-3-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Keystone 2 66AK2L SoCs have 4 TMS320C66x DSP Core Subsystems
(C66x CorePacs), each with a 1.0 GHz or 1.2 GHz C66x Fixed /
Floating-Point DSP Core, and 32 KB of L1P & L1D SRAMs and a 1 MB
L2 SRAM. Add the DT nodes for these DSP processor sub-systems.
The processors do not have an MMU, and use various IPC Generation
registers and shared memory for inter-processor communication.
The aliases with a stem 'rproc' have also been added for all the
DSPs, they provide a fixed remoteproc id to each DSP processor.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Sam Nelson <sam.nelson@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/boot/dts/keystone-k2l.dtsi | 71 +++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2l.dtsi b/arch/arm/boot/dts/keystone-k2l.dtsi
index 148650406cf7..4431310bc922 100644
--- a/arch/arm/boot/dts/keystone-k2l.dtsi
+++ b/arch/arm/boot/dts/keystone-k2l.dtsi
@@ -33,6 +33,13 @@
 		};
 	};
 
+	aliases {
+		rproc0 = &dsp0;
+		rproc1 = &dsp1;
+		rproc2 = &dsp2;
+		rproc3 = &dsp3;
+	};
+
 	soc {
 		/include/ "keystone-k2l-clocks.dtsi"
 
@@ -268,6 +275,70 @@
 			gpio,syscon-dev = <&devctrl 0x24c>;
 		};
 
+		dsp0: dsp at 10800000 {
+			compatible = "ti,k2l-dsp";
+			reg = <0x10800000 0x00100000>,
+			      <0x10e00000 0x00008000>,
+			      <0x10f00000 0x00008000>;
+			reg-names = "l2sram", "l1pram", "l1dram";
+			clocks = <&clkgem0>;
+			ti,syscon-dev = <&devctrl 0x844>;
+			resets = <&pscrst 0>;
+			interrupt-parent = <&kirq0>;
+			interrupts = <0 8>;
+			interrupt-names = "vring", "exception";
+			kick-gpios = <&dspgpio0 27 0>;
+			status = "disabled";
+		};
+
+		dsp1: dsp at 11800000 {
+			compatible = "ti,k2l-dsp";
+			reg = <0x11800000 0x00100000>,
+			      <0x11e00000 0x00008000>,
+			      <0x11f00000 0x00008000>;
+			reg-names = "l2sram", "l1pram", "l1dram";
+			clocks = <&clkgem1>;
+			ti,syscon-dev = <&devctrl 0x848>;
+			resets = <&pscrst 1>;
+			interrupt-parent = <&kirq0>;
+			interrupts = <1 9>;
+			interrupt-names = "vring", "exception";
+			kick-gpios = <&dspgpio1 27 0>;
+			status = "disabled";
+		};
+
+		dsp2: dsp at 12800000 {
+			compatible = "ti,k2l-dsp";
+			reg = <0x12800000 0x00100000>,
+			      <0x12e00000 0x00008000>,
+			      <0x12f00000 0x00008000>;
+			reg-names = "l2sram", "l1pram", "l1dram";
+			clocks = <&clkgem2>;
+			ti,syscon-dev = <&devctrl 0x84c>;
+			resets = <&pscrst 2>;
+			interrupt-parent = <&kirq0>;
+			interrupts = <2 10>;
+			interrupt-names = "vring", "exception";
+			kick-gpios = <&dspgpio2 27 0>;
+			status = "disabled";
+		};
+
+		dsp3: dsp at 13800000 {
+			compatible = "ti,k2l-dsp";
+			reg = <0x13800000 0x00100000>,
+			      <0x13e00000 0x00008000>,
+			      <0x13f00000 0x00008000>;
+			reg-names = "l2sram", "l1pram", "l1dram";
+			clocks = <&clkgem3>;
+			ti,syscon-dev = <&devctrl 0x850>;
+			resets = <&pscrst 3>;
+			interrupt-parent = <&kirq0>;
+			interrupts = <3 11>;
+			interrupt-names = "vring", "exception";
+			kick-gpios = <&dspgpio3 27 0>;
+			status = "disabled";
+		};
+
 		mdio: mdio at 26200f00 {
 			compatible	= "ti,keystone_mdio", "ti,davinci_mdio";
 			#address-cells = <1>;
-- 
2.13.1
