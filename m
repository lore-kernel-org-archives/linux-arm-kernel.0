From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:50:06 +0900
Subject: [PATCH 1/4] ARM: shmobile: Handle CA7 arch timer delay
In-Reply-To: <cover.1415058939.git.horms+renesas@verge.net.au>
References: <cover.1415058939.git.horms+renesas@verge.net.au>
Message-ID: <27f3c70874fc1d114e26c807e900fec4b50b1217.1415058939.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Update the delay code to include arch timer checks
for CA7. From a arch timer availability perspective
CA7 should be treated same as CA15.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/timer.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
index 87c6be1..32ee335 100644
--- a/arch/arm/mach-shmobile/timer.c
+++ b/arch/arm/mach-shmobile/timer.c
@@ -45,6 +45,7 @@ void __init shmobile_init_delay(void)
 	struct device_node *np, *cpus;
 	bool is_a7_a8_a9 = false;
 	bool is_a15 = false;
+	bool has_arch_timer = false;
 	u32 max_freq = 0;
 
 	cpus = of_find_node_by_path("/cpus");
@@ -57,12 +58,16 @@ void __init shmobile_init_delay(void)
 		if (!of_property_read_u32(np, "clock-frequency", &freq))
 			max_freq = max(max_freq, freq);
 
-		if (of_device_is_compatible(np, "arm,cortex-a7") ||
-		    of_device_is_compatible(np, "arm,cortex-a8") ||
-		    of_device_is_compatible(np, "arm,cortex-a9"))
+		if (of_device_is_compatible(np, "arm,cortex-a8") ||
+		    of_device_is_compatible(np, "arm,cortex-a9")) {
 			is_a7_a8_a9 = true;
-		else if (of_device_is_compatible(np, "arm,cortex-a15"))
+		} else if (of_device_is_compatible(np, "arm,cortex-a7")) {
+			is_a7_a8_a9 = true;
+			has_arch_timer = true;
+		} else if (of_device_is_compatible(np, "arm,cortex-a15")) {
 			is_a15 = true;
+			has_arch_timer = true;
+		}
 	}
 
 	of_node_put(cpus);
@@ -70,10 +75,12 @@ void __init shmobile_init_delay(void)
 	if (!max_freq)
 		return;
 
-	if (is_a7_a8_a9)
-		shmobile_setup_delay_hz(max_freq, 1, 3);
-	else if (is_a15 && !IS_ENABLED(CONFIG_ARM_ARCH_TIMER))
-		shmobile_setup_delay_hz(max_freq, 2, 4);
+	if (!has_arch_timer || !IS_ENABLED(CONFIG_ARM_ARCH_TIMER)) {
+		if (is_a7_a8_a9)
+			shmobile_setup_delay_hz(max_freq, 1, 3);
+		else if (is_a15)
+			shmobile_setup_delay_hz(max_freq, 2, 4);
+	}
 }
 
 static void __init shmobile_late_time_init(void)
-- 
2.1.1
