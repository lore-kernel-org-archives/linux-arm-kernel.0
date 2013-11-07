From: keescook@chromium.org (Kees Cook)
Date: Thu, 7 Nov 2013 09:47:46 -0800
Subject: [PATCH v2] seccomp: not compatible with ARM OABI
Message-ID: <20131107174746.GA22344@www.outflux.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure that seccomp filter won't be built when ARM OABI is in use,
since there is work needed to distinguish calling conventions. Until
that is done (which is likely never since OABI is deprecated), make
sure seccomp filter is unavailable in the OABI world.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2:
 - toggle availability via HAVE_ARCH_SECCOMP_FILTER; James Hogan.
---
 arch/arm/Kconfig |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0a1dc697333c..a0a8590f3609 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -23,7 +23,7 @@ config ARM
 	select HARDIRQS_SW_RESEND
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
 	select HAVE_ARCH_KGDB
-	select HAVE_ARCH_SECCOMP_FILTER
+	select HAVE_ARCH_SECCOMP_FILTER if (AEABI && !OABI_COMPAT)
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_BPF_JIT
 	select HAVE_CONTEXT_TRACKING
@@ -1735,6 +1735,11 @@ config OABI_COMPAT
 	  in memory differs between the legacy ABI and the new ARM EABI
 	  (only for non "thumb" binaries). This option adds a tiny
 	  overhead to all syscalls and produces a slightly larger kernel.
+
+	  The seccomp filter system will not be available when this is
+	  selected, since there is no way yet to sensibly distinguish
+	  between calling conventions during filtering.
+
 	  If you know you'll be using only pure EABI user space then you
 	  can say N here. If this option is not selected and you attempt
 	  to execute a legacy ABI binary then the result will be
-- 
1.7.9.5


-- 
Kees Cook
Chrome OS Security
