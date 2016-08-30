From: mmarek@suse.com (Michal Marek)
Date: Tue, 30 Aug 2016 10:31:35 +0200
Subject: [PATCH] arm64: Set UTS_MACHINE in the Makefile
Message-ID: <1472545895-7237-1-git-send-email-mmarek@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The make rpm target depends on proper UTS_MACHINE definition.  Also, use
the variable in arch/arm64/kernel/setup.c, so that it's not accidentally
removed in the future.

Reported-and-tested-by: Fabian Vogt <fvogt@suse.com>
Signed-off-by: Michal Marek <mmarek@suse.com>
---
 arch/arm64/Makefile        | 2 ++
 arch/arm64/kernel/Makefile | 2 ++
 arch/arm64/kernel/setup.c  | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 5b54f8c021d8..ab3df36fdfbb 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -38,10 +38,12 @@ ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 AS		+= -EB
 LD		+= -EB
+UTS_MACHINE	:= aarch64_be
 else
 KBUILD_CPPFLAGS	+= -mlittle-endian
 AS		+= -EL
 LD		+= -EL
+UTS_MACHINE	:= aarch64
 endif
 
 CHECKFLAGS	+= -D__aarch64__
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 14f7b651c787..7d66bbaafc0c 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -10,6 +10,8 @@ CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_insn.o = -pg
 CFLAGS_REMOVE_return_address.o = -pg
 
+CFLAGS_setup.o = -DUTS_MACHINE='"$(UTS_MACHINE)"'
+
 # Object file lists.
 arm64-obj-y		:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   entry-fpsimd.o process.o ptrace.o setup.o signal.o	\
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 536dce22fe76..c5dd09778c75 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -228,7 +228,7 @@ void __init setup_arch(char **cmdline_p)
 {
 	pr_info("Boot CPU: AArch64 Processor [%08x]\n", read_cpuid_id());
 
-	sprintf(init_utsname()->machine, ELF_PLATFORM);
+	sprintf(init_utsname()->machine, UTS_MACHINE);
 	init_mm.start_code = (unsigned long) _text;
 	init_mm.end_code   = (unsigned long) _etext;
 	init_mm.end_data   = (unsigned long) _edata;
-- 
2.6.6
