From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Tue, 06 Nov 2012 11:48:46 +0530
Subject: [PATCH RFC] ARM: EXYNOS5: Setup legacy i2c controller interrupts on
 SMDK5250
Message-ID: <1352182726-29221-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Exynos5 we have a new high-speed i2c controller. The interrupt
sources for the legacy and new controller are muxed and are controlled
via the SYSCON I2C_CFG register.
At reset the interrupt source is configured for the high-speed controller,
to continue using the old i2c controller we need to modify the I2C_CFG
register.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
This is a hack, I am not quite clear on how to handle this via DT. Suggestions
welcome.

 arch/arm/mach-exynos/mach-exynos5-dt.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index ed37273..badffd4 100644
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
@@ -89,6 +91,12 @@ static const struct of_dev_auxdata exynos5250_auxdata_lookup[] __initconst = {
 	{},
 };
 
+static void exynos5_i2c_setup(void)
+{
+	/* Setup the low-speed i2c controller interrupts */
+	writel(0x0, EXYNOS5_SYS_I2C_CFG);
+}
+
 static void __init exynos5250_dt_map_io(void)
 {
 	exynos_init_io(NULL, 0);
@@ -97,6 +105,8 @@ static void __init exynos5250_dt_map_io(void)
 
 static void __init exynos5250_dt_machine_init(void)
 {
+	exynos5_i2c_setup();
+
 	of_platform_populate(NULL, of_default_bus_match_table,
 				exynos5250_auxdata_lookup, NULL);
 }
-- 
1.6.6.1
