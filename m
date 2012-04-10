From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 10 Apr 2012 17:19:40 -0600
Subject: [PATCH V2 5/5] ARM: dt: tegra cardhu: basic audio support
In-Reply-To: <1334099980-19527-1-git-send-email-swarren@wwwdotorg.org>
References: <1334099980-19527-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1334099980-19527-5-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Add WM8903 codec nodes, and top-level sound complex node for basic
analog audio over headset jack and internal speakers.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2:
* Adjust sound node compatible value; s/tegra30/tegra/. The requirement
  to specifically version this is removed due to the Tegra ASoC utilities
  code internally determining the chip version.
* Move I2S nodes inside AHUB node, since it's the bus that contains them.
---
 arch/arm/boot/dts/tegra-cardhu.dts |   63 ++++++++++++++++++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-cardhu.dts b/arch/arm/boot/dts/tegra-cardhu.dts
index 0a9f34a..ab8d901 100644
--- a/arch/arm/boot/dts/tegra-cardhu.dts
+++ b/arch/arm/boot/dts/tegra-cardhu.dts
@@ -51,6 +51,15 @@
 				nvidia,pull = <2>;
 				nvidia,tristate = <0>;
 			};
+			dap2_fs_pa2 {
+				nvidia,pins =	"dap2_fs_pa2",
+						"dap2_sclk_pa3",
+						"dap2_din_pa4",
+						"dap2_dout_pa5";
+				nvidia,function = "i2s1";
+				nvidia,pull = <0>;
+				nvidia,tristate = <0>;
+			};
 		};
 	};
 
@@ -92,6 +101,20 @@
 
 	i2c at 7000d000 {
 		clock-frequency = <100000>;
+
+		wm8903: wm8903 at 1a {
+			compatible = "wlf,wm8903";
+			reg = <0x1a>;
+			interrupt-parent = <&gpio>;
+			interrupts = <179 0x04>; /* gpio PW3 */
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			micdet-cfg = <0>;
+			micdet-delay = <100>;
+			gpio-cfg = <0xffffffff 0xffffffff 0 0xffffffff 0xffffffff>;
+		};
 	};
 
 	sdhci at 78000000 {
@@ -111,4 +134,44 @@
 	sdhci at 78000400 {
 		support-8bit;
 	};
+
+	ahub at 70080000 {
+		i2s at 70080300 {
+			status = "disable";
+		};
+
+		i2s at 70080500 {
+			status = "disable";
+		};
+
+		i2s at 70080600 {
+			status = "disable";
+		};
+
+		i2s at 70080700 {
+			status = "disable";
+		};
+	};
+
+	sound {
+		compatible = "nvidia,tegra-audio-wm8903-cardhu",
+			     "nvidia,tegra-audio-wm8903";
+		nvidia,model = "NVIDIA Tegra Cardhu";
+
+		nvidia,audio-routing =
+			"Headphone Jack", "HPOUTR",
+			"Headphone Jack", "HPOUTL",
+			"Int Spk", "ROP",
+			"Int Spk", "RON",
+			"Int Spk", "LOP",
+			"Int Spk", "LON",
+			"Mic Jack", "MICBIAS",
+			"IN1L", "Mic Jack";
+
+		nvidia,i2s-controller = <&tegra_i2s1>;
+		nvidia,audio-codec = <&wm8903>;
+
+		nvidia,spkr-en-gpios = <&wm8903 2 0>;
+		nvidia,hp-det-gpios = <&gpio 178 0>; /* gpio PW2 */
+	};
 };
-- 
1.7.0.4
