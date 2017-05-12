From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 12 May 2017 13:48:41 +0100
Subject: [PATCH] arm64: Remove redundant mov from LL/SC cmpxchg
Message-ID: <f197f5369dfa1fe2a220da0950e5f5475382a920.1494593043.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cmpxchg implementation introduced by commit c342f78217e8 ("arm64:
cmpxchg: patch in lse instructions when supported by the CPU") performs
an apparently redundant register move of [old] to [oldval] in the
success case - it always uses the same register width as [oldval] was
originally loaded with, and is only executed when [old] and [oldval] are
known to be equal anyway.

The only effect it seemingly does have is to take up a surprising amount
of space in the kernel text, as removing it reveals:

   text	   data	    bss	    dec	    hex	filename
12426658	1348614	4499749	18275021	116dacd	vmlinux.o.new
12429238	1348614	4499749	18277601	116e4e1	vmlinux.o.old

Reviewed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/include/asm/atomic_ll_sc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
index f819fdcff1ac..f5a2d09afb38 100644
--- a/arch/arm64/include/asm/atomic_ll_sc.h
+++ b/arch/arm64/include/asm/atomic_ll_sc.h
@@ -264,7 +264,6 @@ __LL_SC_PREFIX(__cmpxchg_case_##name(volatile void *ptr,		\
 	"	st" #rel "xr" #sz "\t%w[tmp], %" #w "[new], %[v]\n"	\
 	"	cbnz	%w[tmp], 1b\n"					\
 	"	" #mb "\n"						\
-	"	mov	%" #w "[oldval], %" #w "[old]\n"		\
 	"2:"								\
 	: [tmp] "=&r" (tmp), [oldval] "=&r" (oldval),			\
 	  [v] "+Q" (*(unsigned long *)ptr)				\
-- 
2.12.2.dirty
