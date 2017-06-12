From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 12 Jun 2017 11:57:42 +0200
Subject: [PATCH v3 6/9] net: mvmdio: put the poll intervals in the ops
 structure
In-Reply-To: <20170612095745.11300-1-antoine.tenart@free-electrons.com>
References: <20170612095745.11300-1-antoine.tenart@free-electrons.com>
Message-ID: <20170612095745.11300-7-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Put the two poll intervals (min and max) in the driver's ops
structure. This is needed to add the xmdio support later.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvmdio.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index 7d2f1b2e1fe1..41c75d7b84fb 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -70,6 +70,9 @@ struct orion_mdio_ops {
 	void (*start_read)(struct orion_mdio_dev *, int, int);
 	u16 (*read)(struct orion_mdio_dev *);
 	void (*write)(struct orion_mdio_dev *, int, int, u16);
+
+	unsigned int poll_interval_min;
+	unsigned int poll_interval_max;
 };
 
 static int orion_mdio_smi_is_done(struct orion_mdio_dev *dev)
@@ -112,6 +115,9 @@ static const struct orion_mdio_ops orion_mdio_smi_ops = {
 	.start_read = orion_mdio_smi_start_read_op,
 	.read = orion_mdio_smi_read_op,
 	.write = orion_mdio_smi_write_op,
+
+	.poll_interval_min = MVMDIO_SMI_POLL_INTERVAL_MIN,
+	.poll_interval_max = MVMDIO_SMI_POLL_INTERVAL_MAX,
 };
 
 /* Wait for the SMI unit to be ready for another operation
@@ -131,8 +137,8 @@ static int orion_mdio_wait_ready(const struct orion_mdio_ops *ops,
 			break;
 
 	        if (dev->err_interrupt <= 0) {
-			usleep_range(MVMDIO_SMI_POLL_INTERVAL_MIN,
-				     MVMDIO_SMI_POLL_INTERVAL_MAX);
+			usleep_range(ops->poll_interval_min,
+				     ops->poll_interval_max);
 
 			if (time_is_before_jiffies(end))
 				++timedout;
-- 
2.9.4
