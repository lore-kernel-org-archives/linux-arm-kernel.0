From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 10 Dec 2010 16:28:25 +0000
Subject: [PATCH v3 14/14] picoxcell: add support for the PC7302 development
	board
In-Reply-To: <1291998505-25891-1-git-send-email-jamie@jamieiles.com>
References: <1291998505-25891-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1291998505-25891-15-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PC7302 development board is capable of taking both PC3X2 and PC3X3
devices and features NOR flash, NAND flash, SPI NOR flash a serial
console, 100Mb Ethernet and a number of picoArray peripherals.

This patch provides initial support for running on the PC7302 board.

v2:
	- multiplex the NAND CLE pin by pad name.
	- convert to __raw_ io accessors.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/configs/picoxcell_defconfig   |  103 ++++++++++++++++
 arch/arm/mach-picoxcell/Kconfig        |    9 ++
 arch/arm/mach-picoxcell/Makefile       |    1 +
 arch/arm/mach-picoxcell/board_pc7302.c |  206 ++++++++++++++++++++++++++++++++
 4 files changed, 319 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/configs/picoxcell_defconfig
 create mode 100644 arch/arm/mach-picoxcell/board_pc7302.c

diff --git a/arch/arm/configs/picoxcell_defconfig b/arch/arm/configs/picoxcell_defconfig
new file mode 100644
index 0000000..b10c669
--- /dev/null
+++ b/arch/arm/configs/picoxcell_defconfig
@@ -0,0 +1,103 @@
+CONFIG_EXPERIMENTAL=y
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_SYSVIPC=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_RELAY=y
+CONFIG_EMBEDDED=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_KALLSYMS_EXTRA_PASS=y
+CONFIG_PROFILING=y
+CONFIG_OPROFILE=y
+CONFIG_KPROBES=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_MODULE_SRCVERSION_ALL=y
+# CONFIG_LBDAF is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+CONFIG_ARCH_PICOXCELL=y
+CONFIG_CPU_32v6K=y
+CONFIG_ARM_ERRATA_411920=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
+CONFIG_AEABI=y
+CONFIG_UACCESS_WITH_MEMCPY=y
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_GOV_USERSPACE=y
+CONFIG_FPE_NWFPE=y
+CONFIG_PM=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+# CONFIG_IPV6 is not set
+# CONFIG_WIRELESS is not set
+CONFIG_UEVENT_HELPER_PATH="/sbin/mdev"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_MTD=y
+CONFIG_MTD_PARTITIONS=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_JEDECPROBE=y
+CONFIG_MTD_CFI_ADV_OPTIONS=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_GPIO=y
+CONFIG_MTD_UBI=y
+# CONFIG_BLK_DEV is not set
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=32
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_HW_RANDOM is not set
+CONFIG_GPIO_SYSFS=y
+# CONFIG_HWMON is not set
+# CONFIG_MFD_SUPPORT is not set
+# CONFIG_HID_SUPPORT is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_DNOTIFY is not set
+CONFIG_TMPFS=y
+CONFIG_CONFIGFS_FS=y
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_SUMMARY=y
+CONFIG_UBIFS_FS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+CONFIG_ROOT_NFS=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_STRIP_ASM_SYMS=y
+CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_DETECT_HUNG_TASK=y
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_DEBUG_PREEMPT is not set
+# CONFIG_BKL is not set
+CONFIG_DEBUG_INFO=y
+# CONFIG_RCU_CPU_STALL_DETECTOR is not set
+# CONFIG_FTRACE is not set
+CONFIG_DEBUG_USER=y
+CONFIG_DEBUG_ERRORS=y
+CONFIG_DEBUG_LL=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_CRYPTO_MANAGER=y
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
+# CONFIG_CRYPTO_HW is not set
+CONFIG_CRC_CCITT=y
+CONFIG_LIBCRC32C=y
diff --git a/arch/arm/mach-picoxcell/Kconfig b/arch/arm/mach-picoxcell/Kconfig
index a0b197c..8b38410 100644
--- a/arch/arm/mach-picoxcell/Kconfig
+++ b/arch/arm/mach-picoxcell/Kconfig
@@ -16,6 +16,15 @@ config PICOXCELL_PC3X3
 	  Include support for picoChip PC3x3 family of devices. This includes
 	  PC313, PC323 and PC333.
 
+config BOARD_PC7302
+	bool "Support PC7302 Board"
+	depends on PICOXCELL_PC3X2 || PICOXCELL_PC3X3
+	default y
+	help
+          Include support for the picoChip PC7302 platform. This platform is
+	  can take any of the PC3X2 or PC3X3 devices and includes SPI NOR
+	  flash, parallel NOR flash and NAND flash.
+
 config PC3X3_STOP_WDT_IN_SUSPEND
 	bool "Stop WDT in PM suspend"
 	depends on PICOCHIP_PC3X3
diff --git a/arch/arm/mach-picoxcell/Makefile b/arch/arm/mach-picoxcell/Makefile
index 6f2a5b8..06f5f78 100644
--- a/arch/arm/mach-picoxcell/Makefile
+++ b/arch/arm/mach-picoxcell/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_PICOXCELL_PC3X2)	+= pc3x2.o
 obj-$(CONFIG_PICOXCELL_PC3X3)	+= pc3x3.o
 obj-$(CONFIG_PICOXCELL_SRAM)	+= sram.o
+obj-$(CONFIG_BOARD_PC7302)	+= board_pc7302.o
diff --git a/arch/arm/mach-picoxcell/board_pc7302.c b/arch/arm/mach-picoxcell/board_pc7302.c
new file mode 100644
index 0000000..7beebad
--- /dev/null
+++ b/arch/arm/mach-picoxcell/board_pc7302.c
@@ -0,0 +1,206 @@
+/*
+ * linux/arch/arm/mach-picoxcell/board_pc7302.c
+ *
+ * Copyright (c) 2010 Picochip Ltd., Jamie Iles
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * All enquiries to support at picochip.com
+ */
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/nand-gpio.h>
+#include <linux/mtd/physmap.h>
+#include <linux/spi/flash.h>
+
+#include <mach/hardware.h>
+#include <asm/leds.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+#include "mux.h"
+#include "picoxcell_core.h"
+
+static long pc7302_panic_blink(int state)
+{
+	__raw_writel(state ? 0xFF : 0, IO_ADDRESS(PICOXCELL_GPIO_BASE +
+					    GPIO_SW_PORT_C_DR_REG_OFFSET));
+	return 0;
+}
+
+static void pc7302_panic_init(void)
+{
+	/*
+	 * We have a BOOT_ERROR pin on PC7302. Reuse that for signalling when
+	 * the kernel panics. There is only 1 bit wired up to port C but it
+	 * won't hurt to configure all of them.
+	 */
+	__raw_writel(0xF, IO_ADDRESS(PICOXCELL_GPIO_BASE +
+			       GPIO_SW_PORT_C_DDR_REG_OFFSET));
+	__raw_writel(0x0, IO_ADDRESS(PICOXCELL_GPIO_BASE +
+			       GPIO_SW_PORT_C_CTL_REG_OFFSET));
+
+	panic_blink = pc7302_panic_blink;
+}
+
+static struct mtd_partition pc7302_nor_partitions[] = {
+	{
+		.name		= "Boot",
+		.size		= SZ_128K,
+		.offset		= 0,
+	},
+	{
+		.name		= "Boot Environment",
+		.size		= SZ_128K,
+		.offset		= MTDPART_OFS_APPEND,
+	},
+	{
+		.name		= "Kernel",
+		.size		= SZ_4M,
+		.offset		= MTDPART_OFS_APPEND,
+	},
+	{
+		.name		= "Application",
+		.size		= MTDPART_SIZ_FULL,
+		.offset		= MTDPART_OFS_APPEND,
+	},
+};
+
+static struct physmap_flash_data pc7302_nor_flash_data = {
+	.width		= 1,
+	.parts		= pc7302_nor_partitions,
+	.nr_parts	= ARRAY_SIZE(pc7302_nor_partitions)
+};
+
+static struct resource pc7302_nor_resource = {
+	.start	= PICOXCELL_FLASH_BASE,
+	.end	= PICOXCELL_FLASH_BASE + SZ_128M - 1,
+	.flags	= IORESOURCE_MEM,
+};
+
+static struct platform_device pc7302_nor = {
+	.name		    = "physmap-flash",
+	.id		    = -1,
+	.dev.platform_data  = &pc7302_nor_flash_data,
+	.resource	    = &pc7302_nor_resource,
+	.num_resources	    = 1,
+};
+
+static void __init pc7302_init_nor(void)
+{
+	platform_device_register(&pc7302_nor);
+}
+
+static struct resource pc7302_nand_resource = {
+	.start = EBI_CS2_BASE,
+	.end   = EBI_CS2_BASE + 2 * SZ_1K,
+	.flags = IORESOURCE_MEM,
+};
+
+static struct mtd_partition pc7302_nand_parts[] = {
+	{
+		.name	= "Boot",
+		.size	= 4 * SZ_128K,
+		.offset	= 0,
+	},
+	{
+		.name	= "Redundant Boot",
+		.size	= 4 * SZ_128K,
+		.offset	= MTDPART_OFS_APPEND,
+	},
+	{
+		.name	= "Boot Environment",
+		.size	= SZ_128K,
+		.offset	= MTDPART_OFS_APPEND,
+	},
+	{
+		.name	= "Redundant Boot Environment",
+		.size	= SZ_128K,
+		.offset	= MTDPART_OFS_APPEND,
+	},
+	{
+		.name	= "Kernel",
+		.size	= 8 * SZ_1M,
+		.offset	= (12 * SZ_128K),
+	},
+	{
+		.name	= "File System",
+		.size	= MTDPART_SIZ_FULL,
+		.offset	= MTDPART_OFS_APPEND,
+	},
+};
+
+static struct gpio_nand_platdata pc7302_nand_platdata = {
+	.gpio_rdy   = PC3X2_GPIO_PIN_ARM_1,
+	.gpio_nce   = PC3X2_GPIO_PIN_ARM_2,
+	.gpio_ale   = PC3X2_GPIO_PIN_ARM_3,
+	.gpio_cle   = PC3X2_GPIO_PIN_ARM_4,
+	.gpio_nwp   = -1,
+	.parts	    = pc7302_nand_parts,
+	.num_parts  = ARRAY_SIZE(pc7302_nand_parts),
+};
+
+static struct platform_device pc7302_nand = {
+	.name		    = "gpio-nand",
+	.num_resources	    = 1,
+	.resource	    = &pc7302_nand_resource,
+	.id		    = -1,
+	.dev.platform_data  = &pc7302_nand_platdata,
+};
+
+static void __init pc7302_init_nand(void)
+{
+	platform_device_register(&pc7302_nand);
+}
+
+static void __init pc7302_init(void)
+{
+	unsigned long device_id =
+		__raw_readl(IO_ADDRESS(PICOXCELL_AXI2CFG_BASE +
+				       AXI2CFG_DEVICE_ID_REG_OFFSET));
+
+	picoxcell_core_init();
+
+	/*
+	 * If we haven't booted in parallel mode, then allow ARM.4 GPIO pin to
+	 * be used as GPIO to drive the NAND. We can't do this by GPIO number
+	 * as ARM GPIO 4 can go to two different pads. Specify the pad by
+	 * name.
+	 */
+	if (picoxcell_has_feature(PICOXCELL_FEATURE_SW_NAND)) {
+		const char *pad = NULL;
+
+		switch (device_id) {
+		case 0x8003:
+		case 0x8007:
+			pad = "arm4";
+			break;
+
+		case 0x20:
+		case 0x21:
+		case 0x22:
+			pad = "ebi_addr22";
+			break;
+
+		default:
+			break;
+		}
+		WARN_ON(picoxcell_pin_set_mux_byname(pad, MUX_ARM));
+		pc7302_init_nand();
+	} else
+		pc7302_init_nor();
+
+	pc7302_panic_init();
+}
+
+MACHINE_START(PC7302, "PC7302")
+	.boot_params	= 0x00000100,
+	.map_io		= picoxcell_map_io,
+	.init_irq	= picoxcell_init_irq,
+	.timer		= &picoxcell_sys_timer,
+	.init_machine	= pc7302_init,
+MACHINE_END
-- 
1.7.2.3
