From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 03 May 2014 15:11:40 +0900
Subject: [PATCH 4/4] ARM: EXYNOS: Refactoring to remove soc_is_exynosXXXX
 macros from exynos
In-Reply-To: <1399097500-4052-1-git-send-email-pankaj.dubey@samsung.com>
References: <1399097500-4052-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1399097500-4052-5-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables chipid driver for ARCH_EXYNOS and refactors
machine code as well as exynos cpufreq driver code for using
chipid driver for identification of SoC ID and SoC rev.

This patch also updates DT binding information in exynos4 and
exynos5 dtsi file. As to differentiate product id bit-mask we need
separate compatible string for exynos4 and exynos5. Hoping this will
be helpful in future as bit-mask and bit-shift bit may differ.
Added binding information as well.

CC: Mike Turquette <mturquette@linaro.org>
CC: Pawel Moll <pawel.moll@arm.com>
CC: Rob Herring <robh+dt@kernel.org>
CC: Randy Dunlap <rdunlap@infradead.org>
CC: Russell King <linux@arm.linux.org.uk>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Thomas Abraham <thomas.abraham@linaro.org>
CC: Viresh Kumar <viresh.kumar@linaro.org>
CC: devicetree at vger.kernel.org
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 .../bindings/arm/samsung/exynos-chipid.txt         |   15 ++++++
 arch/arm/Kconfig                                   |    1 +
 arch/arm/boot/dts/exynos4.dtsi                     |    2 +-
 arch/arm/boot/dts/exynos5.dtsi                     |    2 +-
 arch/arm/mach-exynos/exynos.c                      |   36 ++-----------
 arch/arm/mach-exynos/platsmp.c                     |   10 ++--
 arch/arm/mach-exynos/pm.c                          |   28 +++++-----
 arch/arm/plat-samsung/include/plat/cpu.h           |   57 --------------------
 drivers/clk/samsung/clk-exynos4.c                  |    2 +-
 drivers/cpufreq/exynos-cpufreq.c                   |    9 ++--
 drivers/cpufreq/exynos-cpufreq.h                   |    1 -
 drivers/cpufreq/exynos4x12-cpufreq.c               |    5 +-
 12 files changed, 51 insertions(+), 117 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos-chipid.txt

diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.txt
new file mode 100644
index 0000000..b283c6b
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.txt
@@ -0,0 +1,15 @@
+SAMSUNG Exynos4/Exynos5 SoCs Chipid driver.
+
+Required properties:
+- compatible : should be:
+	"samsung,exynos4-chipid"
+	"samsung,exynos5-chipid"
+  Details:
+  samsung,exynos4-chipid: Exynos4 SoCs has Chip ID block that can provide
+	product id, revision number and package information.
+	It has different product-id bit-mask than Exynos5 series SoC.
+  samsung,exynos5-chipid: Exynos5 SoCs has Chip ID block that can provide
+	product id, revision number and package information.
+	It has different product-id bit-mask then Exynos4 series SoC.
+- reg: offset and length of the register set
+
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a4eac2f..06f14a4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -856,6 +856,7 @@ config ARCH_EXYNOS
 	select SRAM
 	select USE_OF
 	select MFD_SYSCON
+	select EXYNOS_CHIPID
 	help
 	  Support for SAMSUNG's EXYNOS SoCs (EXYNOS4/5)
 
diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 2f8bcd0..6db9029 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -46,7 +46,7 @@
 	};
 
 	chipid at 10000000 {
-		compatible = "samsung,exynos4210-chipid";
+		compatible = "samsung,exynos4-chipid";
 		reg = <0x10000000 0x100>;
 	};
 
diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index 79d0608..18e6047 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -19,7 +19,7 @@
 	interrupt-parent = <&gic>;
 
 	chipid at 10000000 {
-		compatible = "samsung,exynos4210-chipid";
+		compatible = "samsung,exynos5-chipid";
 		reg = <0x10000000 0x100>;
 	};
 
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 93ae076..64d804e 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -21,6 +21,7 @@
 #include <linux/pm_domain.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
+#include <linux/exynos-soc.h>
 
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -28,8 +29,6 @@
 #include <asm/mach/map.h>
 #include <asm/memory.h>
 
-#include <plat/cpu.h>
-
 #include "common.h"
 #include "mfc.h"
 #include "regs-pmu.h"
@@ -181,29 +180,6 @@ static void __init exynos_init_late(void)
 	exynos_pm_init();
 }
 
-static int __init exynos_fdt_map_chipid(unsigned long node, const char *uname,
-					int depth, void *data)
-{
-	struct map_desc iodesc;
-	__be32 *reg;
-	unsigned long len;
-
-	if (!of_flat_dt_is_compatible(node, "samsung,exynos4210-chipid") &&
-		!of_flat_dt_is_compatible(node, "samsung,exynos5440-clock"))
-		return 0;
-
-	reg = of_get_flat_dt_prop(node, "reg", &len);
-	if (reg == NULL || len != (sizeof(unsigned long) * 2))
-		return 0;
-
-	iodesc.pfn = __phys_to_pfn(be32_to_cpu(reg[0]));
-	iodesc.length = be32_to_cpu(reg[1]) - 1;
-	iodesc.virtual = (unsigned long)S5P_VA_CHIPID;
-	iodesc.type = MT_DEVICE;
-	iotable_init(&iodesc, 1);
-	return 1;
-}
-
 static const struct of_device_id exynos_dt_pmu_match[] = {
 	{ .compatible = "samsung,exynos4210-pmu" },
 	{ .compatible = "samsung,exynos4212-pmu" },
@@ -254,11 +230,6 @@ static void __init exynos_init_io(void)
 {
 	debug_ll_io_init();
 
-	of_scan_flat_dt(exynos_fdt_map_chipid, NULL);
-
-	/* detect cpu id and rev. */
-	s5p_init_cpu(S5P_VA_CHIPID);
-
 	exynos_map_io();
 }
 
@@ -345,7 +316,10 @@ static void __init exynos_dt_machine_init(void)
 
 	exynos_map_pmu();
 
-	if (!soc_is_exynos5440())
+	if (exynos_soc_id == EXYNOS_SOC_UNKNOWN)
+		early_exynos_chipid_init();
+
+	if (exynos_soc_id != EXYNOS5440)
 		platform_device_register(&exynos_cpuidle);
 
 	platform_device_register_simple("exynos-cpufreq", -1, NULL, 0);
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 12ea1fa..f63fd36 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -20,13 +20,13 @@
 #include <linux/smp.h>
 #include <linux/io.h>
 #include <linux/of_address.h>
+#include <linux/exynos-soc.h>
 
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 #include <asm/firmware.h>
 
-#include <plat/cpu.h>
 #include <mach/map.h>
 
 #include "common.h"
@@ -67,7 +67,8 @@ static int __init exynos_smp_prepare_sram(void)
 
 static inline void __iomem *cpu_boot_reg_base(void)
 {
-	if (soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_1_1)
+	if (exynos_soc_id == EXYNOS4210 &&
+			exynos_soc_rev == EXYNOS4210_REV_1_1)
 		return pmu_base + S5P_INFORM5;
 
 	return sram_base_addr;
@@ -78,9 +79,9 @@ static inline void __iomem *cpu_boot_reg(int cpu)
 	void __iomem *boot_reg;
 
 	boot_reg = cpu_boot_reg_base();
-	if (soc_is_exynos4412())
+	if (exynos_soc_id == EXYNOS4412)
 		boot_reg += 4*cpu;
-	else if (soc_is_exynos5420())
+	else if (exynos_soc_id == EXYNOS5420)
 		boot_reg += 4;
 	return boot_reg;
 }
@@ -261,6 +262,7 @@ static void __init exynos_smp_init_cpus(void)
 static void __init exynos_smp_prepare_cpus(unsigned int max_cpus)
 {
 	int i;
+	early_exynos_chipid_init();
 
 	pmu_base = pmu_base_addr();
 
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index a7a1b7f..d7dab1d 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -22,13 +22,13 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/regmap.h>
+#include <linux/exynos-soc.h>
 
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/smp_scu.h>
 #include <asm/suspend.h>
 
-#include <plat/cpu.h>
 #include <plat/pm-common.h>
 #include <plat/pll.h>
 #include <plat/regs-srom.h>
@@ -87,7 +87,7 @@ static int exynos_irq_set_wake(struct irq_data *data, unsigned int state)
 {
 	const struct exynos_wkup_irq *wkup_irq;
 
-	if (soc_is_exynos5250())
+	if (exynos_soc_id == EXYNOS5250)
 		wkup_irq = exynos5250_wkup_irq;
 	else
 		wkup_irq = exynos4_wkup_irq;
@@ -106,11 +106,11 @@ static int exynos_irq_set_wake(struct irq_data *data, unsigned int state)
 	return -ENOENT;
 }
 
-#define EXYNOS_BOOT_VECTOR_ADDR	(samsung_rev() == EXYNOS4210_REV_1_1 ? \
-			S5P_INFORM7 : (samsung_rev() == EXYNOS4210_REV_1_0 ? \
+#define EXYNOS_BOOT_VECTOR_ADDR	(exynos_soc_rev == EXYNOS4210_REV_1_1 ? \
+			S5P_INFORM7 : (exynos_soc_rev == EXYNOS4210_REV_1_0 ? \
 			0x24 : S5P_INFORM0))
-#define EXYNOS_BOOT_VECTOR_FLAG	(samsung_rev() == EXYNOS4210_REV_1_1 ? \
-			S5P_INFORM6 : (samsung_rev() == EXYNOS4210_REV_1_0 ? \
+#define EXYNOS_BOOT_VECTOR_FLAG	(exynos_soc_rev == EXYNOS4210_REV_1_1 ? \
+			S5P_INFORM6 : (exynos_soc_rev == EXYNOS4210_REV_1_0 ? \
 			0x20 : S5P_INFORM1))
 
 #define S5P_CHECK_AFTR  0xFCBA0D10
@@ -124,7 +124,7 @@ static void exynos_set_wakeupmask(long mask)
 
 static void exynos_cpu_set_boot_vector(long flags)
 {
-	if (samsung_rev() == EXYNOS4210_REV_1_0) {
+	if (exynos_soc_rev == EXYNOS4210_REV_1_0) {
 		__raw_writel(virt_to_phys(exynos_cpu_resume),
 				S5P_VA_SYSRAM + EXYNOS_BOOT_VECTOR_ADDR);
 		__raw_writel(flags, S5P_VA_SYSRAM + EXYNOS_BOOT_VECTOR_FLAG);
@@ -188,7 +188,7 @@ static int exynos_cpu_suspend(unsigned long arg)
 	outer_flush_all();
 #endif
 
-	if (soc_is_exynos5250())
+	if (exynos_soc_id == EXYNOS5250)
 		flush_cache_all();
 
 	/* issue the standby signal into the pm unit. */
@@ -210,7 +210,7 @@ static void exynos_pm_prepare(void)
 
 	s3c_pm_do_save(exynos_core_save, ARRAY_SIZE(exynos_core_save));
 
-	if (soc_is_exynos5250()) {
+	if (exynos_soc_id == EXYNOS5250) {
 		s3c_pm_do_save(exynos5_sys_save, ARRAY_SIZE(exynos5_sys_save));
 		/* Disable USE_RETENTION of JPEG_MEM_OPTION */
 		regmap_read(pmu_regmap, EXYNOS5_JPEG_MEM_OPTION, &tmp);
@@ -249,7 +249,7 @@ static int exynos_pm_suspend(void)
 	tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
 	regmap_write(pmu_regmap, S5P_CENTRAL_SEQ_OPTION, tmp);
 
-	if (!soc_is_exynos5250())
+	if (exynos_soc_id != EXYNOS5250)
 		exynos_cpu_save_register();
 
 	return 0;
@@ -283,7 +283,7 @@ static void exynos_pm_resume(void)
 	if (exynos_pm_central_resume())
 		goto early_wakeup;
 
-	if (!soc_is_exynos5250())
+	if (exynos_soc_id != EXYNOS5250)
 		exynos_cpu_restore_register();
 
 	/* For release retention */
@@ -296,13 +296,13 @@ static void exynos_pm_resume(void)
 	regmap_write(pmu_regmap, S5P_PAD_RET_EBIA_OPTION, (1 << 28));
 	regmap_write(pmu_regmap, S5P_PAD_RET_EBIB_OPTION, (1 << 28));
 
-	if (soc_is_exynos5250())
+	if (exynos_soc_id == EXYNOS5250)
 		s3c_pm_do_restore(exynos5_sys_save,
 			ARRAY_SIZE(exynos5_sys_save));
 
 	s3c_pm_do_restore_core(exynos_core_save, ARRAY_SIZE(exynos_core_save));
 
-	if (!soc_is_exynos5250())
+	if (exynos_soc_id != EXYNOS5250)
 		scu_enable(S5P_VA_SCU);
 
 early_wakeup:
@@ -395,7 +395,7 @@ static int exynos_cpu_pm_notifier(struct notifier_block *self,
 
 	case CPU_PM_EXIT:
 		if (cpu == 0) {
-			if (!soc_is_exynos5250())
+			if (exynos_soc_id != EXYNOS5250)
 				scu_enable(S5P_VA_SCU);
 			exynos_cpu_restore_register();
 			exynos_pm_central_resume();
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index 18a9a00..135471d 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -43,16 +43,6 @@ extern unsigned long samsung_cpu_id;
 #define S5PV210_CPU_ID		0x43110000
 #define S5PV210_CPU_MASK	0xFFFFF000
 
-#define EXYNOS4210_CPU_ID	0x43210000
-#define EXYNOS4212_CPU_ID	0x43220000
-#define EXYNOS4412_CPU_ID	0xE4412200
-#define EXYNOS4_CPU_MASK	0xFFFE0000
-
-#define EXYNOS5250_SOC_ID	0x43520000
-#define EXYNOS5420_SOC_ID	0xE5420000
-#define EXYNOS5440_SOC_ID	0xE5440000
-#define EXYNOS5_SOC_MASK	0xFFFFF000
-
 #define IS_SAMSUNG_CPU(name, id, mask)		\
 static inline int is_samsung_##name(void)	\
 {						\
@@ -68,12 +58,6 @@ IS_SAMSUNG_CPU(s5p6440, S5P6440_CPU_ID, S5P64XX_CPU_MASK)
 IS_SAMSUNG_CPU(s5p6450, S5P6450_CPU_ID, S5P64XX_CPU_MASK)
 IS_SAMSUNG_CPU(s5pc100, S5PC100_CPU_ID, S5PC100_CPU_MASK)
 IS_SAMSUNG_CPU(s5pv210, S5PV210_CPU_ID, S5PV210_CPU_MASK)
-IS_SAMSUNG_CPU(exynos4210, EXYNOS4210_CPU_ID, EXYNOS4_CPU_MASK)
-IS_SAMSUNG_CPU(exynos4212, EXYNOS4212_CPU_ID, EXYNOS4_CPU_MASK)
-IS_SAMSUNG_CPU(exynos4412, EXYNOS4412_CPU_ID, EXYNOS4_CPU_MASK)
-IS_SAMSUNG_CPU(exynos5250, EXYNOS5250_SOC_ID, EXYNOS5_SOC_MASK)
-IS_SAMSUNG_CPU(exynos5420, EXYNOS5420_SOC_ID, EXYNOS5_SOC_MASK)
-IS_SAMSUNG_CPU(exynos5440, EXYNOS5440_SOC_ID, EXYNOS5_SOC_MASK)
 
 #if defined(CONFIG_CPU_S3C2410) || defined(CONFIG_CPU_S3C2412) || \
     defined(CONFIG_CPU_S3C2416) || defined(CONFIG_CPU_S3C2440) || \
@@ -126,47 +110,6 @@ IS_SAMSUNG_CPU(exynos5440, EXYNOS5440_SOC_ID, EXYNOS5_SOC_MASK)
 # define soc_is_s5pv210()	0
 #endif
 
-#if defined(CONFIG_CPU_EXYNOS4210)
-# define soc_is_exynos4210()	is_samsung_exynos4210()
-#else
-# define soc_is_exynos4210()	0
-#endif
-
-#if defined(CONFIG_SOC_EXYNOS4212)
-# define soc_is_exynos4212()	is_samsung_exynos4212()
-#else
-# define soc_is_exynos4212()	0
-#endif
-
-#if defined(CONFIG_SOC_EXYNOS4412)
-# define soc_is_exynos4412()	is_samsung_exynos4412()
-#else
-# define soc_is_exynos4412()	0
-#endif
-
-#define EXYNOS4210_REV_0	(0x0)
-#define EXYNOS4210_REV_1_0	(0x10)
-#define EXYNOS4210_REV_1_1	(0x11)
-
-#if defined(CONFIG_SOC_EXYNOS5250)
-# define soc_is_exynos5250()	is_samsung_exynos5250()
-#else
-# define soc_is_exynos5250()	0
-#endif
-
-#if defined(CONFIG_SOC_EXYNOS5420)
-# define soc_is_exynos5420()	is_samsung_exynos5420()
-#else
-# define soc_is_exynos5420()	0
-#endif
-
-#if defined(CONFIG_SOC_EXYNOS5440)
-# define soc_is_exynos5440()	is_samsung_exynos5440()
-#else
-# define soc_is_exynos5440()	0
-#endif
-
-
 #define IODESC_ENT(x) { (unsigned long)S3C24XX_VA_##x, __phys_to_pfn(S3C24XX_PA_##x), S3C24XX_SZ_##x, MT_DEVICE }
 
 #ifndef KHZ
diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index b4f9672..7b0ea1f 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -1030,7 +1030,7 @@ static unsigned long exynos4_get_xom(void)
 	void __iomem *chipid_base;
 	struct device_node *np;
 
-	np = of_find_compatible_node(NULL, NULL, "samsung,exynos4210-chipid");
+	np = of_find_compatible_node(NULL, NULL, "samsung,exynos4-chipid");
 	if (np) {
 		chipid_base = of_iomap(np, 0);
 
diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index f99cfe2..458ddcc 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -17,8 +17,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/cpufreq.h>
 #include <linux/platform_device.h>
-
-#include <plat/cpu.h>
+#include <linux/exynos-soc.h>
 
 #include "exynos-cpufreq.h"
 
@@ -163,11 +162,11 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 	if (!exynos_info)
 		return -ENOMEM;
 
-	if (soc_is_exynos4210())
+	if (exynos_soc_id == EXYNOS4210)
 		ret = exynos4210_cpufreq_init(exynos_info);
-	else if (soc_is_exynos4212() || soc_is_exynos4412())
+	else if ((exynos_soc_id == EXYNOS4212) || (exynos_soc_id == EXYNOS4412))
 		ret = exynos4x12_cpufreq_init(exynos_info);
-	else if (soc_is_exynos5250())
+	else if (exynos_soc_id == EXYNOS5250)
 		ret = exynos5250_cpufreq_init(exynos_info);
 	else
 		return 0;
diff --git a/drivers/cpufreq/exynos-cpufreq.h b/drivers/cpufreq/exynos-cpufreq.h
index 3ddade8..4201b6d 100644
--- a/drivers/cpufreq/exynos-cpufreq.h
+++ b/drivers/cpufreq/exynos-cpufreq.h
@@ -68,7 +68,6 @@ static inline int exynos5250_cpufreq_init(struct exynos_dvfs_info *info)
 }
 #endif
 
-#include <plat/cpu.h>
 #include <mach/map.h>
 
 #define EXYNOS4_CLKSRC_CPU			(S5P_VA_CMU + 0x14200)
diff --git a/drivers/cpufreq/exynos4x12-cpufreq.c b/drivers/cpufreq/exynos4x12-cpufreq.c
index 466c76a..e328c8f 100644
--- a/drivers/cpufreq/exynos4x12-cpufreq.c
+++ b/drivers/cpufreq/exynos4x12-cpufreq.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/cpufreq.h>
+#include <linux/exynos-soc.h>
 
 #include "exynos-cpufreq.h"
 
@@ -115,7 +116,7 @@ static void exynos4x12_set_clkdiv(unsigned int div_index)
 	tmp = apll_freq_4x12[div_index].clk_div_cpu1;
 
 	__raw_writel(tmp, EXYNOS4_CLKDIV_CPU1);
-	if (soc_is_exynos4212())
+	if (exynos_soc_id == EXYNOS4212)
 		stat_cpu1 = 0x11;
 	else
 		stat_cpu1 = 0x111;
@@ -184,7 +185,7 @@ int exynos4x12_cpufreq_init(struct exynos_dvfs_info *info)
 	if (IS_ERR(mout_apll))
 		goto err_mout_apll;
 
-	if (soc_is_exynos4212())
+	if (exynos_soc_id == EXYNOS4212)
 		apll_freq_4x12 = apll_freq_4212;
 	else
 		apll_freq_4x12 = apll_freq_4412;
-- 
1.7.10.4
