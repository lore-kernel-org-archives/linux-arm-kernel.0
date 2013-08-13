From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 13 Aug 2013 00:12:11 -0700
Subject: [PATCH] ARM: signal: sigreturn_codes should be endian neutral to work
 in BE8
Message-ID: <1376377931-2262-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case of BE8 kernel data is in BE order whereas code stays in LE
order. sigreturn_codes array initializer need to use macros from
<asm/opcodes.h> to setup instructions code in endian neutral way.

Problem was discovered during ltp testing of BE system: all rt_sig*
tests failed. Tested against the same tests in both BE and LE modes.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
---
 arch/arm/kernel/signal.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index ab33042..333a67f 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -20,25 +20,26 @@
 #include <asm/ucontext.h>
 #include <asm/unistd.h>
 #include <asm/vfp.h>
+#include <asm/opcodes.h>
 
 /*
  * For ARM syscalls, we encode the syscall number into the instruction.
  */
-#define SWI_SYS_SIGRETURN	(0xef000000|(__NR_sigreturn)|(__NR_OABI_SYSCALL_BASE))
-#define SWI_SYS_RT_SIGRETURN	(0xef000000|(__NR_rt_sigreturn)|(__NR_OABI_SYSCALL_BASE))
+#define SWI_SYS_SIGRETURN	(__opcode_to_mem_arm(0xef000000|(__NR_sigreturn)|(__NR_OABI_SYSCALL_BASE)))
+#define SWI_SYS_RT_SIGRETURN	(__opcode_to_mem_arm(0xef000000|(__NR_rt_sigreturn)|(__NR_OABI_SYSCALL_BASE)))
 
 /*
  * With EABI, the syscall number has to be loaded into r7.
  */
-#define MOV_R7_NR_SIGRETURN	(0xe3a07000 | (__NR_sigreturn - __NR_SYSCALL_BASE))
-#define MOV_R7_NR_RT_SIGRETURN	(0xe3a07000 | (__NR_rt_sigreturn - __NR_SYSCALL_BASE))
+#define MOV_R7_NR_SIGRETURN	(__opcode_to_mem_arm(0xe3a07000 | (__NR_sigreturn - __NR_SYSCALL_BASE)))
+#define MOV_R7_NR_RT_SIGRETURN	(__opcode_to_mem_arm(0xe3a07000 | (__NR_rt_sigreturn - __NR_SYSCALL_BASE)))
 
 /*
  * For Thumb syscalls, we pass the syscall number via r7.  We therefore
  * need two 16-bit instructions.
  */
-#define SWI_THUMB_SIGRETURN	(0xdf00 << 16 | 0x2700 | (__NR_sigreturn - __NR_SYSCALL_BASE))
-#define SWI_THUMB_RT_SIGRETURN	(0xdf00 << 16 | 0x2700 | (__NR_rt_sigreturn - __NR_SYSCALL_BASE))
+#define SWI_THUMB_SIGRETURN    (__opcode_to_mem_arm(0xdf00 << 16 | 0x2700 | (__NR_sigreturn - __NR_SYSCALL_BASE)))
+#define SWI_THUMB_RT_SIGRETURN (__opcode_to_mem_arm(0xdf00 << 16 | 0x2700 | (__NR_rt_sigreturn - __NR_SYSCALL_BASE)))
 
 static const unsigned long sigreturn_codes[7] = {
 	MOV_R7_NR_SIGRETURN,    SWI_SYS_SIGRETURN,    SWI_THUMB_SIGRETURN,
-- 
1.8.1.4
