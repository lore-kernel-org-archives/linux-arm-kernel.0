From: Vadim.Lomovtsev@caviumnetworks.com (Vadim Lomovtsev)
Date: Fri, 30 Mar 2018 04:59:52 -0700
Subject: [PATCH v2 6/7] net: thunderx: add workqueue control structures for
 handle ndo_set_rx_mode request
In-Reply-To: <20180330115953.17154-1-Vadim.Lomovtsev@caviumnetworks.com>
References: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20180330115953.17154-1-Vadim.Lomovtsev@caviumnetworks.com>
Message-ID: <20180330115953.17154-7-Vadim.Lomovtsev@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>

The kernel calls ndo_set_rx_mode() callback from atomic context which
causes messaging timeouts between VF and PF (as they?re implemented via
MSIx). So in order to handle ndo_set_rx_mode() we need to get rid of it.

This commit implements necessary workqueue related structures to let VF
queue kernel request processing in non-atomic context later.

Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
---
 drivers/net/ethernet/cavium/thunder/nic.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethernet/cavium/thunder/nic.h
index 069289b4f968..5fc46c5a4f36 100644
--- a/drivers/net/ethernet/cavium/thunder/nic.h
+++ b/drivers/net/ethernet/cavium/thunder/nic.h
@@ -265,6 +265,22 @@ struct nicvf_drv_stats {
 
 struct cavium_ptp;
 
+struct xcast_addr {
+	struct list_head list;
+	u64              addr;
+};
+
+struct xcast_addr_list {
+	struct list_head list;
+	int              count;
+};
+
+struct nicvf_work {
+	struct delayed_work    work;
+	u8                     mode;
+	struct xcast_addr_list *mc;
+};
+
 struct nicvf {
 	struct nicvf		*pnicvf;
 	struct net_device	*netdev;
@@ -313,6 +329,7 @@ struct nicvf {
 	struct nicvf_pfc	pfc;
 	struct tasklet_struct	qs_err_task;
 	struct work_struct	reset_task;
+	struct nicvf_work       rx_mode_work;
 
 	/* PTP timestamp */
 	struct cavium_ptp	*ptp_clock;
-- 
2.14.3
