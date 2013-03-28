From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 28 Mar 2013 12:18:38 -0600
Subject: [PATCH] ARM: tegra: add clocks property to AC'97 sound nodes
Message-ID: <1364494718-12098-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Audio-related clocks need to be represented in the device tree. Update
bindings to describe which clocks are needed, and DT files to include
those clocks.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
I forgot to add the clocks to AC'97 based sound nodes in my previous
patch. This patch fixes that.
---
 .../devicetree/bindings/sound/nvidia,tegra-audio-wm9712.txt    |    8 ++++++++
 arch/arm/boot/dts/tegra20-colibri-512.dtsi                     |    3 +++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm9712.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm9712.txt
index be35d34..ad589b1 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm9712.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm9712.txt
@@ -2,6 +2,11 @@ NVIDIA Tegra audio complex
 
 Required properties:
 - compatible : "nvidia,tegra-audio-wm9712"
+- clocks : Must contain an entry for each entry in clock-names.
+- clock-names : Must include the following entries:
+  "pll_a" (The Tegra clock of that name),
+  "pll_a_out0" (The Tegra clock of that name),
+  "mclk" (The Tegra cdev1/extern1 clock, which feeds the CODEC's mclk)
 - nvidia,model : The user-visible name of this sound complex.
 - nvidia,audio-routing : A list of the connections between audio components.
   Each entry is a pair of strings, the first being the connection's sink,
@@ -48,4 +53,7 @@ sound {
 		"Mic", "MIC1";
 
 	nvidia,ac97-controller = <&ac97>;
+
+	clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 93>;
+	clock-names = "pll_a", "pll_a_out0", "mclk";
 };
diff --git a/arch/arm/boot/dts/tegra20-colibri-512.dtsi b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
index cb73e62..79af149 100644
--- a/arch/arm/boot/dts/tegra20-colibri-512.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
@@ -460,6 +460,9 @@
 			"Mic", "MIC1";
 
 		nvidia,ac97-controller = <&ac97>;
+
+		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 93>;
+		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 
 	regulators {
-- 
1.7.10.4
