From: madalin.bucur@nxp.com (Madalin Bucur)
Date: Tue, 13 Nov 2018 18:29:51 +0200
Subject: [PATCH v2 2/2] dpaa_eth: add ethtool coalesce control
In-Reply-To: <1542126591-5114-1-git-send-email-madalin.bucur@nxp.com>
References: <1542126591-5114-1-git-send-email-madalin.bucur@nxp.com>
Message-ID: <1542126591-5114-3-git-send-email-madalin.bucur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow ethtool control of the DPAA QMan portal interrupt coalescing
settings.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
index 13d6e2272ece..4df366b05976 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
@@ -529,6 +529,53 @@ static int dpaa_get_ts_info(struct net_device *net_dev,
 	return 0;
 }
 
+static int dpaa_get_coalesce(struct net_device *dev,
+			     struct ethtool_coalesce *c)
+{
+	struct qman_portal *portal;
+	u32 period;
+	u8 thresh;
+
+	portal = qman_get_affine_portal(smp_processor_id());
+	qman_portal_get_iperiod(portal, &period);
+	qman_dqrr_get_ithresh(portal, &thresh);
+
+	c->rx_coalesce_usecs = period;
+	c->rx_max_coalesced_frames = thresh;
+	c->use_adaptive_rx_coalesce = false;
+
+	return 0;
+}
+
+static int dpaa_set_coalesce(struct net_device *dev,
+			     struct ethtool_coalesce *c)
+{
+	const cpumask_t *cpus = qman_affine_cpus();
+	struct qman_portal *portal;
+	u32 period;
+	u8 thresh;
+	int cpu;
+	int res;
+
+	if (c->use_adaptive_rx_coalesce)
+		return -EINVAL;
+
+	period = c->rx_coalesce_usecs;
+	thresh = c->rx_max_coalesced_frames;
+
+	for_each_cpu(cpu, cpus) {
+		portal = qman_get_affine_portal(cpu);
+		res = qman_portal_set_iperiod(portal, period);
+		if (res)
+			return res;
+		res = qman_dqrr_set_ithresh(portal, thresh);
+		if (res)
+			return res;
+	}
+
+	return 0;
+}
+
 const struct ethtool_ops dpaa_ethtool_ops = {
 	.get_drvinfo = dpaa_get_drvinfo,
 	.get_msglevel = dpaa_get_msglevel,
@@ -545,4 +592,6 @@ const struct ethtool_ops dpaa_ethtool_ops = {
 	.get_rxnfc = dpaa_get_rxnfc,
 	.set_rxnfc = dpaa_set_rxnfc,
 	.get_ts_info = dpaa_get_ts_info,
+	.get_coalesce = dpaa_get_coalesce,
+	.set_coalesce = dpaa_set_coalesce,
 };
-- 
2.1.0
