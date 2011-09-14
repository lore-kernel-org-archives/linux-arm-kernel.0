From: olof@lixom.net (Olof Johansson)
Date: Wed, 14 Sep 2011 08:11:22 -0700
Subject: [PATCH] ARM: rename temp variable in read*_relaxed()
Message-ID: <1316013082-21641-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This resolves the following sparse warning from readl() and other macros,
which ends up embedding readl_relaxed() using the same variable:

arch/arm/mach-tegra/dma.c:169:8: warning: symbol '__v' shadows an earlier one
arch/arm/mach-tegra/dma.c:169:8: originally declared here

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/include/asm/io.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index d66605d..bbeb11e 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -189,11 +189,11 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
  * IO port primitives for more information.
  */
 #ifdef __mem_pci
-#define readb_relaxed(c) ({ u8  __v = __raw_readb(__mem_pci(c)); __v; })
-#define readw_relaxed(c) ({ u16 __v = le16_to_cpu((__force __le16) \
-					__raw_readw(__mem_pci(c))); __v; })
-#define readl_relaxed(c) ({ u32 __v = le32_to_cpu((__force __le32) \
-					__raw_readl(__mem_pci(c))); __v; })
+#define readb_relaxed(c) ({ u8  __r = __raw_readb(__mem_pci(c)); __r; })
+#define readw_relaxed(c) ({ u16 __r = le16_to_cpu((__force __le16) \
+					__raw_readw(__mem_pci(c))); __r; })
+#define readl_relaxed(c) ({ u32 __r = le32_to_cpu((__force __le32) \
+					__raw_readl(__mem_pci(c))); __r; })
 
 #define writeb_relaxed(v,c)	((void)__raw_writeb(v,__mem_pci(c)))
 #define writew_relaxed(v,c)	((void)__raw_writew((__force u16) \
-- 
1.7.4.1
