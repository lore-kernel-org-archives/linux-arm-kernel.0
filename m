From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 16 Apr 2018 18:01:15 -0400
Subject: [PATCH 1/2] parisc: use the asm-generic version for writeX()
Message-ID: <1523916078-23049-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

parisc architecture seems to be mapping writeX() and writeX_relaxed() APIs
to __raw_writeX() API.

__raw_writeX() API doesn't provide any kind of ordering guarantees.
commit 755bd04aaf4b ("io: define stronger ordering for the default writeX()
implementation") changed asm-generic implementation to use a more
conservative approach towards the writeX() API.

Drop the arch specific version and rely on the asm-generic version for
parisc since parisc version doesn't seem to do anything special with these
macros.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 arch/parisc/include/asm/io.h | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
index afe493b..ef04864 100644
--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -194,41 +194,14 @@ static inline unsigned long long readq(const volatile void __iomem *addr)
 	return le64_to_cpu((__le64 __force) __raw_readq(addr));
 }
 
-static inline void writeb(unsigned char b, volatile void __iomem *addr)
-{
-	__raw_writeb(b, addr);
-}
-static inline void writew(unsigned short w, volatile void __iomem *addr)
-{
-	__raw_writew((__u16 __force) cpu_to_le16(w), addr);
-}
-static inline void writel(unsigned int l, volatile void __iomem *addr)
-{
-	__raw_writel((__u32 __force) cpu_to_le32(l), addr);
-}
-static inline void writeq(unsigned long long q, volatile void __iomem *addr)
-{
-	__raw_writeq((__u64 __force) cpu_to_le64(q), addr);
-}
-
 #define	readb	readb
 #define	readw	readw
 #define	readl	readl
 #define readq	readq
-#define writeb	writeb
-#define writew	writew
-#define writel	writel
-#define writeq	writeq
-
 #define readb_relaxed(addr)	readb(addr)
 #define readw_relaxed(addr)	readw(addr)
 #define readl_relaxed(addr)	readl(addr)
 #define readq_relaxed(addr)	readq(addr)
-#define writeb_relaxed(b, addr)	writeb(b, addr)
-#define writew_relaxed(w, addr)	writew(w, addr)
-#define writel_relaxed(l, addr)	writel(l, addr)
-#define writeq_relaxed(q, addr)	writeq(q, addr)
-
 #define mmiowb() do { } while (0)
 
 void memset_io(volatile void __iomem *addr, unsigned char val, int count);
-- 
2.7.4
