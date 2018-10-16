From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 16 Oct 2018 13:50:53 +0300
Subject: [PATCH 2/2] arm64: dts: clearfog-gt-8k: 1G eth PHY reset signal
In-Reply-To: <d02745d924c2ad65cbd1194fc35d12796613722d.1539687053.git.baruch@tkos.co.il>
References: <d02745d924c2ad65cbd1194fc35d12796613722d.1539687053.git.baruch@tkos.co.il>
Message-ID: <d7d0516199244af29efdd5231313a6519f5a4350.1539687053.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reset signal controls the Marvell 1512 1G PHY.

Note that current implementation queries the PHY over the MDIO bus
(get_phy_device() call from of_mdiobus_register_phy()) before reset
signal deassert. If the PHY reset signal is asserted at boot time, PHY
registration fails. So current code relies on the bootloader to deassert
the reset signal.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
index af1310c53bc8..73df0ef5e0c4 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
@@ -337,6 +337,10 @@
 		 */
 		marvell,reg-init = <3 16 0 0x1017>;
 		reg = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp0_copper_eth_phy_reset>;
+		reset-gpios = <&cp1_gpio1 11 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <10000>;
 	};
 
 	switch0: switch0 at 4 {
-- 
2.19.1
