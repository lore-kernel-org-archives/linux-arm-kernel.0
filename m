From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Aug 2014 10:10:11 +0900
Subject: [PATCH 06/10] ARM: shmobile: Remove shmobile_setup_delay()
In-Reply-To: <cover.1408927601.git.horms+renesas@verge.net.au>
References: <cover.1408927601.git.horms+renesas@verge.net.au>
Message-ID: <7dd4cfd7f8c2976a8d65022146386480474501ca.1408927601.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

All ARM mach-shmobile SoCs and boards now rely on DTS for
CPU Frequency information, so remove the unused function
shmobile_setup_delay(). While at it, make the function
shmobile_setup_delay_hz() static.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/common.h |  2 --
 arch/arm/mach-shmobile/timer.c  | 21 ++-------------------
 2 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index 9805608..72087c7 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -2,8 +2,6 @@
 #define __ARCH_MACH_COMMON_H
 
 extern void shmobile_earlytimer_init(void);
-extern void shmobile_setup_delay(unsigned int max_cpu_core_mhz,
-			 unsigned int mult, unsigned int div);
 extern void shmobile_init_delay(void);
 struct twd_local_timer;
 extern void shmobile_setup_console(void);
diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
index 942efdc..adce98b 100644
--- a/arch/arm/mach-shmobile/timer.c
+++ b/arch/arm/mach-shmobile/timer.c
@@ -23,8 +23,8 @@
 #include <linux/delay.h>
 #include <linux/of_address.h>
 
-void __init shmobile_setup_delay_hz(unsigned int max_cpu_core_hz,
-				    unsigned int mult, unsigned int div)
+static void __init shmobile_setup_delay_hz(unsigned int max_cpu_core_hz,
+					   unsigned int mult, unsigned int div)
 {
 	/* calculate a worst-case loops-per-jiffy value
 	 * based on maximum cpu core hz setting and the
@@ -40,23 +40,6 @@ void __init shmobile_setup_delay_hz(unsigned int max_cpu_core_hz,
 		preset_lpj = max_cpu_core_hz / value;
 }
 
-void __init shmobile_setup_delay(unsigned int max_cpu_core_mhz,
-				 unsigned int mult, unsigned int div)
-{
-	/* calculate a worst-case loops-per-jiffy value
-	 * based on maximum cpu core mhz setting and the
-	 * __delay() implementation in arch/arm/lib/delay.S
-	 *
-	 * this will result in a longer delay than expected
-	 * when the cpu core runs on lower frequencies.
-	 */
-
-	unsigned int value = (1000000 * mult) / (HZ * div);
-
-	if (!preset_lpj)
-		preset_lpj = max_cpu_core_mhz * value;
-}
-
 void __init shmobile_init_delay(void)
 {
 	struct device_node *np, *cpus;
-- 
2.0.1
