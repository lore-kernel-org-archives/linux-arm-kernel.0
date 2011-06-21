From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 21 Jun 2011 12:09:45 -0700
Subject: [PATCH] ARM: quiet sparse noise due to
	__ARCH_WANT_SYS_RT_SIG(ACTION|SUSPEND)
Message-ID: <201106211209.46462.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM defines __ARCH_WANT_SYS_RT_SIG(ACTION|SUSPEND) which
produces the following sparse warnings in kernel/signal.c:

  warning: symbol 'sys_rt_sigaction' was not declared. Should it be static?
  warning: symbol 'sys_rt_sigsuspend' was not declared. Should it be static?

Since ARM doesn't include <asm-generic/syscalls.h>, due to different
calling conventions for some system calls, prototype the functions
in <asm/unistd.h> to quiet the noise.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Mikael Pettersson <mikpe@it.uu.se>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Mike Frysinger <vapier@gentoo.org>
Cc: Tony Luck <tony.luck@intel.com>

---

diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
index 2c04ed5..322c54e 100644
--- a/arch/arm/include/asm/unistd.h
+++ b/arch/arm/include/asm/unistd.h
@@ -467,6 +467,20 @@
 #define __ARCH_WANT_SYS_SOCKETCALL
 #endif
 
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+#include <linux/linkage.h>
+#include <linux/compiler.h>
+#include <linux/signal.h>
+
+asmlinkage long sys_rt_sigaction(int sig, const struct sigaction __user *act,
+				 struct sigaction __user *oact,
+				 size_t sigsetsize);
+asmlinkage long sys_rt_sigsuspend(sigset_t __user *unewset, size_t sigsetsize);
+
+#endif /* !__ASSEMBLY__ */
+
 /*
  * "Conditional" syscalls
  *
