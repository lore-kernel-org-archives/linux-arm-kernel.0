From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 4 Aug 2016 08:21:35 +0800
Subject: [PATCH v1] net: phy: micrel: Add specific suspend
Message-ID: <1470270095-13131-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Disable all interrupts when suspend, they will be enabled
when resume. Otherwise, the suspend/resume process will be
blocked occasionally.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---

 drivers/net/phy/micrel.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 5a8fefc..8cb778a 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -647,6 +647,23 @@ static void kszphy_get_stats(struct phy_device *phydev,
 		data[i] = kszphy_get_stat(phydev, i);
 }
 
+int kszphy_suspend(struct phy_device *phydev)
+{
+	int value;
+
+	mutex_lock(&phydev->lock);
+
+	/* disable interrupts */
+	phy_write(phydev, MII_KSZPHY_INTCS, 0x0);
+
+	value = phy_read(phydev, MII_BMCR);
+	phy_write(phydev, MII_BMCR, value | BMCR_PDOWN);
+
+	mutex_unlock(&phydev->lock);
+
+	return 0;
+}
+
 static int kszphy_resume(struct phy_device *phydev)
 {
 	int value;
@@ -870,7 +887,7 @@ static struct phy_driver ksphy_driver[] = {
 	.get_sset_count = kszphy_get_sset_count,
 	.get_strings	= kszphy_get_strings,
 	.get_stats	= kszphy_get_stats,
-	.suspend	= genphy_suspend,
+	.suspend	= kszphy_suspend,
 	.resume		= kszphy_resume,
 }, {
 	.phy_id		= PHY_ID_KSZ8061,
-- 
2.7.4
