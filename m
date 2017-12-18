From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 18 Dec 2017 10:44:44 +0100
Subject: [PATCH net-next v3 5/7] net: phy: meson-gxl: leave CONFIG_A6 untouched
In-Reply-To: <20171218094446.31912-1-jbrunet@baylibre.com>
References: <20171218094446.31912-1-jbrunet@baylibre.com>
Message-ID: <20171218094446.31912-6-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PHY performs just as well when left in its default configuration and
it makes senses because this poke gets reset just after init.

According to the documentation, all registers in the Analog/DSP bank are
reset when there is a mode switch from 10BT to 100BT. The bank is also
reset on power down and soft reset, so we will never see the value which
may have been set by the bootloader.

In the end, we have used the default configuration so far and there is no
reason to change now. Remove CONFIG_A6 poke to make this clear.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/net/phy/meson-gxl.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
index 0a34656a2086..ddc92424e8de 100644
--- a/drivers/net/phy/meson-gxl.c
+++ b/drivers/net/phy/meson-gxl.c
@@ -38,9 +38,6 @@
 #define BANK_WOL		1
 #define BANK_BIST		3
 
-/* Analog/DSP Registers */
-#define A6_CONFIG_REG	0x17
-
 /* WOL Registers */
 #define LPI_STATUS	0xc
 #define  LPI_STATUS_RSV12	BIT(12)
@@ -126,12 +123,6 @@ static int meson_gxl_config_init(struct phy_device *phydev)
 {
 	int ret;
 
-	/* Write CONFIG_A6*/
-	ret = meson_gxl_write_reg(phydev, BANK_ANALOG_DSP, A6_CONFIG_REG,
-				  0x8e0d);
-	if (ret)
-		return ret;
-
 	/* Enable fractional PLL */
 	ret = meson_gxl_write_reg(phydev, BANK_BIST, FR_PLL_CONTROL, 0x5);
 	if (ret)
-- 
2.14.3
