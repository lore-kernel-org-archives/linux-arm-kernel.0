From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 17 Jun 2015 11:34:21 +0200
Subject: [PATCH 2/2] ARM: shmobile: timer: r8a73a4 and r8a7790 are
 multi-platform only
In-Reply-To: <1434533661-22730-1-git-send-email-geert+renesas@glider.be>
References: <1434533661-22730-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1434533661-22730-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commits e042681894b62d60 ("ARM: shmobile: r8a7790: Remove legacy
code") and 9d07d414d4c33d86 ("ARM: shmobile: r8a73a4: ape6evm: Remove
legacy platform"), the R-Mobile APE6 and R-Car H2 SoCs are supported by
multiplatform kernels only.
Hence we can drop checks for these SoCs in legacy kernel builds.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/timer.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
index 0edf2a6d2bbef7f7..f1d027aa7a81ac33 100644
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
1.9.1
