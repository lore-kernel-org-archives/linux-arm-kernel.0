From: dvyukov@google.com (Dmitry Vyukov)
Date: Thu, 26 Apr 2018 15:08:46 +0200
Subject: [PATCH] arm: port KCOV to arm
Message-ID: <20180426130846.130976-1-dvyukov@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

KCOV is code coverage collection facility used, in particular, by syzkaller
system call fuzzer. There is some interest in using syzkaller on arm devices.
So port KCOV to arm.

On implementation level this merely declares that KCOV is supported and
disables instrumentation of 3 special cases. Reasons for disabling are
commented in code.

Tested with qemu-system-arm/vexpress-a15.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Abbott Liu <liuwenliang@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Koguchi Takuo <takuo.koguchi.sw@hitachi.com>
Cc: Atul Prakash <atulp@google.com>
Cc: linux at armlinux.org.uk
Cc: linux-arm-kernel at lists.infradead.org
Cc: syzkaller at googlegroups.com
---
 arch/arm/Kconfig                  | 1 +
 arch/arm/boot/compressed/Makefile | 3 +++
 arch/arm/mm/Makefile              | 4 ++++
 arch/arm/vdso/Makefile            | 3 +++
 4 files changed, 11 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a7f8e7f4b88f..60558a6bb744 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -105,6 +105,7 @@ config ARM
 	select REFCOUNT_FULL
 	select RTC_LIB
 	select SYS_SUPPORTS_APM_EMULATION
+	select ARCH_HAS_KCOV
 	# Above selects are sorted alphabetically; please add new ones
 	# according to that.  Thanks.
 	help
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 45a6b9b7af2a..5219700e9161 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -25,6 +25,9 @@ endif
 
 GCOV_PROFILE		:= n
 
+# Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
+KCOV_INSTRUMENT		:= n
+
 #
 # Architecture dependencies
 #
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 9dbb84923e12..e8be5d904ac7 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -8,6 +8,10 @@ obj-y				+= dma-mapping$(MMUEXT).o
 obj-$(CONFIG_MMU)		+= fault-armv.o flush.o idmap.o ioremap.o \
 				   mmap.o pgd.o mmu.o pageattr.o
 
+# Instrumenting fault.c causes infinite recursion between:
+# __dabt_svc -> do_DataAbort -> __sanitizer_cov_trace_pc -> __dabt_svc
+KCOV_INSTRUMENT_fault.o := n
+
 ifneq ($(CONFIG_MMU),y)
 obj-y				+= nommu.o
 obj-$(CONFIG_ARM_MPU)		+= pmsa-v7.o
diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index bb4118213fee..f4efff9d3afb 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -30,6 +30,9 @@ CFLAGS_vgettimeofday.o = -O2
 # Disable gcov profiling for VDSO code
 GCOV_PROFILE := n
 
+# Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
+KCOV_INSTRUMENT := n
+
 # Force dependency
 $(obj)/vdso.o : $(obj)/vdso.so
 
-- 
2.17.0.484.g0c8726318c-goog
