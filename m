From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 27 Jun 2016 17:02:46 +0800
Subject: [PATCH 08/10] arm64: dts: tegra: Add Tegra186 support
In-Reply-To: <20160627090248.23621-1-josephl@nvidia.com>
References: <20160627090248.23621-1-josephl@nvidia.com>
Message-ID: <20160627090248.23621-9-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the initial support of Tegra186 SoC, which can help to bring
up the debug console and initrd for further developing.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 77 ++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra186.dtsi

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
new file mode 100644
index 000000000000..bed30f30bb0b
--- /dev/null
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -0,0 +1,77 @@
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/mailbox/tegra-hsp.h>
+
+/ {
+	compatible = "nvidia,tegra186";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	uarta: serial at 03100000 {
+		compatible = "nvidia,tegra186-uart", "nvidia,tegra20-uart";
+		reg = <0x0 0x03100000 0x0 0x40>;
+		reg-shift = <2>;
+		interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	gic: interrupt-controller at 03881000 {
+		compatible = "arm,gic-400";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x0 0x03881000 0x0 0x1000>,
+		      <0x0 0x03882000 0x0 0x2000>;
+		interrupts = <GIC_PPI 9
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		interrupt-parent = <&gic>;
+	};
+
+	hsp_top: hsp at 03c00000 {
+		compatible = "nvidia,tegra186-hsp";
+		reg = <0x0 0x03c00000 0x0 0xa0000>;
+		interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "doorbell";
+		nvidia,hsp-function = <HSP_DOORBELL>;
+		#mbox-cells = <1>;
+	};
+
+	bpmp at d0000000 {
+		compatible = "nvidia,tegra186-bpmp";
+		mboxes = <&hsp_top HSP_DB_MASTER_BPMP>;
+		shmem = <&cpu_bpmp_tx &cpu_bpmp_rx>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+		status = "disabled";
+	};
+
+	sysram at 30000000 {
+		compatible = "nvidia,tegra186-sysram", "mmio-ram";
+		reg = <0x0 0x30000000 0x0 0x4ffff>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0 0x0 0x0 0x30000000 0x0 0x4ffff>;
+
+		cpu_bpmp_tx: bpmp_shmem at 4e000 {
+			compatible = "nvidia,tegra186-bpmp-shmem";
+			reg = <0x0 0x4e000 0x0 0x1000>;
+		};
+
+		cpu_bpmp_rx: bpmp_shmem at 4f000 {
+			compatible = "nvidia,tegra186-bpmp-shmem";
+			reg = <0x0 0x4f000 0x0 0x1000>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupt-parent = <&gic>;
+	};
+};
-- 
2.9.0
