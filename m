From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Wed, 26 Sep 2018 16:22:37 +0300
Subject: [PATCH v2 12/22] dpaa_eth: base dma mappings on the fman rx port
In-Reply-To: <20180926132247.10971-1-laurentiu.tudor@nxp.com>
References: <20180926132247.10971-1-laurentiu.tudor@nxp.com>
Message-ID: <20180926132247.10971-13-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

The dma transactions initiator is the rx fman port so that's the device
that the dma mappings should be done. Previously the mappings were done
through the MAC device which makes no sense because it's neither dma-able
nor connected in any way to smmu.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 6ca3fdbef580..ac9e50c8a556 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2796,8 +2796,15 @@ static int dpaa_eth_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	mac_dev = dpaa_mac_dev_get(pdev);
+	if (IS_ERR(mac_dev)) {
+		dev_err(&pdev->dev, "dpaa_mac_dev_get() failed\n");
+		err = PTR_ERR(mac_dev);
+		goto probe_err;
+	}
+
 	/* device used for DMA mapping */
-	dev = pdev->dev.parent;
+	dev = fman_port_get_device(mac_dev->port[RX]);
 	err = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(40));
 	if (err) {
 		dev_err(dev, "dma_coerce_mask_and_coherent() failed\n");
@@ -2822,13 +2829,6 @@ static int dpaa_eth_probe(struct platform_device *pdev)
 
 	priv->msg_enable = netif_msg_init(debug, DPAA_MSG_DEFAULT);
 
-	mac_dev = dpaa_mac_dev_get(pdev);
-	if (IS_ERR(mac_dev)) {
-		dev_err(dev, "dpaa_mac_dev_get() failed\n");
-		err = PTR_ERR(mac_dev);
-		goto free_netdev;
-	}
-
 	/* If fsl_fm_max_frm is set to a higher value than the all-common 1500,
 	 * we choose conservatively and let the user explicitly set a higher
 	 * MTU via ifconfig. Otherwise, the user may end up with different MTUs
@@ -2964,9 +2964,9 @@ static int dpaa_eth_probe(struct platform_device *pdev)
 	qman_release_cgrid(priv->cgr_data.cgr.cgrid);
 free_dpaa_bps:
 	dpaa_bps_free(priv);
-free_netdev:
 	dev_set_drvdata(dev, NULL);
 	free_netdev(net_dev);
+probe_err:
 
 	return err;
 }
-- 
2.17.1
