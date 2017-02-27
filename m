From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 27 Feb 2017 15:14:16 +0000
Subject: [PATCH 05/20] ARM: implement pci_remap_cfgspace() interface
In-Reply-To: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170227151436.18698-6-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PCI bus specifications (rev 3.0, 3.2.5 "Transaction Ordering
and Posting") define rules for PCI configuration space transactions
ordering and posting, that state that configuration writes have to
be non-posted transactions.

Current ioremap interface on ARM provides mapping functions that
provide "bufferable" writes transactions (ie ioremap uses MT_DEVICE
memory type) aka posted writes, so PCI host controller drivers have
no arch interface to remap PCI configuration space with memory
attributes that comply with the PCI specifications for configuration
space.

Implement an ARM specific pci_remap_cfgspace() interface that allows to
map PCI config memory regions with MT_UNCACHED memory type (ie strongly
ordered - non-posted writes), providing a remap function that complies
with PCI specifications for config space transactions.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
---
 arch/arm/include/asm/io.h | 10 ++++++++++
 arch/arm/mm/ioremap.c     |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 42871fb..74d1b09 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -187,6 +187,16 @@ static inline void pci_ioremap_set_mem_type(int mem_type) {}
 extern int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr);
 
 /*
+ * PCI configuration space mapping function.
+ *
+ * PCI specifications does not allow configuration write
+ * transactions to be posted. Add an arch specific
+ * pci_remap_cfgspace definition that is implemented
+ * through strongly ordered memory mappings.
+ */
+#define pci_remap_cfgspace pci_remap_cfgspace
+void __iomem *pci_remap_cfgspace(resource_size_t res_cookie, size_t size);
+/*
  * Now, pick up the machine-defined IO definitions
  */
 #ifdef CONFIG_NEED_MACH_IO_H
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index ff0eed2..fc91205 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -481,6 +481,13 @@ int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr)
 				  __pgprot(get_mem_type(pci_ioremap_mem_type)->prot_pte));
 }
 EXPORT_SYMBOL_GPL(pci_ioremap_io);
+
+void __iomem *pci_remap_cfgspace(resource_size_t res_cookie, size_t size)
+{
+	return arch_ioremap_caller(res_cookie, size, MT_UNCACHED,
+				   __builtin_return_address(0));
+}
+EXPORT_SYMBOL_GPL(pci_remap_cfgspace);
 #endif
 
 /*
-- 
2.10.0
