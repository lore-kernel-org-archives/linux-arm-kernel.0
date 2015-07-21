From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 21 Jul 2015 08:55:25 +0200
Subject: [PATCH] ARM64: dts: Mediatek: mt8173-evb: fix MMC,
 add to USB power domain
Message-ID: <1437461725-12364-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MT8173 E1 chip has a silicon bug which breaks MMC when the USB
power domain is disabled. The E1 chip is only found on the MT8173-evb
board and this board only has the E1 chip, so we can implement this
as a board specific workaround. This patch adds the MMC ports to the
USB power domain to enable the domain whenever MMC is active. Since
people tend to copy-paste add a comment so hopefully people will drop
this line for other boards.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---

This fixes MMC support in conjunction with the SCPSYS power domain driver
currently sitting in Matthias' tree, so this is best fitted in Matthias'
v4.2-next/arm64 branch

 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 459ce6d..1c9dd84 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -317,6 +317,8 @@
 	cap-mmc-highspeed;
 	vmmc-supply = <&mt6397_vemc_3v3_reg>;
 	non-removable;
+	/* Only MT8173 E1 needs USB power domain enabled for MMC */
+	power-domains = <&scpsys MT8173_POWER_DOMAIN_USB>;
 };
 
 &mmc1 {
@@ -331,6 +333,8 @@
 	cd-gpios = <&pio 132 0>;
 	vmmc-supply = <&mt6397_vmch_reg>;
 	vqmmc-supply = <&mt6397_vmc_reg>;
+	/* Only MT8173 E1 needs USB power domain enabled for MMC */
+	power-domains = <&scpsys MT8173_POWER_DOMAIN_USB>;
 };
 
 &pio {
-- 
2.1.4
