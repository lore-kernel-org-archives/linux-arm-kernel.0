From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 19 Dec 2016 16:05:36 +0100
Subject: [PATCH net 1/3] net: phy: fix sign type error in
 genphy_config_eee_advert
In-Reply-To: <1482159938-13239-1-git-send-email-jbrunet@baylibre.com>
References: <1482159938-13239-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <1482159938-13239-2-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In genphy_config_eee_advert, the return value of phy_read_mmd_indirect is
checked to know if the register could be accessed but the result is
assigned to a 'u32'.
Changing to 'int' to correctly get errors from phy_read_mmd_indirect.

Fixes: d853d145ea3e ("net: phy: add an option to disable EEE advertisement")
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/net/phy/phy_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 9c06f8028f0c..ee5ebadb1463 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1187,8 +1187,8 @@ static int genphy_config_advert(struct phy_device *phydev)
  */
 static int genphy_config_eee_advert(struct phy_device *phydev)
 {
-	u32 broken = phydev->eee_broken_modes;
-	u32 old_adv, adv;
+	int broken = phydev->eee_broken_modes;
+	int old_adv, adv;
 
 	/* Nothing to disable */
 	if (!broken)
-- 
2.7.4
