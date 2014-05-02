From: will.deacon@arm.com (Will Deacon)
Date: Fri,  2 May 2014 16:24:11 +0100
Subject: [PATCH 4/8] arm64: barriers: wire up new barrier options
In-Reply-To: <1399044255-20435-1-git-send-email-will.deacon@arm.com>
References: <1399044255-20435-1-git-send-email-will.deacon@arm.com>
Message-ID: <1399044255-20435-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that all callers of the barrier macros are updated to pass the
mandatory options, update the macros so the option is actually used.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/barrier.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 5d69eddbe39e..71a42d6599fb 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -25,12 +25,12 @@
 #define wfi()		asm volatile("wfi" : : : "memory")
 
 #define isb()		asm volatile("isb" : : : "memory")
-#define dmb(opt)	asm volatile("dmb sy" : : : "memory")
-#define dsb(opt)	asm volatile("dsb sy" : : : "memory")
+#define dmb(opt)	asm volatile("dmb " #opt : : : "memory")
+#define dsb(opt)	asm volatile("dsb " #opt : : : "memory")
 
 #define mb()		dsb(sy)
-#define rmb()		asm volatile("dsb ld" : : : "memory")
-#define wmb()		asm volatile("dsb st" : : : "memory")
+#define rmb()		dsb(ld)
+#define wmb()		dsb(st)
 
 #ifndef CONFIG_SMP
 #define smp_mb()	barrier()
@@ -54,9 +54,9 @@ do {									\
 
 #else
 
-#define smp_mb()	asm volatile("dmb ish" : : : "memory")
-#define smp_rmb()	asm volatile("dmb ishld" : : : "memory")
-#define smp_wmb()	asm volatile("dmb ishst" : : : "memory")
+#define smp_mb()	dmb(ish)
+#define smp_rmb()	dmb(ishld)
+#define smp_wmb()	dmb(ishst)
 
 #define smp_store_release(p, v)						\
 do {									\
-- 
1.9.2
