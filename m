From: twarren@nvidia.com (Tom Warren)
Date: Fri, 23 Oct 2015 16:30:42 -0700
Subject: [PATCH v2] spi: Tegra: add device tree binding doc for SPI/QSPI
Message-ID: <1445643042-5764-1-git-send-email-twarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the device tree binding doc for the Tegra
SPI/QSPI controllers on Tegra114 and Tegra210.

Signed-off-by: Tom Warren <twarren@nvidia.com>
---
Changes in v2:
- based it more on kernel's nvidia,tegra114-spi.txt binding
- changes based on prelim review by swarren at nvidia.com

 doc/device-tree-bindings/spi/spi-tegra.txt | 60 ++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 doc/device-tree-bindings/spi/spi-tegra.txt

diff --git a/doc/device-tree-bindings/spi/spi-tegra.txt b/doc/device-tree-bindings/spi/spi-tegra.txt
new file mode 100644
index 0000000..3664267
--- /dev/null
+++ b/doc/device-tree-bindings/spi/spi-tegra.txt
@@ -0,0 +1,60 @@
+NVIDIA Tegra SPI/QSPI controller.
+
+Required properties:
+- compatible : should be one of the following:
+  "nvidia,tegra114-spi" (for Tegra114)
+  "nvidia,tegra210-qspi" (for Tegra210)
+- reg: Should contain SPI registers location and length.
+- interrupts: Should contain SPI interrupts.
+- clock-names : Must include the following entries:
+  - spi
+- clocks : Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
+- resets : Must contain an entry for each entry in reset-names.
+  See ../reset/reset.txt for details.
+- reset-names : Must include the following entries:
+  - spi
+
+Optional properties:
+- dmas : Must contain an entry for each entry in clock-names.
+  See ../dma/dma.txt for details.
+- dma-names : Must include the following entries:
+  - rx
+  - tx
+
+Recommended properties:
+- spi-max-frequency: Definition as per spi-bus.txt
+
+Example:
+
+spi at 7000d600 {
+	compatible = "nvidia,tegra114-spi";
+	reg = <0x7000d600 0x200>;
+	interrupts = <0 82 0x04>;
+	spi-max-frequency = <25000000>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clocks = <&tegra_car 44>;
+	clock-names = "spi";
+	resets = <&tegra_car 44>;
+	reset-names = "spi";
+	dmas = <&apbdma 16>, <&apbdma 16>;
+	dma-names = "rx", "tx";
+	status = "disabled";
+};
+
+spi at 70410000 {
+	compatible = "nvidia,tegra210-qspi";
+	reg = <0x0 0x70410000 0x0 0x1000>;
+	interrupts = <0 10 0x04>;
+	spi-max-frequency = <24000000>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clocks = <&tegra_car 211>;
+	clock-names = "spi";
+	resets = <&tegra_car 211>;
+	reset-names = "spi";
+	dmas = <&apbdma 16>, <&apbdma 16>;
+	dma-names = "rx", "tx";
+	status = "disabled";
+};
-- 
1.8.2.1.610.g562af5b
