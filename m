From: pawel.moll@arm.com (Pawel Moll)
Date: Mon,  3 Sep 2012 17:25:31 +0100
Subject: [PATCH 11/11] ARM: vexpress: Start using new Versatile Express
 infrastructure
In-Reply-To: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
References: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1346689531-7212-12-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch starts using all the configuration infrastructure.

- generic GPIO library is forced now

- sysreg GPIOs are used to as MMC CD and WP information sources;
  thanks to this MMCI auxiliary data is not longer necessary

- DVI muxer and mode control is removed from non-DT V2P-CA9 code
  as this is now handled by the vexpress-display driver

- oscillator control is removed as is being handled by the
  common clock driver now

- the sysreg and sysctl control is now delegated to the
  appropriate drivers and all related code was removed

- NOR Flash set_vpp function has been removed as the control
  bit used does _not_ control its VPP line, but the #WP signal
  instead (which is de facto unusable in case of Linux MTD
  drivers); this also allowed the remove its DT auxiliary
  data

The non-DT code defines only minimal required number of
the config devices. Device Trees are updated to make use
of all new features.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/Kconfig                                  |    4 +-
 arch/arm/include/asm/hardware/sp810.h             |    6 -
 arch/arm/mach-vexpress/ct-ca9x4.c                 |   37 +--
 arch/arm/mach-vexpress/include/mach/motherboard.h |   81 ------
 arch/arm/mach-vexpress/platsmp.c                  |    3 +-
 arch/arm/mach-vexpress/v2m.c                      |  321 +++++----------------
 6 files changed, 86 insertions(+), 366 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e88fe09..45a5d88 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -322,11 +322,12 @@ config ARCH_VERSATILE
 
 config ARCH_VEXPRESS
 	bool "ARM Ltd. Versatile Express family"
-	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
 	select ARM_TIMER_SP804
 	select CLKDEV_LOOKUP
 	select COMMON_CLK
+	select COMMON_CLK_VERSATILE
 	select GENERIC_CLOCKEVENTS
 	select HAVE_CLK
 	select HAVE_PATA_PLATFORM
@@ -335,6 +336,7 @@ config ARCH_VEXPRESS
 	select PLAT_VERSATILE
 	select PLAT_VERSATILE_CLCD
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select VEXPRESS_CONFIG_BUS
 	help
 	  This enables support for the ARM Ltd Versatile Express boards.
 
diff --git a/arch/arm/include/asm/hardware/sp810.h b/arch/arm/include/asm/hardware/sp810.h
index afd7e91..6636430 100644
--- a/arch/arm/include/asm/hardware/sp810.h
+++ b/arch/arm/include/asm/hardware/sp810.h
@@ -50,12 +50,6 @@
 #define SCPCELLID2		0xFF8
 #define SCPCELLID3		0xFFC
 
-#define SCCTRL_TIMEREN0SEL_REFCLK	(0 << 15)
-#define SCCTRL_TIMEREN0SEL_TIMCLK	(1 << 15)
-
-#define SCCTRL_TIMEREN1SEL_REFCLK	(0 << 17)
-#define SCCTRL_TIMEREN1SEL_TIMCLK	(1 << 17)
-
 #define SCCTRL_TIMERENnSEL_SHIFT(n)	(15 + ((n) * 2))
 
 static inline void sysctl_soft_reset(void __iomem *base)
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 61c4924..3e93058 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -9,6 +9,7 @@
 #include <linux/amba/bus.h>
 #include <linux/amba/clcd.h>
 #include <linux/clkdev.h>
+#include <linux/vexpress.h>
 
 #include <asm/hardware/arm_timer.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -64,19 +65,6 @@ static void __init ct_ca9x4_init_irq(void)
 	ca9x4_twd_init();
 }
 
-static void ct_ca9x4_clcd_enable(struct clcd_fb *fb)
-{
-	u32 site = v2m_get_master_site();
-
-	/*
-	 * Old firmware was using the "site" component of the command
-	 * to control the DVI muxer (while it should be always 0 ie. MB).
-	 * Newer firmware uses the data register. Keep both for compatibility.
-	 */
-	v2m_cfg_write(SYS_CFG_MUXFPGA | SYS_CFG_SITE(site), site);
-	v2m_cfg_write(SYS_CFG_DVIMODE | SYS_CFG_SITE(SYS_CFG_SITE_MB), 2);
-}
-
 static int ct_ca9x4_clcd_setup(struct clcd_fb *fb)
 {
 	unsigned long framesize = 1024 * 768 * 2;
@@ -93,7 +81,6 @@ static struct clcd_board ct_ca9x4_clcd_data = {
 	.caps		= CLCD_CAP_5551 | CLCD_CAP_565,
 	.check		= clcdfb_check,
 	.decode		= clcdfb_decode,
-	.enable		= ct_ca9x4_clcd_enable,
 	.setup		= ct_ca9x4_clcd_setup,
 	.mmap		= versatile_clcd_mmap_dma,
 	.remove		= versatile_clcd_remove_dma,
@@ -111,12 +98,23 @@ static struct amba_device *ct_ca9x4_amba_devs[] __initdata = {
 	&gpio_device,
 };
 
+static const char * const ct_ca9x4_osc1_periphs[] = {
+	"ct:clcd",
+	NULL
+};
 
-static struct v2m_osc ct_osc1 = {
-	.osc = 1,
+static struct vexpress_osc_info ct_ca9x4_osc1_info = {
+	.clock_name = "clcdclk",
 	.rate_min = 10000000,
 	.rate_max = 80000000,
-	.rate_default = 23750000,
+	.dev_ids = ct_ca9x4_osc1_periphs,
+};
+
+static struct vexpress_config_device ct_ca9x4_osc1_device = {
+	.name		= "ct:osc1",
+	.func		= VEXPRESS_CONFIG_FUNC_OSC,
+	.addr		= { VEXPRESS_SITE_MASTER, 0, 0, 1 },
+	.dev.platform_data = &ct_ca9x4_osc1_info,
 };
 
 static struct resource pmu_resources[] = {
@@ -152,7 +150,6 @@ static struct platform_device pmu_device = {
 static void __init ct_ca9x4_init(void)
 {
 	int i;
-	struct clk *clk;
 
 #ifdef CONFIG_CACHE_L2X0
 	void __iomem *l2x0_base = ioremap(CT_CA9X4_L2CC, SZ_4K);
@@ -164,9 +161,7 @@ static void __init ct_ca9x4_init(void)
 	l2x0_init(l2x0_base, 0x00400000, 0xfe0fffff);
 #endif
 
-	ct_osc1.site = v2m_get_master_site();
-	clk = v2m_osc_register("ct:osc1", &ct_osc1);
-	clk_register_clkdev(clk, NULL, "ct:clcd");
+	vexpress_config_device_register(&ct_ca9x4_osc1_device);
 
 	for (i = 0; i < ARRAY_SIZE(ct_ca9x4_amba_devs); i++)
 		amba_device_register(ct_ca9x4_amba_devs[i], &iomem_resource);
diff --git a/arch/arm/mach-vexpress/include/mach/motherboard.h b/arch/arm/mach-vexpress/include/mach/motherboard.h
index 1e388c7..68abc8b 100644
--- a/arch/arm/mach-vexpress/include/mach/motherboard.h
+++ b/arch/arm/mach-vexpress/include/mach/motherboard.h
@@ -1,8 +1,6 @@
 #ifndef __MACH_MOTHERBOARD_H
 #define __MACH_MOTHERBOARD_H
 
-#include <linux/clk-provider.h>
-
 /*
  * Physical addresses, offset from V2M_PA_CS0-3
  */
@@ -41,31 +39,6 @@
 #define V2M_CF			(V2M_PA_CS7 + 0x0001a000)
 #define V2M_CLCD		(V2M_PA_CS7 + 0x0001f000)
 
-/*
- * Offsets from SYSREGS base
- */
-#define V2M_SYS_ID		0x000
-#define V2M_SYS_SW		0x004
-#define V2M_SYS_LED		0x008
-#define V2M_SYS_100HZ		0x024
-#define V2M_SYS_FLAGS		0x030
-#define V2M_SYS_FLAGSSET	0x030
-#define V2M_SYS_FLAGSCLR	0x034
-#define V2M_SYS_NVFLAGS		0x038
-#define V2M_SYS_NVFLAGSSET	0x038
-#define V2M_SYS_NVFLAGSCLR	0x03c
-#define V2M_SYS_MCI		0x048
-#define V2M_SYS_FLASH		0x03c
-#define V2M_SYS_CFGSW		0x058
-#define V2M_SYS_24MHZ		0x05c
-#define V2M_SYS_MISC		0x060
-#define V2M_SYS_DMA		0x064
-#define V2M_SYS_PROCID0		0x084
-#define V2M_SYS_PROCID1		0x088
-#define V2M_SYS_CFGDATA		0x0a0
-#define V2M_SYS_CFGCTRL		0x0a4
-#define V2M_SYS_CFGSTAT		0x0a8
-
 
 /*
  * Interrupts.  Those in {} are for AMBA devices
@@ -91,43 +64,6 @@
 
 
 /*
- * Configuration
- */
-#define SYS_CFG_START		(1 << 31)
-#define SYS_CFG_WRITE		(1 << 30)
-#define SYS_CFG_OSC		(1 << 20)
-#define SYS_CFG_VOLT		(2 << 20)
-#define SYS_CFG_AMP		(3 << 20)
-#define SYS_CFG_TEMP		(4 << 20)
-#define SYS_CFG_RESET		(5 << 20)
-#define SYS_CFG_SCC		(6 << 20)
-#define SYS_CFG_MUXFPGA		(7 << 20)
-#define SYS_CFG_SHUTDOWN	(8 << 20)
-#define SYS_CFG_REBOOT		(9 << 20)
-#define SYS_CFG_DVIMODE		(11 << 20)
-#define SYS_CFG_POWER		(12 << 20)
-#define SYS_CFG_SITE(n)		((n) << 16)
-#define SYS_CFG_SITE_MB		0
-#define SYS_CFG_SITE_DB1	1
-#define SYS_CFG_SITE_DB2	2
-#define SYS_CFG_STACK(n)	((n) << 12)
-
-#define SYS_CFG_ERR		(1 << 1)
-#define SYS_CFG_COMPLETE	(1 << 0)
-
-int v2m_cfg_write(u32 devfn, u32 data);
-int v2m_cfg_read(u32 devfn, u32 *data);
-void v2m_flags_set(u32 data);
-
-/*
- * Miscellaneous
- */
-#define SYS_MISC_MASTERSITE	(1 << 14)
-#define SYS_PROCIDx_HBI_MASK	0xfff
-
-int v2m_get_master_site(void);
-
-/*
  * Core tile IDs
  */
 #define V2M_CT_ID_CA9		0x0c000191
@@ -149,21 +85,4 @@ struct ct_desc {
 
 extern struct ct_desc *ct_desc;
 
-/*
- * OSC clock provider
- */
-struct v2m_osc {
-	struct clk_hw hw;
-	u8 site; /* 0 = motherboard, 1 = site 1, 2 = site 2 */
-	u8 stack; /* board stack position */
-	u16 osc;
-	unsigned long rate_min;
-	unsigned long rate_max;
-	unsigned long rate_default;
-};
-
-#define to_v2m_osc(osc) container_of(osc, struct v2m_osc, hw)
-
-struct clk *v2m_osc_register(const char *name, struct v2m_osc *osc);
-
 #endif
diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index 14ba112..f07cb2f 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -13,6 +13,7 @@
 #include <linux/smp.h>
 #include <linux/io.h>
 #include <linux/of_fdt.h>
+#include <linux/vexpress.h>
 
 #include <asm/smp_scu.h>
 #include <asm/hardware/gic.h>
@@ -193,5 +194,5 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 	 * until it receives a soft interrupt, and then the
 	 * secondary CPU branches to this address.
 	 */
-	v2m_flags_set(virt_to_phys(versatile_secondary_startup));
+	vexpress_flags_set(virt_to_phys(versatile_secondary_startup));
 }
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 37608f2..e4535db 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -15,11 +15,10 @@
 #include <linux/smsc911x.h>
 #include <linux/spinlock.h>
 #include <linux/usb/isp1760.h>
-#include <linux/clkdev.h>
-#include <linux/clk-provider.h>
 #include <linux/mtd/physmap.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
+#include <linux/vexpress.h>
 
 #include <asm/arch_timer.h>
 #include <asm/mach-types.h>
@@ -32,7 +31,6 @@
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/hardware/gic.h>
 #include <asm/hardware/timer-sp.h>
-#include <asm/hardware/sp810.h>
 
 #include <mach/ct-ca9x4.h>
 #include <mach/motherboard.h>
@@ -56,22 +54,6 @@ static struct map_desc v2m_io_desc[] __initdata = {
 	},
 };
 
-static void __iomem *v2m_sysreg_base;
-
-static void __init v2m_sysctl_init(void __iomem *base)
-{
-	u32 scctrl;
-
-	if (WARN_ON(!base))
-		return;
-
-	/* Select 1MHz TIMCLK as the reference clock for SP804 timers */
-	scctrl = readl(base + SCCTRL);
-	scctrl |= SCCTRL_TIMEREN0SEL_TIMCLK;
-	scctrl |= SCCTRL_TIMEREN1SEL_TIMCLK;
-	writel(scctrl, base + SCCTRL);
-}
-
 static void __init v2m_sp804_init(void __iomem *base, unsigned int irq)
 {
 	if (WARN_ON(!base || irq == NO_IRQ))
@@ -85,69 +67,6 @@ static void __init v2m_sp804_init(void __iomem *base, unsigned int irq)
 }
 
 
-static DEFINE_SPINLOCK(v2m_cfg_lock);
-
-int v2m_cfg_write(u32 devfn, u32 data)
-{
-	/* Configuration interface broken? */
-	u32 val;
-
-	printk("%s: writing %08x to %08x\n", __func__, data, devfn);
-
-	devfn |= SYS_CFG_START | SYS_CFG_WRITE;
-
-	spin_lock(&v2m_cfg_lock);
-	val = readl(v2m_sysreg_base + V2M_SYS_CFGSTAT);
-	writel(val & ~SYS_CFG_COMPLETE, v2m_sysreg_base + V2M_SYS_CFGSTAT);
-
-	writel(data, v2m_sysreg_base +  V2M_SYS_CFGDATA);
-	writel(devfn, v2m_sysreg_base + V2M_SYS_CFGCTRL);
-
-	do {
-		val = readl(v2m_sysreg_base + V2M_SYS_CFGSTAT);
-	} while (val == 0);
-	spin_unlock(&v2m_cfg_lock);
-
-	return !!(val & SYS_CFG_ERR);
-}
-
-int v2m_cfg_read(u32 devfn, u32 *data)
-{
-	u32 val;
-
-	devfn |= SYS_CFG_START;
-
-	spin_lock(&v2m_cfg_lock);
-	writel(0, v2m_sysreg_base + V2M_SYS_CFGSTAT);
-	writel(devfn, v2m_sysreg_base + V2M_SYS_CFGCTRL);
-
-	mb();
-
-	do {
-		cpu_relax();
-		val = readl(v2m_sysreg_base + V2M_SYS_CFGSTAT);
-	} while (val == 0);
-
-	*data = readl(v2m_sysreg_base + V2M_SYS_CFGDATA);
-	spin_unlock(&v2m_cfg_lock);
-
-	return !!(val & SYS_CFG_ERR);
-}
-
-void __init v2m_flags_set(u32 data)
-{
-	writel(~0, v2m_sysreg_base + V2M_SYS_FLAGSCLR);
-	writel(data, v2m_sysreg_base + V2M_SYS_FLAGSSET);
-}
-
-int v2m_get_master_site(void)
-{
-	u32 misc = readl(v2m_sysreg_base + V2M_SYS_MISC);
-
-	return misc & SYS_MISC_MASTERSITE ? SYS_CFG_SITE_DB2 : SYS_CFG_SITE_DB1;
-}
-
-
 static struct resource v2m_pcie_i2c_resource = {
 	.start	= V2M_SERIAL_BUS_PCI,
 	.end	= V2M_SERIAL_BUS_PCI + SZ_4K - 1,
@@ -235,14 +154,8 @@ static struct platform_device v2m_usb_device = {
 	.dev.platform_data = &v2m_usb_config,
 };
 
-static void v2m_flash_set_vpp(struct platform_device *pdev, int on)
-{
-	writel(on != 0, v2m_sysreg_base + V2M_SYS_FLASH);
-}
-
 static struct physmap_flash_data v2m_flash_data = {
 	.width		= 4,
-	.set_vpp	= v2m_flash_set_vpp,
 };
 
 static struct resource v2m_flash_resources[] = {
@@ -289,14 +202,49 @@ static struct platform_device v2m_cf_device = {
 	.dev.platform_data = &v2m_pata_data,
 };
 
-static unsigned int v2m_mmci_status(struct device *dev)
-{
-	return readl(v2m_sysreg_base + V2M_SYS_MCI) & (1 << 0);
-}
-
 static struct mmci_platform_data v2m_mmci_data = {
 	.ocr_mask	= MMC_VDD_32_33|MMC_VDD_33_34,
-	.status		= v2m_mmci_status,
+	.gpio_wp	= VEXPRESS_GPIO_MMC_WPROT,
+	.gpio_cd	= VEXPRESS_GPIO_MMC_CARDIN,
+};
+
+static struct resource v2m_sysreg_resources[] = {
+	{
+		.start	= V2M_SYSREGS,
+		.end	= V2M_SYSREGS + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device v2m_sysreg_device = {
+	.name		= "vexpress-sysreg",
+	.id		= -1,
+	.resource	= v2m_sysreg_resources,
+	.num_resources	= ARRAY_SIZE(v2m_sysreg_resources),
+};
+
+static struct vexpress_config_device v2m_muxfpga_device = {
+	.name		= "mb:muxfpga",
+	.func		= VEXPRESS_CONFIG_FUNC_MUXFPGA,
+	.addr		= { VEXPRESS_SITE_MB, 0, 0, 0 },
+};
+
+static struct vexpress_config_device v2m_shutdown_device = {
+	.name		= "mb:shutdown",
+	.func		= VEXPRESS_CONFIG_FUNC_SHUTDOWN,
+	.addr		= { VEXPRESS_SITE_MB, 0, 0, 0 },
+};
+
+static struct vexpress_config_device v2m_reboot_device = {
+	.name		= "mb:reboot",
+	.func		= VEXPRESS_CONFIG_FUNC_REBOOT,
+	.addr		= { VEXPRESS_SITE_MB, 0, 0, 0 },
+};
+
+static struct vexpress_config_device v2m_dvimode_device = {
+	.name		= "mb:dvimode",
+	.func		= VEXPRESS_CONFIG_FUNC_DVIMODE,
+	.addr		= { VEXPRESS_SITE_MB, 0, 0, 0 },
 };
 
 static AMBA_APB_DEVICE(aaci,  "mb:aaci",  0, V2M_AACI, IRQ_V2M_AACI, NULL);
@@ -323,123 +271,9 @@ static struct amba_device *v2m_amba_devs[] __initdata = {
 	&rtc_device,
 };
 
-
-static unsigned long v2m_osc_recalc_rate(struct clk_hw *hw,
-		unsigned long parent_rate)
-{
-	struct v2m_osc *osc = to_v2m_osc(hw);
-
-	return !parent_rate ? osc->rate_default : parent_rate;
-}
-
-static long v2m_osc_round_rate(struct clk_hw *hw, unsigned long rate,
-		unsigned long *parent_rate)
-{
-	struct v2m_osc *osc = to_v2m_osc(hw);
-
-	if (WARN_ON(rate < osc->rate_min))
-		rate = osc->rate_min;
-
-	if (WARN_ON(rate > osc->rate_max))
-		rate = osc->rate_max;
-
-	return rate;
-}
-
-static int v2m_osc_set_rate(struct clk_hw *hw, unsigned long rate,
-		unsigned long parent_rate)
-{
-	struct v2m_osc *osc = to_v2m_osc(hw);
-
-	v2m_cfg_write(SYS_CFG_OSC | SYS_CFG_SITE(osc->site) |
-			SYS_CFG_STACK(osc->stack) | osc->osc, rate);
-
-	return 0;
-}
-
-static struct clk_ops v2m_osc_ops = {
-	.recalc_rate = v2m_osc_recalc_rate,
-	.round_rate = v2m_osc_round_rate,
-	.set_rate = v2m_osc_set_rate,
-};
-
-struct clk * __init v2m_osc_register(const char *name, struct v2m_osc *osc)
-{
-	struct clk_init_data init;
-
-	WARN_ON(osc->site > 2);
-	WARN_ON(osc->stack > 15);
-	WARN_ON(osc->osc > 4095);
-
-	init.name = name;
-	init.ops = &v2m_osc_ops;
-	init.flags = CLK_IS_ROOT;
-	init.num_parents = 0;
-
-	osc->hw.init = &init;
-
-	return clk_register(NULL, &osc->hw);
-}
-
-static struct v2m_osc v2m_mb_osc1 = {
-	.site = SYS_CFG_SITE_MB,
-	.osc = 1,
-	.rate_min = 23750000,
-	.rate_max = 63500000,
-	.rate_default = 23750000,
-};
-
-static const char *v2m_ref_clk_periphs[] __initconst = {
-	"mb:wdt",   "1000f000.wdt",  "1c0f0000.wdt",	/* SP805 WDT */
-};
-
-static const char *v2m_osc1_periphs[] __initconst = {
-	"mb:clcd",  "1001f000.clcd", "1c1f0000.clcd",	/* PL111 CLCD */
-};
-
-static const char *v2m_osc2_periphs[] __initconst = {
-	"mb:mmci",  "10005000.mmci", "1c050000.mmci",	/* PL180 MMCI */
-	"mb:kmi0",  "10006000.kmi",  "1c060000.kmi",	/* PL050 KMI0 */
-	"mb:kmi1",  "10007000.kmi",  "1c070000.kmi",	/* PL050 KMI1 */
-	"mb:uart0", "10009000.uart", "1c090000.uart",	/* PL011 UART0 */
-	"mb:uart1", "1000a000.uart", "1c0a0000.uart",	/* PL011 UART1 */
-	"mb:uart2", "1000b000.uart", "1c0b0000.uart",	/* PL011 UART2 */
-	"mb:uart3", "1000c000.uart", "1c0c0000.uart",	/* PL011 UART3 */
-};
-
-static void __init v2m_clk_init(void)
-{
-	struct clk *clk;
-	int i;
-
-	clk = clk_register_fixed_rate(NULL, "dummy_apb_pclk", NULL,
-			CLK_IS_ROOT, 0);
-	WARN_ON(clk_register_clkdev(clk, "apb_pclk", NULL));
-
-	clk = clk_register_fixed_rate(NULL, "mb:ref_clk", NULL,
-			CLK_IS_ROOT, 32768);
-	for (i = 0; i < ARRAY_SIZE(v2m_ref_clk_periphs); i++)
-		WARN_ON(clk_register_clkdev(clk, NULL, v2m_ref_clk_periphs[i]));
-
-	clk = clk_register_fixed_rate(NULL, "mb:sp804_clk", NULL,
-			CLK_IS_ROOT, 1000000);
-	WARN_ON(clk_register_clkdev(clk, "v2m-timer0", "sp804"));
-	WARN_ON(clk_register_clkdev(clk, "v2m-timer1", "sp804"));
-
-	clk = v2m_osc_register("mb:osc1", &v2m_mb_osc1);
-	for (i = 0; i < ARRAY_SIZE(v2m_osc1_periphs); i++)
-		WARN_ON(clk_register_clkdev(clk, NULL, v2m_osc1_periphs[i]));
-
-	clk = clk_register_fixed_rate(NULL, "mb:osc2", NULL,
-			CLK_IS_ROOT, 24000000);
-	for (i = 0; i < ARRAY_SIZE(v2m_osc2_periphs); i++)
-		WARN_ON(clk_register_clkdev(clk, NULL, v2m_osc2_periphs[i]));
-}
-
 static void __init v2m_timer_init(void)
 {
-	v2m_sysctl_init(ioremap(V2M_SYSCTL, SZ_4K));
-	v2m_clk_init();
+	vexpress_clk_init(ioremap(V2M_SYSCTL, SZ_4K));
 	v2m_sp804_init(ioremap(V2M_TIMER01, SZ_4K), IRQ_V2M_TIMER0);
 }
 
@@ -451,19 +285,7 @@ static void __init v2m_init_early(void)
 {
 	if (ct_desc->init_early)
 		ct_desc->init_early();
-	versatile_sched_clock_init(v2m_sysreg_base + V2M_SYS_24MHZ, 24000000);
-}
-
-static void v2m_power_off(void)
-{
-	if (v2m_cfg_write(SYS_CFG_SHUTDOWN | SYS_CFG_SITE(SYS_CFG_SITE_MB), 0))
-		printk(KERN_EMERG "Unable to shutdown\n");
-}
-
-static void v2m_restart(char str, const char *cmd)
-{
-	if (v2m_cfg_write(SYS_CFG_REBOOT | SYS_CFG_SITE(SYS_CFG_SITE_MB), 0))
-		printk(KERN_EMERG "Unable to reboot\n");
+	versatile_sched_clock_init(vexpress_get_24mhz_clock_base(), 24000000);
 }
 
 struct ct_desc *ct_desc;
@@ -480,7 +302,7 @@ static void __init v2m_populate_ct_desc(void)
 	u32 current_tile_id;
 
 	ct_desc = NULL;
-	current_tile_id = readl(v2m_sysreg_base + V2M_SYS_PROCID0)
+	current_tile_id = vexpress_get_procid(VEXPRESS_SITE_MASTER)
 				& V2M_CT_ID_MASK;
 
 	for (i = 0; i < ARRAY_SIZE(ct_descs) && !ct_desc; ++i)
@@ -496,7 +318,7 @@ static void __init v2m_populate_ct_desc(void)
 static void __init v2m_map_io(void)
 {
 	iotable_init(v2m_io_desc, ARRAY_SIZE(v2m_io_desc));
-	v2m_sysreg_base = ioremap(V2M_SYSREGS, SZ_4K);
+	vexpress_sysreg_early_init(ioremap(V2M_SYSREGS, SZ_4K));
 	v2m_populate_ct_desc();
 	ct_desc->map_io();
 }
@@ -513,6 +335,12 @@ static void __init v2m_init(void)
 	regulator_register_fixed(0, v2m_eth_supplies,
 			ARRAY_SIZE(v2m_eth_supplies));
 
+	vexpress_config_device_register(&v2m_muxfpga_device);
+	vexpress_config_device_register(&v2m_shutdown_device);
+	vexpress_config_device_register(&v2m_reboot_device);
+	vexpress_config_device_register(&v2m_dvimode_device);
+
+	platform_device_register(&v2m_sysreg_device);
 	platform_device_register(&v2m_pcie_i2c_device);
 	platform_device_register(&v2m_ddc_i2c_device);
 	platform_device_register(&v2m_flash_device);
@@ -523,7 +351,7 @@ static void __init v2m_init(void)
 	for (i = 0; i < ARRAY_SIZE(v2m_amba_devs); i++)
 		amba_device_register(v2m_amba_devs[i], &iomem_resource);
 
-	pm_power_off = v2m_power_off;
+	pm_power_off = vexpress_power_off;
 
 	ct_desc->init_tile();
 }
@@ -536,7 +364,7 @@ MACHINE_START(VEXPRESS, "ARM-Versatile Express")
 	.timer		= &v2m_timer,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= v2m_init,
-	.restart	= v2m_restart,
+	.restart	= vexpress_restart,
 MACHINE_END
 
 #if defined(CONFIG_ARCH_VEXPRESS_DT)
@@ -579,20 +407,13 @@ void __init v2m_dt_map_io(void)
 
 void __init v2m_dt_init_early(void)
 {
-	struct device_node *node;
 	u32 dt_hbi;
 
-	node = of_find_compatible_node(NULL, NULL, "arm,vexpress-sysreg");
-	v2m_sysreg_base = of_iomap(node, 0);
-	if (WARN_ON(!v2m_sysreg_base))
-		return;
+	vexpress_sysreg_of_early_init();
 
 	/* Confirm board type against DT property, if available */
 	if (of_property_read_u32(allnodes, "arm,hbi", &dt_hbi) == 0) {
-		int site = v2m_get_master_site();
-		u32 id = readl(v2m_sysreg_base + (site == SYS_CFG_SITE_DB2 ?
-				V2M_SYS_PROCID1 : V2M_SYS_PROCID0));
-		u32 hbi = id & SYS_PROCIDx_HBI_MASK;
+		u32 hbi = vexpress_get_hbi(VEXPRESS_SITE_MASTER);
 
 		if (WARN_ON(dt_hbi != hbi))
 			pr_warning("vexpress: DT HBI (%x) is not matching "
@@ -608,6 +429,7 @@ static  struct of_device_id vexpress_irq_match[] __initdata = {
 static void __init v2m_dt_init_irq(void)
 {
 	of_irq_init(vexpress_irq_match);
+	vexpress_config_of_populate();
 }
 
 static void __init v2m_dt_timer_init(void)
@@ -616,47 +438,34 @@ static void __init v2m_dt_timer_init(void)
 	const char *path;
 	int err;
 
-	node = of_find_compatible_node(NULL, NULL, "arm,sp810");
-	v2m_sysctl_init(of_iomap(node, 0));
-
-	v2m_clk_init();
+	vexpress_clk_of_init();
 
 	err = of_property_read_string(of_aliases, "arm,v2m_timer", &path);
 	if (WARN_ON(err))
 		return;
 	node = of_find_node_by_path(path);
 	v2m_sp804_init(of_iomap(node, 0), irq_of_parse_and_map(node, 0));
+
 	if (arch_timer_of_register() != 0)
 		twd_local_timer_of_register();
 
 	if (arch_timer_sched_clock_init() != 0)
-		versatile_sched_clock_init(v2m_sysreg_base + V2M_SYS_24MHZ, 24000000);
+		versatile_sched_clock_init(vexpress_get_24mhz_clock_base(),
+				24000000);
 }
 
 static struct sys_timer v2m_dt_timer = {
 	.init = v2m_dt_timer_init,
 };
 
-static struct of_dev_auxdata v2m_dt_auxdata_lookup[] __initdata = {
-	OF_DEV_AUXDATA("arm,vexpress-flash", V2M_NOR0, "physmap-flash",
-			&v2m_flash_data),
-	OF_DEV_AUXDATA("arm,primecell", V2M_MMCI, "mb:mmci", &v2m_mmci_data),
-	/* RS1 memory map */
-	OF_DEV_AUXDATA("arm,vexpress-flash", 0x08000000, "physmap-flash",
-			&v2m_flash_data),
-	OF_DEV_AUXDATA("arm,primecell", 0x1c050000, "mb:mmci", &v2m_mmci_data),
-	{}
-};
-
 static void __init v2m_dt_init(void)
 {
 	l2x0_of_init(0x00400000, 0xfe0fffff);
-	of_platform_populate(NULL, of_default_bus_match_table,
-			v2m_dt_auxdata_lookup, NULL);
-	pm_power_off = v2m_power_off;
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	pm_power_off = vexpress_power_off;
 }
 
-const static char *v2m_dt_match[] __initconst = {
+static const char * const v2m_dt_match[] __initconst = {
 	"arm,vexpress",
 	NULL,
 };
@@ -669,7 +478,7 @@ DT_MACHINE_START(VEXPRESS_DT, "ARM-Versatile Express")
 	.timer		= &v2m_dt_timer,
 	.init_machine	= v2m_dt_init,
 	.handle_irq	= gic_handle_irq,
-	.restart	= v2m_restart,
+	.restart	= vexpress_restart,
 MACHINE_END
 
 #endif
-- 
1.7.9.5
