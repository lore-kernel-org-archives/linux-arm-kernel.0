From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Wed, 11 Jan 2017 16:32:51 +0000
Subject: [PATCH net-next] net: thunderx: Fix error return code in nicvf_open()
Message-ID: <20170111163251.19367-1-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: 712c31853440 ("net: thunderx: Program LMAC credits based on MTU")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index 273eafd..a25bb6e 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1274,7 +1274,8 @@ int nicvf_open(struct net_device *netdev)
 	/* Configure receive side scaling and MTU */
 	if (!nic->sqs_mode) {
 		nicvf_rss_init(nic);
-		if (nicvf_update_hw_max_frs(nic, netdev->mtu))
+		err = nicvf_update_hw_max_frs(nic, netdev->mtu);
+		if (err)
 			goto cleanup;
 
 		/* Clear percpu stats */
