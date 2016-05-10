From: tn@semihalf.com (Tomasz Nowicki)
Date: Tue, 10 May 2016 17:20:01 +0200
Subject: [PATCH V7 11/11] arm64, pci,
 acpi: Start using ACPI based PCI host controller driver for ARM64.
In-Reply-To: <1462893601-8937-1-git-send-email-tn@semihalf.com>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
Message-ID: <1462893601-8937-12-git-send-email-tn@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is perfectly fine to use ACPI_PCI_HOST_GENERIC for ARM64,
so lets get rid of PCI init and RAW ACPI accessor empty stubs
and go with full-blown PCI host controller driver.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
To: Catalin Marinas <catalin.marinas@arm.com>
To: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
To: Will Deacon <will.deacon@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/Kconfig      |  1 +
 arch/arm64/kernel/pci.c | 24 ------------------------
 2 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4f43622..1bded87 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2,6 +2,7 @@ config ARM64
 	def_bool y
 	select ACPI_CCA_REQUIRED if ACPI
 	select ACPI_GENERIC_GSI if ACPI
+	select ACPI_PCI_HOST_GENERIC if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index eeec5f6..e484c91 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -74,27 +74,3 @@ void pcibios_remove_bus(struct pci_bus *bus)
 {
 	acpi_pci_remove_bus(bus);
 }
-
-/*
- * raw_pci_read/write - Platform-specific PCI config space access.
- */
-int raw_pci_read(unsigned int domain, unsigned int bus,
-		  unsigned int devfn, int reg, int len, u32 *val)
-{
-	return -ENXIO;
-}
-
-int raw_pci_write(unsigned int domain, unsigned int bus,
-		unsigned int devfn, int reg, int len, u32 val)
-{
-	return -ENXIO;
-}
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
