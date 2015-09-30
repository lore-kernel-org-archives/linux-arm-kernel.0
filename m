From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 30 Sep 2015 17:50:20 +0200
Subject: [PATCH 3/3] ARM: shmobile: r8a7779: Remove legacy PM Domain remainings
In-Reply-To: <1443628220-1352-1-git-send-email-geert+renesas@glider.be>
References: <1443628220-1352-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1443628220-1352-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit c99cd90d98a98aa1 ("ARM: shmobile: r8a7779: Remove legacy
SoC code"), r8a7779_init_pm_domains() is no longer called.

Remove all related legacy PM Domain code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/pm-r8a7779.c | 99 -------------------------------------
 arch/arm/mach-shmobile/r8a7779.h    |  6 ---
 2 files changed, 105 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-r8a7779.c b/arch/arm/mach-shmobile/pm-r8a7779.c
index 47a862e7f8bab242..14c42a1bdf1ef20d 100644
--- a/arch/arm/mach-shmobile/pm-r8a7779.c
+++ b/arch/arm/mach-shmobile/pm-r8a7779.c
@@ -9,20 +9,8 @@
  * for more details.
  */
 
-#include <linux/pm.h>
-#include <linux/suspend.h>
-#include <linux/err.h>
-#include <linux/pm_clock.h>
-#include <linux/pm_domain.h>
-#include <linux/platform_device.h>
-#include <linux/delay.h>
-#include <linux/irq.h>
-#include <linux/interrupt.h>
-#include <linux/console.h>
-
 #include <asm/io.h>
 
-#include "common.h"
 #include "pm-rcar.h"
 #include "r8a7779.h"
 
@@ -30,17 +18,6 @@
 #define SYSCIER 0x0c
 #define SYSCIMR 0x10
 
-struct r8a7779_pm_domain {
-	struct generic_pm_domain genpd;
-	struct rcar_sysc_ch ch;
-};
-
-static inline
-const struct rcar_sysc_ch *to_r8a7779_ch(struct generic_pm_domain *d)
-{
-	return &container_of(d, struct r8a7779_pm_domain, genpd)->ch;
-}
-
 #if defined(CONFIG_PM) || defined(CONFIG_SMP)
 
 static void __init r8a7779_sysc_init(void)
@@ -58,82 +35,6 @@ static inline void r8a7779_sysc_init(void) {}
 
 #endif /* CONFIG_PM || CONFIG_SMP */
 
-#ifdef CONFIG_PM
-
-static int pd_power_down(struct generic_pm_domain *genpd)
-{
-	return rcar_sysc_power_down(to_r8a7779_ch(genpd));
-}
-
-static int pd_power_up(struct generic_pm_domain *genpd)
-{
-	return rcar_sysc_power_up(to_r8a7779_ch(genpd));
-}
-
-static bool pd_is_off(struct generic_pm_domain *genpd)
-{
-	return rcar_sysc_power_is_off(to_r8a7779_ch(genpd));
-}
-
-static bool pd_active_wakeup(struct device *dev)
-{
-	return true;
-}
-
-static void r8a7779_init_pm_domain(struct r8a7779_pm_domain *r8a7779_pd)
-{
-	struct generic_pm_domain *genpd = &r8a7779_pd->genpd;
-
-	pm_genpd_init(genpd, NULL, false);
-	genpd->dev_ops.active_wakeup = pd_active_wakeup;
-	genpd->power_off = pd_power_down;
-	genpd->power_on = pd_power_up;
-
-	if (pd_is_off(&r8a7779_pd->genpd))
-		pd_power_up(&r8a7779_pd->genpd);
-}
-
-static struct r8a7779_pm_domain r8a7779_pm_domains[] = {
-	{
-		.genpd.name = "SH4A",
-		.ch = {
-			.chan_offs = 0x80, /* PWRSR1 .. PWRER1 */
-			.isr_bit = 16, /* SH4A */
-		},
-	},
-	{
-		.genpd.name = "SGX",
-		.ch = {
-			.chan_offs = 0xc0, /* PWRSR2 .. PWRER2 */
-			.isr_bit = 20, /* SGX */
-		},
-	},
-	{
-		.genpd.name = "VDP1",
-		.ch = {
-			.chan_offs = 0x100, /* PWRSR3 .. PWRER3 */
-			.isr_bit = 21, /* VDP */
-		},
-	},
-	{
-		.genpd.name = "IMPX3",
-		.ch = {
-			.chan_offs = 0x140, /* PWRSR4 .. PWRER4 */
-			.isr_bit = 24, /* IMP */
-		},
-	},
-};
-
-void __init r8a7779_init_pm_domains(void)
-{
-	int j;
-
-	for (j = 0; j < ARRAY_SIZE(r8a7779_pm_domains); j++)
-		r8a7779_init_pm_domain(&r8a7779_pm_domains[j]);
-}
-
-#endif /* CONFIG_PM */
-
 void __init r8a7779_pm_init(void)
 {
 	static int once;
diff --git a/arch/arm/mach-shmobile/r8a7779.h b/arch/arm/mach-shmobile/r8a7779.h
index aad833a8f0b8c5f1..e1aaa2ef9376c91d 100644
--- a/arch/arm/mach-shmobile/r8a7779.h
+++ b/arch/arm/mach-shmobile/r8a7779.h
@@ -3,12 +3,6 @@
 
 extern void r8a7779_pm_init(void);
 
-#ifdef CONFIG_PM
-extern void __init r8a7779_init_pm_domains(void);
-#else
-static inline void r8a7779_init_pm_domains(void) {}
-#endif /* CONFIG_PM */
-
 extern struct smp_operations r8a7779_smp_ops;
 
 #endif /* __ASM_R8A7779_H__ */
-- 
1.9.1
