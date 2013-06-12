From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 12 Jun 2013 11:37:14 -0600
Subject: [PATCH 1/3] ARM: tegra: enable audio on Dalmore
Message-ID: <1371058636-25244-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Dalmore uses the RT5640 audio CODEC. Instantiate this on the I2C bus.
Enable the relevant Tegra I2C controller. Add the top-level "sound" node
to hook everything together, and provide a "sound card" device.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra114-dalmore.dts | 39 ++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index cfeb0f5..b009b90 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -728,6 +728,15 @@
 			sbs,i2c-retry-count = <2>;
 			sbs,poll-retry-count = <100>;
 		};
+
+		rt5640: rt5640 {
+			compatible = "realtek,rt5640";
+			reg = <0x1c>;
+			interrupt-parent = <&gpio>;
+			interrupts = <TEGRA_GPIO(W, 3) GPIO_ACTIVE_HIGH>;
+			realtek,ldo1-en-gpios =
+				<&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
+		};
 	};
 
 	i2c at 7000d000 {
@@ -842,6 +851,12 @@
 		nvidia,invert-interrupt;
 	};
 
+	ahub {
+		i2s at 70080400 {
+			status = "okay";
+		};
+	};
+
 	sdhci at 78000400 {
 		cd-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
 		bus-width = <4>;
@@ -936,4 +951,28 @@
 			vin-supply = <&tps65090_dcdc1_reg>;
 		};
 	};
+
+	sound {
+		compatible = "nvidia,tegra-audio-rt5640-dalmore",
+			     "nvidia,tegra-audio-rt5640";
+		nvidia,model = "NVIDIA Tegra Dalmore";
+
+		nvidia,audio-routing =
+			"Headphones", "HPOR",
+			"Headphones", "HPOL",
+			"Speakers", "SPORP",
+			"Speakers", "SPORN",
+			"Speakers", "SPOLP",
+			"Speakers", "SPOLN";
+
+		nvidia,i2s-controller = <&tegra_i2s1>;
+		nvidia,audio-codec = <&rt5640>;
+
+		nvidia,hp-det-gpios = <&gpio TEGRA_GPIO(R, 7) GPIO_ACTIVE_HIGH>;
+
+		clocks = <&tegra_car TEGRA114_CLK_PLL_A>,
+			 <&tegra_car TEGRA114_CLK_PLL_A_OUT0>,
+			 <&tegra_car TEGRA114_CLK_EXTERN1>;
+		clock-names = "pll_a", "pll_a_out0", "mclk";
+	};
 };
-- 
1.8.1.5
