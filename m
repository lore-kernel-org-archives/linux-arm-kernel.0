From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Thu, 09 Feb 2017 12:18:45 +0000
Subject: [PATCH 3/4] ARM: kuser: simplify kuser_cmpxchg* preprocessor
 conditionals
In-Reply-To: <20170209121756.GC27312@n2100.armlinux.org.uk>
References: <20170209121756.GC27312@n2100.armlinux.org.uk>
Message-ID: <E1cbngT-000269-4q@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simplify the kuser_cmpxchg* preprocessor conditionals by arranging the
ARMv6+ code first.  This gives us one level of preprocessor conditional
nesting, rather than two levels.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/kernel/kuser.S | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/arch/arm/kernel/kuser.S b/arch/arm/kernel/kuser.S
index 5d2a2784ed09..d7081a4761fe 100644
--- a/arch/arm/kernel/kuser.S
+++ b/arch/arm/kernel/kuser.S
@@ -2,6 +2,10 @@
 
 #include <asm/assembler.h>
 
+#if defined(CONFIG_SMP) && !defined(CONFIG_CPU_32v6K)
+#error "incoherent kernel configuration"
+#endif
+
 	__INIT
 
 /*
@@ -63,9 +67,7 @@ __kuser_cmpxchg64:				@ 0xffff0f60
 	ldmfd	sp!, {r4, r5, r6, r7}
 	usr_ret	lr
 
-#elif !defined(CONFIG_SMP)
-
-#ifdef CONFIG_MMU
+#elif defined(CONFIG_MMU)
 
 	/*
 	 * The only thing that can break atomicity in this cmpxchg64
@@ -109,10 +111,6 @@ __kuser_cmpxchg64:				@ 0xffff0f60
 	usr_ret	lr
 #endif
 
-#else
-#error "incoherent kernel configuration"
-#endif
-
 	kuser_pad __kuser_cmpxchg64, 64
 
 __kuser_memory_barrier:				@ 0xffff0fa0
@@ -123,9 +121,20 @@ __kuser_memory_barrier:				@ 0xffff0fa0
 
 __kuser_cmpxchg:				@ 0xffff0fc0
 
-#if __LINUX_ARM_ARCH__ < 6
+#if __LINUX_ARM_ARCH__ >= 6
 
-#ifdef CONFIG_MMU
+	smp_dmb	arm
+1:	ldrex	r3, [r2]
+	subs	r3, r3, r0
+	strexeq	r3, r1, [r2]
+	teqeq	r3, #1
+	beq	1b
+	rsbs	r0, r3, #0
+	/* beware -- each __kuser slot must be 8 instructions max */
+	ALT_SMP(b	__kuser_memory_barrier)
+	ALT_UP(usr_ret	lr)
+
+#elif defined(CONFIG_MMU)
 
 	/*
 	 * The only thing that can break atomicity in this cmpxchg
@@ -164,21 +173,6 @@ __kuser_cmpxchg:				@ 0xffff0fc0
 	usr_ret	lr
 #endif
 
-#else
-
-	smp_dmb	arm
-1:	ldrex	r3, [r2]
-	subs	r3, r3, r0
-	strexeq	r3, r1, [r2]
-	teqeq	r3, #1
-	beq	1b
-	rsbs	r0, r3, #0
-	/* beware -- each __kuser slot must be 8 instructions max */
-	ALT_SMP(b	__kuser_memory_barrier)
-	ALT_UP(usr_ret	lr)
-
-#endif
-
 	kuser_pad __kuser_cmpxchg, 32
 
 __kuser_get_tls:				@ 0xffff0fe0
-- 
2.7.4
