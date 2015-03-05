From: keescook@chromium.org (Kees Cook)
Date: Wed,  4 Mar 2015 17:27:06 -0800
Subject: [PATCH v3 6/8] powerpc: switch to using asm-generic for seccomp.h
In-Reply-To: <1425518828-16017-1-git-send-email-keescook@chromium.org>
References: <1425518828-16017-1-git-send-email-keescook@chromium.org>
Message-ID: <1425518828-16017-7-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to using the newly created asm-generic/seccomp.h for the seccomp
strict mode syscall definitions. The obsolete sigreturn in COMPAT mode
is retained as an override. Remaining definitions are identical, though
they incorrectly appeared in uapi, which has been corrected.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/include/asm/seccomp.h      | 10 ++++++++++
 arch/powerpc/include/uapi/asm/Kbuild    |  1 -
 arch/powerpc/include/uapi/asm/seccomp.h | 16 ----------------
 3 files changed, 10 insertions(+), 17 deletions(-)
 create mode 100644 arch/powerpc/include/asm/seccomp.h
 delete mode 100644 arch/powerpc/include/uapi/asm/seccomp.h

diff --git a/arch/powerpc/include/asm/seccomp.h b/arch/powerpc/include/asm/seccomp.h
new file mode 100644
index 000000000000..c1818e35cf02
--- /dev/null
+++ b/arch/powerpc/include/asm/seccomp.h
@@ -0,0 +1,10 @@
+#ifndef _ASM_POWERPC_SECCOMP_H
+#define _ASM_POWERPC_SECCOMP_H
+
+#include <linux/unistd.h>
+
+#define __NR_seccomp_sigreturn_32 __NR_sigreturn
+
+#include <asm-generic/seccomp.h>
+
+#endif	/* _ASM_POWERPC_SECCOMP_H */
diff --git a/arch/powerpc/include/uapi/asm/Kbuild b/arch/powerpc/include/uapi/asm/Kbuild
index 7a3f795ac218..79c4068be278 100644
--- a/arch/powerpc/include/uapi/asm/Kbuild
+++ b/arch/powerpc/include/uapi/asm/Kbuild
@@ -25,7 +25,6 @@ header-y += posix_types.h
 header-y += ps3fb.h
 header-y += ptrace.h
 header-y += resource.h
-header-y += seccomp.h
 header-y += sembuf.h
 header-y += setup.h
 header-y += shmbuf.h
diff --git a/arch/powerpc/include/uapi/asm/seccomp.h b/arch/powerpc/include/uapi/asm/seccomp.h
deleted file mode 100644
index 00c1d9133cfe..000000000000
--- a/arch/powerpc/include/uapi/asm/seccomp.h
+++ /dev/null
@@ -1,16 +0,0 @@
-#ifndef _ASM_POWERPC_SECCOMP_H
-#define _ASM_POWERPC_SECCOMP_H
-
-#include <linux/unistd.h>
-
-#define __NR_seccomp_read __NR_read
-#define __NR_seccomp_write __NR_write
-#define __NR_seccomp_exit __NR_exit
-#define __NR_seccomp_sigreturn __NR_rt_sigreturn
-
-#define __NR_seccomp_read_32 __NR_read
-#define __NR_seccomp_write_32 __NR_write
-#define __NR_seccomp_exit_32 __NR_exit
-#define __NR_seccomp_sigreturn_32 __NR_sigreturn
-
-#endif	/* _ASM_POWERPC_SECCOMP_H */
-- 
1.9.1
