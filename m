From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 19 Oct 2012 11:45:54 +0900
Subject: [PATCH 1/7] ARM: EXYNOS: add support for EXYNOS5440 SoC
In-Reply-To: <1350614759-1852-1-git-send-email-kgene.kim@samsung.com>
References: <1350614759-1852-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1350614759-1852-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for EXYNOS5440 SoC which is including
Cortex-A15 Quad cores.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/Kconfig                 |   20 ++++++
 arch/arm/mach-exynos/Makefile                |    3 +-
 arch/arm/mach-exynos/common.c                |   85 ++++++++++++++++++++++++--
 arch/arm/mach-exynos/common.h                |    2 +
 arch/arm/mach-exynos/dev-uart.c              |   14 ++++
 arch/arm/mach-exynos/include/mach/irqs.h     |    5 ++
 arch/arm/mach-exynos/include/mach/map.h      |    8 +++
 arch/arm/mach-exynos/include/mach/regs-pmu.h |    1 +
 arch/arm/mach-exynos/mach-exynos5-dt.c       |   34 ++++++++---
 arch/arm/mach-exynos/mct.c                   |   15 +++++
 arch/arm/mach-exynos/setup-i2c0.c            |    2 +-
 arch/arm/plat-samsung/include/plat/cpu.h     |    8 +++
 arch/arm/plat-samsung/include/plat/devs.h    |    1 +
 drivers/tty/serial/samsung.c                 |    3 +-
 14 files changed, 184 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 1d0d083..c047aba 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -68,6 +68,16 @@ config SOC_EXYNOS5250
 	help
 	  Enable EXYNOS5250 SoC support
 
+config SOC_EXYNOS5440
+	bool "SAMSUNG EXYNOS5440"
+	default y
+	depends on ARCH_EXYNOS5
+	select ARM_ARCH_TIMER
+	select AUTO_ZRELADDR
+	select COMMON_CLK
+	help
+	  Enable EXYNOS5440 SoC support
+
 config EXYNOS4_MCT
 	bool
 	default y
@@ -426,6 +436,16 @@ config MACH_EXYNOS5_DT
 	  Machine support for Samsung EXYNOS5 machine with device tree enabled.
 	  Select this if a fdt blob is available for the EXYNOS5 SoC based board.
 
+config MACH_EXYNOS5440_DT
+	bool "SAMSUNG EXYNOS5440 Machine using device tree"
+	depends on ARCH_EXYNOS5
+	select ARM_AMBA
+	select SOC_EXYNOS5440
+	select USE_OF
+	help
+	  Machine support for Samsung EXYNOS5440 machine with device tree enabled.
+	  Select this if a fdt blob is available for the EXYNOS5440 SoC based board.
+
 if ARCH_EXYNOS4
 
 comment "Configuration for HSMMC 8-bit bus width"
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index ad66c9f4..92df758 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -13,7 +13,7 @@ obj-				:=
 # Core
 
 obj-$(CONFIG_ARCH_EXYNOS)	+= common.o
-obj-$(CONFIG_ARCH_EXYNOS5)	+= clock-exynos5.o
+obj-$(CONFIG_SOC_EXYNOS5250)	+= clock-exynos5.o
 
 obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_PM_GENERIC_DOMAINS) += pm_domains.o
@@ -41,6 +41,7 @@ obj-$(CONFIG_MACH_SMDK4412)		+= mach-smdk4x12.o
 
 obj-$(CONFIG_MACH_EXYNOS4_DT)		+= mach-exynos4-dt.o
 obj-$(CONFIG_MACH_EXYNOS5_DT)		+= mach-exynos5-dt.o
+obj-$(CONFIG_MACH_EXYNOS5440_DT)	+= mach-exynos5-dt.o
 
 # device support
 
diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index fea1542..786d8f4 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -57,9 +57,11 @@ static const char name_exynos4210[] = "EXYNOS4210";
 static const char name_exynos4212[] = "EXYNOS4212";
 static const char name_exynos4412[] = "EXYNOS4412";
 static const char name_exynos5250[] = "EXYNOS5250";
+static const char name_exynos5440[] = "EXYNOS5440";
 
 static void exynos4_map_io(void);
 static void exynos5_map_io(void);
+static void exynos5440_map_io(void);
 static void exynos5_init_clocks(int xtal);
 static void exynos_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 static int exynos_init(void);
@@ -94,6 +96,13 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.init_uarts	= exynos_init_uarts,
 		.init		= exynos_init,
 		.name		= name_exynos5250,
+	}, {
+		.idcode		= EXYNOS5440_SOC_ID,
+		.idmask		= EXYNOS5_SOC_MASK,
+		.map_io		= exynos5440_map_io,
+		.init_uarts	= exynos_init_uarts,
+		.init		= exynos_init,
+		.name		= name_exynos5440,
 	},
 };
 
@@ -108,6 +117,15 @@ static struct map_desc exynos_iodesc[] __initdata = {
 	},
 };
 
+static struct map_desc exynos5440_iodesc[] __initdata = {
+	{
+		.virtual	= (unsigned long)S5P_VA_CHIPID,
+		.pfn		= __phys_to_pfn(EXYNOS5440_PA_CHIPID),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	},
+};
+
 static struct map_desc exynos4_iodesc[] __initdata = {
 	{
 		.virtual	= (unsigned long)S3C_VA_SYS,
@@ -274,6 +292,25 @@ static struct map_desc exynos5_iodesc[] __initdata = {
 	},
 };
 
+static struct map_desc exynos5440_iodesc0[] __initdata = {
+	{
+		.virtual	= (unsigned long)S3C_VA_UART,
+		.pfn		= __phys_to_pfn(EXYNOS5440_PA_UART0),
+		.length		= SZ_512K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_GIC_CPU,
+		.pfn		= __phys_to_pfn(EXYNOS5440_PA_GIC_CPU),
+		.length		= SZ_64K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_GIC_DIST,
+		.pfn		= __phys_to_pfn(EXYNOS5440_PA_GIC_DIST),
+		.length		= SZ_64K,
+		.type		= MT_DEVICE,
+	},
+};
+
 void exynos4_restart(char mode, const char *cmd)
 {
 	__raw_writel(0x1, S5P_SWRESET);
@@ -281,11 +318,29 @@ void exynos4_restart(char mode, const char *cmd)
 
 void exynos5_restart(char mode, const char *cmd)
 {
-	__raw_writel(0x1, EXYNOS_SWRESET);
+	u32 val;
+	void __iomem *addr;
+
+	if (of_machine_is_compatible("samsung,exynos5250")) {
+		val = 0x1;
+		addr = EXYNOS_SWRESET;
+	} else if (of_machine_is_compatible("samsung,exynos5440")) {
+		val = (0x10 << 20) | (0x1 << 16);
+		addr = EXYNOS5440_SWRESET;
+	} else {
+		pr_err("%s: cannot support non-DT\n", __func__);
+		return;
+	}
+
+	__raw_writel(val, addr);
 }
 
 void __init exynos_init_late(void)
 {
+	if (of_machine_is_compatible("samsung,exynos5440"))
+		/* to be supported later */
+		return;
+
 	exynos_pm_late_initcall();
 }
 
@@ -298,7 +353,11 @@ void __init exynos_init_late(void)
 void __init exynos_init_io(struct map_desc *mach_desc, int size)
 {
 	/* initialize the io descriptors we need for initialization */
-	iotable_init(exynos_iodesc, ARRAY_SIZE(exynos_iodesc));
+	if (of_machine_is_compatible("samsung,exynos5440"))
+		iotable_init(exynos5440_iodesc, ARRAY_SIZE(exynos5440_iodesc));
+	else
+		iotable_init(exynos_iodesc, ARRAY_SIZE(exynos_iodesc));
+
 	if (mach_desc)
 		iotable_init(mach_desc, size);
 
@@ -364,6 +423,11 @@ static void __init exynos5_map_io(void)
 	s3c_i2c2_setname("s3c2440-i2c");
 }
 
+static void __init exynos5440_map_io(void)
+{
+	iotable_init(exynos5440_iodesc0, ARRAY_SIZE(exynos5440_iodesc0));
+}
+
 static void __init exynos5_init_clocks(int xtal)
 {
 	printk(KERN_DEBUG "%s: initializing clocks\n", __func__);
@@ -587,6 +651,11 @@ static const struct of_device_id exynos4_dt_irq_match[] = {
 			.data = combiner_of_init, },
 	{},
 };
+
+static const struct of_device_id exynos5440_dt_irq_match[] = {
+	{ .compatible = "arm,cortex-a15-gic", .data = gic_of_init, },
+	{},
+};
 #endif
 
 void __init exynos4_init_irq(void)
@@ -616,14 +685,18 @@ void __init exynos4_init_irq(void)
 void __init exynos5_init_irq(void)
 {
 #ifdef CONFIG_OF
-	of_irq_init(exynos4_dt_irq_match);
+	if (soc_is_exynos5440())
+		of_irq_init(exynos5440_dt_irq_match);
+	else
+		of_irq_init(exynos4_dt_irq_match);
 #endif
 	/*
 	 * The parameters of s5p_init_irq() are for VIC init.
 	 * Theses parameters should be NULL and 0 because EXYNOS4
 	 * uses GIC instead of VIC.
 	 */
-	s5p_init_irq(NULL, 0);
+	if (!soc_is_exynos5440())
+		s5p_init_irq(NULL, 0);
 }
 
 struct bus_type exynos_subsys = {
@@ -646,7 +719,7 @@ static int __init exynos4_l2x0_cache_init(void)
 {
 	int ret;
 
-	if (soc_is_exynos5250())
+	if (soc_is_exynos5250() || soc_is_exynos5440())
 		return 0;
 
 	ret = l2x0_of_init(L2_AUX_VAL, L2_AUX_MASK);
@@ -714,6 +787,8 @@ static void __init exynos_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 
 	if (soc_is_exynos5250())
 		s3c24xx_init_uartdevs("exynos4210-uart", exynos5_uart_resources, cfg, no);
+	else if (soc_is_exynos5440())
+		s3c24xx_init_uartdevs("exynos4210-uart", exynos5440_uart_resources, cfg, no);
 	else
 		s3c24xx_init_uartdevs("exynos4210-uart", exynos4_uart_resources, cfg, no);
 }
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 7a4e0ea..99b88f8 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -13,9 +13,11 @@
 #define __ARCH_ARM_MACH_EXYNOS_COMMON_H
 
 extern struct sys_timer exynos4_timer;
+extern struct sys_timer exynos5_timer;
 
 struct map_desc;
 void exynos_init_io(struct map_desc *mach_desc, int size);
+void exynos5440_init_io(struct map_desc *mach_desc, int size);
 void exynos4_init_irq(void);
 void exynos5_init_irq(void);
 void exynos4_restart(char mode, const char *cmd);
diff --git a/arch/arm/mach-exynos/dev-uart.c b/arch/arm/mach-exynos/dev-uart.c
index 2e85c02..95b887f 100644
--- a/arch/arm/mach-exynos/dev-uart.c
+++ b/arch/arm/mach-exynos/dev-uart.c
@@ -76,3 +76,17 @@ struct s3c24xx_uart_resources exynos5_uart_resources[] __initdata = {
 		.nr_resources	= ARRAY_SIZE(exynos5_uart3_resource),
 	},
 };
+
+EXYNOS_UART_RESOURCE(5440, 0)
+EXYNOS_UART_RESOURCE(5440, 1)
+
+struct s3c24xx_uart_resources exynos5440_uart_resources[] __initdata = {
+	[0] = {
+		.resources	= exynos5440_uart0_resource,
+		.nr_resources	= ARRAY_SIZE(exynos5440_uart0_resource),
+	},
+	[1] = {
+		.resources	= exynos5440_uart1_resource,
+		.nr_resources	= ARRAY_SIZE(exynos5440_uart0_resource),
+	},
+};
diff --git a/arch/arm/mach-exynos/include/mach/irqs.h b/arch/arm/mach-exynos/include/mach/irqs.h
index 35bced6..f43a96c 100644
--- a/arch/arm/mach-exynos/include/mach/irqs.h
+++ b/arch/arm/mach-exynos/include/mach/irqs.h
@@ -333,6 +333,11 @@
 #define EXYNOS5_IRQ_FIMC_LITE1		IRQ_SPI(126)
 #define EXYNOS5_IRQ_RP_TIMER		IRQ_SPI(127)
 
+/* EXYNOS5440 */
+
+#define EXYNOS5440_IRQ_UART0		IRQ_SPI(2)
+#define EXYNOS5440_IRQ_UART1		IRQ_SPI(3)
+
 #define EXYNOS5_IRQ_PMU			COMBINER_IRQ(1, 2)
 
 #define EXYNOS5_IRQ_SYSMMU_GSC0_0	COMBINER_IRQ(2, 0)
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index 8480849..d0602d3 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -53,12 +53,14 @@
 #define EXYNOS4_PA_ONENAND_DMA		0x0C600000
 
 #define EXYNOS_PA_CHIPID		0x10000000
+#define EXYNOS5440_PA_CHIPID		0x00160000
 
 #define EXYNOS4_PA_SYSCON		0x10010000
 #define EXYNOS5_PA_SYSCON		0x10050100
 
 #define EXYNOS4_PA_PMU			0x10020000
 #define EXYNOS5_PA_PMU			0x10040000
+#define EXYNOS5440_PA_PMU		0x00160000
 
 #define EXYNOS4_PA_CMU			0x10030000
 #define EXYNOS5_PA_CMU			0x10010000
@@ -83,6 +85,8 @@
 #define EXYNOS4_PA_GIC_DIST		0x10490000
 #define EXYNOS5_PA_GIC_CPU		0x10482000
 #define EXYNOS5_PA_GIC_DIST		0x10481000
+#define EXYNOS5440_PA_GIC_CPU		0x002E2000
+#define EXYNOS5440_PA_GIC_DIST		0x002E1000
 
 #define EXYNOS4_PA_COREPERI		0x10500000
 #define EXYNOS4_PA_TWD			0x10500600
@@ -281,6 +285,10 @@
 #define EXYNOS5_PA_UART3		0x12C30000
 #define EXYNOS5_SZ_UART			SZ_256
 
+#define EXYNOS5440_PA_UART0		0x000B0000
+#define EXYNOS5440_PA_UART1		0x000C0000
+#define EXYNOS5440_SZ_UART		SZ_256
+
 #define S3C_VA_UARTx(x)			(S3C_VA_UART + ((x) * S3C_UART_OFFSET))
 
 #endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-exynos/include/mach/regs-pmu.h b/arch/arm/mach-exynos/include/mach/regs-pmu.h
index d4e392b..c0b74f3 100644
--- a/arch/arm/mach-exynos/include/mach/regs-pmu.h
+++ b/arch/arm/mach-exynos/include/mach/regs-pmu.h
@@ -31,6 +31,7 @@
 
 #define S5P_SWRESET				S5P_PMUREG(0x0400)
 #define EXYNOS_SWRESET				S5P_PMUREG(0x0400)
+#define EXYNOS5440_SWRESET			S5P_PMUREG(0x00C4)
 
 #define S5P_WAKEUP_STAT				S5P_PMUREG(0x0600)
 #define S5P_EINT_WAKEUP_MASK			S5P_PMUREG(0x0604)
diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index db1cd8e..7052f80 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -75,20 +75,24 @@ static const struct of_dev_auxdata exynos5250_auxdata_lookup[] __initconst = {
 	{},
 };
 
-static void __init exynos5250_dt_map_io(void)
+static void __init exynos5_dt_map_io(void)
 {
 	exynos_init_io(NULL, 0);
-	s3c24xx_init_clocks(24000000);
+
+	if (of_machine_is_compatible("samsung,exynos5250"))
+		s3c24xx_init_clocks(24000000);
 }
 
-static void __init exynos5250_dt_machine_init(void)
+static void __init exynos5_dt_machine_init(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table,
-				exynos5250_auxdata_lookup, NULL);
+	if (of_machine_is_compatible("samsung,exynos5250"))
+		of_platform_populate(NULL, of_default_bus_match_table,
+				     exynos5250_auxdata_lookup, NULL);
 }
 
-static char const *exynos5250_dt_compat[] __initdata = {
+static char const *exynos5_dt_compat[] __initdata = {
 	"samsung,exynos5250",
+	"samsung,exynos5440",
 	NULL
 };
 
@@ -96,11 +100,23 @@ DT_MACHINE_START(EXYNOS5_DT, "SAMSUNG EXYNOS5 (Flattened Device Tree)")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
 	.init_irq	= exynos5_init_irq,
 	.smp		= smp_ops(exynos_smp_ops),
-	.map_io		= exynos5250_dt_map_io,
+	.map_io		= exynos5_dt_map_io,
 	.handle_irq	= gic_handle_irq,
-	.init_machine	= exynos5250_dt_machine_init,
+	.init_machine	= exynos5_dt_machine_init,
 	.init_late	= exynos_init_late,
 	.timer		= &exynos4_timer,
-	.dt_compat	= exynos5250_dt_compat,
+	.dt_compat	= exynos5_dt_compat,
+	.restart        = exynos5_restart,
+MACHINE_END
+
+DT_MACHINE_START(EXYNOS5440_DT, "SAMSUNG EXYNOS5440 (Flattened Device Tree)")
+	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
+	.init_irq	= exynos5_init_irq,
+	.smp		= smp_ops(exynos_smp_ops),
+	.map_io		= exynos5_dt_map_io,
+	.handle_irq	= gic_handle_irq,
+	.init_machine	= exynos5_dt_machine_init,
+	.timer		= &exynos5_timer,
+	.dt_compat	= exynos5_dt_compat,
 	.restart        = exynos5_restart,
 MACHINE_END
diff --git a/arch/arm/mach-exynos/mct.c b/arch/arm/mach-exynos/mct.c
index cc3805a..31f45ec 100644
--- a/arch/arm/mach-exynos/mct.c
+++ b/arch/arm/mach-exynos/mct.c
@@ -19,7 +19,9 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/percpu.h>
+#include <linux/of.h>
 
+#include <asm/arch_timer.h>
 #include <asm/hardware/gic.h>
 #include <asm/localtimer.h>
 
@@ -487,6 +489,9 @@ static void __init exynos4_timer_init(void)
 		exynos4x12_clk_init();
 #endif
 
+	if (of_machine_is_compatible("samsung,exynos5440"))
+		arch_timer_of_register();
+
 	if ((soc_is_exynos4210()) || (soc_is_exynos5250()))
 		mct_int_type = MCT_INT_SPI;
 	else
@@ -500,3 +505,13 @@ static void __init exynos4_timer_init(void)
 struct sys_timer exynos4_timer = {
 	.init		= exynos4_timer_init,
 };
+
+static void __init exynos5_timer_init(void)
+{
+	if (of_machine_is_compatible("samsung,exynos5440"))
+		arch_timer_of_register();
+}
+
+struct sys_timer exynos5_timer = {
+	.init		= exynos5_timer_init,
+};
diff --git a/arch/arm/mach-exynos/setup-i2c0.c b/arch/arm/mach-exynos/setup-i2c0.c
index 5700f23..e2d9dfb 100644
--- a/arch/arm/mach-exynos/setup-i2c0.c
+++ b/arch/arm/mach-exynos/setup-i2c0.c
@@ -20,7 +20,7 @@ struct platform_device; /* don't need the contents */
 
 void s3c_i2c0_cfg_gpio(struct platform_device *dev)
 {
-	if (soc_is_exynos5250())
+	if (soc_is_exynos5250() || soc_is_exynos5440())
 		/* will be implemented with gpio function */
 		return;
 
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index ace4451..e0072ce 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -43,6 +43,7 @@ extern unsigned long samsung_cpu_id;
 #define EXYNOS4_CPU_MASK	0xFFFE0000
 
 #define EXYNOS5250_SOC_ID	0x43520000
+#define EXYNOS5440_SOC_ID	0x54400000
 #define EXYNOS5_SOC_MASK	0xFFFFF000
 
 #define IS_SAMSUNG_CPU(name, id, mask)		\
@@ -62,6 +63,7 @@ IS_SAMSUNG_CPU(exynos4210, EXYNOS4210_CPU_ID, EXYNOS4_CPU_MASK)
 IS_SAMSUNG_CPU(exynos4212, EXYNOS4212_CPU_ID, EXYNOS4_CPU_MASK)
 IS_SAMSUNG_CPU(exynos4412, EXYNOS4412_CPU_ID, EXYNOS4_CPU_MASK)
 IS_SAMSUNG_CPU(exynos5250, EXYNOS5250_SOC_ID, EXYNOS5_SOC_MASK)
+IS_SAMSUNG_CPU(exynos5440, EXYNOS5440_SOC_ID, EXYNOS5_SOC_MASK)
 
 #if defined(CONFIG_CPU_S3C2410) || defined(CONFIG_CPU_S3C2412) || \
     defined(CONFIG_CPU_S3C2416) || defined(CONFIG_CPU_S3C2440) || \
@@ -130,6 +132,12 @@ IS_SAMSUNG_CPU(exynos5250, EXYNOS5250_SOC_ID, EXYNOS5_SOC_MASK)
 # define soc_is_exynos5250()	0
 #endif
 
+#if defined(CONFIG_SOC_EXYNOS5440)
+# define soc_is_exynos5440()	is_samsung_exynos5440()
+#else
+# define soc_is_exynos5440()	0
+#endif
+
 #define IODESC_ENT(x) { (unsigned long)S3C24XX_VA_##x, __phys_to_pfn(S3C24XX_PA_##x), S3C24XX_SZ_##x, MT_DEVICE }
 
 #ifndef KHZ
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index 5da4b4f..cd90038 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -28,6 +28,7 @@ extern struct s3c24xx_uart_resources s3c64xx_uart_resources[];
 extern struct s3c24xx_uart_resources s5p_uart_resources[];
 extern struct s3c24xx_uart_resources exynos4_uart_resources[];
 extern struct s3c24xx_uart_resources exynos5_uart_resources[];
+extern struct s3c24xx_uart_resources exynos5440_uart_resources[];
 
 extern struct platform_device *s3c24xx_uart_devs[];
 extern struct platform_device *s3c24xx_uart_src[];
diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 7f04717..0e26a16 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1646,7 +1646,8 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 #endif
 
 #if defined(CONFIG_CPU_EXYNOS4210) || defined(CONFIG_SOC_EXYNOS4212) || \
-	defined(CONFIG_SOC_EXYNOS4412) || defined(CONFIG_SOC_EXYNOS5250)
+	defined(CONFIG_SOC_EXYNOS4412) || defined(CONFIG_SOC_EXYNOS5250) || \
+	defined(CONFIG_SOC_EXYNOS5440)
 static struct s3c24xx_serial_drv_data exynos4210_serial_drv_data = {
 	.info = &(struct s3c24xx_uart_info) {
 		.name		= "Samsung Exynos4 UART",
-- 
1.7.4.4
