From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 16 Mar 2016 17:59:41 +0800
Subject: [PATCH 2/2] PCI: mvebu: use SET_NOIRQ_SYSTEM_SLEEP_PM_OPS for
 mvebu_pcie_pm_ops
In-Reply-To: <1458122381-2280-1-git-send-email-jszhang@marvell.com>
References: <1458122381-2280-1-git-send-email-jszhang@marvell.com>
Message-ID: <1458122381-2280-3-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

use SET_NOIRQ_SYSTEM_SLEEP_PM_OPS helper macro for mvebu_pcie_pm_ops.
The macro also setups freeze_noirq, thaw_noirq and poweroff_noirq,
restore_noirq accordingly.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/pci/host/pci-mvebu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 6c43cb8..6b451df 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -1003,6 +1003,7 @@ static void mvebu_pcie_msi_enable(struct mvebu_pcie *pcie)
 		pcie->msi->dev = &pcie->pdev->dev;
 }
 
+#ifdef CONFIG_PM_SLEEP
 static int mvebu_pcie_suspend(struct device *dev)
 {
 	struct mvebu_pcie *pcie;
@@ -1031,6 +1032,7 @@ static int mvebu_pcie_resume(struct device *dev)
 
 	return 0;
 }
+#endif
 
 static void mvebu_pcie_port_clk_put(void *data)
 {
@@ -1299,8 +1301,7 @@ static const struct of_device_id mvebu_pcie_of_match_table[] = {
 MODULE_DEVICE_TABLE(of, mvebu_pcie_of_match_table);
 
 static const struct dev_pm_ops mvebu_pcie_pm_ops = {
-	.suspend_noirq = mvebu_pcie_suspend,
-	.resume_noirq = mvebu_pcie_resume,
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mvebu_pcie_suspend, mvebu_pcie_resume)
 };
 
 static struct platform_driver mvebu_pcie_driver = {
-- 
2.7.0
