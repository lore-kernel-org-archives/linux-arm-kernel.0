From: julien.thierry@arm.com (Julien Thierry)
Date: Thu,  6 Sep 2018 12:09:56 +0100
Subject: [PATCH] arm64: uaccess: implement unsafe accessors
Message-ID: <1536232196-55027-1-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current implementation of get/put_user_unsafe default to get/put_user
which toggle PAN before each access, despite having been told by the caller
that multiple accesses to user memory were about to happen.

Provide implementations for user_access_begin/end to turn PAN off/on and
implement unsafe accessors that assume PAN was already turned off.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/uaccess.h | 61 ++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index e66b0fc..c4528dd 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -277,11 +277,9 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 	: "+r" (err), "=&r" (x)						\
 	: "r" (addr), "i" (-EFAULT))

-#define __get_user_err(x, ptr, err)					\
+#define __get_user_err_unsafe(x, ptr, err)				\
 do {									\
 	unsigned long __gu_val;						\
-	__chk_user_ptr(ptr);						\
-	uaccess_enable_not_uao();					\
 	switch (sizeof(*(ptr))) {					\
 	case 1:								\
 		__get_user_asm("ldrb", "ldtrb", "%w", __gu_val, (ptr),  \
@@ -302,17 +300,24 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 	default:							\
 		BUILD_BUG();						\
 	}								\
-	uaccess_disable_not_uao();					\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
 } while (0)

-#define __get_user_check(x, ptr, err)					\
+#define __get_user_err_check(x, ptr, err)				\
+do {									\
+	__chk_user_ptr(ptr);						\
+	uaccess_enable_not_uao();					\
+	__get_user_err_unsafe((x), (ptr), (err));			\
+	uaccess_disable_not_uao();					\
+} while (0)
+
+#define __get_user_err(x, ptr, err, accessor)				\
 ({									\
 	__typeof__(*(ptr)) __user *__p = (ptr);				\
 	might_fault();							\
 	if (access_ok(VERIFY_READ, __p, sizeof(*__p))) {		\
 		__p = uaccess_mask_ptr(__p);				\
-		__get_user_err((x), __p, (err));			\
+		accessor((x), __p, (err));				\
 	} else {							\
 		(x) = 0; (err) = -EFAULT;				\
 	}								\
@@ -320,14 +325,14 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)

 #define __get_user_error(x, ptr, err)					\
 ({									\
-	__get_user_check((x), (ptr), (err));				\
+	__get_user_err((x), (ptr), (err), __get_user_err_check);	\
 	(void)0;							\
 })

 #define __get_user(x, ptr)						\
 ({									\
 	int __gu_err = 0;						\
-	__get_user_check((x), (ptr), __gu_err);				\
+	__get_user_err((x), (ptr), __gu_err, __get_user_err_check);	\
 	__gu_err;							\
 })

@@ -347,11 +352,9 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 	: "+r" (err)							\
 	: "r" (x), "r" (addr), "i" (-EFAULT))

-#define __put_user_err(x, ptr, err)					\
+#define __put_user_err_unsafe(x, ptr, err)				\
 do {									\
 	__typeof__(*(ptr)) __pu_val = (x);				\
-	__chk_user_ptr(ptr);						\
-	uaccess_enable_not_uao();					\
 	switch (sizeof(*(ptr))) {					\
 	case 1:								\
 		__put_user_asm("strb", "sttrb", "%w", __pu_val, (ptr),	\
@@ -372,16 +375,24 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 	default:							\
 		BUILD_BUG();						\
 	}								\
+} while (0)
+
+
+#define __put_user_err_check(x, ptr, err)				\
+do {									\
+	__chk_user_ptr(ptr);						\
+	uaccess_enable_not_uao();					\
+	__put_user_err_unsafe((x), (ptr), (err));			\
 	uaccess_disable_not_uao();					\
 } while (0)

-#define __put_user_check(x, ptr, err)					\
+#define __put_user_err(x, ptr, err, accessor)				\
 ({									\
 	__typeof__(*(ptr)) __user *__p = (ptr);				\
 	might_fault();							\
 	if (access_ok(VERIFY_WRITE, __p, sizeof(*__p))) {		\
 		__p = uaccess_mask_ptr(__p);				\
-		__put_user_err((x), __p, (err));			\
+		accessor((x), __p, (err));				\
 	} else	{							\
 		(err) = -EFAULT;					\
 	}								\
@@ -389,19 +400,39 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)

 #define __put_user_error(x, ptr, err)					\
 ({									\
-	__put_user_check((x), (ptr), (err));				\
+	__put_user_err((x), (ptr), (err), __put_user_err_check);	\
 	(void)0;							\
 })

 #define __put_user(x, ptr)						\
 ({									\
 	int __pu_err = 0;						\
-	__put_user_check((x), (ptr), __pu_err);				\
+	__put_user_err((x), (ptr), __pu_err, __put_user_err_check);	\
 	__pu_err;							\
 })

 #define put_user	__put_user

+
+#define user_access_begin()	uaccess_enable_not_uao()
+#define user_access_end()	uaccess_disable_not_uao()
+
+#define unsafe_get_user(x, ptr, err)					\
+do {									\
+	int __gu_err = 0;						\
+	__get_user_err((x), (ptr), __gu_err, __get_user_err_unsafe);	\
+	if (__gu_err != 0)						\
+		goto err;						\
+} while (0)
+
+#define unsafe_put_user(x, ptr, err)					\
+do {									\
+	int __pu_err = 0;						\
+	__put_user_err((x), (ptr), __pu_err, __put_user_err_unsafe);	\
+	if (__pu_err != 0)						\
+		goto err;						\
+} while (0)
+
 extern unsigned long __must_check __arch_copy_from_user(void *to, const void __user *from, unsigned long n);
 #define raw_copy_from_user(to, from, n)					\
 ({									\
--
1.9.1
