From: aleksey.makarov@cavium.com (Aleksey Makarov)
Date: Mon, 15 Jan 2018 18:44:57 +0600
Subject: [PATCH net-next v6 2/2] net: thunderx: add timestamping support
In-Reply-To: <20180115124500.14872-1-aleksey.makarov@cavium.com>
References: <20180115124500.14872-1-aleksey.makarov@cavium.com>
Message-ID: <20180115124500.14872-3-aleksey.makarov@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunil Goutham <sgoutham@cavium.com>

This adds timestamping support for both receive and transmit
paths. On the receive side no filters are supported i.e either
all pkts will get a timestamp appended infront of the packet or none.
On the transmit side HW doesn't support timestamp insertion but
only generates a separate CQE with transmitted packet's timestamp.
Also HW supports only one packet at a time for timestamping on the
transmit side.

Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@cavium.com>
Acked-by: Philippe Ombredanne <pombredanne@nexb.com>
---
 drivers/net/ethernet/cavium/Kconfig                |   1 +
 drivers/net/ethernet/cavium/thunder/nic.h          |  36 +++++
 drivers/net/ethernet/cavium/thunder/nic_main.c     |  56 ++++++-
 drivers/net/ethernet/cavium/thunder/nic_reg.h      |   1 +
 .../net/ethernet/cavium/thunder/nicvf_ethtool.c    |  29 +++-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c   | 169 ++++++++++++++++++++-
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c |  26 ++++
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c  |  29 ++++
 drivers/net/ethernet/cavium/thunder/thunder_bgx.h  |   4 +
 9 files changed, 345 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cavium/Kconfig b/drivers/net/ethernet/cavium/Kconfig
index 96586c0b4490..043e3c11c42b 100644
--- a/drivers/net/ethernet/cavium/Kconfig
+++ b/drivers/net/ethernet/cavium/Kconfig
@@ -27,6 +27,7 @@ config THUNDER_NIC_PF
 
 config THUNDER_NIC_VF
 	tristate "Thunder Virtual function driver"
+	imply CAVIUM_PTP
 	depends on 64BIT
 	---help---
 	  This driver supports Thunder's NIC virtual function
diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethernet/cavium/thunder/nic.h
index 4a02e618e318..4cacce5d2b16 100644
--- a/drivers/net/ethernet/cavium/thunder/nic.h
+++ b/drivers/net/ethernet/cavium/thunder/nic.h
@@ -263,6 +263,8 @@ struct nicvf_drv_stats {
 	struct u64_stats_sync   syncp;
 };
 
+struct cavium_ptp;
+
 struct nicvf {
 	struct nicvf		*pnicvf;
 	struct net_device	*netdev;
@@ -312,6 +314,33 @@ struct nicvf {
 	struct tasklet_struct	qs_err_task;
 	struct work_struct	reset_task;
 
+	/* PTP timestamp */
+	struct cavium_ptp	*ptp_clock;
+	/* Inbound timestamping is on */
+	bool			hw_rx_tstamp;
+	/* When the packet that requires timestamping is sent, hardware inserts
+	 * two entries to the completion queue.  First is the regular
+	 * CQE_TYPE_SEND entry that signals that the packet was sent.
+	 * The second is CQE_TYPE_SEND_PTP that contains the actual timestamp
+	 * for that packet.
+	 * `ptp_skb` is initialized in the handler for the CQE_TYPE_SEND
+	 * entry and is used and zeroed in the handler for the CQE_TYPE_SEND_PTP
+	 * entry.
+	 * So `ptp_skb` is used to hold the pointer to the packet between
+	 * the calls to CQE_TYPE_SEND and CQE_TYPE_SEND_PTP handlers.
+	 */
+	struct sk_buff		*ptp_skb;
+	/* `tx_ptp_skbs` is set when the hardware is sending a packet that
+	 * requires timestamping.  Cavium hardware can not process more than one
+	 * such packet at once so this is set each time the driver submits
+	 * a packet that requires timestamping to the send queue and clears
+	 * each time it receives the entry on the completion queue saying
+	 * that such packet was sent.
+	 * So `tx_ptp_skbs` prevents driver from submitting more than one
+	 * packet that requires timestamping to the hardware for transmitting.
+	 */
+	atomic_t		tx_ptp_skbs;
+
 	/* Interrupt coalescing settings */
 	u32			cq_coalesce_usecs;
 	u32			msg_enable;
@@ -371,6 +400,7 @@ struct nicvf {
 #define	NIC_MBOX_MSG_LOOPBACK		0x16	/* Set interface in loopback */
 #define	NIC_MBOX_MSG_RESET_STAT_COUNTER 0x17	/* Reset statistics counters */
 #define	NIC_MBOX_MSG_PFC		0x18	/* Pause frame control */
+#define	NIC_MBOX_MSG_PTP_CFG		0x19	/* HW packet timestamp */
 #define	NIC_MBOX_MSG_CFG_DONE		0xF0	/* VF configuration done */
 #define	NIC_MBOX_MSG_SHUTDOWN		0xF1	/* VF is being shutdown */
 
@@ -521,6 +551,11 @@ struct pfc {
 	u8    fc_tx;
 };
 
+struct set_ptp {
+	u8    msg;
+	bool  enable;
+};
+
 /* 128 bit shared memory between PF and each VF */
 union nic_mbx {
 	struct { u8 msg; }	msg;
@@ -540,6 +575,7 @@ union nic_mbx {
 	struct set_loopback	lbk;
 	struct reset_stat_cfg	reset_stat;
 	struct pfc		pfc;
+	struct set_ptp		ptp;
 };
 
 #define NIC_NODE_ID_MASK	0x03
diff --git a/drivers/net/ethernet/cavium/thunder/nic_main.c b/drivers/net/ethernet/cavium/thunder/nic_main.c
index 8f1dd55b3e08..8325577d7442 100644
--- a/drivers/net/ethernet/cavium/thunder/nic_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nic_main.c
@@ -426,13 +426,22 @@ static void nic_init_hw(struct nicpf *nic)
 	/* Enable backpressure */
 	nic_reg_write(nic, NIC_PF_BP_CFG, (1ULL << 6) | 0x03);
 
-	/* TNS and TNS bypass modes are present only on 88xx */
+	/* TNS and TNS bypass modes are present only on 88xx
+	 * Also offset of this CSR has changed in 81xx and 83xx.
+	 */
 	if (nic->pdev->subsystem_device == PCI_SUBSYS_DEVID_88XX_NIC_PF) {
 		/* Disable TNS mode on both interfaces */
 		nic_reg_write(nic, NIC_PF_INTF_0_1_SEND_CFG,
-			      (NIC_TNS_BYPASS_MODE << 7) | BGX0_BLOCK);
+			      (NIC_TNS_BYPASS_MODE << 7) |
+			      BGX0_BLOCK | (1ULL << 16));
 		nic_reg_write(nic, NIC_PF_INTF_0_1_SEND_CFG | (1 << 8),
-			      (NIC_TNS_BYPASS_MODE << 7) | BGX1_BLOCK);
+			      (NIC_TNS_BYPASS_MODE << 7) |
+			      BGX1_BLOCK | (1ULL << 16));
+	} else {
+		/* Configure timestamp generation timeout to 10us */
+		for (i = 0; i < nic->hw->bgx_cnt; i++)
+			nic_reg_write(nic, NIC_PF_INTFX_SEND_CFG | (i << 3),
+				      (1ULL << 16));
 	}
 
 	nic_reg_write(nic, NIC_PF_INTF_0_1_BP_CFG,
@@ -880,6 +889,44 @@ static void nic_pause_frame(struct nicpf *nic, int vf, struct pfc *cfg)
 	}
 }
 
+/* Enable or disable HW timestamping by BGX for pkts received on a LMAC */
+static void nic_config_timestamp(struct nicpf *nic, int vf, struct set_ptp *ptp)
+{
+	struct pkind_cfg *pkind;
+	u8 lmac, bgx_idx;
+	u64 pkind_val, pkind_idx;
+
+	if (vf >= nic->num_vf_en)
+		return;
+
+	bgx_idx = NIC_GET_BGX_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
+	lmac = NIC_GET_LMAC_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
+
+	pkind_idx = lmac + bgx_idx * MAX_LMAC_PER_BGX;
+	pkind_val = nic_reg_read(nic, NIC_PF_PKIND_0_15_CFG | (pkind_idx << 3));
+	pkind = (struct pkind_cfg *)&pkind_val;
+
+	if (ptp->enable && !pkind->hdr_sl) {
+		/* Skiplen to exclude 8byte timestamp while parsing pkt
+		 * If not configured, will result in L2 errors.
+		 */
+		pkind->hdr_sl = 4;
+		/* Adjust max packet length allowed */
+		pkind->maxlen += (pkind->hdr_sl * 2);
+		bgx_config_timestamping(nic->node, bgx_idx, lmac, true);
+		nic_reg_write(nic, NIC_PF_RX_ETYPE_0_7 | (1 << 3),
+			      (ETYPE_ALG_ENDPARSE << 16) | ETH_P_1588);
+	} else if (!ptp->enable && pkind->hdr_sl) {
+		pkind->maxlen -= (pkind->hdr_sl * 2);
+		pkind->hdr_sl = 0;
+		bgx_config_timestamping(nic->node, bgx_idx, lmac, false);
+		nic_reg_write(nic, NIC_PF_RX_ETYPE_0_7 | (1 << 3),
+			      (ETYPE_ALG_SKIP << 16) | ETH_P_8021Q);
+	}
+
+	nic_reg_write(nic, NIC_PF_PKIND_0_15_CFG | (pkind_idx << 3), pkind_val);
+}
+
 /* Interrupt handler to handle mailbox messages from VFs */
 static void nic_handle_mbx_intr(struct nicpf *nic, int vf)
 {
@@ -1022,6 +1069,9 @@ static void nic_handle_mbx_intr(struct nicpf *nic, int vf)
 	case NIC_MBOX_MSG_PFC:
 		nic_pause_frame(nic, vf, &mbx.pfc);
 		goto unlock;
+	case NIC_MBOX_MSG_PTP_CFG:
+		nic_config_timestamp(nic, vf, &mbx.ptp);
+		break;
 	default:
 		dev_err(&nic->pdev->dev,
 			"Invalid msg from VF%d, msg 0x%x\n", vf, mbx.msg.msg);
diff --git a/drivers/net/ethernet/cavium/thunder/nic_reg.h b/drivers/net/ethernet/cavium/thunder/nic_reg.h
index 80d46337cf29..a16c48a1ebb2 100644
--- a/drivers/net/ethernet/cavium/thunder/nic_reg.h
+++ b/drivers/net/ethernet/cavium/thunder/nic_reg.h
@@ -99,6 +99,7 @@
 #define   NIC_PF_ECC3_DBE_INT_W1S		(0x2708)
 #define   NIC_PF_ECC3_DBE_ENA_W1C		(0x2710)
 #define   NIC_PF_ECC3_DBE_ENA_W1S		(0x2718)
+#define   NIC_PF_INTFX_SEND_CFG			(0x4000)
 #define   NIC_PF_MCAM_0_191_ENA			(0x100000)
 #define   NIC_PF_MCAM_0_191_M_0_5_DATA		(0x110000)
 #define   NIC_PF_MCAM_CTRL			(0x120000)
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c b/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
index b9ece9cbf98b..ed9f10bdf41e 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
@@ -9,12 +9,14 @@
 /* ETHTOOL Support for VNIC_VF Device*/
 
 #include <linux/pci.h>
+#include <linux/net_tstamp.h>
 
 #include "nic_reg.h"
 #include "nic.h"
 #include "nicvf_queues.h"
 #include "q_struct.h"
 #include "thunder_bgx.h"
+#include "../common/cavium_ptp.h"
 
 #define DRV_NAME	"thunder-nicvf"
 #define DRV_VERSION     "1.0"
@@ -824,6 +826,31 @@ static int nicvf_set_pauseparam(struct net_device *dev,
 	return 0;
 }
 
+static int nicvf_get_ts_info(struct net_device *netdev,
+			     struct ethtool_ts_info *info)
+{
+	struct nicvf *nic = netdev_priv(netdev);
+
+	if (!nic->ptp_clock)
+		return ethtool_op_get_ts_info(netdev, info);
+
+	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
+				SOF_TIMESTAMPING_RX_SOFTWARE |
+				SOF_TIMESTAMPING_SOFTWARE |
+				SOF_TIMESTAMPING_TX_HARDWARE |
+				SOF_TIMESTAMPING_RX_HARDWARE |
+				SOF_TIMESTAMPING_RAW_HARDWARE;
+
+	info->phc_index = cavium_ptp_clock_index(nic->ptp_clock);
+
+	info->tx_types = (1 << HWTSTAMP_TX_OFF) | (1 << HWTSTAMP_TX_ON);
+
+	info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
+			   (1 << HWTSTAMP_FILTER_ALL);
+
+	return 0;
+}
+
 static const struct ethtool_ops nicvf_ethtool_ops = {
 	.get_link		= nicvf_get_link,
 	.get_drvinfo		= nicvf_get_drvinfo,
@@ -847,7 +874,7 @@ static const struct ethtool_ops nicvf_ethtool_ops = {
 	.set_channels		= nicvf_set_channels,
 	.get_pauseparam         = nicvf_get_pauseparam,
 	.set_pauseparam         = nicvf_set_pauseparam,
-	.get_ts_info		= ethtool_op_get_ts_info,
+	.get_ts_info		= nicvf_get_ts_info,
 	.get_link_ksettings	= nicvf_get_link_ksettings,
 };
 
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index 21618d0d694f..881af8a120f5 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -20,11 +20,13 @@
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 #include <linux/filter.h>
+#include <linux/net_tstamp.h>
 
 #include "nic_reg.h"
 #include "nic.h"
 #include "nicvf_queues.h"
 #include "thunder_bgx.h"
+#include "../common/cavium_ptp.h"
 
 #define DRV_NAME	"thunder-nicvf"
 #define DRV_VERSION	"1.0"
@@ -602,6 +604,44 @@ static inline bool nicvf_xdp_rx(struct nicvf *nic, struct bpf_prog *prog,
 	return false;
 }
 
+static void nicvf_snd_ptp_handler(struct net_device *netdev,
+				  struct cqe_send_t *cqe_tx)
+{
+	struct nicvf *nic = netdev_priv(netdev);
+	struct skb_shared_hwtstamps ts;
+	u64 ns;
+
+	nic = nic->pnicvf;
+
+	/* Sync for 'ptp_skb' */
+	smp_rmb();
+
+	/* New timestamp request can be queued now */
+	atomic_set(&nic->tx_ptp_skbs, 0);
+
+	/* Check for timestamp requested skb */
+	if (!nic->ptp_skb)
+		return;
+
+	/* Check if timestamping is timedout, which is set to 10us */
+	if (cqe_tx->send_status == CQ_TX_ERROP_TSTMP_TIMEOUT ||
+	    cqe_tx->send_status == CQ_TX_ERROP_TSTMP_CONFLICT)
+		goto no_tstamp;
+
+	/* Get the timestamp */
+	memset(&ts, 0, sizeof(ts));
+	ns = cavium_ptp_tstamp2time(nic->ptp_clock, cqe_tx->ptp_timestamp);
+	ts.hwtstamp = ns_to_ktime(ns);
+	skb_tstamp_tx(nic->ptp_skb, &ts);
+
+no_tstamp:
+	/* Free the original skb */
+	dev_kfree_skb_any(nic->ptp_skb);
+	nic->ptp_skb = NULL;
+	/* Sync 'ptp_skb' */
+	smp_wmb();
+}
+
 static void nicvf_snd_pkt_handler(struct net_device *netdev,
 				  struct cqe_send_t *cqe_tx,
 				  int budget, int *subdesc_cnt,
@@ -658,7 +698,12 @@ static void nicvf_snd_pkt_handler(struct net_device *netdev,
 		prefetch(skb);
 		(*tx_pkts)++;
 		*tx_bytes += skb->len;
-		napi_consume_skb(skb, budget);
+		/* If timestamp is requested for this skb, don't free it */
+		if (skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS &&
+		    !nic->pnicvf->ptp_skb)
+			nic->pnicvf->ptp_skb = skb;
+		else
+			napi_consume_skb(skb, budget);
 		sq->skbuff[cqe_tx->sqe_ptr] = (u64)NULL;
 	} else {
 		/* In case of SW TSO on 88xx, only last segment will have
@@ -697,6 +742,21 @@ static inline void nicvf_set_rxhash(struct net_device *netdev,
 	skb_set_hash(skb, hash, hash_type);
 }
 
+static inline void nicvf_set_rxtstamp(struct nicvf *nic, struct sk_buff *skb)
+{
+	u64 ns;
+
+	if (!nic->ptp_clock || !nic->hw_rx_tstamp)
+		return;
+
+	/* The first 8 bytes is the timestamp */
+	ns = cavium_ptp_tstamp2time(nic->ptp_clock,
+				    be64_to_cpu(*(__be64 *)skb->data));
+	skb_hwtstamps(skb)->hwtstamp = ns_to_ktime(ns);
+
+	__skb_pull(skb, 8);
+}
+
 static void nicvf_rcv_pkt_handler(struct net_device *netdev,
 				  struct napi_struct *napi,
 				  struct cqe_rx_t *cqe_rx,
@@ -748,6 +808,7 @@ static void nicvf_rcv_pkt_handler(struct net_device *netdev,
 		return;
 	}
 
+	nicvf_set_rxtstamp(nic, skb);
 	nicvf_set_rxhash(netdev, cqe_rx, skb);
 
 	skb_record_rx_queue(skb, rq_idx);
@@ -823,10 +884,12 @@ static int nicvf_cq_intr_handler(struct net_device *netdev, u8 cq_idx,
 					      &tx_pkts, &tx_bytes);
 			tx_done++;
 		break;
+		case CQE_TYPE_SEND_PTP:
+			nicvf_snd_ptp_handler(netdev, (void *)cq_desc);
+		break;
 		case CQE_TYPE_INVALID:
 		case CQE_TYPE_RX_SPLIT:
 		case CQE_TYPE_RX_TCP:
-		case CQE_TYPE_SEND_PTP:
 			/* Ignore for now */
 		break;
 		}
@@ -1322,12 +1385,28 @@ int nicvf_stop(struct net_device *netdev)
 
 	nicvf_free_cq_poll(nic);
 
+	/* Free any pending SKB saved to receive timestamp */
+	if (nic->ptp_skb) {
+		dev_kfree_skb_any(nic->ptp_skb);
+		nic->ptp_skb = NULL;
+	}
+
 	/* Clear multiqset info */
 	nic->pnicvf = nic;
 
 	return 0;
 }
 
+static int nicvf_config_hw_rx_tstamp(struct nicvf *nic, bool enable)
+{
+	union nic_mbx mbx = {};
+
+	mbx.ptp.msg = NIC_MBOX_MSG_PTP_CFG;
+	mbx.ptp.enable = enable;
+
+	return nicvf_send_msg_to_pf(nic, &mbx);
+}
+
 static int nicvf_update_hw_max_frs(struct nicvf *nic, int mtu)
 {
 	union nic_mbx mbx = {};
@@ -1397,6 +1476,12 @@ int nicvf_open(struct net_device *netdev)
 	if (nic->sqs_mode)
 		nicvf_get_primary_vf_struct(nic);
 
+	/* Configure PTP timestamp */
+	if (nic->ptp_clock)
+		nicvf_config_hw_rx_tstamp(nic, nic->hw_rx_tstamp);
+	atomic_set(&nic->tx_ptp_skbs, 0);
+	nic->ptp_skb = NULL;
+
 	/* Configure receive side scaling and MTU */
 	if (!nic->sqs_mode) {
 		nicvf_rss_init(nic);
@@ -1823,6 +1908,73 @@ static void nicvf_xdp_flush(struct net_device *dev)
 	return;
 }
 
+static int nicvf_config_hwtstamp(struct net_device *netdev, struct ifreq *ifr)
+{
+	struct hwtstamp_config config;
+	struct nicvf *nic = netdev_priv(netdev);
+
+	if (!nic->ptp_clock)
+		return -ENODEV;
+
+	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
+		return -EFAULT;
+
+	/* reserved for future extensions */
+	if (config.flags)
+		return -EINVAL;
+
+	switch (config.tx_type) {
+	case HWTSTAMP_TX_OFF:
+	case HWTSTAMP_TX_ON:
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	switch (config.rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		nic->hw_rx_tstamp = false;
+		break;
+	case HWTSTAMP_FILTER_ALL:
+	case HWTSTAMP_FILTER_SOME:
+	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
+		nic->hw_rx_tstamp = true;
+		config.rx_filter = HWTSTAMP_FILTER_ALL;
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	if (netif_running(netdev))
+		nicvf_config_hw_rx_tstamp(nic, nic->hw_rx_tstamp);
+
+	if (copy_to_user(ifr->ifr_data, &config, sizeof(config)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int nicvf_ioctl(struct net_device *netdev, struct ifreq *req, int cmd)
+{
+	switch (cmd) {
+	case SIOCSHWTSTAMP:
+		return nicvf_config_hwtstamp(netdev, req);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static const struct net_device_ops nicvf_netdev_ops = {
 	.ndo_open		= nicvf_open,
 	.ndo_stop		= nicvf_stop,
@@ -1836,6 +1988,7 @@ static const struct net_device_ops nicvf_netdev_ops = {
 	.ndo_bpf		= nicvf_xdp,
 	.ndo_xdp_xmit		= nicvf_xdp_xmit,
 	.ndo_xdp_flush          = nicvf_xdp_flush,
+	.ndo_do_ioctl           = nicvf_ioctl,
 };
 
 static int nicvf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
@@ -1845,6 +1998,16 @@ static int nicvf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct nicvf *nic;
 	int    err, qcount;
 	u16    sdevid;
+	struct cavium_ptp *ptp_clock;
+
+	ptp_clock = cavium_ptp_get();
+	if (IS_ERR(ptp_clock)) {
+		if (PTR_ERR(ptp_clock) == -ENODEV)
+			/* In virtualized environment we proceed without ptp */
+			ptp_clock = NULL;
+		else
+			return PTR_ERR(ptp_clock);
+	}
 
 	err = pci_enable_device(pdev);
 	if (err) {
@@ -1899,6 +2062,7 @@ static int nicvf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 */
 	if (!nic->t88)
 		nic->max_queues *= 2;
+	nic->ptp_clock = ptp_clock;
 
 	/* MAP VF's configuration registers */
 	nic->reg_base = pcim_iomap(pdev, PCI_CFG_REG_BAR_NUM, 0);
@@ -2012,6 +2176,7 @@ static void nicvf_remove(struct pci_dev *pdev)
 	pci_set_drvdata(pdev, NULL);
 	if (nic->drv_stats)
 		free_percpu(nic->drv_stats);
+	cavium_ptp_put(nic->ptp_clock);
 	free_netdev(netdev);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
index 14e62c6ac342..3eae9ff9b53a 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
@@ -982,6 +982,9 @@ void nicvf_qset_config(struct nicvf *nic, bool enable)
 		qs_cfg->be = 1;
 #endif
 		qs_cfg->vnic = qs->vnic_id;
+		/* Enable Tx timestamping capability */
+		if (nic->ptp_clock)
+			qs_cfg->send_tstmp_ena = 1;
 	}
 	nicvf_send_msg_to_pf(nic, &mbx);
 }
@@ -1389,6 +1392,29 @@ nicvf_sq_add_hdr_subdesc(struct nicvf *nic, struct snd_queue *sq, int qentry,
 		hdr->inner_l3_offset = skb_network_offset(skb) - 2;
 		this_cpu_inc(nic->pnicvf->drv_stats->tx_tso);
 	}
+
+	/* Check if timestamp is requested */
+	if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
+		skb_tx_timestamp(skb);
+		return;
+	}
+
+	/* Tx timestamping not supported along with TSO, so ignore request */
+	if (skb_shinfo(skb)->gso_size)
+		return;
+
+	/* HW supports only a single outstanding packet to timestamp */
+	if (!atomic_add_unless(&nic->pnicvf->tx_ptp_skbs, 1, 1))
+		return;
+
+	/* Mark the SKB for later reference */
+	skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+
+	/* Finally enable timestamp generation
+	 * Since 'post_cqe' is also set, two CQEs will be posted
+	 * for this packet i.e CQE_TYPE_SEND and CQE_TYPE_SEND_PTP.
+	 */
+	hdr->tstmp = 1;
 }
 
 /* SQ GATHER subdescriptor
diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 5e5c4d7796b8..0f23999c5bcf 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -245,6 +245,35 @@ void bgx_lmac_rx_tx_enable(int node, int bgx_idx, int lmacid, bool enable)
 }
 EXPORT_SYMBOL(bgx_lmac_rx_tx_enable);
 
+/* Enables or disables timestamp insertion by BGX for Rx packets */
+void bgx_config_timestamping(int node, int bgx_idx, int lmacid, bool enable)
+{
+	struct bgx *bgx = get_bgx(node, bgx_idx);
+	struct lmac *lmac;
+	u64 csr_offset, cfg;
+
+	if (!bgx)
+		return;
+
+	lmac = &bgx->lmac[lmacid];
+
+	if (lmac->lmac_type == BGX_MODE_SGMII ||
+	    lmac->lmac_type == BGX_MODE_QSGMII ||
+	    lmac->lmac_type == BGX_MODE_RGMII)
+		csr_offset = BGX_GMP_GMI_RXX_FRM_CTL;
+	else
+		csr_offset = BGX_SMUX_RX_FRM_CTL;
+
+	cfg = bgx_reg_read(bgx, lmacid, csr_offset);
+
+	if (enable)
+		cfg |= BGX_PKT_RX_PTP_EN;
+	else
+		cfg &= ~BGX_PKT_RX_PTP_EN;
+	bgx_reg_write(bgx, lmacid, csr_offset, cfg);
+}
+EXPORT_SYMBOL(bgx_config_timestamping);
+
 void bgx_lmac_get_pfc(int node, int bgx_idx, int lmacid, void *pause)
 {
 	struct pfc *pfc = (struct pfc *)pause;
diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.h b/drivers/net/ethernet/cavium/thunder/thunder_bgx.h
index 23acdc5ab896..5a7567d31138 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.h
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.h
@@ -122,6 +122,8 @@
 #define  SPU_DBG_CTL_AN_NONCE_MCT_DIS		BIT_ULL(29)
 
 #define BGX_SMUX_RX_INT			0x20000
+#define BGX_SMUX_RX_FRM_CTL		0x20020
+#define  BGX_PKT_RX_PTP_EN			BIT_ULL(12)
 #define BGX_SMUX_RX_JABBER		0x20030
 #define BGX_SMUX_RX_CTL			0x20048
 #define  SMU_RX_CTL_STATUS			(3ull << 0)
@@ -172,6 +174,7 @@
 #define  GMI_PORT_CFG_SPEED_MSB			BIT_ULL(8)
 #define  GMI_PORT_CFG_RX_IDLE			BIT_ULL(12)
 #define  GMI_PORT_CFG_TX_IDLE			BIT_ULL(13)
+#define BGX_GMP_GMI_RXX_FRM_CTL		0x38028
 #define BGX_GMP_GMI_RXX_JABBER		0x38038
 #define BGX_GMP_GMI_TXX_THRESH		0x38210
 #define BGX_GMP_GMI_TXX_APPEND		0x38218
@@ -223,6 +226,7 @@ void bgx_set_lmac_mac(int node, int bgx_idx, int lmacid, const u8 *mac);
 void bgx_get_lmac_link_state(int node, int bgx_idx, int lmacid, void *status);
 void bgx_lmac_internal_loopback(int node, int bgx_idx,
 				int lmac_idx, bool enable);
+void bgx_config_timestamping(int node, int bgx_idx, int lmacid, bool enable);
 void bgx_lmac_get_pfc(int node, int bgx_idx, int lmacid, void *pause);
 void bgx_lmac_set_pfc(int node, int bgx_idx, int lmacid, void *pause);
 
-- 
2.15.1
