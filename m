From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Thu, 12 Jan 2012 16:12:28 +0100
Subject: [PATCH 5/5] S3C24XX: remove plat-s3c24xx/clock.c
In-Reply-To: <201201121609.24110.heiko@sntech.de>
References: <201201121609.24110.heiko@sntech.de>
Message-ID: <201201121612.28367.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With its users reduced, the clock.c does not need to stay around.
s3c24xx_setup_clocks can move into s3c2410-clocks.c for 2410 and 244x,
and its functionality also into s3c2412.c

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c2412/clock.c         |    1 +
 arch/arm/mach-s3c2412/s3c2412.c       |    7 +++-
 arch/arm/plat-s3c24xx/Makefile        |    1 -
 arch/arm/plat-s3c24xx/clock.c         |   59 ---------------------------------
 arch/arm/plat-s3c24xx/s3c2410-clock.c |   15 ++++++++
 5 files changed, 22 insertions(+), 61 deletions(-)
 delete mode 100644 arch/arm/plat-s3c24xx/clock.c

diff --git a/arch/arm/mach-s3c2412/clock.c b/arch/arm/mach-s3c2412/clock.c
index d10b695..3a1312b 100644
--- a/arch/arm/mach-s3c2412/clock.c
+++ b/arch/arm/mach-s3c2412/clock.c
@@ -44,6 +44,7 @@
 #include <plat/s3c2412.h>
 #include <plat/clock.h>
 #include <plat/cpu.h>
+#include <plat/pll.h>
 
 /* We currently have to assume that the system is running
  * from the XTPll input, and that all ***REFCLKs are being
diff --git a/arch/arm/mach-s3c2412/s3c2412.c b/arch/arm/mach-s3c2412/s3c2412.c
index c6eac98..224d4cd 100644
--- a/arch/arm/mach-s3c2412/s3c2412.c
+++ b/arch/arm/mach-s3c2412/s3c2412.c
@@ -202,7 +202,12 @@ void __init_or_cpufreq s3c2412_setup_clocks(void)
 	printk("S3C2412: core %ld.%03ld MHz, memory %ld.%03ld MHz, peripheral %ld.%03ld MHz\n",
 	       print_mhz(fclk), print_mhz(hclk), print_mhz(pclk));
 
-	s3c24xx_setup_clocks(fclk, hclk, pclk);
+	clk_upll.rate = s3c24xx_get_pll(__raw_readl(S3C2410_UPLLCON),
+					clk_xtal.rate);
+
+	clk_h.rate = hclk;
+	clk_p.rate = pclk;
+	clk_f.rate = fclk;
 }
 
 void __init s3c2412_init_clocks(int xtal)
diff --git a/arch/arm/plat-s3c24xx/Makefile b/arch/arm/plat-s3c24xx/Makefile
index b2b0112..0be2263 100644
--- a/arch/arm/plat-s3c24xx/Makefile
+++ b/arch/arm/plat-s3c24xx/Makefile
@@ -15,7 +15,6 @@ obj-				:=
 obj-y				+= cpu.o
 obj-y				+= irq.o
 obj-y				+= dev-uart.o
-obj-y				+= clock.o
 obj-$(CONFIG_S3C24XX_DCLK)	+= clock-dclk.o
 
 obj-$(CONFIG_CPU_FREQ_S3C24XX)	+= cpu-freq.o
diff --git a/arch/arm/plat-s3c24xx/clock.c b/arch/arm/plat-s3c24xx/clock.c
deleted file mode 100644
index 931d26d..0000000
--- a/arch/arm/plat-s3c24xx/clock.c
+++ /dev/null
@@ -1,59 +0,0 @@
-/* linux/arch/arm/plat-s3c24xx/clock.c
- *
- * Copyright (c) 2004-2005 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C24XX Core clock control support
- *
- * Based on, and code from linux/arch/arm/mach-versatile/clock.c
- **
- **  Copyright (C) 2004 ARM Limited.
- **  Written by Deep Blue Solutions Limited.
- *
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-*/
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-
-#include <mach/hardware.h>
-#include <asm/irq.h>
-
-#include <mach/regs-clock.h>
-#include <mach/regs-gpio.h>
-
-#include <plat/cpu-freq.h>
-
-#include <plat/clock.h>
-#include <plat/cpu.h>
-#include <plat/pll.h>
-
-/* initialise all the clocks */
-
-void __init_or_cpufreq s3c24xx_setup_clocks(unsigned long fclk,
-					   unsigned long hclk,
-					   unsigned long pclk)
-{
-	clk_upll.rate = s3c24xx_get_pll(__raw_readl(S3C2410_UPLLCON),
-					clk_xtal.rate);
-
-	clk_mpll.rate = fclk;
-	clk_h.rate = hclk;
-	clk_p.rate = pclk;
-	clk_f.rate = fclk;
-}
diff --git a/arch/arm/plat-s3c24xx/s3c2410-clock.c b/arch/arm/plat-s3c24xx/s3c2410-clock.c
index 25dc4d4..76edfb8 100644
--- a/arch/arm/plat-s3c24xx/s3c2410-clock.c
+++ b/arch/arm/plat-s3c24xx/s3c2410-clock.c
@@ -44,6 +44,8 @@
 #include <plat/s3c2410.h>
 #include <plat/clock.h>
 #include <plat/cpu.h>
+#include <plat/pll.h>
+#include <plat/cpu-freq.h>
 
 int s3c2410_clkcon_enable(struct clk *clk, int enable)
 {
@@ -251,3 +253,16 @@ int __init s3c2410_baseclk_add(void)
 	s3c_pwmclk_init();
 	return 0;
 }
+
+void __init_or_cpufreq s3c24xx_setup_clocks(unsigned long fclk,
+					   unsigned long hclk,
+					   unsigned long pclk)
+{
+	clk_upll.rate = s3c24xx_get_pll(__raw_readl(S3C2410_UPLLCON),
+					clk_xtal.rate);
+
+	clk_mpll.rate = fclk;
+	clk_h.rate = hclk;
+	clk_p.rate = pclk;
+	clk_f.rate = fclk;
+}
-- 
1.7.5.4
