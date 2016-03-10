From: yankejian@huawei.com (Kejian Yan)
Date: Thu, 10 Mar 2016 10:17:08 +0800
Subject: [PATCH net] net: hns: bug fix about ping6
Message-ID: <1457576228-23038-1-git-send-email-yankejian@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current upstreaming code fails to ping other IPv6 net device, because
the enet receives the multicast packets with the src mac addr whick is the
same as its mac addr. These packets need to be dropped.

Signed-off-by: Kejian Yan <yankejian@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index 3f77ff7..9ad5da4 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -564,6 +564,7 @@ static int hns_nic_poll_rx_skb(struct hns_nic_ring_data *ring_data,
 	struct sk_buff *skb;
 	struct hnae_desc *desc;
 	struct hnae_desc_cb *desc_cb;
+	struct ethhdr *eh;
 	unsigned char *va;
 	int bnum, length, i;
 	int pull_len;
@@ -670,6 +671,14 @@ out_bnum_err:
 		return -EFAULT;
 	}
 
+	/* filter out multicast pkt with the same src mac as this port */
+	eh = (struct ethhdr *)skb->data;
+	if (unlikely(is_multicast_ether_addr(eh->h_dest) &&
+		     ether_addr_equal(ndev->dev_addr, eh->h_source))) {
+		dev_kfree_skb_any(skb);
+		return -EFAULT;
+	}
+
 	ring->stats.rx_pkts++;
 	ring->stats.rx_bytes += skb->len;
 
-- 
1.9.1
