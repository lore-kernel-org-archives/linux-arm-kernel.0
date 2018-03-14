From: jinb.park@samsung.com (Jinbum Park)
Date: Wed, 14 Mar 2018 10:32:56 +0900
Subject: [PATCH v2] arm: ubsan: select ARCH_HAS_UBSAN_SANITIZE_ALL
References: <CGME20180314013256epcms1p47a97f32cdcb5a7eaa9303dc4b2cb0ea9@epcms1p4>
Message-ID: <20180314013256epcms1p47a97f32cdcb5a7eaa9303dc4b2cb0ea9@epcms1p4>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To enable UBSAN on arm, ARCH_HAS_UBSAN_SANITIZE_ALL is needed to be selected.

Basic test has passed on Raspberry Pi2, Raspbian jessi lite with
CONFIG_UBSAN_SANITIZE_ALL, CONFIG_UBSAN_NULL.

Used compiler is gcc 5.5.0 in [2] (2017.10).

It would be a resend patch for [1] from Seung-Woo Kim.
There was some problems when [1] submitted before.

  P1) show -Warray-bounds that is not seen without UBSAN
  P2) too large stack size in crypto/serpent_generic.c
  P3) link error of ____ilog2_NaN, __aeabi_uldivmod

I've tried to build locally with allmodconfig to ensure that above errors are fixed.
The result is that P2), P3) have fixed, but P1) appears at diffent location.
But, Since gcc closed P1) issue as won't fix [3],
and It can be a helpful warning to user, we don't have to worry about P1).

build-environment that I used is as belows.

  - config: arm allmodconfig
  - compiler: gcc 5.5.0 in [2] (2017.10)
  - ubsan flag: UBSAN, UBSAN_SANITIZE_ALL, UBSAN_ALIGNMENT, UBSAN_NULL
  - linux version: linux/arm 4.16.0-rc4
  - CONFIG_FRAME_WARN: 1024 (default value)

[1] https://patchwork.kernel.org/patch/9189575/
[2] https://releases.linaro.org/components/toolchain/binaries/latest-5/arm-linux-gnueabi/
[3] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=78678

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jinbum Park <jinb.park@samsung.com>
Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
---
v2: Add sign of Seung-Woo Kim.
    Add commit message about history, build environment.
---
 arch/arm/Kconfig                  | 1 +
 arch/arm/boot/compressed/Makefile | 1 +
 arch/arm/vdso/Makefile            | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1878083..bdd1561 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -7,6 +7,7 @@ config ARM
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
+	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 45a6b9b..1b374ba 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -24,6 +24,7 @@ OBJS		+= hyp-stub.o
 endif
 
 GCOV_PROFILE		:= n
+UBSAN_SANITIZE		:= n
 
 #
 # Architecture dependencies
diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index bb411821..05597f7 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -29,6 +29,7 @@ CFLAGS_vgettimeofday.o = -O2
 
 # Disable gcov profiling for VDSO code
 GCOV_PROFILE := n
+UBSAN_SANITIZE := n
 
 # Force dependency
 $(obj)/vdso.o : $(obj)/vdso.so
-- 
1.9.1
