From: digetx@gmail.com (Dmitry Osipenko)
Date: Sun, 18 Feb 2018 20:01:46 +0300
Subject: [PATCH v1 2/2] ARM: dts: tegra30: Add video decoder node
In-Reply-To: <cover.1518973069.git.digetx@gmail.com>
References: <cover.1518973069.git.digetx@gmail.com>
Message-ID: <6ac145a1259566f85c88bd29be9c8b3e44e53bcf.1518973069.git.digetx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree node for the Video Decoder Engine found on Tegra30 SoC's.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 1fb0c421a9d8..8ae72ffe0048 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -17,6 +17,11 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0 0x40000000 0x40000>;
+
+		vde_pool: vde {
+			reg = <0x400 0x3fc00>;
+			pool;
+		};
 	};
 
 	pcie at 3000 {
@@ -366,6 +371,28 @@
 		*/
 	};
 
+	vde at 6001a000 {
+		compatible = "nvidia,tegra30-vde", "nvidia,tegra20-vde";
+		reg = <0x6001a000 0x1000   /* Syntax Engine */
+		       0x6001b000 0x1000   /* Video Bitstream Engine */
+		       0x6001c000  0x100   /* Macroblock Engine */
+		       0x6001c200  0x100   /* Post-processing Engine */
+		       0x6001c400  0x100   /* Motion Compensation Engine */
+		       0x6001c600  0x100   /* Transform Engine */
+		       0x6001c800  0x100   /* Pixel prediction block */
+		       0x6001ca00  0x100   /* Video DMA */
+		       0x6001d800  0x400>; /* Video frame controls */
+		reg-names = "sxe", "bsev", "mbe", "ppe", "mce",
+			    "tfe", "ppb", "vdma", "frameid";
+		iram = <&vde_pool>; /* IRAM region */
+		interrupts = <GIC_SPI  9 IRQ_TYPE_LEVEL_HIGH>, /* Sync token interrupt */
+			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>, /* BSE-V interrupt */
+			     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>; /* SXE interrupt */
+		interrupt-names = "sync-token", "bsev", "sxe";
+		clocks = <&tegra_car TEGRA30_CLK_VDE>;
+		resets = <&tegra_car 61>;
+	};
+
 	apbmisc at 70000800 {
 		compatible = "nvidia,tegra30-apbmisc", "nvidia,tegra20-apbmisc";
 		reg = <0x70000800 0x64   /* Chip revision */
-- 
2.16.1
