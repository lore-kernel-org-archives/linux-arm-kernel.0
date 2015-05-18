From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 18 May 2015 13:10:48 +0200
Subject: [PATCH] arm64: Rename temp variable in read*_relaxed()
Message-ID: <4f9792c7d10ca30a9b6ba5e2860b56814a41309c.1431947444.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This resolves the following sparse warning from readl() and other
macros, which ends up embedding readl_relaxed() using the same
variable.

Warning log:
include/asm-generic/io.h:364:16: warning: symbol '__v' shadows an
earlier one
include/asm-generic/io.h:364:16: originally declared here
include/asm-generic/io.h:372:16: warning: symbol '__v' shadows an
earlier one
include/asm-generic/io.h:372:16: originally declared here
include/asm-generic/io.h:380:16: warning: symbol '__v' shadows an
earlier one
include/asm-generic/io.h:380:16: originally declared here
include/asm-generic/io.h:568:16: warning: symbol '__v' shadows an
earlier one
include/asm-generic/io.h:568:16: originally declared here
include/asm-generic/io.h:576:16: warning: symbol '__v' shadows an
earlier one
include/asm-generic/io.h:576:16: originally declared here
include/asm-generic/io.h:584:16: warning: symbol '__v' shadows an
earlier one
include/asm-generic/io.h:584:16: originally declared here

The same patch was already applied to arm32 as
"ARM: 7118/1: rename temp variable in read*_relaxed()"
(sha1: b0c1264f534a1cb3c52036a23a04d238434a0df6)

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/include/asm/io.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 540f7c0aea82..cb18715cc60f 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -117,10 +117,10 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
  * ordering rules but do not guarantee any ordering relative to Normal memory
  * accesses.
  */
-#define readb_relaxed(c)	({ u8  __v = __raw_readb(c); __v; })
-#define readw_relaxed(c)	({ u16 __v = le16_to_cpu((__force __le16)__raw_readw(c)); __v; })
-#define readl_relaxed(c)	({ u32 __v = le32_to_cpu((__force __le32)__raw_readl(c)); __v; })
-#define readq_relaxed(c)	({ u64 __v = le64_to_cpu((__force __le64)__raw_readq(c)); __v; })
+#define readb_relaxed(c)	({ u8  __r = __raw_readb(c); __r; })
+#define readw_relaxed(c)	({ u16 __r = le16_to_cpu((__force __le16)__raw_readw(c)); __r; })
+#define readl_relaxed(c)	({ u32 __r = le32_to_cpu((__force __le32)__raw_readl(c)); __r; })
+#define readq_relaxed(c)	({ u64 __r = le64_to_cpu((__force __le64)__raw_readq(c)); __r; })
 
 #define writeb_relaxed(v,c)	((void)__raw_writeb((v),(c)))
 #define writew_relaxed(v,c)	((void)__raw_writew((__force u16)cpu_to_le16(v),(c)))
-- 
2.3.5
