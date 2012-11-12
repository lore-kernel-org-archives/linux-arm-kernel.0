From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 12 Nov 2012 23:05:22 +0530
Subject: [PATCH] ARM: SPEAr3xx: Shirq: Move shirq controller out of plat/
In-Reply-To: <71bbb1faf3cd048953dcf24ef9ce6d9dd37fe8e1.1352608333.git.viresh.kumar@linaro.org>
References: <71bbb1faf3cd048953dcf24ef9ce6d9dd37fe8e1.1352608333.git.viresh.kumar@linaro.org>
Message-ID: <52526a3b70e5b354ee699dee2f1b5f6ba4f3a0ab.1352741575.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves shirq interrupt controllers driver and header file out of
plat-spear directory. It is moved to drivers/irqchip/ directory.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---

Hi Arnd,

This is an follow-up patch of my earlier patchset:

http://www.spinics.net/lists/arm-kernel/msg206253.html

Please apply it after applying them.

 arch/arm/mach-spear3xx/spear3xx.c                              |  2 +-
 arch/arm/plat-spear/Makefile                                   |  2 +-
 drivers/irqchip/Makefile                                       |  5 +++--
 arch/arm/plat-spear/shirq.c => drivers/irqchip/spear-shirq.c   |  9 +++++----
 .../plat/shirq.h => include/linux/irqchip/spear-shirq.h        | 10 ++++------
 5 files changed, 14 insertions(+), 14 deletions(-)
 rename arch/arm/plat-spear/shirq.c => drivers/irqchip/spear-shirq.c (97%)
 rename arch/arm/plat-spear/include/plat/shirq.h => include/linux/irqchip/spear-shirq.h (90%)

diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index f1aaf5b..38fe95d 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -15,12 +15,12 @@
 
 #include <linux/amba/pl022.h>
 #include <linux/amba/pl08x.h>
+#include <linux/irqchip/spear-shirq.h>
 #include <linux/of_irq.h>
 #include <linux/io.h>
 #include <asm/hardware/pl080.h>
 #include <asm/hardware/vic.h>
 #include <plat/pl080.h>
-#include <plat/shirq.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
 
diff --git a/arch/arm/plat-spear/Makefile b/arch/arm/plat-spear/Makefile
index 2607bd0..01e8853 100644
--- a/arch/arm/plat-spear/Makefile
+++ b/arch/arm/plat-spear/Makefile
@@ -5,5 +5,5 @@
 # Common support
 obj-y	:= restart.o time.o
 
-obj-$(CONFIG_ARCH_SPEAR3XX)	+= pl080.o shirq.o
+obj-$(CONFIG_ARCH_SPEAR3XX)	+= pl080.o
 obj-$(CONFIG_ARCH_SPEAR6XX)	+= pl080.o
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index e2e6eb5..fee05b1 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -1,2 +1,3 @@
-obj-$(CONFIG_ARCH_BCM2835) += irq-bcm2835.o
-obj-$(CONFIG_VERSATILE_FPGA_IRQ) += irq-versatile-fpga.o
+obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
+obj-$(CONFIG_ARCH_SPEAR3XX)		+= spear-shirq.o
+obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+= irq-versatile-fpga.o
diff --git a/arch/arm/plat-spear/shirq.c b/drivers/irqchip/spear-shirq.c
similarity index 97%
rename from arch/arm/plat-spear/shirq.c
rename to drivers/irqchip/spear-shirq.c
index 955c724..80e1d2f 100644
--- a/arch/arm/plat-spear/shirq.c
+++ b/drivers/irqchip/spear-shirq.c
@@ -1,11 +1,12 @@
 /*
- * arch/arm/plat-spear/shirq.c
- *
  * SPEAr platform shared irq layer source file
  *
- * Copyright (C) 2009 ST Microelectronics
+ * Copyright (C) 2009-2012 ST Microelectronics
  * Viresh Kumar <viresh.linux@gmail.com>
  *
+ * Copyright (C) 2012 ST Microelectronics
+ * Shiraz Hashim <shiraz.hashim@st.com>
+ *
  * This file is licensed under the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
@@ -18,11 +19,11 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
+#include <linux/irqchip/spear-shirq.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/spinlock.h>
-#include <plat/shirq.h>
 
 static DEFINE_SPINLOCK(lock);
 
diff --git a/arch/arm/plat-spear/include/plat/shirq.h b/include/linux/irqchip/spear-shirq.h
similarity index 90%
rename from arch/arm/plat-spear/include/plat/shirq.h
rename to include/linux/irqchip/spear-shirq.h
index c51b355..c8be16d 100644
--- a/arch/arm/plat-spear/include/plat/shirq.h
+++ b/include/linux/irqchip/spear-shirq.h
@@ -1,9 +1,7 @@
 /*
- * arch/arm/plat-spear/include/plat/shirq.h
- *
  * SPEAr platform shared irq layer header file
  *
- * Copyright (C) 2009 ST Microelectronics
+ * Copyright (C) 2009-2012 ST Microelectronics
  * Viresh Kumar <viresh.linux@gmail.com>
  *
  * This file is licensed under the terms of the GNU General Public
@@ -11,8 +9,8 @@
  * warranty of any kind, whether express or implied.
  */
 
-#ifndef __PLAT_SHIRQ_H
-#define __PLAT_SHIRQ_H
+#ifndef __SPEAR_SHIRQ_H
+#define __SPEAR_SHIRQ_H
 
 #include <linux/irq.h>
 #include <linux/types.h>
@@ -63,4 +61,4 @@ int __init spear310_shirq_of_init(struct device_node *np,
 int __init spear320_shirq_of_init(struct device_node *np,
 		struct device_node *parent);
 
-#endif /* __PLAT_SHIRQ_H */
+#endif /* __SPEAR_SHIRQ_H */
-- 
1.7.12.rc2.18.g61b472e
