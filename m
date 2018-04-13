From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 12 Apr 2018 22:30:43 -0400
Subject: [PATCH v4 1/2] MIPS: io: prevent compiler reordering on the default
 writeX() implementation
Message-ID: <1523586646-19630-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

writeX() has a strong ordering semantics with respect to memory updates.
In the abscence of a write barrier or a compiler barrier, commpiler can
reorder register and memory update instructions. This breaks the writeX()
API.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 arch/mips/include/asm/io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 0cbf3af..fd00ddaf 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -307,7 +307,7 @@ static inline void iounmap(const volatile void __iomem *addr)
 #if defined(CONFIG_CPU_CAVIUM_OCTEON) || defined(CONFIG_LOONGSON3_ENHANCEMENT)
 #define war_io_reorder_wmb()		wmb()
 #else
-#define war_io_reorder_wmb()		do { } while (0)
+#define war_io_reorder_wmb()		barrier()
 #endif
 
 #define __BUILD_MEMORY_SINGLE(pfx, bwlq, type, irq)			\
-- 
2.7.4
