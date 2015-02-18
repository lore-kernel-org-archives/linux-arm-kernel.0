From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 18 Feb 2015 21:01:45 +0100
Subject: [PATCH] ARM: make arrays containing machine compatible strings const
Message-ID: <1424289705-11786-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The definition

	static const char *axxia_dt_match[] __initconst = {
		...

defines a changable array of constant strings. That is you must not do:

	*axxia_dt_match[0] = 'k';

but

	axxia_dt_match[0] = "different string";

is fine. So the annotation __initconst is wrong and yields a compiler
error when other really const variables are added with __initconst.

As the struct machine_desc member dt_compat is declared as

	const char *const *dt_compat;

making the arrays const is the better alternative over changing all
annotations to __initdata.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-axxia/axxia.c            | 2 +-
 arch/arm/mach-bcm/brcmstb.c            | 2 +-
 arch/arm/mach-exynos/exynos.c          | 2 +-
 arch/arm/mach-highbank/highbank.c      | 2 +-
 arch/arm/mach-hisi/hisilicon.c         | 6 +++---
 arch/arm/mach-keystone/keystone.c      | 2 +-
 arch/arm/mach-nspire/nspire.c          | 2 +-
 arch/arm/mach-prima2/common.c          | 6 +++---
 arch/arm/mach-s5pv210/s5pv210.c        | 2 +-
 arch/arm/mach-shmobile/setup-emev2.c   | 2 +-
 arch/arm/mach-versatile/versatile_dt.c | 2 +-
 11 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-axxia/axxia.c b/arch/arm/mach-axxia/axxia.c
index 19e5a1d95397..4db76a493c5a 100644
--- a/arch/arm/mach-axxia/axxia.c
+++ b/arch/arm/mach-axxia/axxia.c
@@ -16,7 +16,7 @@
 #include <linux/init.h>
 #include <asm/mach/arch.h>
 
-static const char *axxia_dt_match[] __initconst = {
+static const char *const axxia_dt_match[] __initconst = {
 	"lsi,axm5516",
 	"lsi,axm5516-sim",
 	"lsi,axm5516-emu",
diff --git a/arch/arm/mach-bcm/brcmstb.c b/arch/arm/mach-bcm/brcmstb.c
index 60a5afa06ed7..3a60f7ee3f0c 100644
--- a/arch/arm/mach-bcm/brcmstb.c
+++ b/arch/arm/mach-bcm/brcmstb.c
@@ -17,7 +17,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-static const char *brcmstb_match[] __initconst = {
+static const char *const brcmstb_match[] __initconst = {
 	"brcm,bcm7445",
 	"brcm,brcmstb",
 	NULL
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 2013f73797ed..9e9dfdfad9d7 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -227,7 +227,7 @@ static void __init exynos_dt_machine_init(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-static char const *exynos_dt_compat[] __initconst = {
+static char const *const exynos_dt_compat[] __initconst = {
 	"samsung,exynos3",
 	"samsung,exynos3250",
 	"samsung,exynos4",
diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 07a09570175d..231fba0d03e5 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -169,7 +169,7 @@ static void __init highbank_init(void)
 		platform_device_register(&highbank_cpuidle_device);
 }
 
-static const char *highbank_match[] __initconst = {
+static const char *const highbank_match[] __initconst = {
 	"calxeda,highbank",
 	"calxeda,ecx-2000",
 	NULL,
diff --git a/arch/arm/mach-hisi/hisilicon.c b/arch/arm/mach-hisi/hisilicon.c
index 76b907078b58..8ac8f3990252 100644
--- a/arch/arm/mach-hisi/hisilicon.c
+++ b/arch/arm/mach-hisi/hisilicon.c
@@ -45,7 +45,7 @@ static void __init hi3620_map_io(void)
 	iotable_init(hi3620_io_desc, ARRAY_SIZE(hi3620_io_desc));
 }
 
-static const char *hi3xxx_compat[] __initconst = {
+static const char *const hi3xxx_compat[] __initconst = {
 	"hisilicon,hi3620-hi4511",
 	NULL,
 };
@@ -55,7 +55,7 @@ DT_MACHINE_START(HI3620, "Hisilicon Hi3620 (Flattened Device Tree)")
 	.dt_compat	= hi3xxx_compat,
 MACHINE_END
 
-static const char *hix5hd2_compat[] __initconst = {
+static const char *const hix5hd2_compat[] __initconst = {
 	"hisilicon,hix5hd2",
 	NULL,
 };
@@ -73,7 +73,7 @@ DT_MACHINE_START(HIP04, "Hisilicon HiP04 (Flattened Device Tree)")
 	.dt_compat	= hip04_compat,
 MACHINE_END
 
-static const char *hip01_compat[] __initconst = {
+static const char *const hip01_compat[] __initconst = {
 	"hisilicon,hip01",
 	"hisilicon,hip01-ca9x2",
 	NULL,
diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index 7f352de26099..06620875813a 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -103,7 +103,7 @@ static void __init keystone_init_meminfo(void)
 	pr_info("Switching to high address space at 0x%llx\n", (u64)offset);
 }
 
-static const char *keystone_match[] __initconst = {
+static const char *const keystone_match[] __initconst = {
 	"ti,keystone",
 	NULL,
 };
diff --git a/arch/arm/mach-nspire/nspire.c b/arch/arm/mach-nspire/nspire.c
index 3d24ebf12095..3445a5686805 100644
--- a/arch/arm/mach-nspire/nspire.c
+++ b/arch/arm/mach-nspire/nspire.c
@@ -27,7 +27,7 @@
 #include "mmio.h"
 #include "clcd.h"
 
-static const char *nspire_dt_match[] __initconst = {
+static const char *const nspire_dt_match[] __initconst = {
 	"ti,nspire",
 	"ti,nspire-cx",
 	"ti,nspire-tp",
diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
index 0c819bb88418..8cadb302a7d2 100644
--- a/arch/arm/mach-prima2/common.c
+++ b/arch/arm/mach-prima2/common.c
@@ -21,7 +21,7 @@ static void __init sirfsoc_init_late(void)
 }
 
 #ifdef CONFIG_ARCH_ATLAS6
-static const char *atlas6_dt_match[] __initconst = {
+static const char *const atlas6_dt_match[] __initconst = {
 	"sirf,atlas6",
 	NULL
 };
@@ -36,7 +36,7 @@ MACHINE_END
 #endif
 
 #ifdef CONFIG_ARCH_PRIMA2
-static const char *prima2_dt_match[] __initconst = {
+static const char *const prima2_dt_match[] __initconst = {
 	"sirf,prima2",
 	NULL
 };
@@ -52,7 +52,7 @@ MACHINE_END
 #endif
 
 #ifdef CONFIG_ARCH_ATLAS7
-static const char *atlas7_dt_match[] __initdata = {
+static const char *const atlas7_dt_match[] __initconst = {
 	"sirf,atlas7",
 	NULL
 };
diff --git a/arch/arm/mach-s5pv210/s5pv210.c b/arch/arm/mach-s5pv210/s5pv210.c
index 43eb1eaea0c9..83e656ea95ae 100644
--- a/arch/arm/mach-s5pv210/s5pv210.c
+++ b/arch/arm/mach-s5pv210/s5pv210.c
@@ -63,7 +63,7 @@ static void __init s5pv210_dt_init_late(void)
 	s5pv210_pm_init();
 }
 
-static char const *s5pv210_dt_compat[] __initconst = {
+static char const *const s5pv210_dt_compat[] __initconst = {
 	"samsung,s5pc110",
 	"samsung,s5pv210",
 	NULL
diff --git a/arch/arm/mach-shmobile/setup-emev2.c b/arch/arm/mach-shmobile/setup-emev2.c
index aad97be9cbe1..37f7b15c01bc 100644
--- a/arch/arm/mach-shmobile/setup-emev2.c
+++ b/arch/arm/mach-shmobile/setup-emev2.c
@@ -37,7 +37,7 @@ static void __init emev2_map_io(void)
 	iotable_init(emev2_io_desc, ARRAY_SIZE(emev2_io_desc));
 }
 
-static const char *emev2_boards_compat_dt[] __initconst = {
+static const char *const emev2_boards_compat_dt[] __initconst = {
 	"renesas,emev2",
 	NULL,
 };
diff --git a/arch/arm/mach-versatile/versatile_dt.c b/arch/arm/mach-versatile/versatile_dt.c
index 9f9bc61ca64b..7de3e92a13b0 100644
--- a/arch/arm/mach-versatile/versatile_dt.c
+++ b/arch/arm/mach-versatile/versatile_dt.c
@@ -35,7 +35,7 @@ static void __init versatile_dt_init(void)
 			     versatile_auxdata_lookup, NULL);
 }
 
-static const char *versatile_dt_match[] __initconst = {
+static const char *const versatile_dt_match[] __initconst = {
 	"arm,versatile-ab",
 	"arm,versatile-pb",
 	NULL,
-- 
2.1.4
