From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 29 Nov 2011 15:11:10 +0000
Subject: [PATCH v3 2/5] ARM: vexpress: Get rid of MMIO_P2V
In-Reply-To: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
References: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1322579473-8804-3-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch gets rid of the MMIO_P2V and __MMPIO_P2V macros,
defining constant virtual base for motherboard and tile
peripherals instead.

Additionally, in preparation for the new motherboard memory
map, the motherboard peripherals are using base pointers
calculated in runtime, instead of compile-time calculated
values.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/include/asm/hardware/arm_timer.h         |    5 ++
 arch/arm/mach-vexpress/core.h                     |   11 +++-
 arch/arm/mach-vexpress/ct-ca9x4.c                 |   52 ++++------------
 arch/arm/mach-vexpress/include/mach/ct-ca9x4.h    |   13 ++---
 arch/arm/mach-vexpress/include/mach/motherboard.h |   52 ++++++++--------
 arch/arm/mach-vexpress/platsmp.c                  |    5 +-
 arch/arm/mach-vexpress/v2m.c                      |   68 ++++++++++++++-------
 7 files changed, 102 insertions(+), 104 deletions(-)

diff --git a/arch/arm/include/asm/hardware/arm_timer.h b/arch/arm/include/asm/hardware/arm_timer.h
index c0f4e7b..d6030ff 100644
--- a/arch/arm/include/asm/hardware/arm_timer.h
+++ b/arch/arm/include/asm/hardware/arm_timer.h
@@ -9,7 +9,12 @@
  *
  * Integrator AP has 16-bit timers, Integrator CP, Versatile and Realview
  * can have 16-bit or 32-bit selectable via a bit in the control register.
+ *
+ * Every SP804 contains two identical timers.
  */
+#define TIMER_1_BASE	0x00
+#define TIMER_2_BASE	0x20
+
 #define TIMER_LOAD	0x00			/* ACVR rw */
 #define TIMER_VALUE	0x04			/* ACVR ro */
 #define TIMER_CTRL	0x08			/* ACVR rw */
diff --git a/arch/arm/mach-vexpress/core.h b/arch/arm/mach-vexpress/core.h
index f439715..d3dd491 100644
--- a/arch/arm/mach-vexpress/core.h
+++ b/arch/arm/mach-vexpress/core.h
@@ -1,6 +1,3 @@
-#define __MMIO_P2V(x)	(((x) & 0xfffff) | (((x) & 0x0f000000) >> 4) | 0xf8000000)
-#define MMIO_P2V(x)	((void __iomem *)__MMIO_P2V(x))
-
 #define AMBA_DEVICE(name,busid,base,plat)	\
 struct amba_device name##_device = {		\
 	.dev		= {			\
@@ -17,3 +14,11 @@ struct amba_device name##_device = {		\
 	.irq		= IRQ_##base,		\
 	/* .dma		= DMA_##base,*/		\
 }
+
+/* 2MB large area for motherboard's peripherals static mapping */
+#define V2M_PERIPH 0xf8000000
+#define V2M_PERIPH_P2V(offset) ((void __iomem *)(V2M_PERIPH | (offset)))
+
+/* Tile's peripherals static mappings should start here */
+#define V2T_PERIPH 0xf8200000
+#define V2T_PERIPH_P2V(offset) ((void __iomem *)(V2T_PERIPH | (offset)))
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 2b1e836..bfd3919 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -30,57 +30,26 @@
 
 #include <plat/clcd.h>
 
-#define V2M_PA_CS7	0x10000000
-
 static struct map_desc ct_ca9x4_io_desc[] __initdata = {
 	{
-		.virtual	= __MMIO_P2V(CT_CA9X4_MPIC),
-		.pfn		= __phys_to_pfn(CT_CA9X4_MPIC),
-		.length		= SZ_16K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= __MMIO_P2V(CT_CA9X4_SP804_TIMER),
-		.pfn		= __phys_to_pfn(CT_CA9X4_SP804_TIMER),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= __MMIO_P2V(CT_CA9X4_L2CC),
-		.pfn		= __phys_to_pfn(CT_CA9X4_L2CC),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
+		.virtual        = V2T_PERIPH,
+		.pfn            = __phys_to_pfn(CT_CA9X4_MPIC),
+		.length         = SZ_8K,
+		.type           = MT_DEVICE,
 	},
 };
 
 static void __init ct_ca9x4_map_io(void)
 {
-#ifdef CONFIG_LOCAL_TIMERS
-	twd_base = MMIO_P2V(A9_MPCORE_TWD);
-#endif
 	iotable_init(ct_ca9x4_io_desc, ARRAY_SIZE(ct_ca9x4_io_desc));
 }
 
 static void __init ct_ca9x4_init_irq(void)
 {
-	gic_init(0, 29, MMIO_P2V(A9_MPCORE_GIC_DIST),
-		 MMIO_P2V(A9_MPCORE_GIC_CPU));
-}
-
-#if 0
-static void __init ct_ca9x4_timer_init(void)
-{
-	writel(0, MMIO_P2V(CT_CA9X4_TIMER0) + TIMER_CTRL);
-	writel(0, MMIO_P2V(CT_CA9X4_TIMER1) + TIMER_CTRL);
-
-	sp804_clocksource_init(MMIO_P2V(CT_CA9X4_TIMER1), "ct-timer1");
-	sp804_clockevents_init(MMIO_P2V(CT_CA9X4_TIMER0), IRQ_CT_CA9X4_TIMER0,
-		"ct-timer0");
+	gic_init(0, 29, V2T_PERIPH_P2V(A9_MPCORE_GIC_DIST),
+		 V2T_PERIPH_P2V(A9_MPCORE_GIC_CPU));
 }
 
-static struct sys_timer ct_ca9x4_timer = {
-	.init	= ct_ca9x4_timer_init,
-};
-#endif
-
 static void ct_ca9x4_clcd_enable(struct clcd_fb *fb)
 {
 	v2m_cfg_write(SYS_CFG_MUXFPGA | SYS_CFG_SITE_DB1, 0);
@@ -193,6 +162,9 @@ static struct platform_device pmu_device = {
 
 static void __init ct_ca9x4_init_early(void)
 {
+#ifdef CONFIG_LOCAL_TIMERS
+	twd_base = V2T_PERIPH_P2V(A9_MPCORE_TWD);
+#endif
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 }
 
@@ -201,7 +173,7 @@ static void __init ct_ca9x4_init(void)
 	int i;
 
 #ifdef CONFIG_CACHE_L2X0
-	void __iomem *l2x0_base = MMIO_P2V(CT_CA9X4_L2CC);
+	void __iomem *l2x0_base = ioremap(CT_CA9X4_L2CC, SZ_4K);
 
 	/* set RAM latencies to 1 cycle for this core tile. */
 	writel(0, l2x0_base + L2X0_TAG_LATENCY_CTRL);
@@ -219,7 +191,7 @@ static void __init ct_ca9x4_init(void)
 #ifdef CONFIG_SMP
 static void ct_ca9x4_init_cpu_map(void)
 {
-	int i, ncores = scu_get_core_count(MMIO_P2V(A9_MPCORE_SCU));
+	int i, ncores = scu_get_core_count(V2T_PERIPH_P2V(A9_MPCORE_SCU));
 
 	if (ncores > nr_cpu_ids) {
 		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
@@ -235,7 +207,7 @@ static void ct_ca9x4_init_cpu_map(void)
 
 static void ct_ca9x4_smp_enable(unsigned int max_cpus)
 {
-	scu_enable(MMIO_P2V(A9_MPCORE_SCU));
+	scu_enable(V2T_PERIPH_P2V(A9_MPCORE_SCU));
 }
 #endif
 
diff --git a/arch/arm/mach-vexpress/include/mach/ct-ca9x4.h b/arch/arm/mach-vexpress/include/mach/ct-ca9x4.h
index a34d3d4..8f962fb 100644
--- a/arch/arm/mach-vexpress/include/mach/ct-ca9x4.h
+++ b/arch/arm/mach-vexpress/include/mach/ct-ca9x4.h
@@ -22,14 +22,11 @@
 #define CT_CA9X4_SYSWDT		(0x1e007000)
 #define CT_CA9X4_L2CC		(0x1e00a000)
 
-#define CT_CA9X4_TIMER0		(CT_CA9X4_SP804_TIMER + 0x000)
-#define CT_CA9X4_TIMER1		(CT_CA9X4_SP804_TIMER + 0x020)
-
-#define A9_MPCORE_SCU		(CT_CA9X4_MPIC + 0x0000)
-#define A9_MPCORE_GIC_CPU	(CT_CA9X4_MPIC + 0x0100)
-#define A9_MPCORE_GIT		(CT_CA9X4_MPIC + 0x0200)
-#define A9_MPCORE_TWD		(CT_CA9X4_MPIC + 0x0600)
-#define A9_MPCORE_GIC_DIST	(CT_CA9X4_MPIC + 0x1000)
+#define A9_MPCORE_SCU		0x0000
+#define A9_MPCORE_GIC_CPU	0x0100
+#define A9_MPCORE_GIT		0x0200
+#define A9_MPCORE_TWD		0x0600
+#define A9_MPCORE_GIC_DIST	0x1000
 
 /*
  * Interrupts.  Those in {} are for AMBA devices
diff --git a/arch/arm/mach-vexpress/include/mach/motherboard.h b/arch/arm/mach-vexpress/include/mach/motherboard.h
index 0a3a375..b4c498c 100644
--- a/arch/arm/mach-vexpress/include/mach/motherboard.h
+++ b/arch/arm/mach-vexpress/include/mach/motherboard.h
@@ -39,33 +39,30 @@
 #define V2M_CF			(V2M_PA_CS7 + 0x0001a000)
 #define V2M_CLCD		(V2M_PA_CS7 + 0x0001f000)
 
-#define V2M_SYS_ID		(V2M_SYSREGS + 0x000)
-#define V2M_SYS_SW		(V2M_SYSREGS + 0x004)
-#define V2M_SYS_LED		(V2M_SYSREGS + 0x008)
-#define V2M_SYS_100HZ		(V2M_SYSREGS + 0x024)
-#define V2M_SYS_FLAGS		(V2M_SYSREGS + 0x030)
-#define V2M_SYS_FLAGSSET	(V2M_SYSREGS + 0x030)
-#define V2M_SYS_FLAGSCLR	(V2M_SYSREGS + 0x034)
-#define V2M_SYS_NVFLAGS		(V2M_SYSREGS + 0x038)
-#define V2M_SYS_NVFLAGSSET	(V2M_SYSREGS + 0x038)
-#define V2M_SYS_NVFLAGSCLR	(V2M_SYSREGS + 0x03c)
-#define V2M_SYS_MCI		(V2M_SYSREGS + 0x048)
-#define V2M_SYS_FLASH		(V2M_SYSREGS + 0x03c)
-#define V2M_SYS_CFGSW		(V2M_SYSREGS + 0x058)
-#define V2M_SYS_24MHZ		(V2M_SYSREGS + 0x05c)
-#define V2M_SYS_MISC		(V2M_SYSREGS + 0x060)
-#define V2M_SYS_DMA		(V2M_SYSREGS + 0x064)
-#define V2M_SYS_PROCID0		(V2M_SYSREGS + 0x084)
-#define V2M_SYS_PROCID1		(V2M_SYSREGS + 0x088)
-#define V2M_SYS_CFGDATA		(V2M_SYSREGS + 0x0a0)
-#define V2M_SYS_CFGCTRL		(V2M_SYSREGS + 0x0a4)
-#define V2M_SYS_CFGSTAT		(V2M_SYSREGS + 0x0a8)
-
-#define V2M_TIMER0		(V2M_TIMER01 + 0x000)
-#define V2M_TIMER1		(V2M_TIMER01 + 0x020)
-
-#define V2M_TIMER2		(V2M_TIMER23 + 0x000)
-#define V2M_TIMER3		(V2M_TIMER23 + 0x020)
+/*
+ * Offsets from SYSREGS base
+ */
+#define V2M_SYS_ID		0x000
+#define V2M_SYS_SW		0x004
+#define V2M_SYS_LED		0x008
+#define V2M_SYS_100HZ		0x024
+#define V2M_SYS_FLAGS		0x030
+#define V2M_SYS_FLAGSSET	0x030
+#define V2M_SYS_FLAGSCLR	0x034
+#define V2M_SYS_NVFLAGS		0x038
+#define V2M_SYS_NVFLAGSSET	0x038
+#define V2M_SYS_NVFLAGSCLR	0x03c
+#define V2M_SYS_MCI		0x048
+#define V2M_SYS_FLASH		0x03c
+#define V2M_SYS_CFGSW		0x058
+#define V2M_SYS_24MHZ		0x05c
+#define V2M_SYS_MISC		0x060
+#define V2M_SYS_DMA		0x064
+#define V2M_SYS_PROCID0		0x084
+#define V2M_SYS_PROCID1		0x088
+#define V2M_SYS_CFGDATA		0x0a0
+#define V2M_SYS_CFGCTRL		0x0a4
+#define V2M_SYS_CFGSTAT		0x0a8
 
 
 /*
@@ -117,6 +114,7 @@
 
 int v2m_cfg_write(u32 devfn, u32 data);
 int v2m_cfg_read(u32 devfn, u32 *data);
+void v2m_flags_set(u32 data);
 
 /*
  * Core tile IDs
diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index 124ffb1..a1ed6d6 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -14,7 +14,6 @@
 #include <linux/io.h>
 
 #include <mach/motherboard.h>
-#define V2M_PA_CS7 0x10000000
 
 #include "core.h"
 
@@ -43,7 +42,5 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 	 * until it receives a soft interrupt, and then the
 	 * secondary CPU branches to this address.
 	 */
-	writel(~0, MMIO_P2V(V2M_SYS_FLAGSCLR));
-	writel(virt_to_phys(versatile_secondary_startup),
-		MMIO_P2V(V2M_SYS_FLAGSSET));
+	v2m_flags_set(virt_to_phys(versatile_secondary_startup));
 }
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 1fafc32..0aa254a 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -39,29 +39,45 @@
 
 static struct map_desc v2m_io_desc[] __initdata = {
 	{
-		.virtual	= __MMIO_P2V(V2M_PA_CS7),
+		.virtual	= V2M_PERIPH,
 		.pfn		= __phys_to_pfn(V2M_PA_CS7),
 		.length		= SZ_128K,
 		.type		= MT_DEVICE,
 	},
 };
 
-static void __init v2m_timer_init(void)
+static void __iomem *v2m_sysreg_base;
+
+static void __init v2m_sysctl_init(void __iomem *base)
 {
 	u32 scctrl;
 
+	if (WARN_ON(!base))
+		return;
+
 	/* Select 1MHz TIMCLK as the reference clock for SP804 timers */
-	scctrl = readl(MMIO_P2V(V2M_SYSCTL + SCCTRL));
+	scctrl = readl(base + SCCTRL);
 	scctrl |= SCCTRL_TIMEREN0SEL_TIMCLK;
 	scctrl |= SCCTRL_TIMEREN1SEL_TIMCLK;
-	writel(scctrl, MMIO_P2V(V2M_SYSCTL + SCCTRL));
+	writel(scctrl, base + SCCTRL);
+}
 
-	writel(0, MMIO_P2V(V2M_TIMER0) + TIMER_CTRL);
-	writel(0, MMIO_P2V(V2M_TIMER1) + TIMER_CTRL);
+static void __init v2m_sp804_init(void __iomem *base, unsigned int irq)
+{
+	if (WARN_ON(!base || irq == NO_IRQ))
+		return;
+
+	writel(0, base + TIMER_1_BASE + TIMER_CTRL);
+	writel(0, base + TIMER_2_BASE + TIMER_CTRL);
 
-	sp804_clocksource_init(MMIO_P2V(V2M_TIMER1), "v2m-timer1");
-	sp804_clockevents_init(MMIO_P2V(V2M_TIMER0), IRQ_V2M_TIMER0,
-		"v2m-timer0");
+	sp804_clocksource_init(base + TIMER_2_BASE, "v2m-timer1");
+	sp804_clockevents_init(base + TIMER_1_BASE, irq, "v2m-timer0");
+}
+
+static void __init v2m_timer_init(void)
+{
+	v2m_sysctl_init(ioremap(V2M_SYSCTL, SZ_4K));
+	v2m_sp804_init(ioremap(V2M_TIMER01, SZ_4K), IRQ_V2M_TIMER0);
 }
 
 static struct sys_timer v2m_timer = {
@@ -81,14 +97,14 @@ int v2m_cfg_write(u32 devfn, u32 data)
 	devfn |= SYS_CFG_START | SYS_CFG_WRITE;
 
 	spin_lock(&v2m_cfg_lock);
-	val = readl(MMIO_P2V(V2M_SYS_CFGSTAT));
-	writel(val & ~SYS_CFG_COMPLETE, MMIO_P2V(V2M_SYS_CFGSTAT));
+	val = readl(v2m_sysreg_base + V2M_SYS_CFGSTAT);
+	writel(val & ~SYS_CFG_COMPLETE, v2m_sysreg_base + V2M_SYS_CFGSTAT);
 
-	writel(data, MMIO_P2V(V2M_SYS_CFGDATA));
-	writel(devfn, MMIO_P2V(V2M_SYS_CFGCTRL));
+	writel(data, v2m_sysreg_base +  V2M_SYS_CFGDATA);
+	writel(devfn, v2m_sysreg_base + V2M_SYS_CFGCTRL);
 
 	do {
-		val = readl(MMIO_P2V(V2M_SYS_CFGSTAT));
+		val = readl(v2m_sysreg_base + V2M_SYS_CFGSTAT);
 	} while (val == 0);
 	spin_unlock(&v2m_cfg_lock);
 
@@ -102,22 +118,28 @@ int v2m_cfg_read(u32 devfn, u32 *data)
 	devfn |= SYS_CFG_START;
 
 	spin_lock(&v2m_cfg_lock);
-	writel(0, MMIO_P2V(V2M_SYS_CFGSTAT));
-	writel(devfn, MMIO_P2V(V2M_SYS_CFGCTRL));
+	writel(0, v2m_sysreg_base + V2M_SYS_CFGSTAT);
+	writel(devfn, v2m_sysreg_base + V2M_SYS_CFGCTRL);
 
 	mb();
 
 	do {
 		cpu_relax();
-		val = readl(MMIO_P2V(V2M_SYS_CFGSTAT));
+		val = readl(v2m_sysreg_base + V2M_SYS_CFGSTAT);
 	} while (val == 0);
 
-	*data = readl(MMIO_P2V(V2M_SYS_CFGDATA));
+	*data = readl(v2m_sysreg_base + V2M_SYS_CFGDATA);
 	spin_unlock(&v2m_cfg_lock);
 
 	return !!(val & SYS_CFG_ERR);
 }
 
+void __init v2m_flags_set(u32 data)
+{
+	writel(~0, v2m_sysreg_base + V2M_SYS_FLAGSCLR);
+	writel(data, v2m_sysreg_base + V2M_SYS_FLAGSSET);
+}
+
 
 static struct resource v2m_pcie_i2c_resource = {
 	.start	= V2M_SERIAL_BUS_PCI,
@@ -203,7 +225,7 @@ static struct platform_device v2m_usb_device = {
 
 static void v2m_flash_set_vpp(struct platform_device *pdev, int on)
 {
-	writel(on != 0, MMIO_P2V(V2M_SYS_FLASH));
+	writel(on != 0, v2m_sysreg_base + V2M_SYS_FLASH);
 }
 
 static struct physmap_flash_data v2m_flash_data = {
@@ -257,7 +279,7 @@ static struct platform_device v2m_cf_device = {
 
 static unsigned int v2m_mmci_status(struct device *dev)
 {
-	return readl(MMIO_P2V(V2M_SYS_MCI)) & (1 << 0);
+	return readl(v2m_sysreg_base + V2M_SYS_MCI) & (1 << 0);
 }
 
 static struct mmci_platform_data v2m_mmci_data = {
@@ -370,7 +392,7 @@ static void __init v2m_init_early(void)
 {
 	ct_desc->init_early();
 	clkdev_add_table(v2m_lookups, ARRAY_SIZE(v2m_lookups));
-	versatile_sched_clock_init(MMIO_P2V(V2M_SYS_24MHZ), 24000000);
+	versatile_sched_clock_init(v2m_sysreg_base + V2M_SYS_24MHZ, 24000000);
 }
 
 static void v2m_power_off(void)
@@ -399,7 +421,8 @@ static void __init v2m_populate_ct_desc(void)
 	u32 current_tile_id;
 
 	ct_desc = NULL;
-	current_tile_id = readl(MMIO_P2V(V2M_SYS_PROCID0)) & V2M_CT_ID_MASK;
+	current_tile_id = readl(v2m_sysreg_base + V2M_SYS_PROCID0)
+				& V2M_CT_ID_MASK;
 
 	for (i = 0; i < ARRAY_SIZE(ct_descs) && !ct_desc; ++i)
 		if (ct_descs[i]->id == current_tile_id)
@@ -413,6 +436,7 @@ static void __init v2m_populate_ct_desc(void)
 static void __init v2m_map_io(void)
 {
 	iotable_init(v2m_io_desc, ARRAY_SIZE(v2m_io_desc));
+	v2m_sysreg_base = V2M_PERIPH_P2V(V2M_SYSREGS);
 	v2m_populate_ct_desc();
 	ct_desc->map_io();
 }
-- 
1.6.3.3
