From: madalin.bucur@nxp.com (Madalin Bucur)
Date: Wed, 21 Nov 2018 13:41:09 +0200
Subject: [PATCH v3 3/3] dpaa_eth: add ethtool coalesce control
In-Reply-To: <1542800469-6802-1-git-send-email-madalin.bucur@nxp.com>
References: <1542800469-6802-1-git-send-email-madalin.bucur@nxp.com>
Message-ID: <1542800469-6802-4-git-send-email-madalin.bucur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow ethtool control of the DPAA QMan portal interrupt coalescing
settings.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c | 71 ++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
index 13d6e2272ece..62497119c85f 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
@@ -529,6 +529,75 @@ static int dpaa_get_ts_info(struct net_device *net_dev,
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
+	bool needs_revert[NR_CPUS] = {false};
+	struct qman_portal *portal;
+	u32 period, prev_period;
+	u8 thresh, prev_thresh;
+	int cpu, res;
+
+	if (c->use_adaptive_rx_coalesce)
+		return -EINVAL;
+
+	period = c->rx_coalesce_usecs;
+	thresh = c->rx_max_coalesced_frames;
+
+	/* save previous values */
+	portal = qman_get_affine_portal(smp_processor_id());
+	qman_portal_get_iperiod(portal, &prev_period);
+	qman_dqrr_get_ithresh(portal, &prev_thresh);
+
+	/* set new values */
+	for_each_cpu(cpu, cpus) {
+		portal = qman_get_affine_portal(cpu);
+		res = qman_portal_set_iperiod(portal, period);
+		if (res)
+			goto revert_values;
+		res = qman_dqrr_set_ithresh(portal, thresh);
+		if (res) {
+			qman_portal_set_iperiod(portal, prev_period);
+			goto revert_values;
+		}
+		needs_revert[cpu] = true;
+	}
+
+	return 0;
+
+revert_values:
+	/* restore previous values */
+	for_each_cpu(cpu, cpus) {
+		if (!needs_revert[cpu])
+			continue;
+		portal = qman_get_affine_portal(cpu);
+		/* previous values will not fail, ignore return value */
+		qman_portal_set_iperiod(portal, prev_period);
+		qman_dqrr_set_ithresh(portal, prev_thresh);
+	}
+
+	return res;
+}
+
 const struct ethtool_ops dpaa_ethtool_ops = {
 	.get_drvinfo = dpaa_get_drvinfo,
 	.get_msglevel = dpaa_get_msglevel,
@@ -545,4 +614,6 @@ const struct ethtool_ops dpaa_ethtool_ops = {
 	.get_rxnfc = dpaa_get_rxnfc,
 	.set_rxnfc = dpaa_set_rxnfc,
 	.get_ts_info = dpaa_get_ts_info,
+	.get_coalesce = dpaa_get_coalesce,
+	.set_coalesce = dpaa_set_coalesce,
 };
-- 
2.1.0
