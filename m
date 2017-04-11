From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 11 Apr 2017 13:28:44 +0100
Subject: [PATCH v3 04/32] asm-generic: add ioremap_nopost() remap interface
In-Reply-To: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170411122923.6285-5-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PCI specifications (Rev 3.0, 3.2.5 "Transaction Ordering and
Posting") mandate non-posted configuration transactions. As further
highlighted in the PCIe specifications (4.0 - Rev0.3, "Ordering
Considerations for the Enhanced Configuration Access Mechanism"),
through ECAM and ECAM-derivative configuration mechanism, the memory
mapped transactions from the host CPU into Configuration Requests on the
PCI express fabric may create ordering problems for software because
writes to memory address are typically posted transactions (unless the
architecture can enforce through virtual address mapping non-posted
write transactions behaviour) but writes to Configuration Space are not
posted on the PCI express fabric.

Current DT and ACPI host bridge controllers map PCI configuration space
(ECAM and ECAM-derivative) into the virtual address space through
ioremap() calls, that are non-cacheable device accesses on most
architectures, but may provide "bufferable" or "posted" write semantics
in architecture like eg ARM/ARM64 that allow ioremap'ed regions writes
to be buffered in the bus connecting the host CPU to the PCI fabric;
this behaviour, as underlined in the PCIe specifications, may trigger
transactions ordering rules and must be prevented.

Introduce a new generic and explicit API to create a memory mapping for
ECAM and ECAM-derivative config space area (and a corresponding generic
asm-generic header file) that defaults to ioremap_nocache() (which
should provide a sane default behaviour) and can be included by
all architectures that do not require an arch specific memory mapping
for ioremap_nopost() to guarantee non-posted writes behaviour.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Luis R. Rodriguez <mcgrof@kernel.org>
---
 include/asm-generic/ioremap-nopost.h | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 include/asm-generic/ioremap-nopost.h

diff --git a/include/asm-generic/ioremap-nopost.h b/include/asm-generic/ioremap-nopost.h
new file mode 100644
index 0000000..015911f
--- /dev/null
+++ b/include/asm-generic/ioremap-nopost.h
@@ -0,0 +1,9 @@
+#ifndef __ASM_GENERIC_IOREMAP_NOPOST_H
+#define __ASM_GENERIC_IOREMAP_NOPOST_H
+
+static inline void __iomem *ioremap_nopost(phys_addr_t offset, size_t size)
+{
+	return ioremap_nocache(offset, size);
+}
+
+#endif /* __ASM_GENERIC_IOREMAP_NOPOST_H */
-- 
2.10.0
