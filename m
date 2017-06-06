From: ruxandra.radulescu@nxp.com (Ioana Radulescu)
Date: Tue, 6 Jun 2017 10:00:32 -0500
Subject: [PATCH 09/18] staging: fsl-dpaa2/eth: Reset dpbp
In-Reply-To: <20170606150041.10955-1-ruxandra.radulescu@nxp.com>
References: <20170606150041.10955-1-ruxandra.radulescu@nxp.com>
Message-ID: <20170606150041.10955-10-ruxandra.radulescu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reset the buffer pool object before using it, like we do
for the other DPAA2 objects.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index d3ec384c7364..fd56fbd20087 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -1687,6 +1687,12 @@ static int setup_dpbp(struct dpaa2_eth_priv *priv)
 		goto err_open;
 	}
 
+	err = dpbp_reset(priv->mc_io, 0, dpbp_dev->mc_handle);
+	if (err) {
+		dev_err(dev, "dpbp_reset() failed\n");
+		goto err_reset;
+	}
+
 	err = dpbp_enable(priv->mc_io, 0, dpbp_dev->mc_handle);
 	if (err) {
 		dev_err(dev, "dpbp_enable() failed\n");
@@ -1705,6 +1711,7 @@ static int setup_dpbp(struct dpaa2_eth_priv *priv)
 err_get_attr:
 	dpbp_disable(priv->mc_io, 0, dpbp_dev->mc_handle);
 err_enable:
+err_reset:
 	dpbp_close(priv->mc_io, 0, dpbp_dev->mc_handle);
 err_open:
 	fsl_mc_object_free(dpbp_dev);
-- 
2.11.0
