From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 17 Nov 2016 18:11:28 +0100
Subject: [PATCH 6/9] arm64: tegra: Add GPIO controllers on Tegra186
In-Reply-To: <20161117171131.20062-1-thierry.reding@gmail.com>
References: <20161117171131.20062-1-thierry.reding@gmail.com>
Message-ID: <20161117171131.20062-6-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Tegra186 has two GPIO controllers that are no longer compatible with the
controller found on earlier generations. One of these controllers exists
in an always-on partition of the SoC whereas the other can be clock- and
powergated.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 1aca69f24fb0..62fa85ae0271 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -1,4 +1,5 @@
 #include <dt-bindings/clock/tegra186-clock.h>
+#include <dt-bindings/gpio/tegra186-gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/tegra186-hsp.h>
 #include <dt-bindings/reset/tegra186-reset.h>
@@ -9,6 +10,23 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	gpio: gpio at 2200000 {
+		compatible = "nvidia,tegra186-gpio";
+		reg-names = "security", "gpio";
+		reg = <0x0 0x2200000 0x0 0x10000>,
+		      <0x0 0x2210000 0x0 0x10000>;
+		interrupts = <GIC_SPI  47 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI  50 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI  53 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI  56 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI  59 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
 	uarta: serial at 3100000 {
 		compatible = "nvidia,tegra186-uart", "nvidia,tegra20-uart";
 		reg = <0x0 0x03100000 0x0 0x40>;
@@ -277,6 +295,18 @@
 		status = "disabled";
 	};
 
+	gpio_aon: gpio at c2f0000 {
+		compatible = "nvidia,tegra186-gpio-aon";
+		reg-names = "security", "gpio";
+		reg = <0x0 0xc2f0000 0x0 0x1000>,
+		      <0x0 0xc2f1000 0x0 0x1000>;
+		interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
 	sysram at 30000000 {
 		compatible = "nvidia,tegra186-sysram", "mmio-sram";
 		reg = <0x0 0x30000000 0x0 0x50000>;
-- 
2.10.2
