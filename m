From: alex.shi@linaro.org (Alex Shi)
Date: Fri,  9 Mar 2018 17:06:50 +0800
Subject: [PATCH 07/39] arm64: Use pointer masking to limit uaccess speculation
In-Reply-To: <20180309090722.26279-1-alex.shi@linaro.org>
References: <20180309090722.26279-1-alex.shi@linaro.org>
Message-ID: <20180309090722.26279-8-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robin Murphy <robin.murphy@arm.com>

commit 4d8efc2d5ee4 upstream.

Similarly to x86, mitigate speculation past an access_ok() check by
masking the pointer against the address limit before use.

Even if we don't expect speculative writes per se, it is plausible that
a CPU may still speculate at least as far as fetching a cache line for
writing, hence we also harden put_user() and clear_user() for peace of
mind.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/include/asm/uaccess.h | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index c625cc5531fc..75363d723262 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -121,6 +121,26 @@ static inline unsigned long __range_ok(unsigned long addr, unsigned long size)
 #define access_ok(type, addr, size)	__range_ok((unsigned long)(addr), size)
 #define user_addr_max			get_fs
 
+/*
+ * Sanitise a uaccess pointer such that it becomes NULL if above the
+ * current addr_limit.
+ */
+#define uaccess_mask_ptr(ptr) (__typeof__(ptr))__uaccess_mask_ptr(ptr)
+static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
+{
+	void __user *safe_ptr;
+
+	asm volatile(
+	"	bics	xzr, %1, %2\n"
+	"	csel	%0, %1, xzr, eq\n"
+	: "=&r" (safe_ptr)
+	: "r" (ptr), "r" (current_thread_info()->addr_limit)
+	: "cc");
+
+	csdb();
+	return safe_ptr;
+}
+
 /*
  * The "__xxx" versions of the user access functions do not verify the address
  * space - it must have been done previously with a separate "access_ok()"
@@ -193,7 +213,7 @@ do {									\
 	__typeof__(*(ptr)) __user *__p = (ptr);				\
 	might_fault();							\
 	access_ok(VERIFY_READ, __p, sizeof(*__p)) ?			\
-		__get_user((x), __p) :					\
+		__p = uaccess_mask_ptr(__p), __get_user((x), __p) :	\
 		((x) = 0, -EFAULT);					\
 })
 
@@ -259,7 +279,7 @@ do {									\
 	__typeof__(*(ptr)) __user *__p = (ptr);				\
 	might_fault();							\
 	access_ok(VERIFY_WRITE, __p, sizeof(*__p)) ?			\
-		__put_user((x), __p) :					\
+		__p = uaccess_mask_ptr(__p), __put_user((x), __p) :	\
 		-EFAULT;						\
 })
 
@@ -297,7 +317,7 @@ static inline unsigned long __must_check copy_in_user(void __user *to, const voi
 static inline unsigned long __must_check clear_user(void __user *to, unsigned long n)
 {
 	if (access_ok(VERIFY_WRITE, to, n))
-		n = __clear_user(to, n);
+		n = __clear_user(__uaccess_mask_ptr(to), n);
 	return n;
 }
 
-- 
2.16.2.440.gc6284da
