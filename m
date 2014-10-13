From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 13 Oct 2014 12:33:46 +0200
Subject: [PATCH 04/12] of: Add NVIDIA Tegra memory controller binding
In-Reply-To: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1413196434-5292-4-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

The memory controller on NVIDIA Tegra exposes various knobs that can be
used to tune the behaviour of the clients attached to it.

In addition, the memory controller implements an SMMU (IOMMU) which can
translate I/O virtual addresses to physical addresses for clients. This
is useful for scatter-gather operation on devices that don't support it
natively and for virtualization or process separation.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- add missing clocks and clock-names properties
- add example

 .../memory-controllers/nvidia,tegra-mc.txt         | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra-mc.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra-mc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra-mc.txt
new file mode 100644
index 000000000000..f3db93c85eea
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra-mc.txt
@@ -0,0 +1,36 @@
+NVIDIA Tegra Memory Controller device tree bindings
+===================================================
+
+Required properties:
+- compatible: Should be "nvidia,tegra<chip>-mc"
+- reg: Physical base address and length of the controller's registers.
+- clocks: Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
+- clock-names: Must include the following entries:
+  - mc: the module's clock input
+- interrupts: The interrupt outputs from the controller.
+- #iommu-cells: Should be 1. The single cell of the IOMMU specifier defines
+  the SWGROUP of the master.
+
+This device implements an IOMMU that complies with the generic IOMMU binding.
+See ../iommu/iommu.txt for details.
+
+Example:
+--------
+
+	mc: memory-controller at 0,70019000 {
+		compatible = "nvidia,tegra124-mc";
+		reg = <0x0 0x70019000 0x0 0x1000>;
+		clocks = <&tegra_car TEGRA124_CLK_MC>;
+		clock-names = "mc";
+
+		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+
+		#iommu-cells = <1>;
+	};
+
+	sdhci at 0,700b0000 {
+		compatible = "nvidia,tegra124-sdhci";
+		...
+		iommus = <&mc TEGRA_SWGROUP_SDMMC1A>;
+	};
-- 
2.1.2
