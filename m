From: pawel.moll@arm.com (Pawel Moll)
Date: Fri,  8 Jun 2012 13:50:34 +0100
Subject: [PATCH 2/2] ARM: vexpress: Initial common clock support
In-Reply-To: <1339159835-32228-1-git-send-email-pawel.moll@arm.com>
References: <1339159835-32228-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1339159835-32228-2-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes Versatile Express use the common clock framework
instead of the plat-versatile implementation (which remains intact
for mach-versatile and mach-realview sake).

It defines clock provider for VE's OSCs (clock generators) and
registers all required fixed and variable clock sources (for both
motherboard and core tile).

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/Kconfig                                  |    2 +-
 arch/arm/mach-vexpress/ct-ca9x4.c                 |   55 +----
 arch/arm/mach-vexpress/include/mach/clkdev.h      |   15 --
 arch/arm/mach-vexpress/include/mach/motherboard.h |   20 ++
 arch/arm/mach-vexpress/v2m.c                      |  253 +++++++++------------
 arch/arm/plat-versatile/Kconfig                   |    5 +
 arch/arm/plat-versatile/Makefile                  |    2 +-
 7 files changed, 150 insertions(+), 202 deletions(-)
 delete mode 100644 arch/arm/mach-vexpress/include/mach/clkdev.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 84449dd..6f3370e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -306,7 +306,7 @@ config ARCH_VEXPRESS
 	select ARM_AMBA
 	select ARM_TIMER_SP804
 	select CLKDEV_LOOKUP
-	select HAVE_MACH_CLKDEV
+	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
 	select HAVE_CLK
 	select HAVE_PATA_PLATFORM
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 11cb248..3ef3fda 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -111,48 +111,22 @@ static struct amba_device *ct_ca9x4_amba_devs[] __initdata = {
 	&gpio_device,
 };
 
+static struct v2m_osc ct_osc1 = {
+	.osc = 1,
+	.rate_min = 10000000,
+	.rate_max = 80000000,
+	.rate_default = 23750000,
+};
 
-static long ct_round(struct clk *clk, unsigned long rate)
-{
-	return rate;
-}
-
-static int ct_set(struct clk *clk, unsigned long rate)
+static void __init ct_ca9x4_init_clk(void)
 {
-	u32 site = v2m_get_master_site();
+	struct clk *clk;
 
-	return v2m_cfg_write(SYS_CFG_OSC | SYS_CFG_SITE(site) | 1, rate);
+	ct_osc1.site = v2m_get_master_site();
+	clk = v2m_osc_register("ct:osc1", &ct_osc1);
+	clk_register_clkdev(clk, NULL, "ct:clcd");
 }
 
-static const struct clk_ops osc1_clk_ops = {
-	.round	= ct_round,
-	.set	= ct_set,
-};
-
-static struct clk osc1_clk = {
-	.ops	= &osc1_clk_ops,
-	.rate	= 24000000,
-};
-
-static struct clk ct_sp804_clk = {
-	.rate	= 1000000,
-};
-
-static struct clk_lookup lookups[] = {
-	{	/* CLCD */
-		.dev_id		= "ct:clcd",
-		.clk		= &osc1_clk,
-	}, {	/* SP804 timers */
-		.dev_id		= "sp804",
-		.con_id		= "ct-timer0",
-		.clk		= &ct_sp804_clk,
-	}, {	/* SP804 timers */
-		.dev_id		= "sp804",
-		.con_id		= "ct-timer1",
-		.clk		= &ct_sp804_clk,
-	},
-};
-
 static struct resource pmu_resources[] = {
 	[0] = {
 		.start	= IRQ_CT_CA9X4_PMU_CPU0,
@@ -183,11 +157,6 @@ static struct platform_device pmu_device = {
 	.resource	= pmu_resources,
 };
 
-static void __init ct_ca9x4_init_early(void)
-{
-	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
-}
-
 static void __init ct_ca9x4_init(void)
 {
 	int i;
@@ -243,8 +212,8 @@ struct ct_desc ct_ca9x4_desc __initdata = {
 	.id		= V2M_CT_ID_CA9,
 	.name		= "CA9x4",
 	.map_io		= ct_ca9x4_map_io,
-	.init_early	= ct_ca9x4_init_early,
 	.init_irq	= ct_ca9x4_init_irq,
+	.init_clk	= ct_ca9x4_init_clk,
 	.init_tile	= ct_ca9x4_init,
 #ifdef CONFIG_SMP
 	.init_cpu_map	= ct_ca9x4_init_cpu_map,
diff --git a/arch/arm/mach-vexpress/include/mach/clkdev.h b/arch/arm/mach-vexpress/include/mach/clkdev.h
deleted file mode 100644
index 3f8307d..0000000
--- a/arch/arm/mach-vexpress/include/mach/clkdev.h
+++ /dev/null
@@ -1,15 +0,0 @@
-#ifndef __ASM_MACH_CLKDEV_H
-#define __ASM_MACH_CLKDEV_H
-
-#include <plat/clock.h>
-
-struct clk {
-	const struct clk_ops	*ops;
-	unsigned long		rate;
-	const struct icst_params *params;
-};
-
-#define __clk_get(clk) ({ 1; })
-#define __clk_put(clk) do { } while (0)
-
-#endif
diff --git a/arch/arm/mach-vexpress/include/mach/motherboard.h b/arch/arm/mach-vexpress/include/mach/motherboard.h
index f004ec9..2762263 100644
--- a/arch/arm/mach-vexpress/include/mach/motherboard.h
+++ b/arch/arm/mach-vexpress/include/mach/motherboard.h
@@ -1,6 +1,8 @@
 #ifndef __MACH_MOTHERBOARD_H
 #define __MACH_MOTHERBOARD_H
 
+#include <linux/clk-provider.h>
+
 /*
  * Physical addresses, offset from V2M_PA_CS0-3
  */
@@ -138,6 +140,7 @@ struct ct_desc {
 	void			(*map_io)(void);
 	void			(*init_early)(void);
 	void			(*init_irq)(void);
+	void			(*init_clk)(void);
 	void			(*init_tile)(void);
 #ifdef CONFIG_SMP
 	void			(*init_cpu_map)(void);
@@ -147,4 +150,21 @@ struct ct_desc {
 
 extern struct ct_desc *ct_desc;
 
+/*
+ * OSC clock provider
+ */
+struct v2m_osc {
+	struct clk_hw hw;
+	u8 site; /* 0 = motherboard, 1 = site 1, 2 = site 2 */
+	u8 stack; /* board stack position */
+	u16 osc;
+	unsigned long rate_min;
+	unsigned long rate_max;
+	unsigned long rate_default;
+};
+
+#define to_v2m_osc(osc) container_of(osc, struct v2m_osc, hw)
+
+struct clk *v2m_osc_register(const char *name, struct v2m_osc *osc);
+
 #endif
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index aa6f9a6..e1e2415 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -16,6 +16,7 @@
 #include <linux/spinlock.h>
 #include <linux/usb/isp1760.h>
 #include <linux/clkdev.h>
+#include <linux/clk-provider.h>
 #include <linux/mtd/physmap.h>
 
 #include <asm/arch_timer.h>
@@ -81,16 +82,6 @@ static void __init v2m_sp804_init(void __iomem *base, unsigned int irq)
 	sp804_clockevents_init(base + TIMER_1_BASE, irq, "v2m-timer0");
 }
 
-static void __init v2m_timer_init(void)
-{
-	v2m_sysctl_init(ioremap(V2M_SYSCTL, SZ_4K));
-	v2m_sp804_init(ioremap(V2M_TIMER01, SZ_4K), IRQ_V2M_TIMER0);
-}
-
-static struct sys_timer v2m_timer = {
-	.init	= v2m_timer_init,
-};
-
 
 static DEFINE_SPINLOCK(v2m_cfg_lock);
 
@@ -326,86 +317,135 @@ static struct amba_device *v2m_amba_devs[] __initdata = {
 };
 
 
-static long v2m_osc_round(struct clk *clk, unsigned long rate)
+static unsigned long v2m_osc_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct v2m_osc *osc = to_v2m_osc(hw);
+
+	return !parent_rate ? osc->rate_default : parent_rate;
+}
+
+static long v2m_osc_round_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long *parent_rate)
 {
+	struct v2m_osc *osc = to_v2m_osc(hw);
+
+	if (WARN_ON(rate < osc->rate_min))
+		rate = osc->rate_min;
+
+	if (WARN_ON(rate > osc->rate_max))
+		rate = osc->rate_max;
+
 	return rate;
 }
 
-static int v2m_osc1_set(struct clk *clk, unsigned long rate)
+static int v2m_osc_set_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long parent_rate)
 {
-	return v2m_cfg_write(SYS_CFG_OSC | SYS_CFG_SITE_MB | 1, rate);
+	struct v2m_osc *osc = to_v2m_osc(hw);
+
+	v2m_cfg_write(SYS_CFG_OSC | SYS_CFG_SITE(osc->site) |
+		SYS_CFG_STACK(osc->stack) | osc->osc, rate);
+
+	return 0;
 }
 
-static const struct clk_ops osc1_clk_ops = {
-	.round	= v2m_osc_round,
-	.set	= v2m_osc1_set,
+static struct clk_ops v2m_osc_ops = {
+	.recalc_rate = v2m_osc_recalc_rate,
+	.round_rate = v2m_osc_round_rate,
+	.set_rate = v2m_osc_set_rate,
 };
 
-static struct clk osc1_clk = {
-	.ops	= &osc1_clk_ops,
-	.rate	= 24000000,
+struct clk * __init v2m_osc_register(const char *name, struct v2m_osc *osc)
+{
+	struct clk_init_data init;
+
+	WARN_ON(osc->site > 2);
+	WARN_ON(osc->stack > 15);
+	WARN_ON(osc->osc > 4095);
+
+	init.name = name;
+	init.ops = &v2m_osc_ops;
+	init.flags = CLK_IS_ROOT;
+	init.num_parents = 0;
+
+	osc->hw.init = &init;
+
+	return clk_register(NULL, &osc->hw);
+}
+
+static struct v2m_osc v2m_mb_osc1 = {
+	.site = SYS_CFG_SITE_MB,
+	.osc = 1,
+	.rate_min = 23750000,
+	.rate_max = 63500000,
+	.rate_default = 23750000,
 };
 
-static struct clk osc2_clk = {
-	.rate	= 24000000,
+static const char *v2m_ref_clk_periphs[] __initconst = {
+	"mb:wdt",	"1000f000.wdt",	"1c0f0000.wdt",	/* SP805 WDT */
 };
 
-static struct clk v2m_sp804_clk = {
-	.rate	= 1000000,
+static const char *v2m_osc1_periphs[] __initconst = {
+	"mb:clcd",	"1001f000.clcd", "1c1f0000.clcd",	/* PL111 CLCD */
 };
 
-static struct clk v2m_ref_clk = {
-	.rate   = 32768,
+static const char *v2m_osc2_periphs[] __initconst = {
+	"mb:mmci",	"10005000.mmci", "1c050000.mmci",	/* PL180 MMCI */
+	"mb:kmi0",	"10006000.kmi",	"1c060000.kmi",	/* PL050 KMI0 */
+	"mb:kmi1",	"10007000.kmi",	"1c070000.kmi",	/* PL050 KMI1 */
+	"mb:uart0", "10009000.uart", "1c090000.uart",	/* PL011 UART0 */
+	"mb:uart1", "1000a000.uart", "1c0a0000.uart",	/* PL011 UART1 */
+	"mb:uart2", "1000b000.uart", "1c0b0000.uart",	/* PL011 UART2 */
+	"mb:uart3", "1000c000.uart", "1c0c0000.uart",	/* PL011 UART3 */
 };
 
-static struct clk dummy_apb_pclk;
-
-static struct clk_lookup v2m_lookups[] = {
-	{	/* AMBA bus clock */
-		.con_id		= "apb_pclk",
-		.clk		= &dummy_apb_pclk,
-	}, {	/* UART0 */
-		.dev_id		= "mb:uart0",
-		.clk		= &osc2_clk,
-	}, {	/* UART1 */
-		.dev_id		= "mb:uart1",
-		.clk		= &osc2_clk,
-	}, {	/* UART2 */
-		.dev_id		= "mb:uart2",
-		.clk		= &osc2_clk,
-	}, {	/* UART3 */
-		.dev_id		= "mb:uart3",
-		.clk		= &osc2_clk,
-	}, {	/* KMI0 */
-		.dev_id		= "mb:kmi0",
-		.clk		= &osc2_clk,
-	}, {	/* KMI1 */
-		.dev_id		= "mb:kmi1",
-		.clk		= &osc2_clk,
-	}, {	/* MMC0 */
-		.dev_id		= "mb:mmci",
-		.clk		= &osc2_clk,
-	}, {	/* CLCD */
-		.dev_id		= "mb:clcd",
-		.clk		= &osc1_clk,
-	}, {	/* SP805 WDT */
-		.dev_id		= "mb:wdt",
-		.clk		= &v2m_ref_clk,
-	}, {	/* SP804 timers */
-		.dev_id		= "sp804",
-		.con_id		= "v2m-timer0",
-		.clk		= &v2m_sp804_clk,
-	}, {	/* SP804 timers */
-		.dev_id		= "sp804",
-		.con_id		= "v2m-timer1",
-		.clk		= &v2m_sp804_clk,
-	},
+static void __init v2m_clk_init(void)
+{
+	struct clk *clk;
+	int i;
+
+	clk = clk_register_fixed_rate(NULL, "dummy_apb_pclk", NULL,
+			CLK_IS_ROOT, 0);
+	WARN_ON(clk_register_clkdev(clk, "abp_pclk", NULL));
+
+	clk = clk_register_fixed_rate(NULL, "mb:ref_clk", NULL,
+			CLK_IS_ROOT, 32768);
+	for (i = 0; i < ARRAY_SIZE(v2m_ref_clk_periphs); i++)
+		WARN_ON(clk_register_clkdev(clk, NULL, v2m_ref_clk_periphs[i]));
+
+	clk = clk_register_fixed_rate(NULL, "mb:sp804_clk", NULL,
+			CLK_IS_ROOT, 1000000);
+	WARN_ON(clk_register_clkdev(clk, "v2m-timer0", "sp804"));
+	WARN_ON(clk_register_clkdev(clk, "v2m-timer1", "sp804"));
+
+	clk = v2m_osc_register("mb:osc1", &v2m_mb_osc1);
+	for (i = 0; i < ARRAY_SIZE(v2m_osc1_periphs); i++)
+		WARN_ON(clk_register_clkdev(clk, NULL, v2m_osc1_periphs[i]));
+
+	clk = clk_register_fixed_rate(NULL, "mb:osc2", NULL,
+			CLK_IS_ROOT, 24000000);
+	for (i = 0; i < ARRAY_SIZE(v2m_osc2_periphs); i++)
+		WARN_ON(clk_register_clkdev(clk, NULL, v2m_osc2_periphs[i]));
+}
+
+static void __init v2m_timer_init(void)
+{
+	v2m_sysctl_init(ioremap(V2M_SYSCTL, SZ_4K));
+	v2m_clk_init();
+	if (ct_desc->init_clk)
+		ct_desc->init_clk();
+	v2m_sp804_init(ioremap(V2M_TIMER01, SZ_4K), IRQ_V2M_TIMER0);
+}
+
+static struct sys_timer v2m_timer = {
+	.init	= v2m_timer_init,
 };
 
 static void __init v2m_init_early(void)
 {
-	ct_desc->init_early();
-	clkdev_add_table(v2m_lookups, ARRAY_SIZE(v2m_lookups));
+	if (ct_desc->init_early)
+		ct_desc->init_early();
 	versatile_sched_clock_init(v2m_sysreg_base + V2M_SYS_24MHZ, 24000000);
 }
 
@@ -528,77 +568,6 @@ void __init v2m_dt_map_io(void)
 #endif
 }
 
-static struct clk_lookup v2m_dt_lookups[] = {
-	{	/* AMBA bus clock */
-		.con_id		= "apb_pclk",
-		.clk		= &dummy_apb_pclk,
-	}, {	/* SP804 timers */
-		.dev_id		= "sp804",
-		.con_id		= "v2m-timer0",
-		.clk		= &v2m_sp804_clk,
-	}, {	/* SP804 timers */
-		.dev_id		= "sp804",
-		.con_id		= "v2m-timer1",
-		.clk		= &v2m_sp804_clk,
-	}, {	/* PL180 MMCI */
-		.dev_id		= "mb:mmci", /* 10005000.mmci */
-		.clk		= &osc2_clk,
-	}, {	/* PL050 KMI0 */
-		.dev_id		= "10006000.kmi",
-		.clk		= &osc2_clk,
-	}, {	/* PL050 KMI1 */
-		.dev_id		= "10007000.kmi",
-		.clk		= &osc2_clk,
-	}, {	/* PL011 UART0 */
-		.dev_id		= "10009000.uart",
-		.clk		= &osc2_clk,
-	}, {	/* PL011 UART1 */
-		.dev_id		= "1000a000.uart",
-		.clk		= &osc2_clk,
-	}, {	/* PL011 UART2 */
-		.dev_id		= "1000b000.uart",
-		.clk		= &osc2_clk,
-	}, {	/* PL011 UART3 */
-		.dev_id		= "1000c000.uart",
-		.clk		= &osc2_clk,
-	}, {	/* SP805 WDT */
-		.dev_id		= "1000f000.wdt",
-		.clk		= &v2m_ref_clk,
-	}, {	/* PL111 CLCD */
-		.dev_id		= "1001f000.clcd",
-		.clk		= &osc1_clk,
-	},
-	/* RS1 memory map */
-	{	/* PL180 MMCI */
-		.dev_id		= "mb:mmci", /* 1c050000.mmci */
-		.clk		= &osc2_clk,
-	}, {	/* PL050 KMI0 */
-		.dev_id		= "1c060000.kmi",
-		.clk		= &osc2_clk,
-	}, {	/* PL050 KMI1 */
-		.dev_id		= "1c070000.kmi",
-		.clk		= &osc2_clk,
-	}, {	/* PL011 UART0 */
-		.dev_id		= "1c090000.uart",
-		.clk		= &osc2_clk,
-	}, {	/* PL011 UART1 */
-		.dev_id		= "1c0a0000.uart",
-		.clk		= &osc2_clk,
-	}, {	/* PL011 UART2 */
-		.dev_id		= "1c0b0000.uart",
-		.clk		= &osc2_clk,
-	}, {	/* PL011 UART3 */
-		.dev_id		= "1c0c0000.uart",
-		.clk		= &osc2_clk,
-	}, {	/* SP805 WDT */
-		.dev_id		= "1c0f0000.wdt",
-		.clk		= &v2m_ref_clk,
-	}, {	/* PL111 CLCD */
-		.dev_id		= "1c1f0000.clcd",
-		.clk		= &osc1_clk,
-	},
-};
-
 void __init v2m_dt_init_early(void)
 {
 	struct device_node *node;
@@ -620,8 +589,6 @@ void __init v2m_dt_init_early(void)
 			pr_warning("vexpress: DT HBI (%x) is not matching "
 					"hardware (%x)!\n", dt_hbi, hbi);
 	}
-
-	clkdev_add_table(v2m_dt_lookups, ARRAY_SIZE(v2m_dt_lookups));
 }
 
 static  struct of_device_id vexpress_irq_match[] __initdata = {
@@ -643,6 +610,8 @@ static void __init v2m_dt_timer_init(void)
 	node = of_find_compatible_node(NULL, NULL, "arm,sp810");
 	v2m_sysctl_init(of_iomap(node, 0));
 
+	v2m_clk_init();
+
 	err = of_property_read_string(of_aliases, "arm,v2m_timer", &path);
 	if (WARN_ON(err))
 		return;
diff --git a/arch/arm/plat-versatile/Kconfig b/arch/arm/plat-versatile/Kconfig
index 81ee7cc..4b9f4bf 100644
--- a/arch/arm/plat-versatile/Kconfig
+++ b/arch/arm/plat-versatile/Kconfig
@@ -1,5 +1,10 @@
 if PLAT_VERSATILE
 
+config PLAT_VERSATILE_CLOCK
+	bool
+	default y
+	depends on !COMMON_CLK
+
 config PLAT_VERSATILE_CLCD
 	bool
 
diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index a5cb194..272769a8 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -1,4 +1,4 @@
-obj-y	:= clock.o
+obj-$(CONFIG_PLAT_VERSATILE_CLOCK) += clock.o
 obj-$(CONFIG_PLAT_VERSATILE_CLCD) += clcd.o
 obj-$(CONFIG_PLAT_VERSATILE_FPGA_IRQ) += fpga-irq.o
 obj-$(CONFIG_PLAT_VERSATILE_LEDS) += leds.o
-- 
1.7.9.5
