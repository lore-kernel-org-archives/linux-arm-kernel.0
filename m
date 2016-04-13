From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 13 Apr 2016 18:13:00 +0100
Subject: [PATCH 4/7] io-64-nonatomic: Add relaxed accessor variants
In-Reply-To: <cover.1460391217.git.robin.murphy@arm.com>
References: <cover.1460391217.git.robin.murphy@arm.com>
Message-ID: <44173fd4e8efd27d670cadc6b30e215243a14099.1460391217.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Whilst commit 9439eb3ab9d1 ("asm-generic: io: implement relaxed
accessor macros as conditional wrappers") makes the *_relaxed forms of
I/O accessors universally available to drivers, in cases where writeq()
is implemented via the io-64-nonatomic helpers, writeq_relaxed() will
end up falling back to writel() regardless of whether writel_relaxed()
is available (identically for s/write/read/).

Add corresponding relaxed forms of the nonatomic helpers to delegate
to the equivalent 32-bit accessors as appropriate.

CC: Arnd Bergmann <arnd@arndb.de>
CC: Christoph Hellwig <hch@lst.de>
CC: Darren Hart <dvhart@linux.intel.com>
CC: Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 include/linux/io-64-nonatomic-hi-lo.h | 25 +++++++++++++++++++++++++
 include/linux/io-64-nonatomic-lo-hi.h | 25 +++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/linux/io-64-nonatomic-hi-lo.h b/include/linux/io-64-nonatomic-hi-lo.h
index 11d7e84..1a85566 100644
--- a/include/linux/io-64-nonatomic-hi-lo.h
+++ b/include/linux/io-64-nonatomic-hi-lo.h
@@ -21,6 +21,23 @@ static inline void hi_lo_writeq(__u64 val, volatile void __iomem *addr)
 	writel(val, addr);
 }
 
+static inline __u64 hi_lo_readq_relaxed(const volatile void __iomem *addr)
+{
+	const volatile u32 __iomem *p = addr;
+	u32 low, high;
+
+	high = readl_relaxed(p + 1);
+	low = readl_relaxed(p);
+
+	return low + ((u64)high << 32);
+}
+
+static inline void hi_lo_writeq_relaxed(__u64 val, volatile void __iomem *addr)
+{
+	writel_relaxed(val >> 32, addr + 4);
+	writel_relaxed(val, addr);
+}
+
 #ifndef readq
 #define readq hi_lo_readq
 #endif
@@ -29,4 +46,12 @@ static inline void hi_lo_writeq(__u64 val, volatile void __iomem *addr)
 #define writeq hi_lo_writeq
 #endif
 
+#ifndef readq_relaxed
+#define readq_relaxed hi_lo_readq_relaxed
+#endif
+
+#ifndef writeq_relaxed
+#define writeq hi_lo_writeq_relaxed
+#endif
+
 #endif	/* _LINUX_IO_64_NONATOMIC_HI_LO_H_ */
diff --git a/include/linux/io-64-nonatomic-lo-hi.h b/include/linux/io-64-nonatomic-lo-hi.h
index 1a4315f..1b7411d 100644
--- a/include/linux/io-64-nonatomic-lo-hi.h
+++ b/include/linux/io-64-nonatomic-lo-hi.h
@@ -21,6 +21,23 @@ static inline void lo_hi_writeq(__u64 val, volatile void __iomem *addr)
 	writel(val >> 32, addr + 4);
 }
 
+static inline __u64 lo_hi_readq_relaxed(const volatile void __iomem *addr)
+{
+	const volatile u32 __iomem *p = addr;
+	u32 low, high;
+
+	low = readl_relaxed(p);
+	high = readl_relaxed(p + 1);
+
+	return low + ((u64)high << 32);
+}
+
+static inline void lo_hi_writeq_relaxed(__u64 val, volatile void __iomem *addr)
+{
+	writel_relaxed(val, addr);
+	writel_relaxed(val >> 32, addr + 4);
+}
+
 #ifndef readq
 #define readq lo_hi_readq
 #endif
@@ -29,4 +46,12 @@ static inline void lo_hi_writeq(__u64 val, volatile void __iomem *addr)
 #define writeq lo_hi_writeq
 #endif
 
+#ifndef readq_relaxed
+#define readq_relaxed hi_lo_readq_relaxed
+#endif
+
+#ifndef writeq_relaxed
+#define writeq hi_lo_writeq_relaxed
+#endif
+
 #endif	/* _LINUX_IO_64_NONATOMIC_LO_HI_H_ */
-- 
2.7.3.dirty
