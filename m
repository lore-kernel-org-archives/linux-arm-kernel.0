From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Dec 2011 04:47:39 -0500
Subject: [PATCH 10/20] ARM: s3c24xx: move special idle code to out of line
In-Reply-To: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
Message-ID: <1324288069-21940-11-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

... and hook it to arm_pm_idle.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-s3c2410/include/mach/system.h |   34 +--------------------------
 arch/arm/mach-s3c2412/s3c2412.c             |    3 +-
 arch/arm/mach-s3c2416/s3c2416.c             |    2 -
 arch/arm/plat-s3c24xx/cpu.c                 |   27 +++++++++++++++++++++
 4 files changed, 29 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-s3c2410/include/mach/system.h b/arch/arm/mach-s3c2410/include/mach/system.h
index a8cbca6701..0cff890b9b 100644
--- a/arch/arm/mach-s3c2410/include/mach/system.h
+++ b/arch/arm/mach-s3c2410/include/mach/system.h
@@ -14,45 +14,13 @@
 #include <mach/hardware.h>
 
 #include <mach/map.h>
-#include <mach/idle.h>
 #include <mach/reset.h>
 
-#include <mach/regs-clock.h>
-
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
+	cpu_do_idle();
 }
 
 #include <mach/system-reset.h>
diff --git a/arch/arm/mach-s3c2412/s3c2412.c b/arch/arm/mach-s3c2412/s3c2412.c
index 57a1e01e4e..d1c855d125 100644
--- a/arch/arm/mach-s3c2412/s3c2412.c
+++ b/arch/arm/mach-s3c2412/s3c2412.c
@@ -33,7 +33,6 @@
 #include <asm/irq.h>
 
 #include <mach/reset.h>
-#include <mach/idle.h>
 
 #include <plat/cpu-freq.h>
 
@@ -162,7 +161,7 @@ void __init s3c2412_map_io(void)
 
 	/* set our idle function */
 
-	s3c24xx_idle = s3c2412_idle;
+	arm_pm_idle = s3c2412_idle;
 
 	/* set custom reset hook */
 
diff --git a/arch/arm/mach-s3c2416/s3c2416.c b/arch/arm/mach-s3c2416/s3c2416.c
index ee214bc83c..456cc11cfc 100644
--- a/arch/arm/mach-s3c2416/s3c2416.c
+++ b/arch/arm/mach-s3c2416/s3c2416.c
@@ -45,7 +45,6 @@
 #include <asm/irq.h>
 
 #include <mach/reset.h>
-#include <mach/idle.h>
 #include <mach/regs-s3c2443-clock.h>
 
 #include <plat/gpio-core.h>
@@ -86,7 +85,6 @@ int __init s3c2416_init(void)
 	printk(KERN_INFO "S3C2416: Initializing architecture\n");
 
 	s3c24xx_reset_hook = s3c2416_hard_reset;
-	/* s3c24xx_idle = s3c2416_idle;	*/
 
 	/* change WDT IRQ number */
 	s3c_device_wdt.resource[1].start = IRQ_S3C2443_WDT;
diff --git a/arch/arm/plat-s3c24xx/cpu.c b/arch/arm/plat-s3c24xx/cpu.c
index 1121df13e1..49094b13b4 100644
--- a/arch/arm/plat-s3c24xx/cpu.c
+++ b/arch/arm/plat-s3c24xx/cpu.c
@@ -32,6 +32,7 @@
 #include <linux/io.h>
 
 #include <mach/hardware.h>
+#include <mach/regs-clock.h>
 #include <asm/irq.h>
 #include <asm/cacheflush.h>
 
@@ -192,8 +193,34 @@ static unsigned long s3c24xx_read_idcode_v4(void)
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
+	for (i = 0; i < 50; i++)
+		tmp += __raw_readl(S3C2410_CLKCON); /* ensure loop not optimised out */
+
+	/* this bit is not cleared on re-start... */
+
+	__raw_writel(__raw_readl(S3C2410_CLKCON) & ~S3C2410_CLKCON_IDLE,
+		     S3C2410_CLKCON);
+}
+
 void __init s3c24xx_init_io(struct map_desc *mach_desc, int size)
 {
+	arm_pm_idle = s3c24xx_default_idle;
+
 	/* initialise the io descriptors we need for initialisation */
 	iotable_init(mach_desc, size);
 	iotable_init(s3c_iodesc, ARRAY_SIZE(s3c_iodesc));
-- 
1.7.7.1.431.g10b2a
