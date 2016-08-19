From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 19 Aug 2016 19:32:29 +0200
Subject: [PATCH v3 08/12] arm64: dts: tegra: Add Tegra186 support
In-Reply-To: <20160819173233.13260-1-thierry.reding@gmail.com>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
Message-ID: <20160819173233.13260-9-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joseph Lo <josephl@nvidia.com>

This adds the initial support of Tegra186 SoC. It provides enough to
enable the serial console and boot from an initial ramdisk.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 86 ++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra186.dtsi

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
new file mode 100644
index 000000000000..53b89b1c1e1f
--- /dev/null
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -0,0 +1,86 @@
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/mailbox/tegra186-hsp.h>
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
+	hsp_top0: hsp at 03c00000 {
+		compatible = "nvidia,tegra186-hsp";
+		reg = <0x0 0x03c00000 0x0 0xa0000>;
+		interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "doorbell";
+		#mbox-cells = <2>;
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
+	bpmp: bpmp {
+		compatible = "nvidia,tegra186-bpmp";
+		mboxes = <&hsp_top0 TEGRA_HSP_MBOX_TYPE_DB
+				    TEGRA_HSP_DB_MASTER_BPMP>;
+		shmem = <&cpu_bpmp_tx &cpu_bpmp_rx>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+
+		bpmp_i2c: i2c {
+			compatible = "nvidia,tegra186-bpmp-i2c";
+			nvidia,bpmp = <&bpmp>;
+			nvidia,bpmp-bus-id = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
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
