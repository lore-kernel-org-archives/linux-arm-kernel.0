From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:36:11 +0000
Subject: [PATCH 18/33] MFD: ucb1x00-core: add handling for ucb1x00 reset
In-Reply-To: <20120125143000.GF1068@n2100.arm.linux.org.uk>
References: <20120125143000.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rq3xL-0000Yx-Ir@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide a way to handle the software controlled ucb1x00 reset signal
from the ucb1x00-core driver without having to code platform specifics
into these drivers.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mfd/ucb1x00-core.c  |   17 +++++++++++++----
 include/linux/mfd/ucb1x00.h |    7 +++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/ucb1x00-core.c b/drivers/mfd/ucb1x00-core.c
index cc1c0dc..42eee63 100644
--- a/drivers/mfd/ucb1x00-core.c
+++ b/drivers/mfd/ucb1x00-core.c
@@ -530,13 +530,17 @@ static struct class ucb1x00_class = {
 
 static int ucb1x00_probe(struct mcp *mcp)
 {
-	struct ucb1x00 *ucb;
+	struct ucb1x00_plat_data *pdata = mcp->attached_device.platform_data;
 	struct ucb1x00_driver *drv;
-	struct ucb1x00_plat_data *pdata;
+	struct ucb1x00 *ucb;
 	unsigned int id;
 	int ret = -ENODEV;
 	int temp;
 
+	/* Tell the platform to deassert the UCB1x00 reset */
+	if (pdata && pdata->reset)
+		pdata->reset(UCB_RST_PROBE);
+
 	mcp_enable(mcp);
 	id = mcp_reg_read(mcp, UCB_ID);
 
@@ -550,7 +554,6 @@ static int ucb1x00_probe(struct mcp *mcp)
 	if (!ucb)
 		goto err_disable;
 
-	pdata = mcp->attached_device.platform_data;
 	ucb->dev.class = &ucb1x00_class;
 	ucb->dev.parent = &mcp->attached_device;
 	dev_set_name(&ucb->dev, "ucb1x00");
@@ -606,7 +609,7 @@ static int ucb1x00_probe(struct mcp *mcp)
 	}
 	mutex_unlock(&ucb1x00_mutex);
 
-	goto out;
+	return ret;
 
  err_irq:
 	free_irq(ucb->irq, ucb);
@@ -618,11 +621,14 @@ static int ucb1x00_probe(struct mcp *mcp)
  err_disable:
 	mcp_disable(mcp);
  out:
+	if (pdata && pdata->reset)
+		pdata->reset(UCB_RST_PROBE_FAIL);
 	return ret;
 }
 
 static void ucb1x00_remove(struct mcp *mcp)
 {
+	struct ucb1x00_plat_data *pdata = mcp->attached_device.platform_data;
 	struct ucb1x00 *ucb = mcp_get_drvdata(mcp);
 	struct list_head *l, *n;
 	int ret;
@@ -643,6 +649,9 @@ static void ucb1x00_remove(struct mcp *mcp)
 
 	free_irq(ucb->irq, ucb);
 	device_unregister(&ucb->dev);
+
+	if (pdata && pdata->reset)
+		pdata->reset(UCB_RST_REMOVE);
 }
 
 int ucb1x00_register_driver(struct ucb1x00_driver *drv)
diff --git a/include/linux/mfd/ucb1x00.h b/include/linux/mfd/ucb1x00.h
index 731b23a..fd088cc 100644
--- a/include/linux/mfd/ucb1x00.h
+++ b/include/linux/mfd/ucb1x00.h
@@ -104,7 +104,14 @@
 #define UCB_MODE_DYN_VFLAG_ENA	(1 << 12)
 #define UCB_MODE_AUD_OFF_CAN	(1 << 13)
 
+enum ucb1x00_reset {
+	UCB_RST_PROBE,
+	UCB_RST_REMOVE,
+	UCB_RST_PROBE_FAIL,
+};
+
 struct ucb1x00_plat_data {
+	void			(*reset)(enum ucb1x00_reset);
 	int			gpio_base;
 };
 
-- 
1.7.4.4
