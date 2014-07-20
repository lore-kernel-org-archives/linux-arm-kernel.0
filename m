From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 20 Jul 2014 17:29:47 +0530
Subject: [PATCH 1/2] PCI: spear: Fix Section mismatch compilation warning for
 probe()
Message-ID: <76576b662613369d0c71db30ceed4ed5ae1343d2.1405857442.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following compilation warning occurs when compiled with:
CONFIG_DEBUG_SECTION_MISMATCH=y

 WARNING: drivers/pci/host/built-in.o(.data+0xc0): Section mismatch in
 reference from the variable spear13xx_pcie_driver to the function
 .init.text:spear13xx_pcie_probe()

Both .probe() and pcie_init() are marked with __init, but spear13xx_pcie_driver
isn't. And so section mismatch.

Fix it by marking spear13xx_pcie_driver with __initdata.

Fixes: 51b66a6 (PCI: spear: Add PCIe driver for ST Microelectronics SPEAr13xx)
Reported-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Olof/Arnd,

Let me know if a PULL request is required for this, otherwise just apply them
directly.

 drivers/pci/host/pcie-spear13xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index 99738e4..67315ea 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -382,7 +382,7 @@ static const struct of_device_id spear13xx_pcie_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, spear13xx_pcie_of_match);
 
-static struct platform_driver spear13xx_pcie_driver = {
+static struct platform_driver spear13xx_pcie_driver __initdata = {
 	.probe		= spear13xx_pcie_probe,
 	.remove		= spear13xx_pcie_remove,
 	.driver = {
-- 
2.0.0.rc2
