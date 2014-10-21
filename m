From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 21 Oct 2014 10:53:39 +0200
Subject: [PATCH 1/9] phy: marvell: Add support for 88E3016 FastEthernet PHY
In-Reply-To: <1413881627-21639-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1413881627-21639-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1413881627-21639-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marvell 88E3016 is a FastEthernet PHY that also can be found in Marvell
Berlin SoCs as integrated PHY.

Tested-by: Antoine T?nart <antoine.tenart@free-electrons.com>
Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: "Antoine T?nart" <antoine.tenart@free-electrons.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: netdev at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/net/phy/marvell.c   | 46 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/marvell_phy.h |  1 +
 2 files changed, 47 insertions(+)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index bd37e45c89c0..d2b2f2f795d5 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -118,6 +118,9 @@
 
 #define MII_M1116R_CONTROL_REG_MAC	21
 
+#define MII_88E3016_PHY_SPEC_CTRL	0x10
+#define MII_88E3016_DISABLE_SCRAMBLER	0x0200
+#define MII_88E3016_AUTO_MDIX_CROSSOVER	0x0030
 
 MODULE_DESCRIPTION("Marvell PHY driver");
 MODULE_AUTHOR("Andy Fleming");
@@ -434,6 +437,25 @@ static int m88e1116r_config_init(struct phy_device *phydev)
 	return 0;
 }
 
+static int m88e3016_config_init(struct phy_device *phydev)
+{
+	int reg;
+
+	/* Enable Scrambler and Auto-Crossover */
+	reg = phy_read(phydev, MII_88E3016_PHY_SPEC_CTRL);
+	if (reg < 0)
+		return reg;
+
+	reg &= ~MII_88E3016_DISABLE_SCRAMBLER;
+	reg |= MII_88E3016_AUTO_MDIX_CROSSOVER;
+
+	reg = phy_write(phydev, MII_88E3016_PHY_SPEC_CTRL, reg);
+	if (reg < 0)
+		return reg;
+
+	return 0;
+}
+
 static int m88e1111_config_init(struct phy_device *phydev)
 {
 	int err;
@@ -770,6 +792,12 @@ static int marvell_read_status(struct phy_device *phydev)
 	return 0;
 }
 
+static int marvell_aneg_done(struct phy_device *phydev)
+{
+	int retval = phy_read(phydev, MII_M1011_PHY_STATUS);
+	return (retval < 0) ? retval : (retval & MII_M1011_PHY_STATUS_RESOLVED);
+}
+
 static int m88e1121_did_interrupt(struct phy_device *phydev)
 {
 	int imask;
@@ -1050,6 +1078,23 @@ static struct phy_driver marvell_drivers[] = {
 		.suspend = &genphy_suspend,
 		.driver = { .owner = THIS_MODULE },
 	},
+	{
+		.phy_id = MARVELL_PHY_ID_88E3016,
+		.phy_id_mask = MARVELL_PHY_ID_MASK,
+		.name = "Marvell 88E3016",
+		.features = PHY_BASIC_FEATURES,
+		.flags = PHY_HAS_INTERRUPT,
+		.config_aneg = &genphy_config_aneg,
+		.config_init = &m88e3016_config_init,
+		.aneg_done = &marvell_aneg_done,
+		.read_status = &marvell_read_status,
+		.ack_interrupt = &marvell_ack_interrupt,
+		.config_intr = &marvell_config_intr,
+		.did_interrupt = &m88e1121_did_interrupt,
+		.resume = &genphy_resume,
+		.suspend = &genphy_suspend,
+		.driver = { .owner = THIS_MODULE },
+	},
 };
 
 static int __init marvell_init(void)
@@ -1079,6 +1124,7 @@ static struct mdio_device_id __maybe_unused marvell_tbl[] = {
 	{ MARVELL_PHY_ID_88E1318S, MARVELL_PHY_ID_MASK },
 	{ MARVELL_PHY_ID_88E1116R, MARVELL_PHY_ID_MASK },
 	{ MARVELL_PHY_ID_88E1510, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88E3016, MARVELL_PHY_ID_MASK },
 	{ }
 };
 
diff --git a/include/linux/marvell_phy.h b/include/linux/marvell_phy.h
index 8e9a029e093d..e6982ac3200d 100644
--- a/include/linux/marvell_phy.h
+++ b/include/linux/marvell_phy.h
@@ -16,6 +16,7 @@
 #define MARVELL_PHY_ID_88E1318S		0x01410e90
 #define MARVELL_PHY_ID_88E1116R		0x01410e40
 #define MARVELL_PHY_ID_88E1510		0x01410dd0
+#define MARVELL_PHY_ID_88E3016		0x01410e60
 
 /* struct phy_device dev_flags definitions */
 #define MARVELL_PHY_M1145_FLAGS_RESISTANCE	0x00000001
-- 
2.1.1
