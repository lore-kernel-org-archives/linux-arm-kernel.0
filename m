From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sun,  3 Dec 2017 00:56:14 +0530
Subject: [PATCH 02/10] net: bcmgenet: free netdev on of_match_node() error
In-Reply-To: <1512242782-7134-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1512242782-7134-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1512242782-7134-3-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change is to call free_netdev(), If of_match_node() will fail.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index e2f1268..e0a8f79 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3363,8 +3363,10 @@ static int bcmgenet_probe(struct platform_device *pdev)
 
 	if (dn) {
 		of_id = of_match_node(bcmgenet_match, dn);
-		if (!of_id)
-			return -EINVAL;
+		if (!of_id) {
+			err = -EINVAL;
+			goto err;
+		}
 	}
 
 	priv = netdev_priv(dev);
-- 
2.7.4
