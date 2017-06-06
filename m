From: ruxandra.radulescu@nxp.com (Ioana Radulescu)
Date: Tue, 6 Jun 2017 10:00:33 -0500
Subject: [PATCH 10/18] staging: fsl-dpaa2/eth: Defer probing if no DPIOs found
In-Reply-To: <20170606150041.10955-1-ruxandra.radulescu@nxp.com>
References: <20170606150041.10955-1-ruxandra.radulescu@nxp.com>
Message-ID: <20170606150041.10955-11-ruxandra.radulescu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the Ethernet driver doesn't find any DPIO devices during probe,
it may be either because there's none available or because they
haven't been probed yet. Request deferred probing in case it's
the latter.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index fd56fbd20087..025b5f6559a4 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -1510,6 +1510,7 @@ static int setup_dpio(struct dpaa2_eth_priv *priv)
 		if (!channel) {
 			dev_info(dev,
 				 "No affine channel for cpu %d and above\n", i);
+			err = -ENODEV;
 			goto err_alloc_ch;
 		}
 
@@ -1524,10 +1525,13 @@ static int setup_dpio(struct dpaa2_eth_priv *priv)
 		/* Register the new context */
 		err = dpaa2_io_service_register(NULL, nctx);
 		if (err) {
-			dev_info(dev, "No affine DPIO for cpu %d\n", i);
+			dev_dbg(dev, "No affine DPIO for cpu %d\n", i);
 			/* If no affine DPIO for this core, there's probably
-			 * none available for next cores either.
+			 * none available for next cores either. Signal we want
+			 * to retry later, in case the DPIO devices weren't
+			 * probed yet.
 			 */
+			err = -EPROBE_DEFER;
 			goto err_service_reg;
 		}
 
@@ -1565,7 +1569,7 @@ static int setup_dpio(struct dpaa2_eth_priv *priv)
 err_alloc_ch:
 	if (cpumask_empty(&priv->dpio_cpumask)) {
 		dev_err(dev, "No cpu with an affine DPIO/DPCON\n");
-		return -ENODEV;
+		return err;
 	}
 
 	dev_info(dev, "Cores %*pbl available for processing ingress traffic\n",
-- 
2.11.0
