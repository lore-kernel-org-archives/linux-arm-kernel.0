From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 18 Mar 2017 09:59:44 +0100
Subject: [PATCH 2/2] ARM/clk: move the ICST library to drivers/clk
In-Reply-To: <20170318085944.15899-1-linus.walleij@linaro.org>
References: <20170318085944.15899-1-linus.walleij@linaro.org>
Message-ID: <20170318085944.15899-3-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the ICST clock divider helper library from
arch/arm/common to drivers/clk/versatile so it is maintained
with the other clock drivers.

We keep the structure as a helper library intact and do not
fuse it with the clk-icst.c Versatile ICST clock driver: there
may be other users out there that need to use this library for
their clocking, and then it will be helpful to keep the
library contained. (The icst.[c|h] files could just be moved
to drivers/clk/lib or a similar location to share the library.)

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/common/Kconfig                                         | 3 ---
 arch/arm/common/Makefile                                        | 1 -
 drivers/clk/versatile/Kconfig                                   | 3 +++
 drivers/clk/versatile/Makefile                                  | 2 +-
 drivers/clk/versatile/clk-icst.c                                | 1 +
 drivers/clk/versatile/clk-icst.h                                | 2 --
 drivers/clk/versatile/clk-impd1.c                               | 1 +
 drivers/clk/versatile/clk-realview.c                            | 1 +
 drivers/clk/versatile/clk-versatile.c                           | 1 +
 {arch/arm/common => drivers/clk/versatile}/icst.c               | 2 +-
 {arch/arm/include/asm/hardware => drivers/clk/versatile}/icst.h | 6 ++----
 11 files changed, 11 insertions(+), 12 deletions(-)
 rename {arch/arm/common => drivers/clk/versatile}/icst.c (98%)
 rename {arch/arm/include/asm/hardware => drivers/clk/versatile}/icst.h (94%)

diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
index 9353184d730d..1181053e3ade 100644
--- a/arch/arm/common/Kconfig
+++ b/arch/arm/common/Kconfig
@@ -1,6 +1,3 @@
-config ICST
-	bool
-
 config SA1111
 	bool
 	select DMABOUNCE if !ARCH_PXA
diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index 27f23b15b1ea..29fdf6a3601d 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -4,7 +4,6 @@
 
 obj-y				+= firmware.o
 
-obj-$(CONFIG_ICST)		+= icst.o
 obj-$(CONFIG_SA1111)		+= sa1111.o
 obj-$(CONFIG_DMABOUNCE)		+= dmabounce.o
 obj-$(CONFIG_SHARP_LOCOMO)	+= locomo.o
diff --git a/drivers/clk/versatile/Kconfig b/drivers/clk/versatile/Kconfig
index a6da2aa09f83..8aa875f25239 100644
--- a/drivers/clk/versatile/Kconfig
+++ b/drivers/clk/versatile/Kconfig
@@ -1,3 +1,6 @@
+config ICST
+	bool
+
 config COMMON_CLK_VERSATILE
 	bool "Clock driver for ARM Reference designs"
 	depends on ARCH_INTEGRATOR || ARCH_REALVIEW || \
diff --git a/drivers/clk/versatile/Makefile b/drivers/clk/versatile/Makefile
index 8ff03744fe98..794130402c8d 100644
--- a/drivers/clk/versatile/Makefile
+++ b/drivers/clk/versatile/Makefile
@@ -1,5 +1,5 @@
 # Makefile for Versatile-specific clocks
-obj-$(CONFIG_ICST)		+= clk-icst.o clk-versatile.o
+obj-$(CONFIG_ICST)		+= icst.o clk-icst.o clk-versatile.o
 obj-$(CONFIG_INTEGRATOR_IMPD1)	+= clk-impd1.o
 obj-$(CONFIG_ARCH_REALVIEW)	+= clk-realview.o
 obj-$(CONFIG_CLK_SP810)		+= clk-sp810.o
diff --git a/drivers/clk/versatile/clk-icst.c b/drivers/clk/versatile/clk-icst.c
index 4faa94440779..09fbe66f1f11 100644
--- a/drivers/clk/versatile/clk-icst.c
+++ b/drivers/clk/versatile/clk-icst.c
@@ -22,6 +22,7 @@
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
 
+#include "icst.h"
 #include "clk-icst.h"
 
 /* Magic unlocking token used on all Versatile boards */
diff --git a/drivers/clk/versatile/clk-icst.h b/drivers/clk/versatile/clk-icst.h
index 04e6f0aef588..5add02ebec5d 100644
--- a/drivers/clk/versatile/clk-icst.h
+++ b/drivers/clk/versatile/clk-icst.h
@@ -1,5 +1,3 @@
-#include <asm/hardware/icst.h>
-
 /**
  * struct clk_icst_desc - descriptor for the ICST VCO
  * @params: ICST parameters
diff --git a/drivers/clk/versatile/clk-impd1.c b/drivers/clk/versatile/clk-impd1.c
index 74c3216dbb00..401558bfc409 100644
--- a/drivers/clk/versatile/clk-impd1.c
+++ b/drivers/clk/versatile/clk-impd1.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/platform_data/clk-integrator.h>
 
+#include "icst.h"
 #include "clk-icst.h"
 
 #define IMPD1_OSC1	0x00
diff --git a/drivers/clk/versatile/clk-realview.c b/drivers/clk/versatile/clk-realview.c
index c56efc70ac16..6fdfee3232f4 100644
--- a/drivers/clk/versatile/clk-realview.c
+++ b/drivers/clk/versatile/clk-realview.c
@@ -11,6 +11,7 @@
 #include <linux/io.h>
 #include <linux/clk-provider.h>
 
+#include "icst.h"
 #include "clk-icst.h"
 
 #define REALVIEW_SYS_OSC0_OFFSET             0x0C
diff --git a/drivers/clk/versatile/clk-versatile.c b/drivers/clk/versatile/clk-versatile.c
index a89a927567e0..d6960de64d4a 100644
--- a/drivers/clk/versatile/clk-versatile.c
+++ b/drivers/clk/versatile/clk-versatile.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 
+#include "icst.h"
 #include "clk-icst.h"
 
 #define INTEGRATOR_HDR_LOCK_OFFSET	0x14
diff --git a/arch/arm/common/icst.c b/drivers/clk/versatile/icst.c
similarity index 98%
rename from arch/arm/common/icst.c
rename to drivers/clk/versatile/icst.c
index d7ed252708c5..de2af63a3aad 100644
--- a/arch/arm/common/icst.c
+++ b/drivers/clk/versatile/icst.c
@@ -17,7 +17,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <asm/div64.h>
-#include <asm/hardware/icst.h>
+#include "icst.h"
 
 /*
  * Divisors for each OD setting.
diff --git a/arch/arm/include/asm/hardware/icst.h b/drivers/clk/versatile/icst.h
similarity index 94%
rename from arch/arm/include/asm/hardware/icst.h
rename to drivers/clk/versatile/icst.h
index 794220b087d2..7519bba03b04 100644
--- a/arch/arm/include/asm/hardware/icst.h
+++ b/drivers/clk/versatile/icst.h
@@ -1,6 +1,4 @@
 /*
- *  arch/arm/include/asm/hardware/icst.h
- *
  *  Copyright (C) 2003 Deep Blue Solutions, Ltd, All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify
@@ -11,8 +9,8 @@
  *  clock generators.  See http://www.idt.com/ for more information
  *  on these devices.
  */
-#ifndef ASMARM_HARDWARE_ICST_H
-#define ASMARM_HARDWARE_ICST_H
+#ifndef ICST_H
+#define ICST_H
 
 struct icst_params {
 	unsigned long	ref;
-- 
2.9.3
