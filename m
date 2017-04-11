From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 11 Apr 2017 13:28:54 +0100
Subject: [PATCH v3 14/32] metag: include default ioremap_nopost()
 implementation
In-Reply-To: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170411122923.6285-15-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PCI specifications (Rev 3.0, 3.2.5 "Transaction Ordering and Posting")
mandate non-posted configuration transactions. As further highlighted in
the PCIe specifications (4.0 - Rev0.3, "Ordering Considerations for the
Enhanced Configuration Access Mechanism"), through ECAM and
ECAM-derivative configuration mechanism, the memory mapped transactions
from the host CPU into Configuration Requests on the PCI express fabric
may create ordering problems for software because writes to memory
address are typically posted transactions (unless the architecture can
enforce through virtual address mapping non-posted write transactions
behaviour) but writes to Configuration Space are not posted on the PCI
express fabric.

Include the asm-generic ioremap_nopost() implementation (currently
falling back to ioremap_nocache()) to provide a non-posted writes
ioremap interface to kernel subsystems.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: James Hogan <james.hogan@imgtec.com>
---
 arch/metag/include/asm/io.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/metag/include/asm/io.h b/arch/metag/include/asm/io.h
index 9890f21..c805e0d 100644
--- a/arch/metag/include/asm/io.h
+++ b/arch/metag/include/asm/io.h
@@ -166,4 +166,6 @@ extern void __iounmap(void __iomem *addr);
 #define iounmap(addr)                           \
 	__iounmap(addr)
 
+#include <asm-generic/ioremap-nopost.h>
+
 #endif  /* _ASM_METAG_IO_H */
-- 
2.10.0
