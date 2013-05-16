From: mst@redhat.com (Michael S. Tsirkin)
Date: Thu, 16 May 2013 14:11:04 +0300
Subject: [PATCH v2 04/10] m32r: uaccess s/might_sleep/might_fault/
In-Reply-To: <cover.1368702323.git.mst@redhat.com>
References: <cover.1368702323.git.mst@redhat.com>
Message-ID: <8b99c8a5fb9dc4ee9a39f96ecb3b9c02c97a8ba2.1368702323.git.mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only reason uaccess routines might sleep
is if they fault. Make this explicit.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/m32r/include/asm/uaccess.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/m32r/include/asm/uaccess.h b/arch/m32r/include/asm/uaccess.h
index 1c7047b..84fe7ba 100644
--- a/arch/m32r/include/asm/uaccess.h
+++ b/arch/m32r/include/asm/uaccess.h
@@ -216,7 +216,7 @@ extern int fixup_exception(struct pt_regs *regs);
 ({									\
 	long __gu_err = 0;						\
 	unsigned long __gu_val;						\
-	might_sleep();							\
+	might_fault();							\
 	__get_user_size(__gu_val,(ptr),(size),__gu_err);		\
 	(x) = (__typeof__(*(ptr)))__gu_val;				\
 	__gu_err;							\
@@ -227,7 +227,7 @@ extern int fixup_exception(struct pt_regs *regs);
 	long __gu_err = -EFAULT;					\
 	unsigned long __gu_val = 0;					\
 	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
-	might_sleep();							\
+	might_fault();							\
 	if (access_ok(VERIFY_READ,__gu_addr,size))			\
 		__get_user_size(__gu_val,__gu_addr,(size),__gu_err);	\
 	(x) = (__typeof__(*(ptr)))__gu_val;				\
@@ -295,7 +295,7 @@ do {									\
 #define __put_user_nocheck(x,ptr,size)					\
 ({									\
 	long __pu_err;							\
-	might_sleep();							\
+	might_fault();							\
 	__put_user_size((x),(ptr),(size),__pu_err);			\
 	__pu_err;							\
 })
@@ -305,7 +305,7 @@ do {									\
 ({									\
 	long __pu_err = -EFAULT;					\
 	__typeof__(*(ptr)) __user *__pu_addr = (ptr);			\
-	might_sleep();							\
+	might_fault();							\
 	if (access_ok(VERIFY_WRITE,__pu_addr,size))			\
 		__put_user_size((x),__pu_addr,(size),__pu_err);		\
 	__pu_err;							\
@@ -597,7 +597,7 @@ unsigned long __generic_copy_from_user(void *, const void __user *, unsigned lon
  */
 #define copy_to_user(to,from,n)				\
 ({							\
-	might_sleep();					\
+	might_fault();					\
 	__generic_copy_to_user((to),(from),(n));	\
 })
 
@@ -638,7 +638,7 @@ unsigned long __generic_copy_from_user(void *, const void __user *, unsigned lon
  */
 #define copy_from_user(to,from,n)			\
 ({							\
-	might_sleep();					\
+	might_fault();					\
 	__generic_copy_from_user((to),(from),(n));	\
 })
 
-- 
MST
