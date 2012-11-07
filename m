From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Wed, 07 Nov 2012 16:16:58 +0530
Subject: [PATCH 1/3] ARM: EXYNOS5: Setup legacy i2c controller interrupts on
 SMDK5250
In-Reply-To: <1352285220-31544-1-git-send-email-a.kesavan@samsung.com>
References: <1352285220-31544-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1352285220-31544-2-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Exynos5 we have a new high-speed i2c controller. The interrupt
sources for the legacy and new controller are muxed and are controlled
via the SYSCON I2C_CFG register. At reset the interrupt source is
configured for the high-speed controller, to continue using the old
i2c controller we need to modify the I2C_CFG register.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/mach-exynos/include/mach/regs-pmu.h |    2 ++
 arch/arm/mach-exynos/mach-exynos5-dt.c       |   24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/include/mach/regs-pmu.h b/arch/arm/mach-exynos/include/mach/regs-pmu.h
index d4e392b..684625a 100644
--- a/arch/arm/mach-exynos/include/mach/regs-pmu.h
+++ b/arch/arm/mach-exynos/include/mach/regs-pmu.h
@@ -15,6 +15,7 @@
 #include <mach/map.h>
 
 #define S5P_PMUREG(x)				(S5P_VA_PMU + (x))
+#define S5P_SYSREG(x)				(S3C_VA_SYS + (x))
 
 #define S5P_CENTRAL_SEQ_CONFIGURATION		S5P_PMUREG(0x0200)
 
@@ -230,6 +231,7 @@
 
 /* For EXYNOS5 */
 
+#define EXYNOS5_SYS_I2C_CFG					S5P_SYSREG(0x0234)
 #define EXYNOS5_USB_CFG						S5P_PMUREG(0x0230)
 
 #define EXYNOS5_AUTO_WDTRESET_DISABLE				S5P_PMUREG(0x0408)
diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index ed37273..7e9baf7 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -13,10 +13,12 @@
 #include <linux/serial_core.h>
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
+#include <linux/io.h>
 
 #include <asm/mach/arch.h>
 #include <asm/hardware/gic.h>
 #include <mach/map.h>
+#include <mach/regs-pmu.h>
 
 #include <plat/cpu.h>
 #include <plat/regs-serial.h>
@@ -97,6 +99,28 @@ static void __init exynos5250_dt_map_io(void)
 
 static void __init exynos5250_dt_machine_init(void)
 {
+	struct device_node *i2c_np;
+	const char *i2c_compat = "samsung,s3c2440-i2c";
+	unsigned int tmp;
+
+	/*
+	 * Exynos5's legacy i2c controller and new high speed i2c
+	 * controller have muxed interrupt sources. By default the
+	 * interrupts for 4-channel HS-I2C controller are enabled.
+	 * If node for first four channels of legacy i2c controller
+	 * are available then re-configure the interrupts via the
+	 * system register.
+	 */
+	for_each_compatible_node(i2c_np, NULL, i2c_compat) {
+		if (of_device_is_available(i2c_np)) {
+			if (of_alias_get_id(i2c_np, "i2c") < 4) {
+				tmp = readl(EXYNOS5_SYS_I2C_CFG);
+				writel(tmp & ~(0x1 << of_alias_get_id(i2c_np, "i2c")),
+						EXYNOS5_SYS_I2C_CFG);
+			}
+		}
+	}
+
 	of_platform_populate(NULL, of_default_bus_match_table,
 				exynos5250_auxdata_lookup, NULL);
 }
-- 
1.6.6.1
