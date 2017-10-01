From: jonas.gorski@gmail.com (Jonas Gorski)
Date: Sun,  1 Oct 2017 13:02:17 +0200
Subject: [PATCH 3/6] bcm63xx_enet: do not rely on probe order
In-Reply-To: <20171001110220.27668-1-jonas.gorski@gmail.com>
References: <20171001110220.27668-1-jonas.gorski@gmail.com>
Message-ID: <20171001110220.27668-4-jonas.gorski@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do not rely on the shared device being probed before the enet(sw)
devices. This makes it easier to eventually move out the shared
device as a dma controller driver (what it should be).

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/ethernet/broadcom/bcm63xx_enet.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index a1e1e12e187a..8caf6abab3a6 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -1722,10 +1722,8 @@ static int bcm_enet_probe(struct platform_device *pdev)
 	const char *clk_name;
 	int i, ret;
 
-	/* stop if shared driver failed, assume driver->probe will be
-	 * called in the same order we register devices (correct ?) */
 	if (!bcm_enet_shared_base[0])
-		return -ENODEV;
+		return -EPROBE_DEFER;
 
 	res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	res_irq_rx = platform_get_resource(pdev, IORESOURCE_IRQ, 1);
@@ -2696,11 +2694,8 @@ static int bcm_enetsw_probe(struct platform_device *pdev)
 	struct resource *res_mem;
 	int ret, irq_rx, irq_tx;
 
-	/* stop if shared driver failed, assume driver->probe will be
-	 * called in the same order we register devices (correct ?)
-	 */
 	if (!bcm_enet_shared_base[0])
-		return -ENODEV;
+		return -EPROBE_DEFER;
 
 	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq_rx = platform_get_irq(pdev, 0);
-- 
2.13.2
