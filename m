From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jan 2013 23:35:45 +0000
Subject: [PATCH 02/13] ARM: spear: unify mach/generic.h and mach/irqs.h
In-Reply-To: <1359156956-32404-1-git-send-email-arnd@arndb.de>
References: <1359156956-32404-1-git-send-email-arnd@arndb.de>
Message-ID: <1359156956-32404-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are indeed easy to combine, as there are no conflicting
definitions in generic.h, and irqs.h will be obsolete once
we enable SPARSE_IRQ.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-spear13xx/include/mach/generic.h | 21 +++++++----
 arch/arm/mach-spear13xx/include/mach/irqs.h    | 23 +++++++++---
 arch/arm/mach-spear3xx/include/mach/generic.h  | 42 ++++++++++++++++------
 arch/arm/mach-spear3xx/include/mach/irqs.h     | 24 ++++++++++---
 arch/arm/mach-spear3xx/spear320.c              |  1 +
 arch/arm/mach-spear3xx/spear3xx.c              |  2 ++
 arch/arm/mach-spear6xx/include/mach/generic.h  | 48 ++++++++++++++++++++++----
 arch/arm/mach-spear6xx/include/mach/irqs.h     | 22 ++++++++----
 8 files changed, 146 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index c33f4d9..58c15c6 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -1,9 +1,8 @@
 /*
- * arch/arm/mach-spear13xx/include/mach/generic.h
+ * spear machine family generic header file
  *
- * spear13xx machine family generic header file
- *
- * Copyright (C) 2012 ST Microelectronics
+ * Copyright (C) 2009-2012 ST Microelectronics
+ * Rajeev Kumar <rajeev-dlh.kumar@st.com>
  * Viresh Kumar <viresh.linux@gmail.com>
  *
  * This file is licensed under the terms of the GNU General Public
@@ -15,23 +14,31 @@
 #define __MACH_GENERIC_H
 
 #include <linux/dmaengine.h>
+#include <linux/amba/pl08x.h>
+#include <linux/init.h>
 #include <asm/mach/time.h>
 
-/* Add spear13xx structure declarations here */
 extern struct sys_timer spear13xx_timer;
+extern struct sys_timer spear3xx_timer;
 extern struct pl022_ssp_controller pl022_plat_data;
+extern struct pl08x_platform_data pl080_plat_data;
 extern struct dw_dma_platform_data dmac_plat_data;
 extern struct dw_dma_slave cf_dma_priv;
 extern struct dw_dma_slave nand_read_dma_priv;
 extern struct dw_dma_slave nand_write_dma_priv;
+bool dw_dma_filter(struct dma_chan *chan, void *slave);
 
-/* Add spear13xx family function declarations here */
 void __init spear_setup_of_timer(void);
+void __init spear3xx_clk_init(void);
+void __init spear3xx_map_io(void);
+void __init spear3xx_dt_init_irq(void);
+void __init spear6xx_clk_init(void);
 void __init spear13xx_map_io(void);
 void __init spear13xx_dt_init_irq(void);
 void __init spear13xx_l2x0_init(void);
-bool dw_dma_filter(struct dma_chan *chan, void *slave);
+
 void spear_restart(char, const char *);
+
 void spear13xx_secondary_startup(void);
 void __cpuinit spear13xx_cpu_die(unsigned int cpu);
 
diff --git a/arch/arm/mach-spear13xx/include/mach/irqs.h b/arch/arm/mach-spear13xx/include/mach/irqs.h
index 271a62b..92da0a8 100644
--- a/arch/arm/mach-spear13xx/include/mach/irqs.h
+++ b/arch/arm/mach-spear13xx/include/mach/irqs.h
@@ -1,9 +1,8 @@
 /*
- * arch/arm/mach-spear13xx/include/mach/irqs.h
+ * IRQ helper macros for spear machine family
  *
- * IRQ helper macros for spear13xx machine family
- *
- * Copyright (C) 2012 ST Microelectronics
+ * Copyright (C) 2009-2012 ST Microelectronics
+ * Rajeev Kumar <rajeev-dlh.kumar@st.com>
  * Viresh Kumar <viresh.linux@gmail.com>
  *
  * This file is licensed under the terms of the GNU General Public
@@ -14,7 +13,23 @@
 #ifndef __MACH_IRQS_H
 #define __MACH_IRQS_H
 
+#ifdef CONFIG_ARCH_SPEAR3XX
+#define NR_IRQS			256
+#endif
+
+#ifdef CONFIG_ARCH_SPEAR6XX
+/* IRQ definitions */
+/* VIC 1 */
+#define IRQ_VIC_END				64
+
+/* GPIO pins virtual irqs */
+#define VIRTUAL_IRQS				24
+#define NR_IRQS					(IRQ_VIC_END + VIRTUAL_IRQS)
+#endif
+
+#ifdef CONFIG_ARCH_SPEAR13XX
 #define IRQ_GIC_END			160
 #define NR_IRQS				IRQ_GIC_END
+#endif
 
 #endif /* __MACH_IRQS_H */
diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index ce19113..58c15c6 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -1,10 +1,9 @@
 /*
- * arch/arm/mach-spear3xx/generic.h
+ * spear machine family generic header file
  *
- * SPEAr3XX machine family generic header file
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar<viresh.linux@gmail.com>
+ * Copyright (C) 2009-2012 ST Microelectronics
+ * Rajeev Kumar <rajeev-dlh.kumar@st.com>
+ * Viresh Kumar <viresh.linux@gmail.com>
  *
  * This file is licensed under the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
@@ -14,24 +13,47 @@
 #ifndef __MACH_GENERIC_H
 #define __MACH_GENERIC_H
 
+#include <linux/dmaengine.h>
 #include <linux/amba/pl08x.h>
 #include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/amba/bus.h>
 #include <asm/mach/time.h>
-#include <asm/mach/map.h>
 
-/* Add spear3xx family device structure declarations here */
+extern struct sys_timer spear13xx_timer;
 extern struct sys_timer spear3xx_timer;
 extern struct pl022_ssp_controller pl022_plat_data;
 extern struct pl08x_platform_data pl080_plat_data;
+extern struct dw_dma_platform_data dmac_plat_data;
+extern struct dw_dma_slave cf_dma_priv;
+extern struct dw_dma_slave nand_read_dma_priv;
+extern struct dw_dma_slave nand_write_dma_priv;
+bool dw_dma_filter(struct dma_chan *chan, void *slave);
 
-/* Add spear3xx family function declarations here */
 void __init spear_setup_of_timer(void);
 void __init spear3xx_clk_init(void);
 void __init spear3xx_map_io(void);
 void __init spear3xx_dt_init_irq(void);
+void __init spear6xx_clk_init(void);
+void __init spear13xx_map_io(void);
+void __init spear13xx_dt_init_irq(void);
+void __init spear13xx_l2x0_init(void);
 
 void spear_restart(char, const char *);
 
+void spear13xx_secondary_startup(void);
+void __cpuinit spear13xx_cpu_die(unsigned int cpu);
+
+extern struct smp_operations spear13xx_smp_ops;
+
+#ifdef CONFIG_MACH_SPEAR1310
+void __init spear1310_clk_init(void);
+#else
+static inline void spear1310_clk_init(void) {}
+#endif
+
+#ifdef CONFIG_MACH_SPEAR1340
+void __init spear1340_clk_init(void);
+#else
+static inline void spear1340_clk_init(void) {}
+#endif
+
 #endif /* __MACH_GENERIC_H */
diff --git a/arch/arm/mach-spear3xx/include/mach/irqs.h b/arch/arm/mach-spear3xx/include/mach/irqs.h
index f95e5b2..92da0a8 100644
--- a/arch/arm/mach-spear3xx/include/mach/irqs.h
+++ b/arch/arm/mach-spear3xx/include/mach/irqs.h
@@ -1,9 +1,8 @@
 /*
- * arch/arm/mach-spear3xx/include/mach/irqs.h
+ * IRQ helper macros for spear machine family
  *
- * IRQ helper macros for SPEAr3xx machine family
- *
- * Copyright (C) 2009 ST Microelectronics
+ * Copyright (C) 2009-2012 ST Microelectronics
+ * Rajeev Kumar <rajeev-dlh.kumar@st.com>
  * Viresh Kumar <viresh.linux@gmail.com>
  *
  * This file is licensed under the terms of the GNU General Public
@@ -14,6 +13,23 @@
 #ifndef __MACH_IRQS_H
 #define __MACH_IRQS_H
 
+#ifdef CONFIG_ARCH_SPEAR3XX
 #define NR_IRQS			256
+#endif
+
+#ifdef CONFIG_ARCH_SPEAR6XX
+/* IRQ definitions */
+/* VIC 1 */
+#define IRQ_VIC_END				64
+
+/* GPIO pins virtual irqs */
+#define VIRTUAL_IRQS				24
+#define NR_IRQS					(IRQ_VIC_END + VIRTUAL_IRQS)
+#endif
+
+#ifdef CONFIG_ARCH_SPEAR13XX
+#define IRQ_GIC_END			160
+#define NR_IRQS				IRQ_GIC_END
+#endif
 
 #endif /* __MACH_IRQS_H */
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 66e3a0c..bd46f3c 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -19,6 +19,7 @@
 #include <linux/of_platform.h>
 #include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
+#include <asm/mach/map.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
 
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index 38fe95d..56a9c26 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -17,9 +17,11 @@
 #include <linux/amba/pl08x.h>
 #include <linux/irqchip/spear-shirq.h>
 #include <linux/of_irq.h>
+#include <linux/clk.h>
 #include <linux/io.h>
 #include <asm/hardware/pl080.h>
 #include <asm/hardware/vic.h>
+#include <asm/mach/map.h>
 #include <plat/pl080.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
diff --git a/arch/arm/mach-spear6xx/include/mach/generic.h b/arch/arm/mach-spear6xx/include/mach/generic.h
index 65514b1..58c15c6 100644
--- a/arch/arm/mach-spear6xx/include/mach/generic.h
+++ b/arch/arm/mach-spear6xx/include/mach/generic.h
@@ -1,10 +1,9 @@
 /*
- * arch/arm/mach-spear6xx/include/mach/generic.h
+ * spear machine family generic header file
  *
- * SPEAr6XX machine family specific generic header file
- *
- * Copyright (C) 2009 ST Microelectronics
- * Rajeev Kumar<rajeev-dlh.kumar@st.com>
+ * Copyright (C) 2009-2012 ST Microelectronics
+ * Rajeev Kumar <rajeev-dlh.kumar@st.com>
+ * Viresh Kumar <viresh.linux@gmail.com>
  *
  * This file is licensed under the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
@@ -14,10 +13,47 @@
 #ifndef __MACH_GENERIC_H
 #define __MACH_GENERIC_H
 
+#include <linux/dmaengine.h>
+#include <linux/amba/pl08x.h>
 #include <linux/init.h>
+#include <asm/mach/time.h>
+
+extern struct sys_timer spear13xx_timer;
+extern struct sys_timer spear3xx_timer;
+extern struct pl022_ssp_controller pl022_plat_data;
+extern struct pl08x_platform_data pl080_plat_data;
+extern struct dw_dma_platform_data dmac_plat_data;
+extern struct dw_dma_slave cf_dma_priv;
+extern struct dw_dma_slave nand_read_dma_priv;
+extern struct dw_dma_slave nand_write_dma_priv;
+bool dw_dma_filter(struct dma_chan *chan, void *slave);
 
 void __init spear_setup_of_timer(void);
-void spear_restart(char, const char *);
+void __init spear3xx_clk_init(void);
+void __init spear3xx_map_io(void);
+void __init spear3xx_dt_init_irq(void);
 void __init spear6xx_clk_init(void);
+void __init spear13xx_map_io(void);
+void __init spear13xx_dt_init_irq(void);
+void __init spear13xx_l2x0_init(void);
+
+void spear_restart(char, const char *);
+
+void spear13xx_secondary_startup(void);
+void __cpuinit spear13xx_cpu_die(unsigned int cpu);
+
+extern struct smp_operations spear13xx_smp_ops;
+
+#ifdef CONFIG_MACH_SPEAR1310
+void __init spear1310_clk_init(void);
+#else
+static inline void spear1310_clk_init(void) {}
+#endif
+
+#ifdef CONFIG_MACH_SPEAR1340
+void __init spear1340_clk_init(void);
+#else
+static inline void spear1340_clk_init(void) {}
+#endif
 
 #endif /* __MACH_GENERIC_H */
diff --git a/arch/arm/mach-spear6xx/include/mach/irqs.h b/arch/arm/mach-spear6xx/include/mach/irqs.h
index 37a5c41..92da0a8 100644
--- a/arch/arm/mach-spear6xx/include/mach/irqs.h
+++ b/arch/arm/mach-spear6xx/include/mach/irqs.h
@@ -1,10 +1,9 @@
 /*
- * arch/arm/mach-spear6xx/include/mach/irqs.h
+ * IRQ helper macros for spear machine family
  *
- * IRQ helper macros for SPEAr6xx machine family
- *
- * Copyright (C) 2009 ST Microelectronics
- * Rajeev Kumar<rajeev-dlh.kumar@st.com>
+ * Copyright (C) 2009-2012 ST Microelectronics
+ * Rajeev Kumar <rajeev-dlh.kumar@st.com>
+ * Viresh Kumar <viresh.linux@gmail.com>
  *
  * This file is licensed under the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
@@ -14,6 +13,11 @@
 #ifndef __MACH_IRQS_H
 #define __MACH_IRQS_H
 
+#ifdef CONFIG_ARCH_SPEAR3XX
+#define NR_IRQS			256
+#endif
+
+#ifdef CONFIG_ARCH_SPEAR6XX
 /* IRQ definitions */
 /* VIC 1 */
 #define IRQ_VIC_END				64
@@ -21,5 +25,11 @@
 /* GPIO pins virtual irqs */
 #define VIRTUAL_IRQS				24
 #define NR_IRQS					(IRQ_VIC_END + VIRTUAL_IRQS)
+#endif
+
+#ifdef CONFIG_ARCH_SPEAR13XX
+#define IRQ_GIC_END			160
+#define NR_IRQS				IRQ_GIC_END
+#endif
 
-#endif	/* __MACH_IRQS_H */
+#endif /* __MACH_IRQS_H */
-- 
1.8.0
