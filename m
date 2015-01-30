From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 30 Jan 2015 09:45:30 +0900
Subject: [PATCH 1/2] ARM: shmobile: r8a73a4: Instantiate GIC from C board code
 in legacy builds
In-Reply-To: <cover.1422577690.git.horms+renesas@verge.net.au>
References: <cover.1422577690.git.horms+renesas@verge.net.au>
Message-ID: <974b072f71e350bf2c5fb9cfd5c6c9d341a53300.1422577690.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

As of commit 9a1091ef0017c40a ("irqchip: gic: Support hierarchy irq
domain."), the APE6EVM legacy board support is known to be broken.

The IRQ numbers of the GIC are now virtual, and no longer match the
hardcoded hardware IRQ numbers in the legacy platform board code.

To fix this issue specific to non-muliplatform r8a73a4 and APE6EVM:
 1) Instantiate the GIC from platform board code and also
 2) Skip over the DT arch timer as well as
 3) Force delay setup based on DT CPU frequency

With these 3 fixes in place interrupts on APE6EVM are now unbroken.

Partially based on legacy GIC fix by Geert Uytterhoeven, thanks to
him for the initial work.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ape6evm.c | 20 ++++++++++++++++++++
 arch/arm/mach-shmobile/timer.c         |  7 +++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index b222f68..2cca5ef 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -22,6 +22,8 @@
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/arm-gic.h>
 #include <linux/kernel.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
@@ -277,6 +279,22 @@ static void __init ape6evm_add_standard_devices(void)
 				      sizeof(ape6evm_leds_pdata));
 }
 
+static void __init ape6evm_legacy_init_time(void)
+{
+	/* Do not invoke DT-based timers via clocksource_of_init() */
+}
+
+static void __init ape6evm_legacy_init_irq(void)
+{
+	void __iomem *gic_dist_base = ioremap_nocache(0xf1001000, 0x1000);
+	void __iomem *gic_cpu_base = ioremap_nocache(0xf1002000, 0x1000);
+
+	gic_init(0, 29, gic_dist_base, gic_cpu_base);
+
+	/* Do not invoke DT-based interrupt code via irqchip_init() */
+}
+
+
 static const char *ape6evm_boards_compat_dt[] __initdata = {
 	"renesas,ape6evm",
 	NULL,
@@ -284,7 +302,9 @@ static const char *ape6evm_boards_compat_dt[] __initdata = {
 
 DT_MACHINE_START(APE6EVM_DT, "ape6evm")
 	.init_early	= shmobile_init_delay,
+	.init_irq       = ape6evm_legacy_init_irq,
 	.init_machine	= ape6evm_add_standard_devices,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= ape6evm_boards_compat_dt,
+	.init_time	= ape6evm_legacy_init_time,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
index 32ee335..44d32a8 100644
--- a/arch/arm/mach-shmobile/timer.c
+++ b/arch/arm/mach-shmobile/timer.c
@@ -75,6 +75,13 @@ void __init shmobile_init_delay(void)
 	if (!max_freq)
 		return;
 
+#ifdef CONFIG_ARCH_SHMOBILE_LEGACY
+	/* Non-multiplatform r8a73a4 SoC cannot use arch timer due
+	 * to GIC being initialized from C and arch timer via DT */
+	if (of_machine_is_compatible("renesas,r8a73a4"))
+		has_arch_timer = false;
+#endif
+
 	if (!has_arch_timer || !IS_ENABLED(CONFIG_ARM_ARCH_TIMER)) {
 		if (is_a7_a8_a9)
 			shmobile_setup_delay_hz(max_freq, 1, 3);
-- 
2.1.4
