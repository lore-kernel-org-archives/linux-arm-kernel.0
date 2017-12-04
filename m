From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Mon,  4 Dec 2017 23:18:20 +0530
Subject: [PATCH 4/7 v2] net: ethernet: i825xx: Fix platform_get_irq's error
 checking
In-Reply-To: <1512409703-20881-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1512409703-20881-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1512409703-20881-5-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_get_irq() function returns negative number if an error
occurs, Zero if No irq is found and positive number if irq gets successful.
platform_get_irq() error checking only for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2:
             commit message was not correct.

 drivers/net/ethernet/i825xx/sni_82596.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/i825xx/sni_82596.c b/drivers/net/ethernet/i825xx/sni_82596.c
index b2c04a7..f2a11fc 100644
--- a/drivers/net/ethernet/i825xx/sni_82596.c
+++ b/drivers/net/ethernet/i825xx/sni_82596.c
@@ -120,9 +120,10 @@ static int sni_82596_probe(struct platform_device *dev)
 	netdevice->dev_addr[5] = readb(eth_addr + 0x06);
 	iounmap(eth_addr);
 
-	if (!netdevice->irq) {
+	if (netdevice->irq <= 0) {
 		printk(KERN_ERR "%s: IRQ not found for i82596@0x%lx\n",
 			__FILE__, netdevice->base_addr);
+		retval = netdevice->irq ? netdevice->irq : -ENODEV;
 		goto probe_failed;
 	}
 
-- 
2.7.4
