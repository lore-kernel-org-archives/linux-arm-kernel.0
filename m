From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 20 Jul 2014 17:29:48 +0530
Subject: [PATCH 2/2] PCI: spear: Remove spear13xx_pcie_remove()
In-Reply-To: <76576b662613369d0c71db30ceed4ed5ae1343d2.1405857442.git.viresh.kumar@linaro.org>
References: <76576b662613369d0c71db30ceed4ed5ae1343d2.1405857442.git.viresh.kumar@linaro.org>
Message-ID: <ac63cf4f32023ef5b8efc5a139abae3d8a5c6607.1405857442.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following compilation warning occurs when compiled with:
CONFIG_DEBUG_SECTION_MISMATCH=y

 WARNING: vmlinux.o(.init.data+0x3338): Section mismatch in reference from the
 variable spear13xx_pcie_driver to the function
 .exit.text:spear13xx_pcie_remove()

This driver isn't allowed to unload, and so doesn't have a *_exit() routine. But
it still has spear13xx_pcie_remove() marked with __exit.

As this driver can't unload, .remove() would never be called, right? So get rid
of it.

Fixes: 51b66a6 (PCI: spear: Add PCIe driver for ST Microelectronics SPEAr13xx)
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/pci/host/pcie-spear13xx.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index 67315ea..6dea9e4 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -365,17 +365,6 @@ static int __init spear13xx_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __exit spear13xx_pcie_remove(struct platform_device *pdev)
-{
-	struct spear13xx_pcie *spear13xx_pcie = platform_get_drvdata(pdev);
-
-	clk_disable_unprepare(spear13xx_pcie->clk);
-
-	phy_exit(spear13xx_pcie->phy);
-
-	return 0;
-}
-
 static const struct of_device_id spear13xx_pcie_of_match[] = {
 	{ .compatible = "st,spear1340-pcie", },
 	{},
@@ -384,7 +373,6 @@ MODULE_DEVICE_TABLE(of, spear13xx_pcie_of_match);
 
 static struct platform_driver spear13xx_pcie_driver __initdata = {
 	.probe		= spear13xx_pcie_probe,
-	.remove		= spear13xx_pcie_remove,
 	.driver = {
 		.name	= "spear-pcie",
 		.owner	= THIS_MODULE,
-- 
2.0.0.rc2
