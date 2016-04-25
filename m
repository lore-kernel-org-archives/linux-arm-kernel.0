From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Apr 2016 14:08:17 +1000
Subject: [PATCH] ARM: shmobile: timer: Drop support for Cortex A8
In-Reply-To: <cover.1461542941.git.horms+renesas@verge.net.au>
References: <cover.1461542941.git.horms+renesas@verge.net.au>
Message-ID: <a4b8c18c40704c28be62af4606cc6758c9ff3dba.1461542941.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Commit edf4100906044225 ("ARM: shmobile: sh7372 dtsi: Remove Legacy
file") removed the DTS for the last shmobile SoC with a Cortex A8 CPU
core (sh7372 aka SH-Mobile AP4), hence drop support for it in the
loops-per-jiffy preset code.

As "div" is always 1 for supported contemporary ARM processors, we can
simplify the code:
  - Absorb shmobile_setup_delay_hz(), which was always called with
    mult = div = 1,
  - Return earlier if the Cortex A7/A15 arch timer exists and support is
    enabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/timer.c | 52 ++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
index 67d79f9c6bad..6196a6380385 100644
--- a/arch/arm/mach-shmobile/timer.c
+++ b/arch/arm/mach-shmobile/timer.c
@@ -20,28 +20,9 @@
 
 #include "common.h"
 
-static void __init shmobile_setup_delay_hz(unsigned int max_cpu_core_hz,
-					   unsigned int mult, unsigned int div)
-{
-	/* calculate a worst-case loops-per-jiffy value
-	 * based on maximum cpu core hz setting and the
-	 * __delay() implementation in arch/arm/lib/delay.S
-	 *
-	 * this will result in a longer delay than expected
-	 * when the cpu core runs on lower frequencies.
-	 */
-
-	unsigned int value = HZ * div / mult;
-
-	if (!preset_lpj)
-		preset_lpj = max_cpu_core_hz / value;
-}
-
 void __init shmobile_init_delay(void)
 {
 	struct device_node *np, *cpus;
-	unsigned int div = 0;
-	bool has_arch_timer = false;
 	u32 max_freq = 0;
 
 	cpus = of_find_node_by_path("/cpus");
@@ -51,25 +32,32 @@ void __init shmobile_init_delay(void)
 	for_each_child_of_node(cpus, np) {
 		u32 freq;
 
+		if (IS_ENABLED(CONFIG_ARM_ARCH_TIMER) &&
+		    (of_device_is_compatible(np, "arm,cortex-a7") ||
+		     of_device_is_compatible(np, "arm,cortex-a15"))) {
+			of_node_put(np);
+			of_node_put(cpus);
+			return;
+		}
+
 		if (!of_property_read_u32(np, "clock-frequency", &freq))
 			max_freq = max(max_freq, freq);
-
-		if (of_device_is_compatible(np, "arm,cortex-a8")) {
-			div = 2;
-		} else if (of_device_is_compatible(np, "arm,cortex-a9")) {
-			div = 1;
-		} else if (of_device_is_compatible(np, "arm,cortex-a7") ||
-			 of_device_is_compatible(np, "arm,cortex-a15")) {
-			div = 1;
-			has_arch_timer = true;
-		}
 	}
 
 	of_node_put(cpus);
 
-	if (!max_freq || !div)
+	if (!max_freq)
 		return;
 
-	if (!has_arch_timer || !IS_ENABLED(CONFIG_ARM_ARCH_TIMER))
-		shmobile_setup_delay_hz(max_freq, 1, div);
+	/*
+	 * Calculate a worst-case loops-per-jiffy value
+	 * based on maximum cpu core hz setting and the
+	 * __delay() implementation in arch/arm/lib/delay.S.
+	 *
+	 * This will result in a longer delay than expected
+	 * when the cpu core runs on lower frequencies.
+	 */
+
+	if (!preset_lpj)
+		preset_lpj = max_freq / HZ;
 }
-- 
2.7.0.rc3.207.g0ac5344
