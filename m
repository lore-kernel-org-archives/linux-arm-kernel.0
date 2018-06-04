From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Mon,  4 Jun 2018 15:08:37 +0800
Subject: [PATCH 10/10] dpaa_eth: add the get_ts_info interface for ethtool
In-Reply-To: <20180604070837.19265-1-yangbo.lu@nxp.com>
References: <20180604070837.19265-1-yangbo.lu@nxp.com>
Message-ID: <20180604070837.19265-11-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added the get_ts_info interface for ethtool to check
the timestamping capability.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c |   44 ++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
index 2f933b6..a20b434 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
@@ -32,6 +32,9 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/string.h>
+#include <linux/of_platform.h>
+#include <linux/net_tstamp.h>
+#include <linux/fsl/ptp_qoriq.h>
 
 #include "dpaa_eth.h"
 #include "mac.h"
@@ -515,6 +518,46 @@ static int dpaa_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 	return ret;
 }
 
+static int dpaa_get_ts_info(struct net_device *net_dev,
+			    struct ethtool_ts_info *info)
+{
+	struct device *dev = net_dev->dev.parent;
+	struct device_node *mac_node = dev->of_node;
+	struct device_node *fman_node = NULL, *ptp_node = NULL;
+	struct platform_device *ptp_dev = NULL;
+	struct qoriq_ptp *ptp = NULL;
+
+	fman_node = of_get_parent(mac_node);
+	if (fman_node)
+		ptp_node = of_parse_phandle(fman_node, "ptimer-handle", 0);
+
+	if (ptp_node)
+		ptp_dev = of_find_device_by_node(ptp_node);
+
+	if (ptp_dev)
+		ptp = platform_get_drvdata(ptp_dev);
+
+	if (ptp) {
+		info->phc_index = ptp->phc_index;
+#ifdef CONFIG_FSL_DPAA_ETH_TS
+		info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
+					SOF_TIMESTAMPING_RX_HARDWARE |
+					SOF_TIMESTAMPING_RAW_HARDWARE;
+		info->tx_types = (1 << HWTSTAMP_TX_OFF) |
+				 (1 << HWTSTAMP_TX_ON);
+		info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
+				   (1 << HWTSTAMP_FILTER_ALL);
+		return 0;
+#endif
+	} else {
+		info->phc_index = -1;
+	}
+
+	info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
+				SOF_TIMESTAMPING_SOFTWARE;
+	return 0;
+}
+
 const struct ethtool_ops dpaa_ethtool_ops = {
 	.get_drvinfo = dpaa_get_drvinfo,
 	.get_msglevel = dpaa_get_msglevel,
@@ -530,4 +573,5 @@ static int dpaa_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 	.set_link_ksettings = dpaa_set_link_ksettings,
 	.get_rxnfc = dpaa_get_rxnfc,
 	.set_rxnfc = dpaa_set_rxnfc,
+	.get_ts_info = dpaa_get_ts_info,
 };
-- 
1.7.1
