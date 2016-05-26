From: yang.shi@linaro.org (Yang Shi)
Date: Thu, 26 May 2016 11:43:51 -0700
Subject: [PATCH] arm64: kasan: instrument user memory access API
Message-ID: <1464288231-11304-1-git-send-email-yang.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The upstream commit 1771c6e1a567ea0ba2cccc0a4ffe68a1419fd8ef
("x86/kasan: instrument user memory access API") added KASAN instrument to
x86 user memory access API, so added such instrument to ARM64 too.

Tested by test_kasan module.

Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
 arch/arm64/include/asm/uaccess.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 0685d74..ec352fa 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -23,6 +23,7 @@
  */
 #include <linux/string.h>
 #include <linux/thread_info.h>
+#include <linux/kasan-checks.h>
 
 #include <asm/alternative.h>
 #include <asm/cpufeature.h>
@@ -276,6 +277,8 @@ extern unsigned long __must_check __clear_user(void __user *addr, unsigned long
 
 static inline unsigned long __must_check copy_from_user(void *to, const void __user *from, unsigned long n)
 {
+	kasan_check_write(to, n);
+
 	if (access_ok(VERIFY_READ, from, n))
 		n = __copy_from_user(to, from, n);
 	else /* security hole - plug it */
@@ -285,6 +288,8 @@ static inline unsigned long __must_check copy_from_user(void *to, const void __u
 
 static inline unsigned long __must_check copy_to_user(void __user *to, const void *from, unsigned long n)
 {
+	kasan_check_read(from, n);
+
 	if (access_ok(VERIFY_WRITE, to, n))
 		n = __copy_to_user(to, from, n);
 	return n;
@@ -297,8 +302,17 @@ static inline unsigned long __must_check copy_in_user(void __user *to, const voi
 	return n;
 }
 
-#define __copy_to_user_inatomic __copy_to_user
-#define __copy_from_user_inatomic __copy_from_user
+static inline unsigned long __copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
+{
+	kasan_check_read(from, n);
+	return __copy_to_user(to, from, n);
+}
+
+static inline unsigned long __copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
+{
+	kasan_check_write(to, n);
+	return __copy_from_user(to, from, n);
+}
 
 static inline unsigned long __must_check clear_user(void __user *to, unsigned long n)
 {
-- 
2.0.2
