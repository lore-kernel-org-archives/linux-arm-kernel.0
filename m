From: aleksey.makarov@auriga.com (Aleksey Makarov)
Date: Thu, 23 Nov 2017 17:41:56 +0300
Subject: [PATCH net v2] net: thunderx: Fix TCP/UDP checksum offload for IPv6
 pkts
Message-ID: <20171123144158.26111-1-aleksey.makarov@auriga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunil Goutham <sgoutham@cavium.com>

Don't offload IP header checksum to NIC.

This fixes a previous patch which enabled checksum offloading
for both IPv4 and IPv6 packets.  So L3 checksum offload was
getting enabled for IPv6 pkts.  And HW is dropping these pkts
as it assumes the pkt is IPv4 when IP csum offload is set
in the SQ descriptor.

Fixes: bbbb494fd005 ("net: thunderx: Enable TSO and checksum offloads for ipv6")
Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
---
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c | 1 -
 1 file changed, 1 deletion(-)

v2:
- Don't enable checksum offloading both for IPv4 and IPv6 (Eric Dumazet)

v1:
  https://lkml.kernel.org/r/20171122123727.23580-1-aleksey.makarov at auriga.com

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
index d4496e9afcdf..8b2c31e2a2b0 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
@@ -1355,7 +1355,6 @@ nicvf_sq_add_hdr_subdesc(struct nicvf *nic, struct snd_queue *sq, int qentry,
 
 	/* Offload checksum calculation to HW */
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
-		hdr->csum_l3 = 1; /* Enable IP csum calculation */
 		hdr->l3_offset = skb_network_offset(skb);
 		hdr->l4_offset = skb_transport_offset(skb);
 
-- 
2.15.0
