From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 17:01:02 +0530
Subject: [PATCH V6 13/17] ST SPEAr: Adding machine support for nand
In-Reply-To: <cover.1298977727.git.viresh.kumar@st.com>
References: <cover.1298977727.git.viresh.kumar@st.com>
Message-ID: <072643b488d58ea2a71d166d7ab81feaf84e5fa4.1298977728.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vipin Kumar <vipin.kumar@st.com>

Reviewed-by: Stanley Miao <stanley.miao@windriver.com>
Signed-off-by: Vipin Kumar <vipin.kumar@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear13xx/include/mach/generic.h |    3 +
 arch/arm/mach-spear13xx/spear1300_evb.c        |   17 +++++
 arch/arm/mach-spear13xx/spear1310_evb.c        |   17 +++++
 arch/arm/mach-spear13xx/spear13xx.c            |   53 +++++++++++++++
 arch/arm/mach-spear3xx/include/mach/generic.h  |    6 ++
 arch/arm/mach-spear3xx/spear300.c              |   85 ++++++++++++++++++++++++
 arch/arm/mach-spear3xx/spear300_evb.c          |   15 ++++
 arch/arm/mach-spear3xx/spear310.c              |   22 ++++++
 arch/arm/mach-spear3xx/spear310_evb.c          |   15 ++++
 arch/arm/mach-spear3xx/spear320.c              |   22 ++++++
 arch/arm/mach-spear3xx/spear320_evb.c          |   15 ++++
 arch/arm/mach-spear6xx/include/mach/generic.h  |    1 +
 arch/arm/mach-spear6xx/spear600_evb.c          |   15 ++++
 arch/arm/mach-spear6xx/spear6xx.c              |   22 ++++++
 14 files changed, 308 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index f86f097..f332f96 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -227,6 +227,7 @@ extern struct platform_device spear13xx_ehci0_device;
 extern struct platform_device spear13xx_ehci1_device;
 extern struct platform_device spear13xx_i2c_device;
 extern struct platform_device spear13xx_kbd_device;
+extern struct platform_device spear13xx_nand_device;
 extern struct platform_device spear13xx_ohci0_device;
 extern struct platform_device spear13xx_ohci1_device;
 extern struct platform_device spear13xx_rtc_device;
@@ -239,6 +240,8 @@ void __init spear_setup_timer(void);
 void __init spear13xx_map_io(void);
 void __init spear13xx_init_irq(void);
 void __init spear13xx_init(void);
+void __init nand_mach_init(u32 busw);
+void nand_select_bank(u32 bank, u32 busw);
 void spear13xx_secondary_startup(void);
 
 /* spear1300 declarations */
diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
index 19be757..9aafa91 100644
--- a/arch/arm/mach-spear13xx/spear1300_evb.c
+++ b/arch/arm/mach-spear13xx/spear1300_evb.c
@@ -12,6 +12,8 @@
  */
 
 #include <linux/types.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/fsmc.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 #include <plat/keyboard.h>
@@ -49,11 +51,19 @@ static struct platform_device *plat_devs[] __initdata = {
 	&spear13xx_ehci1_device,
 	&spear13xx_i2c_device,
 	&spear13xx_kbd_device,
+	&spear13xx_nand_device,
 	&spear13xx_ohci0_device,
 	&spear13xx_ohci1_device,
 	&spear13xx_rtc_device,
 };
 
+/* fsmc platform data */
+static const struct fsmc_nand_platform_data nand_plat_data __initconst = {
+	.select_bank = nand_select_bank,
+	.options = NAND_SKIP_BBTSCAN,
+	.width = FSMC_NAND_BW8,
+};
+
 /* keyboard specific platform data */
 static const __initconst DECLARE_KEYMAP(keymap);
 static const struct matrix_keymap_data keymap_data __initconst = {
@@ -97,6 +107,13 @@ static void __init spear1300_evb_init(void)
 	/* call spear1300 machine init function */
 	spear1300_init(NULL, pmx_devs, ARRAY_SIZE(pmx_devs));
 
+	/* set nand device's plat data */
+	nand_mach_init(FSMC_NAND_BW8);
+	if (platform_device_add_data(&spear13xx_nand_device, &nand_plat_data,
+				sizeof(nand_plat_data)))
+		printk(KERN_WARNING "%s: couldn't add plat_data",
+				spear13xx_nand_device.name);
+
 	/* set keyboard plat data */
 	if (platform_device_add_data(&spear13xx_kbd_device, &kbd_data,
 				sizeof(kbd_data)))
diff --git a/arch/arm/mach-spear13xx/spear1310_evb.c b/arch/arm/mach-spear13xx/spear1310_evb.c
index e196223..d4ef083 100644
--- a/arch/arm/mach-spear13xx/spear1310_evb.c
+++ b/arch/arm/mach-spear13xx/spear1310_evb.c
@@ -12,6 +12,8 @@
  */
 
 #include <linux/types.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/fsmc.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 #include <plat/keyboard.h>
@@ -64,6 +66,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	&spear13xx_ehci1_device,
 	&spear13xx_i2c_device,
 	&spear13xx_kbd_device,
+	&spear13xx_nand_device,
 	&spear13xx_ohci0_device,
 	&spear13xx_ohci1_device,
 	&spear13xx_rtc_device,
@@ -74,6 +77,13 @@ static struct platform_device *plat_devs[] __initdata = {
 	&spear1310_i2c1_device,
 };
 
+/* fsmc platform data */
+static const struct fsmc_nand_platform_data nand_plat_data __initconst = {
+	.select_bank = nand_select_bank,
+	.options = NAND_SKIP_BBTSCAN,
+	.width = FSMC_NAND_BW8,
+};
+
 /* keyboard specific platform data */
 static const __initconst DECLARE_KEYMAP(keymap);
 static const struct matrix_keymap_data keymap_data __initconst = {
@@ -117,6 +127,13 @@ static void __init spear1310_evb_init(void)
 	/* call spear1310 machine init function */
 	spear1310_init(NULL, pmx_devs, ARRAY_SIZE(pmx_devs));
 
+	/* set nand device's plat data */
+	nand_mach_init(FSMC_NAND_BW8);
+	if (platform_device_add_data(&spear13xx_nand_device, &nand_plat_data,
+				sizeof(nand_plat_data)))
+		printk(KERN_WARNING "%s: couldn't add plat_data",
+				spear13xx_nand_device.name);
+
 	/* set keyboard plat data */
 	if (platform_device_add_data(&spear13xx_kbd_device, &kbd_data,
 				sizeof(kbd_data)))
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index 3856161..4e8cd35 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -15,6 +15,7 @@
 #include <linux/amba/pl061.h>
 #include <linux/ptrace.h>
 #include <linux/io.h>
+#include <linux/mtd/fsmc.h>
 #include <asm/hardware/gic.h>
 #include <asm/irq.h>
 #include <asm/localtimer.h>
@@ -24,6 +25,7 @@
 #include <mach/generic.h>
 #include <mach/hardware.h>
 #include <mach/irqs.h>
+#include <mach/misc_regs.h>
 
 /* Add spear13xx machines common devices here */
 /* gpio device registeration */
@@ -98,6 +100,57 @@ struct platform_device spear13xx_i2c_device = {
 	.resource = i2c_resources,
 };
 
+/* nand device registeration */
+void __init nand_mach_init(u32 busw)
+{
+	u32 fsmc_cfg = readl(FSMC_CFG);
+	fsmc_cfg &= ~(FSMC_MEMSEL_MASK << FSMC_MEMSEL_SHIFT);
+	fsmc_cfg |= (FSMC_MEM_NAND << FSMC_MEMSEL_SHIFT);
+
+	if (busw == FSMC_NAND_BW16)
+		fsmc_cfg |= 1 << NAND_DEV_WIDTH16;
+	else
+		fsmc_cfg &= ~(1 << NAND_DEV_WIDTH16);
+
+	writel(fsmc_cfg, FSMC_CFG);
+}
+
+void nand_select_bank(u32 bank, u32 busw)
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
+struct platform_device spear13xx_nand_device = {
+	.name = "fsmc-nand",
+	.id = -1,
+	.resource = nand_resources,
+	.num_resources = ARRAY_SIZE(nand_resources),
+};
+
 /* usb host device registeration */
 static struct resource ehci0_resources[] = {
 	[0] = {
diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index 0307f7e..189aed4 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -108,6 +108,10 @@ extern struct pmx_dev spear3xx_pmx_plgpio_45_46_49_50;
 /* Add spear300 machine device structure declarations here */
 extern struct amba_device spear300_gpio1_device;
 extern struct platform_device spear300_kbd_device;
+extern struct platform_device spear300_nand0_device;
+extern struct platform_device spear300_nand1_device;
+extern struct platform_device spear300_nand2_device;
+extern struct platform_device spear300_nand3_device;
 
 /* pad mux modes */
 extern struct pmx_mode spear300_nand_mode;
@@ -158,6 +162,7 @@ extern struct amba_device spear310_uart2_device;
 extern struct amba_device spear310_uart3_device;
 extern struct amba_device spear310_uart4_device;
 extern struct amba_device spear310_uart5_device;
+extern struct platform_device spear310_nand_device;
 extern struct platform_device spear310_plgpio_device;
 
 /* pad mux devices */
@@ -185,6 +190,7 @@ extern struct amba_device spear320_uart2_device;
 extern struct platform_device spear320_can0_device;
 extern struct platform_device spear320_can1_device;
 extern struct platform_device spear320_i2c1_device;
+extern struct platform_device spear320_nand_device;
 extern struct platform_device spear320_plgpio_device;
 extern struct platform_device spear320_pwm_device;
 
diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index 6b75fe8..3a46551 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -614,6 +614,91 @@ struct platform_device spear300_kbd_device = {
 	.resource = kbd_resources,
 };
 
+/* nand device registeration */
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
+struct platform_device spear300_nand0_device = {
+	.name = "fsmc-nand",
+	.id = 0,
+	.resource = nand0_resources,
+	.num_resources = ARRAY_SIZE(nand0_resources),
+};
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
+struct platform_device spear300_nand1_device = {
+	.name = "fsmc-nand",
+	.id = 1,
+	.resource = nand1_resources,
+	.num_resources = ARRAY_SIZE(nand1_resources),
+};
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
+struct platform_device spear300_nand2_device = {
+	.name = "fsmc-nand",
+	.id = 2,
+	.resource = nand2_resources,
+	.num_resources = ARRAY_SIZE(nand2_resources),
+};
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
+struct platform_device spear300_nand3_device = {
+	.name = "fsmc-nand",
+	.id = 3,
+	.resource = nand3_resources,
+	.num_resources = ARRAY_SIZE(nand3_resources),
+};
+
 /* spear300 routines */
 void __init spear300_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
 		u8 pmx_dev_count)
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index 280bf80..92f9346 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -11,6 +11,8 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/mtd/nand.h>
+#include <linux/mtd/fsmc.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 #include <plat/keyboard.h>
@@ -53,6 +55,13 @@ static struct platform_device *plat_devs[] __initdata = {
 
 	/* spear300 specific devices */
 	&spear300_kbd_device,
+	&spear300_nand0_device,
+};
+
+/* fsmc platform data */
+static const struct fsmc_nand_platform_data nand0_plat_data __initconst = {
+	.options = NAND_SKIP_BBTSCAN,
+	.width = FSMC_NAND_BW8,
 };
 
 /* keyboard specific platform data */
@@ -75,6 +84,12 @@ static void __init spear300_evb_init(void)
 	spear300_init(&spear300_photo_frame_mode, pmx_devs,
 			ARRAY_SIZE(pmx_devs));
 
+	/* set nand0 device's plat data */
+	if (platform_device_add_data(&spear300_nand0_device, &nand0_plat_data,
+				sizeof(nand0_plat_data)))
+		printk(KERN_WARNING "%s: couldn't add plat_data",
+				spear300_nand0_device.name);
+
 	/* set keyboard plat data */
 	if (platform_device_add_data(&spear300_kbd_device, &kbd_data,
 				sizeof(kbd_data)))
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
index ba21b75..9a1bea7 100644
--- a/arch/arm/mach-spear3xx/spear310.c
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -374,6 +374,28 @@ struct amba_device spear310_uart5_device = {
 	.irq = {SPEAR310_VIRQ_UART5, NO_IRQ},
 };
 
+/* nand device registeration */
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
+struct platform_device spear310_nand_device = {
+	.name = "fsmc-nand",
+	.id = -1,
+	.resource = nand_resources,
+	.num_resources = ARRAY_SIZE(nand_resources),
+};
+
 /* plgpio device registeration */
 /*
  * pin to offset and offset to pin converter functions
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
index 38f2331..9c5c9b1 100644
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -11,6 +11,8 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/mtd/nand.h>
+#include <linux/mtd/fsmc.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 #include <mach/emi.h>
@@ -95,9 +97,16 @@ static struct platform_device *plat_devs[] __initdata = {
 
 	/* spear310 specific devices */
 	&spear310_emi_nor_device,
+	&spear310_nand_device,
 	&spear310_plgpio_device,
 };
 
+/* fsmc platform data */
+static const struct fsmc_nand_platform_data nand_plat_data __initconst = {
+	.options = NAND_SKIP_BBTSCAN,
+	.width = FSMC_NAND_BW8,
+};
+
 static void __init spear310_evb_init(void)
 {
 	unsigned int i;
@@ -108,6 +117,12 @@ static void __init spear310_evb_init(void)
 	/* Initialize emi regiters */
 	emi_init(SPEAR310_EMI_REG_BASE, 0, EMI_FLASH_WIDTH32);
 
+	/* set nand device's plat data */
+	if (platform_device_add_data(&spear310_nand_device, &nand_plat_data,
+				sizeof(nand_plat_data)))
+		printk(KERN_WARNING "%s: couldn't add plat_data",
+				spear310_nand_device.name);
+
 	/* Register slave devices on the I2C buses */
 	i2c_register_default_devices();
 
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 047dcae..4a5041f 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -797,6 +797,28 @@ struct platform_device spear320_i2c1_device = {
 	.resource = i2c1_resources,
 };
 
+/* nand device registeration */
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
+struct platform_device spear320_nand_device = {
+	.name = "fsmc-nand",
+	.id = -1,
+	.resource = nand_resources,
+	.num_resources = ARRAY_SIZE(nand_resources),
+};
+
 /* plgpio device registeration */
 static struct plgpio_platform_data plgpio_plat_data = {
 	.gpio_base = 8,
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index 75f1495..bfe5d09 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -11,6 +11,8 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/mtd/nand.h>
+#include <linux/mtd/fsmc.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 #include <mach/emi.h>
@@ -92,10 +94,17 @@ static struct platform_device *plat_devs[] __initdata = {
 	&spear320_can1_device,
 	&spear320_i2c1_device,
 	&spear320_emi_nor_device,
+	&spear320_nand_device,
 	&spear320_plgpio_device,
 	&spear320_pwm_device,
 };
 
+/* fsmc platform data */
+static const struct fsmc_nand_platform_data nand_plat_data __initconst = {
+	.options = NAND_SKIP_BBTSCAN,
+	.width = FSMC_NAND_BW8,
+};
+
 static void __init spear320_evb_init(void)
 {
 	unsigned int i;
@@ -107,6 +116,12 @@ static void __init spear320_evb_init(void)
 	/* Initialize emi regiters */
 	emi_init(SPEAR320_EMI_CTRL_BASE, 0, EMI_FLASH_WIDTH16);
 
+	/* set nand device's plat data */
+	if (platform_device_add_data(&spear320_nand_device, &nand_plat_data,
+				sizeof(nand_plat_data)))
+		printk(KERN_WARNING "%s: couldn't add plat_data",
+				spear320_nand_device.name);
+
 	/* Register slave devices on the I2C buses */
 	i2c_register_default_devices();
 
diff --git a/arch/arm/mach-spear6xx/include/mach/generic.h b/arch/arm/mach-spear6xx/include/mach/generic.h
index 62d8b09..df2606f 100644
--- a/arch/arm/mach-spear6xx/include/mach/generic.h
+++ b/arch/arm/mach-spear6xx/include/mach/generic.h
@@ -35,6 +35,7 @@ extern struct amba_device wdt_device;
 extern struct platform_device ehci0_device;
 extern struct platform_device ehci1_device;
 extern struct platform_device i2c_device;
+extern struct platform_device nand_device;
 extern struct platform_device ohci0_device;
 extern struct platform_device ohci1_device;
 extern struct platform_device rtc_device;
diff --git a/arch/arm/mach-spear6xx/spear600_evb.c b/arch/arm/mach-spear6xx/spear600_evb.c
index d8a13a1..93cc614 100644
--- a/arch/arm/mach-spear6xx/spear600_evb.c
+++ b/arch/arm/mach-spear6xx/spear600_evb.c
@@ -11,6 +11,8 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/mtd/nand.h>
+#include <linux/mtd/fsmc.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 #include <mach/generic.h>
@@ -31,13 +33,26 @@ static struct platform_device *plat_devs[] __initdata = {
 	&i2c_device,
 	&ohci0_device,
 	&ohci1_device,
+	&nand_device,
 	&rtc_device,
 };
 
+/* fsmc platform data */
+static const struct fsmc_nand_platform_data nand_plat_data __initconst = {
+	.options = NAND_SKIP_BBTSCAN,
+	.width = FSMC_NAND_BW8,
+};
+
 static void __init spear600_evb_init(void)
 {
 	unsigned int i;
 
+	/* set nand device's plat data */
+	if (platform_device_add_data(&nand_device, &nand_plat_data,
+				sizeof(nand_plat_data)))
+		printk(KERN_WARNING "%s: couldn't add plat_data",
+				nand_device.name);
+
 	/* call spear600 machine init function */
 	spear600_init();
 
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index fb1a804..927812d 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -133,6 +133,28 @@ struct platform_device i2c_device = {
 	.resource = i2c_resources,
 };
 
+/* nand device registeration */
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
+	.name = "fsmc-nand",
+	.id = -1,
+	.resource = nand_resources,
+	.num_resources = ARRAY_SIZE(nand_resources),
+};
+
 /* usb host device registeration */
 static struct resource ehci0_resources[] = {
 	[0] = {
-- 
1.7.2.2
