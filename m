From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Fri, 18 Jan 2013 18:48:36 +0530
Subject: [PATCH v2] ARM: SAMSUNG: Gracefully exit on suspend failure
In-Reply-To: <1357729952-14881-1-git-send-email-a.kesavan@samsung.com>
References: <1357729952-14881-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1358515116-7280-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per the Exynos5250 User Manual:
When there are pending interrupt events, WFI/WFE instruction are
ignored. To cancel the power-down sequence follow these steps:
1) Disable system power-down using CENTRAL_SEQ_CONFIGURATION register
2) Clear WAKEUP_STAT register
3) Enable interrupt service routine for CPU

Code for early wakeup for exynos already exists. Remove the panic
on suspend failure, clear the wakeup state register and return 1
from cpu_suspend to indicate a failed suspend (to a user daemon).

Older Samsung SoCs have similar panics and I have removed them all.
Haven't touched the S3C2410 sleep code.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
Changes since v1:
* Returned 1 instead of a specific error
* Used pr_info rather than pr_err

 arch/arm/mach-exynos/pm.c          |    6 ++++--
 arch/arm/mach-s3c24xx/pm-s3c2412.c |    3 ++-
 arch/arm/mach-s3c24xx/pm-s3c2416.c |    3 ++-
 arch/arm/mach-s3c64xx/pm.c         |    3 ++-
 arch/arm/mach-s5p64x0/pm.c         |    4 ++--
 arch/arm/mach-s5pv210/pm.c         |    4 ++--
 arch/arm/plat-samsung/pm.c         |    5 ++++-
 7 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index f459afd..e3faaa81 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -92,8 +92,8 @@ static int exynos_cpu_suspend(unsigned long arg)
 	/* issue the standby signal into the pm unit. */
 	cpu_do_idle();
 
-	/* we should never get past here */
-	panic("sleep resumed to originator?");
+	pr_info("Failed to suspend the system\n");
+	return 1; /* Aborting suspend */
 }
 
 static void exynos_pm_prepare(void)
@@ -283,6 +283,8 @@ static void exynos_pm_resume(void)
 	if (!(tmp & S5P_CENTRAL_LOWPWR_CFG)) {
 		tmp |= S5P_CENTRAL_LOWPWR_CFG;
 		__raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
+		/* clear the wakeup state register */
+		__raw_writel(0x0, S5P_WAKEUP_STAT);
 		/* No need to perform below restore code */
 		goto early_wakeup;
 	}
diff --git a/arch/arm/mach-s3c24xx/pm-s3c2412.c b/arch/arm/mach-s3c24xx/pm-s3c2412.c
index 206765c..0f183ae 100644
--- a/arch/arm/mach-s3c24xx/pm-s3c2412.c
+++ b/arch/arm/mach-s3c24xx/pm-s3c2412.c
@@ -48,7 +48,8 @@ static int s3c2412_cpu_suspend(unsigned long arg)
 
 	s3c2412_sleep_enter();
 
-	panic("sleep resumed to originator?");
+	pr_info("Failed to suspend the system\n");
+	return 1; /* Aborting suspend */
 }
 
 static void s3c2412_pm_prepare(void)
diff --git a/arch/arm/mach-s3c24xx/pm-s3c2416.c b/arch/arm/mach-s3c24xx/pm-s3c2416.c
index 1bd4817..1a9e8dd 100644
--- a/arch/arm/mach-s3c24xx/pm-s3c2416.c
+++ b/arch/arm/mach-s3c24xx/pm-s3c2416.c
@@ -34,7 +34,8 @@ static int s3c2416_cpu_suspend(unsigned long arg)
 
 	s3c2412_sleep_enter();
 
-	panic("sleep resumed to originator?");
+	pr_info("Failed to suspend the system\n");
+	return 1; /* Aborting suspend */
 }
 
 static void s3c2416_pm_prepare(void)
diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index f6b13a2..1006f3c 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -297,7 +297,8 @@ static int s3c64xx_cpu_suspend(unsigned long arg)
 
 	/* we should never get past here */
 
-	panic("sleep resumed to originator?");
+	pr_info("Failed to suspend the system\n");
+	return 1; /* Aborting suspend */
 }
 
 /* mapping of interrupts to parts of the wakeup mask */
diff --git a/arch/arm/mach-s5p64x0/pm.c b/arch/arm/mach-s5p64x0/pm.c
index 9cba18b..97c2a08a 100644
--- a/arch/arm/mach-s5p64x0/pm.c
+++ b/arch/arm/mach-s5p64x0/pm.c
@@ -103,8 +103,8 @@ static int s5p64x0_cpu_suspend(unsigned long arg)
 	    "mcr p15, 0, %0, c7, c10, 4\n\t"
 	    "mcr p15, 0, %0, c7, c0, 4" : : "r" (tmp));
 
-	/* we should never get past here */
-	panic("sleep resumed to originator?");
+	pr_info("Failed to suspend the system\n");
+	return 1; /* Aborting suspend */
 }
 
 /* mapping of interrupts to parts of the wakeup mask */
diff --git a/arch/arm/mach-s5pv210/pm.c b/arch/arm/mach-s5pv210/pm.c
index 736bfb1..2b68a67 100644
--- a/arch/arm/mach-s5pv210/pm.c
+++ b/arch/arm/mach-s5pv210/pm.c
@@ -104,8 +104,8 @@ static int s5pv210_cpu_suspend(unsigned long arg)
 	    "mcr p15, 0, %0, c7, c10, 4\n\t"
 	    "wfi" : : "r" (tmp));
 
-	/* we should never get past here */
-	panic("sleep resumed to originator?");
+	pr_info("Failed to suspend the system\n");
+	return 1; /* Aborting suspend */
 }
 
 static void s5pv210_pm_prepare(void)
diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
index 1507028..aa4b06d 100644
--- a/arch/arm/plat-samsung/pm.c
+++ b/arch/arm/plat-samsung/pm.c
@@ -243,6 +243,7 @@ int (*pm_cpu_sleep)(unsigned long);
 
 static int s3c_pm_enter(suspend_state_t state)
 {
+	int ret;
 	/* ensure the debug is initialised (if enabled) */
 
 	s3c_pm_debug_init();
@@ -300,7 +301,9 @@ static int s3c_pm_enter(suspend_state_t state)
 	 * we resume as it saves its own register state and restores it
 	 * during the resume.  */
 
-	cpu_suspend(0, pm_cpu_sleep);
+	ret = cpu_suspend(0, pm_cpu_sleep);
+	if (ret)
+		return ret;
 
 	/* restore the system state */
 
-- 
1.7.9.5
