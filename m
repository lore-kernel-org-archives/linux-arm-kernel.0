From: will.deacon@arm.com (Will Deacon)
Date: Tue, 13 Oct 2015 14:01:06 +0100
Subject: [PATCH] arm64: kasan: fix issues reported by sparse
Message-ID: <1444741266-21335-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sparse reports some new issues introduced by the kasan patches:

  arch/arm64/mm/kasan_init.c:91:13: warning: no previous prototype for
  'kasan_early_init' [-Wmissing-prototypes] void __init kasan_early_init(void)
             ^
  arch/arm64/mm/kasan_init.c:91:13: warning: symbol 'kasan_early_init'
  was not declared. Should it be static? [sparse]

This patch resolves the problem by adding a prototype for
kasan_early_init and marking the function as asmlinkage, since it's only
called from head.S.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/kasan.h | 2 ++
 arch/arm64/mm/kasan_init.c     | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kasan.h b/arch/arm64/include/asm/kasan.h
index 71dfe14acdca..2774fa384c47 100644
--- a/arch/arm64/include/asm/kasan.h
+++ b/arch/arm64/include/asm/kasan.h
@@ -5,6 +5,7 @@
 
 #ifdef CONFIG_KASAN
 
+#include <linux/linkage.h>
 #include <asm/memory.h>
 
 /*
@@ -27,6 +28,7 @@
 #define KASAN_SHADOW_OFFSET     (KASAN_SHADOW_END - (1ULL << (64 - 3)))
 
 void kasan_init(void);
+asmlinkage void kasan_early_init(void);
 
 #else
 static inline void kasan_init(void) { }
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index b6a92f5dd568..cf038c7d9fa9 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -88,7 +88,7 @@ static void __init kasan_map_early_shadow(void)
 	} while (pgd++, addr = next, addr != end);
 }
 
-void __init kasan_early_init(void)
+asmlinkage void __init kasan_early_init(void)
 {
 	BUILD_BUG_ON(KASAN_SHADOW_OFFSET != KASAN_SHADOW_END - (1UL << 61));
 	BUILD_BUG_ON(!IS_ALIGNED(KASAN_SHADOW_START, PGDIR_SIZE));
-- 
2.1.4
