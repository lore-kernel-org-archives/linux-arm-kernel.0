From: himanshujha199640@gmail.com (Himanshu Jha)
Date: Sat, 30 Dec 2017 21:14:57 +0530
Subject: [PATCH] ethernet/broadcom: Use zeroing memory allocator than
 allocator/memset
Message-ID: <1514648697-7148-1-git-send-email-himanshujha199640@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use dma_zalloc_coherent for allocating zeroed
memory and remove unnecessary memset function.

Done using Coccinelle.
Generated-by: scripts/coccinelle/api/alloc/kzalloc-simple.cocci
0-day tested with no failures.

Suggested-by: Luis R. Rodriguez <mcgrof@kernel.org>
Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/net/ethernet/broadcom/bcm63xx_enet.c  | 6 ++----
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c | 5 ++---
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index 1fbbbab..14a59e5 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -2128,27 +2128,25 @@ static int bcm_enetsw_open(struct net_device *dev)
 
 	/* allocate rx dma ring */
 	size = priv->rx_ring_size * sizeof(struct bcm_enet_desc);
-	p = dma_alloc_coherent(kdev, size, &priv->rx_desc_dma, GFP_KERNEL);
+	p = dma_zalloc_coherent(kdev, size, &priv->rx_desc_dma, GFP_KERNEL);
 	if (!p) {
 		dev_err(kdev, "cannot allocate rx ring %u\n", size);
 		ret = -ENOMEM;
 		goto out_freeirq_tx;
 	}
 
-	memset(p, 0, size);
 	priv->rx_desc_alloc_size = size;
 	priv->rx_desc_cpu = p;
 
 	/* allocate tx dma ring */
 	size = priv->tx_ring_size * sizeof(struct bcm_enet_desc);
-	p = dma_alloc_coherent(kdev, size, &priv->tx_desc_dma, GFP_KERNEL);
+	p = dma_zalloc_coherent(kdev, size, &priv->tx_desc_dma, GFP_KERNEL);
 	if (!p) {
 		dev_err(kdev, "cannot allocate tx ring\n");
 		ret = -ENOMEM;
 		goto out_free_rx_ring;
 	}
 
-	memset(p, 0, size);
 	priv->tx_desc_alloc_size = size;
 	priv->tx_desc_cpu = p;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
index fed37cd..3c746f2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
@@ -278,12 +278,11 @@ static int bnxt_hwrm_set_dcbx_app(struct bnxt *bp, struct dcb_app *app,
 
 	n = IEEE_8021QAZ_MAX_TCS;
 	data_len = sizeof(*data) + sizeof(*fw_app) * n;
-	data = dma_alloc_coherent(&bp->pdev->dev, data_len, &mapping,
-				  GFP_KERNEL);
+	data = dma_zalloc_coherent(&bp->pdev->dev, data_len, &mapping,
+				   GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	memset(data, 0, data_len);
 	bnxt_hwrm_cmd_hdr_init(bp, &get, HWRM_FW_GET_STRUCTURED_DATA, -1, -1);
 	get.dest_data_addr = cpu_to_le64(mapping);
 	get.structure_id = cpu_to_le16(STRUCT_HDR_STRUCT_ID_DCBX_APP);
-- 
2.7.4
