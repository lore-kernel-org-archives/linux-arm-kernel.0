From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Mon, 7 May 2012 19:44:10 +0200
Subject: [PATCH 5/5] ARM: S3C24XX: move common clock init into common.c
In-Reply-To: <201205071939.37433.heiko@sntech.de>
References: <201205071939.37433.heiko@sntech.de>
Message-ID: <201205071944.11151.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/common.c |   18 ++++++++++++
 arch/arm/plat-s3c24xx/Makefile |    1 -
 arch/arm/plat-s3c24xx/clock.c  |   59 ----------------------------------------
 3 files changed, 18 insertions(+), 60 deletions(-)
 delete mode 100644 arch/arm/plat-s3c24xx/clock.c

diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index bf1cd36..bcc99e9 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -42,6 +42,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
+#include <mach/regs-clock.h>
 #include <mach/regs-gpio.h>
 #include <plat/regs-serial.h>
 #include <plat/regs-irqtype.h>
@@ -56,6 +57,8 @@
 #include <plat/s3c2416.h>
 #include <plat/s3c244x.h>
 #include <plat/s3c2443.h>
+#include <plat/cpu-freq.h>
+#include <plat/pll.h>
 
 /* table of supported CPUs */
 
@@ -949,3 +952,18 @@ struct s3c24xx_uart_resources s3c2410_uart_resources[] __initdata = {
 		.nr_resources	= ARRAY_SIZE(s3c2410_uart3_resource),
 	},
 };
+
+/* initialise all the clocks */
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
diff --git a/arch/arm/plat-s3c24xx/Makefile b/arch/arm/plat-s3c24xx/Makefile
index 937fc67..6472416 100644
--- a/arch/arm/plat-s3c24xx/Makefile
+++ b/arch/arm/plat-s3c24xx/Makefile
@@ -12,7 +12,6 @@ obj-				:=
 
 # Core files
 
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
-- 
1.7.5.4
