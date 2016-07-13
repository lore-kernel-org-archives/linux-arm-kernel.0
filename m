From: keescook@chromium.org (Kees Cook)
Date: Wed, 13 Jul 2016 14:56:00 -0700
Subject: [PATCH v2 07/11] powerpc/uaccess: Enable hardened usercopy
In-Reply-To: <1468446964-22213-1-git-send-email-keescook@chromium.org>
References: <1468446964-22213-1-git-send-email-keescook@chromium.org>
Message-ID: <1468446964-22213-8-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enables CONFIG_HARDENED_USERCOPY checks on powerpc.

Based on code from PaX and grsecurity.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/Kconfig               |  1 +
 arch/powerpc/include/asm/uaccess.h | 21 +++++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 01f7464d9fea..b7a18b2604be 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -164,6 +164,7 @@ config PPC
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT
 	select HAVE_LIVEPATCH if HAVE_DYNAMIC_FTRACE_WITH_REGS
+	select HAVE_ARCH_HARDENED_USERCOPY
 
 config GENERIC_CSUM
 	def_bool CPU_LITTLE_ENDIAN
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index b7c20f0b8fbe..c1dc6c14deb8 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -310,10 +310,15 @@ static inline unsigned long copy_from_user(void *to,
 {
 	unsigned long over;
 
-	if (access_ok(VERIFY_READ, from, n))
+	if (access_ok(VERIFY_READ, from, n)) {
+		if (!__builtin_constant_p(n))
+			check_object_size(to, n, false);
 		return __copy_tofrom_user((__force void __user *)to, from, n);
+	}
 	if ((unsigned long)from < TASK_SIZE) {
 		over = (unsigned long)from + n - TASK_SIZE;
+		if (!__builtin_constant_p(n - over))
+			check_object_size(to, n - over, false);
 		return __copy_tofrom_user((__force void __user *)to, from,
 				n - over) + over;
 	}
@@ -325,10 +330,15 @@ static inline unsigned long copy_to_user(void __user *to,
 {
 	unsigned long over;
 
-	if (access_ok(VERIFY_WRITE, to, n))
+	if (access_ok(VERIFY_WRITE, to, n)) {
+		if (!__builtin_constant_p(n))
+			check_object_size(from, n, true);
 		return __copy_tofrom_user(to, (__force void __user *)from, n);
+	}
 	if ((unsigned long)to < TASK_SIZE) {
 		over = (unsigned long)to + n - TASK_SIZE;
+		if (!__builtin_constant_p(n))
+			check_object_size(from, n - over, true);
 		return __copy_tofrom_user(to, (__force void __user *)from,
 				n - over) + over;
 	}
@@ -372,6 +382,10 @@ static inline unsigned long __copy_from_user_inatomic(void *to,
 		if (ret == 0)
 			return 0;
 	}
+
+	if (!__builtin_constant_p(n))
+		check_object_size(to, n, false);
+
 	return __copy_tofrom_user((__force void __user *)to, from, n);
 }
 
@@ -398,6 +412,9 @@ static inline unsigned long __copy_to_user_inatomic(void __user *to,
 		if (ret == 0)
 			return 0;
 	}
+	if (!__builtin_constant_p(n))
+		check_object_size(from, n, true);
+
 	return __copy_tofrom_user(to, (__force const void __user *)from, n);
 }
 
-- 
2.7.4
