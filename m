From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Mar 2015 15:21:26 +0100
Subject: [PATCH] ARM: avoid cmpxchg warning in kernel/acct.c
Message-ID: <3051396.SaPW2fB5ZI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent change in kernel/acct.c added a new warning for many
configurations on ARM:

kernel/acct.c: In function 'acct_pin_kill':
arch/arm/include/asm/cmpxchg.h:122:3: warning: value computed is not used [-Wunused-value]
  ((__typeof__(*(ptr)))__cmpxchg_local_generic((ptr), (unsigned long)(o),\

The code is in fact correct, it's just a cmpxchg() call that intentionally
ignores the result, and no other code does that. The warning does not
show up on x86 because of the way that its cmpxchg() macro is written.

This changes the ARM implementation to use a similar construct with a
compound expression instead of a typecast, which causes the compiler to
not complain about an unused result.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 3b994d98a815 ("get rid of the second argument of acct_kill()")

diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
index abb2c3769b01..04be894f7c4e 100644
--- a/arch/arm/include/asm/cmpxchg.h
+++ b/arch/arm/include/asm/cmpxchg.h
@@ -119,8 +119,8 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
  * them available.
  */
 #define cmpxchg_local(ptr, o, n)				  	       \
-	((__typeof__(*(ptr)))__cmpxchg_local_generic((ptr), (unsigned long)(o),\
-			(unsigned long)(n), sizeof(*(ptr))))
+	({(__typeof__(*(ptr)))__cmpxchg_local_generic((ptr), (unsigned long)(o),\
+			(unsigned long)(n), sizeof(*(ptr)));})
 #define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
 
 #ifndef CONFIG_SMP
@@ -202,10 +202,10 @@ static inline unsigned long __cmpxchg_mb(volatile void *ptr, unsigned long old,
 }
 
 #define cmpxchg(ptr,o,n)						\
-	((__typeof__(*(ptr)))__cmpxchg_mb((ptr),			\
+	({(__typeof__(*(ptr)))__cmpxchg_mb((ptr),			\
 					  (unsigned long)(o),		\
 					  (unsigned long)(n),		\
-					  sizeof(*(ptr))))
+					  sizeof(*(ptr)));})
 
 static inline unsigned long __cmpxchg_local(volatile void *ptr,
 					    unsigned long old,
