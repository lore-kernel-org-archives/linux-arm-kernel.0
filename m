From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 22 Sep 2011 17:23:31 +0100
Subject: DT vs ARM static mappings
In-Reply-To: <201109202128.55517.arnd@arndb.de>
References: <1316519479.4611.150.camel@hornet.cambridge.arm.com>
	<4E78A546.9040604@gmail.com>
	<1316535403.4611.534.camel@hornet.cambridge.arm.com>
	<201109202128.55517.arnd@arndb.de>
Message-ID: <1316708611.4611.873.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> - map the entire I/O area in map_io(), depending on the board
> - have an __iomem pointer for the sysreg
> - populate that pointer using of_iomap from the device tree address
>   before you first access it.

Ok, so what I came with is below... It's based more-or-less on top of
Dave's patch (it's just a development snapshot, don't treat it as a
final proposal).

Executive summary:

* I have second map_desc with pfn for RS1 memory map, but using the same
virtual address as the legacy one. The legacy one is used if root of the
tree is compatible with "arm,vexpress-legacy".

* The devices I need to use in v2m.c have aliases in DTS so I can find
their offsets in the flat tree (the *_find_node_by_alias() function is
rather generic and could be moved to drivers/of/fdt.c if you think it
would be useful for others).

* There are no more users of MMIO_P2V in v2m.c, next thing I will do is
the same in core tile; then the macro can be killed. Once this happens
the virtual address currently taken from __MMIO_P2V(V2M_PA_CS7) will be
replaced by some kind of "#define V2M_PERIPH_BASE 0xf8000000".

* Once Nico's changes regarding static maps are in, the manual pointer
operations in v2m_dt_map_io can be replaced with neat ioremap()-s.

All feedback appreciated, cheers!

Pawe?

diff --git a/arch/arm/boot/dts/vexpress-v2m-legacy.dtsi b/arch/arm/boot/dts/vexpress-v2m-legacy.dtsi
index cb18052..ec40e5c 100644
--- a/arch/arm/boot/dts/vexpress-v2m-legacy.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m-legacy.dtsi
@@ -9,6 +9,10 @@
 		serial3 = &uart3;
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
+		timer01 = &timer01;
+		timer23 = &timer23;
+		sysreg = &sysreg;
+		sysctl = &sysctl;
 	};
 
 	motherboard {
@@ -48,6 +52,16 @@
 			#size-cells = <1>;
 			ranges = <0 7 0 0x20000>;
 
+			sysreg: sysreg at 00000 {
+				compatible = "arm,vexpress-sysreg";
+				reg = <0x00000 0x1000>;
+			};
+
+			sysctl: sysctl at 01000 {
+				compatible = "arm,sp810";
+				reg = <0x01000 0x1000>;
+			};
+
 			// PCI-E I2C bus
 			i2c0: i2c at 02000 {
 				compatible = "arm,versatile-i2c";
@@ -116,6 +130,16 @@
 				interrupts = <0>;
 			};
 
+			timer01: timer at 11000 {
+				compatible = "arm,sp804", "arm,primecell";
+				reg = <0x11000 0x1000>;
+			};
+
+			timer23: timer at 12000 {
+				compatible = "arm,sp804", "arm,primecell";
+				reg = <0x12000 0x1000>;
+			};
+
 			// DVI I2C bus
 			i2c1: i2c at 16000 {
 				compatible = "arm,versatile-i2c";
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
index 5fc4871..dadaae1 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca9.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
@@ -6,7 +6,7 @@
 
 / {
 	model = "ARM Versatile Express";
-	compatible = "arm,vexpress-v2p-ca9", "arm,vexpress";
+	compatible = "arm,vexpress-v2p-ca9", "arm,vexpress-legacy", "arm,vexpress";
 	interrupt-parent = <&intc>;
 
 	memory {
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
diff --git a/arch/arm/mach-vexpress/include/mach/motherboard.h b/arch/arm/mach-vexpress/include/mach/motherboard.h
index 0a3a375..0b42b96 100644
--- a/arch/arm/mach-vexpress/include/mach/motherboard.h
+++ b/arch/arm/mach-vexpress/include/mach/motherboard.h
@@ -39,34 +39,27 @@
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
-
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
  * Interrupts.  Those in {} are for AMBA devices
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index ed00d52..16e4006 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -6,6 +6,8 @@
 #include <linux/amba/mmci.h>
 #include <linux/io.h>
 #include <linux/init.h>
+#include <linux/of_address.h>
+#include <linux/of_fdt.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -33,13 +35,14 @@
 
 #include "core.h"
 
+/* Legacy memory map values for backward compatibility */
 #define V2M_PA_CS0	0x40000000
 #define V2M_PA_CS1	0x44000000
 #define V2M_PA_CS2	0x48000000
 #define V2M_PA_CS3	0x4c000000
 #define V2M_PA_CS7	0x10000000
 
-static struct map_desc v2m_io_desc[] __initdata = {
+static struct map_desc v2m_legacy_io_desc[] __initdata = {
 	{
 		.virtual	= __MMIO_P2V(V2M_PA_CS7),
 		.pfn		= __phys_to_pfn(V2M_PA_CS7),
@@ -48,21 +51,36 @@ static struct map_desc v2m_io_desc[] __initdata = {
 	},
 };
 
+static struct map_desc v2m_rs1_io_desc[] __initdata = {
+	{
+		.virtual	= __MMIO_P2V(V2M_PA_CS7),
+		.pfn		= __phys_to_pfn(0x1c000000),
+		.length		= SZ_2M,
+		.type		= MT_DEVICE,
+	},
+};
+
+static void __iomem *v2m_sysreg_base;
+static void __iomem *v2m_sysctl_base;
+static void __iomem *v2m_timer01_base;
+
+
+
 static void __init v2m_timer_init(void)
 {
 	u32 scctrl;
 
 	/* Select 1MHz TIMCLK as the reference clock for SP804 timers */
-	scctrl = readl(MMIO_P2V(V2M_SYSCTL + SCCTRL));
+	scctrl = readl(v2m_sysctl_base + SCCTRL);
 	scctrl |= SCCTRL_TIMEREN0SEL_TIMCLK;
 	scctrl |= SCCTRL_TIMEREN1SEL_TIMCLK;
-	writel(scctrl, MMIO_P2V(V2M_SYSCTL + SCCTRL));
+	writel(scctrl, v2m_sysctl_base + SCCTRL);
 
-	writel(0, MMIO_P2V(V2M_TIMER0) + TIMER_CTRL);
-	writel(0, MMIO_P2V(V2M_TIMER1) + TIMER_CTRL);
+	writel(0, v2m_timer01_base + TIMER_1_BASE + TIMER_CTRL);
+	writel(0, v2m_timer01_base + TIMER_2_BASE + TIMER_CTRL);
 
-	sp804_clocksource_init(MMIO_P2V(V2M_TIMER1), "v2m-timer1");
-	sp804_clockevents_init(MMIO_P2V(V2M_TIMER0), IRQ_V2M_TIMER0,
+	sp804_clocksource_init(v2m_timer01_base + TIMER_1_BASE, "v2m-timer1");
+	sp804_clockevents_init(v2m_timer01_base + TIMER_2_BASE, IRQ_V2M_TIMER0,
 		"v2m-timer0");
 }
 
@@ -83,14 +101,14 @@ int v2m_cfg_write(u32 devfn, u32 data)
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
 
@@ -104,17 +122,17 @@ int v2m_cfg_read(u32 devfn, u32 *data)
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
@@ -205,7 +223,7 @@ static struct platform_device v2m_usb_device = {
 
 static void v2m_flash_set_vpp(struct platform_device *pdev, int on)
 {
-	writel(on != 0, MMIO_P2V(V2M_SYS_FLASH));
+	writel(on != 0, v2m_sysreg_base + V2M_SYS_FLASH);
 }
 
 static struct physmap_flash_data v2m_flash_data = {
@@ -259,7 +277,7 @@ static struct platform_device v2m_cf_device = {
 
 static unsigned int v2m_mmci_status(struct device *dev)
 {
-	return readl(MMIO_P2V(V2M_SYS_MCI)) & (1 << 0);
+	return readl(v2m_sysreg_base + V2M_SYS_MCI) & (1 << 0);
 }
 
 static struct mmci_platform_data v2m_mmci_data = {
@@ -372,7 +390,7 @@ static void __init v2m_init_early(void)
 {
 	ct_desc->init_early();
 	clkdev_add_table(v2m_lookups, ARRAY_SIZE(v2m_lookups));
-	versatile_sched_clock_init(MMIO_P2V(V2M_SYS_24MHZ), 24000000);
+	versatile_sched_clock_init(v2m_sysreg_base + V2M_SYS_24MHZ, 24000000);
 }
 
 static void v2m_power_off(void)
@@ -401,7 +419,8 @@ static void __init v2m_populate_ct_desc(void)
 	u32 current_tile_id;
 
 	ct_desc = NULL;
-	current_tile_id = readl(MMIO_P2V(V2M_SYS_PROCID0)) & V2M_CT_ID_MASK;
+	current_tile_id = readl(v2m_sysreg_base + V2M_SYS_PROCID0)
+				& V2M_CT_ID_MASK;
 
 	for (i = 0; i < ARRAY_SIZE(ct_descs) && !ct_desc; ++i)
 		if (ct_descs[i]->id == current_tile_id)
@@ -414,7 +433,10 @@ static void __init v2m_populate_ct_desc(void)
 
 static void __init v2m_map_io(void)
 {
-	iotable_init(v2m_io_desc, ARRAY_SIZE(v2m_io_desc));
+	iotable_init(v2m_legacy_io_desc, ARRAY_SIZE(v2m_legacy_io_desc));
+	v2m_sysreg_base = MMIO_P2V(V2M_SYSREGS);
+	v2m_sysctl_base = MMIO_P2V(V2M_SYSCTL);
+	v2m_timer01_base = MMIO_P2V(V2M_TIMER01);
 	v2m_populate_ct_desc();
 	ct_desc->map_io();
 }
@@ -472,6 +494,135 @@ struct of_dev_auxdata v2m_dt_auxdata_lookup[] __initdata = {
 	{}
 };
 
+struct v2m_dt_find_alias_state {
+	const char *alias;
+	unsigned long node;
+	const char *path;
+	int depth;
+	int token_len;
+
+};
+
+static int __init v2m_dt_scan_path(unsigned long node,
+		const char *uname, int depth, void *data)
+{
+	struct v2m_dt_find_alias_state *state = data;
+
+	pr_debug("%s: uname='%s', depth=%d, state->path='%s', state->depth=%d,"
+			" state->token_len=%d\n", __func__, uname, depth,
+			state->path, state->depth, state->token_len);
+
+	/* If the depth decreases, we didn't find the path */
+	if (depth < state->depth)
+		return -ENOENT;
+
+	/* Check if path ~= /^uname[\/\0]/ */
+	if (strncmp(state->path, uname, state->token_len) == 0 &&
+			uname[state->token_len] == 0) {
+		const char *slash;
+
+		state->depth++;
+		state->path += state->token_len; /* Next token */
+		if (*state->path == 0) { /* All path tokens processed? */
+			state->node = node;
+			return 1; /* Success! */
+		}
+		BUG_ON(*state->path != '/');
+		state->path++; /* Skip leading slash */
+		slash = strchr(state->path, '/');
+		if (!slash)
+			state->token_len = strlen(state->path);
+		else
+			state->token_len = slash - state->path;
+	}
+
+	return 0;
+}
+
+static int __init v2m_dt_scan_alias(unsigned long node,
+		const char *uname, int depth, void *data)
+{
+	int res;
+	struct v2m_dt_find_alias_state *state = data;
+	
+	if (depth != 1 || strcmp(uname, "aliases") != 0)
+		return 0;
+
+	state->path = of_get_flat_dt_prop(node, state->alias, NULL);
+	if (!state->path)
+		return -ENXIO;
+	if (*state->path != '/')
+		return -EFAULT;
+
+	state->token_len = 0; /* Root node has no name */
+	res = of_scan_flat_dt(v2m_dt_scan_path, state);
+	if (res == 0) /* Whole tree scanned, no path found */
+		res = -ENOENT;
+
+	return res;
+}
+
+static int __init v2m_dt_find_node_by_alias(const char *alias,
+		unsigned long *node)
+{
+	int err;
+	struct v2m_dt_find_alias_state state = {
+		.alias = alias,
+	};
+
+	err = of_scan_flat_dt(v2m_dt_scan_alias, &state);
+	
+	if (err > 0)
+		*node = state.node;
+
+	return err;
+}
+
+static unsigned long __init v2m_dt_periph_offset(const char *alias)
+{
+	unsigned long node;
+	__be32 *reg;
+	unsigned long len;
+	unsigned long offset;
+
+	if (v2m_dt_find_node_by_alias(alias, &node) <= 0)
+		panic("%s(): Can't get offset for '%s'!\n", __func__, alias);
+
+	reg = of_get_flat_dt_prop(node, "reg", &len);
+	if (!reg)
+		panic("%s(): Can't get reg property for '%s'!\n",
+				__func__, alias);
+
+	return be32_to_cpup(reg);
+}
+
+static void __init v2m_dt_map_io(void)
+{
+	void __iomem *periph_base;
+
+	if (of_flat_dt_is_compatible(of_get_flat_dt_root(),
+				"arm,vexpress-legacy")) {
+		pr_info("v2m: Legacy memory map.\n");
+		iotable_init(v2m_legacy_io_desc,
+				ARRAY_SIZE(v2m_legacy_io_desc));
+		/* Won't be needed once we can call ioremap() in map_io */
+		periph_base = (void __iomem *)v2m_legacy_io_desc[0].virtual;
+	} else {
+		printk("v2m: RS1 memory map.\n");
+		iotable_init(v2m_rs1_io_desc,
+				ARRAY_SIZE(v2m_rs1_io_desc));
+		/* Won't be needed once we can call ioremap() in map_io */
+		periph_base = (void __iomem *)v2m_legacy_io_desc[0].virtual;
+	}
+
+	v2m_sysreg_base = periph_base + v2m_dt_periph_offset("sysreg");
+	v2m_sysctl_base = periph_base + v2m_dt_periph_offset("sysctl");
+	v2m_timer01_base = periph_base + v2m_dt_periph_offset("timer01");
+
+	v2m_populate_ct_desc();
+	ct_desc->map_io();
+}
+
 static void __init v2m_dt_init(void)
 {
 	of_platform_populate(NULL, of_default_bus_match_table,
@@ -489,7 +640,7 @@ static const char *v2m_dt_match[] __initconst = {
 };
 
 DT_MACHINE_START(VEXPRESS_DT, "ARM-Versatile Express")
-	.map_io		= v2m_map_io,
+	.map_io		= v2m_dt_map_io,
 	.init_early	= v2m_init_early,
 	.init_irq	= v2m_init_irq,
 	.timer		= &v2m_timer,
