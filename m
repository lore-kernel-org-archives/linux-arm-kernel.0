From: leigh@solinno.co.uk (Leigh Brown)
Date: Sat, 19 Oct 2013 17:23:53 +0100
Subject: [PATCH RFC 3/4] net: mvmdio: slight optimisation of orion_mdio_write
In-Reply-To: <cover.1382199042.git.leigh@solinno.co.uk>
References: <cover.1382199042.git.leigh@solinno.co.uk>
Message-ID: <22cebaeee77c5f2ef66811ca1012d3f0e6c61cbe.1382199042.git.leigh@solinno.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make only a single call to mutex_unlock in orion_mdio_write.

Signed-off-by: Leigh Brown <leigh@solinno.co.uk>
---
 drivers/net/ethernet/marvell/mvmdio.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index 56185fb..3992e2b 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -145,10 +145,8 @@ static int orion_mdio_write(struct mii_bus *bus, int mii_id,
 	mutex_lock(&dev->lock);
 
 	ret = orion_mdio_wait_ready(bus);
-	if (ret < 0) {
-		mutex_unlock(&dev->lock);
-		return ret;
-	}
+	if (ret != 0)
+		goto out;
 
 	writel(((mii_id << MVMDIO_SMI_PHY_ADDR_SHIFT) |
 		(regnum << MVMDIO_SMI_PHY_REG_SHIFT)  |
@@ -156,9 +154,9 @@ static int orion_mdio_write(struct mii_bus *bus, int mii_id,
 		(value << MVMDIO_SMI_DATA_SHIFT)),
 	       dev->regs);
 
+out:
 	mutex_unlock(&dev->lock);
-
-	return 0;
+	return ret;
 }
 
 static int orion_mdio_reset(struct mii_bus *bus)
-- 
1.7.10.4
