From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 17 Jun 2014 16:47:53 +0900
Subject: [PATCH v2 07/08] ARM: shmobile: Move pm-rcar.h, cleanup r8a7779 case
In-Reply-To: <20140617074658.30008.53021.sendpatchset@w520>
References: <20140617074658.30008.53021.sendpatchset@w520>
Message-ID: <20140617074753.30008.57290.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Change location of pm-rcar.h so it can be used as #include "pm-rcar.h"
instead of the old style #include <mach/pm-rcar.h>. Also clean up
the r8a7779 case to move some unused header file cruft into a C
file.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---

 Changes since V1:
 - rebased to v3.16-rc1

 arch/arm/mach-shmobile/include/mach/pm-rcar.h |   15 ---------------
 arch/arm/mach-shmobile/include/mach/r8a7779.h |   12 ------------
 arch/arm/mach-shmobile/pm-r8a7779.c           |   13 ++++++++++++-
 arch/arm/mach-shmobile/pm-r8a7790.c           |    2 +-
 arch/arm/mach-shmobile/pm-rcar.c              |    2 +-
 arch/arm/mach-shmobile/pm-rcar.h              |   15 +++++++++++++++
 arch/arm/mach-shmobile/smp-r8a7779.c          |    2 +-
 arch/arm/mach-shmobile/smp-r8a7790.c          |    2 +-
 8 files changed, 31 insertions(+), 32 deletions(-)

--- 0001/arch/arm/mach-shmobile/include/mach/pm-rcar.h
+++ /dev/null	2013-06-03 21:41:10.638032047 +0900
@@ -1,15 +0,0 @@
-#ifndef PM_RCAR_H
-#define PM_RCAR_H
-
-struct rcar_sysc_ch {
-	unsigned long chan_offs;
-	unsigned int chan_bit;
-	unsigned int isr_bit;
-};
-
-int rcar_sysc_power_down(struct rcar_sysc_ch *sysc_ch);
-int rcar_sysc_power_up(struct rcar_sysc_ch *sysc_ch);
-bool rcar_sysc_power_is_off(struct rcar_sysc_ch *sysc_ch);
-void __iomem *rcar_sysc_init(phys_addr_t base);
-
-#endif /* PM_RCAR_H */
--- 0001/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a7779.h	2014-06-17 16:13:54.000000000 +0900
@@ -2,8 +2,6 @@
 #define __ASM_R8A7779_H__
 
 #include <linux/sh_clk.h>
-#include <linux/pm_domain.h>
-#include <mach/pm-rcar.h>
 
 /* HPB-DMA slave IDs */
 enum {
@@ -12,16 +10,6 @@ enum {
 	HPBDMA_SLAVE_SDHI0_RX,
 };
 
-struct r8a7779_pm_domain {
-	struct generic_pm_domain genpd;
-	struct rcar_sysc_ch ch;
-};
-
-static inline struct rcar_sysc_ch *to_r8a7779_ch(struct generic_pm_domain *d)
-{
-	return &container_of(d, struct r8a7779_pm_domain, genpd)->ch;
-}
-
 extern void r8a7779_init_delay(void);
 extern void r8a7779_init_irq_extpin(int irlm);
 extern void r8a7779_init_irq_extpin_dt(int irlm);
--- 0006/arch/arm/mach-shmobile/pm-r8a7779.c
+++ work/arch/arm/mach-shmobile/pm-r8a7779.c	2014-06-17 16:10:26.000000000 +0900
@@ -13,20 +13,31 @@
 #include <linux/suspend.h>
 #include <linux/err.h>
 #include <linux/pm_clock.h>
+#include <linux/pm_domain.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/console.h>
 #include <asm/io.h>
-#include <mach/pm-rcar.h>
 #include <mach/r8a7779.h>
 #include "common.h"
+#include "pm-rcar.h"
 
 /* SYSC */
 #define SYSCIER 0x0c
 #define SYSCIMR 0x10
 
+struct r8a7779_pm_domain {
+	struct generic_pm_domain genpd;
+	struct rcar_sysc_ch ch;
+};
+
+static inline struct rcar_sysc_ch *to_r8a7779_ch(struct generic_pm_domain *d)
+{
+	return &container_of(d, struct r8a7779_pm_domain, genpd)->ch;
+}
+
 #if defined(CONFIG_PM) || defined(CONFIG_SMP)
 
 static void __init r8a7779_sysc_init(void)
--- 0001/arch/arm/mach-shmobile/pm-r8a7790.c
+++ work/arch/arm/mach-shmobile/pm-r8a7790.c	2014-06-17 16:10:26.000000000 +0900
@@ -12,8 +12,8 @@
 
 #include <linux/kernel.h>
 #include <asm/io.h>
-#include <mach/pm-rcar.h>
 #include <mach/r8a7790.h>
+#include "pm-rcar.h"
 
 /* SYSC */
 #define SYSCIER 0x0c
--- 0001/arch/arm/mach-shmobile/pm-rcar.c
+++ work/arch/arm/mach-shmobile/pm-rcar.c	2014-06-17 16:10:26.000000000 +0900
@@ -13,7 +13,7 @@
 #include <linux/mm.h>
 #include <linux/spinlock.h>
 #include <asm/io.h>
-#include <mach/pm-rcar.h>
+#include "pm-rcar.h"
 
 /* SYSC */
 #define SYSCSR 0x00
--- /dev/null
+++ work/arch/arm/mach-shmobile/pm-rcar.h	2014-06-17 16:10:26.000000000 +0900
@@ -0,0 +1,15 @@
+#ifndef PM_RCAR_H
+#define PM_RCAR_H
+
+struct rcar_sysc_ch {
+	unsigned long chan_offs;
+	unsigned int chan_bit;
+	unsigned int isr_bit;
+};
+
+int rcar_sysc_power_down(struct rcar_sysc_ch *sysc_ch);
+int rcar_sysc_power_up(struct rcar_sysc_ch *sysc_ch);
+bool rcar_sysc_power_is_off(struct rcar_sysc_ch *sysc_ch);
+void __iomem *rcar_sysc_init(phys_addr_t base);
+
+#endif /* PM_RCAR_H */
--- 0006/arch/arm/mach-shmobile/smp-r8a7779.c
+++ work/arch/arm/mach-shmobile/smp-r8a7779.c	2014-06-17 16:10:26.000000000 +0900
@@ -23,13 +23,13 @@
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/delay.h>
-#include <mach/pm-rcar.h>
 #include <mach/r8a7779.h>
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 #include <asm/smp_twd.h>
 #include "common.h"
+#include "pm-rcar.h"
 
 #define AVECR IOMEM(0xfe700040)
 #define R8A7779_SCU_BASE 0xf0000000
--- 0006/arch/arm/mach-shmobile/smp-r8a7790.c
+++ work/arch/arm/mach-shmobile/smp-r8a7790.c	2014-06-17 16:10:26.000000000 +0900
@@ -18,9 +18,9 @@
 #include <linux/smp.h>
 #include <linux/io.h>
 #include <asm/smp_plat.h>
-#include <mach/pm-rcar.h>
 #include <mach/r8a7790.h>
 #include "common.h"
+#include "pm-rcar.h"
 
 #define RST		0xe6160000
 #define CA15BAR		0x0020
