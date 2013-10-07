From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 7 Oct 2013 15:31:22 +0800
Subject: [PATCH 4/7] ARM: tegra: Add initial device tree for Tegra124
In-Reply-To: <1381131085-26116-1-git-send-email-josephl@nvidia.com>
References: <1381131085-26116-1-git-send-email-josephl@nvidia.com>
Message-ID: <1381131085-26116-5-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initial support for Tegra 124 SoC. This is expected to be included in
the board DTS files.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 132 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100644 arch/arm/boot/dts/tegra124.dtsi

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
new file mode 100644
index 0000000..6d0d737
--- /dev/null
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -0,0 +1,132 @@
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+#include "skeleton.dtsi"
+
+/ {
+	compatible = "nvidia,tegra124";
+	interrupt-parent = <&gic>;
+
+	gic: interrupt-controller at 50041000 {
+		compatible = "arm,cortex-a15-gic";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x50041000 0x1000>,
+		      <0x50042000 0x1000>,
+		      <0x50044000 0x2000>,
+		      <0x50046000 0x2000>;
+		interrupts = <GIC_PPI 9
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	timer at 60005000 {
+		compatible = "nvidia,tegra124-timer", "nvidia,tegra20-timer";
+		reg = <0x60005000 0x400>;
+		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	/*
+	 * There are two serial driver i.e. 8250 based simple serial
+	 * driver and APB DMA based serial driver for higher baudrate
+	 * and performace. To enable the 8250 based driver, the compatible
+	 * is "nvidia,tegra124-uart", "nvidia,tegra20-uart" and to enable
+	 * the APB DMA based serial driver, the comptible is
+	 * "nvidia,tegra124-hsuart", "nvidia,tegra30-hsuart".
+	 */
+	serial at 70006000 {
+		compatible = "nvidia,tegra124-uart", "nvidia,tegra20-uart";
+		reg = <0x70006000 0x40>;
+		reg-shift = <2>;
+		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	serial at 70006040 {
+		compatible = "nvidia,tegra124-uart", "nvidia,tegra20-uart";
+		reg = <0x70006040 0x40>;
+		reg-shift = <2>;
+		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	serial at 70006200 {
+		compatible = "nvidia,tegra124-uart", "nvidia,tegra20-uart";
+		reg = <0x70006200 0x40>;
+		reg-shift = <2>;
+		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	serial at 70006300 {
+		compatible = "nvidia,tegra124-uart", "nvidia,tegra20-uart";
+		reg = <0x70006300 0x40>;
+		reg-shift = <2>;
+		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	serial at 70006400 {
+		compatible = "nvidia,tegra124-uart", "nvidia,tegra20-uart";
+		reg = <0x70006400 0x40>;
+		reg-shift = <2>;
+		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	rtc {
+		compatible = "nvidia,tegra124-rtc", "nvidia,tegra20-rtc";
+		reg = <0x7000e000 0x100>;
+		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	pmc {
+		compatible = "nvidia,tegra124-pmc", "nvidia,tegra114-pmc";
+		reg = <0x7000e400 0x400>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0>;
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <1>;
+		};
+
+		cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <2>;
+		};
+
+		cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <3>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <GIC_PPI 13
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+};
-- 
1.8.4
