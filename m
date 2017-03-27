From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 27 Mar 2017 10:49:31 +0100
Subject: [PATCH v2 03/22] asm-generic/pgtable.h: introduce pgprot_nonposted
 remap attribute
In-Reply-To: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
References: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170327094954.7162-4-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the PCI local bus specifications (Revision 3.0, 3.2.5),
I/O Address space transactions are non-posted. On architectures where
I/O space is implemented through a chunk of memory mapped space mapped
to PCI address space (ie IA64/ARM/ARM64) the memory mapping for the
region backing I/O Address Space transactions determines the I/O
transactions attributes (before the transactions actually reaches the
PCI bus where it is handled according to the PCI specifications).

The kernel lacks a pgprot_* attribute to map memory with type
generating non-posted writes transactions, which therefore needs to
be added.

Add a pgprot_nonposted mapping prot to create a memory mapping for
memory areas requiring non-posted write transactions; make it default to
pgprot_noncached (which should provide a sane default behaviour) but
still allowing architectures on which pgprot_noncached results in posted
write transactions to override the prot with an arch specific
implementation that guarantees non-posted writes transactions.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 include/asm-generic/pgtable.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 1fad160..2070172 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -399,6 +399,10 @@ static inline int pud_same(pud_t pud_a, pud_t pud_b)
 #define pgprot_device pgprot_noncached
 #endif
 
+#ifndef pgprot_nonposted
+#define pgprot_nonposted pgprot_noncached
+#endif
+
 #ifndef pgprot_modify
 #define pgprot_modify pgprot_modify
 static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
-- 
2.10.0
