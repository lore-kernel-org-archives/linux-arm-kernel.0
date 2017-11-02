From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  2 Nov 2017 12:13:36 +0100
Subject: [PATCH] [net-next] net: seeq: fix timer conversion
Message-ID: <20171102111350.3380744-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of the timer conversion patches evidently escaped build testing
until I ran into in on ARM randconfig builds:

drivers/net/ethernet/seeq/ether3.c: In function 'ether3_ledoff':
drivers/net/ethernet/seeq/ether3.c:175:40: error: 'priv' undeclared (first use in this function); did you mean 'pid'?
drivers/net/ethernet/seeq/ether3.c:176:27: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]

This fixes the two small typos that caused the problems.

Fixes: 6fd9c53f7186 ("net: seeq: Convert timers to use timer_setup()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/seeq/ether3.c | 2 +-
 drivers/net/ethernet/seeq/ether3.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/seeq/ether3.c b/drivers/net/ethernet/seeq/ether3.c
index da4807723a06..c5bc124b41a9 100644
--- a/drivers/net/ethernet/seeq/ether3.c
+++ b/drivers/net/ethernet/seeq/ether3.c
@@ -172,7 +172,7 @@ ether3_setbuffer(struct net_device *dev, buffer_rw_t read, int start)
  */
 static void ether3_ledoff(struct timer_list *t)
 {
-	struct dev_priv *private = from_timer(priv, t, timer);
+	struct dev_priv *private = from_timer(private, t, timer);
 	struct net_device *dev = private->dev;
 
 	ether3_outw(priv(dev)->regs.config2 |= CFG2_CTRLO, REG_CONFIG2);
diff --git a/drivers/net/ethernet/seeq/ether3.h b/drivers/net/ethernet/seeq/ether3.h
index ea2ba286e665..be19e5fa5cf2 100644
--- a/drivers/net/ethernet/seeq/ether3.h
+++ b/drivers/net/ethernet/seeq/ether3.h
@@ -165,7 +165,7 @@ struct dev_priv {
     unsigned char tx_tail;		/* buffer nr of transmitting packet	 */
     unsigned int rx_head;		/* address to fetch next packet from	 */
     struct timer_list timer;
-    net_device *dev;
+    struct net_device *dev;
     int broken;				/* 0 = ok, 1 = something went wrong	 */
 };
 
-- 
2.9.0
