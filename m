From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 19 Sep 2011 20:37:33 +0900
Subject: [PATCH] ARM: SAMSUNG: plat-samsung/include/plat/pwm-clock.h
Message-ID: <002101cc76c0$85dbe180$9193a480$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removed
 - arch/arm/plat-s3c24xx/include/mach/pwm-clock.h
 - arch/arm/mach-s3c64xx/include/mach/pwm-clock.h
 - arch/arm/mach-s5p64x0/include/mach/pwm-clock.h
 - arch/arm/mach-s5pc100/include/mach/pwm-clock.h
 - arch/arm/mach-s5pv210/include/mach/pwm-clock.h
 - arch/arm/mach-exynos4/include/mach/pwm-clock.h

And created
 - arch/arm/plat-samsung/include/plat/pwm-clock.h

Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c64xx/include/mach/pwm-clock.h     |   56 ----------------
 arch/arm/mach-s5p64x0/include/mach/pwm-clock.h     |   68
-------------------
 arch/arm/mach-s5pc100/include/mach/pwm-clock.h     |   56 ----------------
 arch/arm/mach-s5pv210/include/mach/pwm-clock.h     |   70
--------------------
 arch/arm/plat-s3c24xx/include/mach/pwm-clock.h     |   55 ---------------
 .../mach => plat-samsung/include/plat}/pwm-clock.h |   39 +++++++----
 arch/arm/plat-samsung/pwm-clock.c                  |   13 +++-
 7 files changed, 36 insertions(+), 321 deletions(-)
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/pwm-clock.h
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/pwm-clock.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/pwm-clock.h
 delete mode 100644 arch/arm/mach-s5pv210/include/mach/pwm-clock.h
 delete mode 100644 arch/arm/plat-s3c24xx/include/mach/pwm-clock.h
 rename arch/arm/{mach-exynos4/include/mach =>
plat-samsung/include/plat}/pwm-clock.h (68%)

diff --git a/arch/arm/mach-s3c64xx/include/mach/pwm-clock.h
b/arch/arm/mach-s3c64xx/include/mach/pwm-clock.h
deleted file mode 100644
index b25bede..0000000
--- a/arch/arm/mach-s3c64xx/include/mach/pwm-clock.h
+++ /dev/null
@@ -1,56 +0,0 @@
-/* linux/arch/arm/mach-s3c6400/include/mach/pwm-clock.h
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *      Ben Dooks <ben@simtec.co.uk>
- *      http://armlinux.simtec.co.uk/
- *
- * S3C64xx - pwm clock and timer support
- */
-
-/**
- * pwm_cfg_src_is_tclk() - return whether the given mux config is a tclk
- * @tcfg: The timer TCFG1 register bits shifted down to 0.
- *
- * Return true if the given configuration from TCFG1 is a TCLK instead
- * any of the TDIV clocks.
- */
-static inline int pwm_cfg_src_is_tclk(unsigned long tcfg)
-{
-	return tcfg >= S3C64XX_TCFG1_MUX_TCLK;
-}
-
-/**
- * tcfg_to_divisor() - convert tcfg1 setting to a divisor
- * @tcfg1: The tcfg1 setting, shifted down.
- *
- * Get the divisor value for the given tcfg1 setting. We assume the
- * caller has already checked to see if this is not a TCLK source.
- */
-static inline unsigned long tcfg_to_divisor(unsigned long tcfg1)
-{
-	return 1 << tcfg1;
-}
-
-/**
- * pwm_tdiv_has_div1() - does the tdiv setting have a /1
- *
- * Return true if we have a /1 in the tdiv setting.
- */
-static inline unsigned int pwm_tdiv_has_div1(void)
-{
-	return 1;
-}
-
-/**
- * pwm_tdiv_div_bits() - calculate TCFG1 divisor value.
- * @div: The divisor to calculate the bit information for.
- *
- * Turn a divisor into the necessary bit field for TCFG1.
- */
-static inline unsigned long pwm_tdiv_div_bits(unsigned int div)
-{
-	return ilog2(div);
-}
-
-#define S3C_TCFG1_MUX_TCLK S3C64XX_TCFG1_MUX_TCLK
diff --git a/arch/arm/mach-s5p64x0/include/mach/pwm-clock.h
b/arch/arm/mach-s5p64x0/include/mach/pwm-clock.h
deleted file mode 100644
index 19fff8b..0000000
--- a/arch/arm/mach-s5p64x0/include/mach/pwm-clock.h
+++ /dev/null
@@ -1,68 +0,0 @@
-/* linux/arch/arm/mach-s5p64x0/include/mach/pwm-clock.h
- *
- * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *      Ben Dooks <ben@simtec.co.uk>
- *      http://armlinux.simtec.co.uk/
- *
- * S5P64X0 - pwm clock and timer support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_PWMCLK_H
-#define __ASM_ARCH_PWMCLK_H __FILE__
-
-/**
- * pwm_cfg_src_is_tclk() - return whether the given mux config is a tclk
- * @tcfg: The timer TCFG1 register bits shifted down to 0.
- *
- * Return true if the given configuration from TCFG1 is a TCLK instead
- * any of the TDIV clocks.
- */
-static inline int pwm_cfg_src_is_tclk(unsigned long tcfg)
-{
-	return 0;
-}
-
-/**
- * tcfg_to_divisor() - convert tcfg1 setting to a divisor
- * @tcfg1: The tcfg1 setting, shifted down.
- *
- * Get the divisor value for the given tcfg1 setting. We assume the
- * caller has already checked to see if this is not a TCLK source.
- */
-static inline unsigned long tcfg_to_divisor(unsigned long tcfg1)
-{
-	return 1 << tcfg1;
-}
-
-/**
- * pwm_tdiv_has_div1() - does the tdiv setting have a /1
- *
- * Return true if we have a /1 in the tdiv setting.
- */
-static inline unsigned int pwm_tdiv_has_div1(void)
-{
-	return 1;
-}
-
-/**
- * pwm_tdiv_div_bits() - calculate TCFG1 divisor value.
- * @div: The divisor to calculate the bit information for.
- *
- * Turn a divisor into the necessary bit field for TCFG1.
- */
-static inline unsigned long pwm_tdiv_div_bits(unsigned int div)
-{
-	return ilog2(div);
-}
-
-#define S3C_TCFG1_MUX_TCLK 0
-
-#endif /* __ASM_ARCH_PWMCLK_H */
diff --git a/arch/arm/mach-s5pc100/include/mach/pwm-clock.h
b/arch/arm/mach-s5pc100/include/mach/pwm-clock.h
deleted file mode 100644
index b34d2f7..0000000
--- a/arch/arm/mach-s5pc100/include/mach/pwm-clock.h
+++ /dev/null
@@ -1,56 +0,0 @@
-/* linux/arch/arm/mach-s5pc100/include/mach/pwm-clock.h
- *
- * Copyright 2009 Samsung Electronics Co.
- *      Byungho Min <bhmin@samsung.com>
- *
- * S5PC100 - pwm clock and timer support
- *
- * Based on mach-s3c6400/include/mach/pwm-clock.h
- */
-
-/**
- * pwm_cfg_src_is_tclk() - return whether the given mux config is a tclk
- * @tcfg: The timer TCFG1 register bits shifted down to 0.
- *
- * Return true if the given configuration from TCFG1 is a TCLK instead
- * any of the TDIV clocks.
- */
-static inline int pwm_cfg_src_is_tclk(unsigned long tcfg)
-{
-	return tcfg >= S3C64XX_TCFG1_MUX_TCLK;
-}
-
-/**
- * tcfg_to_divisor() - convert tcfg1 setting to a divisor
- * @tcfg1: The tcfg1 setting, shifted down.
- *
- * Get the divisor value for the given tcfg1 setting. We assume the
- * caller has already checked to see if this is not a TCLK source.
- */
-static inline unsigned long tcfg_to_divisor(unsigned long tcfg1)
-{
-	return 1 << tcfg1;
-}
-
-/**
- * pwm_tdiv_has_div1() - does the tdiv setting have a /1
- *
- * Return true if we have a /1 in the tdiv setting.
- */
-static inline unsigned int pwm_tdiv_has_div1(void)
-{
-	return 1;
-}
-
-/**
- * pwm_tdiv_div_bits() - calculate TCFG1 divisor value.
- * @div: The divisor to calculate the bit information for.
- *
- * Turn a divisor into the necessary bit field for TCFG1.
- */
-static inline unsigned long pwm_tdiv_div_bits(unsigned int div)
-{
-	return ilog2(div);
-}
-
-#define S3C_TCFG1_MUX_TCLK S3C64XX_TCFG1_MUX_TCLK
diff --git a/arch/arm/mach-s5pv210/include/mach/pwm-clock.h
b/arch/arm/mach-s5pv210/include/mach/pwm-clock.h
deleted file mode 100644
index f8a9f1b..0000000
--- a/arch/arm/mach-s5pv210/include/mach/pwm-clock.h
+++ /dev/null
@@ -1,70 +0,0 @@
-/* linux/arch/arm/mach-s5pv210/include/mach/pwm-clock.h
- *
- * Copyright (c) 2009 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *      Ben Dooks <ben@simtec.co.uk>
- *      http://armlinux.simtec.co.uk/
- *
- * Based on arch/arm/mach-s3c64xx/include/mach/pwm-clock.h
- *
- * S5PV210 - pwm clock and timer support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_PWMCLK_H
-#define __ASM_ARCH_PWMCLK_H __FILE__
-
-/**
- * pwm_cfg_src_is_tclk() - return whether the given mux config is a tclk
- * @tcfg: The timer TCFG1 register bits shifted down to 0.
- *
- * Return true if the given configuration from TCFG1 is a TCLK instead
- * any of the TDIV clocks.
- */
-static inline int pwm_cfg_src_is_tclk(unsigned long tcfg)
-{
-	return tcfg == S3C64XX_TCFG1_MUX_TCLK;
-}
-
-/**
- * tcfg_to_divisor() - convert tcfg1 setting to a divisor
- * @tcfg1: The tcfg1 setting, shifted down.
- *
- * Get the divisor value for the given tcfg1 setting. We assume the
- * caller has already checked to see if this is not a TCLK source.
- */
-static inline unsigned long tcfg_to_divisor(unsigned long tcfg1)
-{
-	return 1 << tcfg1;
-}
-
-/**
- * pwm_tdiv_has_div1() - does the tdiv setting have a /1
- *
- * Return true if we have a /1 in the tdiv setting.
- */
-static inline unsigned int pwm_tdiv_has_div1(void)
-{
-	return 1;
-}
-
-/**
- * pwm_tdiv_div_bits() - calculate TCFG1 divisor value.
- * @div: The divisor to calculate the bit information for.
- *
- * Turn a divisor into the necessary bit field for TCFG1.
- */
-static inline unsigned long pwm_tdiv_div_bits(unsigned int div)
-{
-	return ilog2(div);
-}
-
-#define S3C_TCFG1_MUX_TCLK S3C64XX_TCFG1_MUX_TCLK
-
-#endif /* __ASM_ARCH_PWMCLK_H */
diff --git a/arch/arm/plat-s3c24xx/include/mach/pwm-clock.h
b/arch/arm/plat-s3c24xx/include/mach/pwm-clock.h
deleted file mode 100644
index a087de2..0000000
--- a/arch/arm/plat-s3c24xx/include/mach/pwm-clock.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/* linux/arch/arm/plat-s3c24xx/include/mach/pwm-clock.h
- *
- * Copyright 2008 Simtec Electronics
- *      Ben Dooks <ben@simtec.co.uk>
- *      http://armlinux.simtec.co.uk/
- *
- * S3C24xx - pwm clock and timer support
- */
-
-/**
- * pwm_cfg_src_is_tclk() - return whether the given mux config is a tclk
- * @cfg: The timer TCFG1 register bits shifted down to 0.
- *
- * Return true if the given configuration from TCFG1 is a TCLK instead
- * any of the TDIV clocks.
- */
-static inline int pwm_cfg_src_is_tclk(unsigned long tcfg)
-{
-	return tcfg == S3C2410_TCFG1_MUX_TCLK;
-}
-
-/**
- * tcfg_to_divisor() - convert tcfg1 setting to a divisor
- * @tcfg1: The tcfg1 setting, shifted down.
- *
- * Get the divisor value for the given tcfg1 setting. We assume the
- * caller has already checked to see if this is not a TCLK source.
- */
-static inline unsigned long tcfg_to_divisor(unsigned long tcfg1)
-{
-	return 1 << (1 + tcfg1);
-}
-
-/**
- * pwm_tdiv_has_div1() - does the tdiv setting have a /1
- *
- * Return true if we have a /1 in the tdiv setting.
- */
-static inline unsigned int pwm_tdiv_has_div1(void)
-{
-	return 0;
-}
-
-/**
- * pwm_tdiv_div_bits() - calculate TCFG1 divisor value.
- * @div: The divisor to calculate the bit information for.
- *
- * Turn a divisor into the necessary bit field for TCFG1.
- */
-static inline unsigned long pwm_tdiv_div_bits(unsigned int div)
-{
-	return ilog2(div) - 1;
-}
-
-#define S3C_TCFG1_MUX_TCLK S3C2410_TCFG1_MUX_TCLK
diff --git a/arch/arm/mach-exynos4/include/mach/pwm-clock.h
b/arch/arm/plat-samsung/include/plat/pwm-clock.h
similarity index 68%
rename from arch/arm/mach-exynos4/include/mach/pwm-clock.h
rename to arch/arm/plat-samsung/include/plat/pwm-clock.h
index 8e12090..bf6a60e 100644
--- a/arch/arm/mach-exynos4/include/mach/pwm-clock.h
+++ b/arch/arm/plat-samsung/include/plat/pwm-clock.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/mach-exynos4/include/mach/pwm-clock.h
+/* linux/arch/arm/plat-samsung/include/plat/pwm-clock.h
  *
  * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
@@ -8,17 +8,15 @@
  *      Ben Dooks <ben@simtec.co.uk>
  *      http://armlinux.simtec.co.uk/
  *
- * Based on arch/arm/mach-s3c64xx/include/mach/pwm-clock.h
- *
- * EXYNOS4 - pwm clock and timer support
+ * SAMSUNG - pwm clock and timer support
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
 */
 
-#ifndef __ASM_ARCH_PWMCLK_H
-#define __ASM_ARCH_PWMCLK_H __FILE__
+#ifndef __ASM_PLAT_PWM_CLOCK_H
+#define __ASM_PLAT_PWM_CLOCK_H __FILE__
 
 /**
  * pwm_cfg_src_is_tclk() - return whether the given mux config is a tclk
@@ -29,7 +27,14 @@
  */
 static inline int pwm_cfg_src_is_tclk(unsigned long tcfg)
 {
-	return tcfg == S3C64XX_TCFG1_MUX_TCLK;
+	if (soc_is_s3c24xx())
+		return tcfg == S3C2410_TCFG1_MUX_TCLK;
+	else if (soc_is_s3c64xx() || soc_is_s5pc100())
+		return tcfg >= S3C64XX_TCFG1_MUX_TCLK;
+	else if (soc_is_s5p6440() || soc_is_s5p6450())
+		return 0;
+	else
+		return tcfg == S3C64XX_TCFG1_MUX_TCLK;
 }
 
 /**
@@ -41,7 +46,10 @@ static inline int pwm_cfg_src_is_tclk(unsigned long tcfg)
  */
 static inline unsigned long tcfg_to_divisor(unsigned long tcfg1)
 {
-	return 1 << tcfg1;
+	if (soc_is_s3c24xx())
+		return 1 << (tcfg1 + 1);
+	else
+		return 1 << tcfg1;
 }
 
 /**
@@ -51,7 +59,10 @@ static inline unsigned long tcfg_to_divisor(unsigned long
tcfg1)
  */
 static inline unsigned int pwm_tdiv_has_div1(void)
 {
-	return 1;
+	if (soc_is_s3c24xx())
+		return 0;
+	else
+		return 1;
 }
 
 /**
@@ -62,9 +73,9 @@ static inline unsigned int pwm_tdiv_has_div1(void)
  */
 static inline unsigned long pwm_tdiv_div_bits(unsigned int div)
 {
-	return ilog2(div);
+	if (soc_is_s3c24xx())
+		return ilog2(div) - 1;
+	else
+		return ilog2(div);
 }
-
-#define S3C_TCFG1_MUX_TCLK S3C64XX_TCFG1_MUX_TCLK
-
-#endif /* __ASM_ARCH_PWMCLK_H */
+#endif /* __ASM_PLAT_PWM_CLOCK_H */
diff --git a/arch/arm/plat-samsung/pwm-clock.c
b/arch/arm/plat-samsung/pwm-clock.c
index f1bba88..a35ff3b 100644
--- a/arch/arm/plat-samsung/pwm-clock.c
+++ b/arch/arm/plat-samsung/pwm-clock.c
@@ -27,7 +27,7 @@
 #include <plat/cpu.h>
 
 #include <plat/regs-timer.h>
-#include <mach/pwm-clock.h>
+#include <plat/pwm-clock.h>
 
 /* Each of the timers 0 through 5 go through the following
  * clock tree, with the inputs depending on the timers.
@@ -339,8 +339,17 @@ static int clk_pwm_tin_set_parent(struct clk *clk,
struct clk *parent)
 	unsigned long bits;
 	unsigned long shift = S3C2410_TCFG1_SHIFT(id);
 
+	unsigned long mux_tclk;
+
+	if (soc_is_s3c24xx())
+		mux_tclk = S3C2410_TCFG1_MUX_TCLK;
+	else if (soc_is_s5p6440() || soc_is_s5p6450())
+		mux_tclk = 0;
+	else
+		mux_tclk = S3C64XX_TCFG1_MUX_TCLK;
+
 	if (parent == s3c24xx_pwmclk_tclk(id))
-		bits = S3C_TCFG1_MUX_TCLK << shift;
+		bits = mux_tclk << shift;
 	else if (parent == s3c24xx_pwmclk_tdiv(id))
 		bits = clk_pwm_tdiv_bits(to_tdiv(parent)) << shift;
 	else
-- 
1.7.1
