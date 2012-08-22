From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 22 Aug 2012 15:55:45 -0700
Subject: [PATCH 3/3] ARM: MSM: Remove unused idle.c
In-Reply-To: <1345676145-12321-1-git-send-email-sboyd@codeaurora.org>
References: <1345676145-12321-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1345676145-12321-4-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Forcing arm_pm_idle to be msm_idle() doesn't make sense in
configurations that don't have CONFIG_MSM7X00A_IDLE=y (i.e. any
targets that aren't 7x00a). Furthermore, that config doesn't even
exist, so this entire file is dead code. Just remove it so we can
use the default idle support on MSM.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-msm/Makefile |  2 +-
 arch/arm/mach-msm/idle.c   | 49 ----------------------------------------------
 2 files changed, 1 insertion(+), 50 deletions(-)
 delete mode 100644 arch/arm/mach-msm/idle.c

diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
index 4ad3969..5fd0464 100644
--- a/arch/arm/mach-msm/Makefile
+++ b/arch/arm/mach-msm/Makefile
@@ -1,4 +1,4 @@
-obj-y += io.o idle.o timer.o
+obj-y += io.o timer.o
 obj-y += clock.o
 obj-$(CONFIG_DEBUG_FS) += clock-debug.o
 
diff --git a/arch/arm/mach-msm/idle.c b/arch/arm/mach-msm/idle.c
deleted file mode 100644
index 0c9e13c..0000000
--- a/arch/arm/mach-msm/idle.c
+++ /dev/null
@@ -1,49 +0,0 @@
-/* arch/arm/mach-msm/idle.c
- *
- * Idle processing for MSM7K - work around bugs with SWFI.
- *
- * Copyright (c) 2007 QUALCOMM Incorporated.
- * Copyright (C) 2007 Google, Inc.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#include <linux/init.h>
-#include <asm/system.h>
-
-static void msm_idle(void)
-{
-#ifdef CONFIG_MSM7X00A_IDLE
-	asm volatile (
-
-	"mrc     p15, 0, r1, c1, c0, 0    /* read current CR    */ \n\t"
-	"bic     r0, r1, #(1 << 2)        /* clear dcache bit   */ \n\t"
-	"bic     r0, r0, #(1 << 12)       /* clear icache bit   */ \n\t"
-	"mcr     p15, 0, r0, c1, c0, 0    /* disable d/i cache  */ \n\t"
-
-	"mov     r0, #0                   /* prepare wfi value  */ \n\t"
-	"mcr     p15, 0, r0, c7, c10, 0   /* flush the cache    */ \n\t"
-	"mcr     p15, 0, r0, c7, c10, 4   /* memory barrier     */ \n\t"
-	"mcr     p15, 0, r0, c7, c0, 4    /* wait for interrupt */ \n\t"
-
-	"mcr     p15, 0, r1, c1, c0, 0    /* restore d/i cache  */ \n\t"
-
-	: : : "r0","r1" );
-#endif
-}
-
-static int __init msm_idle_init(void)
-{
-	arm_pm_idle = msm_idle;
-	return 0;
-}
-
-arch_initcall(msm_idle_init);
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
