From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 14 Jun 2017 17:49:06 +0200
Subject: [PATCH v4 06/11] net: mvmdio: put the poll intervals in the ops
 structure
In-Reply-To: <20170614154911.14510-1-antoine.tenart@free-electrons.com>
References: <20170614154911.14510-1-antoine.tenart@free-electrons.com>
Message-ID: <20170614154911.14510-7-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Put the two poll intervals (min and max) in the driver's ops
structure. This is needed to add the xmdio support later.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvmdio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index 2a8efc77f5fe..e4aa8e2d2e8a 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -64,6 +64,8 @@ struct orion_mdio_dev {
 
 struct orion_mdio_ops {
 	int (*is_done)(struct orion_mdio_dev *);
+	unsigned int poll_interval_min;
+	unsigned int poll_interval_max;
 };
 
 /* Wait for the SMI unit to be ready for another operation
@@ -83,8 +85,8 @@ static int orion_mdio_wait_ready(const struct orion_mdio_ops *ops,
 			break;
 
 	        if (dev->err_interrupt <= 0) {
-			usleep_range(MVMDIO_SMI_POLL_INTERVAL_MIN,
-				     MVMDIO_SMI_POLL_INTERVAL_MAX);
+			usleep_range(ops->poll_interval_min,
+				     ops->poll_interval_max);
 
 			if (time_is_before_jiffies(end))
 				++timedout;
@@ -113,6 +115,8 @@ static int orion_mdio_smi_is_done(struct orion_mdio_dev *dev)
 
 static const struct orion_mdio_ops orion_mdio_smi_ops = {
 	.is_done = orion_mdio_smi_is_done,
+	.poll_interval_min = MVMDIO_SMI_POLL_INTERVAL_MIN,
+	.poll_interval_max = MVMDIO_SMI_POLL_INTERVAL_MAX,
 };
 
 static int orion_mdio_read(struct mii_bus *bus, int mii_id,
-- 
2.9.4
