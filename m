From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 22 Oct 2009 16:09:31 -0700
Subject: [PATCH v2 10/32] OMAP3: PM: MPU off-mode support
In-Reply-To: <1256252993-24328-10-git-send-email-khilman@deeprootsystems.com>
References: <1256252993-24328-1-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-2-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-3-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-4-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-5-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-6-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-7-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-8-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-9-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-10-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1256252993-24328-11-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajendra Nayak <rnayak@ti.com>

Adds a 'save_state' option when calling into SRAM idle function
and adds some minor cleanups of SRAM asm code.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c    |   11 ++++++++++-
 arch/arm/mach-omap2/sleep34xx.S |   11 ++++-------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 8b5bf91..9fb0876 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -28,6 +28,7 @@
 #include <plat/powerdomain.h>
 #include <plat/control.h>
 #include <plat/serial.h>
+#include <plat/sdrc.h>
 
 #include <asm/tlbflush.h>
 
@@ -223,6 +224,9 @@ static void omap_sram_idle(void)
 		/* No need to save context */
 		save_state = 0;
 		break;
+	case PWRDM_POWER_OFF:
+		save_state = 3;
+		break;
 	default:
 		/* Invalid state */
 		printk(KERN_ERR "Invalid mpu state in sram_idle\n");
@@ -248,7 +252,12 @@ static void omap_sram_idle(void)
 		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
 	}
 
-	_omap_sram_idle(NULL, save_state);
+	/*
+	 * omap3_arm_context is the location where ARM registers
+	 * get saved. The restore path then reads from this
+	 * location and restores them back.
+	 */
+	_omap_sram_idle(omap3_arm_context, save_state);
 	cpu_init();
 
 	/* Restore table entry modified during MMU restoration */
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 6a749f2..f8d3834 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -36,12 +36,11 @@
 				OMAP3430_PM_PREPWSTST)
 #define PM_PREPWSTST_MPU_V	OMAP34XX_PRM_REGADDR(MPU_MOD, \
 				OMAP3430_PM_PREPWSTST)
-#define PM_PWSTCTRL_MPU_P	OMAP34XX_PRM_REGADDR(MPU_MOD, PM_PWSTCTRL)
+#define PM_PWSTCTRL_MPU_P	OMAP3430_PRM_BASE + MPU_MOD + PM_PWSTCTRL
 #define SCRATCHPAD_MEM_OFFS	0x310 /* Move this as correct place is
 				       * available */
-#define SCRATCHPAD_BASE_P	OMAP343X_CTRL_REGADDR(\
-				OMAP343X_CONTROL_MEM_WKUP +\
-				SCRATCHPAD_MEM_OFFS)
+#define SCRATCHPAD_BASE_P	(OMAP343X_CTRL_BASE + OMAP343X_CONTROL_MEM_WKUP\
+						+ SCRATCHPAD_MEM_OFFS)
 #define SDRC_POWER_V		OMAP34XX_SDRC_REGADDR(SDRC_POWER)
 
 	.text
@@ -96,7 +95,7 @@ loop:
 
 	ldmfd	sp!, {r0-r12, pc}		@ restore regs and return
 restore:
-	/* b restore*/ 	@ Enable to debug restore code
+	/* b restore*/  @ Enable to debug restore code
         /* Check what was the reason for mpu reset and store the reason in r9*/
         /* 1 - Only L1 and logic lost */
         /* 2 - Only L2 lost - In this case, we wont be here */
@@ -416,8 +415,6 @@ scratchpad_base:
 	.word	SCRATCHPAD_BASE_P
 sdrc_power:
 	.word SDRC_POWER_V
-context_mem:
-	.word	0x803E3E14
 clk_stabilize_delay:
 	.word 0x000001FF
 assoc_mask:
-- 
1.6.4.3
