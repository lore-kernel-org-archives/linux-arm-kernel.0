From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 10 Jul 2018 15:14:07 +0100
Subject: [PATCH 5/6] ARM: spectre-v1: use get_user() for __get_user()
In-Reply-To: <20180710141322.GL17271@n2100.armlinux.org.uk>
References: <20180710141322.GL17271@n2100.armlinux.org.uk>
Message-ID: <E1fctP5-0005vM-MA@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixing __get_user() for spectre variant 1 is not sane: we would have to
add address space bounds checking in order to validate that the location
should be accessed, and then zero the address if found to be invalid.

Since __get_user() is supposed to avoid the bounds check, and this is
exactly what get_user() does, there's no point having two different
implementations that are doing the same thing.  So, when the Spectre
workarounds are required, make __get_user() an alias of get_user().

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/include/asm/uaccess.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 29fa6f3ea25a..4140be431087 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -250,6 +250,16 @@ static inline void set_fs(mm_segment_t fs)
 #define user_addr_max() \
 	(uaccess_kernel() ? ~0UL : get_fs())
 
+#ifdef CONFIG_CPU_SPECTRE
+/*
+ * When mitigating Spectre variant 1, it is not worth fixing the non-
+ * verifying accessors, because we need to add verification of the
+ * address space there.  Force these to use the standard get_user()
+ * version instead.
+ */
+#define __get_user(x, ptr) get_user(x, ptr)
+#else
+
 /*
  * The "__xxx" versions of the user access functions do not verify the
  * address space - it must have been done previously with a separate
@@ -266,12 +276,6 @@ static inline void set_fs(mm_segment_t fs)
 	__gu_err;							\
 })
 
-#define __get_user_error(x, ptr, err)					\
-({									\
-	__get_user_err((x), (ptr), err);				\
-	(void) 0;							\
-})
-
 #define __get_user_err(x, ptr, err)					\
 do {									\
 	unsigned long __gu_addr = (unsigned long)(ptr);			\
@@ -331,6 +335,7 @@ do {									\
 
 #define __get_user_asm_word(x, addr, err)			\
 	__get_user_asm(x, addr, err, ldr)
+#endif
 
 
 #define __put_user_switch(x, ptr, __err, __fn)				\
-- 
2.7.4
