From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Nov 2015 17:08:33 +0100
Subject: [PATCH] PCI: iproc: hide CONFIG_PCIE_IPROC
Message-ID: <11420214.lrdhuUq0ZO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCIE_IPROC_BCMA does not require CONFIG_OF in Kconfig, but
CONFIG_PCIE_IPROC does, so we can get a warning when building
for an ARM platform without DT support:

warning: (PCIE_IPROC_PLATFORM && PCIE_IPROC_BCMA) selects PCIE_IPROC which has unmet direct dependencies (PCI && OF && (ARM || ARM64))

It turns out that CONFIG_PCIE_IPROC never needs to be enabled
by a user anyway, we can simply rely on it being selected
implictly through either PCIE_IPROC_PLATFORM or PCIE_IPROC_BCMA.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 4785ffbdc9b5 ("PCI: iproc: Add BCMA PCIe driver")

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index f131ba947dc6..767605a5c659 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -118,13 +118,11 @@ config PCI_VERSATILE
 	depends on ARCH_VERSATILE
 
 config PCIE_IPROC
-	tristate "Broadcom iProc PCIe controller"
-	depends on OF && (ARM || ARM64)
-	default n
+	tristate
 	help
 	  This enables the iProc PCIe core controller support for Broadcom's
-	  iProc family of SoCs. An appropriate bus interface driver also needs
-	  to be enabled
+	  iProc family of SoCs. An appropriate bus interface driver needs
+	  to be enabled to select this.
 
 config PCIE_IPROC_PLATFORM
 	tristate "Broadcom iProc PCIe platform bus driver"
