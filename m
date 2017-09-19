From: s-anna@ti.com (Suman Anna)
Date: Mon, 18 Sep 2017 19:28:31 -0500
Subject: [PATCH 1/3] ARM: dts: da850: Add DSP node
In-Reply-To: <20170919002833.5677-1-s-anna@ti.com>
References: <20170919002833.5677-1-s-anna@ti.com>
Message-ID: <20170919002833.5677-2-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The TI Davinci DA8xx family of SoCs have a single DSP subsystem
that is comprised of TI's standard TMS320C674x megamodule and
several blocks of internal memory (L1P, L1D and L2 RAMs). Add
the DT node for this DSP processor sub-system. The processor
does not have an MMU, and uses a chip-level signalling register
and shared memory for inter-processor communication with the
ARM core.

The node has been added in disabled state, and can be enabled
in the respective board dts file with an associated reserved
memory block.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/da850.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index af68ef7b0caa..c66cf7895363 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -23,6 +23,18 @@
 			reg = <0xfffee000 0x2000>;
 		};
 	};
+	dsp: dsp at 11800000 {
+		compatible = "ti,da850-dsp";
+		reg = <0x11800000 0x40000>,
+		      <0x11e00000 0x8000>,
+		      <0x11f00000 0x8000>,
+		      <0x01c14044 0x4>,
+		      <0x01c14174 0x8>;
+		reg-names = "l2sram", "l1pram", "l1dram", "host1cfg", "chipsig";
+		interrupt-parent = <&intc>;
+		interrupts = <28>;
+		status = "disabled";
+	};
 	soc at 1c00000 {
 		compatible = "simple-bus";
 		model = "da850";
-- 
2.13.1
