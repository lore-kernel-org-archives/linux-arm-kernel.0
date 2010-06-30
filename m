From: javier.martin@vista-silicon.com (Javier Martin)
Date: Wed, 30 Jun 2010 17:44:21 +0200
Subject: [PATCH] Add support for Vista Silicon i.MX27 Visstrim_M10 board.
Message-ID: <1277912661-24065-1-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 arch/arm/mach-mx2/Kconfig                          |    8 +
 arch/arm/mach-mx2/Makefile                         |    1 +
 arch/arm/mach-mx2/mach-imx27_visstrim_m10.c        |  279 ++++++++++++++++++++
 .../include/mach/board-imx27_visstrim_m10.h        |   24 ++
 4 files changed, 312 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mx2/mach-imx27_visstrim_m10.c
 create mode 100644 arch/arm/plat-mxc/include/mach/board-imx27_visstrim_m10.h

diff --git a/arch/arm/mach-mx2/Kconfig b/arch/arm/mach-mx2/Kconfig
index 742fd4e..432eb78 100644
--- a/arch/arm/mach-mx2/Kconfig
+++ b/arch/arm/mach-mx2/Kconfig
@@ -91,6 +91,14 @@ config MACH_MX27_3DS
 	  Include support for MX27PDK platform. This includes specific
 	  configurations for the board and its peripherals.
 
+config MACH_IMX27_VISSTRIM_M10
+	bool "Vista Silicon i.MX27 Visstrim_m10"
+	depends on MACH_MX27
+	help
+	  Include support for Visstrim_m10 platform and its different variants.
+	  This includes specific configurations for the board and its
+	  peripherals.
+
 config MACH_IMX27LITE
 	bool "LogicPD MX27 LITEKIT platform"
 	depends on MACH_MX27
diff --git a/arch/arm/mach-mx2/Makefile b/arch/arm/mach-mx2/Makefile
index e3254fa..fbc54a9 100644
--- a/arch/arm/mach-mx2/Makefile
+++ b/arch/arm/mach-mx2/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_MACH_PCM038) += mach-pcm038.o
 obj-$(CONFIG_MACH_PCM970_BASEBOARD) += pcm970-baseboard.o
 obj-$(CONFIG_MACH_MX27_3DS) += mach-mx27_3ds.o
 obj-$(CONFIG_MACH_IMX27LITE) += mach-imx27lite.o
+obj-$(CONFIG_MACH_IMX27_VISSTRIM_M10) += mach-imx27_visstrim_m10.o
 obj-$(CONFIG_MACH_CPUIMX27) += mach-cpuimx27.o
 obj-$(CONFIG_MACH_EUKREA_MBIMX27_BASEBOARD) += eukrea_mbimx27-baseboard.o
 obj-$(CONFIG_MACH_PCA100) += mach-pca100.o
diff --git a/arch/arm/mach-mx2/mach-imx27_visstrim_m10.c b/arch/arm/mach-mx2/mach-imx27_visstrim_m10.c
new file mode 100644
index 0000000..1acd47a
--- /dev/null
+++ b/arch/arm/mach-mx2/mach-imx27_visstrim_m10.c
@@ -0,0 +1,279 @@
+/*
+ * mach-imx27_visstrim_m10.c
+ *
+ * Copyright 2010 Vista Silicon S.L.
+ *		Javier Martin <javier.martin@vista-silicon.com>
+ *
+ * Based on mach-pcm038.c, mach-pca100.c, mach-mx27ads.c and others.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA  02111-1307  USA
+ */
+
+#include <linux/platform_device.h>
+#include <linux/mtd/physmap.h>
+#include <mach/common.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+#include <mach/gpio.h>
+#include <mach/mmc.h>
+#include <mach/imx-uart.h>
+#include <mach/iomux.h>
+#include <mach/board-imx27_visstrim_m10.h>
+#include <mach/mxc_ehci.h>
+#include <mach/i2c.h>
+#include <linux/i2c.h>
+#include <linux/i2c/pca953x.h>
+#include <linux/gpio_keys.h>
+#include <linux/input.h>
+#include "devices.h"
+
+static int visstrim_m10_pins[] = {
+	/* UART1 (console) */
+	PE12_PF_UART1_TXD,
+	PE13_PF_UART1_RXD,
+	PE14_PF_UART1_CTS,
+	PE15_PF_UART1_RTS,
+	/* FEC */
+	PD0_AIN_FEC_TXD0,
+	PD1_AIN_FEC_TXD1,
+	PD2_AIN_FEC_TXD2,
+	PD3_AIN_FEC_TXD3,
+	PD4_AOUT_FEC_RX_ER,
+	PD5_AOUT_FEC_RXD1,
+	PD6_AOUT_FEC_RXD2,
+	PD7_AOUT_FEC_RXD3,
+	PD8_AF_FEC_MDIO,
+	PD9_AIN_FEC_MDC,
+	PD10_AOUT_FEC_CRS,
+	PD11_AOUT_FEC_TX_CLK,
+	PD12_AOUT_FEC_RXD0,
+	PD13_AOUT_FEC_RX_DV,
+	PD14_AOUT_FEC_RX_CLK,
+	PD15_AOUT_FEC_COL,
+	PD16_AIN_FEC_TX_ER,
+	PF23_AIN_FEC_TX_EN,
+	/* SDHC1 */
+	PE18_PF_SD1_D0,
+	PE19_PF_SD1_D1,
+	PE20_PF_SD1_D2,
+	PE21_PF_SD1_D3,
+	PE22_PF_SD1_CMD,
+	PE23_PF_SD1_CLK,
+	/* I2C1 */
+	PD17_PF_I2C_DATA,
+	PD18_PF_I2C_CLK,
+	/* USB OTG */
+	OTG_PHY_CS_GPIO | GPIO_GPIO | GPIO_OUT,
+	PC9_PF_USBOTG_DATA0,
+	PC11_PF_USBOTG_DATA1,
+	PC10_PF_USBOTG_DATA2,
+	PC13_PF_USBOTG_DATA3,
+	PC12_PF_USBOTG_DATA4,
+	PC7_PF_USBOTG_DATA5,
+	PC8_PF_USBOTG_DATA6,
+	PE25_PF_USBOTG_DATA7,
+	PE24_PF_USBOTG_CLK,
+	PE2_PF_USBOTG_DIR,
+	PE0_PF_USBOTG_NXT,
+	PE1_PF_USBOTG_STP,
+	PB23_PF_USB_PWR,
+	PB24_PF_USB_OC,
+};
+
+/* GPIOs used as events for applications */
+static struct gpio_keys_button visstrim_gpio_keys[] = {
+	{
+		.type	= EV_KEY,
+		.code	= KEY_RESTART,
+		.gpio	= (GPIO_PORTC + 15),
+		.desc	= "Default config",
+		.active_low = 0,
+		.wakeup = 1,
+	},
+	{
+		.type	= EV_KEY,
+		.code	= KEY_RECORD,
+		.gpio	= (GPIO_PORTF + 14),
+		.desc	= "Record",
+		.active_low = 0,
+		.wakeup = 1,
+	},
+	{
+		.type   = EV_KEY,
+		.code   = KEY_STOP,
+		.gpio   = (GPIO_PORTF + 13),
+		.desc   = "Stop",
+		.active_low = 0,
+		.wakeup = 1,
+	}
+};
+
+static struct gpio_keys_platform_data visstrim_gpio_keys_platform_data = {
+	.buttons	= visstrim_gpio_keys,
+	.nbuttons	= ARRAY_SIZE(visstrim_gpio_keys),
+};
+
+static struct platform_device visstrim_gpio_keys_device = {
+	.name	= "gpio-keys",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &visstrim_gpio_keys_platform_data,
+	},
+};
+
+/* Visstrim_SM10 has a microSD slot connected to sdhc2*/
+static int visstrim_m10_sdhc1_init(struct device *dev,
+		irq_handler_t detect_irq, void *data)
+{
+	int ret;
+
+	ret = request_irq(IRQ_GPIOB(25), detect_irq, IRQF_TRIGGER_FALLING,
+				"mmc-detect", data);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void visstrim_m10_sdhc1_exit(struct device *dev, void *data)
+{
+	free_irq(IRQ_GPIOB(25), data);
+}
+
+static struct imxmmc_platform_data visstrim_m10_sdhc_pdata = {
+	.init = visstrim_m10_sdhc1_init,
+	.exit = visstrim_m10_sdhc1_exit,
+};
+
+/* Visstrim_SM10 NOR flash */
+static struct physmap_flash_data visstrim_m10_flash_data = {
+	.width = 2,
+};
+
+static struct resource visstrim_m10_flash_resource = {
+	.start = 0xc0000000,
+	.end = 0xc0000000 + 0x04000000 - 1,
+	.flags = IORESOURCE_MEM,
+
+};
+
+static struct platform_device visstrim_m10_nor_mtd_device = {
+	.name = "physmap-flash",
+	.id = 0,
+	.dev = {
+		.platform_data = &visstrim_m10_flash_data,
+	},
+	.num_resources = 1,
+	.resource = &visstrim_m10_flash_resource,
+};
+
+static struct platform_device *platform_devices[] __initdata = {
+	&visstrim_m10_nor_mtd_device,
+	&mxc_fec_device,
+};
+
+/* Visstrim_M10 uses UART0 as console */
+static struct imxuart_platform_data uart_pdata[] = {
+	{
+		.flags = IMXUART_HAVE_RTSCTS,
+	},
+};
+
+/* Visstrim_M10 has several devices attached to I2C1 */
+static struct imxi2c_platform_data visstrim_m10_i2c_1_data = {
+	.bitrate = 100000,
+};
+
+static int visstrim_m10_pca9555_setup(struct i2c_client *client,
+				unsigned gpio_base, unsigned ngpio,
+				void *context)
+{
+	int i;
+
+	for (i = 0; i < ngpio; i++) {
+		gpio_request(gpio_base + i, "Visstrim_m10 GPIO Exp");
+		gpio_export(gpio_base + i, 1);
+	}
+	return 0;
+}
+
+static struct pca953x_platform_data visstrim_m10_pca9555_pdata = {
+	.gpio_base = 240, /* After MX27 internal GPIOs */
+	.invert = 0,
+	.setup = visstrim_m10_pca9555_setup,
+};
+
+static struct i2c_board_info visstrim_m10_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("pca9555", 0x20),
+		.platform_data = &visstrim_m10_pca9555_pdata,
+	},
+};
+
+/* USB OTG */
+static int otg_phy_init(struct platform_device *pdev)
+{
+	gpio_set_value(OTG_PHY_CS_GPIO, 0);
+	return 0;
+}
+
+static struct mxc_usbh_platform_data visstrim_m10_usbotg_pdata = {
+	.init = otg_phy_init,
+	.portsc	= MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
+	.flags	= MXC_EHCI_POWER_PINS_ENABLED,
+};
+
+static void __init visstrim_m10_board_init(void)
+{
+	int ret;
+
+	ret = mxc_gpio_setup_multiple_pins(visstrim_m10_pins,
+			ARRAY_SIZE(visstrim_m10_pins), "VISSTRIM_M10");
+	if (ret)
+		printk(KERN_ERR "visstrim_m10: Failed tu setup pins (%d)\n",
+				ret);
+
+	mxc_register_device(&mxc_uart_device0, &uart_pdata[0]);
+
+	i2c_register_board_info(0, visstrim_m10_i2c_devices,
+				ARRAY_SIZE(visstrim_m10_i2c_devices));
+
+	mxc_register_device(&mxc_i2c_device0, &visstrim_m10_i2c_1_data);
+	mxc_register_device(&mxc_sdhc_device0, &visstrim_m10_sdhc_pdata);
+	mxc_register_device(&mxc_otg_host, &visstrim_m10_usbotg_pdata);
+	platform_device_register(&visstrim_gpio_keys_device);
+	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+}
+
+static void __init visstrim_m10_timer_init(void)
+{
+	mx27_clocks_init((unsigned long)25000000);
+}
+
+static struct sys_timer visstrim_m10_timer = {
+	.init	= visstrim_m10_timer_init,
+};
+
+MACHINE_START(IMX27_VISSTRIM_M10, "Vista Silicon Visstrim_M10")
+	.phys_io        = MX27_AIPI_BASE_ADDR,
+	.io_pg_offst    = ((MX27_AIPI_BASE_ADDR_VIRT) >> 18) & 0xfffc,
+	.boot_params    = MX27_PHYS_OFFSET + 0x100,
+	.map_io         = mx27_map_io,
+	.init_irq       = mx27_init_irq,
+	.init_machine   = visstrim_m10_board_init,
+	.timer          = &visstrim_m10_timer,
+MACHINE_END
diff --git a/arch/arm/plat-mxc/include/mach/board-imx27_visstrim_m10.h b/arch/arm/plat-mxc/include/mach/board-imx27_visstrim_m10.h
new file mode 100644
index 0000000..9ef1531
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/board-imx27_visstrim_m10.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2009 Javier Martin - javier.martin at vista-silicon.com
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301, USA.
+ */
+
+#ifndef __ASM_ARCH_MXC_BOARD_IMX27_VISSTRIM_M10_H__
+#define __ASM_ARCH_MXC_BOARD_IMX27_VISSTRIM_M10_H__
+
+	#define OTG_PHY_CS_GPIO (GPIO_PORTF + 17)
+
+#endif		/* __ASM_ARCH_MXC_BOARD_IMX27_VISSTRIM_M10_H__ */
-- 
1.7.0.4
