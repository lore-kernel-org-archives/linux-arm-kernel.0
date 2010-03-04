From: linux@arm.linux.org.uk (Russell King)
Date: Thu, 04 Mar 2010 19:11:56 +0000
Subject: [PATCH] ARM: Realview/Versatile/Integrator: separate out common
	clock code
References: <git-1267729916-2dbb324ef24e91a11ed84389718874ece7056fd7@rmk-PC>
Message-ID: <git-1267729916-5eb24b69c868ed8197842aa7c1576cdd05d9d41e@rmk-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig                                   |    6 ++
 arch/arm/Makefile                                  |    1 +
 arch/arm/mach-integrator/Makefile                  |    2 +-
 arch/arm/mach-realview/Makefile                    |    2 +-
 arch/arm/mach-realview/clock.c                     |   64 -------------------
 arch/arm/mach-realview/clock.h                     |   20 ------
 arch/arm/mach-realview/core.c                      |    2 +-
 arch/arm/mach-realview/include/mach/clkdev.h       |    9 +++
 arch/arm/mach-realview/realview_eb.c               |    1 -
 arch/arm/mach-realview/realview_pb1176.c           |    1 -
 arch/arm/mach-realview/realview_pb11mp.c           |    1 -
 arch/arm/mach-realview/realview_pba8.c             |    1 -
 arch/arm/mach-versatile/Makefile                   |    2 +-
 arch/arm/mach-versatile/clock.c                    |   65 --------------------
 arch/arm/mach-versatile/clock.h                    |   21 ------
 arch/arm/mach-versatile/core.c                     |    2 +-
 arch/arm/mach-versatile/include/mach/clkdev.h      |    9 +++
 arch/arm/plat-versatile/Makefile                   |    1 +
 .../{mach-integrator => plat-versatile}/clock.c    |    4 +-
 19 files changed, 33 insertions(+), 181 deletions(-)
 delete mode 100644 arch/arm/mach-realview/clock.c
 delete mode 100644 arch/arm/mach-realview/clock.h
 delete mode 100644 arch/arm/mach-versatile/clock.c
 delete mode 100644 arch/arm/mach-versatile/clock.h
 create mode 100644 arch/arm/plat-versatile/Makefile
 rename arch/arm/{mach-integrator => plat-versatile}/clock.c (94%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b9ac2c9..d296ae9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -225,6 +225,7 @@ config ARCH_INTEGRATOR
 	select ICST
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
+	select PLAT_VERSATILE
 	help
 	  Support for ARM's Integrator platform.
 
@@ -237,6 +238,7 @@ config ARCH_REALVIEW
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
 	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select PLAT_VERSATILE
 	help
 	  This enables support for ARM Ltd RealView boards.
 
@@ -250,6 +252,7 @@ config ARCH_VERSATILE
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
 	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select PLAT_VERSATILE
 	help
 	  This enables support for ARM Ltd Versatile board.
 
@@ -852,6 +855,9 @@ config PLAT_ORION
 config PLAT_PXA
 	bool
 
+config PLAT_VERSATILE
+	bool
+
 source arch/arm/mm/Kconfig
 
 config IWMMXT
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 9e75825..a07a3be 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -185,6 +185,7 @@ plat-$(CONFIG_PLAT_PXA)		:= pxa
 plat-$(CONFIG_PLAT_S3C24XX)	:= s3c24xx s3c samsung
 plat-$(CONFIG_PLAT_S3C64XX)	:= s3c64xx s3c samsung
 plat-$(CONFIG_PLAT_S5PC1XX)	:= s5pc1xx s3c samsung
+plat-$(CONFIG_PLAT_VERSATILE)	:= versatile
 
 ifeq ($(CONFIG_ARCH_EBSA110),y)
 # This is what happens if you forget the IOCS16 line.
diff --git a/arch/arm/mach-integrator/Makefile b/arch/arm/mach-integrator/Makefile
index 6a5ef8d..ebeef96 100644
--- a/arch/arm/mach-integrator/Makefile
+++ b/arch/arm/mach-integrator/Makefile
@@ -4,7 +4,7 @@
 
 # Object file lists.
 
-obj-y					:= clock.o core.o lm.o
+obj-y					:= core.o lm.o
 obj-$(CONFIG_ARCH_INTEGRATOR_AP)	+= integrator_ap.o
 obj-$(CONFIG_ARCH_INTEGRATOR_CP)	+= integrator_cp.o
 
diff --git a/arch/arm/mach-realview/Makefile b/arch/arm/mach-realview/Makefile
index e704edb..a01b76b 100644
--- a/arch/arm/mach-realview/Makefile
+++ b/arch/arm/mach-realview/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-obj-y					:= core.o clock.o
+obj-y					:= core.o
 obj-$(CONFIG_MACH_REALVIEW_EB)		+= realview_eb.o
 obj-$(CONFIG_MACH_REALVIEW_PB11MP)	+= realview_pb11mp.o
 obj-$(CONFIG_MACH_REALVIEW_PB1176)	+= realview_pb1176.o
diff --git a/arch/arm/mach-realview/clock.c b/arch/arm/mach-realview/clock.c
deleted file mode 100644
index 18c5459..0000000
--- a/arch/arm/mach-realview/clock.c
+++ /dev/null
@@ -1,64 +0,0 @@
-/*
- *  linux/arch/arm/mach-realview/clock.c
- *
- *  Copyright (C) 2004 ARM Limited.
- *  Written by Deep Blue Solutions Limited.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/device.h>
-#include <linux/list.h>
-#include <linux/errno.h>
-#include <linux/err.h>
-#include <linux/string.h>
-#include <linux/clk.h>
-#include <linux/mutex.h>
-
-#include <asm/hardware/icst.h>
-
-#include "clock.h"
-
-int clk_enable(struct clk *clk)
-{
-	return 0;
-}
-EXPORT_SYMBOL(clk_enable);
-
-void clk_disable(struct clk *clk)
-{
-}
-EXPORT_SYMBOL(clk_disable);
-
-unsigned long clk_get_rate(struct clk *clk)
-{
-	return clk->rate;
-}
-EXPORT_SYMBOL(clk_get_rate);
-
-long clk_round_rate(struct clk *clk, unsigned long rate)
-{
-	struct icst_vco vco;
-	vco = icst_hz_to_vco(clk->params, rate);
-	return icst_hz(clk->params, vco);
-}
-EXPORT_SYMBOL(clk_round_rate);
-
-int clk_set_rate(struct clk *clk, unsigned long rate)
-{
-	int ret = -EIO;
-
-	if (clk->setvco) {
-		struct icst_vco vco;
-
-		vco = icst_hz_to_vco(clk->params, rate);
-		clk->rate = icst_hz(clk->params, vco);
-		clk->setvco(clk, vco);
-		ret = 0;
-	}
-	return ret;
-}
-EXPORT_SYMBOL(clk_set_rate);
diff --git a/arch/arm/mach-realview/clock.h b/arch/arm/mach-realview/clock.h
deleted file mode 100644
index fa64c85..0000000
--- a/arch/arm/mach-realview/clock.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- *  linux/arch/arm/mach-realview/clock.h
- *
- *  Copyright (C) 2004 ARM Limited.
- *  Written by Deep Blue Solutions Limited.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <asm/hardware/icst.h>
-
-struct module;
-
-struct clk {
-	unsigned long		rate;
-	const struct icst_params *params;
-	void			*data;
-	void			(*setvco)(struct clk *, struct icst_vco vco);
-};
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index a8c215a..17eb7eb 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -48,11 +48,11 @@
 
 #include <asm/hardware/gic.h>
 
+#include <mach/clkdev.h>
 #include <mach/platform.h>
 #include <mach/irqs.h>
 
 #include "core.h"
-#include "clock.h"
 
 #define REALVIEW_REFCOUNTER	(__io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_24MHz_OFFSET)
 
diff --git a/arch/arm/mach-realview/include/mach/clkdev.h b/arch/arm/mach-realview/include/mach/clkdev.h
index 04b37a8..fefe467 100644
--- a/arch/arm/mach-realview/include/mach/clkdev.h
+++ b/arch/arm/mach-realview/include/mach/clkdev.h
@@ -1,6 +1,15 @@
 #ifndef __ASM_MACH_CLKDEV_H
 #define __ASM_MACH_CLKDEV_H
 
+#include <asm/hardware/icst.h>
+
+struct clk {
+	unsigned long		rate;
+	const struct icst_params *params;
+	u32			oscoff;
+	void			(*setvco)(struct clk *, struct icst_vco vco);
+};
+
 #define __clk_get(clk) ({ 1; })
 #define __clk_put(clk) do { } while (0)
 
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 39d953c..006765f 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -43,7 +43,6 @@
 #include <mach/irqs.h>
 
 #include "core.h"
-#include "clock.h"
 
 static struct map_desc realview_eb_io_desc[] __initdata = {
 	{
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index a93aac5..217f7c1 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -43,7 +43,6 @@
 #include <mach/irqs.h>
 
 #include "core.h"
-#include "clock.h"
 
 static struct map_desc realview_pb1176_io_desc[] __initdata = {
 	{
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index c7c656e..9ef2ecc 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -44,7 +44,6 @@
 #include <mach/irqs.h>
 
 #include "core.h"
-#include "clock.h"
 
 static struct map_desc realview_pb11mp_io_desc[] __initdata = {
 	{
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index 3e3aaa3..2fab3a6 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -41,7 +41,6 @@
 #include <mach/irqs.h>
 
 #include "core.h"
-#include "clock.h"
 
 static struct map_desc realview_pba8_io_desc[] __initdata = {
 	{
diff --git a/arch/arm/mach-versatile/Makefile b/arch/arm/mach-versatile/Makefile
index ba81e70..97cf4d8 100644
--- a/arch/arm/mach-versatile/Makefile
+++ b/arch/arm/mach-versatile/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-obj-y					:= core.o clock.o
+obj-y					:= core.o
 obj-$(CONFIG_ARCH_VERSATILE_PB)		+= versatile_pb.o
 obj-$(CONFIG_MACH_VERSATILE_AB)		+= versatile_ab.o
 obj-$(CONFIG_PCI)			+= pci.o
diff --git a/arch/arm/mach-versatile/clock.c b/arch/arm/mach-versatile/clock.c
deleted file mode 100644
index adc67d7..0000000
--- a/arch/arm/mach-versatile/clock.c
+++ /dev/null
@@ -1,65 +0,0 @@
-/*
- *  linux/arch/arm/mach-versatile/clock.c
- *
- *  Copyright (C) 2004 ARM Limited.
- *  Written by Deep Blue Solutions Limited.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/device.h>
-#include <linux/list.h>
-#include <linux/errno.h>
-#include <linux/err.h>
-#include <linux/string.h>
-#include <linux/clk.h>
-#include <linux/mutex.h>
-
-#include <asm/clkdev.h>
-#include <asm/hardware/icst.h>
-
-#include "clock.h"
-
-int clk_enable(struct clk *clk)
-{
-	return 0;
-}
-EXPORT_SYMBOL(clk_enable);
-
-void clk_disable(struct clk *clk)
-{
-}
-EXPORT_SYMBOL(clk_disable);
-
-unsigned long clk_get_rate(struct clk *clk)
-{
-	return clk->rate;
-}
-EXPORT_SYMBOL(clk_get_rate);
-
-long clk_round_rate(struct clk *clk, unsigned long rate)
-{
-	struct icst_vco vco;
-	vco = icst_hz_to_vco(clk->params, rate);
-	return icst_hz(clk->params, vco);
-}
-EXPORT_SYMBOL(clk_round_rate);
-
-int clk_set_rate(struct clk *clk, unsigned long rate)
-{
-	int ret = -EIO;
-
-	if (clk->setvco) {
-		struct icst_vco vco;
-
-		vco = icst_hz_to_vco(clk->params, rate);
-		clk->rate = icst_hz(clk->params, vco);
-		clk->setvco(clk, vco);
-		ret = 0;
-	}
-	return ret;
-}
-EXPORT_SYMBOL(clk_set_rate);
diff --git a/arch/arm/mach-versatile/clock.h b/arch/arm/mach-versatile/clock.h
deleted file mode 100644
index aed7e22..0000000
--- a/arch/arm/mach-versatile/clock.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- *  linux/arch/arm/mach-versatile/clock.h
- *
- *  Copyright (C) 2004 ARM Limited.
- *  Written by Deep Blue Solutions Limited.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <asm/hardware/icst.h>
-
-struct module;
-
-struct clk {
-	unsigned long		rate;
-	const struct icst_params *params;
-	u32			oscoff;
-	void			*data;
-	void			(*setvco)(struct clk *, struct icst_vco vco);
-};
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 3c67691..e9d255f 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -47,11 +47,11 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
+#include <mach/clkdev.h>
 #include <mach/hardware.h>
 #include <mach/platform.h>
 
 #include "core.h"
-#include "clock.h"
 
 /*
  * All IO addresses are mapped onto VA 0xFFFx.xxxx, where x.xxxx
diff --git a/arch/arm/mach-versatile/include/mach/clkdev.h b/arch/arm/mach-versatile/include/mach/clkdev.h
index 04b37a8..fefe467 100644
--- a/arch/arm/mach-versatile/include/mach/clkdev.h
+++ b/arch/arm/mach-versatile/include/mach/clkdev.h
@@ -1,6 +1,15 @@
 #ifndef __ASM_MACH_CLKDEV_H
 #define __ASM_MACH_CLKDEV_H
 
+#include <asm/hardware/icst.h>
+
+struct clk {
+	unsigned long		rate;
+	const struct icst_params *params;
+	u32			oscoff;
+	void			(*setvco)(struct clk *, struct icst_vco vco);
+};
+
 #define __clk_get(clk) ({ 1; })
 #define __clk_put(clk) do { } while (0)
 
diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
new file mode 100644
index 0000000..2228fd1
--- /dev/null
+++ b/arch/arm/plat-versatile/Makefile
@@ -0,0 +1 @@
+obj-y	:= clock.o
diff --git a/arch/arm/mach-integrator/clock.c b/arch/arm/plat-versatile/clock.c
similarity index 94%
rename from arch/arm/mach-integrator/clock.c
rename to arch/arm/plat-versatile/clock.c
index 52fc294..2fa34de 100644
--- a/arch/arm/mach-integrator/clock.c
+++ b/arch/arm/plat-versatile/clock.c
@@ -1,5 +1,5 @@
 /*
- *  linux/arch/arm/mach-integrator/clock.c
+ *  linux/arch/arm/plat-versatile/clock.c
  *
  *  Copyright (C) 2004 ARM Limited.
  *  Written by Deep Blue Solutions Limited.
@@ -15,7 +15,7 @@
 #include <linux/mutex.h>
 
 #include <asm/hardware/icst.h>
-#include <asm/clkdev.h>
+
 #include <mach/clkdev.h>
 
 int clk_enable(struct clk *clk)
