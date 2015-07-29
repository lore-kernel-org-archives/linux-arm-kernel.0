From: aleksey.makarov@caviumnetworks.com (Aleksey Makarov)
Date: Wed, 29 Jul 2015 16:49:41 +0300
Subject: [PATCH net 06/11] net: thunderx: Suppress alloc_pages() failure
 warnings
In-Reply-To: <1438177787-20940-1-git-send-email-aleksey.makarov@caviumnetworks.com>
References: <1438177787-20940-1-git-send-email-aleksey.makarov@caviumnetworks.com>
Message-ID: <1438177787-20940-7-git-send-email-aleksey.makarov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunil Goutham <sgoutham@cavium.com>

Suppressing standard alloc_pages() warnings. Some kernel configs limit
alloc size and the network driver may fail. Do not drop a kernel
warning in this case, instead just drop a oneliner that the network
driver could not be loaded since the buffer could not be allocated.

Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@caviumnetworks.com>
---
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
index 500fdbe..ca4240a 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
@@ -103,9 +103,11 @@ static inline int nicvf_alloc_rcv_buffer(struct nicvf *nic, gfp_t gfp,
 
 	/* Allocate a new page */
 	if (!nic->rb_page) {
-		nic->rb_page = alloc_pages(gfp | __GFP_COMP, order);
+		nic->rb_page = alloc_pages(gfp | __GFP_COMP | __GFP_NOWARN,
+					   order);
 		if (!nic->rb_page) {
-			netdev_err(nic->netdev, "Failed to allocate new rcv buffer\n");
+			netdev_err(nic->netdev,
+				   "Failed to allocate new rcv buffer\n");
 			return -ENOMEM;
 		}
 		nic->rb_page_offset = 0;
-- 
2.4.6
