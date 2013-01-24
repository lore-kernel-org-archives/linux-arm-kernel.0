From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 24 Jan 2013 17:07:33 +0100
Subject: [PATCH 3/3] ARM: shmobile: move pin configuration on
 armadillo800eva-reference to DT
In-Reply-To: <1359043653-11374-1-git-send-email-g.liakhovetski@gmx.de>
References: <1359043653-11374-1-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <1359043653-11374-4-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use pinctrl and sh-eth DT bindings to configure sh-eth MAC pins on
armadillo800eva in reference implementation.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |    7 +++++
 .../board-armadillo800eva-reference.c              |   24 --------------------
 2 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 11cb0f9..b815ffd9 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -26,9 +26,12 @@
 		reg = <0xe9a00000 0x800>, <0xe9a01800 0x800>;
 		interrupts = <0x500>;
 		phy-mode = "mii";
+		phy-reset-gpios = <&gpio 18 1>;
 		sh-eth,edmac-endian = "little";
 		sh-eth,register-type = "gigabit";
 		sh-eth,phy-id = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&eth_pins>;
 	};
 
 	reg_3p3v: regulator at 0 {
@@ -137,4 +140,8 @@
 		renesas,pins = "mmc0_data8_1", "mmc0_ctrl_1";
 		renesas,function = "mmc0";
 	};
+	eth_pins: pfc_eth_pins {
+		renesas,pins = "eth_base";
+		renesas,function = "eth";
+	};
 };
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
index 92d7106..54ec573e 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
@@ -152,30 +152,6 @@ static void __init eva_init(void)
 	gpio_request(GPIO_FN_SCIFA1_RXD, NULL);
 	gpio_request(GPIO_FN_SCIFA1_TXD, NULL);
 
-	/* GETHER */
-	gpio_request(GPIO_FN_ET_CRS,		NULL);
-	gpio_request(GPIO_FN_ET_MDC,		NULL);
-	gpio_request(GPIO_FN_ET_MDIO,		NULL);
-	gpio_request(GPIO_FN_ET_TX_ER,		NULL);
-	gpio_request(GPIO_FN_ET_RX_ER,		NULL);
-	gpio_request(GPIO_FN_ET_ERXD0,		NULL);
-	gpio_request(GPIO_FN_ET_ERXD1,		NULL);
-	gpio_request(GPIO_FN_ET_ERXD2,		NULL);
-	gpio_request(GPIO_FN_ET_ERXD3,		NULL);
-	gpio_request(GPIO_FN_ET_TX_CLK,		NULL);
-	gpio_request(GPIO_FN_ET_TX_EN,		NULL);
-	gpio_request(GPIO_FN_ET_ETXD0,		NULL);
-	gpio_request(GPIO_FN_ET_ETXD1,		NULL);
-	gpio_request(GPIO_FN_ET_ETXD2,		NULL);
-	gpio_request(GPIO_FN_ET_ETXD3,		NULL);
-	gpio_request(GPIO_FN_ET_PHY_INT,	NULL);
-	gpio_request(GPIO_FN_ET_COL,		NULL);
-	gpio_request(GPIO_FN_ET_RX_DV,		NULL);
-	gpio_request(GPIO_FN_ET_RX_CLK,		NULL);
-
-	gpio_request(GPIO_PORT18, NULL); /* PHY_RST */
-	gpio_direction_output(GPIO_PORT18, 1);
-
 #ifdef CONFIG_CACHE_L2X0
 	/* Early BRESP enable, Shared attribute override enable, 32K*8way */
 	l2x0_init(IOMEM(0xf0002000), 0x40440000, 0x82000fff);
-- 
1.7.2.5
