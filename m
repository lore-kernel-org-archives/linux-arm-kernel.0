From: ayufan@ayufan.eu (=?UTF-8?q?Kamil=20Trzci=C5=84ski?=)
Date: Mon, 22 Jan 2018 18:46:22 +0100
Subject: [PATCH] rock64: dts: fix gmac2io stability issues
Message-ID: <20180122174628.15613-1-ayufan@ayufan.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit enables thresh dma mode as this forces to disable checksuming,
and chooses delay values which make the interface stable.

These changes are needed, because ROCK64 is faced with two problems:
1. tx checksuming does not work with packets larger than 1498,
2. the default delays for tx/rx are not stable when using 1Gbps connection.

Delays were found out with:
https://github.com/ayufan-rock64/linux-build/tree/master/recipes/gmac-delays-test

Change-Id: Ie894df4b52122988da683c02e3a05d635a5c7b84
Signed-off-by: Kamil Trzci?ski <ayufan@ayufan.eu>
---
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 5602ec01fed9..bcc0bb35d840 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -132,8 +132,6 @@
 	assigned-clocks = <&cru SCLK_MAC2IO>, <&cru SCLK_MAC2IO_EXT>;
 	assigned-clock-parents = <&gmac_clkin>, <&gmac_clkin>;
 	clock_in_out = "input";
-	/* shows instability at 1GBit right now */
-	max-speed = <100>;
 	phy-supply = <&vcc_io>;
 	phy-mode = "rgmii";
 	pinctrl-names = "default";
@@ -141,8 +139,9 @@
 	snps,reset-gpio = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 50000>;
-	tx_delay = <0x26>;
-	rx_delay = <0x11>;
+	snps,force_thresh_dma_mode;
+	tx_delay = <0x24>;
+	rx_delay = <0x18>;
 	status = "okay";
 };
 
-- 
2.14.1
