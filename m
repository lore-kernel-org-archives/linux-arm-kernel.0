From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 24 Oct 2011 05:49:58 -0400
Subject: [PATCH 09/12] ARM: s3c24xx: move special idle code to a proper
	out-of-line pm_idle hooks
In-Reply-To: <1319449801-12367-1-git-send-email-nico@fluxnic.net>
References: <1319449801-12367-1-git-send-email-nico@fluxnic.net>
Message-ID: <1319449801-12367-10-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-s3c2410/include/mach/system.h |   30 ---------------------------
 arch/arm/mach-s3c2412/s3c2412.c             |    4 +-
 arch/arm/mach-s3c2416/s3c2416.c             |    2 -
 arch/arm/plat-s3c24xx/cpu.c                 |   30 +++++++++++++++++++++++++++
 4 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-s3c2410/include/mach/system.h b/arch/arm/mach-s3c2410/include/mach/system.h
index a8cbca6701..0c394dd671 100644
--- a/arch/arm/mach-s3c2410/include/mach/system.h
+++ b/arch/arm/mach-s3c2410/include/mach/system.h
@@ -19,40 +19,10 @@
 
 #include <mach/regs-clock.h>
 
-void (*s3c24xx_idle)(void);
 void (*s3c24xx_reset_hook)(void);
 
-void s3c24xx_default_idle(void)
-{
-	unsigned long tmp;
-	int i;
-
-	/* idle the system by using the idle mode which will wait for an
-	 * interrupt to happen before restarting the system.
-	 */
-
-	/* Warning: going into idle state upsets jtag scanning */
-
-	__raw_writel(__raw_readl(S3C2410_CLKCON) | S3C2410_CLKCON_IDLE,
-		     S3C2410_CLKCON);
-
-	/* the samsung port seems to do a loop and then unset idle.. */
-	for (i = 0; i < 50; i++) {
-		tmp += __raw_readl(S3C2410_CLKCON); /* ensure loop not optimised out */
-	}
-
-	/* this bit is not cleared on re-start... */
-
-	__raw_writel(__raw_readl(S3C2410_CLKCON) & ~S3C2410_CLKCON_IDLE,
-		     S3C2410_CLKCON);
-}
-
 static void arch_idle(void)
 {
-	if (s3c24xx_idle != NULL)
-		(s3c24xx_idle)();
-	else
-		s3c24xx_default_idle();
 }
 
 #include <mach/system-reset.h>
diff --git a/arch/arm/mach-s3c2412/s3c2412.c b/arch/arm/mach-s3c2412/s3c2412.c
index ef0958d3e5..c9018fbf67 100644
--- a/arch/arm/mach-s3c2412/s3c2412.c
+++ b/arch/arm/mach-s3c2412/s3c2412.c
@@ -33,7 +33,6 @@
 #include <asm/irq.h>
 
 #include <mach/reset.h>
-#include <mach/idle.h>
 
 #include <plat/cpu-freq.h>
 
@@ -129,6 +128,7 @@ static void s3c2412_idle(void)
 	__raw_writel(tmp, S3C2412_PWRCFG);
 
 	cpu_do_idle();
+	local_irq_enable();
 }
 
 static void s3c2412_hard_reset(void)
@@ -162,7 +162,7 @@ void __init s3c2412_map_io(void)
 
 	/* set our idle function */
 
-	s3c24xx_idle = s3c2412_idle;
+	pm_idle = s3c2412_idle;
 
 	/* set custom reset hook */
 
diff --git a/arch/arm/mach-s3c2416/s3c2416.c b/arch/arm/mach-s3c2416/s3c2416.c
index 494ce913dc..5b0ab08d5a 100644
--- a/arch/arm/mach-s3c2416/s3c2416.c
+++ b/arch/arm/mach-s3c2416/s3c2416.c
@@ -45,7 +45,6 @@
 #include <asm/irq.h>
 
 #include <mach/reset.h>
-#include <mach/idle.h>
 #include <mach/regs-s3c2443-clock.h>
 
 #include <plat/gpio-core.h>
@@ -85,7 +84,6 @@ int __init s3c2416_init(void)
 	printk(KERN_INFO "S3C2416: Initializing architecture\n");
 
 	s3c24xx_reset_hook = s3c2416_hard_reset;
-	/* s3c24xx_idle = s3c2416_idle;	*/
 
 	/* change WDT IRQ number */
 	s3c_device_wdt.resource[1].start = IRQ_S3C2443_WDT;
diff --git a/arch/arm/plat-s3c24xx/cpu.c b/arch/arm/plat-s3c24xx/cpu.c
index c1fc6c6fac..21ac7de906 100644
--- a/arch/arm/plat-s3c24xx/cpu.c
+++ b/arch/arm/plat-s3c24xx/cpu.c
@@ -192,6 +192,35 @@ static unsigned long s3c24xx_read_idcode_v4(void)
 	return __raw_readl(S3C2410_GSTATUS1);
 }
 
+static void s3c24xx_default_idle(void)
+{
+	unsigned long tmp;
+	int i;
+
+	/* idle the system by using the idle mode which will wait for an
+	 * interrupt to happen before restarting the system.
+	 */
+
+	/* Warning: going into idle state upsets jtag scanning */
+
+	__raw_writel(__raw_readl(S3C2410_CLKCON) | S3C2410_CLKCON_IDLE,
+		     S3C2410_CLKCON);
+
+	/* the samsung port seems to do a loop and then unset idle.. */
+	for (i = 0; i < 50; i++) {
+		tmp += __raw_readl(S3C2410_CLKCON); /* ensure loop not optimised out */
+	}
+
+	/* this bit is not cleared on re-start... */
+
+	__raw_writel(__raw_readl(S3C2410_CLKCON) & ~S3C2410_CLKCON_IDLE,
+		     S3C2410_CLKCON);
+
+	/* return with IRQs enabled */
+	local_irq_enable();
+}
+
+
 /* Hook for arm_pm_restart to ensure we execute the reset code
  * with the caches enabled. It seems@least the S3C2440 has a problem
  * resetting if there is bus activity interrupted by the reset.
@@ -227,6 +256,7 @@ void __init s3c24xx_init_io(struct map_desc *mach_desc, int size)
 		idcode = s3c24xx_read_idcode_v4();
 	}
 
+	pm_idle = s3c24xx_default_idle;
 	arm_pm_restart = s3c24xx_pm_restart;
 
 	s3c_init_cpu(idcode, cpu_ids, ARRAY_SIZE(cpu_ids));
-- 
1.7.7.1.431.g10b2a
