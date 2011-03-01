From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 17:01:04 +0530
Subject: [PATCH V6 15/17] ST SPEAr: Adding support for SDHCI (SDIO)
In-Reply-To: <cover.1298977727.git.viresh.kumar@st.com>
References: <cover.1298977727.git.viresh.kumar@st.com>
Message-ID: <256355a3e856b41ebbebb714f5d68c92eade7765.1298977728.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: Stanley Miao <stanley.miao@windriver.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
---
 arch/arm/mach-spear13xx/include/mach/generic.h |    1 +
 arch/arm/mach-spear13xx/spear1300_evb.c        |    1 +
 arch/arm/mach-spear13xx/spear1310_evb.c        |    1 +
 arch/arm/mach-spear13xx/spear13xx.c            |   34 +++++++++++++++++++
 arch/arm/mach-spear3xx/include/mach/generic.h  |    6 +++
 arch/arm/mach-spear3xx/spear300.c              |   42 ++++++++++++++++++++++++
 arch/arm/mach-spear3xx/spear300_evb.c          |   16 +++++++++
 arch/arm/mach-spear3xx/spear320.c              |   23 +++++++++++++
 arch/arm/mach-spear3xx/spear320_evb.c          |   13 +++++++
 9 files changed, 137 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index 15f5e03..d918368 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -232,6 +232,7 @@ extern struct platform_device spear13xx_nand_device;
 extern struct platform_device spear13xx_ohci0_device;
 extern struct platform_device spear13xx_ohci1_device;
 extern struct platform_device spear13xx_rtc_device;
+extern struct platform_device spear13xx_sdhci_device;
 extern struct sys_timer spear13xx_timer;
 
 /* Add spear13xx family function declarations here */
diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
index 8500e10..3b619e5 100644
--- a/arch/arm/mach-spear13xx/spear1300_evb.c
+++ b/arch/arm/mach-spear13xx/spear1300_evb.c
@@ -60,6 +60,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	&spear13xx_ohci0_device,
 	&spear13xx_ohci1_device,
 	&spear13xx_rtc_device,
+	&spear13xx_sdhci_device,
 };
 
 /* fsmc platform data */
diff --git a/arch/arm/mach-spear13xx/spear1310_evb.c b/arch/arm/mach-spear13xx/spear1310_evb.c
index ec3d617..11aafd8 100644
--- a/arch/arm/mach-spear13xx/spear1310_evb.c
+++ b/arch/arm/mach-spear13xx/spear1310_evb.c
@@ -75,6 +75,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	&spear13xx_ohci0_device,
 	&spear13xx_ohci1_device,
 	&spear13xx_rtc_device,
+	&spear13xx_sdhci_device,
 
 	/* spear1310 specific devices */
 	&spear1310_can0_device,
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index 47f45d5..5370b5b 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -326,6 +326,38 @@ struct platform_device spear13xx_rtc_device = {
 	.resource = rtc_resources,
 };
 
+/* sdhci (sdio) device declaration */
+static struct resource sdhci_resources[] = {
+	{
+		.start	= SPEAR13XX_MCIF_SDHCI_BASE,
+		.end	= SPEAR13XX_MCIF_SDHCI_BASE + SZ_256 - 1,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= IRQ_SDHCI,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device spear13xx_sdhci_device = {
+	.dev = {
+		.coherent_dma_mask = ~0,
+	},
+	.name = "sdhci",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(sdhci_resources),
+	.resource = sdhci_resources,
+};
+
+static void sdhci_enable(void)
+{
+	unsigned val = readl(PERIP_CFG);
+
+	/* This function enables SD/MMC interface out of SD/MMC, CF, XD */
+	val &= ~(MCIF_SEL_MASK << MCIF_SEL_SHIFT);
+	val |= SD_MMC_ACTIVE << MCIF_SEL_SHIFT;
+	writel(val, PERIP_CFG);
+}
+
 #ifdef CONFIG_PCIEPORTBUS
 /* PCIE0 clock always needs to be enabled if any of the three PCIE port
  * have to be used. So call this function from the board initilization
@@ -367,6 +399,8 @@ void __init spear13xx_init(void)
 	 */
 	l2x0_init(__io_address(SPEAR13XX_L2CC_BASE), 0x00260249, 0xfe00ffff);
 #endif
+
+	sdhci_enable();
 }
 
 /* This will initialize vic */
diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index 39cc43f..54540e2 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -113,6 +113,7 @@ extern struct platform_device spear300_nand0_device;
 extern struct platform_device spear300_nand1_device;
 extern struct platform_device spear300_nand2_device;
 extern struct platform_device spear300_nand3_device;
+extern struct platform_device spear300_sdhci_device;
 
 /* pad mux modes */
 extern struct pmx_mode spear300_nand_mode;
@@ -152,6 +153,10 @@ extern struct pmx_dev spear300_pmx_gpio1;
 /* Add spear300 machine function declarations here */
 void __init spear300_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
 		u8 pmx_dev_count);
+#define SDHCI_MEM_ENB		0x1
+#define I2S_MEM_ENB		0x2
+#define SDHCI_MEM_SELECT	0x20000000
+void sdhci_i2s_mem_enable(u8 mask);
 
 #endif /* CONFIG_MACH_SPEAR300 */
 
@@ -195,6 +200,7 @@ extern struct platform_device spear320_i2c1_device;
 extern struct platform_device spear320_nand_device;
 extern struct platform_device spear320_plgpio_device;
 extern struct platform_device spear320_pwm_device;
+extern struct platform_device spear320_sdhci_device;
 
 /* pad mux modes */
 extern struct pmx_mode spear320_auto_net_smii_mode;
diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index 3a46551..3643b79 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -699,6 +699,48 @@ struct platform_device spear300_nand3_device = {
 	.num_resources = ARRAY_SIZE(nand3_resources),
 };
 
+/* sdhci (sdio) device declaration */
+static struct resource sdhci_resources[] = {
+	{
+		.start	= SPEAR300_SDHCI_BASE,
+		.end	= SPEAR300_SDHCI_BASE + SZ_256 - 1,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= SPEAR300_IRQ_SDHCI,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device spear300_sdhci_device = {
+	.dev = {
+		.coherent_dma_mask = ~0,
+	},
+	.name = "sdhci",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(sdhci_resources),
+	.resource = sdhci_resources,
+};
+
+/* Function handling sdhci and i2s memory sharing */
+void sdhci_i2s_mem_enable(u8 mask)
+{
+	u32 val;
+	void __iomem *config = ioremap(SPEAR300_MODE_CONFIG_REG, SZ_16);
+	if (!config) {
+		pr_debug("sdhci_i2s_enb: ioremap fail\n");
+		return;
+	}
+
+	val = readl(config);
+	if (mask == SDHCI_MEM_ENB)
+		val |= SDHCI_MEM_SELECT;
+	else
+		val &= ~SDHCI_MEM_SELECT;
+	writel(val, config);
+
+	iounmap(config);
+}
+
 /* spear300 routines */
 void __init spear300_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
 		u8 pmx_dev_count)
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index 7ab29d4..30b5a1c 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/gpio.h>
+#include <linux/mmc/sdhci-spear.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/fsmc.h>
 #include <linux/spi/flash.h>
@@ -61,6 +62,15 @@ static struct platform_device *plat_devs[] __initdata = {
 	/* spear300 specific devices */
 	&spear300_kbd_device,
 	&spear300_nand0_device,
+	&spear300_sdhci_device,
+};
+
+/* sdhci board specific information */
+static struct sdhci_plat_data sdhci_plat_data = {
+	.card_power_gpio = RAS_GPIO_2,
+	.power_active_high = 0,
+	.power_always_enb = 0,
+	.card_int_gpio = RAS_GPIO_0,
 };
 
 /* fsmc platform data */
@@ -122,6 +132,12 @@ static void __init spear300_evb_init(void)
 	/* Register slave devices on the I2C buses */
 	i2c_register_default_devices();
 
+	/* set sdhci device platform data */
+	sdhci_set_plat_data(&spear300_sdhci_device, &sdhci_plat_data);
+
+	/* Enable sdhci memory */
+	sdhci_i2s_mem_enable(SDHCI_MEM_ENB);
+
 	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
 
 	/* Add Platform Devices */
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index ac5dfb4..34e66cf 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -13,6 +13,7 @@
 
 #include <linux/amba/pl022.h>
 #include <linux/ptrace.h>
+#include <linux/mmc/sdhci-spear.h>
 #include <asm/irq.h>
 #include <plat/gpio.h>
 #include <plat/shirq.h>
@@ -905,6 +906,28 @@ struct platform_device spear320_pwm_device = {
 	.resource = pwm_resources,
 };
 
+/* sdhci (sdio) device registeration */
+static struct resource sdhci_resources[] = {
+	{
+		.start	= SPEAR320_SDHCI_BASE,
+		.end	= SPEAR320_SDHCI_BASE + SZ_256 - 1,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= SPEAR320_IRQ_SDHCI,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device spear320_sdhci_device = {
+	.dev = {
+		.coherent_dma_mask = ~0,
+	},
+	.name = "sdhci",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(sdhci_resources),
+	.resource = sdhci_resources,
+};
+
 /* spear320 routines */
 void __init spear320_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
 		u8 pmx_dev_count)
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index a1a76f2..2b27383 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -15,6 +15,7 @@
 #include <linux/mtd/nand.h>
 #include <linux/mtd/fsmc.h>
 #include <linux/spi/flash.h>
+#include <linux/mmc/sdhci-spear.h>
 #include <linux/spi/spi.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -104,6 +105,15 @@ static struct platform_device *plat_devs[] __initdata = {
 	&spear320_nand_device,
 	&spear320_plgpio_device,
 	&spear320_pwm_device,
+	&spear320_sdhci_device,
+};
+
+/* sdhci board specific information */
+static struct sdhci_plat_data sdhci_plat_data = {
+	.card_power_gpio = PLGPIO_61,
+	.power_active_high = 0,
+	.power_always_enb = 1,
+	.card_int_gpio = -1,
 };
 
 /* fsmc platform data */
@@ -133,6 +143,9 @@ static void __init spear320_evb_init(void)
 		printk(KERN_WARNING "%s: couldn't add plat_data",
 				spear320_nand_device.name);
 
+	/* set sdhci device platform data */
+	sdhci_set_plat_data(&spear320_sdhci_device, &sdhci_plat_data);
+
 	/* Register slave devices on the I2C buses */
 	i2c_register_default_devices();
 
-- 
1.7.2.2
