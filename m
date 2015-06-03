From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 03 Jun 2015 13:35:20 +0100
Subject: [PATCH RFC 2/2] ARM: add soc memory barrier extension
Message-ID: <E1Z07tA-0001TV-As@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an extension to the heavy barrier code to allow a SoC specific
memory barrier function to be provided.  This is needed for platforms
where the interconnect has weak ordering, and thus needs assistance
to ensure that memory writes are properly visible in the correct order
to other parts of the system.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/barrier.h | 1 +
 arch/arm/mm/flush.c            | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/include/asm/barrier.h b/arch/arm/include/asm/barrier.h
index 646539a903a2..1676007d9549 100644
--- a/arch/arm/include/asm/barrier.h
+++ b/arch/arm/include/asm/barrier.h
@@ -37,6 +37,7 @@
 #endif
 
 #ifdef CONFIG_ARM_HEAVY_MB
+extern void (*soc_mb)(void);
 extern void arm_heavy_mb(void);
 #define __arm_heavy_mb(x...) do { dsb(x); arm_heavy_mb(); } while (0)
 #else
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index ce6c2960d5ac..1ec8e7590fc6 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -22,12 +22,16 @@
 #include "mm.h"
 
 #ifdef CONFIG_ARM_HEAVY_MB
+void (*soc_mb)(void);
+
 void arm_heavy_mb(void)
 {
 #ifdef CONFIG_OUTER_CACHE_SYNC
 	if (outer_cache.sync)
 		outer_cache.sync();
 #endif
+	if (soc_mb)
+		soc_mb();
 }
 EXPORT_SYMBOL(arm_heavy_mb);
 #endif
-- 
2.1.0
