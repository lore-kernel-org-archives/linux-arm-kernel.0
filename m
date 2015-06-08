From: acourbot@nvidia.com (Alexandre Courbot)
Date: Mon, 8 Jun 2015 16:41:32 +0900
Subject: [PATCH] ARM: tegra: roth: Add MMC pwrseq to power wifi on
Message-ID: <1433749292-13890-1-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The wifi chip on roth needs to have its reset deasserted in order to be
probed. Add a mmc-pwrseq-simple to allow this to happen and get wifi
working at boot time.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 arch/arm/boot/dts/tegra114-roth.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/tegra114-roth.dts b/arch/arm/boot/dts/tegra114-roth.dts
index ea1772a686c2..04762532a178 100644
--- a/arch/arm/boot/dts/tegra114-roth.dts
+++ b/arch/arm/boot/dts/tegra114-roth.dts
@@ -972,6 +972,11 @@
 		nvidia,invert-interrupt;
 	};
 
+	sdhci0_pwrseq: sdhci0_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpio TEGRA_GPIO(CC, 5) GPIO_ACTIVE_LOW>;
+	};
+
 	/* Wifi */
 	sdhci at 78000000 {
 		status = "okay";
@@ -979,6 +984,7 @@
 		broken-cd;
 		keep-power-in-suspend;
 		cap-sdio-irq;
+		mmc-pwrseq = <&sdhci0_pwrseq>;
 	};
 
 	/* SD card */
-- 
2.4.2
