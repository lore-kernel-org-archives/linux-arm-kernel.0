From: keescook@chromium.org (Kees Cook)
Date: Wed, 20 Jul 2016 13:27:00 -0700
Subject: [PATCH v4 05/12] ARM: uaccess: Enable hardened usercopy
In-Reply-To: <1469046427-12696-1-git-send-email-keescook@chromium.org>
References: <1469046427-12696-1-git-send-email-keescook@chromium.org>
Message-ID: <1469046427-12696-6-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enables CONFIG_HARDENED_USERCOPY checks on arm.

Based on code from PaX and grsecurity.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/Kconfig               |  1 +
 arch/arm/include/asm/uaccess.h | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 90542db1220d..f56b29b3f57e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -35,6 +35,7 @@ config ARM
 	select HARDIRQS_SW_RESEND
 	select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
 	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
+	select HAVE_ARCH_HARDENED_USERCOPY
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
 	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 35c9db857ebe..7fb59199c6bb 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -496,7 +496,10 @@ arm_copy_from_user(void *to, const void __user *from, unsigned long n);
 static inline unsigned long __must_check
 __copy_from_user(void *to, const void __user *from, unsigned long n)
 {
-	unsigned int __ua_flags = uaccess_save_and_enable();
+	unsigned int __ua_flags;
+
+	check_object_size(to, n, false);
+	__ua_flags = uaccess_save_and_enable();
 	n = arm_copy_from_user(to, from, n);
 	uaccess_restore(__ua_flags);
 	return n;
@@ -511,11 +514,15 @@ static inline unsigned long __must_check
 __copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 #ifndef CONFIG_UACCESS_WITH_MEMCPY
-	unsigned int __ua_flags = uaccess_save_and_enable();
+	unsigned int __ua_flags;
+
+	check_object_size(from, n, true);
+	__ua_flags = uaccess_save_and_enable();
 	n = arm_copy_to_user(to, from, n);
 	uaccess_restore(__ua_flags);
 	return n;
 #else
+	check_object_size(from, n, true);
 	return arm_copy_to_user(to, from, n);
 #endif
 }
-- 
2.7.4
