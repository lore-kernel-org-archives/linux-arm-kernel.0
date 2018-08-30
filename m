From: digetx@gmail.com (Dmitry Osipenko)
Date: Thu, 30 Aug 2018 21:04:19 +0300
Subject: [PATCH v3 6/8] ARM: tegra: Always boot CPU in ARM-mode
In-Reply-To: <20180830180421.6415-1-digetx@gmail.com>
References: <20180830180421.6415-1-digetx@gmail.com>
Message-ID: <20180830180421.6415-7-digetx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPU always jumps into reset handler in ARM-mode from the Trusted
Foundations firmware, hence let's make CPU to always jump into kernel
in ARM-mode regardless of the firmware presence to support. This is
required to make  Thumb-2 kernel working with the Trusted Foundations
firmware on Tegra30.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/reset-handler.S | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index a9f13230da2f..555c652f5a07 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -20,6 +20,7 @@
 #include <soc/tegra/flowctrl.h>
 #include <soc/tegra/fuse.h>
 
+#include <asm/assembler.h>
 #include <asm/asm-offsets.h>
 #include <asm/cache.h>
 
@@ -112,10 +113,20 @@ ENTRY(__tegra_cpu_reset_handler_start)
  * NOTE: This code is copied to IRAM. All code and data accesses
  *       must be position-independent.
  */
-
+	.arm
 	.align L1_CACHE_SHIFT
 ENTRY(__tegra_cpu_reset_handler)
 
+	/*
+	 * Tegra30 ignores first bit of the reset vector and always jumps
+	 * into kernel in .ARM mode from the firmware, hence force the mode
+	 * switch if kernel is compiled in Thumb-2.
+	 */
+ THUMB(	badr	r0, 1f		)
+ THUMB(	bx	r0		)
+ THUMB(	.thumb 			)
+ THUMB(	1: 			)
+
 	cpsid	aif, 0x13			@ SVC mode, interrupts disabled
 
 	tegra_get_soc_id TEGRA_APB_MISC_BASE, r6
@@ -215,7 +226,7 @@ __no_cpu0_chk:
 	ldr	lr, [r12, #RESET_DATA(STARTUP_SECONDARY)]
 	cmp	lr, #0
 	bleq	__die				@ no secondary startup handler
-	bx	lr
+	ret	lr
 #endif
 
 /*
-- 
2.18.0
