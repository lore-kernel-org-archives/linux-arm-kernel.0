From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 17 Jun 2015 17:37:36 +0100
Subject: [PATCH] arm: cmpxchg: update macro to prevent compiler warning
Message-ID: <1434559056-20558-1-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In kernel/acct.c we call the cmpxchg() macro without using it's
return value, so the compiler complains when compiling for ARM:

kernel/acct.c: In function 'acct_pin_kill':
arch/arm/include/asm/cmpxchg.h:205:3: warning: value computed is not used [-Wunused-value]
  ((__typeof__(*(ptr)))__cmpxchg_mb((ptr),   \
   ^
kernel/acct.c:174:2: note: in expansion of macro 'cmpxchg'
  cmpxchg(&acct->ns->bacct, pin, NULL);
  ^

Rearrange the macro along the lines of a similar patch for arm64
60010e508111 ("arm64: cmpxchg: update macros to prevent warnings")
to fix the warning.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Cc: Mark Hambleton <Mark.Hambleton@arm.com>
---
 arch/arm/include/asm/cmpxchg.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
index abb2c37..dc27aaf 100644
--- a/arch/arm/include/asm/cmpxchg.h
+++ b/arch/arm/include/asm/cmpxchg.h
@@ -201,11 +201,16 @@ static inline unsigned long __cmpxchg_mb(volatile void *ptr, unsigned long old,
 	return ret;
 }
 
-#define cmpxchg(ptr,o,n)						\
-	((__typeof__(*(ptr)))__cmpxchg_mb((ptr),			\
-					  (unsigned long)(o),		\
-					  (unsigned long)(n),		\
-					  sizeof(*(ptr))))
+#define cmpxchg(ptr, o, n)						\
+({									\
+	__typeof__(*(ptr)) __ret;					\
+	__ret = (__typeof__(*(ptr)))					\
+		__cmpxchg_mb((ptr),					\
+			     (unsigned long)(o),			\
+			     (unsigned long)(n),			\
+			     sizeof(*(ptr)));				\
+	__ret;								\
+})
 
 static inline unsigned long __cmpxchg_local(volatile void *ptr,
 					    unsigned long old,
-- 
2.3.5
