From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 15 Jan 2015 17:12:21 +0100
Subject: [PATCH v2 09/11] ARM: tegra: Use pwrseq-simple for the wifi in Nyan
In-Reply-To: <1421338359-27467-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1421338359-27467-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1421338359-27467-10-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Nyan boards have a Marvell 88w8897 wifi card connected through SDIO
that need the reset line to be hold active for several milliseconds.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 arch/arm/boot/dts/tegra124-nyan.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index 25bbcbe..dbaf261f 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -365,11 +365,19 @@
 		status = "okay";
 	};
 
+	sdhci0_pwrseq: sdhci0_pwrseq {
+		compatible = "mmc,pwrseq-simple";
+
+                reset-gpios = <&gpio TEGRA_GPIO(X, 7) GPIO_ACTIVE_LOW>;
+                delay = <20>; /* ms */
+	};
+
 	sdhci at 0,700b0000 { /* WiFi/BT on this bus */
 		status = "okay";
 		bus-width = <4>;
 		no-1-8-v;
 		non-removable;
+		mmc-pwrseq = <&sdhci0_pwrseq>;
 	};
 
 	sdhci at 0,700b0400 { /* SD Card on this bus */
-- 
1.9.3
