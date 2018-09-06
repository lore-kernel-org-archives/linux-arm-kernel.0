From: julien.thierry@arm.com (Julien Thierry)
Date: Thu,  6 Sep 2018 17:38:06 +0100
Subject: [PATCH v2 7/9] ARM: spectre-v1.1: use put_user() for __put_user()
In-Reply-To: <1536251888-8302-1-git-send-email-julien.thierry@arm.com>
References: <1536251888-8302-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1536251888-8302-8-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When Spectre mitigation is required, __put_user() needs to include
check_uaccess. This is already the case for put_user(), so just make
__put_user() an alias of put_user().

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
---
 arch/arm/include/asm/uaccess.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index d65ef85..1191e7d 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -370,6 +370,14 @@ static inline void set_fs(mm_segment_t fs)
 	__pu_err;							\
 })
 
+#ifdef CONFIG_CPU_SPECTRE
+/*
+ * When mitigating Spectre variant 1.1, all accessors need to include
+ * verification of the address space.
+ */
+#define __put_user(x, ptr) put_user(x, ptr)
+
+#else
 #define __put_user(x, ptr)						\
 ({									\
 	long __pu_err = 0;						\
@@ -377,12 +385,6 @@ static inline void set_fs(mm_segment_t fs)
 	__pu_err;							\
 })
 
-#define __put_user_error(x, ptr, err)					\
-({									\
-	__put_user_switch((x), (ptr), (err), __put_user_nocheck);	\
-	(void) 0;							\
-})
-
 #define __put_user_nocheck(x, __pu_ptr, __err, __size)			\
 	do {								\
 		unsigned long __pu_addr = (unsigned long)__pu_ptr;	\
@@ -462,6 +464,7 @@ static inline void set_fs(mm_segment_t fs)
 	: "r" (x), "i" (-EFAULT)				\
 	: "cc")
 
+#endif /* !CONFIG_CPU_SPECTRE */
 
 #ifdef CONFIG_MMU
 extern unsigned long __must_check
-- 
1.9.1
