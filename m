From: Yisen.Zhuang@huawei.com (Yisen Zhuang)
Date: Tue, 21 Jun 2016 11:56:23 +0800
Subject: [PATCH net-next 03/19] net: hns: add skb_reset_mac_header() after skb
 being alloc
In-Reply-To: <1466481399-70080-1-git-send-email-Yisen.Zhuang@huawei.com>
References: <1466481399-70080-1-git-send-email-Yisen.Zhuang@huawei.com>
Message-ID: <1466481399-70080-4-git-send-email-Yisen.Zhuang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kejian Yan <yankejian@huawei.com>

HNS receives a packet without doing anything, but it should call
skb_reset_mac_header() to initialize the header before using
eth_hdr().

Fixes: 0d6b425a3773c3445b0f51b2f333821beaacb619
Signed-off-by: Kejian Yan <yankejian@huawei.com>
Signed-off-by: Yisen Zhuang <Yisen.Zhuang@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index ad742a6..15200e4 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -600,6 +600,7 @@ static int hns_nic_poll_rx_skb(struct hns_nic_ring_data *ring_data,
 		ring->stats.sw_err_cnt++;
 		return -ENOMEM;
 	}
+	skb_reset_mac_header(skb);
 
 	prefetchw(skb->data);
 	length = le16_to_cpu(desc->rx.pkt_len);
-- 
1.9.1
