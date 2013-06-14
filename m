From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Jun 2013 15:17:24 +0200
Subject: [PATCH] ARM: exynos: remove unused code
In-Reply-To: <51B791EF.9070904@samsung.com>
References: <51B791EF.9070904@samsung.com>
Message-ID: <201306141517.24287.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After exynos has been converted to DT-only booting by removing
most a lot of the ATAGS code, I had a closer look of what is
left. It turns out that a number of unused files are left in
the tree that can be removed along with about another quarter
of the remaining code in mach-exynos.

Specifically this includes:

* all board files
* all setup-*.c files
* dev-audio.c and dev-uart.c
* all code testing for of_have_populated_dt
* the eint_irqchip
* almost all the mach/irqs.h constants (the remaining ones
  are likely bugs)
* Most physical address constants. The remaining ones are
  either bugs or used for the iotable. Both can probably
  get removed in the long run.
* regs-usb-phy.h, which was already unused before
* A lot of code in plat-samsung/ can be made conditional
  on CONFIG_ATAGS, in particular now unused device
  definitions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Hi Kukjin,

Could you check the validity of this patch please?

I think we should apply it on top of your series. I've generated
the patch using 'git format-patch -D' for brevity, so be careful
to actually delete the unused files if you want to apply it to
a local branch on your side.

	Arnd

 arch/arm/Kconfig                                 |    1 -
 arch/arm/mach-exynos/Makefile                    |   14 -
 arch/arm/mach-exynos/common.c                    |  529 +--------
 arch/arm/mach-exynos/common.h                    |    5 +-
 arch/arm/mach-exynos/dev-audio.c                 |  254 ----
 arch/arm/mach-exynos/dev-uart.c                  |   55 -
 arch/arm/mach-exynos/firmware.c                  |   22 +-
 arch/arm/mach-exynos/include/mach/gpio.h         |  289 -----
 arch/arm/mach-exynos/include/mach/irqs.h         |  430 +------
 arch/arm/mach-exynos/include/mach/map.h          |  208 +---
 arch/arm/mach-exynos/include/mach/pm-core.h      |    5 +-
 arch/arm/mach-exynos/include/mach/regs-usb-phy.h |   74 --
 arch/arm/mach-exynos/mach-armlex4210.c           |  207 ----
 arch/arm/mach-exynos/mach-exynos4-dt.c           |   13 +-
 arch/arm/mach-exynos/mach-exynos5-dt.c           |    8 +-
 arch/arm/mach-exynos/mach-nuri.c                 | 1388 ----------------------
 arch/arm/mach-exynos/mach-origen.c               |  823 -------------
 arch/arm/mach-exynos/mach-smdk4x12.c             |  396 ------
 arch/arm/mach-exynos/mach-smdkv310.c             |  444 -------
 arch/arm/mach-exynos/mach-universal_c210.c       | 1159 ------------------
 arch/arm/mach-exynos/pm_domains.c                |   84 +-
 arch/arm/mach-exynos/setup-fimc.c                |   44 -
 arch/arm/mach-exynos/setup-fimd0.c               |   43 -
 arch/arm/mach-exynos/setup-i2c0.c                |   29 -
 arch/arm/mach-exynos/setup-i2c1.c                |   23 -
 arch/arm/mach-exynos/setup-i2c2.c                |   23 -
 arch/arm/mach-exynos/setup-i2c3.c                |   23 -
 arch/arm/mach-exynos/setup-i2c4.c                |   23 -
 arch/arm/mach-exynos/setup-i2c5.c                |   23 -
 arch/arm/mach-exynos/setup-i2c6.c                |   23 -
 arch/arm/mach-exynos/setup-i2c7.c                |   23 -
 arch/arm/mach-exynos/setup-keypad.c              |   36 -
 arch/arm/mach-exynos/setup-sdhci-gpio.c          |  152 ---
 arch/arm/mach-exynos/setup-spi.c                 |   45 -
 arch/arm/mach-exynos/setup-usb-phy.c             |  223 ----
 arch/arm/plat-samsung/Kconfig                    |    2 +-
 arch/arm/plat-samsung/Makefile                   |    7 +-
 arch/arm/plat-samsung/init.c                     |   11 +-
 arch/arm/plat-samsung/pm.c                       |    6 +-
 drivers/gpio/Kconfig                             |    4 +
 drivers/gpio/Makefile                            |    6 +-
 41 files changed, 68 insertions(+), 7109 deletions(-)


diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d462a38..f912265 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -794,7 +794,6 @@ config ARCH_EXYNOS
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_S3C_RTC if RTC_CLASS
-	select NEED_MACH_GPIO_H
 	select NEED_MACH_MEMORY_H
 	help
 	  Support for SAMSUNG's EXYNOS SoCs (EXYNOS4/5)
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 9811f87..9d19565 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -5,13 +5,6 @@
 #
 # Licensed under GPLv2
 
-obj-y				:=
-obj-m				:=
-obj-n				:=
-obj-				:=
-
-# Core
-
 obj-$(CONFIG_ARCH_EXYNOS)	+= common.o
 
 obj-$(CONFIG_PM)		+= pm.o
@@ -34,10 +27,3 @@ AFLAGS_exynos-smc.o		:=-Wa,-march=armv7-a$(plus_sec)
 
 obj-$(CONFIG_MACH_EXYNOS4_DT)		+= mach-exynos4-dt.o
 obj-$(CONFIG_MACH_EXYNOS5_DT)		+= mach-exynos5-dt.o
-
-# device support
-
-obj-y					+= dev-uart.o
-obj-$(CONFIG_ARCH_EXYNOS4)		+= dev-audio.o
-
-obj-$(CONFIG_ARCH_EXYNOS)		+= setup-i2c0.o
diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 9834357..ef0f545 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -38,23 +38,11 @@
 #include <asm/mach/irq.h>
 #include <asm/cacheflush.h>
 
-#include <mach/regs-irq.h>
+#include <mach/map.h>
 #include <mach/regs-pmu.h>
-#include <mach/regs-gpio.h>
-#include <mach/irqs.h>
 
 #include <plat/cpu.h>
-#include <plat/devs.h>
 #include <plat/pm.h>
-#include <plat/sdhci.h>
-#include <plat/gpio-cfg.h>
-#include <plat/adc-core.h>
-#include <plat/fb-core.h>
-#include <plat/fimc-core.h>
-#include <plat/iic-core.h>
-#include <plat/tv-core.h>
-#include <plat/spi-core.h>
-#include <plat/regs-serial.h>
 
 #include "common.h"
 #define L2_AUX_VAL 0x7C470001
@@ -69,31 +57,25 @@ static const char name_exynos5440[] = "EXYNOS5440";
 static void exynos4_map_io(void);
 static void exynos5_map_io(void);
 static void exynos5440_map_io(void);
-static void exynos4_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 static int exynos_init(void);
 
-unsigned long xxti_f = 0, xusbxti_f = 0;
-
 static struct cpu_table cpu_ids[] __initdata = {
 	{
 		.idcode		= EXYNOS4210_CPU_ID,
 		.idmask		= EXYNOS4_CPU_MASK,
 		.map_io		= exynos4_map_io,
-		.init_uarts	= exynos4_init_uarts,
 		.init		= exynos_init,
 		.name		= name_exynos4210,
 	}, {
 		.idcode		= EXYNOS4212_CPU_ID,
 		.idmask		= EXYNOS4_CPU_MASK,
 		.map_io		= exynos4_map_io,
-		.init_uarts	= exynos4_init_uarts,
 		.init		= exynos_init,
 		.name		= name_exynos4212,
 	}, {
 		.idcode		= EXYNOS4412_CPU_ID,
 		.idmask		= EXYNOS4_CPU_MASK,
 		.map_io		= exynos4_map_io,
-		.init_uarts	= exynos4_init_uarts,
 		.init		= exynos_init,
 		.name		= name_exynos4412,
 	}, {
@@ -113,15 +95,6 @@ static struct cpu_table cpu_ids[] __initdata = {
 
 /* Initial IO mappings */
 
-static struct map_desc exynos_iodesc[] __initdata = {
-	{
-		.virtual	= (unsigned long)S5P_VA_CHIPID,
-		.pfn		= __phys_to_pfn(EXYNOS_PA_CHIPID),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	},
-};
-
 static struct map_desc exynos4_iodesc[] __initdata = {
 	{
 		.virtual	= (unsigned long)S3C_VA_SYS,
@@ -304,13 +277,6 @@ static struct map_desc exynos5440_iodesc0[] __initdata = {
 	},
 };
 
-static struct samsung_pwm_variant exynos4_pwm_variant = {
-	.bits		= 32,
-	.div_base	= 0,
-	.has_tint_cstat	= true,
-	.tclk_mask	= 0,
-};
-
 void exynos4_restart(char mode, const char *cmd)
 {
 	__raw_writel(0x1, S5P_SWRESET);
@@ -353,7 +319,7 @@ void __init exynos_init_late(void)
 	exynos_pm_late_initcall();
 }
 
-int __init exynos_fdt_map_chipid(unsigned long node, const char *uname,
+static int __init exynos_fdt_map_chipid(unsigned long node, const char *uname,
 					int depth, void *data)
 {
 	struct map_desc iodesc;
@@ -382,18 +348,11 @@ int __init exynos_fdt_map_chipid(unsigned long node, const char *uname,
  * register the standard cpu IO areas
  */
 
-void __init exynos_init_io(struct map_desc *mach_desc, int size)
+void __init exynos_init_io(void)
 {
 	debug_ll_io_init();
 
-	if (initial_boot_params)
-		of_scan_flat_dt(exynos_fdt_map_chipid, NULL);
-	else
-		iotable_init(exynos_iodesc, ARRAY_SIZE(exynos_iodesc));
-
-	if (mach_desc)
-		iotable_init(mach_desc, size);
-
+	of_scan_flat_dt(exynos_fdt_map_chipid, NULL);
 	/* detect cpu id and rev. */
 	s5p_init_cpu(S5P_VA_CHIPID);
 
@@ -413,34 +372,6 @@ static void __init exynos4_map_io(void)
 		iotable_init(exynos4210_iodesc, ARRAY_SIZE(exynos4210_iodesc));
 	if (soc_is_exynos4212() || soc_is_exynos4412())
 		iotable_init(exynos4x12_iodesc, ARRAY_SIZE(exynos4x12_iodesc));
-
-	/* initialize device information early */
-	exynos4_default_sdhci0();
-	exynos4_default_sdhci1();
-	exynos4_default_sdhci2();
-	exynos4_default_sdhci3();
-
-	s3c_adc_setname("samsung-adc-v3");
-
-	s3c_fimc_setname(0, "exynos4-fimc");
-	s3c_fimc_setname(1, "exynos4-fimc");
-	s3c_fimc_setname(2, "exynos4-fimc");
-	s3c_fimc_setname(3, "exynos4-fimc");
-
-	s3c_sdhci_setname(0, "exynos4-sdhci");
-	s3c_sdhci_setname(1, "exynos4-sdhci");
-	s3c_sdhci_setname(2, "exynos4-sdhci");
-	s3c_sdhci_setname(3, "exynos4-sdhci");
-
-	/* The I2C bus controllers are directly compatible with s3c2440 */
-	s3c_i2c0_setname("s3c2440-i2c");
-	s3c_i2c1_setname("s3c2440-i2c");
-	s3c_i2c2_setname("s3c2440-i2c");
-
-	s5p_fb_setname(0, "exynos4-fb");
-	s5p_hdmi_setname("exynos4-hdmi");
-
-	s3c64xx_spi_setname("exynos4210-spi");
 }
 
 static void __init exynos5_map_io(void)
@@ -456,72 +387,13 @@ static void __init exynos5440_map_io(void)
 	iotable_init(exynos5440_iodesc0, ARRAY_SIZE(exynos5440_iodesc0));
 }
 
-void __init exynos_set_timer_source(u8 channels)
-{
-	exynos4_pwm_variant.output_mask = BIT(SAMSUNG_PWM_NUM) - 1;
-	exynos4_pwm_variant.output_mask &= ~channels;
-}
-
 void __init exynos_init_time(void)
 {
-	unsigned int timer_irqs[SAMSUNG_PWM_NUM] = {
-		EXYNOS4_IRQ_TIMER0_VIC, EXYNOS4_IRQ_TIMER1_VIC,
-		EXYNOS4_IRQ_TIMER2_VIC, EXYNOS4_IRQ_TIMER3_VIC,
-		EXYNOS4_IRQ_TIMER4_VIC,
-	};
-
-	if (of_have_populated_dt()) {
-		of_clk_init(NULL);
-		clocksource_of_init();
-	} else {
-		/* todo: remove after migrating legacy E4 platforms to dt */
-#ifdef CONFIG_ARCH_EXYNOS4
-		exynos4_clk_init(NULL, !soc_is_exynos4210(), S5P_VA_CMU, readl(S5P_VA_CHIPID + 8) & 1);
-		exynos4_clk_register_fixed_ext(xxti_f, xusbxti_f);
-#endif
-#ifdef CONFIG_CLKSRC_SAMSUNG_PWM
-		if (soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_0)
-			samsung_pwm_clocksource_init(S3C_VA_TIMER,
-					timer_irqs, &exynos4_pwm_variant);
-		else
-#endif
-			mct_init(S5P_VA_SYSTIMER, EXYNOS4_IRQ_MCT_G0,
-					EXYNOS4_IRQ_MCT_L0, EXYNOS4_IRQ_MCT_L1);
-	}
-}
-
-static unsigned int max_combiner_nr(void)
-{
-	if (soc_is_exynos5250())
-		return EXYNOS5_MAX_COMBINER_NR;
-	else if (soc_is_exynos4412())
-		return EXYNOS4412_MAX_COMBINER_NR;
-	else if (soc_is_exynos4212())
-		return EXYNOS4212_MAX_COMBINER_NR;
-	else
-		return EXYNOS4210_MAX_COMBINER_NR;
-}
-
-
-void __init exynos4_init_irq(void)
-{
-	unsigned int gic_bank_offset;
-
-	gic_bank_offset = soc_is_exynos4412() ? 0x4000 : 0x8000;
-
-	if (!of_have_populated_dt())
-		gic_init_bases(0, IRQ_PPI(0), S5P_VA_GIC_DIST, S5P_VA_GIC_CPU, gic_bank_offset, NULL);
-	else
-		irqchip_init();
-
-	if (!of_have_populated_dt())
-		combiner_init(S5P_VA_COMBINER_BASE, NULL,
-			      max_combiner_nr(), COMBINER_IRQ(0, 0));
-
-	gic_arch_extn.irq_set_wake = s3c_irq_wake;
+	of_clk_init(NULL);
+	clocksource_of_init();
 }
 
-void __init exynos5_init_irq(void)
+void __init exynos_init_irq(void)
 {
 	irqchip_init();
 	gic_arch_extn.irq_set_wake = s3c_irq_wake;
@@ -542,7 +414,6 @@ static int __init exynos_core_init(void)
 }
 core_initcall(exynos_core_init);
 
-#ifdef CONFIG_CACHE_L2X0
 static int __init exynos4_l2x0_cache_init(void)
 {
 	int ret;
@@ -554,47 +425,10 @@ static int __init exynos4_l2x0_cache_init(void)
 	if (!ret) {
 		l2x0_regs_phys = virt_to_phys(&l2x0_saved_regs);
 		clean_dcache_area(&l2x0_regs_phys, sizeof(unsigned long));
-		return 0;
 	}
-
-	if (!(__raw_readl(S5P_VA_L2CC + L2X0_CTRL) & 0x1)) {
-		l2x0_saved_regs.phy_base = EXYNOS4_PA_L2CC;
-		/* TAG, Data Latency Control: 2 cycles */
-		l2x0_saved_regs.tag_latency = 0x110;
-
-		if (soc_is_exynos4212() || soc_is_exynos4412())
-			l2x0_saved_regs.data_latency = 0x120;
-		else
-			l2x0_saved_regs.data_latency = 0x110;
-
-		l2x0_saved_regs.prefetch_ctrl = 0x30000007;
-		l2x0_saved_regs.pwr_ctrl =
-			(L2X0_DYNAMIC_CLK_GATING_EN | L2X0_STNDBY_MODE_EN);
-
-		l2x0_regs_phys = virt_to_phys(&l2x0_saved_regs);
-
-		__raw_writel(l2x0_saved_regs.tag_latency,
-				S5P_VA_L2CC + L2X0_TAG_LATENCY_CTRL);
-		__raw_writel(l2x0_saved_regs.data_latency,
-				S5P_VA_L2CC + L2X0_DATA_LATENCY_CTRL);
-
-		/* L2X0 Prefetch Control */
-		__raw_writel(l2x0_saved_regs.prefetch_ctrl,
-				S5P_VA_L2CC + L2X0_PREFETCH_CTRL);
-
-		/* L2X0 Power Control */
-		__raw_writel(l2x0_saved_regs.pwr_ctrl,
-				S5P_VA_L2CC + L2X0_POWER_CTRL);
-
-		clean_dcache_area(&l2x0_regs_phys, sizeof(unsigned long));
-		clean_dcache_area(&l2x0_saved_regs, sizeof(struct l2x0_regs));
-	}
-
-	l2x0_init(S5P_VA_L2CC, L2_AUX_VAL, L2_AUX_MASK);
-	return 0;
+	return ret;
 }
 early_initcall(exynos4_l2x0_cache_init);
-#endif
 
 static int __init exynos_init(void)
 {
@@ -602,350 +436,3 @@ static int __init exynos_init(void)
 
 	return device_register(&exynos4_dev);
 }
-
-/* uart registration process */
-
-static void __init exynos4_init_uarts(struct s3c2410_uartcfg *cfg, int no)
-{
-	struct s3c2410_uartcfg *tcfg = cfg;
-	u32 ucnt;
-
-	for (ucnt = 0; ucnt < no; ucnt++, tcfg++)
-		tcfg->has_fracval = 1;
-
-	s3c24xx_init_uartdevs("exynos4210-uart", exynos4_uart_resources, cfg, no);
-}
-
-static void __iomem *exynos_eint_base;
-
-static DEFINE_SPINLOCK(eint_lock);
-
-static unsigned int eint0_15_data[16];
-
-static inline int exynos4_irq_to_gpio(unsigned int irq)
-{
-	if (irq < IRQ_EINT(0))
-		return -EINVAL;
-
-	irq -= IRQ_EINT(0);
-	if (irq < 8)
-		return EXYNOS4_GPX0(irq);
-
-	irq -= 8;
-	if (irq < 8)
-		return EXYNOS4_GPX1(irq);
-
-	irq -= 8;
-	if (irq < 8)
-		return EXYNOS4_GPX2(irq);
-
-	irq -= 8;
-	if (irq < 8)
-		return EXYNOS4_GPX3(irq);
-
-	return -EINVAL;
-}
-
-static inline int exynos5_irq_to_gpio(unsigned int irq)
-{
-	if (irq < IRQ_EINT(0))
-		return -EINVAL;
-
-	irq -= IRQ_EINT(0);
-	if (irq < 8)
-		return EXYNOS5_GPX0(irq);
-
-	irq -= 8;
-	if (irq < 8)
-		return EXYNOS5_GPX1(irq);
-
-	irq -= 8;
-	if (irq < 8)
-		return EXYNOS5_GPX2(irq);
-
-	irq -= 8;
-	if (irq < 8)
-		return EXYNOS5_GPX3(irq);
-
-	return -EINVAL;
-}
-
-static unsigned int exynos4_eint0_15_src_int[16] = {
-	EXYNOS4_IRQ_EINT0,
-	EXYNOS4_IRQ_EINT1,
-	EXYNOS4_IRQ_EINT2,
-	EXYNOS4_IRQ_EINT3,
-	EXYNOS4_IRQ_EINT4,
-	EXYNOS4_IRQ_EINT5,
-	EXYNOS4_IRQ_EINT6,
-	EXYNOS4_IRQ_EINT7,
-	EXYNOS4_IRQ_EINT8,
-	EXYNOS4_IRQ_EINT9,
-	EXYNOS4_IRQ_EINT10,
-	EXYNOS4_IRQ_EINT11,
-	EXYNOS4_IRQ_EINT12,
-	EXYNOS4_IRQ_EINT13,
-	EXYNOS4_IRQ_EINT14,
-	EXYNOS4_IRQ_EINT15,
-};
-
-static unsigned int exynos5_eint0_15_src_int[16] = {
-	EXYNOS5_IRQ_EINT0,
-	EXYNOS5_IRQ_EINT1,
-	EXYNOS5_IRQ_EINT2,
-	EXYNOS5_IRQ_EINT3,
-	EXYNOS5_IRQ_EINT4,
-	EXYNOS5_IRQ_EINT5,
-	EXYNOS5_IRQ_EINT6,
-	EXYNOS5_IRQ_EINT7,
-	EXYNOS5_IRQ_EINT8,
-	EXYNOS5_IRQ_EINT9,
-	EXYNOS5_IRQ_EINT10,
-	EXYNOS5_IRQ_EINT11,
-	EXYNOS5_IRQ_EINT12,
-	EXYNOS5_IRQ_EINT13,
-	EXYNOS5_IRQ_EINT14,
-	EXYNOS5_IRQ_EINT15,
-};
-static inline void exynos_irq_eint_mask(struct irq_data *data)
-{
-	u32 mask;
-
-	spin_lock(&eint_lock);
-	mask = __raw_readl(EINT_MASK(exynos_eint_base, data->irq));
-	mask |= EINT_OFFSET_BIT(data->irq);
-	__raw_writel(mask, EINT_MASK(exynos_eint_base, data->irq));
-	spin_unlock(&eint_lock);
-}
-
-static void exynos_irq_eint_unmask(struct irq_data *data)
-{
-	u32 mask;
-
-	spin_lock(&eint_lock);
-	mask = __raw_readl(EINT_MASK(exynos_eint_base, data->irq));
-	mask &= ~(EINT_OFFSET_BIT(data->irq));
-	__raw_writel(mask, EINT_MASK(exynos_eint_base, data->irq));
-	spin_unlock(&eint_lock);
-}
-
-static inline void exynos_irq_eint_ack(struct irq_data *data)
-{
-	__raw_writel(EINT_OFFSET_BIT(data->irq),
-		     EINT_PEND(exynos_eint_base, data->irq));
-}
-
-static void exynos_irq_eint_maskack(struct irq_data *data)
-{
-	exynos_irq_eint_mask(data);
-	exynos_irq_eint_ack(data);
-}
-
-static int exynos_irq_eint_set_type(struct irq_data *data, unsigned int type)
-{
-	int offs = EINT_OFFSET(data->irq);
-	int shift;
-	u32 ctrl, mask;
-	u32 newvalue = 0;
-
-	switch (type) {
-	case IRQ_TYPE_EDGE_RISING:
-		newvalue = S5P_IRQ_TYPE_EDGE_RISING;
-		break;
-
-	case IRQ_TYPE_EDGE_FALLING:
-		newvalue = S5P_IRQ_TYPE_EDGE_FALLING;
-		break;
-
-	case IRQ_TYPE_EDGE_BOTH:
-		newvalue = S5P_IRQ_TYPE_EDGE_BOTH;
-		break;
-
-	case IRQ_TYPE_LEVEL_LOW:
-		newvalue = S5P_IRQ_TYPE_LEVEL_LOW;
-		break;
-
-	case IRQ_TYPE_LEVEL_HIGH:
-		newvalue = S5P_IRQ_TYPE_LEVEL_HIGH;
-		break;
-
-	default:
-		printk(KERN_ERR "No such irq type %d", type);
-		return -EINVAL;
-	}
-
-	shift = (offs & 0x7) * 4;
-	mask = 0x7 << shift;
-
-	spin_lock(&eint_lock);
-	ctrl = __raw_readl(EINT_CON(exynos_eint_base, data->irq));
-	ctrl &= ~mask;
-	ctrl |= newvalue << shift;
-	__raw_writel(ctrl, EINT_CON(exynos_eint_base, data->irq));
-	spin_unlock(&eint_lock);
-
-	if (soc_is_exynos5250())
-		s3c_gpio_cfgpin(exynos5_irq_to_gpio(data->irq), S3C_GPIO_SFN(0xf));
-	else
-		s3c_gpio_cfgpin(exynos4_irq_to_gpio(data->irq), S3C_GPIO_SFN(0xf));
-
-	return 0;
-}
-
-static struct irq_chip exynos_irq_eint = {
-	.name		= "exynos-eint",
-	.irq_mask	= exynos_irq_eint_mask,
-	.irq_unmask	= exynos_irq_eint_unmask,
-	.irq_mask_ack	= exynos_irq_eint_maskack,
-	.irq_ack	= exynos_irq_eint_ack,
-	.irq_set_type	= exynos_irq_eint_set_type,
-#ifdef CONFIG_PM
-	.irq_set_wake	= s3c_irqext_wake,
-#endif
-};
-
-/*
- * exynos4_irq_demux_eint
- *
- * This function demuxes the IRQ from from EINTs 16 to 31.
- * It is designed to be inlined into the specific handler
- * s5p_irq_demux_eintX_Y.
- *
- * Each EINT pend/mask registers handle eight of them.
- */
-static inline void exynos_irq_demux_eint(unsigned int start)
-{
-	unsigned int irq;
-
-	u32 status = __raw_readl(EINT_PEND(exynos_eint_base, start));
-	u32 mask = __raw_readl(EINT_MASK(exynos_eint_base, start));
-
-	status &= ~mask;
-	status &= 0xff;
-
-	while (status) {
-		irq = fls(status) - 1;
-		generic_handle_irq(irq + start);
-		status &= ~(1 << irq);
-	}
-}
-
-static void exynos_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
-{
-	struct irq_chip *chip = irq_get_chip(irq);
-	chained_irq_enter(chip, desc);
-	exynos_irq_demux_eint(IRQ_EINT(16));
-	exynos_irq_demux_eint(IRQ_EINT(24));
-	chained_irq_exit(chip, desc);
-}
-
-static void exynos_irq_eint0_15(unsigned int irq, struct irq_desc *desc)
-{
-	u32 *irq_data = irq_get_handler_data(irq);
-	struct irq_chip *chip = irq_get_chip(irq);
-
-	chained_irq_enter(chip, desc);
-	generic_handle_irq(*irq_data);
-	chained_irq_exit(chip, desc);
-}
-
-static int __init exynos_init_irq_eint(void)
-{
-	int irq;
-
-#ifdef CONFIG_PINCTRL_SAMSUNG
-	/*
-	 * The Samsung pinctrl driver provides an integrated gpio/pinmux/pinconf
-	 * functionality along with support for external gpio and wakeup
-	 * interrupts. If the samsung pinctrl driver is enabled and includes
-	 * the wakeup interrupt support, then the setting up external wakeup
-	 * interrupts here can be skipped. This check here is temporary to
-	 * allow exynos4 platforms that do not use Samsung pinctrl driver to
-	 * co-exist with platforms that do. When all of the Samsung Exynos4
-	 * platforms switch over to using the pinctrl driver, the wakeup
-	 * interrupt support code here can be completely removed.
-	 */
-	static const struct of_device_id exynos_pinctrl_ids[] = {
-		{ .compatible = "samsung,exynos4210-pinctrl", },
-		{ .compatible = "samsung,exynos4x12-pinctrl", },
-		{ .compatible = "samsung,exynos5250-pinctrl", },
-	};
-	struct device_node *pctrl_np, *wkup_np;
-	const char *wkup_compat = "samsung,exynos4210-wakeup-eint";
-
-	for_each_matching_node(pctrl_np, exynos_pinctrl_ids) {
-		if (of_device_is_available(pctrl_np)) {
-			wkup_np = of_find_compatible_node(pctrl_np, NULL,
-							wkup_compat);
-			if (wkup_np)
-				return -ENODEV;
-		}
-	}
-#endif
-	if (soc_is_exynos5440())
-		return 0;
-
-	if (soc_is_exynos5250())
-		exynos_eint_base = ioremap(EXYNOS5_PA_GPIO1, SZ_4K);
-	else
-		exynos_eint_base = ioremap(EXYNOS4_PA_GPIO2, SZ_4K);
-
-	if (exynos_eint_base == NULL) {
-		pr_err("unable to ioremap for EINT base address\n");
-		return -ENOMEM;
-	}
-
-	for (irq = 0 ; irq <= 31 ; irq++) {
-		irq_set_chip_and_handler(IRQ_EINT(irq), &exynos_irq_eint,
-					 handle_level_irq);
-		set_irq_flags(IRQ_EINT(irq), IRQF_VALID);
-	}
-
-	irq_set_chained_handler(EXYNOS_IRQ_EINT16_31, exynos_irq_demux_eint16_31);
-
-	for (irq = 0 ; irq <= 15 ; irq++) {
-		eint0_15_data[irq] = IRQ_EINT(irq);
-
-		if (soc_is_exynos5250()) {
-			irq_set_handler_data(exynos5_eint0_15_src_int[irq],
-					     &eint0_15_data[irq]);
-			irq_set_chained_handler(exynos5_eint0_15_src_int[irq],
-						exynos_irq_eint0_15);
-		} else {
-			irq_set_handler_data(exynos4_eint0_15_src_int[irq],
-					     &eint0_15_data[irq]);
-			irq_set_chained_handler(exynos4_eint0_15_src_int[irq],
-						exynos_irq_eint0_15);
-		}
-	}
-
-	return 0;
-}
-arch_initcall(exynos_init_irq_eint);
-
-static struct resource exynos4_pmu_resource[] = {
-	DEFINE_RES_IRQ(EXYNOS4_IRQ_PMU),
-	DEFINE_RES_IRQ(EXYNOS4_IRQ_PMU_CPU1),
-#if defined(CONFIG_SOC_EXYNOS4412)
-	DEFINE_RES_IRQ(EXYNOS4_IRQ_PMU_CPU2),
-	DEFINE_RES_IRQ(EXYNOS4_IRQ_PMU_CPU3),
-#endif
-};
-
-static struct platform_device exynos4_device_pmu = {
-	.name		= "arm-pmu",
-	.num_resources	= ARRAY_SIZE(exynos4_pmu_resource),
-	.resource	= exynos4_pmu_resource,
-};
-
-static int __init exynos_armpmu_init(void)
-{
-	if (!of_have_populated_dt()) {
-		if (soc_is_exynos4210() || soc_is_exynos4212())
-			exynos4_device_pmu.num_resources = 2;
-		platform_device_register(&exynos4_device_pmu);
-	}
-
-	return 0;
-}
-arch_initcall(exynos_armpmu_init);
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 11fc1e2..4410885 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -19,9 +19,8 @@ void exynos_init_time(void);
 extern unsigned long xxti_f, xusbxti_f;
 
 struct map_desc;
-void exynos_init_io(struct map_desc *mach_desc, int size);
-void exynos4_init_irq(void);
-void exynos5_init_irq(void);
+void exynos_init_io(void);
+void exynos_init_irq(void);
 void exynos4_restart(char mode, const char *cmd);
 void exynos5_restart(char mode, const char *cmd);
 void exynos_init_late(void);
diff --git a/arch/arm/mach-exynos/dev-audio.c b/arch/arm/mach-exynos/dev-audio.c
deleted file mode 100644
index c662c89..0000000
diff --git a/arch/arm/mach-exynos/dev-uart.c b/arch/arm/mach-exynos/dev-uart.c
deleted file mode 100644
index c48aff0..0000000
diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
index ed11f10..932129e 100644
--- a/arch/arm/mach-exynos/firmware.c
+++ b/arch/arm/mach-exynos/firmware.c
@@ -48,20 +48,18 @@ static const struct firmware_ops exynos_firmware_ops = {
 
 void __init exynos_firmware_init(void)
 {
-	if (of_have_populated_dt()) {
-		struct device_node *nd;
-		const __be32 *addr;
+	struct device_node *nd;
+	const __be32 *addr;
 
-		nd = of_find_compatible_node(NULL, NULL,
-						"samsung,secure-firmware");
-		if (!nd)
-			return;
+	nd = of_find_compatible_node(NULL, NULL,
+					"samsung,secure-firmware");
+	if (!nd)
+		return;
 
-		addr = of_get_address(nd, 0, NULL, NULL);
-		if (!addr) {
-			pr_err("%s: No address specified.\n", __func__);
-			return;
-		}
+	addr = of_get_address(nd, 0, NULL, NULL);
+	if (!addr) {
+		pr_err("%s: No address specified.\n", __func__);
+		return;
 	}
 
 	pr_info("Running under secure firmware.\n");
diff --git a/arch/arm/mach-exynos/include/mach/gpio.h b/arch/arm/mach-exynos/include/mach/gpio.h
deleted file mode 100644
index eb24f1e..0000000
diff --git a/arch/arm/mach-exynos/include/mach/irqs.h b/arch/arm/mach-exynos/include/mach/irqs.h
index c72f59d..67d2ee4 100644
--- a/arch/arm/mach-exynos/include/mach/irqs.h
+++ b/arch/arm/mach-exynos/include/mach/irqs.h
@@ -22,441 +22,30 @@
 
 #define IRQ_SPI(x)			(x + 32)
 
-/* COMBINER */
-
-#define MAX_IRQ_IN_COMBINER		8
-#define COMBINER_GROUP(x)		((x) * MAX_IRQ_IN_COMBINER + IRQ_SPI(128))
-#define COMBINER_IRQ(x, y)		(COMBINER_GROUP(x) + y)
-
-/* For EXYNOS4 and EXYNOS5 */
+/* FIXME: remove these so we can turn on SPARSE_IRQ */
 
-#define EXYNOS_IRQ_EINT16_31		IRQ_SPI(32)
-
-/* For EXYNOS4 SoCs */
-
-#define EXYNOS4_IRQ_EINT0		IRQ_SPI(16)
-#define EXYNOS4_IRQ_EINT1		IRQ_SPI(17)
-#define EXYNOS4_IRQ_EINT2		IRQ_SPI(18)
-#define EXYNOS4_IRQ_EINT3		IRQ_SPI(19)
-#define EXYNOS4_IRQ_EINT4		IRQ_SPI(20)
-#define EXYNOS4_IRQ_EINT5		IRQ_SPI(21)
-#define EXYNOS4_IRQ_EINT6		IRQ_SPI(22)
-#define EXYNOS4_IRQ_EINT7		IRQ_SPI(23)
-#define EXYNOS4_IRQ_EINT8		IRQ_SPI(24)
-#define EXYNOS4_IRQ_EINT9		IRQ_SPI(25)
-#define EXYNOS4_IRQ_EINT10		IRQ_SPI(26)
-#define EXYNOS4_IRQ_EINT11		IRQ_SPI(27)
-#define EXYNOS4_IRQ_EINT12		IRQ_SPI(28)
-#define EXYNOS4_IRQ_EINT13		IRQ_SPI(29)
-#define EXYNOS4_IRQ_EINT14		IRQ_SPI(30)
-#define EXYNOS4_IRQ_EINT15		IRQ_SPI(31)
-
-#define EXYNOS4_IRQ_MDMA0		IRQ_SPI(33)
-#define EXYNOS4_IRQ_MDMA1		IRQ_SPI(34)
-#define EXYNOS4_IRQ_PDMA0		IRQ_SPI(35)
-#define EXYNOS4_IRQ_PDMA1		IRQ_SPI(36)
-#define EXYNOS4_IRQ_TIMER0_VIC		IRQ_SPI(37)
-#define EXYNOS4_IRQ_TIMER1_VIC		IRQ_SPI(38)
-#define EXYNOS4_IRQ_TIMER2_VIC		IRQ_SPI(39)
-#define EXYNOS4_IRQ_TIMER3_VIC		IRQ_SPI(40)
-#define EXYNOS4_IRQ_TIMER4_VIC		IRQ_SPI(41)
-#define EXYNOS4_IRQ_MCT_L0		IRQ_SPI(42)
-#define EXYNOS4_IRQ_WDT			IRQ_SPI(43)
 #define EXYNOS4_IRQ_RTC_ALARM		IRQ_SPI(44)
 #define EXYNOS4_IRQ_RTC_TIC		IRQ_SPI(45)
-#define EXYNOS4_IRQ_GPIO_XB		IRQ_SPI(46)
-#define EXYNOS4_IRQ_GPIO_XA		IRQ_SPI(47)
-#define EXYNOS4_IRQ_MCT_L1		IRQ_SPI(48)
-
-#define EXYNOS4_IRQ_UART0		IRQ_SPI(52)
-#define EXYNOS4_IRQ_UART1		IRQ_SPI(53)
-#define EXYNOS4_IRQ_UART2		IRQ_SPI(54)
-#define EXYNOS4_IRQ_UART3		IRQ_SPI(55)
-#define EXYNOS4_IRQ_UART4		IRQ_SPI(56)
-#define EXYNOS4_IRQ_MCT_G0		IRQ_SPI(57)
-#define EXYNOS4_IRQ_IIC			IRQ_SPI(58)
-#define EXYNOS4_IRQ_IIC1		IRQ_SPI(59)
-#define EXYNOS4_IRQ_IIC2		IRQ_SPI(60)
-#define EXYNOS4_IRQ_IIC3		IRQ_SPI(61)
-#define EXYNOS4_IRQ_IIC4		IRQ_SPI(62)
-#define EXYNOS4_IRQ_IIC5		IRQ_SPI(63)
-#define EXYNOS4_IRQ_IIC6		IRQ_SPI(64)
-#define EXYNOS4_IRQ_IIC7		IRQ_SPI(65)
-#define EXYNOS4_IRQ_SPI0		IRQ_SPI(66)
-#define EXYNOS4_IRQ_SPI1		IRQ_SPI(67)
-#define EXYNOS4_IRQ_SPI2		IRQ_SPI(68)
-
-#define EXYNOS4_IRQ_USB_HOST		IRQ_SPI(70)
-#define EXYNOS4_IRQ_USB_HSOTG		IRQ_SPI(71)
-#define EXYNOS4_IRQ_MODEM_IF		IRQ_SPI(72)
-#define EXYNOS4_IRQ_HSMMC0		IRQ_SPI(73)
-#define EXYNOS4_IRQ_HSMMC1		IRQ_SPI(74)
-#define EXYNOS4_IRQ_HSMMC2		IRQ_SPI(75)
-#define EXYNOS4_IRQ_HSMMC3		IRQ_SPI(76)
-#define EXYNOS4_IRQ_DWMCI		IRQ_SPI(77)
 
-#define EXYNOS4_IRQ_MIPI_CSIS0		IRQ_SPI(78)
-#define EXYNOS4_IRQ_MIPI_CSIS1		IRQ_SPI(80)
-
-#define EXYNOS4_IRQ_ONENAND_AUDI	IRQ_SPI(82)
-#define EXYNOS4_IRQ_ROTATOR		IRQ_SPI(83)
-#define EXYNOS4_IRQ_FIMC0		IRQ_SPI(84)
-#define EXYNOS4_IRQ_FIMC1		IRQ_SPI(85)
-#define EXYNOS4_IRQ_FIMC2		IRQ_SPI(86)
-#define EXYNOS4_IRQ_FIMC3		IRQ_SPI(87)
-#define EXYNOS4_IRQ_JPEG		IRQ_SPI(88)
-#define EXYNOS4_IRQ_2D			IRQ_SPI(89)
-#define EXYNOS4_IRQ_PCIE		IRQ_SPI(90)
+#define EXYNOS5_IRQ_RTC_ALARM		IRQ_SPI(43)
+#define EXYNOS5_IRQ_RTC_TIC		IRQ_SPI(44)
 
-#define EXYNOS4_IRQ_MIXER		IRQ_SPI(91)
-#define EXYNOS4_IRQ_HDMI		IRQ_SPI(92)
-#define EXYNOS4_IRQ_IIC_HDMIPHY		IRQ_SPI(93)
 #define EXYNOS4_IRQ_MFC			IRQ_SPI(94)
-#define EXYNOS4_IRQ_SDO			IRQ_SPI(95)
-
-#define EXYNOS4_IRQ_AUDIO_SS		IRQ_SPI(96)
-#define EXYNOS4_IRQ_I2S0		IRQ_SPI(97)
-#define EXYNOS4_IRQ_I2S1		IRQ_SPI(98)
-#define EXYNOS4_IRQ_I2S2		IRQ_SPI(99)
-#define EXYNOS4_IRQ_AC97		IRQ_SPI(100)
-
-#define EXYNOS4_IRQ_SPDIF		IRQ_SPI(104)
-#define EXYNOS4_IRQ_ADC0		IRQ_SPI(105)
-#define EXYNOS4_IRQ_PEN0		IRQ_SPI(106)
-#define EXYNOS4_IRQ_ADC1		IRQ_SPI(107)
-#define EXYNOS4_IRQ_PEN1		IRQ_SPI(108)
-#define EXYNOS4_IRQ_KEYPAD		IRQ_SPI(109)
-#define EXYNOS4_IRQ_POWER_PMU		IRQ_SPI(110)
-#define EXYNOS4_IRQ_GPS			IRQ_SPI(111)
-#define EXYNOS4_IRQ_INTFEEDCTRL_SSS	IRQ_SPI(112)
-#define EXYNOS4_IRQ_SLIMBUS		IRQ_SPI(113)
-
-#define EXYNOS4_IRQ_TSI			IRQ_SPI(115)
-#define EXYNOS4_IRQ_SATA		IRQ_SPI(116)
-
-#define EXYNOS4_IRQ_PMU			COMBINER_IRQ(2, 2)
-#define EXYNOS4_IRQ_PMU_CPU1		COMBINER_IRQ(3, 2)
-#define EXYNOS4_IRQ_PMU_CPU2		COMBINER_IRQ(18, 2)
-#define EXYNOS4_IRQ_PMU_CPU3		COMBINER_IRQ(19, 2)
-
-#define EXYNOS4_IRQ_TMU_TRIG0		COMBINER_IRQ(2, 4)
-#define EXYNOS4_IRQ_TMU_TRIG1		COMBINER_IRQ(3, 4)
-
-#define EXYNOS4_IRQ_SYSMMU_MDMA0_0	COMBINER_IRQ(4, 0)
-#define EXYNOS4_IRQ_SYSMMU_SSS_0	COMBINER_IRQ(4, 1)
-#define EXYNOS4_IRQ_SYSMMU_FIMC0_0	COMBINER_IRQ(4, 2)
-#define EXYNOS4_IRQ_SYSMMU_FIMC1_0	COMBINER_IRQ(4, 3)
-#define EXYNOS4_IRQ_SYSMMU_FIMC2_0	COMBINER_IRQ(4, 4)
-#define EXYNOS4_IRQ_SYSMMU_FIMC3_0	COMBINER_IRQ(4, 5)
-#define EXYNOS4_IRQ_SYSMMU_JPEG_0	COMBINER_IRQ(4, 6)
-#define EXYNOS4_IRQ_SYSMMU_2D_0		COMBINER_IRQ(4, 7)
-
-#define EXYNOS4_IRQ_SYSMMU_ROTATOR_0	COMBINER_IRQ(5, 0)
-#define EXYNOS4_IRQ_SYSMMU_MDMA1_0	COMBINER_IRQ(5, 1)
-#define EXYNOS4_IRQ_SYSMMU_LCD0_M0_0	COMBINER_IRQ(5, 2)
-#define EXYNOS4_IRQ_SYSMMU_LCD1_M1_0	COMBINER_IRQ(5, 3)
-#define EXYNOS4_IRQ_SYSMMU_TV_M0_0	COMBINER_IRQ(5, 4)
-#define EXYNOS4_IRQ_SYSMMU_MFC_M0_0	COMBINER_IRQ(5, 5)
-#define EXYNOS4_IRQ_SYSMMU_MFC_M1_0	COMBINER_IRQ(5, 6)
-#define EXYNOS4_IRQ_SYSMMU_PCIE_0	COMBINER_IRQ(5, 7)
+#define IRQ_MFC				EXYNOS4_IRQ_MFC
 
-#define EXYNOS4_IRQ_SYSMMU_FIMC_LITE0_0	COMBINER_IRQ(16, 0)
-#define EXYNOS4_IRQ_SYSMMU_FIMC_LITE1_0	COMBINER_IRQ(16, 1)
-#define EXYNOS4_IRQ_SYSMMU_FIMC_ISP_0	COMBINER_IRQ(16, 2)
-#define EXYNOS4_IRQ_SYSMMU_FIMC_DRC_0	COMBINER_IRQ(16, 3)
-#define EXYNOS4_IRQ_SYSMMU_FIMC_FD_0	COMBINER_IRQ(16, 4)
-#define EXYNOS4_IRQ_SYSMMU_FIMC_CX_0	COMBINER_IRQ(16, 5)
+/* COMBINER */
 
-#define EXYNOS4_IRQ_FIMD0_FIFO		COMBINER_IRQ(11, 0)
-#define EXYNOS4_IRQ_FIMD0_VSYNC		COMBINER_IRQ(11, 1)
-#define EXYNOS4_IRQ_FIMD0_SYSTEM	COMBINER_IRQ(11, 2)
+#define MAX_IRQ_IN_COMBINER		8
+#define COMBINER_GROUP(x)		((x) * MAX_IRQ_IN_COMBINER + IRQ_SPI(128))
+#define COMBINER_IRQ(x, y)		(COMBINER_GROUP(x) + y)
 
 #define EXYNOS4210_MAX_COMBINER_NR	16
 #define EXYNOS4212_MAX_COMBINER_NR	18
 #define EXYNOS4412_MAX_COMBINER_NR	20
-#define EXYNOS4_MAX_COMBINER_NR		EXYNOS4412_MAX_COMBINER_NR
-
-#define EXYNOS4_IRQ_GPIO1_NR_GROUPS	16
-#define EXYNOS4_IRQ_GPIO2_NR_GROUPS	9
-
-/*
- * For Compatibility:
- * the default is for EXYNOS4, and
- * for exynos5, should be re-mapped@function
- */
-
-#define IRQ_TIMER0_VIC			EXYNOS4_IRQ_TIMER0_VIC
-#define IRQ_TIMER1_VIC			EXYNOS4_IRQ_TIMER1_VIC
-#define IRQ_TIMER2_VIC			EXYNOS4_IRQ_TIMER2_VIC
-#define IRQ_TIMER3_VIC			EXYNOS4_IRQ_TIMER3_VIC
-#define IRQ_TIMER4_VIC			EXYNOS4_IRQ_TIMER4_VIC
-
-#define IRQ_WDT				EXYNOS4_IRQ_WDT
-#define IRQ_RTC_ALARM			EXYNOS4_IRQ_RTC_ALARM
-#define IRQ_RTC_TIC			EXYNOS4_IRQ_RTC_TIC
-#define IRQ_GPIO_XB			EXYNOS4_IRQ_GPIO_XB
-#define IRQ_GPIO_XA			EXYNOS4_IRQ_GPIO_XA
-
-#define IRQ_IIC				EXYNOS4_IRQ_IIC
-#define IRQ_IIC1			EXYNOS4_IRQ_IIC1
-#define IRQ_IIC3			EXYNOS4_IRQ_IIC3
-#define IRQ_IIC5			EXYNOS4_IRQ_IIC5
-#define IRQ_IIC6			EXYNOS4_IRQ_IIC6
-#define IRQ_IIC7			EXYNOS4_IRQ_IIC7
-
-#define IRQ_SPI0			EXYNOS4_IRQ_SPI0
-#define IRQ_SPI1			EXYNOS4_IRQ_SPI1
-#define IRQ_SPI2			EXYNOS4_IRQ_SPI2
-
-#define IRQ_USB_HOST			EXYNOS4_IRQ_USB_HOST
-#define IRQ_OTG				EXYNOS4_IRQ_USB_HSOTG
-
-#define IRQ_HSMMC0			EXYNOS4_IRQ_HSMMC0
-#define IRQ_HSMMC1			EXYNOS4_IRQ_HSMMC1
-#define IRQ_HSMMC2			EXYNOS4_IRQ_HSMMC2
-#define IRQ_HSMMC3			EXYNOS4_IRQ_HSMMC3
-
-#define IRQ_MIPI_CSIS0			EXYNOS4_IRQ_MIPI_CSIS0
-
-#define IRQ_ONENAND_AUDI		EXYNOS4_IRQ_ONENAND_AUDI
-
-#define IRQ_FIMC0			EXYNOS4_IRQ_FIMC0
-#define IRQ_FIMC1			EXYNOS4_IRQ_FIMC1
-#define IRQ_FIMC2			EXYNOS4_IRQ_FIMC2
-#define IRQ_FIMC3			EXYNOS4_IRQ_FIMC3
-#define IRQ_JPEG			EXYNOS4_IRQ_JPEG
-#define IRQ_2D				EXYNOS4_IRQ_2D
-
-#define IRQ_MIXER			EXYNOS4_IRQ_MIXER
-#define IRQ_HDMI			EXYNOS4_IRQ_HDMI
-#define IRQ_IIC_HDMIPHY			EXYNOS4_IRQ_IIC_HDMIPHY
-#define IRQ_MFC				EXYNOS4_IRQ_MFC
-#define IRQ_SDO				EXYNOS4_IRQ_SDO
-
-#define IRQ_I2S0			EXYNOS4_IRQ_I2S0
-
-#define IRQ_ADC				EXYNOS4_IRQ_ADC0
-#define IRQ_TC				EXYNOS4_IRQ_PEN0
-
-#define IRQ_KEYPAD			EXYNOS4_IRQ_KEYPAD
-
-#define IRQ_FIMD0_FIFO			EXYNOS4_IRQ_FIMD0_FIFO
-#define IRQ_FIMD0_VSYNC			EXYNOS4_IRQ_FIMD0_VSYNC
-#define IRQ_FIMD0_SYSTEM		EXYNOS4_IRQ_FIMD0_SYSTEM
-
-#define IRQ_GPIO1_NR_GROUPS		EXYNOS4_IRQ_GPIO1_NR_GROUPS
-#define IRQ_GPIO2_NR_GROUPS		EXYNOS4_IRQ_GPIO2_NR_GROUPS
-
-/* For EXYNOS5 SoCs */
-
-#define EXYNOS5_IRQ_MDMA0		IRQ_SPI(33)
-#define EXYNOS5_IRQ_PDMA0		IRQ_SPI(34)
-#define EXYNOS5_IRQ_PDMA1		IRQ_SPI(35)
-#define EXYNOS5_IRQ_TIMER0_VIC		IRQ_SPI(36)
-#define EXYNOS5_IRQ_TIMER1_VIC		IRQ_SPI(37)
-#define EXYNOS5_IRQ_TIMER2_VIC		IRQ_SPI(38)
-#define EXYNOS5_IRQ_TIMER3_VIC		IRQ_SPI(39)
-#define EXYNOS5_IRQ_TIMER4_VIC		IRQ_SPI(40)
-#define EXYNOS5_IRQ_RTIC		IRQ_SPI(41)
-#define EXYNOS5_IRQ_WDT			IRQ_SPI(42)
-#define EXYNOS5_IRQ_RTC_ALARM		IRQ_SPI(43)
-#define EXYNOS5_IRQ_RTC_TIC		IRQ_SPI(44)
-#define EXYNOS5_IRQ_GPIO_XB		IRQ_SPI(45)
-#define EXYNOS5_IRQ_GPIO_XA		IRQ_SPI(46)
-#define EXYNOS5_IRQ_GPIO		IRQ_SPI(47)
-#define EXYNOS5_IRQ_IEM_IEC		IRQ_SPI(48)
-#define EXYNOS5_IRQ_IEM_APC		IRQ_SPI(49)
-#define EXYNOS5_IRQ_GPIO_C2C		IRQ_SPI(50)
-#define EXYNOS5_IRQ_IIC			IRQ_SPI(56)
-#define EXYNOS5_IRQ_IIC1		IRQ_SPI(57)
-#define EXYNOS5_IRQ_IIC2		IRQ_SPI(58)
-#define EXYNOS5_IRQ_IIC3		IRQ_SPI(59)
-#define EXYNOS5_IRQ_IIC4		IRQ_SPI(60)
-#define EXYNOS5_IRQ_IIC5		IRQ_SPI(61)
-#define EXYNOS5_IRQ_IIC6		IRQ_SPI(62)
-#define EXYNOS5_IRQ_IIC7		IRQ_SPI(63)
-#define EXYNOS5_IRQ_IIC_HDMIPHY		IRQ_SPI(64)
-#define EXYNOS5_IRQ_TMU			IRQ_SPI(65)
-#define EXYNOS5_IRQ_FIQ_0		IRQ_SPI(66)
-#define EXYNOS5_IRQ_FIQ_1		IRQ_SPI(67)
-#define EXYNOS5_IRQ_SPI0		IRQ_SPI(68)
-#define EXYNOS5_IRQ_SPI1		IRQ_SPI(69)
-#define EXYNOS5_IRQ_SPI2		IRQ_SPI(70)
-#define EXYNOS5_IRQ_USB_HOST		IRQ_SPI(71)
-#define EXYNOS5_IRQ_USB3_DRD		IRQ_SPI(72)
-#define EXYNOS5_IRQ_MIPI_HSI		IRQ_SPI(73)
-#define EXYNOS5_IRQ_USB_HSOTG		IRQ_SPI(74)
-#define EXYNOS5_IRQ_HSMMC0		IRQ_SPI(75)
-#define EXYNOS5_IRQ_HSMMC1		IRQ_SPI(76)
-#define EXYNOS5_IRQ_HSMMC2		IRQ_SPI(77)
-#define EXYNOS5_IRQ_HSMMC3		IRQ_SPI(78)
-#define EXYNOS5_IRQ_MIPICSI0		IRQ_SPI(79)
-#define EXYNOS5_IRQ_MIPICSI1		IRQ_SPI(80)
-#define EXYNOS5_IRQ_EFNFCON_DMA_ABORT	IRQ_SPI(81)
-#define EXYNOS5_IRQ_MIPIDSI0		IRQ_SPI(82)
-#define EXYNOS5_IRQ_WDT_IOP		IRQ_SPI(83)
-#define EXYNOS5_IRQ_ROTATOR		IRQ_SPI(84)
-#define EXYNOS5_IRQ_GSC0		IRQ_SPI(85)
-#define EXYNOS5_IRQ_GSC1		IRQ_SPI(86)
-#define EXYNOS5_IRQ_GSC2		IRQ_SPI(87)
-#define EXYNOS5_IRQ_GSC3		IRQ_SPI(88)
-#define EXYNOS5_IRQ_JPEG		IRQ_SPI(89)
-#define EXYNOS5_IRQ_EFNFCON_DMA		IRQ_SPI(90)
-#define EXYNOS5_IRQ_2D			IRQ_SPI(91)
-#define EXYNOS5_IRQ_EFNFCON_0		IRQ_SPI(92)
-#define EXYNOS5_IRQ_EFNFCON_1		IRQ_SPI(93)
-#define EXYNOS5_IRQ_MIXER		IRQ_SPI(94)
-#define EXYNOS5_IRQ_HDMI		IRQ_SPI(95)
-#define EXYNOS5_IRQ_MFC			IRQ_SPI(96)
-#define EXYNOS5_IRQ_AUDIO_SS		IRQ_SPI(97)
-#define EXYNOS5_IRQ_I2S0		IRQ_SPI(98)
-#define EXYNOS5_IRQ_I2S1		IRQ_SPI(99)
-#define EXYNOS5_IRQ_I2S2		IRQ_SPI(100)
-#define EXYNOS5_IRQ_AC97		IRQ_SPI(101)
-#define EXYNOS5_IRQ_PCM0		IRQ_SPI(102)
-#define EXYNOS5_IRQ_PCM1		IRQ_SPI(103)
-#define EXYNOS5_IRQ_PCM2		IRQ_SPI(104)
-#define EXYNOS5_IRQ_SPDIF		IRQ_SPI(105)
-#define EXYNOS5_IRQ_ADC0		IRQ_SPI(106)
-#define EXYNOS5_IRQ_ADC1		IRQ_SPI(107)
-#define EXYNOS5_IRQ_SATA_PHY		IRQ_SPI(108)
-#define EXYNOS5_IRQ_SATA_PMEMREQ	IRQ_SPI(109)
-#define EXYNOS5_IRQ_CAM_C		IRQ_SPI(110)
-#define EXYNOS5_IRQ_EAGLE_PMU		IRQ_SPI(111)
-#define EXYNOS5_IRQ_INTFEEDCTRL_SSS	IRQ_SPI(112)
-#define EXYNOS5_IRQ_DP1_INTP1		IRQ_SPI(113)
-#define EXYNOS5_IRQ_CEC			IRQ_SPI(114)
-#define EXYNOS5_IRQ_SATA		IRQ_SPI(115)
-
-#define EXYNOS5_IRQ_MMC44		IRQ_SPI(123)
-#define EXYNOS5_IRQ_MDMA1		IRQ_SPI(124)
-#define EXYNOS5_IRQ_FIMC_LITE0		IRQ_SPI(125)
-#define EXYNOS5_IRQ_FIMC_LITE1		IRQ_SPI(126)
-#define EXYNOS5_IRQ_RP_TIMER		IRQ_SPI(127)
-
-/* EXYNOS5440 */
-
-#define EXYNOS5440_IRQ_UART0		IRQ_SPI(2)
-#define EXYNOS5440_IRQ_UART1		IRQ_SPI(3)
-
-#define EXYNOS5_IRQ_PMU			COMBINER_IRQ(1, 2)
-
-#define EXYNOS5_IRQ_SYSMMU_GSC0_0	COMBINER_IRQ(2, 0)
-#define EXYNOS5_IRQ_SYSMMU_GSC0_1	COMBINER_IRQ(2, 1)
-#define EXYNOS5_IRQ_SYSMMU_GSC1_0	COMBINER_IRQ(2, 2)
-#define EXYNOS5_IRQ_SYSMMU_GSC1_1	COMBINER_IRQ(2, 3)
-#define EXYNOS5_IRQ_SYSMMU_GSC2_0	COMBINER_IRQ(2, 4)
-#define EXYNOS5_IRQ_SYSMMU_GSC2_1	COMBINER_IRQ(2, 5)
-#define EXYNOS5_IRQ_SYSMMU_GSC3_0	COMBINER_IRQ(2, 6)
-#define EXYNOS5_IRQ_SYSMMU_GSC3_1	COMBINER_IRQ(2, 7)
-
-#define EXYNOS5_IRQ_SYSMMU_LITE2_0	COMBINER_IRQ(3, 0)
-#define EXYNOS5_IRQ_SYSMMU_LITE2_1	COMBINER_IRQ(3, 1)
-#define EXYNOS5_IRQ_SYSMMU_FIMD1_0	COMBINER_IRQ(3, 2)
-#define EXYNOS5_IRQ_SYSMMU_FIMD1_1	COMBINER_IRQ(3, 3)
-#define EXYNOS5_IRQ_SYSMMU_LITE0_0	COMBINER_IRQ(3, 4)
-#define EXYNOS5_IRQ_SYSMMU_LITE0_1	COMBINER_IRQ(3, 5)
-#define EXYNOS5_IRQ_SYSMMU_SCALERPISP_0	COMBINER_IRQ(3, 6)
-#define EXYNOS5_IRQ_SYSMMU_SCALERPISP_1	COMBINER_IRQ(3, 7)
-
-#define EXYNOS5_IRQ_SYSMMU_ROTATOR_0	COMBINER_IRQ(4, 0)
-#define EXYNOS5_IRQ_SYSMMU_ROTATOR_1	COMBINER_IRQ(4, 1)
-#define EXYNOS5_IRQ_SYSMMU_JPEG_0	COMBINER_IRQ(4, 2)
-#define EXYNOS5_IRQ_SYSMMU_JPEG_1	COMBINER_IRQ(4, 3)
-
-#define EXYNOS5_IRQ_SYSMMU_FD_0		COMBINER_IRQ(5, 0)
-#define EXYNOS5_IRQ_SYSMMU_FD_1		COMBINER_IRQ(5, 1)
-#define EXYNOS5_IRQ_SYSMMU_SCALERCISP_0	COMBINER_IRQ(5, 2)
-#define EXYNOS5_IRQ_SYSMMU_SCALERCISP_1	COMBINER_IRQ(5, 3)
-#define EXYNOS5_IRQ_SYSMMU_MCUISP_0	COMBINER_IRQ(5, 4)
-#define EXYNOS5_IRQ_SYSMMU_MCUISP_1	COMBINER_IRQ(5, 5)
-#define EXYNOS5_IRQ_SYSMMU_3DNR_0	COMBINER_IRQ(5, 6)
-#define EXYNOS5_IRQ_SYSMMU_3DNR_1	COMBINER_IRQ(5, 7)
-
-#define EXYNOS5_IRQ_SYSMMU_ARM_0	COMBINER_IRQ(6, 0)
-#define EXYNOS5_IRQ_SYSMMU_ARM_1	COMBINER_IRQ(6, 1)
-#define EXYNOS5_IRQ_SYSMMU_MFC_R_0	COMBINER_IRQ(6, 2)
-#define EXYNOS5_IRQ_SYSMMU_MFC_R_1	COMBINER_IRQ(6, 3)
-#define EXYNOS5_IRQ_SYSMMU_RTIC_0	COMBINER_IRQ(6, 4)
-#define EXYNOS5_IRQ_SYSMMU_RTIC_1	COMBINER_IRQ(6, 5)
-#define EXYNOS5_IRQ_SYSMMU_SSS_0	COMBINER_IRQ(6, 6)
-#define EXYNOS5_IRQ_SYSMMU_SSS_1	COMBINER_IRQ(6, 7)
-
-#define EXYNOS5_IRQ_SYSMMU_MDMA0_0	COMBINER_IRQ(7, 0)
-#define EXYNOS5_IRQ_SYSMMU_MDMA0_1	COMBINER_IRQ(7, 1)
-#define EXYNOS5_IRQ_SYSMMU_MDMA1_0	COMBINER_IRQ(7, 2)
-#define EXYNOS5_IRQ_SYSMMU_MDMA1_1	COMBINER_IRQ(7, 3)
-#define EXYNOS5_IRQ_SYSMMU_TV_0		COMBINER_IRQ(7, 4)
-#define EXYNOS5_IRQ_SYSMMU_TV_1		COMBINER_IRQ(7, 5)
-
-#define EXYNOS5_IRQ_SYSMMU_MFC_L_0	COMBINER_IRQ(8, 5)
-#define EXYNOS5_IRQ_SYSMMU_MFC_L_1	COMBINER_IRQ(8, 6)
-
-#define EXYNOS5_IRQ_SYSMMU_DIS1_0	COMBINER_IRQ(9, 4)
-#define EXYNOS5_IRQ_SYSMMU_DIS1_1	COMBINER_IRQ(9, 5)
-
-#define EXYNOS5_IRQ_DP			COMBINER_IRQ(10, 3)
-#define EXYNOS5_IRQ_SYSMMU_DIS0_0	COMBINER_IRQ(10, 4)
-#define EXYNOS5_IRQ_SYSMMU_DIS0_1	COMBINER_IRQ(10, 5)
-#define EXYNOS5_IRQ_SYSMMU_ISP_0	COMBINER_IRQ(10, 6)
-#define EXYNOS5_IRQ_SYSMMU_ISP_1	COMBINER_IRQ(10, 7)
-
-#define EXYNOS5_IRQ_SYSMMU_ODC_0	COMBINER_IRQ(11, 0)
-#define EXYNOS5_IRQ_SYSMMU_ODC_1	COMBINER_IRQ(11, 1)
-#define EXYNOS5_IRQ_SYSMMU_DRC_0	COMBINER_IRQ(11, 6)
-#define EXYNOS5_IRQ_SYSMMU_DRC_1	COMBINER_IRQ(11, 7)
-
-#define EXYNOS5_IRQ_MDMA1_ABORT		COMBINER_IRQ(13, 1)
-
-#define EXYNOS5_IRQ_MDMA0_ABORT		COMBINER_IRQ(15, 3)
-
-#define EXYNOS5_IRQ_FIMD1_FIFO		COMBINER_IRQ(18, 4)
-#define EXYNOS5_IRQ_FIMD1_VSYNC		COMBINER_IRQ(18, 5)
-#define EXYNOS5_IRQ_FIMD1_SYSTEM	COMBINER_IRQ(18, 6)
-
-#define EXYNOS5_IRQ_ARMIOP_GIC		COMBINER_IRQ(19, 0)
-#define EXYNOS5_IRQ_ARMISP_GIC		COMBINER_IRQ(19, 1)
-#define EXYNOS5_IRQ_IOP_GIC		COMBINER_IRQ(19, 3)
-#define EXYNOS5_IRQ_ISP_GIC		COMBINER_IRQ(19, 4)
-
-#define EXYNOS5_IRQ_PMU_CPU1		COMBINER_IRQ(22, 4)
-
-#define EXYNOS5_IRQ_EINT0		COMBINER_IRQ(23, 0)
-
-#define EXYNOS5_IRQ_EINT1		COMBINER_IRQ(24, 0)
-#define EXYNOS5_IRQ_SYSMMU_LITE1_0	COMBINER_IRQ(24, 1)
-#define EXYNOS5_IRQ_SYSMMU_LITE1_1	COMBINER_IRQ(24, 2)
-#define EXYNOS5_IRQ_SYSMMU_2D_0		COMBINER_IRQ(24, 5)
-#define EXYNOS5_IRQ_SYSMMU_2D_1		COMBINER_IRQ(24, 6)
-
-#define EXYNOS5_IRQ_EINT2		COMBINER_IRQ(25, 0)
-#define EXYNOS5_IRQ_EINT3		COMBINER_IRQ(25, 1)
-
-#define EXYNOS5_IRQ_EINT4		COMBINER_IRQ(26, 0)
-#define EXYNOS5_IRQ_EINT5		COMBINER_IRQ(26, 1)
-
-#define EXYNOS5_IRQ_EINT6		COMBINER_IRQ(27, 0)
-#define EXYNOS5_IRQ_EINT7		COMBINER_IRQ(27, 1)
-
-#define EXYNOS5_IRQ_EINT8		COMBINER_IRQ(28, 0)
-#define EXYNOS5_IRQ_EINT9		COMBINER_IRQ(28, 1)
-
-#define EXYNOS5_IRQ_EINT10		COMBINER_IRQ(29, 0)
-#define EXYNOS5_IRQ_EINT11		COMBINER_IRQ(29, 1)
-
-#define EXYNOS5_IRQ_EINT12		COMBINER_IRQ(30, 0)
-#define EXYNOS5_IRQ_EINT13		COMBINER_IRQ(30, 1)
-
-#define EXYNOS5_IRQ_EINT14		COMBINER_IRQ(31, 0)
-#define EXYNOS5_IRQ_EINT15		COMBINER_IRQ(31, 1)
 
+#define EXYNOS4_MAX_COMBINER_NR		EXYNOS4412_MAX_COMBINER_NR
 #define EXYNOS5_MAX_COMBINER_NR		32
 
-#define EXYNOS5_IRQ_GPIO1_NR_GROUPS	14
-#define EXYNOS5_IRQ_GPIO2_NR_GROUPS	9
-#define EXYNOS5_IRQ_GPIO3_NR_GROUPS	5
-#define EXYNOS5_IRQ_GPIO4_NR_GROUPS	1
-
 #define MAX_COMBINER_NR			(EXYNOS4_MAX_COMBINER_NR > EXYNOS5_MAX_COMBINER_NR ? \
 					EXYNOS4_MAX_COMBINER_NR : EXYNOS5_MAX_COMBINER_NR)
 
@@ -472,5 +61,4 @@
 #ifndef CONFIG_SPARSE_IRQ
 #define NR_IRQS				EXYNOS_NR_IRQS
 #endif
-
 #endif /* __ASM_ARCH_IRQS_H */
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index 92b29bb..c715e79 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -23,6 +23,10 @@
 
 #include <plat/map-s5p.h>
 
+/*
+ * FIXME: go through the list and remove from iotable
+ * all that are not essential
+ */
 #define EXYNOS4_PA_SYSRAM0		0x02025000
 #define EXYNOS4_PA_SYSRAM1		0x02020000
 #define EXYNOS5_PA_SYSRAM		0x02020000
@@ -30,31 +34,6 @@
 #define EXYNOS4x12_PA_SYSRAM_NS		0x0204F000
 #define EXYNOS5250_PA_SYSRAM_NS		0x0204F000
 
-#define EXYNOS4_PA_FIMC0		0x11800000
-#define EXYNOS4_PA_FIMC1		0x11810000
-#define EXYNOS4_PA_FIMC2		0x11820000
-#define EXYNOS4_PA_FIMC3		0x11830000
-
-#define EXYNOS4_PA_JPEG			0x11840000
-
-/* x = 0...1 */
-#define EXYNOS4_PA_FIMC_LITE(x)		(0x12390000 + ((x) * 0x10000))
-
-#define EXYNOS4_PA_G2D			0x12800000
-
-#define EXYNOS4_PA_I2S0			0x03830000
-#define EXYNOS4_PA_I2S1			0xE3100000
-#define EXYNOS4_PA_I2S2			0xE2A00000
-
-#define EXYNOS4_PA_PCM0			0x03840000
-#define EXYNOS4_PA_PCM1			0x13980000
-#define EXYNOS4_PA_PCM2			0x13990000
-
-#define EXYNOS4_PA_SROM_BANK(x)		(0x04000000 + ((x) * 0x01000000))
-
-#define EXYNOS4_PA_ONENAND		0x0C000000
-#define EXYNOS4_PA_ONENAND_DMA		0x0C600000
-
 #define EXYNOS_PA_CHIPID		0x10000000
 
 #define EXYNOS4_PA_SYSCON		0x10010000
@@ -67,210 +46,35 @@
 #define EXYNOS5_PA_CMU			0x10010000
 
 #define EXYNOS4_PA_SYSTIMER		0x10050000
-
 #define EXYNOS4_PA_WATCHDOG		0x10060000
 #define EXYNOS5_PA_WATCHDOG		0x101D0000
 
-#define EXYNOS4_PA_RTC			0x10070000
-
-#define EXYNOS4_PA_KEYPAD		0x100A0000
-
 #define EXYNOS4_PA_DMC0			0x10400000
 #define EXYNOS4_PA_DMC1			0x10410000
 
 #define EXYNOS4_PA_COMBINER		0x10440000
-#define EXYNOS5_PA_COMBINER		0x10440000
 
 #define EXYNOS4_PA_GIC_CPU		0x10480000
 #define EXYNOS4_PA_GIC_DIST		0x10490000
-#define EXYNOS5_PA_GIC_CPU		0x10482000
-#define EXYNOS5_PA_GIC_DIST		0x10481000
 
 #define EXYNOS4_PA_COREPERI		0x10500000
-#define EXYNOS4_PA_TWD			0x10500600
-#define EXYNOS4_PA_L2CC			0x10502000
-
-#define EXYNOS4_PA_TMU			0x100C0000
-
-#define EXYNOS4_PA_MDMA0		0x10810000
-#define EXYNOS4_PA_MDMA1		0x12850000
-#define EXYNOS4_PA_S_MDMA1		0x12840000
-#define EXYNOS4_PA_PDMA0		0x12680000
-#define EXYNOS4_PA_PDMA1		0x12690000
-#define EXYNOS5_PA_MDMA0		0x10800000
-#define EXYNOS5_PA_MDMA1		0x11C10000
-#define EXYNOS5_PA_PDMA0		0x121A0000
-#define EXYNOS5_PA_PDMA1		0x121B0000
-
-#define EXYNOS4_PA_SYSMMU_MDMA		0x10A40000
-#define EXYNOS4_PA_SYSMMU_2D_ACP	0x10A40000
-#define EXYNOS4_PA_SYSMMU_SSS		0x10A50000
-#define EXYNOS4_PA_SYSMMU_FIMC0		0x11A20000
-#define EXYNOS4_PA_SYSMMU_FIMC1		0x11A30000
-#define EXYNOS4_PA_SYSMMU_FIMC2		0x11A40000
-#define EXYNOS4_PA_SYSMMU_FIMC3		0x11A50000
-#define EXYNOS4_PA_SYSMMU_JPEG		0x11A60000
-#define EXYNOS4_PA_SYSMMU_FIMD0		0x11E20000
-#define EXYNOS4_PA_SYSMMU_FIMD1		0x12220000
-#define EXYNOS4_PA_SYSMMU_FIMC_ISP	0x12260000
-#define EXYNOS4_PA_SYSMMU_FIMC_DRC	0x12270000
-#define EXYNOS4_PA_SYSMMU_FIMC_FD	0x122A0000
-#define EXYNOS4_PA_SYSMMU_ISPCPU	0x122B0000
-#define EXYNOS4_PA_SYSMMU_FIMC_LITE0	0x123B0000
-#define EXYNOS4_PA_SYSMMU_FIMC_LITE1	0x123C0000
-#define EXYNOS4_PA_SYSMMU_PCIe		0x12620000
-#define EXYNOS4_PA_SYSMMU_G2D		0x12A20000
-#define EXYNOS4_PA_SYSMMU_ROTATOR	0x12A30000
-#define EXYNOS4_PA_SYSMMU_MDMA2		0x12A40000
-#define EXYNOS4_PA_SYSMMU_TV		0x12E20000
-#define EXYNOS4_PA_SYSMMU_MFC_L		0x13620000
-#define EXYNOS4_PA_SYSMMU_MFC_R		0x13630000
-
-#define EXYNOS5_PA_GSC0			0x13E00000
-#define EXYNOS5_PA_GSC1			0x13E10000
-#define EXYNOS5_PA_GSC2			0x13E20000
-#define EXYNOS5_PA_GSC3			0x13E30000
 
-#define EXYNOS5_PA_SYSMMU_MDMA1		0x10A40000
-#define EXYNOS5_PA_SYSMMU_SSS		0x10A50000
-#define EXYNOS5_PA_SYSMMU_2D		0x10A60000
-#define EXYNOS5_PA_SYSMMU_MFC_L		0x11200000
-#define EXYNOS5_PA_SYSMMU_MFC_R		0x11210000
-#define EXYNOS5_PA_SYSMMU_ROTATOR	0x11D40000
-#define EXYNOS5_PA_SYSMMU_MDMA2		0x11D50000
-#define EXYNOS5_PA_SYSMMU_JPEG		0x11F20000
-#define EXYNOS5_PA_SYSMMU_IOP		0x12360000
-#define EXYNOS5_PA_SYSMMU_RTIC		0x12370000
-#define EXYNOS5_PA_SYSMMU_ISP		0x13260000
-#define EXYNOS5_PA_SYSMMU_DRC		0x12370000
-#define EXYNOS5_PA_SYSMMU_SCALERC	0x13280000
-#define EXYNOS5_PA_SYSMMU_SCALERP	0x13290000
-#define EXYNOS5_PA_SYSMMU_FD		0x132A0000
-#define EXYNOS5_PA_SYSMMU_ISPCPU	0x132B0000
-#define EXYNOS5_PA_SYSMMU_ODC		0x132C0000
-#define EXYNOS5_PA_SYSMMU_DIS0		0x132D0000
-#define EXYNOS5_PA_SYSMMU_DIS1		0x132E0000
-#define EXYNOS5_PA_SYSMMU_3DNR		0x132F0000
-#define EXYNOS5_PA_SYSMMU_LITE0		0x13C40000
-#define EXYNOS5_PA_SYSMMU_LITE1		0x13C50000
-#define EXYNOS5_PA_SYSMMU_GSC0		0x13E80000
-#define EXYNOS5_PA_SYSMMU_GSC1		0x13E90000
-#define EXYNOS5_PA_SYSMMU_GSC2		0x13EA0000
-#define EXYNOS5_PA_SYSMMU_GSC3		0x13EB0000
-#define EXYNOS5_PA_SYSMMU_FIMD1		0x14640000
-#define EXYNOS5_PA_SYSMMU_TV		0x14650000
-
-#define EXYNOS4_PA_SPI0			0x13920000
-#define EXYNOS4_PA_SPI1			0x13930000
-#define EXYNOS4_PA_SPI2			0x13940000
-#define EXYNOS5_PA_SPI0			0x12D20000
-#define EXYNOS5_PA_SPI1			0x12D30000
-#define EXYNOS5_PA_SPI2			0x12D40000
-
-#define EXYNOS4_PA_GPIO1		0x11400000
-#define EXYNOS4_PA_GPIO2		0x11000000
-#define EXYNOS4_PA_GPIO3		0x03860000
-#define EXYNOS5_PA_GPIO1		0x11400000
-#define EXYNOS5_PA_GPIO2		0x13400000
-#define EXYNOS5_PA_GPIO3		0x10D10000
-#define EXYNOS5_PA_GPIO4		0x03860000
-
-#define EXYNOS4_PA_MIPI_CSIS0		0x11880000
-#define EXYNOS4_PA_MIPI_CSIS1		0x11890000
-
-#define EXYNOS4_PA_FIMD0		0x11C00000
-
-#define EXYNOS4_PA_HSMMC(x)		(0x12510000 + ((x) * 0x10000))
-#define EXYNOS4_PA_DWMCI		0x12550000
-#define EXYNOS5_PA_DWMCI0		0x12200000
-#define EXYNOS5_PA_DWMCI1		0x12210000
-#define EXYNOS5_PA_DWMCI2		0x12220000
-#define EXYNOS5_PA_DWMCI3		0x12230000
-
-#define EXYNOS4_PA_HSOTG		0x12480000
-#define EXYNOS4_PA_USB_HSPHY		0x125B0000
-
-#define EXYNOS4_PA_SATA			0x12560000
-#define EXYNOS4_PA_SATAPHY		0x125D0000
-#define EXYNOS4_PA_SATAPHY_CTRL		0x126B0000
+#define EXYNOS4_PA_L2CC			0x10502000
 
 #define EXYNOS4_PA_SROMC		0x12570000
 #define EXYNOS5_PA_SROMC		0x12250000
 
-#define EXYNOS4_PA_EHCI			0x12580000
-#define EXYNOS4_PA_OHCI			0x12590000
 #define EXYNOS4_PA_HSPHY		0x125B0000
 #define EXYNOS4_PA_MFC			0x13400000
 
 #define EXYNOS4_PA_UART			0x13800000
 #define EXYNOS5_PA_UART			0x12C00000
 
-#define EXYNOS4_PA_VP			0x12C00000
-#define EXYNOS4_PA_MIXER		0x12C10000
-#define EXYNOS4_PA_SDO			0x12C20000
-#define EXYNOS4_PA_HDMI			0x12D00000
-#define EXYNOS4_PA_IIC_HDMIPHY		0x138E0000
-
-#define EXYNOS4_PA_IIC(x)		(0x13860000 + ((x) * 0x10000))
-#define EXYNOS5_PA_IIC(x)		(0x12C60000 + ((x) * 0x10000))
-
-#define EXYNOS4_PA_ADC			0x13910000
-#define EXYNOS4_PA_ADC1			0x13911000
-
-#define EXYNOS4_PA_AC97			0x139A0000
-
-#define EXYNOS4_PA_SPDIF		0x139B0000
-
 #define EXYNOS4_PA_TIMER		0x139D0000
 #define EXYNOS5_PA_TIMER		0x12DD0000
 
-#define EXYNOS4_PA_SDRAM		0x40000000
-#define EXYNOS5_PA_SDRAM		0x40000000
-
-/* Compatibiltiy Defines */
-
-#define S3C_PA_HSMMC0			EXYNOS4_PA_HSMMC(0)
-#define S3C_PA_HSMMC1			EXYNOS4_PA_HSMMC(1)
-#define S3C_PA_HSMMC2			EXYNOS4_PA_HSMMC(2)
-#define S3C_PA_HSMMC3			EXYNOS4_PA_HSMMC(3)
-#define S3C_PA_IIC			EXYNOS4_PA_IIC(0)
-#define S3C_PA_IIC1			EXYNOS4_PA_IIC(1)
-#define S3C_PA_IIC2			EXYNOS4_PA_IIC(2)
-#define S3C_PA_IIC3			EXYNOS4_PA_IIC(3)
-#define S3C_PA_IIC4			EXYNOS4_PA_IIC(4)
-#define S3C_PA_IIC5			EXYNOS4_PA_IIC(5)
-#define S3C_PA_IIC6			EXYNOS4_PA_IIC(6)
-#define S3C_PA_IIC7			EXYNOS4_PA_IIC(7)
-#define S3C_PA_RTC			EXYNOS4_PA_RTC
-#define S3C_PA_WDT			EXYNOS4_PA_WATCHDOG
-#define S3C_PA_SPI0			EXYNOS4_PA_SPI0
-#define S3C_PA_SPI1			EXYNOS4_PA_SPI1
-#define S3C_PA_SPI2			EXYNOS4_PA_SPI2
-#define S3C_PA_USB_HSOTG		EXYNOS4_PA_HSOTG
-
-#define S5P_PA_EHCI			EXYNOS4_PA_EHCI
-#define S5P_PA_FIMC0			EXYNOS4_PA_FIMC0
-#define S5P_PA_FIMC1			EXYNOS4_PA_FIMC1
-#define S5P_PA_FIMC2			EXYNOS4_PA_FIMC2
-#define S5P_PA_FIMC3			EXYNOS4_PA_FIMC3
-#define S5P_PA_JPEG			EXYNOS4_PA_JPEG
-#define S5P_PA_G2D			EXYNOS4_PA_G2D
-#define S5P_PA_FIMD0			EXYNOS4_PA_FIMD0
-#define S5P_PA_HDMI			EXYNOS4_PA_HDMI
-#define S5P_PA_IIC_HDMIPHY		EXYNOS4_PA_IIC_HDMIPHY
+/* Compatibiltiy Defines, need to be removed */
 #define S5P_PA_MFC			EXYNOS4_PA_MFC
-#define S5P_PA_MIPI_CSIS0		EXYNOS4_PA_MIPI_CSIS0
-#define S5P_PA_MIPI_CSIS1		EXYNOS4_PA_MIPI_CSIS1
-#define S5P_PA_MIXER			EXYNOS4_PA_MIXER
-#define S5P_PA_ONENAND			EXYNOS4_PA_ONENAND
-#define S5P_PA_ONENAND_DMA		EXYNOS4_PA_ONENAND_DMA
-#define S5P_PA_SDO			EXYNOS4_PA_SDO
-#define S5P_PA_SDRAM			EXYNOS4_PA_SDRAM
-#define S5P_PA_VP			EXYNOS4_PA_VP
-
-#define SAMSUNG_PA_ADC			EXYNOS4_PA_ADC
-#define SAMSUNG_PA_ADC1			EXYNOS4_PA_ADC1
-#define SAMSUNG_PA_KEYPAD		EXYNOS4_PA_KEYPAD
 
 /* Compatibility UART */
 
diff --git a/arch/arm/mach-exynos/include/mach/pm-core.h b/arch/arm/mach-exynos/include/mach/pm-core.h
index 296090e..bbfc6e3 100644
--- a/arch/arm/mach-exynos/include/mach/pm-core.h
+++ b/arch/arm/mach-exynos/include/mach/pm-core.h
@@ -34,10 +34,7 @@ static inline void s3c_pm_debug_init_uart(void)
 
 static inline void s3c_pm_arch_prepare_irqs(void)
 {
-	u32 eintmask = s3c_irqwake_eintmask;
-
-	if (of_have_populated_dt())
-		eintmask = exynos_get_eint_wake_mask();
+	u32 eintmask = exynos_get_eint_wake_mask();
 
 	__raw_writel(eintmask, S5P_EINT_WAKEUP_MASK);
 	__raw_writel(s3c_irqwake_intmask & ~(1 << 31), S5P_WAKEUP_MASK);
diff --git a/arch/arm/mach-exynos/include/mach/regs-usb-phy.h b/arch/arm/mach-exynos/include/mach/regs-usb-phy.h
deleted file mode 100644
index 0727773..0000000
diff --git a/arch/arm/mach-exynos/mach-armlex4210.c b/arch/arm/mach-exynos/mach-armlex4210.c
deleted file mode 100644
index 5f0f557..0000000
diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-exynos/mach-exynos4-dt.c
index b9ed834..20f0c04 100644
--- a/arch/arm/mach-exynos/mach-exynos4-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
@@ -23,15 +23,7 @@
 
 #include "common.h"
 
-static void __init exynos4_dt_map_io(void)
-{
-	exynos_init_io(NULL, 0);
-}
 
-static void __init exynos4_dt_machine_init(void)
-{
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
 
 static char const *exynos4_dt_compat[] __initdata = {
 	"samsung,exynos4210",
@@ -55,10 +47,9 @@ static void __init exynos4_reserve(void)
 DT_MACHINE_START(EXYNOS4210_DT, "Samsung Exynos4 (Flattened Device Tree)")
 	/* Maintainer: Thomas Abraham <thomas.abraham@linaro.org> */
 	.smp		= smp_ops(exynos_smp_ops),
-	.init_irq	= exynos4_init_irq,
-	.map_io		= exynos4_dt_map_io,
+	.init_irq	= exynos_init_irq,
+	.map_io		= exynos_init_io,
 	.init_early	= exynos_firmware_init,
-	.init_machine	= exynos4_dt_machine_init,
 	.init_late	= exynos_init_late,
 	.init_time	= exynos_init_time,
 	.dt_compat	= exynos4_dt_compat,
diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index 9596861..526a608 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -27,10 +27,6 @@
 static u64 dma_mask64 = DMA_BIT_MASK(64);
 static u64 dma_mask32 = DMA_BIT_MASK(32);
 
-static void __init exynos5_dt_map_io(void)
-{
-	exynos_init_io(NULL, 0);
-}
 
 static int exynos5440_platform_notifier(struct notifier_block *nb,
 				  unsigned long event, void *__dev)
@@ -104,9 +100,9 @@ static void __init exynos5_reserve(void)
 
 DT_MACHINE_START(EXYNOS5_DT, "SAMSUNG EXYNOS5 (Flattened Device Tree)")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
-	.init_irq	= exynos5_init_irq,
 	.smp		= smp_ops(exynos_smp_ops),
-	.map_io		= exynos5_dt_map_io,
+	.init_irq	= exynos_init_irq,
+	.map_io		= exynos_init_io,
 	.init_machine	= exynos5_dt_machine_init,
 	.init_late	= exynos_init_late,
 	.init_time	= exynos_init_time,
diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
deleted file mode 100644
index 5c8b287..0000000
diff --git a/arch/arm/mach-exynos/mach-origen.c b/arch/arm/mach-exynos/mach-origen.c
deleted file mode 100644
index 27f03ed..0000000
diff --git a/arch/arm/mach-exynos/mach-smdk4x12.c b/arch/arm/mach-exynos/mach-smdk4x12.c
deleted file mode 100644
index 2c8af96..0000000
diff --git a/arch/arm/mach-exynos/mach-smdkv310.c b/arch/arm/mach-exynos/mach-smdkv310.c
deleted file mode 100644
index d95b8cf..0000000
diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
deleted file mode 100644
index 74ddb2b..0000000
diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index beb946d..4b70b74 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -192,89 +192,7 @@ static __init int exynos_pm_dt_parse_domains(void)
 
 	return 0;
 }
-
-static __init __maybe_unused void exynos_pm_add_dev_to_genpd(struct platform_device *pdev,
-						struct exynos_pm_domain *pd)
-{
-	if (pdev->dev.bus) {
-		if (!pm_genpd_add_device(&pd->pd, &pdev->dev))
-			pm_genpd_dev_need_restore(&pdev->dev, true);
-		else
-			pr_info("%s: error in adding %s device to %s power"
-				"domain\n", __func__, dev_name(&pdev->dev),
-				pd->name);
-	}
-}
-
-EXYNOS_GPD(exynos4_pd_mfc, S5P_PMU_MFC_CONF, "pd-mfc");
-EXYNOS_GPD(exynos4_pd_g3d, S5P_PMU_G3D_CONF, "pd-g3d");
-EXYNOS_GPD(exynos4_pd_lcd0, S5P_PMU_LCD0_CONF, "pd-lcd0");
-EXYNOS_GPD(exynos4_pd_lcd1, S5P_PMU_LCD1_CONF, "pd-lcd1");
-EXYNOS_GPD(exynos4_pd_tv, S5P_PMU_TV_CONF, "pd-tv");
-EXYNOS_GPD(exynos4_pd_cam, S5P_PMU_CAM_CONF, "pd-cam");
-EXYNOS_GPD(exynos4_pd_gps, S5P_PMU_GPS_CONF, "pd-gps");
-
-static struct exynos_pm_domain *exynos4_pm_domains[] = {
-	&exynos4_pd_mfc,
-	&exynos4_pd_g3d,
-	&exynos4_pd_lcd0,
-	&exynos4_pd_lcd1,
-	&exynos4_pd_tv,
-	&exynos4_pd_cam,
-	&exynos4_pd_gps,
-};
-
-static __init int exynos4_pm_init_power_domain(void)
-{
-	int idx;
-
-	if (of_have_populated_dt())
-		return exynos_pm_dt_parse_domains();
-
-	for (idx = 0; idx < ARRAY_SIZE(exynos4_pm_domains); idx++) {
-		struct exynos_pm_domain *pd = exynos4_pm_domains[idx];
-		int on = __raw_readl(pd->base + 0x4) & S5P_INT_LOCAL_PWR_EN;
-
-		pm_genpd_init(&pd->pd, NULL, !on);
-	}
-
-#ifdef CONFIG_S5P_DEV_FIMD0
-	exynos_pm_add_dev_to_genpd(&s5p_device_fimd0, &exynos4_pd_lcd0);
-#endif
-#ifdef CONFIG_S5P_DEV_TV
-	exynos_pm_add_dev_to_genpd(&s5p_device_hdmi, &exynos4_pd_tv);
-	exynos_pm_add_dev_to_genpd(&s5p_device_mixer, &exynos4_pd_tv);
-#endif
-#ifdef CONFIG_S5P_DEV_MFC
-	exynos_pm_add_dev_to_genpd(&s5p_device_mfc, &exynos4_pd_mfc);
-#endif
-#ifdef CONFIG_S5P_DEV_FIMC0
-	exynos_pm_add_dev_to_genpd(&s5p_device_fimc0, &exynos4_pd_cam);
-#endif
-#ifdef CONFIG_S5P_DEV_FIMC1
-	exynos_pm_add_dev_to_genpd(&s5p_device_fimc1, &exynos4_pd_cam);
-#endif
-#ifdef CONFIG_S5P_DEV_FIMC2
-	exynos_pm_add_dev_to_genpd(&s5p_device_fimc2, &exynos4_pd_cam);
-#endif
-#ifdef CONFIG_S5P_DEV_FIMC3
-	exynos_pm_add_dev_to_genpd(&s5p_device_fimc3, &exynos4_pd_cam);
-#endif
-#ifdef CONFIG_S5P_DEV_CSIS0
-	exynos_pm_add_dev_to_genpd(&s5p_device_mipi_csis0, &exynos4_pd_cam);
-#endif
-#ifdef CONFIG_S5P_DEV_CSIS1
-	exynos_pm_add_dev_to_genpd(&s5p_device_mipi_csis1, &exynos4_pd_cam);
-#endif
-#ifdef CONFIG_S5P_DEV_G2D
-	exynos_pm_add_dev_to_genpd(&s5p_device_g2d, &exynos4_pd_lcd0);
-#endif
-#ifdef CONFIG_S5P_DEV_JPEG
-	exynos_pm_add_dev_to_genpd(&s5p_device_jpeg, &exynos4_pd_cam);
-#endif
-	return 0;
-}
-arch_initcall(exynos4_pm_init_power_domain);
+arch_initcall(exynos_pm_dt_parse_domains);
 
 int __init exynos_pm_late_initcall(void)
 {
diff --git a/arch/arm/mach-exynos/setup-fimc.c b/arch/arm/mach-exynos/setup-fimc.c
deleted file mode 100644
index 6a45078..0000000
diff --git a/arch/arm/mach-exynos/setup-fimd0.c b/arch/arm/mach-exynos/setup-fimd0.c
deleted file mode 100644
index 5665bb4..0000000
diff --git a/arch/arm/mach-exynos/setup-i2c0.c b/arch/arm/mach-exynos/setup-i2c0.c
deleted file mode 100644
index e2d9dfb..0000000
diff --git a/arch/arm/mach-exynos/setup-i2c1.c b/arch/arm/mach-exynos/setup-i2c1.c
deleted file mode 100644
index 8d2279c..0000000
diff --git a/arch/arm/mach-exynos/setup-i2c2.c b/arch/arm/mach-exynos/setup-i2c2.c
deleted file mode 100644
index 0ed62fc..0000000
diff --git a/arch/arm/mach-exynos/setup-i2c3.c b/arch/arm/mach-exynos/setup-i2c3.c
deleted file mode 100644
index 7787fd2..0000000
diff --git a/arch/arm/mach-exynos/setup-i2c4.c b/arch/arm/mach-exynos/setup-i2c4.c
deleted file mode 100644
index edc847f..0000000
diff --git a/arch/arm/mach-exynos/setup-i2c5.c b/arch/arm/mach-exynos/setup-i2c5.c
deleted file mode 100644
index d88af7f..0000000
diff --git a/arch/arm/mach-exynos/setup-i2c6.c b/arch/arm/mach-exynos/setup-i2c6.c
deleted file mode 100644
index c590286..0000000
diff --git a/arch/arm/mach-exynos/setup-i2c7.c b/arch/arm/mach-exynos/setup-i2c7.c
deleted file mode 100644
index 1bba755..0000000
diff --git a/arch/arm/mach-exynos/setup-keypad.c b/arch/arm/mach-exynos/setup-keypad.c
deleted file mode 100644
index 7862bfb..0000000
diff --git a/arch/arm/mach-exynos/setup-sdhci-gpio.c b/arch/arm/mach-exynos/setup-sdhci-gpio.c
deleted file mode 100644
index d5b98c8..0000000
diff --git a/arch/arm/mach-exynos/setup-spi.c b/arch/arm/mach-exynos/setup-spi.c
deleted file mode 100644
index 4999829..0000000
diff --git a/arch/arm/mach-exynos/setup-usb-phy.c b/arch/arm/mach-exynos/setup-usb-phy.c
deleted file mode 100644
index 6af4066..0000000
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index f8ed2de..cb1556c 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -27,7 +27,7 @@ config PLAT_S5P
 	select S5P_GPIO_DRVSTR
 	select SAMSUNG_CLKSRC if !COMMON_CLK
 	select SAMSUNG_GPIOLIB_4BIT
-	select SAMSUNG_IRQ_VIC_TIMER
+	select SAMSUNG_IRQ_VIC_TIMER if (ARCH_S5P64X0 || ARCH_S5PC100 || ARCH_S5PV210)
 	help
 	  Base platform code for Samsung's S5P series SoC.
 
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index a23c460..ae1b411 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -29,16 +29,19 @@ obj-$(CONFIG_S5P_GPIO_INT)	+= s5p-irq-gpioint.o
 
 obj-$(CONFIG_S3C_ADC)	+= adc.o
 
+ifdef CONFIG_ATAGS
 # devices
 
 obj-y				+= platformdata.o
 
 obj-y				+= devs.o
 obj-y				+= dev-uart.o
-obj-$(CONFIG_S5P_DEV_MFC)	+= s5p-dev-mfc.o
 obj-$(CONFIG_S5P_DEV_UART)	+= s5p-dev-uart.o
 
 obj-$(CONFIG_SAMSUNG_DEV_BACKLIGHT)	+= dev-backlight.o
+endif
+
+obj-$(CONFIG_S5P_DEV_MFC)	+= s5p-dev-mfc.o
 
 obj-$(CONFIG_S3C_SETUP_CAMIF)	+= setup-camif.o
 obj-$(CONFIG_S5P_SETUP_MIPIPHY)	+= setup-mipiphy.o
@@ -52,7 +55,9 @@ obj-$(CONFIG_SAMSUNG_DMADEV)	+= dma-ops.o
 # PM support
 
 obj-$(CONFIG_PM)		+= pm.o
+ifdef CONFIG_ATAGS
 obj-$(CONFIG_PM)		+= pm-gpio.o
+endif
 obj-$(CONFIG_SAMSUNG_PM_CHECK)	+= pm-check.o
 
 obj-$(CONFIG_SAMSUNG_WAKEMASK)	+= wakeup-mask.o
diff --git a/arch/arm/plat-samsung/init.c b/arch/arm/plat-samsung/init.c
index 79d10fc..847c4d6 100644
--- a/arch/arm/plat-samsung/init.c
+++ b/arch/arm/plat-samsung/init.c
@@ -63,6 +63,7 @@ void __init s3c_init_cpu(unsigned long idcode,
 	cpu->map_io();
 }
 
+#ifdef CONFIG_ATAGS
 /* s3c24xx_init_clocks
  *
  * Initialise the clock subsystem and associated information from the
@@ -139,21 +140,23 @@ void __init s3c24xx_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 	} else
 		(cpu->init_uarts)(cfg, no);
 }
+#endif
 
 static int __init s3c_arch_init(void)
 {
 	int ret;
 
-	// do the correct init for cpu
-
-	if (cpu == NULL)
-		panic("s3c_arch_init: NULL cpu\n");
+	/* we might be called for a non-samsung platform */
+	if (!cpu)
+		return 0;
 
 	ret = (cpu->init)();
 	if (ret != 0)
 		return ret;
 
+#ifdef CONFIG_ATAGS
 	ret = platform_add_devices(s3c24xx_uart_devs, nr_uarts);
+#endif
 	return ret;
 }
 
diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
index 53210ec..4578134 100644
--- a/arch/arm/plat-samsung/pm.c
+++ b/arch/arm/plat-samsung/pm.c
@@ -270,7 +270,8 @@ static int s3c_pm_enter(suspend_state_t state)
 
 	/* save all necessary core registers not covered by the drivers */
 
-	samsung_pm_save_gpios();
+	if (IS_ENABLED(CONFIG_ATAGS))
+		samsung_pm_save_gpios();
 	samsung_pm_saved_gpios();
 	s3c_pm_save_uarts();
 	s3c_pm_save_core();
@@ -310,7 +311,8 @@ static int s3c_pm_enter(suspend_state_t state)
 
 	s3c_pm_restore_core();
 	s3c_pm_restore_uarts();
-	samsung_pm_restore_gpios();
+	if (IS_ENABLED(CONFIG_ATAGS))
+		samsung_pm_restore_gpios();
 	s3c_pm_restored_gpios();
 
 	s3c_pm_debug_init();
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index f471fe8..09bcbff 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -209,6 +209,10 @@ config GPIO_RCAR
 	help
 	  Say yes here to support GPIO on Renesas R-Car SoCs.
 
+config GPIO_SAMSUNG
+	def_bool PLAT_S3C24XX || PLAT_S3C64XX || ARCH_S5P64X0 || \
+		 ARCH_S5PC100 || ARCH_S5PV210
+
 config GPIO_SPEAR_SPICS
 	bool "ST SPEAr13xx SPI Chip Select as GPIO support"
 	depends on PLAT_SPEAR
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 0cb2d65..5cf2238 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -59,7 +59,11 @@ obj-$(CONFIG_GPIO_PXA)		+= gpio-pxa.o
 obj-$(CONFIG_GPIO_RC5T583)	+= gpio-rc5t583.o
 obj-$(CONFIG_GPIO_RDC321X)	+= gpio-rdc321x.o
 obj-$(CONFIG_GPIO_RCAR)		+= gpio-rcar.o
-obj-$(CONFIG_PLAT_SAMSUNG)	+= gpio-samsung.o
+obj-$(CONFIG_PLAT_S3C24XX)	+= gpio-samsung.o
+obj-$(CONFIG_PLAT_S3C64XX)	+= gpio-samsung.o
+obj-$(CONFIG_ARCH_S5P64X0)	+= gpio-samsung.o
+obj-$(CONFIG_ARCH_S5PC100)	+= gpio-samsung.o
+obj-$(CONFIG_ARCH_S5PV210)	+= gpio-samsung.o
 obj-$(CONFIG_ARCH_SA1100)	+= gpio-sa1100.o
 obj-$(CONFIG_GPIO_SCH)		+= gpio-sch.o
 obj-$(CONFIG_GPIO_SODAVILLE)	+= gpio-sodaville.o
