From: mmarek@suse.com (Michal Marek)
Date: Tue, 30 Aug 2016 16:28:49 +0200
Subject: [PATCH v2] arm64: Set UTS_MACHINE in the Makefile
In-Reply-To: <a2518725-e0ed-06de-ee1b-bcc70c455263@suse.com>
References: <a2518725-e0ed-06de-ee1b-bcc70c455263@suse.com>
Message-ID: <1472567329-10254-1-git-send-email-mmarek@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

UTS_MACHINE is set to the kbuild architecture name by the main Makefile,
and optionally adjusted by the arch Makefiles, so that it holds the
architecture name as presented to userspace (uname -m). In particular,
the make rpm target relies on proper UTS_MACHINE definition. Do the same
in the arm64 Makefile and also, use the variable in
arch/arm64/kernel/setup.c, so that it's not accidentally removed in the
future. Meanwhile, the make deb-pkg target adapted to the wrong
UTS_MACHINE definition, fix that as well.

Reported-and-tested-by: Fabian Vogt <fvogt@suse.com>
Signed-off-by: Michal Marek <mmarek@suse.com>
---

v2: Explain the problem more in the changelog and also fix make deb-pkg
    (thanks to Will Deacon)

 arch/arm64/Makefile        | 2 ++
 arch/arm64/kernel/Makefile | 2 ++
 arch/arm64/kernel/setup.c  | 2 +-
 scripts/package/builddeb   | 2 +-
 4 files changed, 6 insertions(+), 2 deletions(-)

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
diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index e1c09e2f9be7..b8900db5115a 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -51,7 +51,7 @@ set_debarch() {
 		debarch=hppa ;;
 	mips*)
 		debarch=mips$(grep -q CPU_LITTLE_ENDIAN=y $KCONFIG_CONFIG && echo el || true) ;;
-	arm64)
+	aarch64*)
 		debarch=arm64 ;;
 	arm*)
 		if grep -q CONFIG_AEABI=y $KCONFIG_CONFIG; then
-- 
2.6.6
