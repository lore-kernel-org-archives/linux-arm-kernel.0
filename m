From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Tue, 2 May 2017 10:59:26 +0100
Subject: [RFC PATCH 2/2] net: ixgbe: disable RO depending on the root port
 flags
In-Reply-To: <1493719166-9036-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1493719166-9036-1-git-send-email-gabriele.paoloni@huawei.com>
Message-ID: <1493719166-9036-3-git-send-email-gabriele.paoloni@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: gabriele paoloni <gabriele.paoloni@huawei.com>

Intel ixgbe drivers currently disable relaxed ordering at
compilation time depending on the host architecture. This is wrong
as RO support depends either on the root complex implementation
and/or on the EP itself and/or both.

This patch checks at runtime the root port flag
PCI_DEV_FLAGS_NO_RELAXED_ORDERING to be set in order to disable RO.

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 35 ++++++++++++++-----------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 094e1d6..597cb7b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -342,6 +342,8 @@ s32 ixgbe_start_hw_generic(struct ixgbe_hw *hw)
 s32 ixgbe_start_hw_gen2(struct ixgbe_hw *hw)
 {
 	u32 i;
+	struct pci_dev *root;
+	struct ixgbe_adapter *adapter;
 
 	/* Clear the rate limiters */
 	for (i = 0; i < hw->mac.max_tx_queues; i++) {
@@ -350,25 +352,28 @@ s32 ixgbe_start_hw_gen2(struct ixgbe_hw *hw)
 	}
 	IXGBE_WRITE_FLUSH(hw);
 
-#ifndef CONFIG_SPARC
-	/* Disable relaxed ordering */
-	for (i = 0; i < hw->mac.max_tx_queues; i++) {
-		u32 regval;
+	adapter = container_of(hw, struct ixgbe_adapter, hw);
+	root = pci_find_pcie_root_port(adapter->pdev);
 
-		regval = IXGBE_READ_REG(hw, IXGBE_DCA_TXCTRL_82599(i));
-		regval &= ~IXGBE_DCA_TXCTRL_DESC_WRO_EN;
-		IXGBE_WRITE_REG(hw, IXGBE_DCA_TXCTRL_82599(i), regval);
-	}
+	if (root && (root->dev_flags & PCI_DEV_FLAGS_NO_RELAXED_ORDERING)) {
+		/* Disable relaxed ordering */
+		for (i = 0; i < hw->mac.max_tx_queues; i++) {
+			u32 regval;
 
-	for (i = 0; i < hw->mac.max_rx_queues; i++) {
-		u32 regval;
+			regval = IXGBE_READ_REG(hw, IXGBE_DCA_TXCTRL_82599(i));
+			regval &= ~IXGBE_DCA_TXCTRL_DESC_WRO_EN;
+			IXGBE_WRITE_REG(hw, IXGBE_DCA_TXCTRL_82599(i), regval);
+		}
+
+		for (i = 0; i < hw->mac.max_rx_queues; i++) {
+			u32 regval;
 
-		regval = IXGBE_READ_REG(hw, IXGBE_DCA_RXCTRL(i));
-		regval &= ~(IXGBE_DCA_RXCTRL_DATA_WRO_EN |
-			    IXGBE_DCA_RXCTRL_HEAD_WRO_EN);
-		IXGBE_WRITE_REG(hw, IXGBE_DCA_RXCTRL(i), regval);
+			regval = IXGBE_READ_REG(hw, IXGBE_DCA_RXCTRL(i));
+			regval &= ~(IXGBE_DCA_RXCTRL_DATA_WRO_EN |
+					IXGBE_DCA_RXCTRL_HEAD_WRO_EN);
+			IXGBE_WRITE_REG(hw, IXGBE_DCA_RXCTRL(i), regval);
+		}
 	}
-#endif
 	return 0;
 }
 
-- 
2.7.4
