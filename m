From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:38:33 +0000
Subject: [PATCH 25/33] MFD: ucb1x00-core: disable mcp clock when bus is not
 required
In-Reply-To: <20120125143000.GF1068@n2100.arm.linux.org.uk>
References: <20120125143000.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rq3zd-0000ZR-Ty@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ucb1x00-core was leaving the mcp clock enabled indefinitely after
probe.  This needlessly wastes power.  Add the necessary disables to
ensure that the clock remains off when we don't need it.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mfd/ucb1x00-core.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/ucb1x00-core.c b/drivers/mfd/ucb1x00-core.c
index 9f8ea52..ed2a4b2 100644
--- a/drivers/mfd/ucb1x00-core.c
+++ b/drivers/mfd/ucb1x00-core.c
@@ -554,16 +554,17 @@ static int ucb1x00_probe(struct mcp *mcp)
 
 	mcp_enable(mcp);
 	id = mcp_reg_read(mcp, UCB_ID);
+	mcp_disable(mcp);
 
 	if (id != UCB_ID_1200 && id != UCB_ID_1300 && id != UCB_ID_TC35143) {
 		printk(KERN_WARNING "UCB1x00 ID not found: %04x\n", id);
-		goto err_disable;
+		goto out;
 	}
 
 	ucb = kzalloc(sizeof(struct ucb1x00), GFP_KERNEL);
 	ret = -ENOMEM;
 	if (!ucb)
-		goto err_disable;
+		goto out;
 
 	device_initialize(&ucb->dev);
 	ucb->dev.class = &ucb1x00_class;
@@ -581,7 +582,9 @@ static int ucb1x00_probe(struct mcp *mcp)
 	if (ret)
 		goto err_dev_add;
 
+	ucb1x00_enable(ucb);
 	ucb->irq = ucb1x00_detect_irq(ucb);
+	ucb1x00_disable(ucb);
 	if (ucb->irq == NO_IRQ) {
 		dev_err(&ucb->dev, "IRQ probe failed\n");
 		ret = -ENODEV;
@@ -633,8 +636,6 @@ static int ucb1x00_probe(struct mcp *mcp)
 	device_del(&ucb->dev);
  err_dev_add:
 	put_device(&ucb->dev);
- err_disable:
-	mcp_disable(mcp);
  out:
 	if (pdata && pdata->reset)
 		pdata->reset(UCB_RST_PROBE_FAIL);
-- 
1.7.4.4
