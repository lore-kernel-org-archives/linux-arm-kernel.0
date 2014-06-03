From: olof@lixom.net (Olof Johansson)
Date: Mon,  2 Jun 2014 21:57:36 -0700
Subject: [PATCH] ARM: exynos: mark machine descriptor functions static
Message-ID: <1401771456-6101-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no reason to export these functions, and I have no idea why
they have over time ended up in the header file. As a result, none of
the checker tools caught it (i.e. sparse was silent on it).

Signed-off-by: Olof Johansson <olof@lixom.net>
---

I'm guessing with all the churn right now this might not apply, so it
might need manual application around -rc1.

There's definitely room for more cleanup in common.h.

 arch/arm/mach-exynos/common.h |    6 ------
 arch/arm/mach-exynos/exynos.c |   10 +++++-----
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 5a3a1ec..0b0b6d5 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -116,13 +116,7 @@ void mct_init(void __iomem *base, int irq_g0, int irq_l0, int irq_l1);
 struct map_desc;
 extern void __iomem *sysram_ns_base_addr;
 extern void __iomem *sysram_base_addr;
-void exynos_init_io(void);
-void exynos_restart(enum reboot_mode mode, const char *cmd);
 void exynos_sysram_init(void);
-void exynos_cpuidle_init(void);
-void exynos_cpufreq_init(void);
-void exynos_init_late(void);
-
 void exynos_firmware_init(void);
 
 #ifdef CONFIG_PINCTRL_EXYNOS
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 9183675..c4f9c3d 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -146,7 +146,7 @@ static struct map_desc exynos5_iodesc[] __initdata = {
 	},
 };
 
-void exynos_restart(enum reboot_mode mode, const char *cmd)
+static void exynos_restart(enum reboot_mode mode, const char *cmd)
 {
 	struct device_node *np;
 	u32 val = 0x1;
@@ -174,7 +174,7 @@ static struct platform_device exynos_cpuidle = {
 	.id                = -1,
 };
 
-void __init exynos_cpuidle_init(void)
+static void __init exynos_cpuidle_init(void)
 {
 	if (soc_is_exynos5440())
 		return;
@@ -182,7 +182,7 @@ void __init exynos_cpuidle_init(void)
 	platform_device_register(&exynos_cpuidle);
 }
 
-void __init exynos_cpufreq_init(void)
+static void __init exynos_cpufreq_init(void)
 {
 	platform_device_register_simple("exynos-cpufreq", -1, NULL, 0);
 }
@@ -209,7 +209,7 @@ void __init exynos_sysram_init(void)
 	}
 }
 
-void __init exynos_init_late(void)
+static void __init exynos_init_late(void)
 {
 	if (of_machine_is_compatible("samsung,exynos5440"))
 		/* to be supported later */
@@ -256,7 +256,7 @@ static void __init exynos_map_io(void)
 		iotable_init(exynos5_iodesc, ARRAY_SIZE(exynos5_iodesc));
 }
 
-void __init exynos_init_io(void)
+static void __init exynos_init_io(void)
 {
 	debug_ll_io_init();
 
-- 
1.7.10.4
