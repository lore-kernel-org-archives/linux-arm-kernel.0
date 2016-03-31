From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 31 Mar 2016 17:01:23 +0800
Subject: [PATCH] net: mvpp2: fix maybe-uninitialized warning
Message-ID: <1459414883-6295-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is to fix the following maybe-uninitialized warning:

drivers/net/ethernet/marvell/mvpp2.c:6007:18: warning: 'err' may be
used uninitialized in this function [-Wmaybe-uninitialized]

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index c797971a..e9aa8d9 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -6059,8 +6059,10 @@ static int mvpp2_port_init(struct mvpp2_port *port)
 
 		/* Map physical Rx queue to port's logical Rx queue */
 		rxq = devm_kzalloc(dev, sizeof(*rxq), GFP_KERNEL);
-		if (!rxq)
+		if (!rxq) {
+			err = -ENOMEM;
 			goto err_free_percpu;
+		}
 		/* Map this Rx queue to a physical queue */
 		rxq->id = port->first_rxq + queue;
 		rxq->port = port->id;
-- 
2.8.0.rc3
