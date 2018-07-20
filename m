From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Jul 2018 14:05:36 +0200
Subject: [PATCH 5/5] ARM: shmobile: Always enable ARCH_TIMER on SoCs with A7
 and/or A15
In-Reply-To: <cover.1532087129.git.horms+renesas@verge.net.au>
References: <cover.1532087129.git.horms+renesas@verge.net.au>
Message-ID: <54f464e0c91f10212fa5699bfef1f104ee7d2213.1532087129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

R-Mobile APE6, R-Car Gen2, and RZ/G1 SoCs have Cortex-A7 and/or
Cortex-A15 CPU cores, all of which have ARM architectured timers.

Force use of the ARM architectured timer on these SoCs.
This allows to:
  - Remove the calls to shmobile_init_delay() from the corresponding
    machine vectors,
  - Remove a check in timer setup specific to R-Car Gen2,
  - Remove a check in shmobile_init_delay().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig           | 2 ++
 arch/arm/mach-shmobile/setup-r8a73a4.c   | 1 -
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 4 ----
 arch/arm/mach-shmobile/timer.c           | 8 --------
 4 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 0b67254eabb2..aeb2eed08598 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -15,6 +15,7 @@ config ARCH_RCAR_GEN1
 
 config ARCH_RCAR_GEN2
 	bool
+	select HAVE_ARM_ARCH_TIMER
 	select PM
 	select PM_GENERIC_DOMAINS
 	select RENESAS_IRQC
@@ -58,6 +59,7 @@ config ARCH_R8A73A4
 	bool "R-Mobile APE6 (R8A73A40)"
 	select ARCH_RMOBILE
 	select ARM_ERRATA_798181 if SMP
+	select HAVE_ARM_ARCH_TIMER
 	select RENESAS_IRQC
 
 config ARCH_R8A7740
diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index ef391fa368e9..23a29a0ea9c9 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -18,7 +18,6 @@ static const char *const r8a73a4_boards_compat_dt[] __initconst = {
 };
 
 DT_MACHINE_START(R8A73A4_DT, "Generic R8A73A4 (Flattened Device Tree)")
-	.init_early	= shmobile_init_delay,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= r8a73a4_boards_compat_dt,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 117531367f17..013acc97795c 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -59,7 +59,6 @@ static unsigned int __init get_extal_freq(void)
 
 void __init rcar_gen2_timer_init(void)
 {
-#ifdef CONFIG_ARM_ARCH_TIMER
 	void __iomem *base;
 	u32 freq;
 
@@ -101,7 +100,6 @@ void __init rcar_gen2_timer_init(void)
 	}
 
 	iounmap(base);
-#endif /* CONFIG_ARM_ARCH_TIMER */
 
 	of_clk_init(NULL);
 	timer_probe();
@@ -187,7 +185,6 @@ static const char * const rcar_gen2_boards_compat_dt[] __initconst = {
 };
 
 DT_MACHINE_START(RCAR_GEN2_DT, "Generic R-Car Gen2 (Flattened Device Tree)")
-	.init_early	= shmobile_init_delay,
 	.init_late	= shmobile_init_late,
 	.init_time	= rcar_gen2_timer_init,
 	.reserve	= rcar_gen2_reserve,
@@ -202,7 +199,6 @@ static const char * const rz_g1_boards_compat_dt[] __initconst = {
 };
 
 DT_MACHINE_START(RZ_G1_DT, "Generic RZ/G1 (Flattened Device Tree)")
-	.init_early	= shmobile_init_delay,
 	.init_late	= shmobile_init_late,
 	.init_time	= rcar_gen2_timer_init,
 	.reserve	= rcar_gen2_reserve,
diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
index 6196a6380385..828e8aea037e 100644
--- a/arch/arm/mach-shmobile/timer.c
+++ b/arch/arm/mach-shmobile/timer.c
@@ -32,14 +32,6 @@ void __init shmobile_init_delay(void)
 	for_each_child_of_node(cpus, np) {
 		u32 freq;
 
-		if (IS_ENABLED(CONFIG_ARM_ARCH_TIMER) &&
-		    (of_device_is_compatible(np, "arm,cortex-a7") ||
-		     of_device_is_compatible(np, "arm,cortex-a15"))) {
-			of_node_put(np);
-			of_node_put(cpus);
-			return;
-		}
-
 		if (!of_property_read_u32(np, "clock-frequency", &freq))
 			max_freq = max(max_freq, freq);
 	}
-- 
2.11.0
