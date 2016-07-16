From: jm@lentin.co.uk (Jamie Lentin)
Date: Sat, 16 Jul 2016 15:29:07 +0100
Subject: [PATCH v0 09/10] net: phy: Re-attempt custom DT configuration after
 configuration
In-Reply-To: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
Message-ID: <1468679348-10522-10-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

marvell,reg-init is generally used to apply a custom LED configuration
on boot. However this is then blatted in m88e1121_config_aneg when the
interface is brought up. Re-apply any custom configuration afterwards,
to keep custom LED configuration.

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
 drivers/net/phy/marvell.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index c2ca347..b55e4e0 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -424,6 +424,10 @@ static int m88e1121_config_aneg(struct phy_device *phydev)
 	phy_write(phydev, MII_MARVELL_PHY_PAGE, oldpage);
 
 	err = genphy_config_aneg(phydev);
+	if (err < 0)
+		return err;
+
+	err = marvell_of_reg_init(phydev);
 
 	return err;
 }
-- 
2.8.1
