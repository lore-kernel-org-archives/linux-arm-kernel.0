From: yuasa@linux-mips.org (Yoichi Yuasa)
Date: Mon, 2 Nov 2009 11:37:36 +0900
Subject: [PATCH v2] Add KZM-ARM11-01 support
In-Reply-To: <20091102105219.643679b8.yuasa@linux-mips.org>
References: <20091030135343.b907e5de.yuasa@linux-mips.org>
	<20091030110841.GF11014@pengutronix.de>
	<20091030112208.GA1185@n2100.arm.linux.org.uk>
	<20091102105219.643679b8.yuasa@linux-mips.org>
Message-ID: <20091102113736.9bd7ddd1.yuasa@linux-mips.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/arm/configs/mx3_defconfig                  |  101 ++++++---
 arch/arm/mach-mx3/Kconfig                       |    8 +
 arch/arm/mach-mx3/Makefile                      |    1 +
 arch/arm/mach-mx3/kzmarm11.c                    |  268 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/board-kzmarm11.h |   39 ++++
 arch/arm/plat-mxc/include/mach/iomux-mx3.h      |    8 +
 6 files changed, 392 insertions(+), 33 deletions(-)
 create mode 100644 arch/arm/mach-mx3/kzmarm11.c
 create mode 100644 arch/arm/plat-mxc/include/mach/board-kzmarm11.h

diff --git a/arch/arm/configs/mx3_defconfig b/arch/arm/configs/mx3_defconfig
index a4f9a2a..7734cca 100644
--- a/arch/arm/configs/mx3_defconfig
+++ b/arch/arm/configs/mx3_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.31-rc4
-# Tue Jul 28 14:11:34 2009
+# Linux kernel version: 2.6.32-rc5
+# Sun Nov  1 22:56:24 2009
 #
 CONFIG_ARM=y
 CONFIG_HAVE_PWM=y
@@ -9,7 +9,6 @@ CONFIG_SYS_SUPPORTS_APM_EMULATION=y
 CONFIG_GENERIC_GPIO=y
 CONFIG_GENERIC_TIME=y
 CONFIG_GENERIC_CLOCKEVENTS=y
-CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_HAVE_LATENCYTOP_SUPPORT=y
@@ -46,11 +45,12 @@ CONFIG_SYSVIPC_SYSCTL=y
 #
 # RCU Subsystem
 #
-CONFIG_CLASSIC_RCU=y
-# CONFIG_TREE_RCU is not set
-# CONFIG_PREEMPT_RCU is not set
+CONFIG_TREE_RCU=y
+# CONFIG_TREE_PREEMPT_RCU is not set
+# CONFIG_RCU_TRACE is not set
+CONFIG_RCU_FANOUT=32
+# CONFIG_RCU_FANOUT_EXACT is not set
 # CONFIG_TREE_RCU_TRACE is not set
-# CONFIG_PREEMPT_RCU_TRACE is not set
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
@@ -87,16 +87,14 @@ CONFIG_SHMEM=y
 CONFIG_AIO=y
 
 #
-# Performance Counters
+# Kernel Performance Events And Counters
 #
 CONFIG_VM_EVENT_COUNTERS=y
-# CONFIG_STRIP_ASM_SYMS is not set
 CONFIG_COMPAT_BRK=y
 CONFIG_SLAB=y
 # CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
 # CONFIG_PROFILING is not set
-# CONFIG_MARKERS is not set
 CONFIG_HAVE_OPROFILE=y
 # CONFIG_KPROBES is not set
 CONFIG_HAVE_KPROBES=y
@@ -139,6 +137,7 @@ CONFIG_FREEZER=y
 #
 # System Type
 #
+CONFIG_MMU=y
 # CONFIG_ARCH_AAEC2000 is not set
 # CONFIG_ARCH_INTEGRATOR is not set
 # CONFIG_ARCH_REALVIEW is not set
@@ -153,6 +152,7 @@ CONFIG_ARCH_MXC=y
 # CONFIG_ARCH_STMP3XXX is not set
 # CONFIG_ARCH_NETX is not set
 # CONFIG_ARCH_H720X is not set
+# CONFIG_ARCH_NOMADIK is not set
 # CONFIG_ARCH_IOP13XX is not set
 # CONFIG_ARCH_IOP32X is not set
 # CONFIG_ARCH_IOP33X is not set
@@ -175,18 +175,22 @@ CONFIG_ARCH_MXC=y
 # CONFIG_ARCH_SA1100 is not set
 # CONFIG_ARCH_S3C2410 is not set
 # CONFIG_ARCH_S3C64XX is not set
+# CONFIG_ARCH_S5PC1XX is not set
 # CONFIG_ARCH_SHARK is not set
 # CONFIG_ARCH_LH7A40X is not set
 # CONFIG_ARCH_U300 is not set
 # CONFIG_ARCH_DAVINCI is not set
 # CONFIG_ARCH_OMAP is not set
+# CONFIG_ARCH_BCMRING is not set
 
 #
 # Freescale MXC Implementations
 #
 # CONFIG_ARCH_MX1 is not set
 # CONFIG_ARCH_MX2 is not set
+# CONFIG_ARCH_MX25 is not set
 CONFIG_ARCH_MX3=y
+# CONFIG_ARCH_MXC91231 is not set
 CONFIG_ARCH_MX31=y
 CONFIG_ARCH_MX35=y
 
@@ -205,6 +209,7 @@ CONFIG_MACH_QONG=y
 CONFIG_MACH_PCM043=y
 CONFIG_MACH_ARMADILLO5X0=y
 CONFIG_MACH_MX35_3DS=y
+CONFIG_MACH_KZM_ARM11_01=y
 CONFIG_MXC_IRQ_PRIOR=y
 CONFIG_MXC_PWM=y
 CONFIG_ARCH_HAS_RNGA=y
@@ -218,7 +223,7 @@ CONFIG_CPU_V6=y
 # CONFIG_CPU_32v6K is not set
 CONFIG_CPU_32v6=y
 CONFIG_CPU_ABRT_EV6=y
-CONFIG_CPU_PABRT_NOIFAR=y
+CONFIG_CPU_PABRT_V6=y
 CONFIG_CPU_CACHE_V6=y
 CONFIG_CPU_CACHE_VIPT=y
 CONFIG_CPU_COPY_V6=y
@@ -236,6 +241,7 @@ CONFIG_ARM_THUMB=y
 # CONFIG_CPU_BPREDICT_DISABLE is not set
 CONFIG_OUTER_CACHE=y
 CONFIG_CACHE_L2X0=y
+CONFIG_ARM_L1_CACHE_SHIFT=5
 # CONFIG_ARM_ERRATA_411920 is not set
 CONFIG_COMMON_CLKDEV=y
 
@@ -257,6 +263,8 @@ CONFIG_VMSPLIT_3G=y
 # CONFIG_VMSPLIT_2G is not set
 # CONFIG_VMSPLIT_1G is not set
 CONFIG_PAGE_OFFSET=0xC0000000
+# CONFIG_PREEMPT_NONE is not set
+# CONFIG_PREEMPT_VOLUNTARY is not set
 CONFIG_PREEMPT=y
 CONFIG_HZ=100
 CONFIG_AEABI=y
@@ -277,6 +285,7 @@ CONFIG_ZONE_DMA_FLAG=0
 CONFIG_VIRT_TO_BUS=y
 CONFIG_HAVE_MLOCK=y
 CONFIG_HAVE_MLOCKED_PAGE_BIT=y
+# CONFIG_KSM is not set
 CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
 CONFIG_ALIGNMENT_TRAP=y
 # CONFIG_UACCESS_WITH_MEMCPY is not set
@@ -326,6 +335,7 @@ CONFIG_PM_SLEEP=y
 CONFIG_SUSPEND=y
 CONFIG_SUSPEND_FREEZER=y
 # CONFIG_APM_EMULATION is not set
+# CONFIG_PM_RUNTIME is not set
 CONFIG_ARCH_SUSPEND_POSSIBLE=y
 CONFIG_NET=y
 
@@ -367,6 +377,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_NETFILTER is not set
 # CONFIG_IP_DCCP is not set
 # CONFIG_IP_SCTP is not set
+# CONFIG_RDS is not set
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
@@ -407,6 +418,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # Generic Driver Options
 #
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+# CONFIG_DEVTMPFS is not set
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=m
@@ -416,9 +428,9 @@ CONFIG_EXTRA_FIRMWARE=""
 # CONFIG_CONNECTOR is not set
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_TESTS is not set
 # CONFIG_MTD_CONCAT is not set
 CONFIG_MTD_PARTITIONS=y
-# CONFIG_MTD_TESTS is not set
 # CONFIG_MTD_REDBOOT_PARTS is not set
 CONFIG_MTD_CMDLINE_PARTS=y
 # CONFIG_MTD_AFS_PARTS is not set
@@ -587,14 +599,12 @@ CONFIG_DNET=y
 # CONFIG_B44 is not set
 # CONFIG_CS89x0 is not set
 # CONFIG_KS8842 is not set
+# CONFIG_KS8851_MLL is not set
 CONFIG_FEC=y
 # CONFIG_FEC2 is not set
 # CONFIG_NETDEV_1000 is not set
 # CONFIG_NETDEV_10000 is not set
-
-#
-# Wireless LAN
-#
+CONFIG_WLAN=y
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
 
@@ -608,6 +618,7 @@ CONFIG_FEC=y
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
 # CONFIG_ISDN is not set
+# CONFIG_PHONE is not set
 
 #
 # Input device support
@@ -630,7 +641,14 @@ CONFIG_DEVKMEM=y
 #
 # Serial drivers
 #
-# CONFIG_SERIAL_8250 is not set
+CONFIG_SERIAL_8250=m
+CONFIG_SERIAL_8250_NR_UARTS=4
+CONFIG_SERIAL_8250_RUNTIME_UARTS=4
+CONFIG_SERIAL_8250_EXTENDED=y
+# CONFIG_SERIAL_8250_MANY_PORTS is not set
+CONFIG_SERIAL_8250_SHARE_IRQ=y
+# CONFIG_SERIAL_8250_DETECT_IRQ is not set
+# CONFIG_SERIAL_8250_RSA is not set
 
 #
 # Non-8250 serial port support
@@ -649,6 +667,7 @@ CONFIG_UNIX98_PTYS=y
 # CONFIG_TCG_TPM is not set
 CONFIG_I2C=y
 CONFIG_I2C_BOARDINFO=y
+CONFIG_I2C_COMPAT=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_HELPER_AUTO=y
 
@@ -681,15 +700,17 @@ CONFIG_I2C_IMX=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_PCF8574 is not set
-# CONFIG_PCF8575 is not set
-# CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
 # CONFIG_I2C_DEBUG_CHIP is not set
 # CONFIG_SPI is not set
+
+#
+# PPS support
+#
+# CONFIG_PPS is not set
 CONFIG_ARCH_REQUIRE_GPIOLIB=y
 CONFIG_GPIOLIB=y
 # CONFIG_GPIO_SYSFS is not set
@@ -712,6 +733,10 @@ CONFIG_GPIOLIB=y
 #
 # SPI GPIO expanders:
 #
+
+#
+# AC97 GPIO expanders:
+#
 CONFIG_W1=y
 
 #
@@ -734,7 +759,6 @@ CONFIG_W1_SLAVE_THERM=y
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
 # CONFIG_THERMAL is not set
-# CONFIG_THERMAL_HWMON is not set
 # CONFIG_WATCHDOG is not set
 CONFIG_SSB_POSSIBLE=y
 
@@ -759,12 +783,24 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_MFD_TC6393XB is not set
 # CONFIG_PMIC_DA903X is not set
 # CONFIG_MFD_WM8400 is not set
+# CONFIG_MFD_WM831X is not set
 CONFIG_MFD_WM8350=y
 CONFIG_MFD_WM8350_CONFIG_MODE_0=y
 CONFIG_MFD_WM8352_CONFIG_MODE_0=y
 CONFIG_MFD_WM8350_I2C=y
 # CONFIG_MFD_PCF50633 is not set
 # CONFIG_AB3100_CORE is not set
+CONFIG_REGULATOR=y
+# CONFIG_REGULATOR_DEBUG is not set
+# CONFIG_REGULATOR_FIXED_VOLTAGE is not set
+# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
+# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
+# CONFIG_REGULATOR_BQ24022 is not set
+# CONFIG_REGULATOR_MAX1586 is not set
+CONFIG_REGULATOR_WM8350=y
+# CONFIG_REGULATOR_LP3971 is not set
+# CONFIG_REGULATOR_TPS65023 is not set
+# CONFIG_REGULATOR_TPS6507X is not set
 CONFIG_MEDIA_SUPPORT=y
 
 #
@@ -874,10 +910,12 @@ CONFIG_MMC_BLOCK_BOUNCE=y
 # MMC/SD/SDIO Host Controller Drivers
 #
 # CONFIG_MMC_SDHCI is not set
+# CONFIG_MMC_AT91 is not set
+# CONFIG_MMC_ATMELMCI is not set
 CONFIG_MMC_MXC=y
 # CONFIG_MEMSTICK is not set
-# CONFIG_ACCESSIBILITY is not set
 # CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
 CONFIG_RTC_LIB=y
 # CONFIG_RTC_CLASS is not set
 CONFIG_DMADEVICES=y
@@ -896,16 +934,11 @@ CONFIG_DMA_ENGINE=y
 # CONFIG_ASYNC_TX_DMA is not set
 # CONFIG_DMATEST is not set
 # CONFIG_AUXDISPLAY is not set
-CONFIG_REGULATOR=y
-# CONFIG_REGULATOR_DEBUG is not set
-# CONFIG_REGULATOR_FIXED_VOLTAGE is not set
-# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
-# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
-# CONFIG_REGULATOR_BQ24022 is not set
-# CONFIG_REGULATOR_MAX1586 is not set
-CONFIG_REGULATOR_WM8350=y
-# CONFIG_REGULATOR_LP3971 is not set
 # CONFIG_UIO is not set
+
+#
+# TI VLYNQ
+#
 # CONFIG_STAGING is not set
 
 #
@@ -921,6 +954,7 @@ CONFIG_REGULATOR_WM8350=y
 # CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_BTRFS_FS is not set
+# CONFIG_NILFS2_FS is not set
 CONFIG_FILE_LOCKING=y
 CONFIG_FSNOTIFY=y
 # CONFIG_DNOTIFY is not set
@@ -995,7 +1029,6 @@ CONFIG_UBIFS_FS_ZLIB=y
 # CONFIG_ROMFS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-# CONFIG_NILFS2_FS is not set
 CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
@@ -1033,6 +1066,7 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_FRAME_WARN=1024
 # CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_STRIP_ASM_SYMS is not set
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
@@ -1062,7 +1096,6 @@ CONFIG_CRYPTO=y
 #
 # Crypto core or helper
 #
-# CONFIG_CRYPTO_FIPS is not set
 CONFIG_CRYPTO_ALGAPI=y
 CONFIG_CRYPTO_ALGAPI2=y
 CONFIG_CRYPTO_AEAD2=y
@@ -1104,11 +1137,13 @@ CONFIG_CRYPTO_CBC=y
 #
 # CONFIG_CRYPTO_HMAC is not set
 # CONFIG_CRYPTO_XCBC is not set
+# CONFIG_CRYPTO_VMAC is not set
 
 #
 # Digest
 #
 # CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_GHASH is not set
 # CONFIG_CRYPTO_MD4 is not set
 CONFIG_CRYPTO_MD5=y
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 851f245..cde29df 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -100,4 +100,12 @@ config MACH_MX35_3DS
 	help
 	  Include support for MX35PDK platform. This includes specific
 	  configurations for the board and its peripherals.
+
+config MACH_KZM_ARM11_01
+	bool "Support KZM-ARM11-01(Kyoto Microcomputer)"
+	select ARCH_MX31
+	help
+	  Include support for KZM-ARM11-01. This includes specific
+	  configurations for the board and its peripherals.
+
 endif
diff --git a/arch/arm/mach-mx3/Makefile b/arch/arm/mach-mx3/Makefile
index 6b97754..5537a10 100644
--- a/arch/arm/mach-mx3/Makefile
+++ b/arch/arm/mach-mx3/Makefile
@@ -19,3 +19,4 @@ obj-$(CONFIG_MACH_QONG)		+= qong.o
 obj-$(CONFIG_MACH_PCM043)	+= pcm043.o
 obj-$(CONFIG_MACH_ARMADILLO5X0) += armadillo5x0.o
 obj-$(CONFIG_MACH_MX35_3DS)	+= mx35pdk.o
+obj-$(CONFIG_MACH_KZM_ARM11_01)	+= kzmarm11.o
diff --git a/arch/arm/mach-mx3/kzmarm11.c b/arch/arm/mach-mx3/kzmarm11.c
new file mode 100644
index 0000000..6fa99ce
--- /dev/null
+++ b/arch/arm/mach-mx3/kzmarm11.c
@@ -0,0 +1,268 @@
+/*
+ * KZM-ARM11-01 support
+ *  Copyright (C) 2009  Yoichi Yuasa <yuasa@linux-mips.org>
+ *
+ * based on code for MX31ADS,
+ *  Copyright (C) 2000 Deep Blue Solutions Ltd
+ *  Copyright (C) 2002 Shane Nay (shane at minirl.com)
+ *  Copyright 2005-2007 Freescale Semiconductor, Inc. All Rights Reserved.
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/gpio.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/serial_8250.h>
+#include <linux/smsc911x.h>
+#include <linux/types.h>
+
+#include <asm/irq.h>
+#include <asm/mach-types.h>
+#include <asm/setup.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/irq.h>
+#include <asm/mach/map.h>
+#include <asm/mach/time.h>
+
+#include <mach/board-kzmarm11.h>
+#include <mach/clock.h>
+#include <mach/common.h>
+#include <mach/imx-uart.h>
+#include <mach/iomux-mx3.h>
+#include <mach/memory.h>
+
+#include "devices.h"
+
+#if defined(CONFIG_SERIAL_8250) || defined(CONFIG_SERIAL_8250_MODULE)
+/*
+ * KZM-ARM11-01 has an external UART on FPGA
+ */
+static struct plat_serial8250_port serial_platform_data[] = {
+	{
+		.membase	= IO_ADDRESS(KZM_ARM11_16550),
+		.mapbase	= KZM_ARM11_16550,
+		.irq		= IOMUX_TO_IRQ(MX31_PIN_GPIO1_1),
+		.irqflags	= IRQ_TYPE_EDGE_RISING,
+		.uartclk	= 14745600,
+		.regshift	= 0,
+		.iotype		= UPIO_MEM,
+		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
+				  UPF_BUGGY_UART,
+	},
+	{},
+};
+
+static struct resource serial8250_resources[] = {
+	{
+		.start	= KZM_ARM11_16550,
+		.end	= KZM_ARM11_16550 + 0x10,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= IOMUX_TO_IRQ(MX31_PIN_GPIO1_1),
+		.end	= IOMUX_TO_IRQ(MX31_PIN_GPIO1_1),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device serial_device = {
+	.name		= "serial8250",
+	.id		= PLAT8250_DEV_PLATFORM,
+	.dev		= {
+				.platform_data = serial_platform_data,
+			  },
+	.num_resources	= ARRAY_SIZE(serial8250_resources),
+	.resource	= serial8250_resources,
+};
+
+static int __init kzm_init_ext_uart(void)
+{
+	u8 tmp;
+
+	/*
+	 * GPIO 1-1: external UART interrupt line
+	 */
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_GPIO1_1, IOMUX_CONFIG_GPIO));
+	gpio_request(IOMUX_TO_GPIO(MX31_PIN_GPIO1_1), "ext-uart-int");
+	gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_GPIO1_1));
+
+	/*
+	 * Unmask UART interrupt
+	 */
+	tmp = __raw_readb(IO_ADDRESS(KZM_ARM11_CTL1));
+	tmp |= 0x2;
+	__raw_writeb(tmp, IO_ADDRESS(KZM_ARM11_CTL1));
+
+	return platform_device_register(&serial_device);
+}
+#else
+static inline int kzm_init_ext_uart(void)
+{
+	return 0;
+}
+#endif
+
+/*
+ * SMSC LAN9118
+ */
+#if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
+static struct smsc911x_platform_config kzm_smsc9118_config = {
+	.phy_interface	= PHY_INTERFACE_MODE_MII,
+	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_HIGH,
+	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
+	.flags		= SMSC911X_USE_32BIT | SMSC911X_SAVE_MAC_ADDRESS,
+};
+
+static struct resource kzm_smsc9118_resources[] = {
+	{
+		.start	= CS5_BASE_ADDR,
+		.end	= CS5_BASE_ADDR + SZ_128K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= IOMUX_TO_IRQ(MX31_PIN_GPIO1_2),
+		.end	= IOMUX_TO_IRQ(MX31_PIN_GPIO1_2),
+		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
+	},
+};
+
+static struct platform_device kzm_smsc9118_device = {
+	.name		= "smsc911x",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(kzm_smsc9118_resources),
+	.resource	= kzm_smsc9118_resources,
+	.dev		= {
+				.platform_data = &kzm_smsc9118_config,
+			  },
+};
+
+static int __init kzm_init_smsc9118(void)
+{
+	/*
+	 * GPIO 1-2: SMSC9118 interrupt line
+	 */
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_GPIO1_2, IOMUX_CONFIG_GPIO));
+	gpio_request(IOMUX_TO_GPIO(MX31_PIN_GPIO1_2), "smsc9118-int");
+	gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_GPIO1_2));
+
+	return platform_device_register(&kzm_smsc9118_device);
+}
+#else
+static inline int kzm_init_smsc9118(void)
+{
+	return 0;
+}
+#endif
+
+#if defined(CONFIG_SERIAL_IMX) || defined(CONFIG_SERIAL_IMX_MODULE)
+static struct imxuart_platform_data uart_pdata = {
+	.flags = IMXUART_HAVE_RTSCTS,
+};
+
+static void __init kzm_init_imx_uart(void)
+{
+	mxc_register_device(&mxc_uart_device0, &uart_pdata);
+
+	mxc_register_device(&mxc_uart_device1, &uart_pdata);
+}
+#else
+static inline void kzm_init_imx_uart(void)
+{
+}
+#endif
+
+static int kzm_pins[] __initdata = {
+	MX31_PIN_CTS1__CTS1,
+	MX31_PIN_RTS1__RTS1,
+	MX31_PIN_TXD1__TXD1,
+	MX31_PIN_RXD1__RXD1,
+	MX31_PIN_DCD_DCE1__DCD_DCE1,
+	MX31_PIN_RI_DCE1__RI_DCE1,
+	MX31_PIN_DSR_DCE1__DSR_DCE1,
+	MX31_PIN_DTR_DCE1__DTR_DCE1,
+	MX31_PIN_CTS2__CTS2,
+	MX31_PIN_RTS2__RTS2,
+	MX31_PIN_TXD2__TXD2,
+	MX31_PIN_RXD2__RXD2,
+	MX31_PIN_DCD_DTE1__DCD_DTE2,
+	MX31_PIN_RI_DTE1__RI_DTE2,
+	MX31_PIN_DSR_DTE1__DSR_DTE2,
+	MX31_PIN_DTR_DTE1__DTR_DTE2,
+};
+
+/*
+ * Board specific initialization.
+ */
+static void __init kzm_board_init(void)
+{
+	mxc_iomux_setup_multiple_pins(kzm_pins,
+				      ARRAY_SIZE(kzm_pins), "kzm");
+	kzm_init_ext_uart();
+	kzm_init_smsc9118();
+	kzm_init_imx_uart();
+
+	pr_info("Clock input source is 26MHz\n");
+}
+
+/*
+ * This structure defines static mappings for the kzm-arm11-01 board.
+ */
+static struct map_desc kzm_io_desc[] __initdata = {
+	{
+		.virtual	= CS4_BASE_ADDR_VIRT,
+		.pfn		= __phys_to_pfn(CS4_BASE_ADDR),
+		.length		= CS4_SIZE,
+		.type		= MT_DEVICE
+	},
+	{
+		.virtual	= CS5_BASE_ADDR_VIRT,
+		.pfn		= __phys_to_pfn(CS5_BASE_ADDR),
+		.length		= CS5_SIZE,
+		.type		= MT_DEVICE
+	},
+};
+
+/*
+ * Set up static virtual mappings.
+ */
+static void __init kzm_map_io(void)
+{
+	mx31_map_io();
+	iotable_init(kzm_io_desc, ARRAY_SIZE(kzm_io_desc));
+}
+
+static void __init kzm_timer_init(void)
+{
+	mx31_clocks_init(26000000);
+}
+
+static struct sys_timer kzm_timer = {
+	.init   = kzm_timer_init,
+};
+
+/*
+ * The following uses standard kernel macros define in arch.h in order to
+ * initialize __mach_desc_KZM_ARM11_01 data structure.
+ */
+MACHINE_START(KZM_ARM11_01, "Kyoto Microcomputer Co., Ltd. KZM-ARM11-01")
+	.phys_io        = AIPS1_BASE_ADDR,
+	.io_pg_offst    = ((AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
+	.boot_params    = PHYS_OFFSET + 0x100,
+	.map_io         = kzm_map_io,
+	.init_irq       = mx31_init_irq,
+	.init_machine   = kzm_board_init,
+	.timer          = &kzm_timer,
+MACHINE_END
diff --git a/arch/arm/plat-mxc/include/mach/board-kzmarm11.h b/arch/arm/plat-mxc/include/mach/board-kzmarm11.h
new file mode 100644
index 0000000..05ff2f3
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/board-kzmarm11.h
@@ -0,0 +1,39 @@
+/*
+ *  Copyright (C) 2009  Yoichi Yuasa <yuasa@linux-mips.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+#ifndef __ARM_ARCH_BOARD_KZM_ARM11_H
+#define __ARM_ARCH_BOARD_KZM_ARM11_H
+
+/*
+ *  KZM-ARM11-01 Board Control Registers on FPGA
+ */
+#define KZM_ARM11_CTL1		(CS4_BASE_ADDR + 0x1000)
+#define KZM_ARM11_CTL2		(CS4_BASE_ADDR + 0x1001)
+#define KZM_ARM11_RSW1		(CS4_BASE_ADDR + 0x1002)
+#define KZM_ARM11_BACK_LIGHT	(CS4_BASE_ADDR + 0x1004)
+#define KZM_ARM11_FPGA_REV	(CS4_BASE_ADDR + 0x1008)
+#define KZM_ARM11_7SEG_LED	(CS4_BASE_ADDR + 0x1010)
+#define KZM_ARM11_LEDS		(CS4_BASE_ADDR + 0x1020)
+#define KZM_ARM11_DIPSW2	(CS4_BASE_ADDR + 0x1003)
+
+/*
+ * External UART for touch panel on FPGA
+ */
+#define KZM_ARM11_16550		(CS4_BASE_ADDR + 0x1050)
+
+#endif /* __ARM_ARCH_BOARD_KZM_ARM11_H */
+
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx3.h b/arch/arm/plat-mxc/include/mach/iomux-mx3.h
index 446f867..c9ef1ec 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx3.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx3.h
@@ -524,10 +524,18 @@ enum iomux_pins {
 #define MX31_PIN_RTS1__RTS1		IOMUX_MODE(MX31_PIN_RTS1, IOMUX_CONFIG_FUNC)
 #define MX31_PIN_TXD1__TXD1		IOMUX_MODE(MX31_PIN_TXD1, IOMUX_CONFIG_FUNC)
 #define MX31_PIN_RXD1__RXD1		IOMUX_MODE(MX31_PIN_RXD1, IOMUX_CONFIG_FUNC)
+#define MX31_PIN_DCD_DCE1__DCD_DCE1	IOMUX_MODE(MX31_PIN_DCD_DCE1, IOMUX_CONFIG_FUNC)
+#define MX31_PIN_RI_DCE1__RI_DCE1	IOMUX_MODE(MX31_PIN_RI_DCE1, IOMUX_CONFIG_FUNC)
+#define MX31_PIN_DSR_DCE1__DSR_DCE1	IOMUX_MODE(MX31_PIN_DSR_DCE1, IOMUX_CONFIG_FUNC)
+#define MX31_PIN_DTR_DCE1__DTR_DCE1	IOMUX_MODE(MX31_PIN_DTR_DCE1, IOMUX_CONFIG_FUNC)
 #define MX31_PIN_CTS2__CTS2		IOMUX_MODE(MX31_PIN_CTS2, IOMUX_CONFIG_FUNC)
 #define MX31_PIN_RTS2__RTS2		IOMUX_MODE(MX31_PIN_RTS2, IOMUX_CONFIG_FUNC)
 #define MX31_PIN_TXD2__TXD2		IOMUX_MODE(MX31_PIN_TXD2, IOMUX_CONFIG_FUNC)
 #define MX31_PIN_RXD2__RXD2		IOMUX_MODE(MX31_PIN_RXD2, IOMUX_CONFIG_FUNC)
+#define MX31_PIN_DCD_DTE1__DCD_DTE2	IOMUX_MODE(MX31_PIN_DCD_DTE1, IOMUX_CONFIG_ALT1)
+#define MX31_PIN_RI_DTE1__RI_DTE2	IOMUX_MODE(MX31_PIN_RI_DTE1, IOMUX_CONFIG_ALT1)
+#define MX31_PIN_DSR_DTE1__DSR_DTE2	IOMUX_MODE(MX31_PIN_DSR_DTE1, IOMUX_CONFIG_ALT1)
+#define MX31_PIN_DTR_DTE1__DTR_DTE2	IOMUX_MODE(MX31_PIN_DTR_DTE1, IOMUX_OCONFIG_ALT3 | IOMUX_ICONFIG_NONE)
 #define MX31_PIN_PC_RST__CTS5		IOMUX_MODE(MX31_PIN_PC_RST, IOMUX_CONFIG_ALT2)
 #define MX31_PIN_PC_VS2__RTS5		IOMUX_MODE(MX31_PIN_PC_VS2, IOMUX_CONFIG_ALT2)
 #define MX31_PIN_PC_BVD2__TXD5		IOMUX_MODE(MX31_PIN_PC_BVD2, IOMUX_CONFIG_ALT2)
-- 
1.6.5.1
