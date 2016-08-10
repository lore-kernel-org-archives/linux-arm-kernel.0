From: sunil.kovvuri@gmail.com (sunil.kovvuri at gmail.com)
Date: Wed, 10 Aug 2016 12:12:49 +0530
Subject: [PATCH 17/21] net: thunderx: Don't set mac address for secondary Qset
 VFs
In-Reply-To: <1470811373-28277-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1470811373-28277-1-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <1470811373-28277-18-git-send-email-sunil.kovvuri@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunil Goutham <sgoutham@cavium.com>

Set MAC addresses only for primary VF's and don't for
secondary VFs.

Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
---
 drivers/net/ethernet/cavium/thunder/nic_main.c   | 2 +-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nic_main.c b/drivers/net/ethernet/cavium/thunder/nic_main.c
index 3932c45..167291b 100644
--- a/drivers/net/ethernet/cavium/thunder/nic_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nic_main.c
@@ -174,7 +174,7 @@ static void nic_mbx_send_ready(struct nicpf *nic, int vf)
 
 	mbx.nic_cfg.tns_mode = NIC_TNS_BYPASS_MODE;
 
-	if (vf < MAX_LMAC) {
+	if (vf < nic->num_vf_en) {
 		bgx_idx = NIC_GET_BGX_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
 		lmac = NIC_GET_LMAC_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
 
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index 300416a..4a084ab 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1209,7 +1209,7 @@ int nicvf_open(struct net_device *netdev)
 	}
 
 	/* Check if we got MAC address from PF or else generate a radom MAC */
-	if (is_zero_ether_addr(netdev->dev_addr)) {
+	if (!nic->sqs_mode && is_zero_ether_addr(netdev->dev_addr)) {
 		eth_hw_addr_random(netdev);
 		nicvf_hw_set_mac_addr(nic, netdev);
 	}
-- 
2.7.4
