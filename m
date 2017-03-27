From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 27 Mar 2017 10:49:33 +0100
Subject: [PATCH v2 05/22] ARM64: implement ioremap_nopost() interface
In-Reply-To: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
References: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170327094954.7162-6-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PCI bus specifications (rev 3.0, 3.2.5 "Transaction Ordering
and Posting") defines rules for PCI configuration space transactions
ordering and posting, that state that configuration writes
are non-posted transactions.

This rule is reinforced by the ARM v8 architecture reference manual
(issue A.k, Early Write Acknowledgment) that explicitly recommends
that No Early Write Acknowledgment attribute should be used to map
PCI configuration (write) transactions.

Current ioremap interface on ARM64 implements mapping functions
where the Early Write Acknowledgment hint is enabled, so they
cannot be used to map PCI configuration space in a PCI specs
compliant way.

Implement an ARM64 specific ioremap_nopost() interface
that allows to map PCI config region with nGnRnE attributes, providing
a remap function that complies with PCI specifications and the ARMv8
architecture reference manual recommendations.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/io.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 0c00c87..1a703e5 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -173,6 +173,18 @@ extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
 #define iounmap				__iounmap
 
 /*
+ * ioremap implementation providing non-posted writes (ie v8 no Early
+ * Write Acknowledgment) semantics.
+ *
+ * PCI specifications disallows posted write configuration transactions.
+ * Add an arch specific ioremap_post definition that is implemented
+ * through nGnRnE device memory attribute as recommended by the ARM v8
+ * Architecture reference manual Issue A.k B2.8.2 "Device memory" so
+ * that it can be used to map PCI config space memory areas.
+ */
+#define ioremap_nopost(addr, size) __ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRnE))
+
+/*
  * io{read,write}{16,32,64}be() macros
  */
 #define ioread16be(p)		({ __u16 __v = be16_to_cpu((__force __be16)__raw_readw(p)); __iormb(); __v; })
-- 
2.10.0
