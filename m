From: dave.martin@linaro.org (Dave Martin)
Date: Thu,  8 Sep 2011 17:04:12 +0100
Subject: [PATCH v2 1/3] ARM: iwmmxt: Fix Makefile rules for building iwmmxt
	for Thumb-2
In-Reply-To: <1315497854-13311-1-git-send-email-dave.martin@linaro.org>
References: <1315497854-13311-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1315497854-13311-2-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because gcc/gas have no sane way to turn on individual CPU
extensions from the command-line, iwmmxt.S was previously built
with -mcpu=iwmmxt.  Unfortunately, this also downgrades the CPU to
v5, with the result that this file fails to build for a Thumb-2
kernel.

New versions of the tools support -march=<base arch>+iwmmxt, and it
seems reasonable to require up-to-date tools when building in
Thumb-2.  So, this patch uses -march=armv7-a+iwmmxt for
CONFIG_THUMB2_KERNEL=y.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/kernel/Makefile |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index f7887dc..e03691e 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -66,6 +66,18 @@ obj-$(CONFIG_IWMMXT)		+= iwmmxt.o
 obj-$(CONFIG_CPU_HAS_PMU)	+= pmu.o
 obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
 AFLAGS_iwmmxt.o			:= -Wa,-mcpu=iwmmxt
+ifdef CONFIG_CPU_V7
+AFLAGS_iwmmxt.o			:= $(call cc-option,-Wa$(comma)-march=armv7-a+iwmmxt,-DIWMMXT_LEGACY_ASSEMBLER)
+ifeq ($(AFLAGS_iwmmxt.o),-DIWMMXT_LEGACY_ASSEMBLER)
+ifdef CONFIG_THUMB2_KERNEL
+$(error Newer binutils is needed to build iwmmxt support for Thumb-2 kernels.)
+else
+$(warning Warning: Building legacy pre-v7 iwmmxt code for a v7 target.\
+  This is inadvisable.  Please upgrade to newer binutils.)
+AFLAGS_iwmmxt.o			+= -Wa,-mcpu=iwmmxt
+endif
+endif
+endif # CONFIG_CPU_V7
 
 ifneq ($(CONFIG_ARCH_EBSA110),y)
   obj-y		+= io.o
-- 
1.7.4.1
