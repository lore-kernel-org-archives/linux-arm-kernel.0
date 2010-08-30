From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 30 Aug 2010 16:13:55 +0530
Subject: [PATCH 27/74] ST SPEAr : NAND interface driver for spear platforms
In-Reply-To: <07ce8daf18d3a9f13864752074af3490a324d84c.1283161023.git.viresh.kumar@st.com>
References: <07ce8daf18d3a9f13864752074af3490a324d84c.1283161023.git.viresh.kumar@st.com>
Message-ID: <7cd7060b403b448d74649cec5c28c795bcbbdbc3.1283161023.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vipin Kumar <vipin.kumar@st.com>

SPEAr platforms use Flexible Static Memory Controller(FSMC) provided by ST for
interfacing with NAND devices.
This patch adds the support for glue logic for NAND flash on SPEAr boards

Signed-off-by: Vipin Kumar <vipin.kumar@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear13xx/clock.c                  |    2 +-
 arch/arm/mach-spear13xx/include/mach/generic.h   |    2 +
 arch/arm/mach-spear13xx/include/mach/misc_regs.h |   10 +
 arch/arm/mach-spear13xx/spear1300_evb.c          |    8 +
 arch/arm/mach-spear13xx/spear13xx.c              |   58 ++
 arch/arm/mach-spear3xx/clock.c                   |   14 +
 arch/arm/mach-spear3xx/include/mach/generic.h    |   15 +-
 arch/arm/mach-spear3xx/include/mach/spear320.h   |    3 +
 arch/arm/mach-spear3xx/spear300.c                |   98 +++
 arch/arm/mach-spear3xx/spear300_evb.c            |    7 +
 arch/arm/mach-spear3xx/spear310.c                |   26 +
 arch/arm/mach-spear3xx/spear310_evb.c            |    7 +
 arch/arm/mach-spear3xx/spear320.c                |   26 +
 arch/arm/mach-spear3xx/spear320_evb.c            |    7 +
 arch/arm/mach-spear6xx/clock.c                   |    2 +-
 arch/arm/mach-spear6xx/include/mach/generic.h    |    1 +
 arch/arm/mach-spear6xx/spear600_evb.c            |    7 +
 arch/arm/mach-spear6xx/spear6xx.c                |   26 +
 arch/arm/plat-spear/include/plat/fsmc.h          |  109 +++
 arch/arm/plat-spear/include/plat/nand.h          |   76 ++
 drivers/mtd/nand/Kconfig                         |    6 +
 drivers/mtd/nand/Makefile                        |    1 +
 drivers/mtd/nand/spear_nand.c                    |  860 ++++++++++++++++++++++
 23 files changed, 1363 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/plat-spear/include/plat/fsmc.h
 create mode 100644 arch/arm/plat-spear/include/plat/nand.h
 create mode 100644 drivers/mtd/nand/spear_nand.c

diff --git a/arch/arm/mach-spear13xx/clock.c b/arch/arm/mach-spear13xx/clock.c
index 5280657..8658d48 100644
--- a/arch/arm/mach-spear13xx/clock.c
+++ b/arch/arm/mach-spear13xx/clock.c
@@ -791,7 +791,7 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{.dev_id = "pcie2",		.clk = &pcie2_clk},
 	{.dev_id = "cfxd",		.clk = &cfxd_clk},
 	{.dev_id = "sd",		.clk = &sd_clk},
-	{.dev_id = "fsmc",		.clk = &fsmc_clk},
+	{.con_id = "fsmc",		.clk = &fsmc_clk},
 	{.dev_id = "sysram0",		.clk = &sysram0_clk},
 	{.dev_id = "sysram1",		.clk = &sysram1_clk},
 
diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index 186a8be..b884359 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -35,6 +35,7 @@ extern struct platform_device ehci0_device;
 extern struct platform_device ehci1_device;
 extern struct platform_device i2c_device;
 extern struct platform_device kbd_device;
+extern struct platform_device nand_device;
 extern struct platform_device ohci0_device;
 extern struct platform_device ohci1_device;
 extern struct platform_device rtc_device;
@@ -51,6 +52,7 @@ void __init spear1300_init(void);
 void __init spear13xx_map_io(void);
 void __init spear13xx_init_irq(void);
 void __init spear13xx_init(void);
+void __init nand_mach_init(u32 busw);
 void spear13xx_secondary_startup(void);
 
 #endif /* __MACH_GENERIC_H */
diff --git a/arch/arm/mach-spear13xx/include/mach/misc_regs.h b/arch/arm/mach-spear13xx/include/mach/misc_regs.h
index c4dcab2..05815fa 100644
--- a/arch/arm/mach-spear13xx/include/mach/misc_regs.h
+++ b/arch/arm/mach-spear13xx/include/mach/misc_regs.h
@@ -205,6 +205,16 @@
 #define PCIE_MIPHY_CFG		((unsigned int *)(MISC_BASE + 0x328))
 #define PERIP_CFG		((unsigned int *)(MISC_BASE + 0x32c))
 #define FSMC_CFG		((unsigned int *)(MISC_BASE + 0x330))
+	/* FSMC_CFG register masks */
+	#define FSMC_MEMSEL_MASK	0x3
+	#define FSMC_MEMSEL_SHIFT	0
+	#define FSMC_MEM_NOR		0
+	#define FSMC_MEM_NAND		1
+	#define FSMC_MEM_SRAM		2
+	#define NAND_BANK_MASK		0x3
+	#define NAND_BANK_SHIFT		2
+	#define NAND_DEV_WIDTH16	4
+
 #define MPMC_CTR_STS		((unsigned int *)(MISC_BASE + 0x334))
 
 /* Inter-Processor Communication Registers */
diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
index 5b74f05..4267b46 100644
--- a/arch/arm/mach-spear13xx/spear1300_evb.c
+++ b/arch/arm/mach-spear13xx/spear1300_evb.c
@@ -12,11 +12,13 @@
  */
 
 #include <linux/types.h>
+#include <linux/mtd/nand.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
 #include <plat/keyboard.h>
+#include <plat/nand.h>
 #include <plat/smi.h>
 
 static struct amba_device *amba_devs[] __initdata = {
@@ -30,6 +32,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	&ehci1_device,
 	&i2c_device,
 	&kbd_device,
+	&nand_device,
 	&ohci0_device,
 	&ohci1_device,
 	&rtc_device,
@@ -52,6 +55,11 @@ static void __init spear1300_evb_init(void)
 	/* set keyboard plat data */
 	kbd_set_plat_data(&kbd_device, &kbd_data);
 
+	/* set nand device's plat data */
+	nand_set_plat_data(&nand_device, NULL, 0, NAND_SKIP_BBTSCAN,
+			SPEAR_NAND_BW8);
+	nand_mach_init(SPEAR_NAND_BW8);
+
 	/* call spear1300 machine init function */
 	spear1300_init();
 
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index b6bddff..4810652 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -23,6 +23,8 @@
 #include <mach/irqs.h>
 #include <mach/generic.h>
 #include <mach/hardware.h>
+#include <mach/misc_regs.h>
+#include <plat/nand.h>
 
 /* Add spear13xx machines common devices here */
 /* gpio device registeration */
@@ -97,6 +99,62 @@ struct platform_device i2c_device = {
 	.resource = i2c_resources,
 };
 
+/* nand device registeration */
+void __init nand_mach_init(u32 busw)
+{
+	u32 fsmc_cfg = readl(FSMC_CFG);
+	fsmc_cfg &= ~(FSMC_MEMSEL_MASK << FSMC_MEMSEL_SHIFT);
+	fsmc_cfg |= (FSMC_MEM_NAND << FSMC_MEMSEL_SHIFT);
+
+	if (busw == SPEAR_NAND_BW16)
+		fsmc_cfg |= 1 << NAND_DEV_WIDTH16;
+	else
+		fsmc_cfg &= ~(1 << NAND_DEV_WIDTH16);
+
+	writel(fsmc_cfg, FSMC_CFG);
+}
+
+static void nand_select_bank(u32 bank, u32 busw)
+{
+	u32 fsmc_cfg = readl(FSMC_CFG);
+
+	fsmc_cfg &= ~(NAND_BANK_MASK << NAND_BANK_SHIFT);
+	fsmc_cfg |= (bank << NAND_BANK_SHIFT);
+
+	if (busw)
+		fsmc_cfg |= 1 << NAND_DEV_WIDTH16;
+	else
+		fsmc_cfg &= ~(1 << NAND_DEV_WIDTH16);
+
+	writel(fsmc_cfg, FSMC_CFG);
+}
+
+static struct nand_platform_data nand_platform_data = {
+	.select_bank = nand_select_bank,
+};
+
+static struct resource nand_resources[] = {
+	{
+		.name = "nand_data",
+		.start = SPEAR13XX_FSMC_MEM_BASE,
+		.end = SPEAR13XX_FSMC_MEM_BASE + SZ_16 - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.name = "fsmc_regs",
+		.start = SPEAR13XX_FSMC_BASE,
+		.end = SPEAR13XX_FSMC_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+struct platform_device nand_device = {
+	.name = "nand",
+	.id = -1,
+	.resource = nand_resources,
+	.num_resources = ARRAY_SIZE(nand_resources),
+	.dev.platform_data = &nand_platform_data,
+};
+
 /* usb host device registeration */
 static struct resource ehci0_resources[] = {
 	[0] = {
diff --git a/arch/arm/mach-spear3xx/clock.c b/arch/arm/mach-spear3xx/clock.c
index 39835e8..93c5fd9 100644
--- a/arch/arm/mach-spear3xx/clock.c
+++ b/arch/arm/mach-spear3xx/clock.c
@@ -461,6 +461,16 @@ static struct clk gpio_clk = {
 
 static struct clk dummy_apb_pclk;
 
+#if defined(CONFIG_MACH_SPEAR300) || defined(CONFIG_MACH_SPEAR310) || \
+	defined(CONFIG_MACH_SPEAR320)
+/* fsmc clock */
+static struct clk fsmc_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &ahb_clk,
+	.recalc = &follow_parent,
+};
+#endif
+
 /* spear300 machine specific clock structures */
 #ifdef CONFIG_MACH_SPEAR300
 /* keyboard clock */
@@ -535,6 +545,10 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{ .dev_id = "adc",		.clk = &adc_clk},
 	{ .dev_id = "ssp",		.clk = &ssp_clk},
 	{ .dev_id = "gpio",		.clk = &gpio_clk},
+#if defined(CONFIG_MACH_SPEAR300) || defined(CONFIG_MACH_SPEAR310) || \
+	defined(CONFIG_MACH_SPEAR320)
+	{ .con_id = "fsmc",		.clk = &fsmc_clk},
+#endif
 
 	/* spear300 machine specific clock structures */
 #ifdef CONFIG_MACH_SPEAR300
diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index 91c0c09..6aac229 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -111,6 +111,10 @@ extern struct pmx_driver pmx_driver;
 extern struct amba_device clcd_device;
 extern struct amba_device gpio1_device;
 extern struct platform_device kbd_device;
+extern struct platform_device nand0_device;
+extern struct platform_device nand1_device;
+extern struct platform_device nand2_device;
+extern struct platform_device nand3_device;
 
 /* pad mux modes */
 extern struct pmx_mode nand_mode;
@@ -148,12 +152,12 @@ void __init spear300_init(void);
 
 /* Add misc structure declarations here */
 extern struct clcd_board clcd_plat_data;
-#endif /* CONFIG_MACH_SPEAR300 */
 
 /* spear310 declarations */
-#ifdef CONFIG_MACH_SPEAR310
+#elif defined(CONFIG_MACH_SPEAR310)
 /* Add spear310 machine device structure declarations here */
 extern struct platform_device plgpio_device;
+extern struct platform_device nand_device;
 
 /* pad mux devices */
 extern struct pmx_dev pmx_emi_cs_0_1_4_5;
@@ -168,13 +172,12 @@ extern struct pmx_dev pmx_tdm0;
 /* Add spear310 machine function declarations here */
 void __init spear310_init(void);
 
-#endif /* CONFIG_MACH_SPEAR310 */
-
 /* spear320 declarations */
-#ifdef CONFIG_MACH_SPEAR320
+#elif defined(CONFIG_MACH_SPEAR320)
 /* Add spear320 machine device structure declarations here */
 extern struct amba_device clcd_device;
 extern struct platform_device i2c1_device;
+extern struct platform_device nand_device;
 extern struct platform_device plgpio_device;
 extern struct platform_device pwm_device;
 
@@ -213,6 +216,6 @@ void __init spear320_init(void);
 
 /* Add misc structure declarations here */
 extern struct clcd_board clcd_plat_data;
-#endif /* CONFIG_MACH_SPEAR320 */
+#endif
 
 #endif /* __MACH_GENERIC_H */
diff --git a/arch/arm/mach-spear3xx/include/mach/spear320.h b/arch/arm/mach-spear3xx/include/mach/spear320.h
index 53677e4..aa6727c 100644
--- a/arch/arm/mach-spear3xx/include/mach/spear320.h
+++ b/arch/arm/mach-spear3xx/include/mach/spear320.h
@@ -22,6 +22,9 @@
 #define SPEAR320_FSMC_BASE		0x4C000000
 #define SPEAR320_FSMC_SIZE		0x01000000
 
+#define SPEAR320_NAND_BASE		0x50000000
+#define SPEAR320_NAND_SIZE		0x04000000
+
 #define SPEAR320_I2S_BASE		0x60000000
 #define SPEAR320_I2S_SIZE		0x10000000
 
diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index cf010cc..3a86868 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -17,6 +17,7 @@
 #include <asm/irq.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
+#include <plat/nand.h>
 #include <plat/shirq.h>
 
 /* pad multiplexing support */
@@ -426,6 +427,103 @@ struct platform_device kbd_device = {
 	.resource = kbd_resources,
 };
 
+/* nand device registeration */
+static struct nand_platform_data nand0_platform_data;
+
+static struct resource nand0_resources[] = {
+	{
+		.name = "nand_data",
+		.start = SPEAR300_NAND_0_BASE,
+		.end = SPEAR300_NAND_0_BASE + SZ_16 - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.name = "fsmc_regs",
+		.start = SPEAR300_FSMC_BASE,
+		.end = SPEAR300_FSMC_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+struct platform_device nand0_device = {
+	.name = "nand",
+	.id = 0,
+	.resource = nand0_resources,
+	.num_resources = ARRAY_SIZE(nand0_resources),
+	.dev.platform_data = &nand0_platform_data,
+};
+
+static struct nand_platform_data nand1_platform_data;
+
+static struct resource nand1_resources[] = {
+	{
+		.name = "nand_data",
+		.start = SPEAR300_NAND_1_BASE,
+		.end = SPEAR300_NAND_1_BASE + SZ_16 - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.name = "fsmc_regs",
+		.start = SPEAR300_FSMC_BASE,
+		.end = SPEAR300_FSMC_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+struct platform_device nand1_device = {
+	.name = "nand",
+	.id = 1,
+	.resource = nand1_resources,
+	.num_resources = ARRAY_SIZE(nand1_resources),
+	.dev.platform_data = &nand1_platform_data,
+};
+
+static struct nand_platform_data nand2_platform_data;
+
+static struct resource nand2_resources[] = {
+	{
+		.name = "nand_data",
+		.start = SPEAR300_NAND_2_BASE,
+		.end = SPEAR300_NAND_2_BASE + SZ_16 - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.name = "fsmc_regs",
+		.start = SPEAR300_FSMC_BASE,
+		.end = SPEAR300_FSMC_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+struct platform_device nand2_device = {
+	.name = "nand",
+	.id = 2,
+	.resource = nand2_resources,
+	.num_resources = ARRAY_SIZE(nand2_resources),
+	.dev.platform_data = &nand2_platform_data,
+};
+
+static struct nand_platform_data nand3_platform_data;
+
+static struct resource nand3_resources[] = {
+	{
+		.name = "nand_data",
+		.start = SPEAR300_NAND_3_BASE,
+		.end = SPEAR300_NAND_3_BASE + SZ_16 - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.name = "fsmc_regs",
+		.start = SPEAR300_FSMC_BASE,
+		.end = SPEAR300_FSMC_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+struct platform_device nand3_device = {
+	.name = "nand",
+	.id = 3,
+	.resource = nand3_resources,
+	.num_resources = ARRAY_SIZE(nand3_resources),
+	.dev.platform_data = &nand3_platform_data,
+};
+
 /* spear3xx shared irq */
 struct shirq_dev_config shirq_ras1_config[] = {
 	{
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index 7bd8963..895f7b7 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -11,11 +11,13 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/mtd/nand.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
 #include <plat/keyboard.h>
+#include <plat/nand.h>
 #include <plat/smi.h>
 
 /* padmux devices to enable */
@@ -49,6 +51,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	/* spear3xx specific devices */
 	&ehci_device,
 	&i2c_device,
+	&nand0_device,
 	&ohci0_device,
 	&ohci1_device,
 	&rtc_device,
@@ -79,6 +82,10 @@ static void __init spear300_evb_init(void)
 	/* set keyboard plat data */
 	kbd_set_plat_data(&kbd_device, &kbd_data);
 
+	/* set nand0 device's plat data */
+	nand_set_plat_data(&nand0_device, NULL, 0, NAND_SKIP_BBTSCAN,
+			SPEAR_NAND_BW8);
+
 	/* call spear300 machine init function */
 	spear300_init();
 
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
index 88b55b5..69350b7 100644
--- a/arch/arm/mach-spear3xx/spear310.c
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -16,6 +16,7 @@
 #include <mach/generic.h>
 #include <mach/spear.h>
 #include <plat/gpio.h>
+#include <plat/nand.h>
 #include <plat/shirq.h>
 
 /* pad multiplexing support */
@@ -177,6 +178,31 @@ int spear300_o2p(int offset)
 		return offset + 2;
 }
 
+/* nand device registeration */
+static struct nand_platform_data nand_platform_data;
+
+static struct resource nand_resources[] = {
+	{
+		.name = "nand_data",
+		.start = SPEAR310_NAND_BASE,
+		.end = SPEAR310_NAND_BASE + SZ_16 - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.name = "fsmc_regs",
+		.start = SPEAR310_FSMC_BASE,
+		.end = SPEAR310_FSMC_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+struct platform_device nand_device = {
+	.name = "nand",
+	.id = -1,
+	.resource = nand_resources,
+	.num_resources = ARRAY_SIZE(nand_resources),
+	.dev.platform_data = &nand_platform_data,
+};
+
 static struct plgpio_platform_data plgpio_plat_data = {
 	.gpio_base = 8,
 	.irq_base = SPEAR_PLGPIO_INT_BASE,
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
index cd076c9..8f17362 100644
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -11,10 +11,12 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/mtd/nand.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
+#include <plat/nand.h>
 #include <plat/smi.h>
 
 /* padmux devices to enable */
@@ -54,6 +56,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	/* spear3xx specific devices */
 	&ehci_device,
 	&i2c_device,
+	&nand_device,
 	&ohci0_device,
 	&ohci1_device,
 	&rtc_device,
@@ -72,6 +75,10 @@ static void __init spear310_evb_init(void)
 	pmx_driver.devs = pmx_devs;
 	pmx_driver.devs_count = ARRAY_SIZE(pmx_devs);
 
+	/* set nand device's plat data */
+	nand_set_plat_data(&nand_device, NULL, 0, NAND_SKIP_BBTSCAN,
+			SPEAR_NAND_BW8);
+
 	/* call spear310 machine init function */
 	spear310_init();
 
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 75e7890..2ac838b 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -16,6 +16,7 @@
 #include <mach/generic.h>
 #include <mach/spear.h>
 #include <plat/gpio.h>
+#include <plat/nand.h>
 #include <plat/shirq.h>
 
 /* pad multiplexing support */
@@ -431,6 +432,31 @@ struct platform_device i2c1_device = {
 	.resource = i2c1_resources,
 };
 
+/* nand device registeration */
+static struct nand_platform_data nand_platform_data;
+
+static struct resource nand_resources[] = {
+	{
+		.name = "nand_data",
+		.start = SPEAR320_NAND_BASE,
+		.end = SPEAR320_NAND_BASE + SZ_16 - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.name = "fsmc_regs",
+		.start = SPEAR320_FSMC_BASE,
+		.end = SPEAR320_FSMC_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+struct platform_device nand_device = {
+	.name = "nand",
+	.id = -1,
+	.resource = nand_resources,
+	.num_resources = ARRAY_SIZE(nand_resources),
+	.dev.platform_data = &nand_platform_data,
+};
+
 static struct resource plgpio_resources[] = {
 	{
 		.start = SPEAR320_SOC_CONFIG_BASE,
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index 7f7b5dd..d693877 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -11,10 +11,12 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/mtd/nand.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
+#include <plat/nand.h>
 #include <plat/smi.h>
 
 /* padmux devices to enable */
@@ -52,6 +54,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	/* spear3xx specific devices */
 	&ehci_device,
 	&i2c_device,
+	&nand_device,
 	&ohci0_device,
 	&ohci1_device,
 	&rtc_device,
@@ -72,6 +75,10 @@ static void __init spear320_evb_init(void)
 	pmx_driver.devs = pmx_devs;
 	pmx_driver.devs_count = ARRAY_SIZE(pmx_devs);
 
+	/* set nand device's plat data */
+	nand_set_plat_data(&nand_device, NULL, 0, NAND_SKIP_BBTSCAN,
+			SPEAR_NAND_BW8);
+
 	/* call spear320 machine init function */
 	spear320_init();
 
diff --git a/arch/arm/mach-spear6xx/clock.c b/arch/arm/mach-spear6xx/clock.c
index fb05ec8..91f1f3f 100644
--- a/arch/arm/mach-spear6xx/clock.c
+++ b/arch/arm/mach-spear6xx/clock.c
@@ -602,7 +602,7 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{ .dev_id = "jpeg",		.clk = &jpeg_clk},
 	{ .dev_id = "gmac",		.clk = &gmac_clk},
 	{ .dev_id = "smi",		.clk = &smi_clk},
-	{ .dev_id = "fsmc",		.clk = &fsmc_clk},
+	{ .con_id = "fsmc",		.clk = &fsmc_clk},
 	/* clock derived from apb clk */
 	{ .dev_id = "adc",		.clk = &adc_clk},
 	{ .dev_id = "ssp0",		.clk = &ssp0_clk},
diff --git a/arch/arm/mach-spear6xx/include/mach/generic.h b/arch/arm/mach-spear6xx/include/mach/generic.h
index f885898..ff90419 100644
--- a/arch/arm/mach-spear6xx/include/mach/generic.h
+++ b/arch/arm/mach-spear6xx/include/mach/generic.h
@@ -36,6 +36,7 @@ extern struct amba_device wdt_device;
 extern struct platform_device ehci0_device;
 extern struct platform_device ehci1_device;
 extern struct platform_device i2c_device;
+extern struct platform_device nand_device;
 extern struct platform_device ohci0_device;
 extern struct platform_device ohci1_device;
 extern struct platform_device rtc_device;
diff --git a/arch/arm/mach-spear6xx/spear600_evb.c b/arch/arm/mach-spear6xx/spear600_evb.c
index 0eb5f50..cf86efc 100644
--- a/arch/arm/mach-spear6xx/spear600_evb.c
+++ b/arch/arm/mach-spear6xx/spear600_evb.c
@@ -11,10 +11,12 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/mtd/nand.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
+#include <plat/nand.h>
 #include <plat/smi.h>
 
 static struct amba_device *amba_devs[] __initdata = {
@@ -33,6 +35,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	&i2c_device,
 	&ohci0_device,
 	&ohci1_device,
+	&nand_device,
 	&rtc_device,
 	&smi_device,
 };
@@ -41,6 +44,10 @@ static void __init spear600_evb_init(void)
 {
 	unsigned int i;
 
+	/* set nand device's plat data */
+	nand_set_plat_data(&nand_device, NULL, 0, NAND_SKIP_BBTSCAN,
+			SPEAR_NAND_BW8);
+
 	/* call spear600 machine init function */
 	spear600_init();
 
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index 4987597..2296d0f 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -21,6 +21,7 @@
 #include <mach/irqs.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
+#include <plat/nand.h>
 
 /* Add spear6xx machines common devices here */
 
@@ -152,6 +153,31 @@ struct platform_device i2c_device = {
 	.resource = i2c_resources,
 };
 
+/* nand device registeration */
+static struct nand_platform_data nand_platform_data;
+
+static struct resource nand_resources[] = {
+	{
+		.name = "nand_data",
+		.start = SPEAR6XX_ICM1_NAND_BASE,
+		.end = SPEAR6XX_ICM1_NAND_BASE + SZ_16 - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.name = "fsmc_regs",
+		.start = SPEAR6XX_ICM1_FSMC_BASE,
+		.end = SPEAR6XX_ICM1_FSMC_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+struct platform_device nand_device = {
+	.name = "nand",
+	.id = -1,
+	.resource = nand_resources,
+	.num_resources = ARRAY_SIZE(nand_resources),
+	.dev.platform_data = &nand_platform_data,
+};
+
 /* usb host device registeration */
 static struct resource ehci0_resources[] = {
 	[0] = {
diff --git a/arch/arm/plat-spear/include/plat/fsmc.h b/arch/arm/plat-spear/include/plat/fsmc.h
new file mode 100644
index 0000000..c0fdcd3
--- /dev/null
+++ b/arch/arm/plat-spear/include/plat/fsmc.h
@@ -0,0 +1,109 @@
+/*
+ * arch/arm/plat-spear/include/plat/fsmc.h
+ *
+ * SPEAr platform nand interface header file
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Vipin Kumar <vipin.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __PLAT_FSMC_H
+#define __PLAT_FSMC_H
+
+#include <linux/delay.h>
+#include <linux/types.h>
+#include <asm/param.h>
+
+#define FSMC_MAX_NAND_BANKS	4
+
+struct nand_bank_regs {
+	u32 pc;
+	u32 sts;
+	u32 comm;
+	u32 attrib;
+	u32 ioata;
+	u32 ecc1;
+	u32 ecc2;
+	u32 ecc3;
+};
+
+struct fsmc_regs {
+	u8 reserved_1[0x40];
+	struct nand_bank_regs bank_regs[FSMC_MAX_NAND_BANKS];
+	u8 reserved_2[0xfe0 - 0xc0];
+	u32 peripid0;			/* 0xfe0 */
+	u32 peripid1;			/* 0xfe4 */
+	u32 peripid2;			/* 0xfe8 */
+	u32 peripid3;			/* 0xfec */
+	u32 pcellid0;			/* 0xff0 */
+	u32 pcellid1;			/* 0xff4 */
+	u32 pcellid2;			/* 0xff8 */
+	u32 pcellid3;			/* 0xffc */
+};
+
+#define FSMC_BUSY_WAIT_TIMEOUT	(1 * HZ)
+
+/* pc register definitions */
+#define FSMC_RESET		(1 << 0)
+#define FSMC_WAITON		(1 << 1)
+#define FSMC_ENABLE		(1 << 2)
+#define FSMC_DEVTYPE_NAND	(1 << 3)
+#define FSMC_DEVWID_8		(0 << 4)
+#define FSMC_DEVWID_16		(1 << 4)
+#define FSMC_ECCEN		(1 << 6)
+#define FSMC_ECCPLEN_512	(0 << 7)
+#define FSMC_ECCPLEN_256	(1 << 7)
+#define FSMC_TCLR_1		(1 << 9)
+#define FSMC_TAR_1		(1 << 13)
+
+/* sts register definitions */
+#define FSMC_CODE_RDY		(1 << 15)
+
+/* comm register definitions */
+#define FSMC_TSET_0		(0 << 0)
+#define FSMC_TWAIT_6		(6 << 8)
+#define FSMC_THOLD_4		(4 << 16)
+#define FSMC_THIZ_1		(1 << 24)
+
+/* peripid2 register definitions */
+#define FSMC_REVISION_MSK	(0xf)
+#define FSMC_REVISION_SHFT	(0x4)
+
+#define FSMC_VER1		1
+#define FSMC_VER2		2
+#define FSMC_VER3		3
+#define FSMC_VER4		4
+#define FSMC_VER5		5
+#define FSMC_VER6		6
+#define FSMC_VER7		7
+#define FSMC_VER8		8
+
+static inline u32 get_fsmc_version(struct fsmc_regs *regs)
+{
+	return (readl(&regs->peripid2) >> FSMC_REVISION_SHFT) &
+				FSMC_REVISION_MSK;
+}
+
+/*
+ * There are 13 bytes of ecc for every 512 byte block in FSMC version 8
+ * and it has to be read consecutively and immediately after the 512
+ * byte data block for hardware to generate the error bit offsets
+ * Managing the ecc bytes in the following way is easier. This way is
+ * similar to oobfree structure maintained already in u-boot nand driver
+ */
+#define MAX_ECCPLACE_ENTRIES	32
+
+struct fsmc_nand_eccplace {
+	u8 offset;
+	u8 length;
+};
+
+struct fsmc_eccplace {
+	struct fsmc_nand_eccplace eccplace[MAX_ECCPLACE_ENTRIES];
+};
+
+#endif /* __PLAT_FSMC_H */
diff --git a/arch/arm/plat-spear/include/plat/nand.h b/arch/arm/plat-spear/include/plat/nand.h
new file mode 100644
index 0000000..712b4b0
--- /dev/null
+++ b/arch/arm/plat-spear/include/plat/nand.h
@@ -0,0 +1,76 @@
+/*
+ * arch/arm/plat-spear/include/plat/nand.h
+ *
+ * NAND macros for SPEAr platform
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Vipin Kumar <vipin.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __PLAT_NAND_H
+#define __PLAT_NAND_H
+
+#include <linux/mtd/partitions.h>
+
+#define SPEAR_NAND_BW8		1
+#define SPEAR_NAND_BW16		2
+
+#if defined(CONFIG_MACH_SPEAR310)
+#define PLAT_NAND_CLE		(1 << 17)
+#define PLAT_NAND_ALE		(1 << 16)
+#else
+#define PLAT_NAND_CLE		(1 << 16)
+#define PLAT_NAND_ALE		(1 << 17)
+#endif
+
+struct nand_platform_data {
+	/*
+	 * Board specific information
+	 * Set from arch/arm/mach-spear<mach>/spear<mach>_evb.c
+	 */
+
+	/*
+	 * Use the default partition table present in the NAND driver if
+	 * partitions is set to NULL.
+	 */
+	struct mtd_partition	*partitions;
+	unsigned int		nr_partitions;
+	unsigned int		options;
+	unsigned int		width;
+
+	/*
+	 * Machine specific information
+	 * Set from arch/arm/mach-spear<mach>/spear<mach>.c
+	 */
+
+	unsigned int		bank;
+	/*
+	 * Set to NULL if bank selection is not supported by machine
+	 * architecture
+	 * -> eg. when controller supports only one bank
+	 */
+	void			(*select_bank)(u32 bank, u32 busw);
+};
+
+/* This function is used to set platform data field of pdev->dev */
+static inline void nand_set_plat_data(struct platform_device *pdev,
+		struct mtd_partition *partitions, unsigned int nr_partitions,
+		unsigned int options, unsigned int width)
+{
+	struct nand_platform_data *nand_plat_data;
+	nand_plat_data = dev_get_platdata(&pdev->dev);
+
+	if (partitions) {
+		nand_plat_data->partitions = partitions;
+		nand_plat_data->nr_partitions = nr_partitions;
+	}
+
+	nand_plat_data->options = options;
+	nand_plat_data->width = width;
+}
+
+#endif /* __PLAT_NAND_H */
diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 8b4b67c..89d35d1 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -531,4 +531,10 @@ config MTD_NAND_JZ4740
 	help
 		Enables support for NAND Flash on JZ4740 SoC based boards.
 
+config MTD_NAND_SPEAR
+	tristate "Support for NAND on SPEAr platforms"
+	depends on MTD_NAND && PLAT_SPEAR
+	help
+	  Enables support for NAND Flash chips wired onto SPEAr boards.
+
 endif # MTD_NAND
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index ac83dcd..d1749af 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_MTD_NAND_FSL_UPM)		+= fsl_upm.o
 obj-$(CONFIG_MTD_NAND_SH_FLCTL)		+= sh_flctl.o
 obj-$(CONFIG_MTD_NAND_MXC)		+= mxc_nand.o
 obj-$(CONFIG_MTD_NAND_SOCRATES)		+= socrates_nand.o
+obj-$(CONFIG_MTD_NAND_SPEAR)		+= spear_nand.o
 obj-$(CONFIG_MTD_NAND_TXX9NDFMC)	+= txx9ndfmc.o
 obj-$(CONFIG_MTD_NAND_NUC900)		+= nuc900_nand.o
 obj-$(CONFIG_MTD_NAND_NOMADIK)		+= nomadik_nand.o
diff --git a/drivers/mtd/nand/spear_nand.c b/drivers/mtd/nand/spear_nand.c
new file mode 100644
index 0000000..da9661b
--- /dev/null
+++ b/drivers/mtd/nand/spear_nand.c
@@ -0,0 +1,860 @@
+/*
+ * drivers/mtd/nand/spear_nand.c
+ *
+ * SPEAr13XX machines common source file
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Vipin Kumar <vipin.kumar@st.com>
+ * Ashish Priyadarshi
+ *
+ * Based on drivers/mtd/nand/nomadik_nand.c
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/resource.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/nand_ecc.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/partitions.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <plat/fsmc.h>
+#include <plat/nand.h>
+#include <mtd/mtd-abi.h>
+
+static struct nand_ecclayout fsmc_ecc1_layout = {
+	.eccbytes = 24,
+	.eccpos = {2, 3, 4, 18, 19, 20, 34, 35, 36, 50, 51, 52,
+		66, 67, 68, 82, 83, 84, 98, 99, 100, 114, 115, 116},
+	.oobfree = {
+		{.offset = 8, .length = 8},
+		{.offset = 24, .length = 8},
+		{.offset = 40, .length = 8},
+		{.offset = 56, .length = 8},
+		{.offset = 72, .length = 8},
+		{.offset = 88, .length = 8},
+		{.offset = 104, .length = 8},
+		{.offset = 120, .length = 8}
+	}
+};
+
+static struct nand_ecclayout fsmc_ecc4_lp_layout = {
+	.eccbytes = 104,
+	.eccpos = {  2,   3,   4,   5,   6,   7,   8,
+		9,  10,  11,  12,  13,  14,
+		18,  19,  20,  21,  22,  23,  24,
+		25,  26,  27,  28,  29,  30,
+		34,  35,  36,  37,  38,  39,  40,
+		41,  42,  43,  44,  45,  46,
+		50,  51,  52,  53,  54,  55,  56,
+		57,  58,  59,  60,  61,  62,
+		66,  67,  68,  69,  70,  71,  72,
+		73,  74,  75,  76,  77,  78,
+		82,  83,  84,  85,  86,  87,  88,
+		89,  90,  91,  92,  93,  94,
+		98,  99, 100, 101, 102, 103, 104,
+		105, 106, 107, 108, 109, 110,
+		114, 115, 116, 117, 118, 119, 120,
+		121, 122, 123, 124, 125, 126
+	},
+	.oobfree = {
+		{.offset = 15, .length = 3},
+		{.offset = 31, .length = 3},
+		{.offset = 47, .length = 3},
+		{.offset = 63, .length = 3},
+		{.offset = 79, .length = 3},
+		{.offset = 95, .length = 3},
+		{.offset = 111, .length = 3},
+		{.offset = 127, .length = 1}
+	}
+};
+
+/*
+ * ECC placement definitions in oobfree type format.
+ * There are 13 bytes of ecc for every 512 byte block and it has to be read
+ * consecutively and immediately after the 512 byte data block for hardware to
+ * generate the error bit offsets in 512 byte data.
+ * Managing the ecc bytes in the following way makes it easier for software to
+ * read ecc bytes consecutive to data bytes. This way is similar to
+ * oobfree structure maintained already in generic nand driver
+ */
+static struct fsmc_eccplace fsmc_ecc4_lp_place = {
+	.eccplace = {
+		{.offset = 2, .length = 13},
+		{.offset = 18, .length = 13},
+		{.offset = 34, .length = 13},
+		{.offset = 50, .length = 13},
+		{.offset = 66, .length = 13},
+		{.offset = 82, .length = 13},
+		{.offset = 98, .length = 13},
+		{.offset = 114, .length = 13}
+	}
+};
+
+static struct nand_ecclayout fsmc_ecc4_sp_layout = {
+	.eccbytes = 13,
+	.eccpos = { 0,  1,  2,  3,  6,  7, 8,
+		9, 10, 11, 12, 13, 14
+	},
+	.oobfree = {
+		{.offset = 15, .length = 1},
+	}
+};
+
+static struct fsmc_eccplace fsmc_ecc4_sp_place = {
+	.eccplace = {
+		{.offset = 0, .length = 4},
+		{.offset = 6, .length = 9}
+	}
+};
+
+/*
+ * Default partition tables to be used if the partition information not provided
+ * through platform data
+ */
+#define PARTITION(n, off, sz)	{.name = n, .offset = off, .size = sz}
+
+/*
+ * Default partition layout for small page(= 512 bytes) devices
+ * Size for "Root file system" is updated in driver based on actual device size
+ */
+static struct mtd_partition partition_info_16KB_blk[] = {
+	PARTITION("X-loader", 0, 4 * 0x4000),
+	PARTITION("U-Boot", 0x10000, 20 * 0x4000),
+	PARTITION("Kernel", 0x60000, 256 * 0x4000),
+	PARTITION("Root File System", 0x460000, 0),
+};
+
+/*
+ * Default partition layout for large page(> 512 bytes) devices
+ * Size for "Root file system" is updated in driver based on actual device size
+ */
+static struct mtd_partition partition_info_128KB_blk[] = {
+	PARTITION("X-loader", 0, 4 * 0x20000),
+	PARTITION("U-Boot", 0x80000, 12 * 0x20000),
+	PARTITION("Kernel", 0x200000, 48 * 0x20000),
+	PARTITION("Root File System", 0x800000, 0),
+};
+
+#ifdef CONFIG_MTD_CMDLINE_PARTS
+const char *part_probes[] = { "cmdlinepart", NULL };
+#endif
+
+/**
+ * struct spear_nand_dev - Structure for SPEAr NAND Device
+ *
+ * @mtd:		MTD info for a NAND flash.
+ * @nand:		Chip related info for a NAND flash.
+ * @partitions:		Partition info for a NAND Flash.
+ * @nr_partitions:	Total number of partition of a NAND flash.
+ *
+ * @ecc_place:		ECC placing locations in oobfree type format.
+ * @bank:		Bank number for probed device.
+ * @clk:		Clock structure for FSMC.
+ *
+ * @data_va:		NAND port for Data.
+ * @cmd_va:		NAND port for Command.
+ * @addr_va:		NAND port for Address.
+ * @regs_va:		FSMC regs base address.
+ */
+struct spear_nand_data {
+	struct mtd_info		mtd;
+	struct nand_chip	nand;
+	struct mtd_partition	*partitions;
+	unsigned int		nr_partitions;
+
+	struct fsmc_eccplace	*ecc_place;
+	unsigned int		bank;
+	struct clk		*clk;
+
+	struct resource		*resregs;
+	struct resource		*rescmd;
+	struct resource		*resaddr;
+	struct resource		*resdata;
+
+	void __iomem		*data_va;
+	void __iomem		*cmd_va;
+	void __iomem		*addr_va;
+	void __iomem		*regs_va;
+
+	void			(*select_chip)(u32 bank, u32 busw);
+};
+
+/* Assert CS signal based on chipnr */
+static void spear_select_chip(struct mtd_info *mtd, int chipnr)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct spear_nand_data *host;
+
+	host = container_of(mtd, struct spear_nand_data, mtd);
+
+	switch (chipnr) {
+	case -1:
+		chip->cmd_ctrl(mtd, NAND_CMD_NONE, 0 | NAND_CTRL_CHANGE);
+		break;
+	case 0:
+	case 1:
+	case 2:
+	case 3:
+		if (host->select_chip)
+			host->select_chip(chipnr,
+					chip->options & NAND_BUSWIDTH_16);
+		break;
+
+	default:
+		BUG();
+	}
+}
+
+/*
+ * spear_cmd_ctrl - For facilitaing Hardware access
+ * This routine allows hardware specific access to control-lines(ALE,CLE)
+ */
+static void spear_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
+{
+	struct nand_chip *this = mtd->priv;
+	struct spear_nand_data *host = container_of(mtd,
+					struct spear_nand_data, mtd);
+	struct fsmc_regs *regs = host->regs_va;
+	unsigned int bank = host->bank;
+
+	if (ctrl & NAND_CTRL_CHANGE) {
+		if (ctrl & NAND_CLE) {
+			this->IO_ADDR_R = (void __iomem *)host->cmd_va;
+			this->IO_ADDR_W = (void __iomem *)host->cmd_va;
+		} else if (ctrl & NAND_ALE) {
+			this->IO_ADDR_R = (void __iomem *)host->addr_va;
+			this->IO_ADDR_W = (void __iomem *)host->addr_va;
+		} else {
+			this->IO_ADDR_R = (void __iomem *)host->data_va;
+			this->IO_ADDR_W = (void __iomem *)host->data_va;
+		}
+
+		if (ctrl & NAND_NCE) {
+			writel(readl(&regs->bank_regs[bank].pc) | FSMC_ENABLE,
+					&regs->bank_regs[bank].pc);
+		} else {
+			writel(readl(&regs->bank_regs[bank].pc) & ~FSMC_ENABLE,
+				       &regs->bank_regs[bank].pc);
+		}
+	}
+
+	mb();
+
+	if (cmd != NAND_CMD_NONE)
+		writeb(cmd, this->IO_ADDR_W);
+}
+
+/*
+ * fsmc_nand_init - FSMC (Flexible Static Memory Controller) init routine
+ *
+ * This routine initializes timing parameters related to NAND memory access in
+ * FSMC registers
+ */
+static void fsmc_nand_init(struct fsmc_regs *regs, u32 bank, u32 busw)
+{
+	u32 value = FSMC_DEVTYPE_NAND | FSMC_ENABLE | FSMC_WAITON;
+
+	if (busw)
+		writel(value | FSMC_DEVWID_16, &regs->bank_regs[bank].pc);
+	else
+		writel(value | FSMC_DEVWID_8, &regs->bank_regs[bank].pc);
+
+	writel(readl(&regs->bank_regs[bank].pc) | FSMC_TCLR_1 | FSMC_TAR_1,
+	       &regs->bank_regs[bank].pc);
+	writel(FSMC_THIZ_1 | FSMC_THOLD_4 | FSMC_TWAIT_6 | FSMC_TSET_0,
+	       &regs->bank_regs[bank].comm);
+	writel(FSMC_THIZ_1 | FSMC_THOLD_4 | FSMC_TWAIT_6 | FSMC_TSET_0,
+	       &regs->bank_regs[bank].attrib);
+}
+
+/*
+ * fsmc_enable_hwecc - Enables Hardware ECC through FSMC registers
+ */
+static void fsmc_enable_hwecc(struct mtd_info *mtd, int mode)
+{
+	struct spear_nand_data *host = container_of(mtd,
+					struct spear_nand_data, mtd);
+	struct fsmc_regs *regs = host->regs_va;
+	u32 bank = host->bank;
+
+	writel(readl(&regs->bank_regs[bank].pc) & ~FSMC_ECCPLEN_256,
+		       &regs->bank_regs[bank].pc);
+	writel(readl(&regs->bank_regs[bank].pc) & ~FSMC_ECCEN,
+			&regs->bank_regs[bank].pc);
+	writel(readl(&regs->bank_regs[bank].pc) | FSMC_ECCEN,
+			&regs->bank_regs[bank].pc);
+}
+
+/*
+ * fsmc_read_hwecc_ecc4 - Hardware ECC calculator for ecc4 option supported by
+ * FSMC. ECC is 13 bytes for 512 bytes of data (supports error correction upto
+ * max of 8-bits)
+ */
+static int fsmc_read_hwecc_ecc4(struct mtd_info *mtd, const u8 *data, u8 *ecc)
+{
+	struct spear_nand_data *host = container_of(mtd,
+					struct spear_nand_data, mtd);
+	struct fsmc_regs *regs = host->regs_va;
+	u32 bank = host->bank;
+	u32 ecc_tmp;
+	unsigned long deadline = jiffies + FSMC_BUSY_WAIT_TIMEOUT;
+
+	do {
+		if (readl(&regs->bank_regs[bank].sts) & FSMC_CODE_RDY)
+			break;
+		else
+			cond_resched();
+	} while (!time_after_eq(jiffies, deadline));
+
+	ecc_tmp = readl(&regs->bank_regs[bank].ecc1);
+	ecc[0] = (u8) (ecc_tmp >> 0);
+	ecc[1] = (u8) (ecc_tmp >> 8);
+	ecc[2] = (u8) (ecc_tmp >> 16);
+	ecc[3] = (u8) (ecc_tmp >> 24);
+
+	ecc_tmp = readl(&regs->bank_regs[bank].ecc2);
+	ecc[4] = (u8) (ecc_tmp >> 0);
+	ecc[5] = (u8) (ecc_tmp >> 8);
+	ecc[6] = (u8) (ecc_tmp >> 16);
+	ecc[7] = (u8) (ecc_tmp >> 24);
+
+	ecc_tmp = readl(&regs->bank_regs[bank].ecc3);
+	ecc[8] = (u8) (ecc_tmp >> 0);
+	ecc[9] = (u8) (ecc_tmp >> 8);
+	ecc[10] = (u8) (ecc_tmp >> 16);
+	ecc[11] = (u8) (ecc_tmp >> 24);
+
+	ecc_tmp = readl(&regs->bank_regs[bank].sts);
+	ecc[12] = (u8) (ecc_tmp >> 16);
+
+	return 0;
+}
+
+/*
+ * fsmc_read_hwecc_ecc1 - Hardware ECC calculator for ecc1 option supported by
+ * FSMC. ECC is 3 bytes for 512 bytes of data (supports error correction upto
+ * max of 1-bit)
+ */
+static int fsmc_read_hwecc_ecc1(struct mtd_info *mtd, const u8 *data, u8 *ecc)
+{
+	struct spear_nand_data *host = container_of(mtd,
+					struct spear_nand_data, mtd);
+	struct fsmc_regs *regs = host->regs_va;
+	u32 bank = host->bank;
+	u32 ecc_tmp;
+
+	ecc_tmp = readl(&regs->bank_regs[bank].ecc1);
+	ecc[0] = (u8) (ecc_tmp >> 0);
+	ecc[1] = (u8) (ecc_tmp >> 8);
+	ecc[2] = (u8) (ecc_tmp >> 16);
+
+	return 0;
+}
+
+/*
+ * fsmc_read_page_hwecc
+ * @mtd:	mtd info structure
+ * @chip:	nand chip info structure
+ * @buf:	buffer to store read data
+ * @page:	page number to read
+ *
+ * This routine is needed for fsmc verison 8 as reading from NAND chip has to be
+ * performed in a strict sequence as follows:
+ * data(512 byte) -> ecc(13 byte)
+ * After this read, fsmc hardware generates and reports error data bits(upto a
+ * max of 8 bits)
+ */
+static int fsmc_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
+				 u8 *buf, int page)
+{
+	struct spear_nand_data *host = container_of(mtd,
+					struct spear_nand_data, mtd);
+	struct fsmc_eccplace *ecc_place = host->ecc_place;
+	int i, j, s, stat, eccsize = chip->ecc.size;
+	int eccbytes = chip->ecc.bytes;
+	int eccsteps = chip->ecc.steps;
+	u8 *p = buf;
+	u8 *ecc_calc = chip->buffers->ecccalc;
+	u8 *ecc_code = chip->buffers->ecccode;
+	int off, len, group = 0;
+	/*
+	 * ecc_oob is intentionally taken as u16. In 16bit devices, we end up
+	 * reading 14 bytes (7 words) from oob. The local array is to maintain
+	 * word alignment
+	 */
+	u16 ecc_oob[7];
+	u8 *oob = (u8 *)&ecc_oob[0];
+
+	for (i = 0, s = 0; s < eccsteps; s++, i += eccbytes, p += eccsize) {
+
+		chip->cmdfunc(mtd, NAND_CMD_READ0, s * eccsize, page);
+		chip->ecc.hwctl(mtd, NAND_ECC_READ);
+		chip->read_buf(mtd, p, eccsize);
+
+		for (j = 0; j < eccbytes;) {
+			off = ecc_place->eccplace[group].offset;
+			len = ecc_place->eccplace[group].length;
+			group++;
+
+			/*
+			* length is intentionally kept a higher multiple of 2
+			* to read at least 13 bytes even in case of 16 bit NAND
+			* devices
+			*/
+			len = roundup(len, 2);
+			chip->cmdfunc(mtd, NAND_CMD_READOOB, off, page);
+			chip->read_buf(mtd, oob + j, len);
+			j += len;
+		}
+
+		memcpy(&ecc_code[i], oob, 13);
+		chip->ecc.calculate(mtd, p, &ecc_calc[i]);
+
+		stat = chip->ecc.correct(mtd, p, &ecc_code[i], &ecc_calc[i]);
+		if (stat < 0)
+			mtd->ecc_stats.failed++;
+		else
+			mtd->ecc_stats.corrected += stat;
+	}
+
+	return 0;
+}
+
+/*
+ * fsmc_correct_data
+ * @mtd:	mtd info structure
+ * @dat:	buffer of read data
+ * @read_ecc:	ecc read from device spare area
+ * @calc_ecc:	ecc calculated from read data
+ *
+ * calc_ecc is a 104 bit information containing maximum of 8 error
+ * offset informations of 13 bits each in 512 bytes of read data.
+ */
+static int fsmc_correct_data(struct mtd_info *mtd, u8 *dat, u8 *read_ecc,
+		u8 *calc_ecc)
+{
+	struct spear_nand_data *host = container_of(mtd,
+					struct spear_nand_data, mtd);
+	struct fsmc_regs *regs = host->regs_va;
+	unsigned int bank = host->bank;
+	u16 err_idx[8];
+	u64 ecc_data[2];
+	u32 num_err, i;
+
+	/* The calculated ecc is actually the correction index in data */
+	memcpy(ecc_data, calc_ecc, 13);
+
+	/*
+	 * ------------------- calc_ecc[] bit wise -----------|--13 bits--|
+	 * |---idx[7]--|--.....-----|---idx[2]--||---idx[1]--||---idx[0]--|
+	 *
+	 * calc_ecc is a 104 bit information containing maximum of 8 error
+	 * offset informations of 13 bits each. calc_ecc is copied into a u64
+	 * array and error offset indexes are populated in err_idx array
+	 */
+	for (i = 0; i < 8; i++) {
+		if (i == 4) {
+			err_idx[4] = ((ecc_data[1] & 0x1) << 12) | ecc_data[0];
+			ecc_data[1] >>= 1;
+			continue;
+		}
+		err_idx[i] = (ecc_data[i/4] & 0x1FFF);
+		ecc_data[i/4] >>= 13;
+	}
+
+	num_err = (readl(&regs->bank_regs[bank].sts) >> 10) & 0xF;
+
+	if (num_err == 0xF)
+		return -EBADMSG;
+
+	i = 0;
+	while (num_err--) {
+		change_bit(0, (unsigned long *)&err_idx[i]);
+		change_bit(1, (unsigned long *)&err_idx[i]);
+
+		if (err_idx[i] <= 512 * 8) {
+			change_bit(err_idx[i], (unsigned long *)dat);
+			i++;
+		}
+	}
+	return i;
+}
+
+/*
+ * spear_nand_probe - Probe function
+ * @pdev:       platform device structure
+ */
+static int spear_nand_probe(struct platform_device *pdev)
+{
+	struct nand_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct spear_nand_data *host;
+	struct mtd_info *mtd;
+	struct nand_chip *nand;
+	struct fsmc_regs *regs;
+	struct resource *res;
+	int nr_parts, ret = 0;
+
+	if (!pdata) {
+		pr_err("Platform data is NULL\n");
+		return -EINVAL;
+	}
+
+	/* Allocate memory for the device structure (and zero it) */
+	host = kzalloc(sizeof(*host), GFP_KERNEL);
+	if (!host) {
+		dev_err(&pdev->dev, "Failed to allocate device structure.\n");
+		return -ENOMEM;
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "nand_data");
+	if (!res) {
+		ret = -EIO;
+		goto err_probe1;
+	}
+
+	host->resdata = request_mem_region(res->start, resource_size(res),
+			pdev->name);
+	if (!host->resdata) {
+		ret = -EIO;
+		goto err_probe1;
+	}
+
+	host->data_va = ioremap(res->start, resource_size(res));
+	if (!host->data_va) {
+		ret = -EIO;
+		goto err_probe1;
+	}
+
+	host->resaddr = request_mem_region(res->start + PLAT_NAND_ALE,
+			resource_size(res), pdev->name);
+	if (!host->resaddr) {
+		ret = -EIO;
+		goto err_probe1;
+	}
+
+	host->addr_va = ioremap(res->start + PLAT_NAND_ALE, resource_size(res));
+	if (!host->addr_va) {
+		ret = -EIO;
+		goto err_probe1;
+	}
+
+	host->rescmd = request_mem_region(res->start + PLAT_NAND_CLE,
+			resource_size(res), pdev->name);
+	if (!host->rescmd) {
+		ret = -EIO;
+		goto err_probe1;
+	}
+
+	host->cmd_va = ioremap(res->start + PLAT_NAND_CLE, resource_size(res));
+	if (!host->cmd_va) {
+		ret = -EIO;
+		goto err_probe1;
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fsmc_regs");
+	if (!res) {
+		ret = -EIO;
+		goto err_probe1;
+	}
+
+	host->resregs = request_mem_region(res->start, resource_size(res),
+			pdev->name);
+	if (!host->resregs) {
+		ret = -EIO;
+		goto err_probe1;
+	}
+
+	host->regs_va = ioremap(res->start, resource_size(res));
+	if (!host->regs_va) {
+		ret = -EIO;
+		goto err_probe1;
+	}
+
+	host->clk = clk_get(NULL, "fsmc");
+	if (IS_ERR(host->clk)) {
+		ret = PTR_ERR(host->clk);
+		host->clk = NULL;
+		goto err_probe1;
+	}
+
+	ret = clk_enable(host->clk);
+	if (ret)
+		goto err_probe1;
+
+	host->bank = pdata->bank;
+	host->select_chip = pdata->select_bank;
+	regs = host->regs_va;
+
+	/* Link all private pointers */
+	mtd = &host->mtd;
+	nand = &host->nand;
+	mtd->priv = nand;
+	nand->priv = host;
+
+	host->mtd.owner = THIS_MODULE;
+	nand->IO_ADDR_R = host->data_va;
+	nand->IO_ADDR_W = host->data_va;
+	nand->cmd_ctrl = spear_cmd_ctrl;
+	nand->chip_delay = 30;
+
+	nand->ecc.mode = NAND_ECC_HW;
+	nand->ecc.hwctl = fsmc_enable_hwecc;
+	nand->ecc.size = 512;
+	nand->options = pdata->options;
+	nand->select_chip = spear_select_chip;
+
+	if (pdata->width == SPEAR_NAND_BW16)
+		nand->options |= NAND_BUSWIDTH_16;
+
+	fsmc_nand_init(regs, host->bank, nand->options & NAND_BUSWIDTH_16);
+
+	if (get_fsmc_version(host->regs_va) == FSMC_VER8) {
+		nand->ecc.read_page = fsmc_read_page_hwecc;
+		nand->ecc.calculate = fsmc_read_hwecc_ecc4;
+		nand->ecc.correct = fsmc_correct_data;
+		nand->ecc.bytes = 13;
+	} else {
+		nand->ecc.calculate = fsmc_read_hwecc_ecc1;
+		nand->ecc.correct = nand_correct_data;
+		nand->ecc.bytes = 3;
+	}
+
+	/*
+	 * Scan to find existance of the device
+	 */
+	if (nand_scan_ident(&host->mtd, 1, NULL)) {
+		ret = -ENXIO;
+		dev_err(&pdev->dev, "No NAND Device found!\n");
+		goto err_probe;
+	}
+
+	if (get_fsmc_version(host->regs_va) == FSMC_VER8) {
+		if (host->mtd.writesize == 512) {
+			nand->ecc.layout = &fsmc_ecc4_sp_layout;
+			host->ecc_place = &fsmc_ecc4_sp_place;
+		} else {
+			nand->ecc.layout = &fsmc_ecc4_lp_layout;
+			host->ecc_place = &fsmc_ecc4_lp_place;
+		}
+	} else {
+		nand->ecc.layout = &fsmc_ecc1_layout;
+	}
+
+	/* Second stage of scan to fill MTD data-structures */
+	if (nand_scan_tail(&host->mtd)) {
+		ret = -ENXIO;
+		goto err_probe;
+	}
+
+	/*
+	 * The partition information can is accessed by (in the same precedence)
+	 *
+	 * command line through Bootloader,
+	 * platform data,
+	 * default partition information present in driver.
+	 */
+#ifdef CONFIG_MTD_PARTITIONS
+#ifdef CONFIG_MTD_CMDLINE_PARTS
+	/*
+	 * Check if partition info passed via command line
+	 */
+	host->mtd.name = "nand";
+	nr_parts = parse_mtd_partitions(&host->mtd, part_probes,
+			&host->partitions, 0);
+	if (nr_parts > 0) {
+		host->nr_partitions = nr_parts;
+	} else {
+#endif
+		/*
+		 * Check if partition info passed via command line
+		 */
+		if (pdata->partitions) {
+			host->partitions = pdata->partitions;
+			host->nr_partitions = pdata->nr_partitions;
+		} else {
+			struct mtd_partition *partition;
+			int i;
+
+			/* Select the default partitions info */
+			switch (host->mtd.size) {
+			case 0x01000000:
+			case 0x02000000:
+			case 0x04000000:
+				host->partitions = partition_info_16KB_blk;
+				host->nr_partitions =
+					sizeof(partition_info_16KB_blk) /
+					sizeof(struct mtd_partition);
+				break;
+			case 0x08000000:
+			case 0x10000000:
+			case 0x20000000:
+			case 0x40000000:
+				host->partitions = partition_info_128KB_blk;
+				host->nr_partitions =
+					sizeof(partition_info_128KB_blk) /
+					sizeof(struct mtd_partition);
+				break;
+			default:
+				ret = -ENXIO;
+				pr_err("Unsupported NAND size\n");
+				goto err_probe;
+			}
+
+			partition = host->partitions;
+			for (i = 0; i < host->nr_partitions; i++, partition++) {
+				if (partition->size == 0) {
+					partition->size = host->mtd.size -
+						partition->offset;
+					break;
+				}
+			}
+		}
+#ifdef CONFIG_MTD_CMDLINE_PARTS
+	}
+#endif
+
+	if (host->partitions) {
+		ret = add_mtd_partitions(&host->mtd, host->partitions,
+				host->nr_partitions);
+		if (ret)
+			goto err_probe;
+	}
+#else
+	dev_info(&pdev->dev, "Registering %s as whole device\n", mtd->name);
+	if (!add_mtd_device(mtd)) {
+		ret = -ENXIO;
+		goto err_probe;
+	}
+#endif
+
+	platform_set_drvdata(pdev, host);
+	dev_info(&pdev->dev, "SPEAr NAND driver registration successful\n");
+	return 0;
+
+err_probe:
+	clk_disable(host->clk);
+err_probe1:
+	if (host->clk)
+		clk_put(host->clk);
+	if (host->regs_va)
+		iounmap(host->regs_va);
+	if (host->resregs)
+		release_mem_region(host->resregs->start,
+				resource_size(host->resregs));
+	if (host->cmd_va)
+		iounmap(host->cmd_va);
+	if (host->rescmd)
+		release_mem_region(host->rescmd->start,
+				resource_size(host->rescmd));
+	if (host->addr_va)
+		iounmap(host->addr_va);
+	if (host->resaddr)
+		release_mem_region(host->resaddr->start,
+				resource_size(host->resaddr));
+	if (host->data_va)
+		iounmap(host->data_va);
+	if (host->resdata)
+		release_mem_region(host->resdata->start,
+				resource_size(host->resdata));
+
+	kfree(host);
+	return ret;
+}
+
+/*
+ * Clean up routine
+ */
+static int spear_nand_remove(struct platform_device *pdev)
+{
+	struct spear_nand_data *host = platform_get_drvdata(pdev);
+
+	platform_set_drvdata(pdev, NULL);
+
+	if (host) {
+#ifdef CONFIG_MTD_PARTITIONS
+		del_mtd_partitions(&host->mtd);
+#else
+		del_mtd_device(&host->mtd);
+#endif
+		clk_disable(host->clk);
+		clk_put(host->clk);
+
+		iounmap(host->regs_va);
+		release_mem_region(host->resregs->start,
+				resource_size(host->resregs));
+		iounmap(host->cmd_va);
+		release_mem_region(host->rescmd->start,
+				resource_size(host->rescmd));
+		iounmap(host->addr_va);
+		release_mem_region(host->resaddr->start,
+				resource_size(host->resaddr));
+		iounmap(host->data_va);
+		release_mem_region(host->resdata->start,
+				resource_size(host->resdata));
+
+		kfree(host);
+	}
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int spear_nand_suspend(struct device *dev)
+{
+	struct spear_nand_data *host = dev_get_drvdata(dev);
+	if (host)
+		clk_disable(host->clk);
+	return 0;
+}
+
+static int spear_nand_resume(struct device *dev)
+{
+	struct spear_nand_data *host = dev_get_drvdata(dev);
+	if (host)
+		clk_enable(host->clk);
+	return 0;
+}
+
+static const struct dev_pm_ops spear_nand_pm_ops = {
+	.suspend = spear_nand_suspend,
+	.resume = spear_nand_resume,
+};
+#endif
+
+static struct platform_driver spear_nand_driver = {
+	.probe = spear_nand_probe,
+	.remove = spear_nand_remove,
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "nand",
+#ifdef CONFIG_PM
+		.pm = &spear_nand_pm_ops,
+#endif
+	},
+};
+
+static int __init spear_nand_init(void)
+{
+	return platform_driver_register(&spear_nand_driver);
+}
+module_init(spear_nand_init);
+
+static void __exit spear_nand_exit(void)
+{
+	platform_driver_unregister(&spear_nand_driver);
+}
+module_exit(spear_nand_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Vipin Kumar <vipin.kumar@st.com>, Ashish Priyadarshi");
+MODULE_DESCRIPTION("NAND driver for SPEAr Platforms");
-- 
1.7.2.2
