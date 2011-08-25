From: zintis.petersons@abcsolutions.lv (Zintis Petersons)
Date: Thu, 25 Aug 2011 11:59:06 +0300
Subject: [PATCH 1/3] add Freecom Datatank Gateway support
Message-ID: <009d01cc6305$41354c20$c39fe460$@abcsolutions.lv>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add support for the Freecom Datatank Gateway board.

Signed-off-by: Zintis Petersons <Zintis.Petersons@abcsolutions.lv>
---
diff -ruN a/arch/arm/mach-orion5x/dt2-setup.c
b/arch/arm/mach-orion5x/dt2-setup.c
--- a/arch/arm/mach-orion5x/dt2-setup.c	1970-01-01 03:00:00.000000000 +0300
+++ b/arch/arm/mach-orion5x/dt2-setup.c	2011-08-25 11:31:59.000000000 +0300
@@ -0,0 +1,342 @@
+/*
+ * arch/arm/mach-orion5x/dt2-setup.c
+ *
+ * Freecom DataTank Gateway Setup
+ *
+ * Copyright (C) 2009 Zintis Petersons <Zintis.Petersons@abcsolutions.lv>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/pci.h>
+#include <linux/irq.h>
+#include <linux/mtd/physmap.h>
+#include <linux/mv643xx_eth.h>
+#include <linux/ethtool.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <net/dsa.h>
+#include <linux/ata_platform.h>
+#include <linux/i2c.h>
+#include <linux/reboot.h>
+#include <linux/interrupt.h>
+#include <asm/mach-types.h>
+#include <asm/gpio.h>
+#include <asm/leds.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/pci.h>
+#include <mach/orion5x.h>
+#include <asm/setup.h>
+#include <mach/dt2-common.h>
+#include "common.h"
+#include "mpp.h"
+
+/**************************************************************************
***
+ * DT2 local
+
****************************************************************************
/
+
+struct DT2_EEPROM_STRUCT dt2_eeprom;
+
+/**************************************************************************
***
+ * DT2 Info
+
****************************************************************************
/
+
+#define DT2_NOR_BOOT_BASE	0xf4000000
+#define DT2_NOR_BOOT_SIZE	SZ_512K
+
+/*
+ * PCI
+ */
+
+#define DT2_PCI_SLOT0_OFFS	7
+#define DT2_PCI_SLOT0_IRQ_A_PIN	3
+#define DT2_PCI_SLOT0_IRQ_B_PIN	2
+
+/**************************************************************************
***
+ * 512K NOR Flash on Device bus Boot CS
+
****************************************************************************
/
+
+static struct mtd_partition dt2_partitions[] = {
+	{
+		.name		= "U-Boot Config",
+		.offset		= 0x00000000,
+		/* only the first 4kB is used */
+		.size		= SZ_4K,
+	},
+};
+
+static struct physmap_flash_data dt2_nor_flash_data = {
+	.width		= 1,		/* 8 bit bus width */
+	.parts		= dt2_partitions,
+	.nr_parts	= ARRAY_SIZE(dt2_partitions)
+};
+
+static struct resource dt2_nor_flash_resource = {
+	.flags		= IORESOURCE_MEM,
+	.start		= DT2_NOR_BOOT_BASE,
+	.end		= DT2_NOR_BOOT_BASE + DT2_NOR_BOOT_SIZE - 1,
+};
+
+static struct platform_device dt2_nor_flash = {
+	.name		= "physmap-flash",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &dt2_nor_flash_data,
+	},
+	.num_resources	= 1,
+	.resource	= &dt2_nor_flash_resource,
+};
+
+/**************************************************************************
***
+ * LEDS
+
****************************************************************************
/
+static struct platform_device dt2_leds = {
+	.name		= "dt2-led",
+	.id		= -1,
+};
+
+/**************************************************************************
***
+ * PCI
+
****************************************************************************
/
+void __init dt2_pci_preinit(void)
+{
+	int pin, irq;
+
+	/*
+	 * Configure PCI GPIO IRQ pins
+	 */
+	pin = DT2_PCI_SLOT0_IRQ_A_PIN;
+	if (gpio_request(pin, "PCI IntA") == 0) {
+		if (gpio_direction_input(pin) == 0) {
+			irq = gpio_to_irq(pin);
+			irq_set_irq_type(irq, IRQ_TYPE_LEVEL_LOW);
+		} else {
+			printk(KERN_ERR "%s(%d): failed to "
+					"irq_set_irq_type pin %d\n",
__FUNCTION__, __LINE__, pin);
+			gpio_free(pin);
+		}
+	} else {
+		printk(KERN_ERR "%s(%d): failed to gpio_request %d\n",
__FUNCTION__, __LINE__, pin);
+	}
+
+	pin = DT2_PCI_SLOT0_IRQ_B_PIN;
+	if (gpio_request(pin, "PCI IntB") == 0) {
+		if (gpio_direction_input(pin) == 0) {
+			irq = gpio_to_irq(pin);
+			irq_set_irq_type(irq, IRQ_TYPE_LEVEL_LOW);
+		} else {
+			printk(KERN_ERR "%s(%d): failed to "
+					"irq_set_irq_type pin %d\n",
__FUNCTION__, __LINE__, pin);
+			gpio_free(pin);
+		}
+	} else {
+		printk(KERN_ERR "%s(%d): failed to gpio_request %d\n",
__FUNCTION__, __LINE__, pin);
+	}
+}
+
+static int __init dt2_pci_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	int irq;
+
+	/*
+	 * Check for devices with hard-wired IRQs.
+	 */
+	irq = orion5x_pci_map_irq(dev, slot, pin);
+	if (irq != -1)
+		return irq;
+
+	/*
+	 * PCI IRQs are connected via GPIOs.
+	 */
+	switch (slot - DT2_PCI_SLOT0_OFFS) {
+		case 0:
+			return gpio_to_irq(DT2_PCI_SLOT0_IRQ_A_PIN);
+		case 1:
+			return gpio_to_irq(DT2_PCI_SLOT0_IRQ_B_PIN);
+		default:
+			return -1;
+	}
+}
+
+static struct hw_pci dt2_pci __initdata = {
+	.nr_controllers	= 2,
+	.preinit	= dt2_pci_preinit,
+	.swizzle	= pci_std_swizzle,
+	.setup		= orion5x_pci_sys_setup,
+	.scan		= orion5x_pci_sys_scan_bus,
+	.map_irq	= dt2_pci_map_irq,
+};
+
+static int __init dt2_pci_init(void)
+{
+	if (machine_is_dt2())
+		pci_common_init(&dt2_pci);
+
+	return 0;
+}
+
+subsys_initcall(dt2_pci_init);
+
+/**************************************************************************
***
+ * Ethernet
+
****************************************************************************
/
+
+static struct mv643xx_eth_platform_data dt2_eth_data = {
+	.phy_addr	= MV643XX_ETH_PHY_NONE,
+	.speed		= SPEED_1000,
+	.duplex		= DUPLEX_FULL,
+};
+
+static struct dsa_chip_data dt2_switch_chip_data = {
+	.port_names[0] = "wan",
+	.port_names[1] = "lan1",
+	.port_names[2] = "lan2",
+	.port_names[3] = "cpu",
+	.port_names[4] = "lan3",
+	.port_names[5] = "lan4",
+};
+
+static struct dsa_platform_data dt2_switch_plat_data = {
+	.nr_chips	= 1,
+	.chip		= &dt2_switch_chip_data,
+};
+
+static int dt2_netdev_event(struct notifier_block *this,
+				unsigned long event, void *ptr)
+{
+	struct net_device *dev = ptr;
+	struct sockaddr mac;
+
+	if (event == NETDEV_REGISTER && strcmp(dev->name,
dt2_switch_chip_data.port_names[0]) == 0) {
+		memcpy(mac.sa_data, dt2_eeprom.gw.mac_addr[1], ETH_ALEN);
+		if (is_valid_ether_addr(mac.sa_data)) {
+			mac.sa_family = dev->type;
+			dev_set_mac_address(dev, &mac);
+			msleep(2);
+			printk(KERN_INFO
+				"dt2: MAC address now set to %pM for port
wan\n", mac.sa_data);
+		}
+		else {
+			printk(KERN_ERR "dt2: No valid MAC address for port
wan\n");
+		}
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block dt2_netdev_notifier = {
+	.notifier_call = dt2_netdev_event,
+};
+
+/**************************************************************************
***
+ * RTC ISL1208 on I2C bus
+
****************************************************************************
/
+static struct i2c_board_info __initdata dt2_i2c_rtc = {
+	I2C_BOARD_INFO("isl1208", 0x6F),
+};
+
+/**************************************************************************
***
+ * Sata
+
****************************************************************************
/
+static struct mv_sata_platform_data dt2_sata_data = {
+	.n_ports	= 2,
+};
+
+/**************************************************************************
***
+ * General Setup
+
****************************************************************************
/
+static unsigned int dt2_mpp_modes[] __initdata = {
+	MPP0_GPIO,		// RTC interrupt
+	MPP1_GPIO,		// 88e6131 interrupt
+	MPP2_GPIO,		// PCI_intB
+	MPP3_GPIO,		// PCI_intA
+	MPP4_GPIO,		// reset button switch
+	MPP5_GPIO,
+	MPP6_GPIO,
+	MPP7_GPIO,
+	MPP8_GPIO,
+	MPP9_GIGE,		/* GE_RXERR */
+	MPP10_GPIO,		// usb
+	MPP11_GPIO,		// usb
+	MPP12_GIGE,		// GE_TXD[4]
+	MPP13_GIGE,		// GE_TXD[5]
+	MPP14_GIGE,		// GE_TXD[6]
+	MPP15_GIGE,		// GE_TXD[7]
+	MPP16_GIGE,		// GE_RXD[4]
+	MPP17_GIGE,		// GE_RXD[5]
+	MPP18_GIGE,		// GE_RXD[6]
+	MPP19_GIGE,		// GE_RXD[7]
+	0,
+};
+
+static void __init dt2_init(void)
+{
+	/*
+	 * Setup basic Orion functions. Need to be called early.
+	 */
+	orion5x_init();
+
+	orion5x_mpp_conf(dt2_mpp_modes);
+
+	/*
+	 * Configure peripherals.
+	 */
+	orion5x_uart0_init();
+	orion5x_ehci0_init();
+	orion5x_ehci1_init();
+	orion5x_i2c_init();
+	orion5x_sata_init(&dt2_sata_data);
+	orion5x_xor_init();
+
+	orion5x_setup_dev_boot_win(DT2_NOR_BOOT_BASE, DT2_NOR_BOOT_SIZE);
+	orion5x_setup_dev0_win(DT2_LEDS_BASE, DT2_LEDS_SIZE);
+
+	printk(KERN_INFO "dt2: Serial: %s\n",
dt2_eeprom.fc.dt2_serial_number);
+	printk(KERN_INFO "dt2: Revision: %016x\n",
dt2_eeprom.fc.dt2_revision);
+
+	register_netdevice_notifier(&dt2_netdev_notifier);
+
+	orion5x_eth_init(&dt2_eth_data);
+	memcpy(dt2_eth_data.mac_addr, dt2_eeprom.gw.mac_addr[0], 6);
+	printk(KERN_INFO "dt2: MAC address now set to %pM for port lan\n", 
+
dt2_eeprom.gw.mac_addr[0]);
+
+	orion5x_eth_switch_init(&dt2_switch_plat_data, NO_IRQ);
+
+	i2c_register_board_info(0, &dt2_i2c_rtc, 1);
+
+	platform_device_register(&dt2_nor_flash);
+	platform_device_register(&dt2_leds);
+}
+
+static int __init parse_tag_dt2_uboot(const struct tag *t)
+{
+	struct tag_mv_uboot *mv_uboot;
+		
+	// Get pointer to our block
+	mv_uboot = (struct tag_mv_uboot*)&t->u;
+			
+	//DT2 specific data
+	memcpy(&dt2_eeprom, mv_uboot->dt2_eeprom, sizeof(struct
DT2_EEPROM_STRUCT));
+
+	return 0;
+}
+__tagtable(ATAG_MV_UBOOT, parse_tag_dt2_uboot);
+
+/* Warning: Freecom uses their own custom bootloader with mach-type (=1500)
*/
+MACHINE_START(DT2, "Freecom DataTank Gateway")
+	/* Maintainer: Zintis Petersons <Zintis.Petersons@abcsolutions.lv>
*/
+	.boot_params	= 0x00000100,
+	.init_machine	= dt2_init,
+	.map_io		= orion5x_map_io,
+	.init_early	= orion5x_init_early,
+	.init_irq	= orion5x_init_irq,
+	.timer		= &orion5x_timer,
+	.fixup		= tag_fixup_mem32,
+MACHINE_END
+
diff -ruN a/arch/arm/mach-orion5x/include/mach/dt2-common.h
b/arch/arm/mach-orion5x/include/mach/dt2-common.h
--- a/arch/arm/mach-orion5x/include/mach/dt2-common.h	1970-01-01
03:00:00.000000000 +0300
+++ b/arch/arm/mach-orion5x/include/mach/dt2-common.h	2009-11-03
12:42:18.000000000 +0200
@@ -0,0 +1,100 @@
+#ifndef __INC_DT2_COMMON_H
+#define __INC_DT2_COMMON_H
+
+#define DT2_PIN_GPIO_SYNC		25
+#define DT2_PIN_GPIO_POWER		24
+#define DT2_PIN_GPIO_UNPLUG1		23
+#define DT2_PIN_GPIO_UNPLUG2		22
+#define DT2_PIN_GPIO_RESET		4
+
+#define DT2_LED_POS_SYNC		3
+#define DT2_LED_POS_POWER		2
+#define DT2_LED_POS_USB1		1
+#define DT2_LED_POS_USB2		0
+#define DT2_LED_POS_WAN			5
+#define DT2_LED_POS_WLAN		4
+#define DT2_LED_POS_SATASW		6
+#define DT2_LED_POS_SATAHW		7
+
+#define DT2_LEDS_BASE			0xfa000000
+#define DT2_LEDS_SIZE			SZ_1K
+
+#define ATAG_MV_UBOOT			0x41000403
+
+struct tag_mv_uboot {
+	u32 uboot_version;
+	u32 tclk;
+	u32 sysclk;
+	u32 isUsbHost;
+	u32 overEthAddr;
+	u8  dt2_eeprom[256];
+};
+
+#define DT2_EEPROM_ADDR 		0x50
+#define DT2_EEPROM_OFFSET		0
+#define DT2_EEPROM_LENGTH		256
+
+#define DT2_SERIAL_NUMBER_DEFAULT	"run on default\0"
+#define DT2_REVISION_DEFAULT_INIT 	0xFF
+#define DT2_CONFIG_FLAGS_DEFAULT 	0x00
+
+#define _PACKED_	__attribute__((packed))
+
+struct DT2_EEPROM_SD_CONFIG {
+	unsigned int	ram_1;
+	unsigned int	ram_2;
+	unsigned int	ram_3;
+	unsigned int	ram_4;
+	unsigned char	ram_5;
+	unsigned char	ram_6;
+	unsigned short	ram_7;
+	unsigned int 	magic_id;
+	} _PACKED_;		// 24 Bytes in total
+
+struct DT2_EEPROM_FC_CONFIG {
+	unsigned char	rtc_sts_mask;
+	unsigned char	rtc_sts_init;
+	unsigned char	rtc_int_mask;
+	unsigned char	rtc_int_init;
+	unsigned char	rtc_atrim_init;
+	unsigned char	rtc_dtrim_init;
+	unsigned char	dummy1;
+	unsigned char	dummy2;
+	unsigned char	dt2_config_flags;	/* 0x80 to load rtc_values
to RTC */
+	unsigned char	dt2_revision;		/* upper nibble is HW, lower
nibble is FW */
+	unsigned char	dt2_serial_number[16];	/* Serial number of DT-2 */
+	} _PACKED_;		// 26 Bytes in total
+
+#define CFG_LOAD_RTC_VALUES 	0x80
+
+struct DT2_EEPROM_GW_CONFIG {
+	unsigned int	dummy1;
+	unsigned int	dummy2;
+	unsigned int	dummy3;
+	unsigned char	dummy4;
+	unsigned char	tos_video_val1;
+	unsigned char	tos_video_val2;
+	unsigned char	tos_voip_val;
+	unsigned char	qos_igmp_cfg;
+	unsigned char	num_of_ifs;
+	unsigned short	vlan_ports_if[3];
+	unsigned char	mac_addr[3][6];
+	} _PACKED_;		// 42 Bytes in total
+
+#define _SIZE_OF_ALL_STRUCTS_ (sizeof(struct DT2_EEPROM_SD_CONFIG) +
sizeof(struct DT2_EEPROM_FC_CONFIG) +  sizeof(struct DT2_EEPROM_GW_CONFIG))
+
+// MV = EEPROM - SD - FC - GW - CRC
+struct DT2_EEPROM_MV_CONFIG {
+	unsigned int reg_addr[(DT2_EEPROM_LENGTH - _SIZE_OF_ALL_STRUCTS_ -
sizeof(unsigned int)) / (sizeof(unsigned int) * 2)];
+	unsigned int reg_data[(DT2_EEPROM_LENGTH - _SIZE_OF_ALL_STRUCTS_ -
sizeof(unsigned int)) / (sizeof(unsigned int) * 2)];
+ 	} _PACKED_;
+
+struct DT2_EEPROM_STRUCT {
+	struct DT2_EEPROM_MV_CONFIG mv;
+	struct DT2_EEPROM_SD_CONFIG sd;
+	struct DT2_EEPROM_FC_CONFIG fc;
+	struct DT2_EEPROM_GW_CONFIG gw;
+	unsigned int	crc;
+	} _PACKED_;
+
+#endif
diff -ruN a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
--- a/arch/arm/mach-orion5x/Kconfig	2011-08-17 20:57:16.000000000 +0300
+++ b/arch/arm/mach-orion5x/Kconfig	2011-08-25 11:31:58.000000000 +0300
@@ -16,6 +16,13 @@
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell Orion-NAS (88F5182) RD2
 
+config MACH_DT2
+	bool "Freecom DataTank Gateway"
+	select I2C_BOARDINFO
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Freecom DataTank Gateway
+
 config MACH_KUROBOX_PRO
 	bool "KuroBox Pro"
 	select I2C_BOARDINFO
diff -ruN a/arch/arm/mach-orion5x/Makefile b/arch/arm/mach-orion5x/Makefile
--- a/arch/arm/mach-orion5x/Makefile	2011-08-17 20:57:16.000000000 +0300
+++ b/arch/arm/mach-orion5x/Makefile	2011-08-25 11:31:57.000000000 +0300
@@ -1,6 +1,7 @@
 obj-y				+= common.o addr-map.o pci.o irq.o mpp.o
 obj-$(CONFIG_MACH_DB88F5281)	+= db88f5281-setup.o
 obj-$(CONFIG_MACH_RD88F5182)	+= rd88f5182-setup.o
+obj-$(CONFIG_MACH_DT2)		+= dt2-setup.o
 obj-$(CONFIG_MACH_KUROBOX_PRO)	+= kurobox_pro-setup.o
 obj-$(CONFIG_MACH_TERASTATION_PRO2)	+= terastation_pro2-setup.o
 obj-$(CONFIG_MACH_LINKSTATION_PRO) += kurobox_pro-setup.o
