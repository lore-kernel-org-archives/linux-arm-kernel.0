From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 May 2011 18:28:55 +0100
Subject: [PATCH 10/19] clocksource: convert Integrator/AP 16-bit down
	counting clocksource
In-Reply-To: <20110516172334.GD13659@n2100.arm.linux.org.uk>
References: <20110516172334.GD13659@n2100.arm.linux.org.uk>
Message-ID: <E1QM1bD-0003Dt-Ff@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the Integrator/AP 16-bit down-counting clocksource to the
generic clocksource infrastructure.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-integrator/Kconfig         |    1 +
 arch/arm/mach-integrator/integrator_ap.c |   21 +++------------------
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-integrator/Kconfig b/arch/arm/mach-integrator/Kconfig
index d701d32..dfd18f3 100644
--- a/arch/arm/mach-integrator/Kconfig
+++ b/arch/arm/mach-integrator/Kconfig
@@ -4,6 +4,7 @@ menu "Integrator Options"
 
 config ARCH_INTEGRATOR_AP
 	bool "Support Integrator/AP and Integrator/PP2 platforms"
+	select CLKSRC_MMIO
 	select MIGHT_HAVE_PCI
 	help
 	  Include support for the ARM(R) Integrator/AP and
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 980803f..9c61acf 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -343,25 +343,9 @@ static void __init ap_init(void)
 
 static unsigned long timer_reload;
 
-static void __iomem * const clksrc_base = (void __iomem *)TIMER2_VA_BASE;
-
-static cycle_t timersp_read(struct clocksource *cs)
-{
-	return ~(readl(clksrc_base + TIMER_VALUE) & 0xffff);
-}
-
-static struct clocksource clocksource_timersp = {
-	.name		= "timer2",
-	.rating		= 200,
-	.read		= timersp_read,
-	.mask		= CLOCKSOURCE_MASK(16),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
 static void integrator_clocksource_init(u32 khz)
 {
-	struct clocksource *cs = &clocksource_timersp;
-	void __iomem *base = clksrc_base;
+	void __iomem *base = (void __iomem *)TIMER2_VA_BASE;
 	u32 ctrl = TIMER_CTRL_ENABLE;
 
 	if (khz >= 1500) {
@@ -372,7 +356,8 @@ static void integrator_clocksource_init(u32 khz)
 	writel(ctrl, base + TIMER_CTRL);
 	writel(0xffff, base + TIMER_LOAD);
 
-	clocksource_register_khz(cs, khz);
+	clocksource_mmio_init(base + TIMER_VALUE, "timer2",
+		khz * 1000, 200, 16, clocksource_mmio_readl_down);
 }
 
 static void __iomem * const clkevt_base = (void __iomem *)TIMER1_VA_BASE;
-- 
1.7.4.4
