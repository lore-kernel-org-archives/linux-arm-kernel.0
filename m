From: sw0312.kim@samsung.com (Seung-Woo Kim)
Date: Thu, 22 Sep 2016 13:49:17 +0900
Subject: [PATCH] arm: ubsan: select ARCH_HAS_UBSAN_SANITIZE_ALL
Message-ID: <1474519757-10228-1-git-send-email-sw0312.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To enable UBSAN on arm, this patch enables ARCH_HAS_UBSAN_SANITIZE_ALL
from arm confiuration. Basic kernel bootup test is passed on arm with
CONFIG_UBSAN_SANITIZE_ALL enabled.

Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
---
This is resend of the patch I already sent, [1], without RFC tag.
[1] https://patchwork.kernel.org/patch/9189533/

I tested kernel build and basic boot up on Exynos5422, Exynos4412 and
Exynos3250 SoC boards.

At previous time on [1], there were some build error on other systems,
but they were caused by driver bug or gcc bug. So I think UBSAN on ARM
can be re-considered.
---
 arch/arm/Kconfig                  |    1 +
 arch/arm/boot/compressed/Makefile |    1 +
 arch/arm/vdso/Makefile            |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a9c4e48..a80f9b1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -7,6 +7,7 @@ config ARM
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_USE_BUILTIN_BSWAP
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index d50430c..883374f 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -23,6 +23,7 @@ OBJS		+= hyp-stub.o
 endif
 
 GCOV_PROFILE		:= n
+UBSAN_SANITIZE		:= n
 
 #
 # Architecture dependencies
diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index 59a8fa7..cb90e59 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -28,6 +28,7 @@ CFLAGS_vgettimeofday.o = -O2
 
 # Disable gcov profiling for VDSO code
 GCOV_PROFILE := n
+UBSAN_SANITIZE := n
 
 # Force dependency
 $(obj)/vdso.o : $(obj)/vdso.so
-- 
1.7.4.1
