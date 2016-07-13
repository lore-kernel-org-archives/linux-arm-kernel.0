From: keescook@chromium.org (Kees Cook)
Date: Wed, 13 Jul 2016 14:56:02 -0700
Subject: [PATCH v2 09/11] s390/uaccess: Enable hardened usercopy
In-Reply-To: <1468446964-22213-1-git-send-email-keescook@chromium.org>
References: <1468446964-22213-1-git-send-email-keescook@chromium.org>
Message-ID: <1468446964-22213-10-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enables CONFIG_HARDENED_USERCOPY checks on s390.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/s390/Kconfig       | 1 +
 arch/s390/lib/uaccess.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index a8c259059adf..9f694311c9ed 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -122,6 +122,7 @@ config S390
 	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_EARLY_PFN_TO_NID
+	select HAVE_ARCH_HARDENED_USERCOPY
 	select HAVE_ARCH_JUMP_LABEL
 	select CPU_NO_EFFICIENT_FFS if !HAVE_MARCH_Z9_109_FEATURES
 	select HAVE_ARCH_SECCOMP_FILTER
diff --git a/arch/s390/lib/uaccess.c b/arch/s390/lib/uaccess.c
index ae4de559e3a0..6986c20166f0 100644
--- a/arch/s390/lib/uaccess.c
+++ b/arch/s390/lib/uaccess.c
@@ -104,6 +104,7 @@ static inline unsigned long copy_from_user_mvcp(void *x, const void __user *ptr,
 
 unsigned long __copy_from_user(void *to, const void __user *from, unsigned long n)
 {
+	check_object_size(to, n, false);
 	if (static_branch_likely(&have_mvcos))
 		return copy_from_user_mvcos(to, from, n);
 	return copy_from_user_mvcp(to, from, n);
@@ -177,6 +178,7 @@ static inline unsigned long copy_to_user_mvcs(void __user *ptr, const void *x,
 
 unsigned long __copy_to_user(void __user *to, const void *from, unsigned long n)
 {
+	check_object_size(from, n, true);
 	if (static_branch_likely(&have_mvcos))
 		return copy_to_user_mvcos(to, from, n);
 	return copy_to_user_mvcs(to, from, n);
-- 
2.7.4
