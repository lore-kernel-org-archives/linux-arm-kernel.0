From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Mon, 9 Aug 2010 19:18:17 +0530
Subject: [PATCH 4/4] ux500: mop500: add TC35892 and MicroSD slot support
In-Reply-To: <1281361697-4874-1-git-send-email-rabin.vincent@stericsson.com>
References: <1281361697-4874-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1281361697-4874-4-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500-sdi.c             |   63 ++++++++++++++++++++
 arch/arm/mach-ux500/board-mop500.c                 |   34 +++++++++++
 arch/arm/mach-ux500/board-mop500.h                 |    8 +++
 .../mach-ux500/include/mach/irqs-board-mop500.h    |   14 ++++-
 4 files changed, 118 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
index bac9956..f0095ff 100644
--- a/arch/arm/mach-ux500/board-mop500-sdi.c
+++ b/arch/arm/mach-ux500/board-mop500-sdi.c
@@ -20,6 +20,19 @@
 #include "board-mop500.h"
 
 static pin_cfg_t mop500_sdi_pins[] = {
+	/* SDI0 (MicroSD slot) */
+	GPIO18_MC0_CMDDIR,
+	GPIO19_MC0_DAT0DIR,
+	GPIO20_MC0_DAT2DIR,
+	GPIO21_MC0_DAT31DIR,
+	GPIO22_MC0_FBCLK,
+	GPIO23_MC0_CLK,
+	GPIO24_MC0_CMD,
+	GPIO25_MC0_DAT0,
+	GPIO26_MC0_DAT1,
+	GPIO27_MC0_DAT2,
+	GPIO28_MC0_DAT3,
+
 	/* SDI4 (on-board eMMC) */
 	GPIO197_MC4_DAT3,
 	GPIO198_MC4_DAT2,
@@ -50,6 +63,55 @@ static pin_cfg_t mop500_sdi2_pins[] = {
 };
 
 /*
+ * SDI 0 (MicroSD slot)
+ */
+
+/* MMCIPOWER bits */
+#define MCI_DATA2DIREN		(1 << 2)
+#define MCI_CMDDIREN		(1 << 3)
+#define MCI_DATA0DIREN		(1 << 4)
+#define MCI_DATA31DIREN		(1 << 5)
+#define MCI_FBCLKEN		(1 << 7)
+
+static u32 mop500_sdi0_vdd_handler(struct device *dev, unsigned int vdd,
+				   unsigned char power_mode)
+{
+	if (power_mode == MMC_POWER_UP)
+		gpio_set_value(GPIO_SDMMC_EN, 1);
+	else if (power_mode == MMC_POWER_OFF)
+		gpio_set_value(GPIO_SDMMC_EN, 0);
+
+	return MCI_FBCLKEN | MCI_CMDDIREN | MCI_DATA0DIREN |
+	       MCI_DATA2DIREN | MCI_DATA31DIREN;
+}
+
+static struct mmci_platform_data mop500_sdi0_data = {
+	.vdd_handler	= mop500_sdi0_vdd_handler,
+	.ocr_mask	= MMC_VDD_29_30,
+	.f_max		= 100000000,
+	.capabilities	= MMC_CAP_4_BIT_DATA,
+	.gpio_cd	= GPIO_SDMMC_CD,
+	.gpio_wp	= -1,
+};
+
+void mop500_sdi_tc35892_init(void)
+{
+	int ret;
+
+	ret = gpio_request(GPIO_SDMMC_EN, "SDMMC_EN");
+	if (!ret)
+		ret = gpio_request(GPIO_SDMMC_1V8_3V_SEL,
+				   "GPIO_SDMMC_1V8_3V_SEL");
+	if (ret)
+		return;
+
+	gpio_direction_output(GPIO_SDMMC_1V8_3V_SEL, 1);
+	gpio_direction_output(GPIO_SDMMC_EN, 0);
+
+	amba_device_register(&u8500_sdi0_device, &iomem_resource);
+}
+
+/*
  * SDI 2 (POP eMMC, not on DB8500ed)
  */
 
@@ -78,6 +140,7 @@ void mop500_sdi_init(void)
 {
 	nmk_config_pins(mop500_sdi_pins, ARRAY_SIZE(mop500_sdi_pins));
 
+	u8500_sdi0_device.dev.platform_data = &mop500_sdi0_data;
 	u8500_sdi2_device.dev.platform_data = &mop500_sdi2_data;
 	u8500_sdi4_device.dev.platform_data = &mop500_sdi4_data;
 
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index de31032..3abdd7e 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -13,11 +13,13 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/i2c.h>
 #include <linux/gpio.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/pl022.h>
 #include <linux/spi/spi.h>
 #include <linux/mfd/ab8500.h>
+#include <linux/mfd/tc35892.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -48,6 +50,8 @@ static pin_cfg_t mop500_pins[] = {
 	GPIO11_I2C2_SCL,
 	GPIO229_I2C3_SDA,
 	GPIO230_I2C3_SCL,
+
+	GPIO217_GPIO,		/* GPIO_EXP_INT */
 };
 
 static void ab4500_spi_cs_control(u32 command)
@@ -99,6 +103,33 @@ static struct pl022_ssp_controller ssp0_platform_data = {
 	.num_chipselect = 5,
 };
 
+/*
+ * TC35892
+ */
+
+static void mop500_tc35892_init(struct tc35892 *tc35892, unsigned int base)
+{
+	mop500_sdi_tc35892_init();
+}
+
+static struct tc35892_gpio_platform_data mop500_tc35892_gpio_data = {
+	.gpio_base	= MOP500_EGPIO(0),
+	.setup		= mop500_tc35892_init,
+};
+
+static struct tc35892_platform_data mop500_tc35892_data = {
+	.gpio		= &mop500_tc35892_gpio_data,
+	.irq_base	= MOP500_EGPIO_IRQ_BASE,
+};
+
+static struct i2c_board_info mop500_i2c0_devices[] = {
+	{
+		I2C_BOARD_INFO("tc35892", 0x42),
+		.irq            = NOMADIK_GPIO_TO_IRQ(217),
+		.platform_data  = &mop500_tc35892_data,
+	},
+};
+
 #define U8500_I2C_CONTROLLER(id, _slsu, _tft, _rft, clk, _sm) \
 static struct nmk_i2c_controller u8500_i2c##id##_data = { \
 	/*				\
@@ -168,6 +199,9 @@ static void __init u8500_init_machine(void)
 
 	spi_register_board_info(u8500_spi_devices,
 			ARRAY_SIZE(u8500_spi_devices));
+
+	i2c_register_board_info(0, mop500_i2c0_devices,
+				ARRAY_SIZE(mop500_i2c0_devices));
 }
 
 MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
diff --git a/arch/arm/mach-ux500/board-mop500.h b/arch/arm/mach-ux500/board-mop500.h
index 2d24032..3a338e6 100644
--- a/arch/arm/mach-ux500/board-mop500.h
+++ b/arch/arm/mach-ux500/board-mop500.h
@@ -7,6 +7,14 @@
 #ifndef __BOARD_MOP500_H
 #define __BOARD_MOP500_H
 
+#define MOP500_EGPIO(x)			(NOMADIK_NR_GPIO + (x))
+
+/* GPIOs on the TC35892 expander */
+#define GPIO_SDMMC_CD			MOP500_EGPIO(3)
+#define GPIO_SDMMC_EN			MOP500_EGPIO(17)
+#define GPIO_SDMMC_1V8_3V_SEL		MOP500_EGPIO(18)
+
 extern void mop500_sdi_init(void);
+extern void mop500_sdi_tc35892_init(void);
 
 #endif
diff --git a/arch/arm/mach-ux500/include/mach/irqs-board-mop500.h b/arch/arm/mach-ux500/include/mach/irqs-board-mop500.h
index cca4f70..7ee8aaa 100644
--- a/arch/arm/mach-ux500/include/mach/irqs-board-mop500.h
+++ b/arch/arm/mach-ux500/include/mach/irqs-board-mop500.h
@@ -13,7 +13,19 @@
 #define MOP500_AB8500_IRQ_BASE		IRQ_BOARD_START
 #define MOP500_AB8500_IRQ_END		(MOP500_AB8500_IRQ_BASE \
 					 + AB8500_NR_IRQS)
-#define MOP500_IRQ_END			MOP500_AB8500_IRQ_END
+
+#define TC35892_NR_INTERNAL_IRQS	8
+#define TC35892_INT_GPIO(x)		(TC35892_NR_INTERNAL_IRQS + (x))
+#define TC35892_NR_GPIOS		24
+#define TC35892_NR_IRQS			TC35892_INT_GPIO(TC35892_NR_GPIOS)
+
+#define MOP500_EGPIO_NR_IRQS		TC35892_NR_IRQS
+
+#define MOP500_EGPIO_IRQ_BASE		MOP500_AB8500_IRQ_END
+#define MOP500_EGPIO_IRQ_END		(MOP500_EGPIO_IRQ_BASE \
+					 + MOP500_EGPIO_NR_IRQS)
+
+#define MOP500_IRQ_END			MOP500_EGPIO_IRQ_END
 
 #if MOP500_IRQ_END > IRQ_BOARD_END
 #undef IRQ_BOARD_END
-- 
1.7.2.dirty
