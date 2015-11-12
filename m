From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Nov 2015 15:37:12 +0100
Subject: [PATCH] ARM64: build vdso without libgcov
Message-ID: <8988881.1vH1oNjPUl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On a cross-toolchain without glibc support, libgcov may not be
available, and attempting to build an arm64 kernel with GCOV
enabled then results in a build error:

/home/arnd/cross-gcc/lib/gcc/aarch64-linux/5.2.1/../../../../aarch64-linux/bin/ld: cannot find -lgcov

We don't really want to link libgcov into the vdso anyway, so
this patch just disables GCOV in the vdso directory, just as
we do for most other architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Found trying to build allmodconfig

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index f6fe17d88da5..b467fd0a384b 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -15,6 +15,9 @@ ccflags-y := -shared -fno-common -fno-builtin
 ccflags-y += -nostdlib -Wl,-soname=linux-vdso.so.1 \
 		$(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
 
+# Disable gcov profiling for VDSO code
+GCOV_PROFILE := n
+
 # Workaround for bare-metal (ELF) toolchains that neglect to pass -shared
 # down to collect2, resulting in silent corruption of the vDSO image.
 ccflags-y += -Wl,-shared
