From: gang.chen@asianux.com (Chen Gang)
Date: Sat, 22 Jun 2013 13:54:14 +0800
Subject: [PATCH] arch: arm64: kernel: add '#ifdef CONFIG_COMPAT' for
 aarch32_break_handler()
Message-ID: <51C53C06.7050205@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


If 'COMPAT' not defined, aarch32_break_handler() cannot pass compiling,
so need add '#ifdef' for it just like the header file has done.

The related make:

  make ARCH=arm64 randconfig
  make ARCH=arm64 menuconfig
  make ARCH=arm64 V=1 EXTRA_CFLAGS=-W

The related error:

  arch/arm64/kernel/debug-monitors.c:249:5: error: redefinition of ?aarch32_break_handler?
  In file included from arch/arm64/kernel/debug-monitors.c:29:0:
  /root/linux-next/arch/arm64/include/asm/debug-monitors.h:89:12: note: previous definition of ?aarch32_break_handler? was here


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm64/kernel/debug-monitors.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 08018e3..ceedcd7 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -246,6 +246,7 @@ static int brk_handler(unsigned long addr, unsigned int esr,
 	return 0;
 }
 
+#ifdef CONFIG_COMPAT
 int aarch32_break_handler(struct pt_regs *regs)
 {
 	siginfo_t info;
@@ -285,6 +286,7 @@ int aarch32_break_handler(struct pt_regs *regs)
 	force_sig_info(SIGTRAP, &info, current);
 	return 0;
 }
+#endif
 
 static int __init debug_traps_init(void)
 {
-- 
1.7.7.6
