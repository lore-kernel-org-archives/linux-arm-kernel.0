From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 30 Oct 2014 11:21:25 +0100
Subject: [PATCH v3 2/5] phy: berlin-sata: Add support for BG2 SATA PHY
In-Reply-To: <1414664488-5911-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1413882477-27922-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1414664488-5911-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1414664488-5911-3-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Berlin BG2 also has a SATA PHY compatible with the current driver
except different PHY_BASE. Add a new compatible to the driver
reflecting the different PHY_BASE.

Acked-by: Antoine T?nart <antoine.tenart@free-electrons.com>
Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Changelog:
v1->v2:
- none
v2->v3:
- Use of_device_is_compatible for different PHY_BASE (Suggested by
  Felipe Balbi)

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: "Antoine T?nart" <antoine.tenart@free-electrons.com>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/phy/phy-berlin-sata.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/phy-berlin-sata.c b/drivers/phy/phy-berlin-sata.c
index cdb46d1203a4..873e7a890fee 100644
--- a/drivers/phy/phy-berlin-sata.c
+++ b/drivers/phy/phy-berlin-sata.c
@@ -30,6 +30,7 @@
 #define MBUS_WRITE_REQUEST_SIZE_128	(BIT(2) << 16)
 #define MBUS_READ_REQUEST_SIZE_128	(BIT(2) << 19)
 
+#define BG2_PHY_BASE		0x080
 #define BG2Q_PHY_BASE		0x200
 
 /* register 0x01 */
@@ -222,7 +223,10 @@ static int phy_berlin_sata_probe(struct platform_device *pdev)
 	if (!priv->phys)
 		return -ENOMEM;
 
-	priv->phy_base = BG2Q_PHY_BASE;
+	if (of_device_is_compatible(dev->of_node, "marvell,berlin2-sata-phy"))
+		priv->phy_base = BG2_PHY_BASE;
+	else
+		priv->phy_base = BG2Q_PHY_BASE;
 
 	dev_set_drvdata(dev, priv);
 	spin_lock_init(&priv->lock);
@@ -271,6 +275,7 @@ static int phy_berlin_sata_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id phy_berlin_sata_of_match[] = {
+	{ .compatible = "marvell,berlin2-sata-phy" },
 	{ .compatible = "marvell,berlin2q-sata-phy" },
 	{ },
 };
-- 
2.1.1
