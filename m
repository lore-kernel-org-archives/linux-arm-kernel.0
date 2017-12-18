From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 18 Dec 2017 10:44:45 +0100
Subject: [PATCH net-next v3 6/7] net: phy: meson-gxl: add interrupt support
In-Reply-To: <20171218094446.31912-1-jbrunet@baylibre.com>
References: <20171218094446.31912-1-jbrunet@baylibre.com>
Message-ID: <20171218094446.31912-7-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable interrupt support in meson-gxl PHY driver

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/net/phy/meson-gxl.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
index ddc92424e8de..ee0aa18af631 100644
--- a/drivers/net/phy/meson-gxl.c
+++ b/drivers/net/phy/meson-gxl.c
@@ -33,6 +33,14 @@
 #define  TSTCNTL_WRITE_ADDRESS	GENMASK(4, 0)
 #define TSTREAD1	21
 #define TSTWRITE	23
+#define INTSRC_FLAG	29
+#define  INTSRC_ANEG_PR		BIT(1)
+#define  INTSRC_PARALLEL_FAULT	BIT(2)
+#define  INTSRC_ANEG_LP_ACK	BIT(3)
+#define  INTSRC_LINK_DOWN	BIT(4)
+#define  INTSRC_REMOTE_FAULT	BIT(5)
+#define  INTSRC_ANEG_COMPLETE	BIT(6)
+#define INTSRC_MASK	30
 
 #define BANK_ANALOG_DSP		0
 #define BANK_WOL		1
@@ -193,16 +201,43 @@ static int meson_gxl_read_status(struct phy_device *phydev)
 	return genphy_read_status(phydev);
 }
 
+static int meson_gxl_ack_interrupt(struct phy_device *phydev)
+{
+	int ret = phy_read(phydev, INTSRC_FLAG);
+
+	return ret < 0 ? ret : 0;
+}
+
+static int meson_gxl_config_intr(struct phy_device *phydev)
+{
+	u16 val;
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
+		val = INTSRC_ANEG_PR
+			| INTSRC_PARALLEL_FAULT
+			| INTSRC_ANEG_LP_ACK
+			| INTSRC_LINK_DOWN
+			| INTSRC_REMOTE_FAULT
+			| INTSRC_ANEG_COMPLETE;
+	} else {
+		val = 0;
+	}
+
+	return phy_write(phydev, INTSRC_MASK, val);
+}
+
 static struct phy_driver meson_gxl_phy[] = {
 	{
 		.phy_id		= 0x01814400,
 		.phy_id_mask	= 0xfffffff0,
 		.name		= "Meson GXL Internal PHY",
 		.features	= PHY_BASIC_FEATURES,
-		.flags		= PHY_IS_INTERNAL,
+		.flags		= PHY_IS_INTERNAL | PHY_HAS_INTERRUPT,
 		.config_init	= meson_gxl_config_init,
 		.aneg_done      = genphy_aneg_done,
 		.read_status	= meson_gxl_read_status,
+		.ack_interrupt	= meson_gxl_ack_interrupt,
+		.config_intr	= meson_gxl_config_intr,
 		.suspend        = genphy_suspend,
 		.resume         = genphy_resume,
 	},
-- 
2.14.3
