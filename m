From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 17 Sep 2014 10:02:44 -0600
Subject: [PATCH 1/2] ARM: tegra: tegra124: Add PCIe support
Message-ID: <1410969765-18070-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Add the PCIe controller device tree node and hook up the PCIe PHY from
the XUSB pad controller.

Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
I intend to apply these immediately, since they simply implement the DT
bindings that were posted a while ago and recently merged into the PCIe
tree, follow the same layout as PCIe support for earlier chips, and the
patches have had plenty of local testing by myself.

 arch/arm/boot/dts/tegra124.dtsi | 66 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 0ba3a0b6685f..478c555ebd96 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -12,6 +12,72 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	pcie-controller at 0,01003000 {
+		compatible = "nvidia,tegra124-pcie";
+		device_type = "pci";
+		reg = <0x0 0x01003000 0x0 0x00000800   /* PADS registers */
+		       0x0 0x01003800 0x0 0x00000800   /* AFI registers */
+		       0x0 0x02000000 0x0 0x10000000>; /* configuration space */
+		reg-names = "pads", "afi", "cs";
+		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
+			     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
+		interrupt-names = "intr", "msi";
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+
+		bus-range = <0x00 0xff>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+
+		ranges = <0x82000000 0 0x01000000 0x0 0x01000000 0 0x00001000   /* port 0 configuration space */
+			  0x82000000 0 0x01001000 0x0 0x01001000 0 0x00001000   /* port 1 configuration space */
+			  0x81000000 0 0x0        0x0 0x12000000 0 0x00010000   /* downstream I/O (64 KiB) */
+			  0x82000000 0 0x13000000 0x0 0x13000000 0 0x0d000000   /* non-prefetchable memory (208 MiB) */
+			  0xc2000000 0 0x20000000 0x0 0x20000000 0 0x20000000>; /* prefetchable memory (512 MiB) */
+
+		clocks = <&tegra_car TEGRA124_CLK_PCIE>,
+			 <&tegra_car TEGRA124_CLK_AFI>,
+			 <&tegra_car TEGRA124_CLK_PLL_E>,
+			 <&tegra_car TEGRA124_CLK_CML0>;
+		clock-names = "pex", "afi", "pll_e", "cml";
+		resets = <&tegra_car 70>,
+			 <&tegra_car 72>,
+			 <&tegra_car 74>;
+		reset-names = "pex", "afi", "pcie_x";
+		status = "disabled";
+
+		phys = <&padctl TEGRA_XUSB_PADCTL_PCIE>;
+		phy-names = "pcie";
+
+		pci at 1,0 {
+			device_type = "pci";
+			assigned-addresses = <0x82000800 0 0x01000000 0 0x1000>;
+			reg = <0x000800 0 0 0 0>;
+			status = "disabled";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+
+			nvidia,num-lanes = <2>;
+		};
+
+		pci at 2,0 {
+			device_type = "pci";
+			assigned-addresses = <0x82001000 0 0x01001000 0 0x1000>;
+			reg = <0x001000 0 0 0 0>;
+			status = "disabled";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+
+			nvidia,num-lanes = <1>;
+		};
+	};
+
 	host1x at 0,50000000 {
 		compatible = "nvidia,tegra124-host1x", "simple-bus";
 		reg = <0x0 0x50000000 0x0 0x00034000>;
-- 
1.9.1
