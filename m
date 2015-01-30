From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 30 Jan 2015 09:45:31 +0900
Subject: [PATCH 2/2] ARM: shmobile: r8a7790: Instantiate GIC from C board code
 in legacy builds
In-Reply-To: <cover.1422577690.git.horms+renesas@verge.net.au>
References: <cover.1422577690.git.horms+renesas@verge.net.au>
Message-ID: <77cf5166f21c3b73b04571311dc89a327424f594.1422577690.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

As of commit 9a1091ef0017c40a ("irqchip: gic: Support hierarchy irq
domain."), the Lager legacy board support is known to be broken.

The IRQ numbers of the GIC are now virtual, and no longer match the
hardcoded hardware IRQ numbers in the legacy platform board code.

To fix this issue specific to non-multiplatform r8a7790 and Lager:
 1) Instantiate the GIC from platform board code and also
 2) Skip over the DT arch timer as well as
 3) Force delay setup based on DT CPU frequency

With these 3 fixes in place interrupts on Lager are now unbroken.

Partially based on legacy GIC fix by Geert Uytterhoeven, thanks to
him for the initial work.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager.c     | 13 +++++++++++++
 arch/arm/mach-shmobile/setup-rcar-gen2.c |  2 ++
 arch/arm/mach-shmobile/timer.c           |  5 +++++
 3 files changed, 20 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 571327b..3f51327 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -25,6 +25,8 @@
 #include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/arm-gic.h>
 #include <linux/kernel.h>
 #include <linux/leds.h>
 #include <linux/mfd/tmio.h>
@@ -873,6 +875,16 @@ static void __init lager_init(void)
 					  lager_ksz8041_fixup);
 }
 
+static void __init lager_legacy_init_irq(void)
+{
+	void __iomem *gic_dist_base = ioremap_nocache(0xf1001000, 0x1000);
+	void __iomem *gic_cpu_base = ioremap_nocache(0xf1002000, 0x1000);
+
+	gic_init(0, 29, gic_dist_base, gic_cpu_base);
+
+	/* Do not invoke DT-based interrupt code via irqchip_init() */
+}
+
 static const char * const lager_boards_compat_dt[] __initconst = {
 	"renesas,lager",
 	NULL,
@@ -881,6 +893,7 @@ static const char * const lager_boards_compat_dt[] __initconst = {
 DT_MACHINE_START(LAGER_DT, "lager")
 	.smp		= smp_ops(r8a7790_smp_ops),
 	.init_early	= shmobile_init_delay,
+	.init_irq	= lager_legacy_init_irq,
 	.init_time	= rcar_gen2_timer_init,
 	.init_machine	= lager_init,
 	.init_late	= shmobile_init_late,
diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 7ed9279..101b3e4 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -137,7 +137,9 @@ void __init rcar_gen2_timer_init(void)
 #ifdef CONFIG_COMMON_CLK
 	rcar_gen2_clocks_init(mode);
 #endif
+#ifdef CONFIG_ARCH_SHMOBILE_MULTI
 	clocksource_of_init();
+#endif
 }
 
 struct memory_reserve_config {
diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
index 44d32a8..88f067b 100644
--- a/arch/arm/mach-shmobile/timer.c
+++ b/arch/arm/mach-shmobile/timer.c
@@ -80,6 +80,11 @@ void __init shmobile_init_delay(void)
 	 * to GIC being initialized from C and arch timer via DT */
 	if (of_machine_is_compatible("renesas,r8a73a4"))
 		has_arch_timer = false;
+
+	/* Non-multiplatform r8a7790 SoC cannot use arch timer due
+	 * to GIC being initialized from C and arch timer via DT */
+	if (of_machine_is_compatible("renesas,r8a7790"))
+		has_arch_timer = false;
 #endif
 
 	if (!has_arch_timer || !IS_ENABLED(CONFIG_ARM_ARCH_TIMER)) {
-- 
2.1.4
