From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 09:58:50 +0900
Subject: [PATCH 9/9] ARM: shmobile: Set clock frequency in HZ from OF nodes
In-Reply-To: <cover.1400200838.git.horms+renesas@verge.net.au>
References: <cover.1400200838.git.horms+renesas@verge.net.au>
Message-ID: <f492b81777c93b33afe892b424e022022b5bc297.1400200838.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

shmobile_init_delay() looks for OF "clock-frequency" to determine
the delay which is set by calling shmobile_setup_delay().

Unfortunately this seems to be incorrect in detail as
"clock-frequency" node values are in HZ whereas the frequency
argument to shmobile_setup_delay() is in MHz.

Provide a variant of shmobile_setup_delay() that accepts HZ to
correct this problem.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/timer.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
index ccecde9..68bc0b8 100644
--- a/arch/arm/mach-shmobile/timer.c
+++ b/arch/arm/mach-shmobile/timer.c
@@ -23,6 +23,23 @@
 #include <linux/delay.h>
 #include <linux/of_address.h>
 
+void __init shmobile_setup_delay_hz(unsigned int max_cpu_core_hz,
+				    unsigned int mult, unsigned int div)
+{
+	/* calculate a worst-case loops-per-jiffy value
+	 * based on maximum cpu core hz setting and the
+	 * __delay() implementation in arch/arm/lib/delay.S
+	 *
+	 * this will result in a longer delay than expected
+	 * when the cpu core runs on lower frequencies.
+	 */
+
+	unsigned int value = HZ * div / mult;
+
+	if (!preset_lpj)
+		preset_lpj = max_cpu_core_hz / value;
+}
+
 void __init shmobile_setup_delay(unsigned int max_cpu_core_mhz,
 				 unsigned int mult, unsigned int div)
 {
@@ -58,12 +75,12 @@ void __init shmobile_init_delay(void)
 
 	if (max_freq) {
 		if (of_find_compatible_node(NULL, NULL, "arm,cortex-a8"))
-			shmobile_setup_delay(max_freq, 1, 3);
+			shmobile_setup_delay_hz(max_freq, 1, 3);
 		else if (of_find_compatible_node(NULL, NULL, "arm,cortex-a9"))
-			shmobile_setup_delay(max_freq, 1, 3);
+			shmobile_setup_delay_hz(max_freq, 1, 3);
 		else if (of_find_compatible_node(NULL, NULL, "arm,cortex-a15"))
 			if (!IS_ENABLED(CONFIG_ARM_ARCH_TIMER))
-				shmobile_setup_delay(max_freq, 2, 4);
+				shmobile_setup_delay_hz(max_freq, 2, 4);
 	}
 }
 
-- 
1.8.5.2
