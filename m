From: dave.martin@linaro.org (Dave Martin)
Date: Wed,  7 Sep 2011 16:59:16 +0100
Subject: [RFC PATCH 1/3] ARM: iwmmxt: Fix Makefile rules for building iwmmxt
	for Thumb-2
In-Reply-To: <1315411158-17479-1-git-send-email-dave.martin@linaro.org>
References: <1315411158-17479-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1315411158-17479-2-git-send-email-dave.martin@linaro.org>
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
 arch/arm/kernel/Makefile |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index f7887dc..8a58339 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -65,7 +65,14 @@ obj-$(CONFIG_CPU_PJ4)		+= pj4-cp0.o
 obj-$(CONFIG_IWMMXT)		+= iwmmxt.o
 obj-$(CONFIG_CPU_HAS_PMU)	+= pmu.o
 obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
+
+# When enough people have binutils which support -march=...+iwmmxt, this
+# should change to something like if __LINUX_ARM_ARCH__ < 7.
+ifdef CONFIG_THUMB2_KERNEL
+AFLAGS_iwmmxt.o			:= -Wa,-march=armv7-a+iwmmxt
+else
 AFLAGS_iwmmxt.o			:= -Wa,-mcpu=iwmmxt
+endif
 
 ifneq ($(CONFIG_ARCH_EBSA110),y)
   obj-y		+= io.o
-- 
1.7.4.1
