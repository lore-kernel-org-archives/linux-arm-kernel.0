From: tobetter@gmail.com (Dongjin Kim)
Date: Sat, 18 Nov 2017 15:35:44 -0500
Subject: [PATCH] ARM: exynos: add machine description for ODROID-XU3/4
Message-ID: <20171118203544.19431-1-tobetter@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to add the machine descriptions for ODROID-XU3/4 boards
in order to present the hardware name at /proc/cputinfo rather than
"SAMSUNG EXYNOS (Flattened Device Tree)". An embedded open source project,
such as DietPi, reads the hardware name to run different features.

	$ cat /proc/cpuinfo | grep Hardware
	Hardware        : ODROID-XU4

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---
 arch/arm/mach-exynos/exynos.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index c404c15ad07f..6197dbf9f48b 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -241,3 +241,31 @@ DT_MACHINE_START(EXYNOS_DT, "SAMSUNG EXYNOS (Flattened Device Tree)")
 	.dt_compat	= exynos_dt_compat,
 	.dt_fixup	= exynos_dt_fixup,
 MACHINE_END
+
+#define ODROID_MACHINE_START(name, compat)			\
+	DT_MACHINE_START(EXYNOS5422_ODROID_##name, "ODROID-"#name)	\
+		.l2c_aux_val	= 0x3c400001,			\
+		.l2c_aux_mask	= 0xc20fffff,			\
+		.smp		= smp_ops(exynos_smp_ops),	\
+		.map_io		= exynos_init_io,		\
+		.init_early	= exynos_firmware_init,		\
+		.init_irq	= exynos_init_irq,		\
+		.init_machine	= exynos_dt_machine_init,	\
+		.init_late	= exynos_init_late,		\
+		.dt_compat	= compat,			\
+		.dt_fixup	= exynos_dt_fixup,		\
+	MACHINE_END
+
+static char const *const exynos5422_odroidxu3_dt_compat[] __initconst = {
+	"hardkernel,odroid-xu3",
+	"hardkernel,odroid-xu3-lite",
+	NULL,
+};
+
+static char const *const exynos5422_odroidxu4_dt_compat[] __initconst = {
+	"hardkernel,odroid-xu4",
+	NULL,
+};
+
+ODROID_MACHINE_START(XU3, exynos5422_odroidxu3_dt_compat)
+ODROID_MACHINE_START(XU4, exynos5422_odroidxu4_dt_compat)
-- 
2.11.0
