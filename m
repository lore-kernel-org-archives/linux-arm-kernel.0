From: swarren@nvidia.com (Stephen Warren)
Date: Wed,  2 Nov 2011 13:50:43 -0600
Subject: [PATCH] arm/tegra: Remove code that's ifndef CONFIG_ARM_GIC
Message-ID: <1320263443-32548-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

entry-macro.S contains some stale code for chips before Tegra20 that
apparently didn't use an ARM GIC. All chips supported by mainline use
an ARM GIC, so rip out the stale code.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/include/mach/entry-macro.S |   23 -----------------------
 1 files changed, 0 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-tegra/include/mach/entry-macro.S b/arch/arm/mach-tegra/include/mach/entry-macro.S
index dd165c5..485a11e 100644
--- a/arch/arm/mach-tegra/include/mach/entry-macro.S
+++ b/arch/arm/mach-tegra/include/mach/entry-macro.S
@@ -15,7 +15,6 @@
 #include <mach/iomap.h>
 #include <mach/io.h>
 
-#if defined(CONFIG_ARM_GIC)
 #define HAVE_GET_IRQNR_PREAMBLE
 #include <asm/hardware/entry-macro-gic.S>
 
@@ -32,25 +31,3 @@
 
 	.macro  arch_ret_to_user, tmp1, tmp2
 	.endm
-#else
-	/* legacy interrupt controller for AP16 */
-	.macro	disable_fiq
-	.endm
-
-	.macro	get_irqnr_preamble, base, tmp
-	@ enable imprecise aborts
-	cpsie	a
-	@ EVP base at 0xf010f000
-	mov \base, #0xf0000000
-	orr \base, #0x00100000
-	orr \base, #0x0000f000
-	.endm
-
-	.macro	arch_ret_to_user, tmp1, tmp2
-	.endm
-
-	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-	ldr \irqnr, [\base, #0x20]	@ EVT_IRQ_STS
-	cmp \irqnr, #0x80
-	.endm
-#endif
-- 
1.7.0.4
