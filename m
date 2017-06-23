From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 23 Jun 2017 14:29:51 +0200
Subject: [PATCH 1/2] pinctrl: armada-37xx: Fix uart2 group selection register
 mask
In-Reply-To: <20170623122952.9871-1-gregory.clement@free-electrons.com>
References: <20170623122952.9871-1-gregory.clement@free-electrons.com>
Message-ID: <20170623122952.9871-2-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ken Ma <make@marvell.com>

If north bridge selection register bit1 is clear, pins [10:8] are for
SDIO0 Resetn, Wakeup, and PDN while if bit1 is set, pins [10:8]are for
GPIO; when bit1 is clear, pin 9 and pin 10 can be used for uart2 RTSn
and CTSn, so bit1 should be added to uart2 group and it must be set
for both "gpio" and "uart" functions of uart2 group.

Signed-off-by: Ken Ma <make@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index 5c96f5558310..2fb1c67886fc 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -147,8 +147,9 @@ static struct armada_37xx_pin_group armada_37xx_nb_groups[] = {
 	PIN_GRP_GPIO("onewire", 4, 1, BIT(16), "onewire"),
 	PIN_GRP_GPIO("uart1", 25, 2, BIT(17), "uart"),
 	PIN_GRP_GPIO("spi_quad", 15, 2, BIT(18), "spi"),
-	PIN_GRP_EXTRA("uart2", 9, 2, BIT(13) | BIT(14) | BIT(19),
-		      BIT(13) | BIT(14), BIT(19), 18, 2, "gpio", "uart"),
+	PIN_GRP_EXTRA("uart2", 9, 2, BIT(1) | BIT(13) | BIT(14) | BIT(19),
+		      BIT(1) | BIT(13) | BIT(14), BIT(1) | BIT(19),
+		      18, 2, "gpio", "uart"),
 	PIN_GRP_GPIO("led0_od", 11, 1, BIT(20), "led"),
 	PIN_GRP_GPIO("led1_od", 12, 1, BIT(21), "led"),
 	PIN_GRP_GPIO("led2_od", 13, 1, BIT(22), "led"),
-- 
2.11.0
