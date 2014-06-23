From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:25:03 +0900
Subject: [PATCH 7/8] ARM: shmobile: Move pm-rcar.h, cleanup r8a7779 case
In-Reply-To: <cover.1403487267.git.horms+renesas@verge.net.au>
References: <cover.1403487267.git.horms+renesas@verge.net.au>
Message-ID: <585c09df3738d4f72cee36eb0b975351fd9a339a.1403487267.git.horms+renesas@verge.net.au>
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
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/pm-rcar.h | 15 ---------------
 arch/arm/mach-shmobile/include/mach/r8a7779.h | 12 ------------
 arch/arm/mach-shmobile/pm-r8a7779.c           | 13 ++++++++++++-
 arch/arm/mach-shmobile/pm-r8a7790.c           |  2 +-
 arch/arm/mach-shmobile/pm-rcar.c              |  2 +-
 arch/arm/mach-shmobile/pm-rcar.h              | 15 +++++++++++++++
 arch/arm/mach-shmobile/smp-r8a7779.c          |  2 +-
 arch/arm/mach-shmobile/smp-r8a7790.c          |  2 +-
 8 files changed, 31 insertions(+), 32 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/include/mach/pm-rcar.h
 create mode 100644 arch/arm/mach-shmobile/pm-rcar.h

diff --git a/arch/arm/mach-shmobile/include/mach/pm-rcar.h b/arch/arm/mach-shmobile/include/mach/pm-rcar.h
deleted file mode 100644
index ef3a1ef..0000000
--- a/arch/arm/mach-shmobile/include/mach/pm-rcar.h
+++ /dev/null
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
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7779.h b/arch/arm/mach-shmobile/include/mach/r8a7779.h
index 88eecea..def10a2 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7779.h
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
diff --git a/arch/arm/mach-shmobile/pm-r8a7779.c b/arch/arm/mach-shmobile/pm-r8a7779.c
index 2b79bac..f0f36cb 100644
--- a/arch/arm/mach-shmobile/pm-r8a7779.c
+++ b/arch/arm/mach-shmobile/pm-r8a7779.c
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
diff --git a/arch/arm/mach-shmobile/pm-r8a7790.c b/arch/arm/mach-shmobile/pm-r8a7790.c
index fc82839..0f1090d8 100644
--- a/arch/arm/mach-shmobile/pm-r8a7790.c
+++ b/arch/arm/mach-shmobile/pm-r8a7790.c
@@ -12,8 +12,8 @@
 
 #include <linux/kernel.h>
 #include <asm/io.h>
-#include <mach/pm-rcar.h>
 #include <mach/r8a7790.h>
+#include "pm-rcar.h"
 
 /* SYSC */
 #define SYSCIER 0x0c
diff --git a/arch/arm/mach-shmobile/pm-rcar.c b/arch/arm/mach-shmobile/pm-rcar.c
index 1f465a1..34b8a56 100644
--- a/arch/arm/mach-shmobile/pm-rcar.c
+++ b/arch/arm/mach-shmobile/pm-rcar.c
@@ -13,7 +13,7 @@
 #include <linux/mm.h>
 #include <linux/spinlock.h>
 #include <asm/io.h>
-#include <mach/pm-rcar.h>
+#include "pm-rcar.h"
 
 /* SYSC */
 #define SYSCSR 0x00
diff --git a/arch/arm/mach-shmobile/pm-rcar.h b/arch/arm/mach-shmobile/pm-rcar.h
new file mode 100644
index 0000000..ef3a1ef
--- /dev/null
+++ b/arch/arm/mach-shmobile/pm-rcar.h
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
diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index e063cd2..c230fc0 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
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
diff --git a/arch/arm/mach-shmobile/smp-r8a7790.c b/arch/arm/mach-shmobile/smp-r8a7790.c
index fea53d5..a8ace58 100644
--- a/arch/arm/mach-shmobile/smp-r8a7790.c
+++ b/arch/arm/mach-shmobile/smp-r8a7790.c
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
-- 
2.0.0.rc2
