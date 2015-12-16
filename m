From: tn@semihalf.com (Tomasz Nowicki)
Date: Wed, 16 Dec 2015 16:16:33 +0100
Subject: [PATCH V2 23/23] arm64, pci,
 acpi: Start using ACPI based PCI host bridge driver for ARM64.
In-Reply-To: <1450278993-12664-1-git-send-email-tn@semihalf.com>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
Message-ID: <1450278993-12664-24-git-send-email-tn@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lets get rid of empty PCI init stub, related ACPI header and
go with full-blown PCI host bridge driver.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Liviu Dudau <Liviu.Dudau@arm.com>
CC: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
CC: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig      |  4 ++++
 arch/arm64/kernel/pci.c | 10 ----------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index d65d315..71032ed 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -86,6 +86,7 @@ config ARM64
 	select OF_EARLY_FLATTREE
 	select OF_RESERVED_MEM
 	select PERF_USE_VMALLOC
+	select PCI_HOST_GENERIC_ACPI if ACPI
 	select POWER_RESET
 	select POWER_SUPPLY
 	select RTC_LIB
@@ -213,6 +214,9 @@ config PCI_MMCONFIG
 	select PCI_ECAM
 	depends on ACPI
 
+config ARCH_PCI_HOST_GENERIC_ACPI
+	def_bool ACPI
+
 endmenu
 
 menu "Kernel Features"
diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index f7948f5..e9cf58b 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -10,7 +10,6 @@
  *
  */
 
-#include <linux/acpi.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -50,12 +49,3 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 
 	return pci_enable_resources(dev, mask);
 }
-
-#ifdef CONFIG_ACPI
-/* Root bridge scanning */
-struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
-{
-	/* TODO: Should be revisited when implementing PCI on ACPI */
-	return NULL;
-}
-#endif
-- 
1.9.1
