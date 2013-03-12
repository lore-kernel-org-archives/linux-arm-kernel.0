From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Mar 2013 17:46:51 +0100
Subject: [PATCH v2 08/13] ARM: spear: move generic.h and pl080.h into private
 dir
In-Reply-To: <1363106816-9603-1-git-send-email-arnd@arndb.de>
References: <1363106816-9603-1-git-send-email-arnd@arndb.de>
Message-ID: <1363106816-9603-9-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No file outside of mach-spear includes these files any more,
so they don't have to be globally visible now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-spear/generic.h               | 58 +++++++++++++++++++++++++++++
 arch/arm/mach-spear/include/mach/generic.h  | 58 -----------------------------
 arch/arm/mach-spear/include/mach/hardware.h |  1 -
 arch/arm/mach-spear/include/plat/pl080.h    | 21 -----------
 arch/arm/mach-spear/pl080.h                 | 21 +++++++++++
 arch/arm/mach-spear/platsmp.c               |  2 +-
 arch/arm/mach-spear/restart.c               |  2 +-
 arch/arm/mach-spear/spear1310.c             |  2 +-
 arch/arm/mach-spear/spear1340.c             |  2 +-
 arch/arm/mach-spear/spear13xx.c             |  2 +-
 arch/arm/mach-spear/spear300.c              |  2 +-
 arch/arm/mach-spear/spear310.c              |  2 +-
 arch/arm/mach-spear/spear320.c              |  2 +-
 arch/arm/mach-spear/spear3xx.c              |  4 +-
 arch/arm/mach-spear/spear6xx.c              |  4 +-
 arch/arm/mach-spear/time.c                  |  2 +-
 16 files changed, 92 insertions(+), 93 deletions(-)
 create mode 100644 arch/arm/mach-spear/generic.h
 delete mode 100644 arch/arm/mach-spear/include/mach/generic.h
 delete mode 100644 arch/arm/mach-spear/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-spear/include/plat/pl080.h
 create mode 100644 arch/arm/mach-spear/pl080.h

diff --git a/arch/arm/mach-spear/generic.h b/arch/arm/mach-spear/generic.h
new file mode 100644
index 0000000..af47d9b
--- /dev/null
+++ b/arch/arm/mach-spear/generic.h
@@ -0,0 +1,58 @@
+/*
+ * spear machine family generic header file
+ *
+ * Copyright (C) 2009-2012 ST Microelectronics
+ * Rajeev Kumar <rajeev-dlh.kumar@st.com>
+ * Viresh Kumar <viresh.linux@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_GENERIC_H
+#define __MACH_GENERIC_H
+
+#include <linux/dmaengine.h>
+#include <linux/amba/pl08x.h>
+#include <linux/init.h>
+#include <asm/mach/time.h>
+
+extern void spear13xx_timer_init(void);
+extern void spear3xx_timer_init(void);
+extern struct pl022_ssp_controller pl022_plat_data;
+extern struct pl08x_platform_data pl080_plat_data;
+extern struct dw_dma_platform_data dmac_plat_data;
+extern struct dw_dma_slave cf_dma_priv;
+extern struct dw_dma_slave nand_read_dma_priv;
+extern struct dw_dma_slave nand_write_dma_priv;
+bool dw_dma_filter(struct dma_chan *chan, void *slave);
+
+void __init spear_setup_of_timer(void);
+void __init spear3xx_clk_init(void);
+void __init spear3xx_map_io(void);
+void __init spear3xx_dt_init_irq(void);
+void __init spear6xx_clk_init(void);
+void __init spear13xx_map_io(void);
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
+
+#endif /* __MACH_GENERIC_H */
diff --git a/arch/arm/mach-spear/include/mach/generic.h b/arch/arm/mach-spear/include/mach/generic.h
deleted file mode 100644
index af47d9b..0000000
--- a/arch/arm/mach-spear/include/mach/generic.h
+++ /dev/null
@@ -1,58 +0,0 @@
-/*
- * spear machine family generic header file
- *
- * Copyright (C) 2009-2012 ST Microelectronics
- * Rajeev Kumar <rajeev-dlh.kumar@st.com>
- * Viresh Kumar <viresh.linux@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_GENERIC_H
-#define __MACH_GENERIC_H
-
-#include <linux/dmaengine.h>
-#include <linux/amba/pl08x.h>
-#include <linux/init.h>
-#include <asm/mach/time.h>
-
-extern void spear13xx_timer_init(void);
-extern void spear3xx_timer_init(void);
-extern struct pl022_ssp_controller pl022_plat_data;
-extern struct pl08x_platform_data pl080_plat_data;
-extern struct dw_dma_platform_data dmac_plat_data;
-extern struct dw_dma_slave cf_dma_priv;
-extern struct dw_dma_slave nand_read_dma_priv;
-extern struct dw_dma_slave nand_write_dma_priv;
-bool dw_dma_filter(struct dma_chan *chan, void *slave);
-
-void __init spear_setup_of_timer(void);
-void __init spear3xx_clk_init(void);
-void __init spear3xx_map_io(void);
-void __init spear3xx_dt_init_irq(void);
-void __init spear6xx_clk_init(void);
-void __init spear13xx_map_io(void);
-void __init spear13xx_l2x0_init(void);
-
-void spear_restart(char, const char *);
-
-void spear13xx_secondary_startup(void);
-void __cpuinit spear13xx_cpu_die(unsigned int cpu);
-
-extern struct smp_operations spear13xx_smp_ops;
-
-#ifdef CONFIG_MACH_SPEAR1310
-void __init spear1310_clk_init(void);
-#else
-static inline void spear1310_clk_init(void) {}
-#endif
-
-#ifdef CONFIG_MACH_SPEAR1340
-void __init spear1340_clk_init(void);
-#else
-static inline void spear1340_clk_init(void) {}
-#endif
-
-#endif /* __MACH_GENERIC_H */
diff --git a/arch/arm/mach-spear/include/mach/hardware.h b/arch/arm/mach-spear/include/mach/hardware.h
deleted file mode 100644
index 40a8c17..0000000
--- a/arch/arm/mach-spear/include/mach/hardware.h
+++ /dev/null
@@ -1 +0,0 @@
-/* empty */
diff --git a/arch/arm/mach-spear/include/plat/pl080.h b/arch/arm/mach-spear/include/plat/pl080.h
deleted file mode 100644
index eb6590d..0000000
--- a/arch/arm/mach-spear/include/plat/pl080.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * arch/arm/plat-spear/include/plat/pl080.h
- *
- * DMAC pl080 definitions for SPEAr platform
- *
- * Copyright (C) 2012 ST Microelectronics
- * Viresh Kumar <viresh.linux@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __PLAT_PL080_H
-#define __PLAT_PL080_H
-
-struct pl08x_channel_data;
-int pl080_get_signal(const struct pl08x_channel_data *cd);
-void pl080_put_signal(const struct pl08x_channel_data *cd, int signal);
-
-#endif /* __PLAT_PL080_H */
diff --git a/arch/arm/mach-spear/pl080.h b/arch/arm/mach-spear/pl080.h
new file mode 100644
index 0000000..eb6590d
--- /dev/null
+++ b/arch/arm/mach-spear/pl080.h
@@ -0,0 +1,21 @@
+/*
+ * arch/arm/plat-spear/include/plat/pl080.h
+ *
+ * DMAC pl080 definitions for SPEAr platform
+ *
+ * Copyright (C) 2012 ST Microelectronics
+ * Viresh Kumar <viresh.linux@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __PLAT_PL080_H
+#define __PLAT_PL080_H
+
+struct pl08x_channel_data;
+int pl080_get_signal(const struct pl08x_channel_data *cd);
+void pl080_put_signal(const struct pl08x_channel_data *cd, int signal);
+
+#endif /* __PLAT_PL080_H */
diff --git a/arch/arm/mach-spear/platsmp.c b/arch/arm/mach-spear/platsmp.c
index af4ade6..927979e 100644
--- a/arch/arm/mach-spear/platsmp.c
+++ b/arch/arm/mach-spear/platsmp.c
@@ -19,7 +19,7 @@
 #include <asm/cacheflush.h>
 #include <asm/smp_scu.h>
 #include <mach/spear.h>
-#include <mach/generic.h>
+#include "generic.h"
 
 static DEFINE_SPINLOCK(boot_lock);
 
diff --git a/arch/arm/mach-spear/restart.c b/arch/arm/mach-spear/restart.c
index 7d4616d..004f0f2 100644
--- a/arch/arm/mach-spear/restart.c
+++ b/arch/arm/mach-spear/restart.c
@@ -14,7 +14,7 @@
 #include <linux/amba/sp810.h>
 #include <asm/system_misc.h>
 #include <mach/spear.h>
-#include <mach/generic.h>
+#include "generic.h"
 
 #define SPEAR13XX_SYS_SW_RES			(VA_MISC_BASE + 0x204)
 void spear_restart(char mode, const char *cmd)
diff --git a/arch/arm/mach-spear/spear1310.c b/arch/arm/mach-spear/spear1310.c
index 56214d1..fe868b2 100644
--- a/arch/arm/mach-spear/spear1310.c
+++ b/arch/arm/mach-spear/spear1310.c
@@ -19,7 +19,7 @@
 #include <linux/pata_arasan_cf_data.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <mach/generic.h>
+#include "generic.h"
 #include <mach/spear.h>
 
 /* Base addresses */
diff --git a/arch/arm/mach-spear/spear1340.c b/arch/arm/mach-spear/spear1340.c
index b01c4c7..75e3864 100644
--- a/arch/arm/mach-spear/spear1340.c
+++ b/arch/arm/mach-spear/spear1340.c
@@ -20,7 +20,7 @@
 #include <linux/of_platform.h>
 #include <linux/irqchip.h>
 #include <asm/mach/arch.h>
-#include <mach/generic.h>
+#include "generic.h"
 #include <mach/spear.h>
 
 #include "spear13xx-dma.h"
diff --git a/arch/arm/mach-spear/spear13xx.c b/arch/arm/mach-spear/spear13xx.c
index 988fefe..6f62dd5 100644
--- a/arch/arm/mach-spear/spear13xx.c
+++ b/arch/arm/mach-spear/spear13xx.c
@@ -21,7 +21,7 @@
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/map.h>
 #include <asm/smp_twd.h>
-#include <mach/generic.h>
+#include "generic.h"
 #include <mach/spear.h>
 
 #include "spear13xx-dma.h"
diff --git a/arch/arm/mach-spear/spear300.c b/arch/arm/mach-spear/spear300.c
index 72449ee..bac56e8 100644
--- a/arch/arm/mach-spear/spear300.c
+++ b/arch/arm/mach-spear/spear300.c
@@ -17,7 +17,7 @@
 #include <linux/irqchip.h>
 #include <linux/of_platform.h>
 #include <asm/mach/arch.h>
-#include <mach/generic.h>
+#include "generic.h"
 #include <mach/spear.h>
 
 /* DMAC platform data's slave info */
diff --git a/arch/arm/mach-spear/spear310.c b/arch/arm/mach-spear/spear310.c
index 0b7962d..6ffbc63 100644
--- a/arch/arm/mach-spear/spear310.c
+++ b/arch/arm/mach-spear/spear310.c
@@ -18,7 +18,7 @@
 #include <linux/irqchip.h>
 #include <linux/of_platform.h>
 #include <asm/mach/arch.h>
-#include <mach/generic.h>
+#include "generic.h"
 #include <mach/spear.h>
 
 #define SPEAR310_UART1_BASE		UL(0xB2000000)
diff --git a/arch/arm/mach-spear/spear320.c b/arch/arm/mach-spear/spear320.c
index e9db7db..b8a4bb5 100644
--- a/arch/arm/mach-spear/spear320.c
+++ b/arch/arm/mach-spear/spear320.c
@@ -20,7 +20,7 @@
 #include <linux/of_platform.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <mach/generic.h>
+#include "generic.h"
 #include <mach/spear.h>
 
 #define SPEAR320_UART1_BASE		UL(0xA3000000)
diff --git a/arch/arm/mach-spear/spear3xx.c b/arch/arm/mach-spear/spear3xx.c
index d7580f2..be0c94d 100644
--- a/arch/arm/mach-spear/spear3xx.c
+++ b/arch/arm/mach-spear/spear3xx.c
@@ -18,8 +18,8 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <asm/mach/map.h>
-#include <plat/pl080.h>
-#include <mach/generic.h>
+#include "pl080.h"
+#include "generic.h"
 #include <mach/spear.h>
 
 /* ssp device registration */
diff --git a/arch/arm/mach-spear/spear6xx.c b/arch/arm/mach-spear/spear6xx.c
index 97fb31d..78e1359 100644
--- a/arch/arm/mach-spear/spear6xx.c
+++ b/arch/arm/mach-spear/spear6xx.c
@@ -24,8 +24,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
-#include <plat/pl080.h>
-#include <mach/generic.h>
+#include "pl080.h"
+#include "generic.h"
 #include <mach/spear.h>
 
 /* dmac device registration */
diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
index bd5c53c..d449673 100644
--- a/arch/arm/mach-spear/time.c
+++ b/arch/arm/mach-spear/time.c
@@ -23,7 +23,7 @@
 #include <linux/time.h>
 #include <linux/irq.h>
 #include <asm/mach/time.h>
-#include <mach/generic.h>
+#include "generic.h"
 
 /*
  * We would use TIMER0 and TIMER1 as clockevent and clocksource.
-- 
1.8.1.2
