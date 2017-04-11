From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 11 Apr 2017 13:29:03 +0100
Subject: [PATCH v3 23/32] sh: include default ioremap_nopost() implementation
In-Reply-To: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170411122923.6285-24-lorenzo.pieralisi@arm.com>
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
Cc: Rich Felker <dalias@libc.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 3280a6b..23814cd 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -371,6 +371,7 @@ static inline int iounmap_fixed(void __iomem *addr) { return -EINVAL; }
 #define ioremap_nocache	ioremap
 #define ioremap_uc	ioremap
 #define iounmap		__iounmap
+#include <asm-generic/ioremap-nopost.h>
 
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
-- 
2.10.0
