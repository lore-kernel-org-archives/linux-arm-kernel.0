From: omar.ramirez@ti.com (Omar Ramirez Luna)
Date: Thu, 31 Mar 2011 14:15:23 -0600
Subject: [PATCH] ARM: BUG() dies silently
Message-ID: <1301602523-9906-1-git-send-email-omar.ramirez@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are some cases where the code generated for BUG() results
into an infinite while loop without causing a null dereference,
this ends on a kernel being stuck on a loop and the user without
a clue of what happened.

E.g.: lib/scatterlist.c : __sg_alloc_table

        BUG_ON(nents > max_ents);
 438:   9a000000        bls     440 <__sg_alloc_table+0x20>
 43c:   eafffffe        b       43c <__sg_alloc_table+0x1c>

Adding volatile makes the compiler to avoid optimizations on this
code, which makes the panic to occur:

        BUG_ON(nents > max_ents);
 438:   9a000002        bls     448 <__sg_alloc_table+0x28>
 43c:   e3a03000        mov     r3, #0
 440:   e5833000        str     r3, [r3]
 444:   eafffffc        b       43c <__sg_alloc_table+0x1c>

Seen with gnu/linux cs arm-2010q1-202 and arm2010.09-50.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---

If needed I can change:
./arch/arm/mach-clps711x/include/mach/io.h:
	#define __raw_readsb(p,d,l)  do { *(int *)0 = 0; } while (0)
./arch/arm/mach-clps711x/include/mach/io.h:
	#define __raw_readsl(p,d,l)  do { *(int *)0 = 0; } while (0)
./arch/arm/mach-clps711x/include/mach/io.h:
	#define __raw_writesb(p,d,l) do { *(int *)0 = 0; } while (0)
./arch/arm/mach-clps711x/include/mach/io.h:
	#define __raw_writesl(p,d,l) do { *(int *)0 = 0; } while (0)
./arch/arm/kernel/traps.c:      *(int *)0 = 0;


 arch/arm/include/asm/bug.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/bug.h b/arch/arm/include/asm/bug.h
index 4d88425..a58d863 100644
--- a/arch/arm/include/asm/bug.h
+++ b/arch/arm/include/asm/bug.h
@@ -12,7 +12,7 @@ extern void __bug(const char *file, int line) __attribute__((noreturn));
 #else
 
 /* this just causes an oops */
-#define BUG()		do { *(int *)0 = 0; } while (1)
+#define BUG()		do { *(volatile int *)0 = 0; } while(1)
 
 #endif
 
-- 
1.7.1
