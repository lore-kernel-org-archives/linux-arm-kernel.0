From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed,  4 Dec 2013 15:26:55 -0700
Subject: [PATCH 3/4] ARM: tegra: add audio-related device to Tegra124 DT
In-Reply-To: <1386196016-25128-1-git-send-email-swarren@wwwdotorg.org>
References: <1386196016-25128-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1386196016-25128-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Tegra124 contains a similar set of audio devices to previous Tegra chips.
Specifically, there is an AHUB device which contains DMA FIFOs and audio
routing, and which hosts various audio-related components such as I2S
controllers.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 103 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 7017e7ae0176..05e9939b4b7c 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -320,6 +320,109 @@
 		status = "disable";
 	};
 
+	ahub at 70300000 {
+		compatible = "nvidia,tegra124-ahub";
+		reg = <0x70300000 0x200>,
+		      <0x70300800 0x800>,
+		      <0x70300200 0x600>;
+		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA124_CLK_D_AUDIO>,
+			 <&tegra_car TEGRA124_CLK_APBIF>;
+		clock-names = "d_audio", "apbif";
+		resets = <&tegra_car 106>, /* d_audio */
+			 <&tegra_car 107>, /* apbif */
+			 <&tegra_car 30>,  /* i2s0 */
+			 <&tegra_car 11>,  /* i2s1 */
+			 <&tegra_car 18>,  /* i2s2 */
+			 <&tegra_car 101>, /* i2s3 */
+			 <&tegra_car 102>, /* i2s4 */
+			 <&tegra_car 108>, /* dam0 */
+			 <&tegra_car 109>, /* dam1 */
+			 <&tegra_car 110>, /* dam2 */
+			 <&tegra_car 10>,  /* spdif */
+			 <&tegra_car 153>, /* amx */
+			 <&tegra_car 185>, /* amx1 */
+			 <&tegra_car 154>, /* adx */
+			 <&tegra_car 180>, /* adx1 */
+			 <&tegra_car 186>, /* afc0 */
+			 <&tegra_car 187>, /* afc1 */
+			 <&tegra_car 188>, /* afc2 */
+			 <&tegra_car 189>, /* afc3 */
+			 <&tegra_car 190>, /* afc4 */
+			 <&tegra_car 191>; /* afc5 */
+		reset-names = "d_audio", "apbif", "i2s0", "i2s1", "i2s2",
+			      "i2s3", "i2s4", "dam0", "dam1", "dam2",
+			      "spdif", "amx", "amx1", "adx", "adx1",
+			      "afc0", "afc1", "afc2", "afc3", "afc4", "afc5";
+		dmas = <&apbdma 1>, <&apbdma 1>,
+		       <&apbdma 2>, <&apbdma 2>,
+		       <&apbdma 3>, <&apbdma 3>,
+		       <&apbdma 4>, <&apbdma 4>,
+		       <&apbdma 6>, <&apbdma 6>,
+		       <&apbdma 7>, <&apbdma 7>,
+		       <&apbdma 12>, <&apbdma 12>,
+		       <&apbdma 13>, <&apbdma 13>,
+		       <&apbdma 14>, <&apbdma 14>,
+		       <&apbdma 29>, <&apbdma 29>;
+		dma-names = "rx0", "tx0", "rx1", "tx1", "rx2", "tx2",
+			    "rx3", "tx3", "rx4", "tx4", "rx5", "tx5",
+			    "rx6", "tx6", "rx7", "tx7", "rx8", "tx8",
+			    "rx9", "tx9";
+		ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		tegra_i2s0: i2s at 70301000 {
+			compatible = "nvidia,tegra124-i2s";
+			reg = <0x70301000 0x100>;
+			nvidia,ahub-cif-ids = <4 4>;
+			clocks = <&tegra_car TEGRA124_CLK_I2S0>;
+			resets = <&tegra_car 30>;
+			reset-names = "i2s";
+			status = "disabled";
+		};
+
+		tegra_i2s1: i2s at 70301100 {
+			compatible = "nvidia,tegra124-i2s";
+			reg = <0x70301100 0x100>;
+			nvidia,ahub-cif-ids = <5 5>;
+			clocks = <&tegra_car TEGRA124_CLK_I2S1>;
+			resets = <&tegra_car 11>;
+			reset-names = "i2s";
+			status = "disabled";
+		};
+
+		tegra_i2s2: i2s at 70301200 {
+			compatible = "nvidia,tegra124-i2s";
+			reg = <0x70301200 0x100>;
+			nvidia,ahub-cif-ids = <6 6>;
+			clocks = <&tegra_car TEGRA124_CLK_I2S2>;
+			resets = <&tegra_car 18>;
+			reset-names = "i2s";
+			status = "disabled";
+		};
+
+		tegra_i2s3: i2s at 70301300 {
+			compatible = "nvidia,tegra124-i2s";
+			reg = <0x70301300 0x100>;
+			nvidia,ahub-cif-ids = <7 7>;
+			clocks = <&tegra_car TEGRA124_CLK_I2S3>;
+			resets = <&tegra_car 101>;
+			reset-names = "i2s";
+			status = "disabled";
+		};
+
+		tegra_i2s4: i2s at 70301400 {
+			compatible = "nvidia,tegra124-i2s";
+			reg = <0x70301400 0x100>;
+			nvidia,ahub-cif-ids = <8 8>;
+			clocks = <&tegra_car TEGRA124_CLK_I2S4>;
+			resets = <&tegra_car 102>;
+			reset-names = "i2s";
+			status = "disabled";
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.8.1.5
