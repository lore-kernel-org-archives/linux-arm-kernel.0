From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 17 Apr 2018 00:08:50 -0400
Subject: [PATCH v2 1/2] parisc: define stronger ordering for the default
 writeX()
Message-ID: <1523938133-3224-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

parisc architecture seems to be mapping writeX() and writeX_relaxed() APIs
to __raw_writeX() API.

__raw_writeX() API doesn't provide any kind of ordering guarantees.
commit 755bd04aaf4b ("io: define stronger ordering for the default writeX()
implementation") changed asm-generic implementation to use a more
conservative approach towards the writeX() API.

Place a barrier() before the register write so that compiler doesn't
optimize across the regiter operation.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 arch/parisc/include/asm/io.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
index afe493b..2ec6405 100644
--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -196,18 +196,22 @@ static inline unsigned long long readq(const volatile void __iomem *addr)
 
 static inline void writeb(unsigned char b, volatile void __iomem *addr)
 {
+	barrier();
 	__raw_writeb(b, addr);
 }
 static inline void writew(unsigned short w, volatile void __iomem *addr)
 {
+	barrier();
 	__raw_writew((__u16 __force) cpu_to_le16(w), addr);
 }
 static inline void writel(unsigned int l, volatile void __iomem *addr)
 {
+	barrier();
 	__raw_writel((__u32 __force) cpu_to_le32(l), addr);
 }
 static inline void writeq(unsigned long long q, volatile void __iomem *addr)
 {
+	barrier();
 	__raw_writeq((__u64 __force) cpu_to_le64(q), addr);
 }
 
-- 
2.7.4
