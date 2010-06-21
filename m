From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Jun 2010 13:23:29 +0100
Subject: [PATCH 1/2] ARM: Do not use outer_sync() in mb() if
	!ARM_DMA_MEM_BUFFERABLE
In-Reply-To: <20100621115703.7162.95491.stgit@e102109-lin.cambridge.arm.com>
References: <20100621115703.7162.95491.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100621122329.7162.61895.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the mb() barrier implementation for the
!ARM_DMA_MEM_BUFFERABLE case so that it no longer performs an outer
cache sync. When this is option is disabled, the coherent DMA buffers
are mapped as Strongly Ordered and there is no need for an L2 cache
sync.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/system.h |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

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
