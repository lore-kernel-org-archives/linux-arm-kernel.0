From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:22:57 +0900
Subject: [PATCH 1/2] ARM: shmobile: timer: Fix preset_lpj leading to too short
 delays
In-Reply-To: <cover.1459732456.git.horms+renesas@verge.net.au>
References: <cover.1459732456.git.horms+renesas@verge.net.au>
Message-ID: <dadb875efc805fc4c1834129f01d9ca252d10ad7.1459732456.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

On all shmobile ARM SoCs, loop-based delays may complete early, which
can be after only 1/3 (Cortex A9) or 1/2 (Cortex A7 or A15) of the
minimum required time.

This is caused by calculating preset_lpj based on incorrect assumptions
about the number of clock cycles per loop:
  - All of Cortex A7, A9, and A15 run __loop_delay() at 1 loop per
    CPU clock cycle,
  - As of commit 11d4bb1bd067f9d0 ("ARM: 7907/1: lib: delay-loop: Add
    align directive to fix BogoMIPS calculation"), Cortex A8 runs
    __loop_delay() at 1 loop per 2 instead of 3 CPU clock cycles.

On SoCs with Cortex A7 and/or A15 CPU cores, this went unnoticed, as
delays use the ARM arch timer if available. R-Car Gen2 doesn't work if
the arch timer is disabled. However, APE6 can be used without the arch
timer.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/timer.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
index ad008e4b0c49..67d79f9c6bad 100644
--- a/arch/arm/mach-shmobile/timer.c
+++ b/arch/arm/mach-shmobile/timer.c
@@ -40,8 +40,7 @@ static void __init shmobile_setup_delay_hz(unsigned int max_cpu_core_hz,
 void __init shmobile_init_delay(void)
 {
 	struct device_node *np, *cpus;
-	bool is_a7_a8_a9 = false;
-	bool is_a15 = false;
+	unsigned int div = 0;
 	bool has_arch_timer = false;
 	u32 max_freq = 0;
 
@@ -55,27 +54,22 @@ void __init shmobile_init_delay(void)
 		if (!of_property_read_u32(np, "clock-frequency", &freq))
 			max_freq = max(max_freq, freq);
 
-		if (of_device_is_compatible(np, "arm,cortex-a8") ||
-		    of_device_is_compatible(np, "arm,cortex-a9")) {
-			is_a7_a8_a9 = true;
-		} else if (of_device_is_compatible(np, "arm,cortex-a7")) {
-			is_a7_a8_a9 = true;
-			has_arch_timer = true;
-		} else if (of_device_is_compatible(np, "arm,cortex-a15")) {
-			is_a15 = true;
+		if (of_device_is_compatible(np, "arm,cortex-a8")) {
+			div = 2;
+		} else if (of_device_is_compatible(np, "arm,cortex-a9")) {
+			div = 1;
+		} else if (of_device_is_compatible(np, "arm,cortex-a7") ||
+			 of_device_is_compatible(np, "arm,cortex-a15")) {
+			div = 1;
 			has_arch_timer = true;
 		}
 	}
 
 	of_node_put(cpus);
 
-	if (!max_freq)
+	if (!max_freq || !div)
 		return;
 
-	if (!has_arch_timer || !IS_ENABLED(CONFIG_ARM_ARCH_TIMER)) {
-		if (is_a7_a8_a9)
-			shmobile_setup_delay_hz(max_freq, 1, 3);
-		else if (is_a15)
-			shmobile_setup_delay_hz(max_freq, 2, 4);
-	}
+	if (!has_arch_timer || !IS_ENABLED(CONFIG_ARM_ARCH_TIMER))
+		shmobile_setup_delay_hz(max_freq, 1, div);
 }
-- 
2.1.4
