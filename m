From: keescook@chromium.org (Kees Cook)
Date: Wed, 6 Nov 2013 15:31:17 -0800
Subject: [PATCH] seccomp: not compatible with ARM OABI
Message-ID: <20131106233117.GA24545@www.outflux.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure that seccomp filter won't be built when ARM OABI is in use,
since there is work needed to distinguish calling conventions. Until
that is done (which is likely never since OABI is deprecated), make
sure seccomp filter is unavailable in the OABI compat world.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/Kconfig |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index af2cc6eabcc7..6eaca7d92399 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -331,12 +331,15 @@ config HAVE_ARCH_SECCOMP_FILTER
 
 config SECCOMP_FILTER
 	def_bool y
-	depends on HAVE_ARCH_SECCOMP_FILTER && SECCOMP && NET
+	depends on HAVE_ARCH_SECCOMP_FILTER && SECCOMP && NET && !OABI_COMPAT
 	help
 	  Enable tasks to build secure computing environments defined
 	  in terms of Berkeley Packet Filter programs which implement
 	  task-defined system call filtering polices.
 
+	  Not available on ARM when built with OABI compatibility due to
+	  lack of a sensible way to distinguish the calling conventions.
+
 	  See Documentation/prctl/seccomp_filter.txt for details.
 
 config HAVE_CONTEXT_TRACKING
-- 
1.7.9.5


-- 
Kees Cook
Chrome OS Security
