From: s-anna@ti.com (Suman Anna)
Date: Fri, 28 Jul 2017 18:19:15 -0500
Subject: [PATCH 3/6] ARM: dts: keystone-k2e: Add DSP node
In-Reply-To: <20170728231918.16778-1-s-anna@ti.com>
References: <20170728231918.16778-1-s-anna@ti.com>
Message-ID: <20170728231918.16778-4-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Keystone 2 66AK2E SoC has one TMS320C66x DSP Core Subsystem
(C66x CorePac), with a 1.4 GHz C66x Fixed or Floating-Point DSP
Core, and 32 KB of L1P & L1D SRAMs and a 1 MB L2 SRAM. Add the
DT node for this DSP processor sub-system. The processor does
not have a MMU, and uses various IPC Generation registers and
shared memory for inter-processor communication. The alias with
a stem 'rproc' has also been added for the DSP, it provides a
fixed remoteproc id for the DSP processor.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Sam Nelson <sam.nelson@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/boot/dts/keystone-k2e.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2e.dtsi b/arch/arm/boot/dts/keystone-k2e.dtsi
index 0dd4cdd6d40c..819ab8345916 100644
--- a/arch/arm/boot/dts/keystone-k2e.dtsi
+++ b/arch/arm/boot/dts/keystone-k2e.dtsi
@@ -45,6 +45,10 @@
 		};
 	};
 
+	aliases {
+		rproc0 = &dsp0;
+	};
+
 	soc {
 		/include/ "keystone-k2e-clocks.dtsi"
 
@@ -114,6 +118,22 @@
 			gpio,syscon-dev = <&devctrl 0x240>;
 		};
 
+		dsp0: dsp at 10800000 {
+			compatible = "ti,k2e-dsp";
+			reg = <0x10800000 0x00080000>,
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
 		pcie1: pcie at 21020000 {
 			compatible = "ti,keystone-pcie","snps,dw-pcie";
 			clocks = <&clkpcie1>;
-- 
2.13.1
