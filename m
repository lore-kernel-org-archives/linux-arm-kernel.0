From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed,  2 Jan 2013 22:55:17 -0700
Subject: [PATCH 2/6] ARM: bcm2835: add a pm_power_off implementation
In-Reply-To: <1357192521-13025-1-git-send-email-swarren@wwwdotorg.org>
References: <1357192521-13025-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1357192521-13025-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dom Cobley <popcornmix@gmail.com>

Add a pm_power_off function that resets the SoC, and indicates to
bootcode.bin not to boot. Should allow a lower power 'off' state, even
if it's not really off.

This is commit 48efdd2 "Add a pm_power_off function that resets us, ..."
downstream.

Signed-off-by: Dom Cobley <popcornmix@gmail.com>
[swarren: Various non-semantic rework for upstreaming]
Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
 arch/arm/mach-bcm2835/bcm2835.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/mach-bcm2835/bcm2835.c b/arch/arm/mach-bcm2835/bcm2835.c
index f0d739f..c867d0e 100644
--- a/arch/arm/mach-bcm2835/bcm2835.c
+++ b/arch/arm/mach-bcm2835/bcm2835.c
@@ -26,11 +26,13 @@
 #include <mach/bcm2835_soc.h>
 
 #define PM_RSTC				0x1c
+#define PM_RSTS				0x20
 #define PM_WDOG				0x24
 
 #define PM_PASSWORD			0x5a000000
 #define PM_RSTC_WRCFG_MASK		0x00000030
 #define PM_RSTC_WRCFG_FULL_RESET	0x00000020
+#define PM_RSTS_HADWRH_SET		0x00000040
 
 static void __iomem *wdt_regs;
 
@@ -67,6 +69,29 @@ static void bcm2835_restart(char mode, const char *cmd)
 	mdelay(1);
 }
 
+/*
+ * We can't really power off, but if we do the normal reset scheme, and
+ * indicate to bootcode.bin not to reboot, then most of the chip will be
+ * powered off.
+ */
+static void bcm2835_power_off(void)
+{
+	u32 val;
+
+	/*
+	 * We set the watchdog hard reset bit here to distinguish this reset
+	 * from the normal (full) reset. bootcode.bin will not reboot after a
+	 * hard reset.
+	 */
+	val = readl_relaxed(wdt_regs + PM_RSTS);
+	val &= ~PM_RSTC_WRCFG_MASK;
+	val |= PM_PASSWORD | PM_RSTS_HADWRH_SET;
+	writel_relaxed(val, wdt_regs + PM_RSTS);
+
+	/* Continue with normal reset mechanism */
+	bcm2835_restart(0, "");
+}
+
 static struct map_desc io_map __initdata = {
 	.virtual = BCM2835_PERIPH_VIRT,
 	.pfn = __phys_to_pfn(BCM2835_PERIPH_PHYS),
@@ -84,6 +109,9 @@ static void __init bcm2835_init(void)
 	int ret;
 
 	bcm2835_setup_restart();
+	if (wdt_regs)
+		pm_power_off = bcm2835_power_off;
+
 	bcm2835_init_clocks();
 
 	ret = of_platform_populate(NULL, of_default_bus_match_table, NULL,
-- 
1.7.10.4
