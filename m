From: ruxandra.radulescu@nxp.com (Ioana Radulescu)
Date: Tue, 6 Jun 2017 10:00:38 -0500
Subject: [PATCH 15/18] staging: fsl-dpaa2/eth: Reorder priv fields
In-Reply-To: <20170606150041.10955-1-ruxandra.radulescu@nxp.com>
References: <20170606150041.10955-1-ruxandra.radulescu@nxp.com>
Message-ID: <20170606150041.10955-16-ruxandra.radulescu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reorder fields in the device's private structure such that
the ones most used on the hotpath are at the beginning of
the structure.

This brings a small performance improvement due to better
cache usage.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
index 886a0681fee1..c760e9b77e22 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
@@ -290,34 +290,30 @@ struct dpaa2_eth_hash_fields {
 /* Driver private data */
 struct dpaa2_eth_priv {
 	struct net_device *net_dev;
+	/* Standard statistics */
+	struct rtnl_link_stats64 __percpu *percpu_stats;
+	/* Extra stats, in addition to the ones known by the kernel */
+	struct dpaa2_eth_drv_stats __percpu *percpu_extras;
+	struct iommu_domain *iommu_domain;
+	u16 tx_data_offset;
+	u16 bpid;
+	u16 tx_qdid;
 
 	u8 num_fqs;
-	struct dpaa2_eth_fq fq[DPAA2_ETH_MAX_QUEUES];
-
 	u8 num_channels;
+	struct dpaa2_eth_fq fq[DPAA2_ETH_MAX_QUEUES];
 	struct dpaa2_eth_channel *channel[DPAA2_ETH_MAX_DPCONS];
 
+	struct fsl_mc_io *mc_io;
+	u16 mc_token;
 	struct dpni_attr dpni_attrs;
-	u16 tx_data_offset;
-
 	struct fsl_mc_device *dpbp_dev;
-	u16 bpid;
-	struct iommu_domain *iommu_domain;
 
-	u16 tx_qdid;
-	struct fsl_mc_io *mc_io;
 	/* Cores which have an affine DPIO/DPCON.
 	 * This is the cpu set on which Rx and Tx conf frames are processed
 	 */
 	struct cpumask dpio_cpumask;
 
-	/* Standard statistics */
-	struct rtnl_link_stats64 __percpu *percpu_stats;
-	/* Extra stats, in addition to the ones known by the kernel */
-	struct dpaa2_eth_drv_stats __percpu *percpu_extras;
-
-	u16 mc_token;
-
 	struct dpni_link_state link_state;
 	bool do_link_poll;
 	struct task_struct *poll_thread;
-- 
2.11.0
