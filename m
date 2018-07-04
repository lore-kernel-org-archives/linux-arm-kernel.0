From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  4 Jul 2018 20:33:23 +0200
Subject: [PATCH net-next 4/5 v2] net: gemini: Move main init to port
In-Reply-To: <20180704183324.10605-1-linus.walleij@linaro.org>
References: <20180704183324.10605-1-linus.walleij@linaro.org>
Message-ID: <20180704183324.10605-4-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The initialization sequence for the ethernet, setting up
interrupt routing and such things, need to be done after
both the ports are clocked and reset. Before this the
config will not "take". Move the initialization to the
port probe function and keep track of init status in
the state.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- No changes, just resending with the rest.
---
 drivers/net/ethernet/cortina/gemini.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 6b5aa5704c4f..4e341570047f 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -151,6 +151,7 @@ struct gemini_ethernet {
 	void __iomem *base;
 	struct gemini_ethernet_port *port0;
 	struct gemini_ethernet_port *port1;
+	bool initialized;
 
 	spinlock_t	irq_lock; /* Locks IRQ-related registers */
 	unsigned int	freeq_order;
@@ -2303,6 +2304,14 @@ static void gemini_port_remove(struct gemini_ethernet_port *port)
 
 static void gemini_ethernet_init(struct gemini_ethernet *geth)
 {
+	/* Only do this once both ports are online */
+	if (geth->initialized)
+		return;
+	if (geth->port0 && geth->port1)
+		geth->initialized = true;
+	else
+		return;
+
 	writel(0, geth->base + GLOBAL_INTERRUPT_ENABLE_0_REG);
 	writel(0, geth->base + GLOBAL_INTERRUPT_ENABLE_1_REG);
 	writel(0, geth->base + GLOBAL_INTERRUPT_ENABLE_2_REG);
@@ -2450,6 +2459,10 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 		geth->port0 = port;
 	else
 		geth->port1 = port;
+
+	/* This will just be done once both ports are up and reset */
+	gemini_ethernet_init(geth);
+
 	platform_set_drvdata(pdev, port);
 
 	/* Set up and register the netdev */
@@ -2567,7 +2580,6 @@ static int gemini_ethernet_probe(struct platform_device *pdev)
 
 	spin_lock_init(&geth->irq_lock);
 	spin_lock_init(&geth->freeq_lock);
-	gemini_ethernet_init(geth);
 
 	/* The children will use this */
 	platform_set_drvdata(pdev, geth);
@@ -2580,8 +2592,8 @@ static int gemini_ethernet_remove(struct platform_device *pdev)
 {
 	struct gemini_ethernet *geth = platform_get_drvdata(pdev);
 
-	gemini_ethernet_init(geth);
 	geth_cleanup_freeq(geth);
+	geth->initialized = false;
 
 	return 0;
 }
-- 
2.17.1
