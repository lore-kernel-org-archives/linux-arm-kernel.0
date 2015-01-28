From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 20:48:19 +0100
Subject: [PATCH 12/15] ARM: bpf: fix NOMMU build
In-Reply-To: <1422474502-3097078-1-git-send-email-arnd@arndb.de>
References: <1422474502-3097078-1-git-send-email-arnd@arndb.de>
Message-ID: <1422474502-3097078-13-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/net/built-in.o: In function `bpf_jit_compile':
:(.text+0x2758): undefined reference to `set_memory_ro'
arch/arm/net/built-in.o: In function `bpf_jit_free':
:(.text+0x27ac): undefined reference to `set_memory_rw'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/cacheflush.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 2d46862e7bef..4812cda8fd17 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -482,10 +482,17 @@ static inline void __sync_cache_range_r(volatile void *p, size_t size)
 	: : : "r0","r1","r2","r3","r4","r5","r6","r7", \
 	      "r9","r10","lr","memory" )
 
+#ifdef CONFIG_MMU
 int set_memory_ro(unsigned long addr, int numpages);
 int set_memory_rw(unsigned long addr, int numpages);
 int set_memory_x(unsigned long addr, int numpages);
 int set_memory_nx(unsigned long addr, int numpages);
+#else
+static inline int set_memory_ro(unsigned long addr, int numpages) { return 0; }
+static inline int set_memory_rw(unsigned long addr, int numpages) { return 0; }
+static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
+static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
+#endif
 
 #ifdef CONFIG_DEBUG_RODATA
 void mark_rodata_ro(void);
-- 
2.1.0.rc2
