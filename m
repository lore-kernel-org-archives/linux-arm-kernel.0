From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu,  7 Dec 2017 15:27:09 +0100
Subject: [PATCH net-next v2 2/8] net: phy: meson-gxl: define control registers
In-Reply-To: <20171207142715.32578-1-jbrunet@baylibre.com>
References: <20171207142715.32578-1-jbrunet@baylibre.com>
Message-ID: <20171207142715.32578-3-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define registers and bits in meson-gxl PHY driver to make a bit
more human friendly. No functional change.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/net/phy/meson-gxl.c | 64 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 13 deletions(-)

diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
index 7ddb709f69fc..d82aa8cea401 100644
--- a/drivers/net/phy/meson-gxl.c
+++ b/drivers/net/phy/meson-gxl.c
@@ -22,54 +22,92 @@
 #include <linux/ethtool.h>
 #include <linux/phy.h>
 #include <linux/netdevice.h>
+#include <linux/bitfield.h>
+
+#define TSTCNTL		20
+#define  TSTCNTL_READ		BIT(15)
+#define  TSTCNTL_WRITE		BIT(14)
+#define  TSTCNTL_REG_BANK_SEL	GENMASK(12, 11)
+#define  TSTCNTL_TEST_MODE	BIT(10)
+#define  TSTCNTL_READ_ADDRESS	GENMASK(9, 5)
+#define  TSTCNTL_WRITE_ADDRESS	GENMASK(4, 0)
+#define TSTREAD1	21
+#define TSTWRITE	23
+
+#define BANK_ANALOG_DSP		0
+#define BANK_BIST		3
+
+/* Analog/DSP Registers */
+#define A6_CONFIG_REG	0x17
+
+/* BIST Registers */
+#define FR_PLL_CONTROL	0x1b
+#define FR_PLL_DIV0	0x1c
+#define FR_PLL_DIV1	0x1d
 
 static int meson_gxl_config_init(struct phy_device *phydev)
 {
 	int ret;
 
 	/* Enable Analog and DSP register Bank access by */
-	ret = phy_write(phydev, 0x14, 0x0000);
+	ret = phy_write(phydev, TSTCNTL, 0);
 	if (ret)
 		return ret;
-	ret = phy_write(phydev, 0x14, 0x0400);
+	ret = phy_write(phydev, TSTCNTL, TSTCNTL_TEST_MODE);
 	if (ret)
 		return ret;
-	ret = phy_write(phydev, 0x14, 0x0000);
+	ret = phy_write(phydev, TSTCNTL, 0);
 	if (ret)
 		return ret;
-	ret = phy_write(phydev, 0x14, 0x0400);
+	ret = phy_write(phydev, TSTCNTL, TSTCNTL_TEST_MODE);
 	if (ret)
 		return ret;
 
-	/* Write Analog register 23 */
-	ret = phy_write(phydev, 0x17, 0x8E0D);
+	/* Write CONFIG_A6*/
+	ret = phy_write(phydev, TSTWRITE, 0x8e0d)
 	if (ret)
 		return ret;
-	ret = phy_write(phydev, 0x14, 0x4417);
+	ret = phy_write(phydev, TSTCNTL,
+			TSTCNTL_WRITE
+			| FIELD_PREP(TSTCNTL_REG_BANK_SEL, BANK_ANALOG_DSP)
+			| TSTCNTL_TEST_MODE
+			| FIELD_PREP(TSTCNTL_WRITE_ADDRESS, A6_CONFIG_REG));
 	if (ret)
 		return ret;
 
 	/* Enable fractional PLL */
-	ret = phy_write(phydev, 0x17, 0x0005);
+	ret = phy_write(phydev, TSTWRITE, 0x0005);
 	if (ret)
 		return ret;
-	ret = phy_write(phydev, 0x14, 0x5C1B);
+	ret = phy_write(phydev, TSTCNTL,
+			TSTCNTL_WRITE
+			| FIELD_PREP(TSTCNTL_REG_BANK_SEL, BANK_BIST)
+			| TSTCNTL_TEST_MODE
+			| FIELD_PREP(TSTCNTL_WRITE_ADDRESS, FR_PLL_CONTROL));
 	if (ret)
 		return ret;
 
 	/* Program fraction FR_PLL_DIV1 */
-	ret = phy_write(phydev, 0x17, 0x029A);
+	ret = phy_write(phydev, TSTWRITE, 0x029a);
 	if (ret)
 		return ret;
-	ret = phy_write(phydev, 0x14, 0x5C1D);
+	ret = phy_write(phydev, TSTCNTL,
+			TSTCNTL_WRITE
+			| FIELD_PREP(TSTCNTL_REG_BANK_SEL, BANK_BIST)
+			| TSTCNTL_TEST_MODE
+			| FIELD_PREP(TSTCNTL_WRITE_ADDRESS, FR_PLL_DIV1));
 	if (ret)
 		return ret;
 
 	/* Program fraction FR_PLL_DIV1 */
-	ret = phy_write(phydev, 0x17, 0xAAAA);
+	ret = phy_write(phydev, TSTWRITE, 0xaaaa);
 	if (ret)
 		return ret;
-	ret = phy_write(phydev, 0x14, 0x5C1C);
+	ret = phy_write(phydev, TSTCNTL,
+			TSTCNTL_WRITE
+			| FIELD_PREP(TSTCNTL_REG_BANK_SEL, BANK_BIST)
+			| TSTCNTL_TEST_MODE
+			| FIELD_PREP(TSTCNTL_WRITE_ADDRESS, FR_PLL_DIV0));
 	if (ret)
 		return ret;
 
-- 
2.14.3
