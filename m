From: tom.leiming@gmail.com (tom.leiming at gmail.com)
Date: Sat, 16 Apr 2011 00:21:51 +0800
Subject: [PATCH] ARM: fix badly implementation of wmb
Message-ID: <1302884511-14152-1-git-send-email-tom.leiming@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ming Lei <tom.leiming@gmail.com>

Commit e7c5650f6067f65f8e961394f376d4862808d0d2

	ARM: 5996/1: ARM: Change the mandatory barriers implementation (4/4)

implements wmb as dsb plus outer_sync, which will make wmb
much more strict than required. In fact, it is enough for dmb to
keep the partial order of two stores, so restore wmb as dmb to
fix possible performance degrade caused by the commit e7c5650f.

Also the patch defines __iowmb as mb to fix the issue which the
commit e7c5650f addressed.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 arch/arm/include/asm/io.h     |    2 +-
 arch/arm/include/asm/system.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index d66605d..b2cd9f2 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -98,7 +98,7 @@ static inline void __iomem *__typesafe_io(unsigned long addr)
 /* IO barriers */
 #ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
 #define __iormb()		rmb()
-#define __iowmb()		wmb()
+#define __iowmb()		mb()
 #else
 #define __iormb()		do { } while (0)
 #define __iowmb()		do { } while (0)
diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 885be09..1ec2c25 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -160,7 +160,7 @@ extern unsigned int user_debug;
 #elif defined(CONFIG_ARM_DMA_MEM_BUFFERABLE) || defined(CONFIG_SMP)
 #define mb()		do { dsb(); outer_sync(); } while (0)
 #define rmb()		dmb()
-#define wmb()		mb()
+#define wmb()		dmb()
 #else
 #include <asm/memory.h>
 #define mb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
-- 
1.7.3
