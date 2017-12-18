From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 18 Dec 2017 10:44:40 +0100
Subject: [PATCH net-next v3 1/7] net: phy: meson-gxl: check phy_write return
 value
In-Reply-To: <20171218094446.31912-1-jbrunet@baylibre.com>
References: <20171218094446.31912-1-jbrunet@baylibre.com>
Message-ID: <20171218094446.31912-2-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Always check phy_write return values. Better to be safe than sorry

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/net/phy/meson-gxl.c | 50 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
index 4ee630afe43a..900606204c0a 100644
--- a/drivers/net/phy/meson-gxl.c
+++ b/drivers/net/phy/meson-gxl.c
@@ -26,27 +26,53 @@
 
 static int meson_gxl_config_init(struct phy_device *phydev)
 {
+	int ret;
+
 	/* Enable Analog and DSP register Bank access by */
-	phy_write(phydev, 0x14, 0x0000);
-	phy_write(phydev, 0x14, 0x0400);
-	phy_write(phydev, 0x14, 0x0000);
-	phy_write(phydev, 0x14, 0x0400);
+	ret = phy_write(phydev, 0x14, 0x0000);
+	if (ret)
+		return ret;
+	ret = phy_write(phydev, 0x14, 0x0400);
+	if (ret)
+		return ret;
+	ret = phy_write(phydev, 0x14, 0x0000);
+	if (ret)
+		return ret;
+	ret = phy_write(phydev, 0x14, 0x0400);
+	if (ret)
+		return ret;
 
 	/* Write Analog register 23 */
-	phy_write(phydev, 0x17, 0x8E0D);
-	phy_write(phydev, 0x14, 0x4417);
+	ret = phy_write(phydev, 0x17, 0x8E0D);
+	if (ret)
+		return ret;
+	ret = phy_write(phydev, 0x14, 0x4417);
+	if (ret)
+		return ret;
 
 	/* Enable fractional PLL */
-	phy_write(phydev, 0x17, 0x0005);
-	phy_write(phydev, 0x14, 0x5C1B);
+	ret = phy_write(phydev, 0x17, 0x0005);
+	if (ret)
+		return ret;
+	ret = phy_write(phydev, 0x14, 0x5C1B);
+	if (ret)
+		return ret;
 
 	/* Program fraction FR_PLL_DIV1 */
-	phy_write(phydev, 0x17, 0x029A);
-	phy_write(phydev, 0x14, 0x5C1D);
+	ret = phy_write(phydev, 0x17, 0x029A);
+	if (ret)
+		return ret;
+	ret = phy_write(phydev, 0x14, 0x5C1D);
+	if (ret)
+		return ret;
 
 	/* Program fraction FR_PLL_DIV1 */
-	phy_write(phydev, 0x17, 0xAAAA);
-	phy_write(phydev, 0x14, 0x5C1C);
+	ret = phy_write(phydev, 0x17, 0xAAAA);
+	if (ret)
+		return ret;
+	ret = phy_write(phydev, 0x14, 0x5C1C);
+	if (ret)
+		return ret;
 
 	return 0;
 }
-- 
2.14.3
