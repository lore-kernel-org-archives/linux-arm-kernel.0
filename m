From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  7 Jun 2013 16:51:54 +0900
Subject: [PATCH 24/27] ARM: shmobile: sh73a0: add CPUFreq support
In-Reply-To: <1370591517-20239-1-git-send-email-horms+renesas@verge.net.au>
References: <1370591517-20239-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370591517-20239-25-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

This patch enables the use of the generic cpufreq-cpu0 driver on sh73a0.
Providing a regulator, a list of OPPs in DT, combined with a virtual
cpufreq-cpu0 platform device and a clock, attached to it is everything,
the cpufreq-cpu0 driver needs. The first sh73a0 platform, implementing
such CPUFreq support is kzm9g-reference.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig        | 2 ++
 arch/arm/mach-shmobile/setup-sh73a0.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 52e8c6e..f871f2a 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -169,6 +169,8 @@ config MACH_KZM9D
 config MACH_KZM9G
 	bool "KZM-A9-GT board"
 	depends on ARCH_SH73A0
+	select ARCH_HAS_CPUFREQ
+	select ARCH_HAS_OPP
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	select SND_SOC_AK4642 if SND_SIMPLE_CARD
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 3bc33a5..3acb45a 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -963,6 +963,8 @@ static const struct of_dev_auxdata sh73a0_auxdata_lookup[] __initconst = {
 
 void __init sh73a0_add_standard_devices_dt(void)
 {
+	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", .id = -1, };
+
 	/* clocks are setup late during boot in the case of DT */
 	sh73a0_clock_init();
 
@@ -970,6 +972,9 @@ void __init sh73a0_add_standard_devices_dt(void)
 			     ARRAY_SIZE(sh73a0_devices_dt));
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     sh73a0_auxdata_lookup, NULL);
+
+	/* Instantiate cpufreq-cpu0 */
+	platform_device_register_full(&devinfo);
 }
 
 static const char *sh73a0_boards_compat_dt[] __initdata = {
-- 
1.8.2.1
