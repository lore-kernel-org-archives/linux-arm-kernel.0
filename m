From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 19 Nov 2018 19:24:22 -0600
Subject: [PATCH v3 3/5] phy: ocelot-serdes: convert to use eth phy mode and
 submode
In-Reply-To: <20181120012424.11802-1-grygorii.strashko@ti.com>
References: <20181120012424.11802-1-grygorii.strashko@ti.com>
Message-ID: <20181120012424.11802-4-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert ocelot-serdes PHY driver to use recently introduced
PHY_MODE_ETHERNET and phy_set_mode_ext().

Cc: Quentin Schulz <quentin.schulz@bootlin.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/mscc/ocelot.c   |  9 ++-------
 drivers/phy/mscc/phy-ocelot-serdes.c | 22 ++++++++++++++++------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 3238b9e..3edb608 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -472,7 +472,6 @@ static int ocelot_port_open(struct net_device *dev)
 {
 	struct ocelot_port *port = netdev_priv(dev);
 	struct ocelot *ocelot = port->ocelot;
-	enum phy_mode phy_mode;
 	int err;
 
 	/* Enable receiving frames on the port, and activate auto-learning of
@@ -484,12 +483,8 @@ static int ocelot_port_open(struct net_device *dev)
 			 ANA_PORT_PORT_CFG, port->chip_port);
 
 	if (port->serdes) {
-		if (port->phy_mode == PHY_INTERFACE_MODE_SGMII)
-			phy_mode = PHY_MODE_SGMII;
-		else
-			phy_mode = PHY_MODE_QSGMII;
-
-		err = phy_set_mode(port->serdes, phy_mode);
+		err = phy_set_mode_ext(port->serdes, PHY_MODE_ETHERNET,
+				       port->phy_mode);
 		if (err) {
 			netdev_err(dev, "Could not set mode of SerDes\n");
 			return err;
diff --git a/drivers/phy/mscc/phy-ocelot-serdes.c b/drivers/phy/mscc/phy-ocelot-serdes.c
index c61a9890..77c46f6 100644
--- a/drivers/phy/mscc/phy-ocelot-serdes.c
+++ b/drivers/phy/mscc/phy-ocelot-serdes.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/phy.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -104,20 +105,24 @@ struct serdes_mux {
 	u8			idx;
 	u8			port;
 	enum phy_mode		mode;
+	int			submode;
 	u32			mask;
 	u32			mux;
 };
 
-#define SERDES_MUX(_idx, _port, _mode, _mask, _mux) {		\
+#define SERDES_MUX(_idx, _port, _mode, _submode, _mask, _mux) {		\
 	.idx = _idx,						\
 	.port = _port,						\
 	.mode = _mode,						\
+	.submode = _submode,					\
 	.mask = _mask,						\
 	.mux = _mux,						\
 }
 
-#define SERDES_MUX_SGMII(i, p, m, c) SERDES_MUX(i, p, PHY_MODE_SGMII, m, c)
-#define SERDES_MUX_QSGMII(i, p, m, c) SERDES_MUX(i, p, PHY_MODE_QSGMII, m, c)
+#define SERDES_MUX_SGMII(i, p, m, c) \
+	SERDES_MUX(i, p, PHY_MODE_ETHERNET, PHY_INTERFACE_MODE_SGMII, m, c)
+#define SERDES_MUX_QSGMII(i, p, m, c) \
+	SERDES_MUX(i, p, PHY_MODE_ETHERNET, PHY_INTERFACE_MODE_QSGMII, m, c)
 
 static const struct serdes_mux ocelot_serdes_muxes[] = {
 	SERDES_MUX_SGMII(SERDES1G(0), 0, 0, 0),
@@ -154,7 +159,7 @@ static const struct serdes_mux ocelot_serdes_muxes[] = {
 	SERDES_MUX_SGMII(SERDES6G(1), 8, 0, 0),
 	SERDES_MUX_SGMII(SERDES6G(2), 10, HSIO_HW_CFG_PCIE_ENA |
 			 HSIO_HW_CFG_DEV2G5_10_MODE, 0),
-	SERDES_MUX(SERDES6G(2), 10, PHY_MODE_PCIE, HSIO_HW_CFG_PCIE_ENA,
+	SERDES_MUX(SERDES6G(2), 10, PHY_MODE_PCIE, 0, HSIO_HW_CFG_PCIE_ENA,
 		   HSIO_HW_CFG_PCIE_ENA),
 };
 
@@ -164,12 +169,17 @@ static int serdes_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	unsigned int i;
 	int ret;
 
+	/* As of now only PHY_MODE_ETHERNET is supported */
+	if (mode != PHY_MODE_ETHERNET)
+		return -EOPNOTSUPP;
+
 	for (i = 0; i < ARRAY_SIZE(ocelot_serdes_muxes); i++) {
 		if (macro->idx != ocelot_serdes_muxes[i].idx ||
-		    mode != ocelot_serdes_muxes[i].mode)
+		    mode != ocelot_serdes_muxes[i].mode ||
+		    submode != ocelot_serdes_muxes[i].submode)
 			continue;
 
-		if (mode != PHY_MODE_QSGMII &&
+		if (submode != PHY_INTERFACE_MODE_QSGMII &&
 		    macro->port != ocelot_serdes_muxes[i].port)
 			continue;
 
-- 
2.10.5
