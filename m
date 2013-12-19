From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Thu, 19 Dec 2013 04:49:22 -0800
Subject: [PATCH 4/6] ARM: DTS: tegra: add the DFLL IP block to the T114 SoC
 file
In-Reply-To: <20131219122857.3226.42830.stgit@tamien>
References: <20131219122857.3226.42830.stgit@tamien>
Message-ID: <20131219123719.3226.44864.stgit@tamien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic DT bindings for the DFLL IP block for the NVIDIA Tegra114 SoC.

Signed-off-by: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Matthew Longnecker <mlongnecker@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
---
 .../bindings/clock/nvidia,tegra114-dfll.txt        |   43 ++++++++++++++++++++
 arch/arm/boot/dts/tegra114.dtsi                    |   10 +++++
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/nvidia,tegra114-dfll.txt

diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra114-dfll.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra114-dfll.txt
new file mode 100644
index 000000000000..b868bf97bc3d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/nvidia,tegra114-dfll.txt
@@ -0,0 +1,43 @@
+NVIDIA Tegra114 DFLL FCPU clocksource data in the SoC DTS file:
+
+Required properties:
+
+- compatible : "nvidia,tegra114-dfll-fcpu"
+
+- reg : Must contain the starting physical address and length for the
+        DFLL's MMIO register space, including the DFLL-to-I2C
+        controller interface and the DFLL's I2C controller.
+
+- clocks : Must contain an array of two-cell arrays, one per clock.
+           DFLL source clocks.  At minimum this should include the
+           reference clock source and the IP block's main clock
+           source.  Also it should contain the DFLL's I2C controller
+           clock source.  The format is <&clock-provider-phandle
+           clock-id>.
+
+- clock-names : Must contain an array of strings, one per 'clocks'
+                two-cell array.  The position in the array of these
+                strings must correspond to the position in the 'clocks'
+                array (see above).  The DFLL driver currently requires
+                the "soc", "ref", and "i2c" clock names to be populated.
+
+
+Optional properties:
+
+- status : device availability -- managed by the DT integration code, not
+           the DFLL driver.  Should be set to "disabled" in the SoC
+           DTS file.
+
+
+Example:
+
+dfll at 70110000 {
+        compatible = "nvidia,tegra114-dfll-fcpu";
+        reg = <0x70110000 0x400>;
+        clocks = <&tegra_car TEGRA114_CLK_DFLL_SOC>,
+                 <&tegra_car TEGRA114_CLK_DFLL_REF>,
+                 <&tegra_car TEGRA114_CLK_I2C5>;
+        clock-names = "soc", "ref", "i2c";
+        status = "disabled";
+};
+
diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index ae855ec60bbd..1cd59d79e67c 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -480,6 +480,16 @@
 		};
 	};
 
+	dfll at 70110000 {
+		compatible = "nvidia,tegra114-dfll-fcpu";
+		reg = <0x70110000 0x400>;
+		clocks = <&tegra_car TEGRA114_CLK_DFLL_SOC>,
+			 <&tegra_car TEGRA114_CLK_DFLL_REF>,
+			 <&tegra_car TEGRA114_CLK_I2C5>;
+		clock-names = "soc", "ref", "i2c";
+		status = "disabled";
+	};
+
 	sdhci at 78000000 {
 		compatible = "nvidia,tegra114-sdhci", "nvidia,tegra30-sdhci";
 		reg = <0x78000000 0x200>;
