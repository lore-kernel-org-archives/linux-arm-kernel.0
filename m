From: s-anna@ti.com (Suman Anna)
Date: Thu, 10 Aug 2017 18:52:43 -0500
Subject: [PATCH 1/3] ARM: dts: keystone-k2g: Add DSP node
In-Reply-To: <20170810235245.30316-1-s-anna@ti.com>
References: <20170810235245.30316-1-s-anna@ti.com>
Message-ID: <20170810235245.30316-2-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Keystone 2 66AK2G SoC has a single TMS320C66x DSP Core
Subsystem (C66x CorePac), containing a C66x Fixed/Floating-Point
DSP Core, and 32 KB of L1P & L1D SRAMs and a 1 MB L2 SRAM. Add
the DT node for this DSP processor sub-system.

The DT node has a new property 'power-domains' and no 'clocks'
properties, and uses slightly different property values for
'resets' compared to other Keystone 2 SoCs. The processor does
not have an MMU, and uses various IPC Generation registers and
shared memory for inter-processor communication. The alias with
a stem 'rproc' has also been added for the DSP, it provides a
fixed remoteproc id for the DSP processor.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/keystone-k2g.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index 35726b66fb91..826b286665e6 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -28,6 +28,7 @@
 
 	aliases {
 		serial0 = &uart0;
+		rproc0 = &dsp0;
 	};
 
 	cpus {
@@ -147,6 +148,22 @@
 			gpio,syscon-dev = <&devctrl 0x240>;
 		};
 
+		dsp0: dsp at 10800000 {
+			compatible = "ti,k2g-dsp";
+			reg = <0x10800000 0x00100000>,
+			      <0x10e00000 0x00008000>,
+			      <0x10f00000 0x00008000>;
+			reg-names = "l2sram", "l1pram", "l1dram";
+			power-domains = <&k2g_pds 0x0046>;
+			ti,syscon-dev = <&devctrl 0x844>;
+			resets = <&k2g_reset 0x0046 0x1>;
+			interrupt-parent = <&kirq0>;
+			interrupts = <0 8>;
+			interrupt-names = "vring", "exception";
+			kick-gpios = <&dspgpio0 27 0>;
+			status = "disabled";
+		};
+
 		msgmgr: msgmgr at 02a00000 {
 			compatible = "ti,k2g-message-manager";
 			#mbox-cells = <2>;
-- 
2.13.1
