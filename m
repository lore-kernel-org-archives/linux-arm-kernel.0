From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 12 Feb 2014 16:55:46 +0100
Subject: [PATCH 12/14] net: axienet: Use of_property_* calls
In-Reply-To: <cover.1392220536.git.michal.simek@xilinx.com>
References: <cover.1392220536.git.michal.simek@xilinx.com>
Message-ID: <77b9c5c033a54916c3e5be6f67dbd59c0155bc4c.1392220536.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srikanth Thokala <srikanth.thokala@xilinx.com>

Use of_property_* calls

Signed-off-by: Srikanth Thokala <sthokal@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 41 ++++++++++-------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 936a14c..9a9ffbc 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1493,13 +1493,13 @@ static void axienet_dma_err_handler(unsigned long data)
  */
 static int axienet_of_probe(struct platform_device *pdev)
 {
-	__be32 *p;
-	int size, ret = 0;
+	int ret;
 	struct device_node *np;
 	struct axienet_local *lp;
 	struct net_device *ndev;
-	const void *addr;
+	u8 mac_addr[6];
 	struct resource *ethres, dmares;
+	u32 value;

 	ndev = alloc_etherdev(sizeof(*lp));
 	if (!ndev)
@@ -1530,9 +1530,9 @@ static int axienet_of_probe(struct platform_device *pdev)
 	/* Setup checksum offload, but default to off if not specified */
 	lp->features = 0;

-	p = (__be32 *) of_get_property(pdev->dev.of_node, "xlnx,txcsum", NULL);
-	if (p) {
-		switch (be32_to_cpup(p)) {
+	ret = of_property_read_u32(pdev->dev.of_node, "xlnx,txcsum", &value);
+	if (!ret) {
+		switch (value) {
 		case 1:
 			lp->csum_offload_on_tx_path =
 				XAE_FEATURE_PARTIAL_TX_CSUM;
@@ -1551,9 +1551,9 @@ static int axienet_of_probe(struct platform_device *pdev)
 			lp->csum_offload_on_tx_path = XAE_NO_CSUM_OFFLOAD;
 		}
 	}
-	p = (__be32 *) of_get_property(pdev->dev.of_node, "xlnx,rxcsum", NULL);
-	if (p) {
-		switch (be32_to_cpup(p)) {
+	ret = of_property_read_u32(pdev->dev.of_node, "xlnx,rxcsum", &value);
+	if (!ret) {
+		switch (value) {
 		case 1:
 			lp->csum_offload_on_rx_path =
 				XAE_FEATURE_PARTIAL_RX_CSUM;
@@ -1574,17 +1574,10 @@ static int axienet_of_probe(struct platform_device *pdev)
 	 * Here we check for memory allocated for Rx/Tx in the hardware from
 	 * the device-tree and accordingly set flags.
 	 */
-	p = (__be32 *) of_get_property(pdev->dev.of_node, "xlnx,rxmem", NULL);
-	if (p)
-		lp->rxmem = be32_to_cpup(p);
-	p = (__be32 *) of_get_property(pdev->dev.of_node, "xlnx,temac-type",
-				       NULL);
-	if (p)
-		lp->temac_type = be32_to_cpup(p);
-	p = (__be32 *) of_get_property(pdev->dev.of_node,
-						"xlnx,phy-type", NULL);
-	if (p)
-		lp->phy_type = be32_to_cpup(p);
+	of_property_read_u32(pdev->dev.of_node, "xlnx,rxmem", &lp->rxmem);
+	of_property_read_u32(pdev->dev.of_node, "xlnx,temac-type",
+					&lp->temac_type);
+	of_property_read_u32(pdev->dev.of_node, "xlnx,phy-type", &lp->phy_type);

 	/* Find the DMA node, map the DMA registers, and decode the DMA IRQs */
 	np = of_parse_phandle(pdev->dev.of_node, "axistream-connected", 0);
@@ -1614,13 +1607,13 @@ static int axienet_of_probe(struct platform_device *pdev)
 	}

 	/* Retrieve the MAC address */
-	addr = of_get_property(pdev->dev.of_node, "local-mac-address", &size);
-	if ((!addr) || (size != 6)) {
+	ret = of_property_read_u8_array(pdev->dev.of_node,
+			"local-mac-address", mac_addr, 6);
+	if (ret) {
 		dev_err(&pdev->dev, "could not find MAC address\n");
-		ret = -ENODEV;
 		goto free_netdev;
 	}
-	axienet_set_mac_address(ndev, (void *) addr);
+	axienet_set_mac_address(ndev, (void *) mac_addr);

 	lp->coalesce_count_rx = XAXIDMA_DFT_RX_THRESHOLD;
 	lp->coalesce_count_tx = XAXIDMA_DFT_TX_THRESHOLD;
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140212/53eca111/attachment.sig>
