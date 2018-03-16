From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:51:08 +0100
Subject: [PATCH 38/69] arm64: dts: renesas: initial R8A77965 SoC device tree
In-Reply-To: <cover.1521206129.git.horms+renesas@verge.net.au>
References: <cover.1521206129.git.horms+renesas@verge.net.au>
Message-ID: <df863d6f95f57dbb4f7c2f5ec2f230809551b17f.1521206129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

Basic support for the Gen 3 R-Car M3-N SoC.

Based on original work from:
Takeshi Kihara <takeshi.kihara.df@renesas.com>
Magnus Damm <damm+renesas@opensource.se>

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 490 ++++++++++++++++++++++++++++++
 1 file changed, 490 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77965.dtsi

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
new file mode 100644
index 000000000000..6b6ec653f543
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -0,0 +1,490 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the r8a77965 SoC
+ *
+ * Copyright (C) 2018 Jacopo Mondi <jacopo+renesas@jmondi.org>
+ *
+ * Based on r8a7796.dtsi
+ * Copyright (C) 2016 Renesas Electronics Corp.
+ */
+
+#include <dt-bindings/clock/renesas-cpg-mssr.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+#define CPG_AUDIO_CLK_I		10
+
+/ {
+	compatible = "renesas,r8a77965";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	psci {
+		compatible = "arm,psci-1.0", "arm,psci-0.2";
+		method = "smc";
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		a57_0: cpu at 0 {
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x0>;
+			device_type = "cpu";
+			power-domains = <&sysc 0>;
+			next-level-cache = <&L2_CA57>;
+			enable-method = "psci";
+		};
+
+		a57_1: cpu at 1 {
+			compatible = "arm,cortex-a57","arm,armv8";
+			reg = <0x1>;
+			device_type = "cpu";
+			power-domains = <&sysc 1>;
+			next-level-cache = <&L2_CA57>;
+			enable-method = "psci";
+		};
+
+		L2_CA57: cache-controller-0 {
+			compatible = "cache";
+			reg = <0>;
+			power-domains = <&sysc 12>;
+			cache-unified;
+			cache-level = <2>;
+		};
+	};
+
+	extal_clk: extal {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board */
+		clock-frequency = <0>;
+	};
+
+	extalr_clk: extalr {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board */
+		clock-frequency = <0>;
+	};
+
+	/*
+	 * The external audio clocks are configured as 0 Hz fixed frequency
+	 * clocks by default.
+	 * Boards that provide audio clocks should override them.
+	 */
+	audio_clk_a: audio_clk_a {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	audio_clk_b: audio_clk_b {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	audio_clk_c: audio_clk_c {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	/* External CAN clock - to be overridden by boards that provide it */
+	can_clk: can {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	/* External SCIF clock - to be overridden by boards that provide it */
+	scif_clk: scif {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	/* External PCIe clock - can be overridden by the board */
+	pcie_bus_clk: pcie_bus {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	/* External USB clocks - can be overridden by the board */
+	usb3s0_clk: usb3s0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	usb_extal_clk: usb_extal {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	pmu_a57 {
+		compatible = "arm,cortex-a57-pmu";
+		interrupts-extended = <&gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&a57_0>,
+				     <&a57_1>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gic: interrupt-controller at f1010000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x0 0xf1010000 0 0x1000>,
+			      <0x0 0xf1020000 0 0x20000>,
+			      <0x0 0xf1040000 0 0x20000>,
+			      <0x0 0xf1060000 0 0x20000>;
+			interrupts = <GIC_PPI 9
+					(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&cpg CPG_MOD 408>;
+			clock-names = "clk";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 408>;
+		};
+
+		pfc: pin-controller at e6060000 {
+			compatible = "renesas,pfc-r8a77965";
+			reg = <0 0xe6060000 0 0x50c>;
+		};
+
+		cpg: clock-controller at e6150000 {
+			compatible = "renesas,r8a77965-cpg-mssr";
+			reg = <0 0xe6150000 0 0x1000>;
+			clocks = <&extal_clk>, <&extalr_clk>;
+			clock-names = "extal", "extalr";
+			#clock-cells = <2>;
+			#power-domain-cells = <0>;
+			#reset-cells = <1>;
+		};
+
+		rst: reset-controller at e6160000 {
+			compatible = "renesas,r8a77965-rst";
+			reg = <0 0xe6160000 0 0x0200>;
+		};
+
+		prr: chipid at fff00044 {
+			compatible = "renesas,prr";
+			reg = <0 0xfff00044 0 4>;
+		};
+
+		sysc: system-controller at e6180000 {
+			compatible = "renesas,r8a77965-sysc";
+			reg = <0 0xe6180000 0 0x0400>;
+			#power-domain-cells = <1>;
+		};
+
+		gpio0: gpio at e6050000 {
+			/* placeholder */
+		};
+
+		gpio1: gpio at e6051000 {
+			/* placeholder */
+		};
+
+		gpio2: gpio at e6052000 {
+			/* placeholder */
+		};
+
+		gpio3: gpio at e6053000 {
+			/* placeholder */
+		};
+
+		gpio4: gpio at e6054000 {
+			/* placeholder */
+		};
+
+		gpio5: gpio at e6055000 {
+			/* placeholder */
+		};
+
+		gpio6: gpio at e6055400 {
+			/* placeholder */
+		};
+
+		gpio7: gpio at e6055800 {
+			/* placeholder */
+		};
+
+		intc_ex: interrupt-controller at e61c0000 {
+			/* placeholder */
+		};
+
+		dmac0: dma-controller at e6700000 {
+			/* placeholder */
+		};
+
+		dmac1: dma-controller at e7300000 {
+			/* placeholder */
+		};
+
+		dmac2: dma-controller at e7310000 {
+			/* placeholder */
+		};
+
+		scif0: serial at e6e60000 {
+			/* placeholder */
+		};
+
+		scif1: serial at e6e68000 {
+			/* placeholder */
+		};
+
+		scif2: serial at e6e88000 {
+			/* placeholder */
+		};
+
+		scif3: serial at e6c50000 {
+			/* placeholder */
+		};
+
+		scif4: serial at e6c40000 {
+			/* placeholder */
+		};
+
+		scif5: serial at e6f30000 {
+			/* placeholder */
+		};
+
+		avb: ethernet at e6800000 {
+			/* placeholder */
+		};
+
+		csi20: csi2 at fea80000 {
+			/* placeholder */
+		};
+
+		csi40: csi2 at feaa0000 {
+			/* placeholder */
+		};
+
+		vin0: video at e6ef0000 {
+			/* placeholder */
+		};
+
+		vin1: video at e6ef1000 {
+			/* placeholder */
+		};
+
+		vin2: video at e6ef2000 {
+			/* placeholder */
+		};
+
+		vin3: video at e6ef3000 {
+			/* placeholder */
+		};
+
+		vin4: video at e6ef4000 {
+			/* placeholder */
+		};
+
+		vin5: video at e6ef5000 {
+			/* placeholder */
+		};
+
+		vin6: video at e6ef6000 {
+			/* placeholder */
+		};
+
+		vin7: video at e6ef7000 {
+			/* placeholder */
+		};
+
+		ohci0: usb at ee080000 {
+			/* placeholder */
+		};
+
+		ehci0: usb at ee080100 {
+			/* placeholder */
+		};
+
+		usb2_phy0: usb-phy at ee080200 {
+			/* placeholder */
+		};
+
+		ohci1: usb at ee0a0000 {
+			/* placeholder */
+		};
+
+		ehci1: usb at ee0a0100 {
+			/* placeholder */
+		};
+
+		i2c0: i2c at e6500000 {
+			/* placeholder */
+		};
+
+		i2c1: i2c at e6508000 {
+			/* placeholder */
+		};
+
+		i2c2: i2c at e6510000 {
+			/* placeholder */
+		};
+
+		i2c3: i2c at e66d0000 {
+			/* placeholder */
+		};
+
+		i2c4: i2c at e66d8000 {
+			/* placeholder */
+		};
+
+		i2c5: i2c at e66e0000 {
+			/* placeholder */
+		};
+
+		i2c6: i2c at e66e8000 {
+			/* placeholder */
+		};
+
+		i2c_dvfs: i2c at e60b0000 {
+			/* placeholder */
+		};
+
+		pwm0: pwm at e6e30000 {
+			/* placeholder */
+		};
+
+		pwm1: pwm at e6e31000 {
+			/* placeholder */
+		};
+
+		pwm2: pwm at e6e32000 {
+			/* placeholder */
+		};
+
+		pwm3: pwm at e6e33000 {
+			/* placeholder */
+		};
+
+		pwm4: pwm at e6e34000 {
+			/* placeholder */
+		};
+
+		pwm5: pwm at e6e35000 {
+			/* placeholder */
+		};
+
+		pwm6: pwm at e6e36000 {
+			/* placeholder */
+		};
+
+		du: display at feb00000 {
+			/* placeholder */
+
+			ports {
+				port at 0 {
+					reg = <0>;
+					du_out_rgb: endpoint {
+					};
+				};
+				port at 1 {
+					reg = <1>;
+					du_out_hdmi0: endpoint {
+					};
+				};
+				port at 2 {
+					reg = <2>;
+					du_out_lvds0: endpoint {
+					};
+				};
+			};
+		};
+
+		hsusb: usb at e6590000 {
+			/* placeholder */
+		};
+
+		pciec0: pcie at fe000000 {
+			/* placeholder */
+		};
+
+		pciec1: pcie at ee800000 {
+			/* placeholder */
+		};
+
+		rcar_sound: sound at ec500000 {
+			/* placeholder */
+
+			rcar_sound,dvc {
+				dvc0: dvc-0 {
+				};
+				dvc1: dvc-1 {
+				};
+			};
+
+			rcar_sound,src {
+				src0: src-0 {
+				};
+				src1: src-1 {
+				};
+			};
+
+			rcar_sound,ssi {
+				ssi0: ssi-0 {
+				};
+				ssi1: ssi-1 {
+				};
+			};
+		};
+
+		usb2_phy1: usb-phy at ee0a0200 {
+			/* placeholder */
+		};
+
+		sdhi0: sd at ee100000 {
+			/* placeholder */
+		};
+
+		sdhi1: sd at ee120000 {
+			/* placeholder */
+		};
+
+		sdhi2: sd at ee140000 {
+			/* placeholder */
+		};
+
+		sdhi3: sd at ee160000 {
+			/* placeholder */
+		};
+
+		usb3_phy0: usb-phy at e65ee000 {
+			/* placeholder */
+		};
+
+		usb3_peri0: usb at ee020000 {
+			/* placeholder */
+		};
+
+		xhci0: usb at ee000000 {
+			/* placeholder */
+		};
+
+		wdt0: watchdog at e6020000 {
+			/* placeholder */
+		};
+	};
+};
-- 
2.11.0
