From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Wed, 18 Sep 2013 09:13:55 +0200
Subject: [PATCH] IXP4xx: Add Gateworks Cambria support.
Message-ID: <m3vc1ya9fw.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Krzysztof Ha?asa <khalasa@piap.pl>

diff --git a/arch/arm/mach-ixp4xx/Kconfig b/arch/arm/mach-ixp4xx/Kconfig
index 676e144..70c5cb9 100644
--- a/arch/arm/mach-ixp4xx/Kconfig
+++ b/arch/arm/mach-ixp4xx/Kconfig
@@ -25,6 +25,14 @@ config MACH_AVILA
 	  Avila Network Platform. For more information on this platform,
 	  see <file:Documentation/arm/IXP4xx>.
 
+config MACH_CAMBRIA
+	bool "Cambria"
+	select PCI
+	help
+	  Say 'Y' here if you want your kernel to support the Gateworks
+	  Cambria GW2350 board. For more information on this platform,
+	  see <file:Documentation/arm/IXP4xx>.
+
 config MACH_LOFT
     bool "Loft"
     depends on MACH_AVILA
@@ -158,7 +166,7 @@ config CPU_IXP46X
 
 config CPU_IXP43X
 	bool
-	depends on MACH_KIXRP435
+	depends on MACH_KIXRP435 || MACH_CAMBRIA
 	default y
 
 config MACH_GTWX5715
diff --git a/arch/arm/mach-ixp4xx/Makefile b/arch/arm/mach-ixp4xx/Makefile
index eded94c..a7aa6a5 100644
--- a/arch/arm/mach-ixp4xx/Makefile
+++ b/arch/arm/mach-ixp4xx/Makefile
@@ -23,6 +23,7 @@ obj-y	+= common.o
 
 obj-$(CONFIG_ARCH_IXDP4XX)	+= ixdp425-setup.o
 obj-$(CONFIG_MACH_AVILA)	+= avila-setup.o
+obj-$(CONFIG_MACH_CAMBRIA)	+= cambria.o
 obj-$(CONFIG_MACH_IXDPG425)	+= coyote-setup.o
 obj-$(CONFIG_ARCH_ADI_COYOTE)	+= coyote-setup.o
 obj-$(CONFIG_MACH_GTWX5715)	+= gtwx5715-setup.o
diff --git a/arch/arm/mach-ixp4xx/cambria.c b/arch/arm/mach-ixp4xx/cambria.c
new file mode 100644
index 0000000..30ddfe0
--- /dev/null
+++ b/arch/arm/mach-ixp4xx/cambria.c
@@ -0,0 +1,245 @@
+/*
+ * Gateworks Cambria GW2350 platform support
+ * Portions based on OpenWRT.
+ */
+
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/i2c-gpio.h>
+#include <linux/i2c/at24.h>
+#include <linux/if_ether.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/leds.h>
+#include <linux/pci.h>
+#include <linux/serial_8250.h>
+#include <linux/types.h>
+#include <linux/usb/ehci_pdriver.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/flash.h>
+
+static struct platform_device cambria_flash = {
+	.name			= "IXP4XX-Flash",
+	.id			= 0,
+	.num_resources		= 1,
+	.resource		= &(struct resource) {
+		.start		= IXP4XX_EXP_BUS_BASE(0),
+		.end		= IXP4XX_EXP_BUS_BASE(0) + SZ_32M - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	.dev.platform_data	= &(struct flash_platform_data) {
+		.map_name	= "cfi_probe",
+		.width		= 2,
+	},
+};
+
+static struct platform_device cambria_i2c = {
+	.name			= "i2c-gpio",
+	.id			= 0,
+	.dev.platform_data	= &(struct i2c_gpio_platform_data) {
+		.sda_pin	= 7,
+		.scl_pin	= 6,
+	},
+};
+
+static struct eth_plat_info cambria_eth0_pdata = {
+	.phy			= 1,
+	.rxq			= 4,
+	.txreadyq		= 21,
+};
+
+static struct eth_plat_info cambria_eth1_pdata = {
+	.phy			= 2,
+	.rxq			= 2,
+	.txreadyq		= 19,
+};
+
+static struct platform_device cambria_eth0 = {
+	.name			= "ixp4xx_eth",
+	.id			= IXP4XX_ETH_NPEC,
+	.dev.platform_data	= &cambria_eth0_pdata,
+};
+
+static struct platform_device cambria_eth1 = {
+	.name			= "ixp4xx_eth",
+	.id			= IXP4XX_ETH_NPEA,
+	.dev.platform_data	= &cambria_eth1_pdata,
+};
+
+static struct platform_device cambria_uart = {
+	.name			= "serial8250",
+	.id			= PLAT8250_DEV_PLATFORM,
+	.num_resources		= 1,
+	.resource		= &(struct resource) {
+		.start		= IXP4XX_UART1_BASE_PHYS,
+		.end		= IXP4XX_UART1_BASE_PHYS + 0x0fff,
+		.flags		= IORESOURCE_MEM,
+	},
+	.dev.platform_data	= (struct plat_serial8250_port[]) {
+		{
+			.mapbase	= IXP4XX_UART1_BASE_PHYS,
+			.membase	= (char __iomem *)IXP4XX_UART1_BASE_VIRT + REG_OFFSET,
+			.irq		= IRQ_IXP4XX_UART1,
+			.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
+			.iotype		= UPIO_MEM,
+			.regshift	= 2,
+			.uartclk	= IXP4XX_UART_XTAL,
+		},
+		{ },
+	}
+};
+
+static struct platform_device cambria_leds = {
+	.name		= "leds-gpio",
+	.id		= -1,
+	.dev.platform_data = &(struct gpio_led_platform_data) {
+		.num_leds	= 1,
+		.leds		= &(struct gpio_led) {
+			.name		= "user",
+			.gpio		= 5,
+			.active_low	= 1,
+		},
+	},
+};
+
+static struct usb_ehci_pdata cambria_usb_pdata = {
+	.caps_offset	= 0x100,
+	.has_tt		= 1,
+	.big_endian_desc = 1,
+	.big_endian_mmio = 1,
+};
+
+static struct platform_device cambria_usb0 = {
+	.name		= "ehci-platform",
+	.id		= 0,
+	.resource	= (struct resource[]) {
+		{
+			.start	= IXP4XX_EHCI1_BASE_PHYS,
+			.end	= IXP4XX_EHCI1_BASE_PHYS + IXP4XX_EHCI_REGION_SIZE - 1,
+			.flags	= IORESOURCE_MEM,
+		},
+		{
+			.start	= 32,
+			.flags	= IORESOURCE_IRQ,
+		},
+	},
+	.num_resources	= 2,
+	.dev.platform_data = &cambria_usb_pdata,
+};
+
+static struct platform_device cambria_usb1 = {
+	.name		= "ehci-platform",
+	.id		= 1,
+	.resource	= (struct resource[]) {
+		{
+			.start	= IXP4XX_EHCI2_BASE_PHYS,
+			.end	= IXP4XX_EHCI2_BASE_PHYS + IXP4XX_EHCI_REGION_SIZE - 1,
+			.flags	= IORESOURCE_MEM,
+		},
+		{
+			.start	= 33,
+			.flags	= IORESOURCE_IRQ,
+		},
+	},
+	.num_resources	= 2,
+	.dev.platform_data = &cambria_usb_pdata,
+};
+
+static struct platform_device *cambria_devices[] __initdata = {
+	&cambria_flash,
+	&cambria_i2c,
+	&cambria_eth0,
+	&cambria_eth1,
+	&cambria_uart,
+	&cambria_leds,
+	&cambria_usb0,
+	&cambria_usb1,
+};
+
+static void at24_setup(struct memory_accessor *mem_acc, void *context)
+{
+	char mac_addr[ETH_ALEN];
+
+	/* Read MAC addresses */
+	if (mem_acc->read(mem_acc, mac_addr, 0x100, ETH_ALEN) == ETH_ALEN)
+		memcpy(&cambria_eth0_pdata.hwaddr, mac_addr, ETH_ALEN);
+
+	if (mem_acc->read(mem_acc, mac_addr, 0x106, ETH_ALEN) == ETH_ALEN)
+		memcpy(&cambria_eth1_pdata.hwaddr, mac_addr, ETH_ALEN);
+}
+
+static struct at24_platform_data cambria_eeprom_info = {
+	.byte_len	= 1024,
+	.page_size	= 16,
+	.flags		= AT24_FLAG_READONLY,
+	.setup		= at24_setup,
+};
+
+static struct i2c_board_info __initdata cambria_i2c_board_info[] = {
+	{
+		I2C_BOARD_INFO("ad7418", 0x28),
+	},
+	{
+		I2C_BOARD_INFO("24c08", 0x50),
+		.platform_data	= &cambria_eeprom_info,
+	},
+};
+
+static void __init cambria_init(void)
+{
+	ixp4xx_sys_init();
+	platform_add_devices(cambria_devices, ARRAY_SIZE(cambria_devices));
+	i2c_register_board_info(0, cambria_i2c_board_info,
+				ARRAY_SIZE(cambria_i2c_board_info));
+}
+
+#ifdef CONFIG_PCI
+void __init cambria_pci_preinit(void)
+{
+	irq_set_irq_type(IRQ_IXP4XX_GPIO11, IRQ_TYPE_LEVEL_LOW);
+	ixp4xx_pci_preinit();
+}
+
+static int __init cambria_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	switch (slot) {
+	case 1:
+		return IRQ_IXP4XX_GPIO11;
+	default:
+		return -1;
+	}
+}
+
+struct hw_pci cambria_pci __initdata = {
+	.nr_controllers	= 1,
+	.ops		= &ixp4xx_ops,
+	.preinit	= cambria_pci_preinit,
+	.setup		= ixp4xx_setup,
+	.map_irq	= cambria_map_irq,
+};
+
+int __init cambria_pci_init(void)
+{
+	if (machine_is_cambria())
+		pci_common_init(&cambria_pci);
+	return 0;
+}
+
+subsys_initcall(cambria_pci_init);
+#endif /* CONFIG_PCI */
+
+MACHINE_START(CAMBRIA, "Gateworks Cambria")
+	/* Maintainer: Krzysztof Halasa */
+	.map_io		= ixp4xx_map_io,
+	.init_early	= ixp4xx_init_early,
+	.init_irq	= ixp4xx_init_irq,
+	.init_time	= ixp4xx_timer_init,
+	.atag_offset	= 0x0100,
+	.init_machine	= cambria_init,
+#ifdef CONFIG_PCI
+	.dma_zone_size	= SZ_64M,
+#endif
+	.restart	= ixp4xx_restart,
+MACHINE_END
diff --git a/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h b/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
index c5bae9c..f6ced67 100644
--- a/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
+++ b/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
@@ -595,6 +595,13 @@
 
 #define DCMD_LENGTH	0x01fff		/* length mask (max = 8K - 1) */
 
+/*
+ * EHCI USB host registers
+ */
+#define IXP4XX_EHCI1_BASE_PHYS		0xCD000000
+#define IXP4XX_EHCI2_BASE_PHYS		0xCE000000
+#define IXP4XX_EHCI_REGION_SIZE		0x00000200
+
 /* "fuse" bits of IXP_EXP_CFG2 */
 /* All IXP4xx CPUs */
 #define IXP4XX_FEATURE_RCOMP		(1 << 0)
diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index a10297d..9ada1a7 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -261,6 +261,7 @@ halibut			MACH_HALIBUT		HALIBUT			1439
 trout			MACH_TROUT		TROUT			1440
 tct_hammer		MACH_TCT_HAMMER		TCT_HAMMER		1460
 herald			MACH_HERALD		HERALD			1461
+cambria			MACH_CAMBRIA		CAMBRIA			1468
 sim_one			MACH_SIM_ONE		SIM_ONE			1476
 jive			MACH_JIVE		JIVE			1490
 sam9_l9260		MACH_SAM9_L9260		SAM9_L9260		1501
