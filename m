From: leigh@solinno.co.uk (Leigh Brown)
Date: Thu, 24 Oct 2013 19:09:32 +0100
Subject: [PATCH RFC v2 2/4] net: mvmdio: orion_mdio_ready: remove manual poll
In-Reply-To: <cover.1382637156.git.leigh@solinno.co.uk>
References: <cover.1382637156.git.leigh@solinno.co.uk>
Message-ID: <7d1ca351f04d7e51f72bdce00a86a27bf1db4350.1382637156.git.leigh@solinno.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace manual poll of MVMDIO_SMI_READ_VALID with a call to
orion_mdio_wait_ready.  This ensures a consistent timeout,
eliminates a busy loop, and allows for use of interrupts on
systems that support them.

Signed-off-by: Leigh Brown <leigh@solinno.co.uk>
---
 drivers/net/ethernet/marvell/mvmdio.c |   36 +++++++++++++--------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index 6ed6f00..f053475 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -111,43 +111,35 @@ static int orion_mdio_read(struct mii_bus *bus, int mii_id,
 			   int regnum)
 {
 	struct orion_mdio_dev *dev = bus->priv;
-	int count;
 	u32 val;
 	int ret;
 
 	mutex_lock(&dev->lock);
 
 	ret = orion_mdio_wait_ready(bus);
-	if (ret < 0) {
-		mutex_unlock(&dev->lock);
-		return ret;
-	}
+	if (ret < 0)
+		goto out;
 
 	writel(((mii_id << MVMDIO_SMI_PHY_ADDR_SHIFT) |
 		(regnum << MVMDIO_SMI_PHY_REG_SHIFT)  |
 		MVMDIO_SMI_READ_OPERATION),
 	       dev->regs);
 
-	/* Wait for the value to become available */
-	count = 0;
-	while (1) {
-		val = readl(dev->regs);
-		if (val & MVMDIO_SMI_READ_VALID)
-			break;
-
-		if (count > 100) {
-			dev_err(bus->parent, "Timeout when reading PHY\n");
-			mutex_unlock(&dev->lock);
-			return -ETIMEDOUT;
-		}
-
-		udelay(10);
-		count++;
+	ret = orion_mdio_wait_ready(bus);
+	if (ret < 0)
+		goto out;
+
+	val = readl(dev->regs);
+	if (!(val & MVMDIO_SMI_READ_VALID)) {
+		dev_err(bus->parent, "SMI bus read not valid\n");
+		ret = -ENODEV;
+		goto out;
 	}
 
+	ret = val & 0xFFFF;
+out:
 	mutex_unlock(&dev->lock);
-
-	return val & 0xFFFF;
+	return ret;
 }
 
 static int orion_mdio_write(struct mii_bus *bus, int mii_id,
-- 
1.7.10.4
