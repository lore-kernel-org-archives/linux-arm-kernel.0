From: james.morse@arm.com (James Morse)
Date: Wed, 10 Oct 2018 16:55:44 +0100
Subject: [PATCH] Revert "arm64: uaccess: implement unsafe accessors"
Message-ID: <20181010155544.19125-1-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit a1f33941f7e103bcf471eaf8461b212223c642d6.

The unsafe accessors allow the PAN enable/disable calls to be made
once for a group of accesses. Adding these means we can now have
sequences that look like this:

| user_access_begin();
| unsafe_put_user(static-value, x, err);
| unsafe_put_user(helper-that-sleeps(), x, err);
| user_access_end();

Calling schedule() without taking an exception doesn't switch the
PSTATE or TTBRs. We can switch out of a uaccess-enabled region, and
run other code with uaccess enabled for a different thread.

We can also switch from uaccess-disabled code back into this region,
meaning the unsafe_put_user()s will fault.

For software-PAN, threads that do this will get stuck as
handle_mm_fault() will determine the page has already been mapped in,
but we fault again as the page tables aren't loaded.

To solve this we need code in __switch_to() that save/restores the
PAN state.

Signed-off-by: James Morse <james.morse@arm.com>
CC: Julien Thierry <julien.thierry@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
This reverts a patch queued in for-next/core.

 arch/arm64/include/asm/uaccess.h | 61 ++++++++------------------------
 1 file changed, 15 insertions(+), 46 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 8ac6e34922e7..07c34087bd5e 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -276,9 +276,11 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 	: "+r" (err), "=&r" (x)						\
 	: "r" (addr), "i" (-EFAULT))
 
-#define __get_user_err_unsafe(x, ptr, err)				\
+#define __get_user_err(x, ptr, err)					\
 do {									\
 	unsigned long __gu_val;						\
+	__chk_user_ptr(ptr);						\
+	uaccess_enable_not_uao();					\
 	switch (sizeof(*(ptr))) {					\
 	case 1:								\
 		__get_user_asm("ldrb", "ldtrb", "%w", __gu_val, (ptr),  \
@@ -299,24 +301,17 @@ do {									\
 	default:							\
 		BUILD_BUG();						\
 	}								\
-	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
-} while (0)
-
-#define __get_user_err_check(x, ptr, err)				\
-do {									\
-	__chk_user_ptr(ptr);						\
-	uaccess_enable_not_uao();					\
-	__get_user_err_unsafe((x), (ptr), (err));			\
 	uaccess_disable_not_uao();					\
+	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
 } while (0)
 
-#define __get_user_err(x, ptr, err, accessor)				\
+#define __get_user_check(x, ptr, err)					\
 ({									\
 	__typeof__(*(ptr)) __user *__p = (ptr);				\
 	might_fault();							\
 	if (access_ok(VERIFY_READ, __p, sizeof(*__p))) {		\
 		__p = uaccess_mask_ptr(__p);				\
-		accessor((x), __p, (err));				\
+		__get_user_err((x), __p, (err));			\
 	} else {							\
 		(x) = 0; (err) = -EFAULT;				\
 	}								\
@@ -324,14 +319,14 @@ do {									\
 
 #define __get_user_error(x, ptr, err)					\
 ({									\
-	__get_user_err((x), (ptr), (err), __get_user_err_check);	\
+	__get_user_check((x), (ptr), (err));				\
 	(void)0;							\
 })
 
 #define __get_user(x, ptr)						\
 ({									\
 	int __gu_err = 0;						\
-	__get_user_err((x), (ptr), __gu_err, __get_user_err_check);	\
+	__get_user_check((x), (ptr), __gu_err);				\
 	__gu_err;							\
 })
 
@@ -351,9 +346,11 @@ do {									\
 	: "+r" (err)							\
 	: "r" (x), "r" (addr), "i" (-EFAULT))
 
-#define __put_user_err_unsafe(x, ptr, err)				\
+#define __put_user_err(x, ptr, err)					\
 do {									\
 	__typeof__(*(ptr)) __pu_val = (x);				\
+	__chk_user_ptr(ptr);						\
+	uaccess_enable_not_uao();					\
 	switch (sizeof(*(ptr))) {					\
 	case 1:								\
 		__put_user_asm("strb", "sttrb", "%w", __pu_val, (ptr),	\
@@ -374,24 +371,16 @@ do {									\
 	default:							\
 		BUILD_BUG();						\
 	}								\
-} while (0)
-
-
-#define __put_user_err_check(x, ptr, err)				\
-do {									\
-	__chk_user_ptr(ptr);						\
-	uaccess_enable_not_uao();					\
-	__put_user_err_unsafe((x), (ptr), (err));			\
 	uaccess_disable_not_uao();					\
 } while (0)
 
-#define __put_user_err(x, ptr, err, accessor)				\
+#define __put_user_check(x, ptr, err)					\
 ({									\
 	__typeof__(*(ptr)) __user *__p = (ptr);				\
 	might_fault();							\
 	if (access_ok(VERIFY_WRITE, __p, sizeof(*__p))) {		\
 		__p = uaccess_mask_ptr(__p);				\
-		accessor((x), __p, (err));				\
+		__put_user_err((x), __p, (err));			\
 	} else	{							\
 		(err) = -EFAULT;					\
 	}								\
@@ -399,39 +388,19 @@ do {									\
 
 #define __put_user_error(x, ptr, err)					\
 ({									\
-	__put_user_err((x), (ptr), (err), __put_user_err_check);	\
+	__put_user_check((x), (ptr), (err));				\
 	(void)0;							\
 })
 
 #define __put_user(x, ptr)						\
 ({									\
 	int __pu_err = 0;						\
-	__put_user_err((x), (ptr), __pu_err, __put_user_err_check);	\
+	__put_user_check((x), (ptr), __pu_err);				\
 	__pu_err;							\
 })
 
 #define put_user	__put_user
 
-
-#define user_access_begin()	uaccess_enable_not_uao()
-#define user_access_end()	uaccess_disable_not_uao()
-
-#define unsafe_get_user(x, ptr, err)					\
-do {									\
-	int __gu_err = 0;						\
-	__get_user_err((x), (ptr), __gu_err, __get_user_err_unsafe);	\
-	if (__gu_err != 0)						\
-		goto err;						\
-} while (0)
-
-#define unsafe_put_user(x, ptr, err)					\
-do {									\
-	int __pu_err = 0;						\
-	__put_user_err((x), (ptr), __pu_err, __put_user_err_unsafe);	\
-	if (__pu_err != 0)						\
-		goto err;						\
-} while (0)
-
 extern unsigned long __must_check __arch_copy_from_user(void *to, const void __user *from, unsigned long n);
 #define raw_copy_from_user(to, from, n)					\
 ({									\
-- 
2.19.0
