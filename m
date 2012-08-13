From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Aug 2012 21:05:34 +0800
Subject: [PATCH 14/17] ARM: imx53: support device tree boot only
In-Reply-To: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
References: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1344863137-6112-15-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With device tree kernel provides the equal support as those imx53 board
files, it's time to remove the board files and get imx53 support device
tree only.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/configs/imx_v6_v7_defconfig           |    2 +-
 arch/arm/mach-imx/Kconfig                      |   79 +-----
 arch/arm/mach-imx/Makefile                     |    6 +-
 arch/arm/mach-imx/Makefile.boot                |    8 +-
 arch/arm/mach-imx/{imx53-dt.c => mach-imx53.c} |    0
 arch/arm/mach-imx/mach-mx53_ard.c              |  272 --------------------
 arch/arm/mach-imx/mach-mx53_evk.c              |  179 -------------
 arch/arm/mach-imx/mach-mx53_loco.c             |  321 ------------------------
 arch/arm/mach-imx/mach-mx53_smd.c              |  168 -------------
 9 files changed, 18 insertions(+), 1017 deletions(-)
 rename arch/arm/mach-imx/{imx53-dt.c => mach-imx53.c} (100%)
 delete mode 100644 arch/arm/mach-imx/mach-mx53_ard.c
 delete mode 100644 arch/arm/mach-imx/mach-mx53_evk.c
 delete mode 100644 arch/arm/mach-imx/mach-mx53_loco.c
 delete mode 100644 arch/arm/mach-imx/mach-mx53_smd.c

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 81817d0..8e865c0 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -32,7 +32,7 @@ CONFIG_MACH_VPR200=y
 CONFIG_MACH_IMX51_DT=y
 CONFIG_MACH_MX51_3DS=y
 CONFIG_MACH_EUKREA_CPUIMX51SD=y
-CONFIG_MACH_IMX53_DT=y
+CONFIG_SOC_IMX53=y
 CONFIG_SOC_IMX6Q=y
 CONFIG_MXC_PWM=y
 CONFIG_SMP=y
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 1afdc67..374fcc2 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -102,15 +102,6 @@ config	SOC_IMX51
 	select ARCH_MX5
 	select ARCH_MX51
 
-config	SOC_IMX53
-	bool
-	select SOC_IMX5
-	select ARCH_MX5
-	select ARCH_MX53
-	select HAVE_CAN_FLEXCAN if CAN
-	select PINCTRL
-	select PINCTRL_IMX53
-
 if ARCH_IMX_V4_V5
 
 comment "MX1 platforms:"
@@ -738,69 +729,19 @@ config MACH_EUKREA_MBIMXSD51_BASEBOARD
 
 endchoice
 
-comment "i.MX53 machines:"
-
-config MACH_IMX53_DT
-	bool "Support i.MX53 platforms from device tree"
-	select SOC_IMX53
-	select MACH_MX53_ARD
-	select MACH_MX53_EVK
-	select MACH_MX53_LOCO
-	select MACH_MX53_SMD
-	help
-	  Include support for Freescale i.MX53 based platforms
-	  using the device tree for discovery
-
-config MACH_MX53_EVK
-	bool "Support MX53 EVK platforms"
-	select SOC_IMX53
-	select IMX_HAVE_PLATFORM_IMX2_WDT
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_IMX_I2C
-	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
-	select IMX_HAVE_PLATFORM_SPI_IMX
-	select LEDS_GPIO_REGISTER
-	help
-	  Include support for MX53 EVK platform. This includes specific
-	  configurations for the board and its peripherals.
-
-config MACH_MX53_SMD
-	bool "Support MX53 SMD platforms"
-	select SOC_IMX53
-	select IMX_HAVE_PLATFORM_IMX2_WDT
-	select IMX_HAVE_PLATFORM_IMX_I2C
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
-	help
-	  Include support for MX53 SMD platform. This includes specific
-	  configurations for the board and its peripherals.
+comment "Device tree only"
 
-config MACH_MX53_LOCO
-	bool "Support MX53 LOCO platforms"
-	select SOC_IMX53
-	select IMX_HAVE_PLATFORM_IMX2_WDT
-	select IMX_HAVE_PLATFORM_IMX_I2C
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
-	select IMX_HAVE_PLATFORM_GPIO_KEYS
-	select LEDS_GPIO_REGISTER
-	help
-	  Include support for MX53 LOCO platform. This includes specific
-	  configurations for the board and its peripherals.
+config	SOC_IMX53
+	bool "i.MX53 support"
+	select SOC_IMX5
+	select ARCH_MX5
+	select ARCH_MX53
+	select HAVE_CAN_FLEXCAN if CAN
+	select PINCTRL
+	select PINCTRL_IMX53
 
-config MACH_MX53_ARD
-	bool "Support MX53 ARD platforms"
-	select SOC_IMX53
-	select IMX_HAVE_PLATFORM_IMX2_WDT
-	select IMX_HAVE_PLATFORM_IMX_I2C
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
-	select IMX_HAVE_PLATFORM_GPIO_KEYS
 	help
-	  Include support for MX53 ARD platform. This includes specific
-	  configurations for the board and its peripherals.
-
-comment "i.MX6 family:"
+	  This enables support for Freescale i.MX53 processor.
 
 config SOC_IMX6Q
 	bool "i.MX6 Quad support"
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 88b756c..58dc7c6 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -83,13 +83,9 @@ endif
 # i.MX5 based machines
 obj-$(CONFIG_MACH_MX51_BABBAGE) += mach-mx51_babbage.o
 obj-$(CONFIG_MACH_MX51_3DS) += mach-mx51_3ds.o
-obj-$(CONFIG_MACH_MX53_EVK) += mach-mx53_evk.o
-obj-$(CONFIG_MACH_MX53_SMD) += mach-mx53_smd.o
-obj-$(CONFIG_MACH_MX53_LOCO) += mach-mx53_loco.o
-obj-$(CONFIG_MACH_MX53_ARD) += mach-mx53_ard.o
 obj-$(CONFIG_MACH_EUKREA_CPUIMX51SD) += mach-cpuimx51sd.o
 obj-$(CONFIG_MACH_EUKREA_MBIMXSD51_BASEBOARD) += eukrea_mbimxsd51-baseboard.o
 obj-$(CONFIG_MACH_MX50_RDP) += mach-mx50_rdp.o
 
 obj-$(CONFIG_MACH_IMX51_DT) += imx51-dt.o
-obj-$(CONFIG_MACH_IMX53_DT) += imx53-dt.o
+obj-$(CONFIG_SOC_IMX53) += mach-imx53.o
diff --git a/arch/arm/mach-imx/Makefile.boot b/arch/arm/mach-imx/Makefile.boot
index 05541cf..c609676 100644
--- a/arch/arm/mach-imx/Makefile.boot
+++ b/arch/arm/mach-imx/Makefile.boot
@@ -39,8 +39,12 @@ params_phys-$(CONFIG_SOC_IMX6Q)	:= 0x10000100
 initrd_phys-$(CONFIG_SOC_IMX6Q)	:= 0x10800000
 
 dtb-$(CONFIG_MACH_IMX51_DT) += imx51-babbage.dtb
-dtb-$(CONFIG_MACH_IMX53_DT) += imx53-ard.dtb imx53-evk.dtb \
-			       imx53-qsb.dtb imx53-smd.dtb
+
+dtb-$(CONFIG_SOC_IMX53) += imx53-ard.dtb \
+			   imx53-evk.dtb \
+			   imx53-qsb.dtb \
+			   imx53-smd.dtb \
+
 dtb-$(CONFIG_SOC_IMX6Q)	+= imx6q-arm2.dtb \
 			   imx6q-sabrelite.dtb \
 			   imx6q-sabresd.dtb \
diff --git a/arch/arm/mach-imx/imx53-dt.c b/arch/arm/mach-imx/mach-imx53.c
similarity index 100%
rename from arch/arm/mach-imx/imx53-dt.c
rename to arch/arm/mach-imx/mach-imx53.c
diff --git a/arch/arm/mach-imx/mach-mx53_ard.c b/arch/arm/mach-imx/mach-mx53_ard.c
deleted file mode 100644
index 6c28e65..0000000
--- a/arch/arm/mach-imx/mach-mx53_ard.c
+++ /dev/null
@@ -1,272 +0,0 @@
-/*
- * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
- */
-
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
-
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
-
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#include <linux/init.h>
-#include <linux/clk.h>
-#include <linux/delay.h>
-#include <linux/gpio.h>
-#include <linux/smsc911x.h>
-#include <linux/regulator/machine.h>
-#include <linux/regulator/fixed.h>
-
-#include <mach/common.h>
-#include <mach/hardware.h>
-#include <mach/iomux-mx53.h>
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/time.h>
-
-#include "devices-imx53.h"
-
-#define ARD_ETHERNET_INT_B	IMX_GPIO_NR(2, 31)
-#define ARD_SD1_CD		IMX_GPIO_NR(1, 1)
-#define ARD_SD1_WP		IMX_GPIO_NR(1, 9)
-#define ARD_I2CPORTEXP_B	IMX_GPIO_NR(2, 3)
-#define ARD_VOLUMEDOWN		IMX_GPIO_NR(4, 0)
-#define ARD_HOME			IMX_GPIO_NR(5, 10)
-#define ARD_BACK			IMX_GPIO_NR(5, 11)
-#define ARD_PROG			IMX_GPIO_NR(5, 12)
-#define ARD_VOLUMEUP		IMX_GPIO_NR(5, 13)
-
-static iomux_v3_cfg_t mx53_ard_pads[] = {
-	/* UART1 */
-	MX53_PAD_PATA_DIOW__UART1_TXD_MUX,
-	MX53_PAD_PATA_DMACK__UART1_RXD_MUX,
-	/* WEIM for CS1 */
-	MX53_PAD_EIM_EB3__GPIO2_31, /* ETHERNET_INT_B */
-	MX53_PAD_EIM_D16__EMI_WEIM_D_16,
-	MX53_PAD_EIM_D17__EMI_WEIM_D_17,
-	MX53_PAD_EIM_D18__EMI_WEIM_D_18,
-	MX53_PAD_EIM_D19__EMI_WEIM_D_19,
-	MX53_PAD_EIM_D20__EMI_WEIM_D_20,
-	MX53_PAD_EIM_D21__EMI_WEIM_D_21,
-	MX53_PAD_EIM_D22__EMI_WEIM_D_22,
-	MX53_PAD_EIM_D23__EMI_WEIM_D_23,
-	MX53_PAD_EIM_D24__EMI_WEIM_D_24,
-	MX53_PAD_EIM_D25__EMI_WEIM_D_25,
-	MX53_PAD_EIM_D26__EMI_WEIM_D_26,
-	MX53_PAD_EIM_D27__EMI_WEIM_D_27,
-	MX53_PAD_EIM_D28__EMI_WEIM_D_28,
-	MX53_PAD_EIM_D29__EMI_WEIM_D_29,
-	MX53_PAD_EIM_D30__EMI_WEIM_D_30,
-	MX53_PAD_EIM_D31__EMI_WEIM_D_31,
-	MX53_PAD_EIM_DA0__EMI_NAND_WEIM_DA_0,
-	MX53_PAD_EIM_DA1__EMI_NAND_WEIM_DA_1,
-	MX53_PAD_EIM_DA2__EMI_NAND_WEIM_DA_2,
-	MX53_PAD_EIM_DA3__EMI_NAND_WEIM_DA_3,
-	MX53_PAD_EIM_DA4__EMI_NAND_WEIM_DA_4,
-	MX53_PAD_EIM_DA5__EMI_NAND_WEIM_DA_5,
-	MX53_PAD_EIM_DA6__EMI_NAND_WEIM_DA_6,
-	MX53_PAD_EIM_OE__EMI_WEIM_OE,
-	MX53_PAD_EIM_RW__EMI_WEIM_RW,
-	MX53_PAD_EIM_CS1__EMI_WEIM_CS_1,
-	/* SDHC1 */
-	MX53_PAD_SD1_CMD__ESDHC1_CMD,
-	MX53_PAD_SD1_CLK__ESDHC1_CLK,
-	MX53_PAD_SD1_DATA0__ESDHC1_DAT0,
-	MX53_PAD_SD1_DATA1__ESDHC1_DAT1,
-	MX53_PAD_SD1_DATA2__ESDHC1_DAT2,
-	MX53_PAD_SD1_DATA3__ESDHC1_DAT3,
-	MX53_PAD_PATA_DATA8__ESDHC1_DAT4,
-	MX53_PAD_PATA_DATA9__ESDHC1_DAT5,
-	MX53_PAD_PATA_DATA10__ESDHC1_DAT6,
-	MX53_PAD_PATA_DATA11__ESDHC1_DAT7,
-	MX53_PAD_GPIO_1__GPIO1_1,
-	MX53_PAD_GPIO_9__GPIO1_9,
-	/* I2C2 */
-	MX53_PAD_EIM_EB2__I2C2_SCL,
-	MX53_PAD_KEY_ROW3__I2C2_SDA,
-	/* I2C3 */
-	MX53_PAD_GPIO_3__I2C3_SCL,
-	MX53_PAD_GPIO_16__I2C3_SDA,
-	/* GPIO */
-	MX53_PAD_DISP0_DAT16__GPIO5_10,	/* home */
-	MX53_PAD_DISP0_DAT17__GPIO5_11,	/* back */
-	MX53_PAD_DISP0_DAT18__GPIO5_12,	/* prog */
-	MX53_PAD_DISP0_DAT19__GPIO5_13,	/* vol up */
-	MX53_PAD_GPIO_10__GPIO4_0,		/* vol down */
-};
-
-#define GPIO_BUTTON(gpio_num, ev_code, act_low, descr, wake)	\
-{							\
-	.gpio		= gpio_num,				\
-	.type		= EV_KEY,				\
-	.code		= ev_code,				\
-	.active_low	= act_low,				\
-	.desc		= "btn " descr,			\
-	.wakeup		= wake,					\
-}
-
-static struct gpio_keys_button ard_buttons[] = {
-	GPIO_BUTTON(ARD_HOME, KEY_HOME, 1, "home", 0),
-	GPIO_BUTTON(ARD_BACK, KEY_BACK, 1, "back", 0),
-	GPIO_BUTTON(ARD_PROG, KEY_PROGRAM, 1, "program", 0),
-	GPIO_BUTTON(ARD_VOLUMEUP, KEY_VOLUMEUP, 1, "volume-up", 0),
-	GPIO_BUTTON(ARD_VOLUMEDOWN, KEY_VOLUMEDOWN, 1, "volume-down", 0),
-};
-
-static const struct gpio_keys_platform_data ard_button_data __initconst = {
-	.buttons        = ard_buttons,
-	.nbuttons       = ARRAY_SIZE(ard_buttons),
-};
-
-static struct resource ard_smsc911x_resources[] = {
-	{
-		.start = MX53_CS1_64MB_BASE_ADDR,
-		.end = MX53_CS1_64MB_BASE_ADDR + SZ_32M - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		/* irq number is run-time assigned */
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct smsc911x_platform_config ard_smsc911x_config = {
-	.irq_polarity = SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
-	.irq_type = SMSC911X_IRQ_TYPE_PUSH_PULL,
-	.flags = SMSC911X_USE_32BIT,
-};
-
-static struct platform_device ard_smsc_lan9220_device = {
-	.name = "smsc911x",
-	.id = -1,
-	.num_resources = ARRAY_SIZE(ard_smsc911x_resources),
-	.resource = ard_smsc911x_resources,
-	.dev = {
-		.platform_data = &ard_smsc911x_config,
-	},
-};
-
-static const struct esdhc_platform_data mx53_ard_sd1_data __initconst = {
-	.cd_gpio = ARD_SD1_CD,
-	.wp_gpio = ARD_SD1_WP,
-};
-
-static struct imxi2c_platform_data mx53_ard_i2c2_data = {
-	.bitrate = 50000,
-};
-
-static struct imxi2c_platform_data mx53_ard_i2c3_data = {
-	.bitrate = 400000,
-};
-
-static void __init mx53_ard_io_init(void)
-{
-	gpio_request(ARD_ETHERNET_INT_B, "eth-int-b");
-	gpio_direction_input(ARD_ETHERNET_INT_B);
-
-	gpio_request(ARD_I2CPORTEXP_B, "i2cptexp-rst");
-	gpio_direction_output(ARD_I2CPORTEXP_B, 1);
-}
-
-/* Config CS1 settings for ethernet controller */
-static int weim_cs_config(void)
-{
-	u32 reg;
-	void __iomem *weim_base, *iomuxc_base;
-
-	weim_base = ioremap(MX53_WEIM_BASE_ADDR, SZ_4K);
-	if (!weim_base)
-		return -ENOMEM;
-
-	iomuxc_base = ioremap(MX53_IOMUXC_BASE_ADDR, SZ_4K);
-	if (!iomuxc_base) {
-		iounmap(weim_base);
-		return -ENOMEM;
-	}
-
-	/* CS1 timings for LAN9220 */
-	writel(0x20001, (weim_base + 0x18));
-	writel(0x0, (weim_base + 0x1C));
-	writel(0x16000202, (weim_base + 0x20));
-	writel(0x00000002, (weim_base + 0x24));
-	writel(0x16002082, (weim_base + 0x28));
-	writel(0x00000000, (weim_base + 0x2C));
-	writel(0x00000000, (weim_base + 0x90));
-
-	/* specify 64 MB on CS1 and CS0 on GPR1 */
-	reg = readl(iomuxc_base + 0x4);
-	reg &= ~0x3F;
-	reg |= 0x1B;
-	writel(reg, (iomuxc_base + 0x4));
-
-	iounmap(iomuxc_base);
-	iounmap(weim_base);
-
-	return 0;
-}
-
-static struct regulator_consumer_supply dummy_supplies[] = {
-	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
-	REGULATOR_SUPPLY("vddvario", "smsc911x"),
-};
-
-void __init imx53_ard_common_init(void)
-{
-	mxc_iomux_v3_setup_multiple_pads(mx53_ard_pads,
-					 ARRAY_SIZE(mx53_ard_pads));
-	weim_cs_config();
-}
-
-static struct platform_device *devices[] __initdata = {
-	&ard_smsc_lan9220_device,
-};
-
-static void __init mx53_ard_board_init(void)
-{
-	imx53_soc_init();
-	imx53_add_imx_uart(0, NULL);
-
-	imx53_ard_common_init();
-	mx53_ard_io_init();
-	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
-	ard_smsc911x_resources[1].start = gpio_to_irq(ARD_ETHERNET_INT_B);
-	ard_smsc911x_resources[1].end = gpio_to_irq(ARD_ETHERNET_INT_B);
-	platform_add_devices(devices, ARRAY_SIZE(devices));
-
-	imx53_add_sdhci_esdhc_imx(0, &mx53_ard_sd1_data);
-	imx53_add_imx2_wdt(0);
-	imx53_add_imx_i2c(1, &mx53_ard_i2c2_data);
-	imx53_add_imx_i2c(2, &mx53_ard_i2c3_data);
-	imx_add_gpio_keys(&ard_button_data);
-	imx53_add_ahci_imx();
-}
-
-static void __init mx53_ard_timer_init(void)
-{
-	mx53_clocks_init(32768, 24000000, 22579200, 0);
-}
-
-static struct sys_timer mx53_ard_timer = {
-	.init	= mx53_ard_timer_init,
-};
-
-MACHINE_START(MX53_ARD, "Freescale MX53 ARD Board")
-	.map_io = mx53_map_io,
-	.init_early = imx53_init_early,
-	.init_irq = mx53_init_irq,
-	.handle_irq = imx53_handle_irq,
-	.timer = &mx53_ard_timer,
-	.init_machine = mx53_ard_board_init,
-	.init_late	= imx53_init_late,
-	.restart	= mxc_restart,
-MACHINE_END
diff --git a/arch/arm/mach-imx/mach-mx53_evk.c b/arch/arm/mach-imx/mach-mx53_evk.c
deleted file mode 100644
index 09fe219..0000000
--- a/arch/arm/mach-imx/mach-mx53_evk.c
+++ /dev/null
@@ -1,179 +0,0 @@
-/*
- * Copyright (C) 2010-2011 Freescale Semiconductor, Inc. All Rights Reserved.
- * Copyright (C) 2010 Yong Shen. <Yong.Shen@linaro.org>
- */
-
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
-
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
-
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#include <linux/init.h>
-#include <linux/clk.h>
-#include <linux/delay.h>
-#include <linux/gpio.h>
-#include <linux/spi/flash.h>
-#include <linux/spi/spi.h>
-#include <mach/common.h>
-#include <mach/hardware.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/time.h>
-#include <mach/iomux-mx53.h>
-
-#define MX53_EVK_FEC_PHY_RST	IMX_GPIO_NR(7, 6)
-#define EVK_ECSPI1_CS0		IMX_GPIO_NR(2, 30)
-#define EVK_ECSPI1_CS1		IMX_GPIO_NR(3, 19)
-#define MX53EVK_LED		IMX_GPIO_NR(7, 7)
-
-#include "devices-imx53.h"
-
-static iomux_v3_cfg_t mx53_evk_pads[] = {
-	MX53_PAD_CSI0_DAT10__UART1_TXD_MUX,
-	MX53_PAD_CSI0_DAT11__UART1_RXD_MUX,
-
-	MX53_PAD_PATA_BUFFER_EN__UART2_RXD_MUX,
-	MX53_PAD_PATA_DMARQ__UART2_TXD_MUX,
-	MX53_PAD_PATA_DIOR__UART2_RTS,
-	MX53_PAD_PATA_INTRQ__UART2_CTS,
-
-	MX53_PAD_PATA_CS_0__UART3_TXD_MUX,
-	MX53_PAD_PATA_CS_1__UART3_RXD_MUX,
-
-	MX53_PAD_EIM_D16__ECSPI1_SCLK,
-	MX53_PAD_EIM_D17__ECSPI1_MISO,
-	MX53_PAD_EIM_D18__ECSPI1_MOSI,
-
-	/* ecspi chip select lines */
-	MX53_PAD_EIM_EB2__GPIO2_30,
-	MX53_PAD_EIM_D19__GPIO3_19,
-	/* LED */
-	MX53_PAD_PATA_DA_1__GPIO7_7,
-};
-
-static const struct imxuart_platform_data mx53_evk_uart_pdata __initconst = {
-	.flags = IMXUART_HAVE_RTSCTS,
-};
-
-static const struct gpio_led mx53evk_leds[] __initconst = {
-	{
-		.name			= "green",
-		.default_trigger	= "heartbeat",
-		.gpio			= MX53EVK_LED,
-	},
-};
-
-static const struct gpio_led_platform_data mx53evk_leds_data __initconst = {
-	.leds		= mx53evk_leds,
-	.num_leds	= ARRAY_SIZE(mx53evk_leds),
-};
-
-static inline void mx53_evk_init_uart(void)
-{
-	imx53_add_imx_uart(0, NULL);
-	imx53_add_imx_uart(1, &mx53_evk_uart_pdata);
-	imx53_add_imx_uart(2, NULL);
-}
-
-static const struct imxi2c_platform_data mx53_evk_i2c_data __initconst = {
-	.bitrate = 100000,
-};
-
-static inline void mx53_evk_fec_reset(void)
-{
-	int ret;
-
-	/* reset FEC PHY */
-	ret = gpio_request_one(MX53_EVK_FEC_PHY_RST, GPIOF_OUT_INIT_LOW,
-							"fec-phy-reset");
-	if (ret) {
-		printk(KERN_ERR"failed to get GPIO_FEC_PHY_RESET: %d\n", ret);
-		return;
-	}
-	msleep(1);
-	gpio_set_value(MX53_EVK_FEC_PHY_RST, 1);
-}
-
-static const struct fec_platform_data mx53_evk_fec_pdata __initconst = {
-	.phy = PHY_INTERFACE_MODE_RMII,
-};
-
-static struct spi_board_info mx53_evk_spi_board_info[] __initdata = {
-	{
-		.modalias = "mtd_dataflash",
-		.max_speed_hz = 25000000,
-		.bus_num = 0,
-		.chip_select = 1,
-		.mode = SPI_MODE_0,
-		.platform_data = NULL,
-	},
-};
-
-static int mx53_evk_spi_cs[] = {
-	EVK_ECSPI1_CS0,
-	EVK_ECSPI1_CS1,
-};
-
-static const struct spi_imx_master mx53_evk_spi_data __initconst = {
-	.chipselect     = mx53_evk_spi_cs,
-	.num_chipselect = ARRAY_SIZE(mx53_evk_spi_cs),
-};
-
-void __init imx53_evk_common_init(void)
-{
-	mxc_iomux_v3_setup_multiple_pads(mx53_evk_pads,
-					 ARRAY_SIZE(mx53_evk_pads));
-}
-
-static void __init mx53_evk_board_init(void)
-{
-	imx53_soc_init();
-	imx53_evk_common_init();
-
-	mx53_evk_init_uart();
-	mx53_evk_fec_reset();
-	imx53_add_fec(&mx53_evk_fec_pdata);
-
-	imx53_add_imx_i2c(0, &mx53_evk_i2c_data);
-	imx53_add_imx_i2c(1, &mx53_evk_i2c_data);
-
-	imx53_add_sdhci_esdhc_imx(0, NULL);
-	imx53_add_sdhci_esdhc_imx(1, NULL);
-
-	spi_register_board_info(mx53_evk_spi_board_info,
-		ARRAY_SIZE(mx53_evk_spi_board_info));
-	imx53_add_ecspi(0, &mx53_evk_spi_data);
-	imx53_add_imx2_wdt(0);
-	gpio_led_register_device(-1, &mx53evk_leds_data);
-}
-
-static void __init mx53_evk_timer_init(void)
-{
-	mx53_clocks_init(32768, 24000000, 22579200, 0);
-}
-
-static struct sys_timer mx53_evk_timer = {
-	.init	= mx53_evk_timer_init,
-};
-
-MACHINE_START(MX53_EVK, "Freescale MX53 EVK Board")
-	.map_io = mx53_map_io,
-	.init_early = imx53_init_early,
-	.init_irq = mx53_init_irq,
-	.handle_irq = imx53_handle_irq,
-	.timer = &mx53_evk_timer,
-	.init_machine = mx53_evk_board_init,
-	.init_late	= imx53_init_late,
-	.restart	= mxc_restart,
-MACHINE_END
diff --git a/arch/arm/mach-imx/mach-mx53_loco.c b/arch/arm/mach-imx/mach-mx53_loco.c
deleted file mode 100644
index 8abe23c..0000000
--- a/arch/arm/mach-imx/mach-mx53_loco.c
+++ /dev/null
@@ -1,321 +0,0 @@
-/*
- * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
- */
-
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
-
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
-
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#include <linux/init.h>
-#include <linux/clk.h>
-#include <linux/delay.h>
-#include <linux/gpio.h>
-#include <linux/i2c.h>
-
-#include <mach/common.h>
-#include <mach/hardware.h>
-#include <mach/iomux-mx53.h>
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/time.h>
-
-#include "devices-imx53.h"
-
-#define MX53_LOCO_POWER			IMX_GPIO_NR(1, 8)
-#define MX53_LOCO_UI1			IMX_GPIO_NR(2, 14)
-#define MX53_LOCO_UI2			IMX_GPIO_NR(2, 15)
-#define LOCO_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
-#define LOCO_LED			IMX_GPIO_NR(7, 7)
-#define LOCO_SD3_CD			IMX_GPIO_NR(3, 11)
-#define LOCO_SD3_WP			IMX_GPIO_NR(3, 12)
-#define LOCO_SD1_CD			IMX_GPIO_NR(3, 13)
-#define LOCO_ACCEL_EN			IMX_GPIO_NR(6, 14)
-
-static iomux_v3_cfg_t mx53_loco_pads[] = {
-	/* FEC */
-	MX53_PAD_FEC_MDC__FEC_MDC,
-	MX53_PAD_FEC_MDIO__FEC_MDIO,
-	MX53_PAD_FEC_REF_CLK__FEC_TX_CLK,
-	MX53_PAD_FEC_RX_ER__FEC_RX_ER,
-	MX53_PAD_FEC_CRS_DV__FEC_RX_DV,
-	MX53_PAD_FEC_RXD1__FEC_RDATA_1,
-	MX53_PAD_FEC_RXD0__FEC_RDATA_0,
-	MX53_PAD_FEC_TX_EN__FEC_TX_EN,
-	MX53_PAD_FEC_TXD1__FEC_TDATA_1,
-	MX53_PAD_FEC_TXD0__FEC_TDATA_0,
-	/* FEC_nRST */
-	MX53_PAD_PATA_DA_0__GPIO7_6,
-	/* FEC_nINT */
-	MX53_PAD_PATA_DATA4__GPIO2_4,
-	/* AUDMUX5 */
-	MX53_PAD_KEY_COL0__AUDMUX_AUD5_TXC,
-	MX53_PAD_KEY_ROW0__AUDMUX_AUD5_TXD,
-	MX53_PAD_KEY_COL1__AUDMUX_AUD5_TXFS,
-	MX53_PAD_KEY_ROW1__AUDMUX_AUD5_RXD,
-	/* I2C1 */
-	MX53_PAD_CSI0_DAT8__I2C1_SDA,
-	MX53_PAD_CSI0_DAT9__I2C1_SCL,
-	MX53_PAD_NANDF_CS1__GPIO6_14,	/* Accelerometer Enable */
-	/* I2C2 */
-	MX53_PAD_KEY_COL3__I2C2_SCL,
-	MX53_PAD_KEY_ROW3__I2C2_SDA,
-	/* SD1 */
-	MX53_PAD_SD1_CMD__ESDHC1_CMD,
-	MX53_PAD_SD1_CLK__ESDHC1_CLK,
-	MX53_PAD_SD1_DATA0__ESDHC1_DAT0,
-	MX53_PAD_SD1_DATA1__ESDHC1_DAT1,
-	MX53_PAD_SD1_DATA2__ESDHC1_DAT2,
-	MX53_PAD_SD1_DATA3__ESDHC1_DAT3,
-	/* SD1_CD */
-	MX53_PAD_EIM_DA13__GPIO3_13,
-	/* SD3 */
-	MX53_PAD_PATA_DATA8__ESDHC3_DAT0,
-	MX53_PAD_PATA_DATA9__ESDHC3_DAT1,
-	MX53_PAD_PATA_DATA10__ESDHC3_DAT2,
-	MX53_PAD_PATA_DATA11__ESDHC3_DAT3,
-	MX53_PAD_PATA_DATA0__ESDHC3_DAT4,
-	MX53_PAD_PATA_DATA1__ESDHC3_DAT5,
-	MX53_PAD_PATA_DATA2__ESDHC3_DAT6,
-	MX53_PAD_PATA_DATA3__ESDHC3_DAT7,
-	MX53_PAD_PATA_IORDY__ESDHC3_CLK,
-	MX53_PAD_PATA_RESET_B__ESDHC3_CMD,
-	/* SD3_CD */
-	MX53_PAD_EIM_DA11__GPIO3_11,
-	/* SD3_WP */
-	MX53_PAD_EIM_DA12__GPIO3_12,
-	/* VGA */
-	MX53_PAD_EIM_OE__IPU_DI1_PIN7,
-	MX53_PAD_EIM_RW__IPU_DI1_PIN8,
-	/* DISPLB */
-	MX53_PAD_EIM_D20__IPU_SER_DISP0_CS,
-	MX53_PAD_EIM_D21__IPU_DISPB0_SER_CLK,
-	MX53_PAD_EIM_D22__IPU_DISPB0_SER_DIN,
-	MX53_PAD_EIM_D23__IPU_DI0_D0_CS,
-	/* DISP0_POWER_EN */
-	MX53_PAD_EIM_D24__GPIO3_24,
-	/* DISP0 DET INT */
-	MX53_PAD_EIM_D31__GPIO3_31,
-	/* LVDS */
-	MX53_PAD_LVDS0_TX3_P__LDB_LVDS0_TX3,
-	MX53_PAD_LVDS0_CLK_P__LDB_LVDS0_CLK,
-	MX53_PAD_LVDS0_TX2_P__LDB_LVDS0_TX2,
-	MX53_PAD_LVDS0_TX1_P__LDB_LVDS0_TX1,
-	MX53_PAD_LVDS0_TX0_P__LDB_LVDS0_TX0,
-	MX53_PAD_LVDS1_TX3_P__LDB_LVDS1_TX3,
-	MX53_PAD_LVDS1_TX2_P__LDB_LVDS1_TX2,
-	MX53_PAD_LVDS1_CLK_P__LDB_LVDS1_CLK,
-	MX53_PAD_LVDS1_TX1_P__LDB_LVDS1_TX1,
-	MX53_PAD_LVDS1_TX0_P__LDB_LVDS1_TX0,
-	/* I2C1 */
-	MX53_PAD_CSI0_DAT8__I2C1_SDA,
-	MX53_PAD_CSI0_DAT9__I2C1_SCL,
-	/* UART1 */
-	MX53_PAD_CSI0_DAT10__UART1_TXD_MUX,
-	MX53_PAD_CSI0_DAT11__UART1_RXD_MUX,
-	/* CSI0 */
-	MX53_PAD_CSI0_DAT12__IPU_CSI0_D_12,
-	MX53_PAD_CSI0_DAT13__IPU_CSI0_D_13,
-	MX53_PAD_CSI0_DAT14__IPU_CSI0_D_14,
-	MX53_PAD_CSI0_DAT15__IPU_CSI0_D_15,
-	MX53_PAD_CSI0_DAT16__IPU_CSI0_D_16,
-	MX53_PAD_CSI0_DAT17__IPU_CSI0_D_17,
-	MX53_PAD_CSI0_DAT18__IPU_CSI0_D_18,
-	MX53_PAD_CSI0_DAT19__IPU_CSI0_D_19,
-	MX53_PAD_CSI0_VSYNC__IPU_CSI0_VSYNC,
-	MX53_PAD_CSI0_MCLK__IPU_CSI0_HSYNC,
-	MX53_PAD_CSI0_PIXCLK__IPU_CSI0_PIXCLK,
-	/* DISPLAY */
-	MX53_PAD_DI0_DISP_CLK__IPU_DI0_DISP_CLK,
-	MX53_PAD_DI0_PIN15__IPU_DI0_PIN15,
-	MX53_PAD_DI0_PIN2__IPU_DI0_PIN2,
-	MX53_PAD_DI0_PIN3__IPU_DI0_PIN3,
-	MX53_PAD_DISP0_DAT0__IPU_DISP0_DAT_0,
-	MX53_PAD_DISP0_DAT1__IPU_DISP0_DAT_1,
-	MX53_PAD_DISP0_DAT2__IPU_DISP0_DAT_2,
-	MX53_PAD_DISP0_DAT3__IPU_DISP0_DAT_3,
-	MX53_PAD_DISP0_DAT4__IPU_DISP0_DAT_4,
-	MX53_PAD_DISP0_DAT5__IPU_DISP0_DAT_5,
-	MX53_PAD_DISP0_DAT6__IPU_DISP0_DAT_6,
-	MX53_PAD_DISP0_DAT7__IPU_DISP0_DAT_7,
-	MX53_PAD_DISP0_DAT8__IPU_DISP0_DAT_8,
-	MX53_PAD_DISP0_DAT9__IPU_DISP0_DAT_9,
-	MX53_PAD_DISP0_DAT10__IPU_DISP0_DAT_10,
-	MX53_PAD_DISP0_DAT11__IPU_DISP0_DAT_11,
-	MX53_PAD_DISP0_DAT12__IPU_DISP0_DAT_12,
-	MX53_PAD_DISP0_DAT13__IPU_DISP0_DAT_13,
-	MX53_PAD_DISP0_DAT14__IPU_DISP0_DAT_14,
-	MX53_PAD_DISP0_DAT15__IPU_DISP0_DAT_15,
-	MX53_PAD_DISP0_DAT16__IPU_DISP0_DAT_16,
-	MX53_PAD_DISP0_DAT17__IPU_DISP0_DAT_17,
-	MX53_PAD_DISP0_DAT18__IPU_DISP0_DAT_18,
-	MX53_PAD_DISP0_DAT19__IPU_DISP0_DAT_19,
-	MX53_PAD_DISP0_DAT20__IPU_DISP0_DAT_20,
-	MX53_PAD_DISP0_DAT21__IPU_DISP0_DAT_21,
-	MX53_PAD_DISP0_DAT22__IPU_DISP0_DAT_22,
-	MX53_PAD_DISP0_DAT23__IPU_DISP0_DAT_23,
-	/* Audio CLK*/
-	MX53_PAD_GPIO_0__CCM_SSI_EXT1_CLK,
-	/* PWM */
-	MX53_PAD_GPIO_1__PWM2_PWMO,
-	/* SPDIF */
-	MX53_PAD_GPIO_7__SPDIF_PLOCK,
-	MX53_PAD_GPIO_17__SPDIF_OUT1,
-	/* GPIO */
-	MX53_PAD_PATA_DA_1__GPIO7_7,		/* LED */
-	MX53_PAD_PATA_DA_2__GPIO7_8,
-	MX53_PAD_PATA_DATA5__GPIO2_5,
-	MX53_PAD_PATA_DATA6__GPIO2_6,
-	MX53_PAD_PATA_DATA14__GPIO2_14,
-	MX53_PAD_PATA_DATA15__GPIO2_15,
-	MX53_PAD_PATA_INTRQ__GPIO7_2,
-	MX53_PAD_EIM_WAIT__GPIO5_0,
-	MX53_PAD_NANDF_WP_B__GPIO6_9,
-	MX53_PAD_NANDF_RB0__GPIO6_10,
-	MX53_PAD_NANDF_CS1__GPIO6_14,
-	MX53_PAD_NANDF_CS2__GPIO6_15,
-	MX53_PAD_NANDF_CS3__GPIO6_16,
-	MX53_PAD_GPIO_5__GPIO1_5,
-	MX53_PAD_GPIO_16__GPIO7_11,
-	MX53_PAD_GPIO_8__GPIO1_8,
-};
-
-#define GPIO_BUTTON(gpio_num, ev_code, act_low, descr, wake)	\
-{								\
-	.gpio		= gpio_num,				\
-	.type		= EV_KEY,				\
-	.code		= ev_code,				\
-	.active_low	= act_low,				\
-	.desc		= "btn " descr,				\
-	.wakeup		= wake,					\
-}
-
-static struct gpio_keys_button loco_buttons[] = {
-	GPIO_BUTTON(MX53_LOCO_POWER, KEY_POWER, 1, "power", 0),
-	GPIO_BUTTON(MX53_LOCO_UI1, KEY_VOLUMEUP, 1, "volume-up", 0),
-	GPIO_BUTTON(MX53_LOCO_UI2, KEY_VOLUMEDOWN, 1, "volume-down", 0),
-};
-
-static const struct gpio_keys_platform_data loco_button_data __initconst = {
-	.buttons        = loco_buttons,
-	.nbuttons       = ARRAY_SIZE(loco_buttons),
-};
-
-static const struct esdhc_platform_data mx53_loco_sd1_data __initconst = {
-	.cd_gpio = LOCO_SD1_CD,
-	.cd_type = ESDHC_CD_GPIO,
-	.wp_type = ESDHC_WP_NONE,
-};
-
-static const struct esdhc_platform_data mx53_loco_sd3_data __initconst = {
-	.cd_gpio = LOCO_SD3_CD,
-	.wp_gpio = LOCO_SD3_WP,
-	.cd_type = ESDHC_CD_GPIO,
-	.wp_type = ESDHC_WP_GPIO,
-};
-
-static inline void mx53_loco_fec_reset(void)
-{
-	int ret;
-
-	/* reset FEC PHY */
-	ret = gpio_request(LOCO_FEC_PHY_RST, "fec-phy-reset");
-	if (ret) {
-		printk(KERN_ERR"failed to get GPIO_FEC_PHY_RESET: %d\n", ret);
-		return;
-	}
-	gpio_direction_output(LOCO_FEC_PHY_RST, 0);
-	msleep(1);
-	gpio_set_value(LOCO_FEC_PHY_RST, 1);
-}
-
-static const struct fec_platform_data mx53_loco_fec_data __initconst = {
-	.phy = PHY_INTERFACE_MODE_RMII,
-};
-
-static const struct imxi2c_platform_data mx53_loco_i2c_data __initconst = {
-	.bitrate = 100000,
-};
-
-static const struct gpio_led mx53loco_leds[] __initconst = {
-	{
-		.name			= "green",
-		.default_trigger	= "heartbeat",
-		.gpio			= LOCO_LED,
-	},
-};
-
-static const struct gpio_led_platform_data mx53loco_leds_data __initconst = {
-	.leds		= mx53loco_leds,
-	.num_leds	= ARRAY_SIZE(mx53loco_leds),
-};
-
-void __init imx53_qsb_common_init(void)
-{
-	mxc_iomux_v3_setup_multiple_pads(mx53_loco_pads,
-					 ARRAY_SIZE(mx53_loco_pads));
-}
-
-static struct i2c_board_info mx53loco_i2c_devices[] = {
-	{
-		I2C_BOARD_INFO("mma8450", 0x1C),
-	},
-};
-
-static void __init mx53_loco_board_init(void)
-{
-	int ret;
-	imx53_soc_init();
-	imx53_qsb_common_init();
-
-	imx53_add_imx_uart(0, NULL);
-	mx53_loco_fec_reset();
-	imx53_add_fec(&mx53_loco_fec_data);
-	imx53_add_imx2_wdt(0);
-
-	ret = gpio_request_one(LOCO_ACCEL_EN, GPIOF_OUT_INIT_HIGH, "accel_en");
-	if (ret)
-		pr_err("Cannot request ACCEL_EN pin: %d\n", ret);
-
-	i2c_register_board_info(0, mx53loco_i2c_devices,
-				ARRAY_SIZE(mx53loco_i2c_devices));
-	imx53_add_imx_i2c(0, &mx53_loco_i2c_data);
-	imx53_add_imx_i2c(1, &mx53_loco_i2c_data);
-	imx53_add_sdhci_esdhc_imx(0, &mx53_loco_sd1_data);
-	imx53_add_sdhci_esdhc_imx(2, &mx53_loco_sd3_data);
-	imx_add_gpio_keys(&loco_button_data);
-	gpio_led_register_device(-1, &mx53loco_leds_data);
-	imx53_add_ahci_imx();
-}
-
-static void __init mx53_loco_timer_init(void)
-{
-	mx53_clocks_init(32768, 24000000, 0, 0);
-}
-
-static struct sys_timer mx53_loco_timer = {
-	.init	= mx53_loco_timer_init,
-};
-
-MACHINE_START(MX53_LOCO, "Freescale MX53 LOCO Board")
-	.map_io = mx53_map_io,
-	.init_early = imx53_init_early,
-	.init_irq = mx53_init_irq,
-	.handle_irq = imx53_handle_irq,
-	.timer = &mx53_loco_timer,
-	.init_machine = mx53_loco_board_init,
-	.init_late	= imx53_init_late,
-	.restart	= mxc_restart,
-MACHINE_END
diff --git a/arch/arm/mach-imx/mach-mx53_smd.c b/arch/arm/mach-imx/mach-mx53_smd.c
deleted file mode 100644
index b15d6a6..0000000
--- a/arch/arm/mach-imx/mach-mx53_smd.c
+++ /dev/null
@@ -1,168 +0,0 @@
-/*
- * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
- */
-
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
-
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
-
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#include <linux/init.h>
-#include <linux/clk.h>
-#include <linux/delay.h>
-#include <linux/gpio.h>
-
-#include <mach/common.h>
-#include <mach/hardware.h>
-#include <mach/iomux-mx53.h>
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/time.h>
-
-#include "devices-imx53.h"
-
-#define SMD_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
-#define MX53_SMD_SATA_PWR_EN    IMX_GPIO_NR(3, 3)
-
-static iomux_v3_cfg_t mx53_smd_pads[] = {
-	MX53_PAD_CSI0_DAT10__UART1_TXD_MUX,
-	MX53_PAD_CSI0_DAT11__UART1_RXD_MUX,
-
-	MX53_PAD_PATA_BUFFER_EN__UART2_RXD_MUX,
-	MX53_PAD_PATA_DMARQ__UART2_TXD_MUX,
-
-	MX53_PAD_PATA_CS_0__UART3_TXD_MUX,
-	MX53_PAD_PATA_CS_1__UART3_RXD_MUX,
-	MX53_PAD_PATA_DA_1__UART3_CTS,
-	MX53_PAD_PATA_DA_2__UART3_RTS,
-	/* I2C1 */
-	MX53_PAD_CSI0_DAT8__I2C1_SDA,
-	MX53_PAD_CSI0_DAT9__I2C1_SCL,
-	/* SD1 */
-	MX53_PAD_SD1_CMD__ESDHC1_CMD,
-	MX53_PAD_SD1_CLK__ESDHC1_CLK,
-	MX53_PAD_SD1_DATA0__ESDHC1_DAT0,
-	MX53_PAD_SD1_DATA1__ESDHC1_DAT1,
-	MX53_PAD_SD1_DATA2__ESDHC1_DAT2,
-	MX53_PAD_SD1_DATA3__ESDHC1_DAT3,
-	/* SD2 */
-	MX53_PAD_SD2_CMD__ESDHC2_CMD,
-	MX53_PAD_SD2_CLK__ESDHC2_CLK,
-	MX53_PAD_SD2_DATA0__ESDHC2_DAT0,
-	MX53_PAD_SD2_DATA1__ESDHC2_DAT1,
-	MX53_PAD_SD2_DATA2__ESDHC2_DAT2,
-	MX53_PAD_SD2_DATA3__ESDHC2_DAT3,
-	/* SD3 */
-	MX53_PAD_PATA_DATA8__ESDHC3_DAT0,
-	MX53_PAD_PATA_DATA9__ESDHC3_DAT1,
-	MX53_PAD_PATA_DATA10__ESDHC3_DAT2,
-	MX53_PAD_PATA_DATA11__ESDHC3_DAT3,
-	MX53_PAD_PATA_DATA0__ESDHC3_DAT4,
-	MX53_PAD_PATA_DATA1__ESDHC3_DAT5,
-	MX53_PAD_PATA_DATA2__ESDHC3_DAT6,
-	MX53_PAD_PATA_DATA3__ESDHC3_DAT7,
-	MX53_PAD_PATA_IORDY__ESDHC3_CLK,
-	MX53_PAD_PATA_RESET_B__ESDHC3_CMD,
-};
-
-static const struct imxuart_platform_data mx53_smd_uart_data __initconst = {
-	.flags = IMXUART_HAVE_RTSCTS,
-};
-
-static inline void mx53_smd_init_uart(void)
-{
-	imx53_add_imx_uart(0, NULL);
-	imx53_add_imx_uart(1, NULL);
-	imx53_add_imx_uart(2, &mx53_smd_uart_data);
-}
-
-static inline void mx53_smd_fec_reset(void)
-{
-	int ret;
-
-	/* reset FEC PHY */
-	ret = gpio_request(SMD_FEC_PHY_RST, "fec-phy-reset");
-	if (ret) {
-		printk(KERN_ERR"failed to get GPIO_FEC_PHY_RESET: %d\n", ret);
-		return;
-	}
-	gpio_direction_output(SMD_FEC_PHY_RST, 0);
-	msleep(1);
-	gpio_set_value(SMD_FEC_PHY_RST, 1);
-}
-
-static const struct fec_platform_data mx53_smd_fec_data __initconst = {
-	.phy = PHY_INTERFACE_MODE_RMII,
-};
-
-static const struct imxi2c_platform_data mx53_smd_i2c_data __initconst = {
-	.bitrate = 100000,
-};
-
-static inline void mx53_smd_ahci_pwr_on(void)
-{
-	int ret;
-
-	/* Enable SATA PWR */
-	ret = gpio_request_one(MX53_SMD_SATA_PWR_EN,
-			GPIOF_DIR_OUT | GPIOF_INIT_HIGH, "ahci-sata-pwr");
-	if (ret) {
-		pr_err("failed to enable SATA_PWR_EN: %d\n", ret);
-		return;
-	}
-}
-
-void __init imx53_smd_common_init(void)
-{
-	mxc_iomux_v3_setup_multiple_pads(mx53_smd_pads,
-					 ARRAY_SIZE(mx53_smd_pads));
-}
-
-static void __init mx53_smd_board_init(void)
-{
-	imx53_soc_init();
-	imx53_smd_common_init();
-
-	mx53_smd_init_uart();
-	mx53_smd_fec_reset();
-	imx53_add_fec(&mx53_smd_fec_data);
-	imx53_add_imx2_wdt(0);
-	imx53_add_imx_i2c(0, &mx53_smd_i2c_data);
-	imx53_add_sdhci_esdhc_imx(0, NULL);
-	imx53_add_sdhci_esdhc_imx(1, NULL);
-	imx53_add_sdhci_esdhc_imx(2, NULL);
-	mx53_smd_ahci_pwr_on();
-	imx53_add_ahci_imx();
-}
-
-static void __init mx53_smd_timer_init(void)
-{
-	mx53_clocks_init(32768, 24000000, 22579200, 0);
-}
-
-static struct sys_timer mx53_smd_timer = {
-	.init	= mx53_smd_timer_init,
-};
-
-MACHINE_START(MX53_SMD, "Freescale MX53 SMD Board")
-	.map_io = mx53_map_io,
-	.init_early = imx53_init_early,
-	.init_irq = mx53_init_irq,
-	.handle_irq = imx53_handle_irq,
-	.timer = &mx53_smd_timer,
-	.init_machine = mx53_smd_board_init,
-	.init_late	= imx53_init_late,
-	.restart	= mxc_restart,
-MACHINE_END
-- 
1.7.5.4
