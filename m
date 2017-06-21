From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Jun 2017 23:53:00 +0200
Subject: [PATCH 2/4] ARM/PCI: mv78xx0: pass pci_ops correctly again
In-Reply-To: <20170621215323.3921382-1-arnd@arndb.de>
References: <20170621215323.3921382-1-arnd@arndb.de>
Message-ID: <20170621215323.3921382-2-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We used to pass the operations when calling pci_scan_root_bus, but
that argument was removed:

arch/arm/mach-mv78xx0/pcie.c:175:23: error: 'pcie_ops' defined but not used [-Werror=unused-variable]

Setting it in pci_hw should address this.

Fixes: ace27646da8e ("ARM/PCI: Convert PCI scan API to pci_scan_root_bus_bridge()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-mv78xx0/pcie.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
index 2b406e909a43..cb7f95c9d8eb 100644
--- a/arch/arm/mach-mv78xx0/pcie.c
+++ b/arch/arm/mach-mv78xx0/pcie.c
@@ -214,6 +214,7 @@ static int __init mv78xx0_pcie_map_irq(const struct pci_dev *dev, u8 slot,
 }
 
 static struct hw_pci mv78xx0_pci __initdata = {
+	.ops		= &pcie_ops,
 	.nr_controllers	= 8,
 	.preinit	= mv78xx0_pcie_preinit,
 	.setup		= mv78xx0_pcie_setup,
-- 
2.9.0
