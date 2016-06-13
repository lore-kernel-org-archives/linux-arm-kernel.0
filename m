From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 13 Jun 2016 20:31:59 +0800
Subject: [PATCH] arm64: mm: update SECTION_SIZE_BITS to 27 for 4k pagesize
Message-ID: <1465821119-3384-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On one of my platforms, linux is given 1152MB memory. With current
SECTION_SIZE_BITS 30, the reserved memmap is larger, it's a waste for
us. Inspired by disscusion[1], reducing the SECTION_SIZE_BITS to 27
which means 128M section size saves us about 14MB, a huge gain for
embeded memory constrained system.

[1]http://lkml.iu.edu/hypermail/linux/kernel/1604.1/03036.html

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/include/asm/sparsemem.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
index 74a9d30..41c10f7 100644
--- a/arch/arm64/include/asm/sparsemem.h
+++ b/arch/arm64/include/asm/sparsemem.h
@@ -18,7 +18,11 @@
 
 #ifdef CONFIG_SPARSEMEM
 #define MAX_PHYSMEM_BITS	48
+#ifdef CONFIG_ARM64_64K_PAGES
 #define SECTION_SIZE_BITS	30
+#else
+#define SECTION_SIZE_BITS	27
+#endif
 #endif
 
 #endif
-- 
2.8.1
