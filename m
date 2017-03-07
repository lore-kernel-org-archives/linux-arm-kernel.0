From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  7 Mar 2017 16:53:19 +0100
Subject: [PATCHv3 net-next 21/22] net: mvpp2: set dma mask and coherent dma
 mask on PPv2.2
In-Reply-To: <1488902000-2658-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1488902000-2658-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1488902000-2658-22-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On PPv2.2, the streaming mappings can be anywhere in the first 40 bits
of the physical address space. However, for the coherent mappings, we
still need them to be in the first 32 bits of the address space,
because all BM pools share a single register to store the high 32 bits
of the BM pool address, which means all BM pools must be allocated in
the same 4GB memory area.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 0a3c470..92c47f3 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -6941,6 +6941,20 @@ static int mvpp2_probe(struct platform_device *pdev)
 	/* Get system's tclk rate */
 	priv->tclk = clk_get_rate(priv->pp_clk);
 
+	if (priv->hw_version == MVPP22) {
+		err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(40));
+		if (err)
+			goto err_mg_clk;
+		/* Sadly, the BM pools all share the same register to
+		 * store the high 32 bits of their address. So they
+		 * must all have the same high 32 bits, which forces
+		 * us to restrict coherent memory to DMA_BIT_MASK(32).
+		 */
+		err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
+		if (err)
+			goto err_mg_clk;
+	}
+
 	/* Initialize network controller */
 	err = mvpp2_init(pdev, priv);
 	if (err < 0) {
-- 
2.7.4
