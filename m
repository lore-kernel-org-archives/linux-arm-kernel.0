From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 10 Jul 2015 15:37:03 +0900
Subject: [PATCH 16/16] ARM: shmobile: timer: r8a73a4 and r8a7790 are
 multi-platform only
In-Reply-To: <cover.1436509680.git.horms+renesas@verge.net.au>
References: <cover.1436509680.git.horms+renesas@verge.net.au>
Message-ID: <20834a406ee20b57c796f9911f06600b71c75788.1436509680.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Since commits e042681894b62d60 ("ARM: shmobile: r8a7790: Remove legacy
code") and 9d07d414d4c33d86 ("ARM: shmobile: r8a73a4: ape6evm: Remove
legacy platform"), the R-Mobile APE6 and R-Car H2 SoCs are supported by
multiplatform kernels only.
Hence we can drop checks for these SoCs in legacy kernel builds.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/timer.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
index 0edf2a6d2bbe..f1d027aa7a81 100644
--- a/arch/arm/mach-shmobile/timer.c
+++ b/arch/arm/mach-shmobile/timer.c
@@ -70,18 +70,6 @@ void __init shmobile_init_delay(void)
 	if (!max_freq)
 		return;
 
-#ifdef CONFIG_ARCH_SHMOBILE_LEGACY
-	/* Non-multiplatform r8a73a4 SoC cannot use arch timer due
-	 * to GIC being initialized from C and arch timer via DT */
-	if (of_machine_is_compatible("renesas,r8a73a4"))
-		has_arch_timer = false;
-
-	/* Non-multiplatform r8a7790 SoC cannot use arch timer due
-	 * to GIC being initialized from C and arch timer via DT */
-	if (of_machine_is_compatible("renesas,r8a7790"))
-		has_arch_timer = false;
-#endif
-
 	if (!has_arch_timer || !IS_ENABLED(CONFIG_ARM_ARCH_TIMER)) {
 		if (is_a7_a8_a9)
 			shmobile_setup_delay_hz(max_freq, 1, 3);
-- 
2.1.4
