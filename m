From: horia.geanta@freescale.com (=?UTF-8?q?Horia=20Geant=C4=83?=)
Date: Wed, 12 Aug 2015 17:12:39 +0300
Subject: [PATCH v2] arm64: add ioread64be and iowrite64be macros
In-Reply-To: <20150812134526.GD23540@arm.com>
References: <20150812134526.GD23540@arm.com>
Message-ID: <1439388759-4299-1-git-send-email-horia.geanta@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will allow device drivers to consistently use io{read,write}XXbe
macros in all cases.

Signed-off-by: Alex Porosanu <alexandru.porosanu@freescale.com>
Signed-off-by: Horia Geant? <horia.geanta@freescale.com>
---

I am planning to use the macros in a subsequent patch that revamps
the I/O accessors in drivers/crypto/caam/regs.h

Let me know if you prefer having this change submitted as part of a
patchset (bundled with the caller/user of the macros).

 arch/arm64/include/asm/io.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 44be1e03ed65..9b6e408cfa51 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -174,13 +174,15 @@ extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
 #define iounmap				__iounmap
 
 /*
- * io{read,write}{16,32}be() macros
+ * io{read,write}{16,32,64}be() macros
  */
 #define ioread16be(p)		({ __u16 __v = be16_to_cpu((__force __be16)__raw_readw(p)); __iormb(); __v; })
 #define ioread32be(p)		({ __u32 __v = be32_to_cpu((__force __be32)__raw_readl(p)); __iormb(); __v; })
+#define ioread64be(p)		({ __u64 __v = be64_to_cpu((__force __be64)__raw_readq(p)); __iormb(); __v; })
 
 #define iowrite16be(v,p)	({ __iowmb(); __raw_writew((__force __u16)cpu_to_be16(v), p); })
 #define iowrite32be(v,p)	({ __iowmb(); __raw_writel((__force __u32)cpu_to_be32(v), p); })
+#define iowrite64be(v,p)	({ __iowmb(); __raw_writeq((__force __u64)cpu_to_be64(v), p); })
 
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
-- 
2.4.4
