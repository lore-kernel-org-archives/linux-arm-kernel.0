From: riku.voipio@linaro.org (Riku Voipio)
Date: Mon,  8 Sep 2014 15:59:34 +0300
Subject: [PATCH] Enable gcov support on the ARM architecture
Message-ID: <1410181174-14977-1-git-send-email-riku.voipio@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable gcov support for ARM based on original patches by David
Singleton and George G. Davis

Riku - updated to patch to current mainline kernel. The patch
has been submitted in 2010, 2012 - for symmetry, now in 2014 too.

https://lwn.net/Articles/390419/
http://marc.info/?l=linux-arm-kernel&m=133823081813044

From: Vincent Sanders <vincent.sanders@collabora.co.uk>
Cc: Andrey Ryabinin <a.ryabinin@samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
Signed-off-by: Vincent Sanders <vincent.sanders@collabora.co.uk>
---
 arch/arm/boot/bootp/Makefile      | 2 ++
 arch/arm/boot/compressed/Makefile | 2 ++
 arch/arm/kernel/Makefile          | 2 ++
 kernel/gcov/Kconfig               | 2 +-
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/bootp/Makefile b/arch/arm/boot/bootp/Makefile
index c394e30..5761f00 100644
--- a/arch/arm/boot/bootp/Makefile
+++ b/arch/arm/boot/bootp/Makefile
@@ -5,6 +5,8 @@
 # architecture-specific flags and dependencies.
 #
 
+GCOV_PROFILE	:= n
+
 LDFLAGS_bootp	:=-p --no-undefined -X \
 		 --defsym initrd_phys=$(INITRD_PHYS) \
 		 --defsym params_phys=$(PARAMS_PHYS) -T
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 76a50ec..3ea230a 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -37,6 +37,8 @@ ifeq ($(CONFIG_ARM_VIRT_EXT),y)
 OBJS		+= hyp-stub.o
 endif
 
+GCOV_PROFILE		:= n
+
 #
 # Architecture dependencies
 #
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 38ddd9f..979c4e9 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -5,6 +5,8 @@
 CPPFLAGS_vmlinux.lds := -DTEXT_OFFSET=$(TEXT_OFFSET)
 AFLAGS_head.o        := -DTEXT_OFFSET=$(TEXT_OFFSET)
 
+GCOV_PROFILE := n
+
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_insn.o = -pg
diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
index d04ce8a..cf66c5c 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -35,7 +35,7 @@ config GCOV_KERNEL
 config GCOV_PROFILE_ALL
 	bool "Profile entire Kernel"
 	depends on GCOV_KERNEL
-	depends on SUPERH || S390 || X86 || PPC || MICROBLAZE
+	depends on SUPERH || S390 || X86 || PPC || MICROBLAZE || ARM
 	default n
 	---help---
 	This options activates profiling for the entire kernel.
-- 
2.0.1
