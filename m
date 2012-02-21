From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 21 Feb 2012 14:04:15 +0200
Subject: [PATCH - linux-next] ARM: ptrace: Fix audit caused compile error
Message-ID: <1329825855-11902-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While trying to compile the kernel for ARM (omap2plus_defconfig) the kernel
build fails with:

arch/arm/kernel/ptrace.c: In function ?syscall_trace?:
arch/arm/kernel/ptrace.c:920:3: error: implicit declaration of function ?audit_syscall_exit?
arch/arm/kernel/ptrace.c:922:3: error: implicit declaration of function ?audit_syscall_entry?
arch/arm/kernel/ptrace.c:922:23: error: ?AUDIT_ARCH_ARMEB? undeclared (first use in this function)
arch/arm/kernel/ptrace.c:922:23: note: each undeclared identifier is reported only once for each function it appears in
make[1]: *** [arch/arm/kernel/ptrace.o] Error 1

The issue created by commit:
29ef73b7 Kernel: Audit Support For The ARM Platform

We need to include the linux/audit.h header to the arch/arm/kernel/ptrace.c
file to be able to compile the kernel.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/kernel/ptrace.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index e33870f..8e41ad2 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -15,6 +15,7 @@
 #include <linux/elf.h>
 #include <linux/smp.h>
 #include <linux/ptrace.h>
+#include <linux/audit.h>
 #include <linux/user.h>
 #include <linux/security.h>
 #include <linux/init.h>
-- 
1.7.8.4
