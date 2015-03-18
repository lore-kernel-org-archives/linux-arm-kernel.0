From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed, 18 Mar 2015 10:52:21 +0100
Subject: [PATCH v6 06/12] ARM: tegra: Use pwrseq-simple for the wifi in Nyan
In-Reply-To: <1426672363-30667-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1426672363-30667-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1426672363-30667-7-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Nyan boards have a Marvell 88w8897 wifi card connected through SDIO
that needs the reset line to be asserted before mmc power up and deasserted
afterwards.

This patch also adds references to the power supplies of the card so that
the regulators are enabled when it's probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Acked-by: Stephen Warren <swarren@nvidia.com>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
---
 arch/arm/boot/dts/tegra124-nyan.dtsi | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index 579b0b9..d3a95f9 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -207,7 +207,6 @@
 					regulator-name = "+1.8V_VDDIO";
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
-					regulator-boot-on;
 					regulator-always-on;
 				};
 
@@ -364,12 +363,20 @@
 		status = "okay";
 	};
 
+	sdhci0_pwrseq: sdhci0_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+
+		reset-gpios = <&gpio TEGRA_GPIO(X, 7) GPIO_ACTIVE_LOW>;
+	};
+
 	sdhci at 0,700b0000 { /* WiFi/BT on this bus */
 		status = "okay";
-		power-gpios = <&gpio TEGRA_GPIO(X, 7) GPIO_ACTIVE_HIGH>;
 		bus-width = <4>;
 		no-1-8-v;
 		non-removable;
+		mmc-pwrseq = <&sdhci0_pwrseq>;
+		vmmc-supply = <&vdd_3v3_lp0>;
+		vqmmc-supply = <&vddio_1v8>;
 	};
 
 	sdhci at 0,700b0400 { /* SD Card on this bus */
-- 
2.1.0
