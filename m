From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Mar 2010 13:48:31 +0000
Subject: [PATCH v4 2/4] ARM: Add outer_cache_fns.sync function pointer
In-Reply-To: <20100319134614.14625.18408.stgit@e102109-lin.cambridge.arm.com>
References: <20100319134614.14625.18408.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100319134831.14625.87556.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces the outer_cache_fns.sync function pointer together
with the OUTER_CACHE_SYNC config option that can be used to drain the
write buffer of the outer cache.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/outercache.h |   14 ++++++++++++++
 arch/arm/mm/Kconfig               |    6 ++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/outercache.h b/arch/arm/include/asm/outercache.h
index c8571cb..25f76ba 100644
--- a/arch/arm/include/asm/outercache.h
+++ b/arch/arm/include/asm/outercache.h
@@ -25,6 +25,9 @@ struct outer_cache_fns {
 	void (*inv_range)(unsigned long, unsigned long);
 	void (*clean_range)(unsigned long, unsigned long);
 	void (*flush_range)(unsigned long, unsigned long);
+#ifdef CONFIG_OUTER_CACHE_SYNC
+	void (*sync)(void);
+#endif
 };
 
 #ifdef CONFIG_OUTER_CACHE
@@ -58,4 +61,15 @@ static inline void outer_flush_range(unsigned long start, unsigned long end)
 
 #endif
 
+#ifdef CONFIG_OUTER_CACHE_SYNC
+static inline void outer_sync(void)
+{
+	if (outer_cache.sync)
+		outer_cache.sync();
+}
+#else
+static inline void outer_sync(void)
+{ }
+#endif
+
 #endif	/* __ASM_OUTERCACHE_H */
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 63719d4..7dc1f8c 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -745,6 +745,12 @@ config NEEDS_SYSCALL_FOR_CMPXCHG
 config OUTER_CACHE
 	bool
 
+config OUTER_CACHE_SYNC
+	bool
+	help
+	  The outer cache has a outer_cache_fns.sync function pointer
+	  that can be used to drain the write buffer of the outer cache.
+
 config CACHE_FEROCEON_L2
 	bool "Enable the Feroceon L2 cache controller"
 	depends on ARCH_KIRKWOOD || ARCH_MV78XX0
