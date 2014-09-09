From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  9 Sep 2014 13:22:17 +0900
Subject: [PATCH 1/2] ARM: shmobile: support Cortex-A7 in shmobile_init_delay()
In-Reply-To: <cover.1410235571.git.horms+renesas@verge.net.au>
References: <cover.1410235571.git.horms+renesas@verge.net.au>
Message-ID: <0dc50fd3dc4a70d0d317103188c129d378125643.1410235571.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/timer.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
index 942efdc..0b01770 100644
--- a/arch/arm/mach-shmobile/timer.c
+++ b/arch/arm/mach-shmobile/timer.c
@@ -60,7 +60,7 @@ void __init shmobile_setup_delay(unsigned int max_cpu_core_mhz,
 void __init shmobile_init_delay(void)
 {
 	struct device_node *np, *cpus;
-	bool is_a8_a9 = false;
+	bool is_a7_a8_a9 = false;
 	bool is_a15 = false;
 	u32 max_freq = 0;
 
@@ -74,9 +74,10 @@ void __init shmobile_init_delay(void)
 		if (!of_property_read_u32(np, "clock-frequency", &freq))
 			max_freq = max(max_freq, freq);
 
-		if (of_device_is_compatible(np, "arm,cortex-a8") ||
+		if (of_device_is_compatible(np, "arm,cortex-a7") ||
+		    of_device_is_compatible(np, "arm,cortex-a8") ||
 		    of_device_is_compatible(np, "arm,cortex-a9"))
-			is_a8_a9 = true;
+			is_a7_a8_a9 = true;
 		else if (of_device_is_compatible(np, "arm,cortex-a15"))
 			is_a15 = true;
 	}
@@ -86,7 +87,7 @@ void __init shmobile_init_delay(void)
 	if (!max_freq)
 		return;
 
-	if (is_a8_a9)
+	if (is_a7_a8_a9)
 		shmobile_setup_delay_hz(max_freq, 1, 3);
 	else if (is_a15 && !IS_ENABLED(CONFIG_ARM_ARCH_TIMER))
 		shmobile_setup_delay_hz(max_freq, 2, 4);
-- 
2.0.1
