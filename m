From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 15 Jun 2017 16:43:22 +0200
Subject: [PATCH net-next v5 07/11] net: mvmdio: check the MII_ADDR_C45 bit is
 not set for smi operations
In-Reply-To: <20170615144326.24463-1-antoine.tenart@free-electrons.com>
References: <20170615144326.24463-1-antoine.tenart@free-electrons.com>
Message-ID: <20170615144326.24463-8-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a check for the read and write smi operations, to ensure the
MII_ADDR_C45 bit isn't set. This will be needed as soon as the xSMI
support is added to the mvmdio driver.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/marvell/mvmdio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index e4aa8e2d2e8a..fe6072aae0a6 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -126,6 +126,9 @@ static int orion_mdio_read(struct mii_bus *bus, int mii_id,
 	u32 val;
 	int ret;
 
+	if (regnum & MII_ADDR_C45)
+		return -EOPNOTSUPP;
+
 	ret = orion_mdio_wait_ready(&orion_mdio_smi_ops, bus);
 	if (ret < 0)
 		goto out;
@@ -157,6 +160,9 @@ static int orion_mdio_write(struct mii_bus *bus, int mii_id,
 	struct orion_mdio_dev *dev = bus->priv;
 	int ret;
 
+	if (regnum & MII_ADDR_C45)
+		return -EOPNOTSUPP;
+
 	ret = orion_mdio_wait_ready(&orion_mdio_smi_ops, bus);
 	if (ret < 0)
 		goto out;
-- 
2.9.4
