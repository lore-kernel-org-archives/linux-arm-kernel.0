From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu,  7 Dec 2017 15:27:13 +0100
Subject: [PATCH net-next v2 6/8] net: phy: meson-gxl: leave CONFIG_A6 untouched
In-Reply-To: <20171207142715.32578-1-jbrunet@baylibre.com>
References: <20171207142715.32578-1-jbrunet@baylibre.com>
Message-ID: <20171207142715.32578-7-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PHY performs just as well when left in its default configuration and
it makes senses because this poke gets reset just after init.

According to the documentation, all registers in the Analog/DSP bank are
reset when there is a mode switch from 10BT to 100BT.

In the end, we have used the default configuration so far and there is no
reason to change now. Remove CONFIG_A6 poke to make this clear.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

Out of curiosity, I tried to re-apply the ANALOG/DSP settings on speed
changes (patch available here [0] if someone wants to try) but I did
not notice any change as a result. In the end, I thought it was safer
to keep on using the ANALOG settings we have been actually using so far,
everybody seems to be happy with them

[0]: https://github.com/jeromebrunet/linux/commit/b594288e629a61574e76112497474fd3cf46c781

 drivers/net/phy/meson-gxl.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
index 726e0eeed475..5325940fe899 100644
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
