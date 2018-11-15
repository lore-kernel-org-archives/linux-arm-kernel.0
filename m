From: yinbo.zhu@nxp.com (Yinbo Zhu)
Date: Thu, 15 Nov 2018 17:23:57 +0800
Subject: [PATCH v1] arch: arm64: add ARM64 specific fucntions required for
 ehci fsl driver
Message-ID: <20181115092357.1556-1-yinbo.zhu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajesh Bhagat <rajesh.bhagat@nxp.com>

Add set/clear bits functions for ARM platform which are used by ehci fsl
driver

Signed-off-by: Rajesh Bhagat <rajesh.bhagat@nxp.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 arch/arm64/include/asm/io.h |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index e97b861..0dc4334 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -185,6 +185,35 @@ extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
 #define iowrite32be(v,p)	({ __iowmb(); __raw_writel((__force __u32)cpu_to_be32(v), p); })
 #define iowrite64be(v,p)	({ __iowmb(); __raw_writeq((__force __u64)cpu_to_be64(v), p); })
 
+/* access ports */
+#define setbits32(_addr, _v) iowrite32be(ioread32be(_addr) |  (_v), (_addr))
+#define clrbits32(_addr, _v) iowrite32be(ioread32be(_addr) & ~(_v), (_addr))
+
+#define setbits16(_addr, _v) iowrite16be(ioread16be(_addr) |  (_v), (_addr))
+#define clrbits16(_addr, _v) iowrite16be(ioread16be(_addr) & ~(_v), (_addr))
+
+#define setbits8(_addr, _v) iowrite8(ioread8(_addr) |  (_v), (_addr))
+#define clrbits8(_addr, _v) iowrite8(ioread8(_addr) & ~(_v), (_addr))
+
+/* Clear and set bits in one shot.  These macros can be used to clear and
+ * set multiple bits in a register using a single read-modify-write.  These
+ * macros can also be used to set a multiple-bit bit pattern using a mask,
+ * by specifying the mask in the 'clear' parameter and the new bit pattern
+ * in the 'set' parameter.
+ */
+
+#define clrsetbits_be32(addr, clear, set) \
+	iowrite32be((ioread32be(addr) & ~(clear)) | (set), (addr))
+#define clrsetbits_le32(addr, clear, set) \
+	iowrite32le((ioread32le(addr) & ~(clear)) | (set), (addr))
+#define clrsetbits_be16(addr, clear, set) \
+	iowrite16be((ioread16be(addr) & ~(clear)) | (set), (addr))
+#define clrsetbits_le16(addr, clear, set) \
+	iowrite16le((ioread16le(addr) & ~(clear)) | (set), (addr))
+#define clrsetbits_8(addr, clear, set) \
+	iowrite8((ioread8(addr) & ~(clear)) | (set), (addr))
+
+
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
-- 
1.7.1
