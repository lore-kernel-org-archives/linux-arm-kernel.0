From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 04 Jun 2010 13:11:31 +0100
Subject: [PATCH] ARM: Do not enable ARM_DMA_MEM_BUFFERABLE for some RealView
	boards
Message-ID: <20100604121130.20940.51309.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RealView boards with certain revisions of the L210/L220 cache controller
may have issues with recent changes to the mb() barrier implementation
(DSB followed by an L2 cache sync).

Until an L2-specific workaround is added, this patch proposes that the
mb() barrier performs an outer cache sync only when
ARM_DMA_MEM_BUFFERABLE is enabled. When this is option is disabled, the
coherent DMA buffers are mapped as Strongly Ordered and there is no need
for an L2 cache sync.

The patch also disables ARM_DMA_MEM_BUFFERABLE for some of the RealView
boards with L210/L220.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <rmk@arm.linux.org.uk>
Cc: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: Bjoern B. Brandenburg <bbb.lst@gmail.com>
---
 arch/arm/include/asm/system.h |    6 +++++-
 arch/arm/mm/Kconfig           |    2 ++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 5f4f480..3b2abcf 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -141,10 +141,14 @@ extern unsigned int user_debug;
 
 #ifdef CONFIG_ARCH_HAS_BARRIERS
 #include <mach/barriers.h>
-#elif defined(CONFIG_ARM_DMA_MEM_BUFFERABLE) || defined(CONFIG_SMP)
+#elif defined(CONFIG_ARM_DMA_MEM_BUFFERABLE)
 #define mb()		do { dsb(); outer_sync(); } while (0)
 #define rmb()		dmb()
 #define wmb()		mb()
+#elif defined(CONFIG_SMP)
+#define mb()		dsb()
+#define rmb()		dmb()
+#define wmb()		mb()
 #else
 #define mb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
 #define rmb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 3053731..9f10a9b 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -828,6 +828,8 @@ config ARM_L1_CACHE_SHIFT
 
 config ARM_DMA_MEM_BUFFERABLE
 	bool "Use non-cacheable memory for DMA" if CPU_V6 && !CPU_V7
+	depends on !(MACH_REALVIEW_PB1176 || REALVIEW_EB_ARM11MP || \
+		     MACH_REALVIEW_PB11MP)
 	default y if CPU_V6 || CPU_V7
 	help
 	  Historically, the kernel has used strongly ordered mappings to
