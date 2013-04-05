From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri,  5 Apr 2013 12:00:38 +0200
Subject: [PATCH v5 3/3] ARM: shmobile: sh73a0: add CPUFreq support
In-Reply-To: <1365156038-12467-1-git-send-email-g.liakhovetski@gmx.de>
References: <1365156038-12467-1-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <1365156038-12467-4-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the use of the generic cpufreq-cpu0 driver on sh73a0.
Providing a regulator, a list of OPPs in DT, combined with a virtual
cpufreq-cpu0 platform device and a clock, attached to it is everything,
the cpufreq-cpu0 driver needs. The first sh73a0 platform, implementing
such CPUFreq support is kzm9g-reference.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

v5: remove sh73a0-kzm9g-reference.dts hunk, it's now merged into patch 2/3

 arch/arm/mach-shmobile/Kconfig        |    2 ++
 arch/arm/mach-shmobile/setup-sh73a0.c |    5 +++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 1a517e2..4ac5bf9 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -177,6 +177,8 @@ config MACH_KZM9G
 config MACH_KZM9G_REFERENCE
 	bool "KZM-A9-GT board - Reference Device Tree Implementation"
 	depends on ARCH_SH73A0
+	select ARCH_HAS_CPUFREQ
+	select ARCH_HAS_OPP
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	select SND_SOC_AK4642 if SND_SIMPLE_CARD
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index d10ded0..9a522f9 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -1003,6 +1003,8 @@ static const struct of_dev_auxdata sh73a0_auxdata_lookup[] __initconst = {
 
 void __init sh73a0_add_standard_devices_dt(void)
 {
+	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", .id = -1, };
+
 	/* clocks are setup late during boot in the case of DT */
 	sh73a0_clock_init();
 
@@ -1010,6 +1012,9 @@ void __init sh73a0_add_standard_devices_dt(void)
 			     ARRAY_SIZE(sh73a0_devices_dt));
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     sh73a0_auxdata_lookup, NULL);
+
+	/* Instantiate cpufreq-cpu0 */
+	platform_device_register_full(&devinfo);
 }
 
 static const char *sh73a0_boards_compat_dt[] __initdata = {
-- 
1.7.2.5
