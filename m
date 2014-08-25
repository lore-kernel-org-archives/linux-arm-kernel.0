From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Aug 2014 10:10:10 +0900
Subject: [PATCH 05/10] ARM: shmobile: r8a73a4: Use shmobile_init_delay()
In-Reply-To: <cover.1408927601.git.horms+renesas@verge.net.au>
References: <cover.1408927601.git.horms+renesas@verge.net.au>
Message-ID: <f5720080b51d61c33dc559fedab9a601930e95c1.1408927601.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Adjust the r8a73a4 SoC support code to use shmobile_init_delay()
together with CPU Frequency settings from the DTS. Get rid of the
C code version and r8a73a4_init_early() that now are unused.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/r8a73a4.h       | 1 -
 arch/arm/mach-shmobile/setup-r8a73a4.c | 9 +--------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm/mach-shmobile/r8a73a4.h b/arch/arm/mach-shmobile/r8a73a4.h
index ce8bdd1..5fafd6f 100644
--- a/arch/arm/mach-shmobile/r8a73a4.h
+++ b/arch/arm/mach-shmobile/r8a73a4.h
@@ -14,6 +14,5 @@ void r8a73a4_add_standard_devices(void);
 void r8a73a4_add_dt_devices(void);
 void r8a73a4_clock_init(void);
 void r8a73a4_pinmux_init(void);
-void r8a73a4_init_early(void);
 
 #endif /* __ASM_R8A73A4_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index 6fbcdcc..53f40b7 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -295,13 +295,6 @@ void __init r8a73a4_add_standard_devices(void)
 	r8a73a4_register_dmac();
 }
 
-void __init r8a73a4_init_early(void)
-{
-#ifndef CONFIG_ARM_ARCH_TIMER
-	shmobile_setup_delay(1500, 2, 4); /* Cortex-A15 @ 1500MHz */
-#endif
-}
-
 #ifdef CONFIG_USE_OF
 
 static const char *r8a73a4_boards_compat_dt[] __initdata = {
@@ -310,7 +303,7 @@ static const char *r8a73a4_boards_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(R8A73A4_DT, "Generic R8A73A4 (Flattened Device Tree)")
-	.init_early	= r8a73a4_init_early,
+	.init_early	= shmobile_init_delay,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= r8a73a4_boards_compat_dt,
 MACHINE_END
-- 
2.0.1
