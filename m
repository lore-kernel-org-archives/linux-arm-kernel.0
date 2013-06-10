From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 10 Jun 2013 15:55:21 -0400
Subject: [PATCH 1/3] ARM: keystone: Add minimal TI Keystone platform support
In-Reply-To: <1370894123-26846-1-git-send-email-santosh.shilimkar@ti.com>
References: <1370894123-26846-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1370894123-26846-2-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Texas Instruments Keystone family of multi-core devices are
based on ARM Cortex A15. Patch adds basic definitions for a
new Keystone sub-architecture in ARM.

The TCI66xxK2H Communications Infrastructure Keystone SoCs
are member of the C66x family based on TI's new KeyStone 2
multi-core SoC Architecture designed specifically for high
performance wireless and networking infrastructure applications.
The SOCs contains many subsystems like Cortex A15 ARM CorePacs,
C66XX DSP CorePacs, MSMC memory controller, Tera Net bus,
IP Network, Navigator, Hyperlink, 1G/10G Ethernet, Radio layers
and queue based communication systems.

Cc: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: arm at kernel.org

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/Kconfig                            |    3 +
 arch/arm/Kconfig.debug                      |   16 +++
 arch/arm/Makefile                           |    1 +
 arch/arm/configs/keystone_defconfig         |  157 +++++++++++++++++++++++++++
 arch/arm/include/debug/keystone.S           |   43 ++++++++
 arch/arm/mach-keystone/Kconfig              |   16 +++
 arch/arm/mach-keystone/Makefile             |    1 +
 arch/arm/mach-keystone/Makefile.boot        |    1 +
 arch/arm/mach-keystone/include/mach/timex.h |   15 +++
 arch/arm/mach-keystone/keystone.c           |   74 +++++++++++++
 10 files changed, 327 insertions(+)
 create mode 100644 arch/arm/configs/keystone_defconfig
 create mode 100644 arch/arm/include/debug/keystone.S
 create mode 100644 arch/arm/mach-keystone/Kconfig
 create mode 100644 arch/arm/mach-keystone/Makefile
 create mode 100644 arch/arm/mach-keystone/Makefile.boot
 create mode 100644 arch/arm/mach-keystone/include/mach/timex.h
 create mode 100644 arch/arm/mach-keystone/keystone.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 49d993c..37fe64c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -948,6 +948,8 @@ source "arch/arm/mach-iop13xx/Kconfig"
 
 source "arch/arm/mach-ixp4xx/Kconfig"
 
+source "arch/arm/mach-keystone/Kconfig"
+
 source "arch/arm/mach-kirkwood/Kconfig"
 
 source "arch/arm/mach-ks8695/Kconfig"
@@ -1564,6 +1566,7 @@ config ARCH_NR_GPIO
 	default 352 if ARCH_VT8500
 	default 288 if ARCH_SUNXI
 	default 264 if MACH_H4700
+	default 512 if ARCH_KEYSTONE
 	default 0
 	help
 	  Maximum number of GPIOs in the system.
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 1d41908..62e7f95 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -251,6 +251,20 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on i.MX6Q/DL.
 
+	config DEBUG_KEYSTONE_UART0
+		bool "Kernel low-level debugging on KEYSTONE2 using UART0"
+		depends on ARCH_KEYSTONE
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to UART0 serial port on KEYSTONE2 devices.
+
+	config DEBUG_KEYSTONE_UART1
+		bool "Kernel low-level debugging on KEYSTONE2 using UART1"
+		depends on ARCH_KEYSTONE
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to UART1 serial port on KEYSTONE2 devices.
+
 	config DEBUG_MMP_UART2
 		bool "Kernel low-level debugging message via MMP UART2"
 		depends on ARCH_MMP
@@ -632,6 +646,8 @@ config DEBUG_LL_INCLUDE
 				 DEBUG_IMX51_UART || \
 				 DEBUG_IMX53_UART ||\
 				 DEBUG_IMX6Q_UART
+	default "debug/keystone.S" if DEBUG_KEYSTONE_UART0 || \
+				      DEBUG_KEYSTONE_UART1
 	default "debug/mvebu.S" if DEBUG_MVEBU_UART
 	default "debug/mxs.S" if DEBUG_IMX23_UART || DEBUG_IMX28_UART
 	default "debug/nomadik.S" if DEBUG_NOMADIK_UART
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 1ba358b..a1c9a78 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -194,6 +194,7 @@ machine-$(CONFIG_PLAT_SPEAR)		+= spear
 machine-$(CONFIG_ARCH_VIRT)		+= virt
 machine-$(CONFIG_ARCH_ZYNQ)		+= zynq
 machine-$(CONFIG_ARCH_SUNXI)		+= sunxi
+machine-$(CONFIG_ARCH_KEYSTONE)		+= keystone
 
 # Platform directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
new file mode 100644
index 0000000..62e968c
--- /dev/null
+++ b/arch/arm/configs/keystone_defconfig
@@ -0,0 +1,157 @@
+# CONFIG_SWAP is not set
+CONFIG_POSIX_MQUEUE=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_SYSCTL_SYSCALL=y
+CONFIG_KALLSYMS_ALL=y
+# CONFIG_ELF_CORE is not set
+# CONFIG_BASE_FULL is not set
+CONFIG_EMBEDDED=y
+CONFIG_PROFILING=y
+CONFIG_OPROFILE=y
+CONFIG_KPROBES=y
+CONFIG_MODULES=y
+CONFIG_MODULE_FORCE_LOAD=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_ARCH_KEYSTONE=y
+CONFIG_ARM_LPAE=y
+CONFIG_SMP=y
+CONFIG_PREEMPT=y
+CONFIG_AEABI=y
+CONFIG_HIGHMEM=y
+CONFIG_VFP=y
+CONFIG_NEON=y
+# CONFIG_SUSPEND is not set
+CONFIG_PM_RUNTIME=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_UNIX_DIAG=y
+CONFIG_XFRM_USER=y
+CONFIG_XFRM_SUB_POLICY=y
+CONFIG_XFRM_STATISTICS=y
+CONFIG_NET_KEY=y
+CONFIG_NET_KEY_MIGRATE=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_ROUTE_MULTIPATH=y
+CONFIG_IP_ROUTE_VERBOSE=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_NET_IPIP=y
+CONFIG_NET_IPGRE_DEMUX=y
+CONFIG_NET_IPGRE=y
+CONFIG_IP_MROUTE=y
+CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
+CONFIG_IP_PIMSM_V2=y
+CONFIG_INET_AH=y
+CONFIG_INET_IPCOMP=y
+CONFIG_IPV6=y
+CONFIG_INET6_XFRM_MODE_TRANSPORT=m
+CONFIG_INET6_XFRM_MODE_TUNNEL=m
+CONFIG_INET6_XFRM_MODE_BEET=m
+CONFIG_IPV6_SIT=m
+CONFIG_IPV6_MULTIPLE_TABLES=y
+CONFIG_IPV6_SUBTREES=y
+CONFIG_IPV6_MROUTE=y
+CONFIG_IPV6_PIMSM_V2=y
+CONFIG_NETFILTER=y
+CONFIG_NF_CONNTRACK=y
+CONFIG_NF_CT_NETLINK=y
+CONFIG_NETFILTER_XT_TARGET_CLASSIFY=y
+CONFIG_NETFILTER_XT_TARGET_CONNMARK=y
+CONFIG_NETFILTER_XT_TARGET_IDLETIMER=y
+CONFIG_NETFILTER_XT_TARGET_MARK=y
+CONFIG_NETFILTER_XT_MATCH_COMMENT=y
+CONFIG_NETFILTER_XT_MATCH_CONNBYTES=y
+CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=y
+CONFIG_NETFILTER_XT_MATCH_CONNMARK=y
+CONFIG_NETFILTER_XT_MATCH_CONNTRACK=y
+CONFIG_NETFILTER_XT_MATCH_CPU=y
+CONFIG_NETFILTER_XT_MATCH_IPRANGE=y
+CONFIG_NETFILTER_XT_MATCH_LENGTH=y
+CONFIG_NETFILTER_XT_MATCH_MAC=y
+CONFIG_NETFILTER_XT_MATCH_MARK=y
+CONFIG_NETFILTER_XT_MATCH_MULTIPORT=y
+CONFIG_NETFILTER_XT_MATCH_PKTTYPE=y
+CONFIG_NETFILTER_XT_MATCH_STATE=y
+CONFIG_NF_CONNTRACK_IPV4=y
+CONFIG_IP_NF_IPTABLES=y
+CONFIG_IP_NF_MATCH_AH=y
+CONFIG_IP_NF_MATCH_ECN=y
+CONFIG_IP_NF_MATCH_TTL=y
+CONFIG_IP_NF_FILTER=y
+CONFIG_IP_NF_TARGET_REJECT=y
+CONFIG_IP_NF_TARGET_ULOG=y
+CONFIG_IP_NF_MANGLE=y
+CONFIG_IP_NF_TARGET_CLUSTERIP=y
+CONFIG_IP_NF_TARGET_ECN=y
+CONFIG_IP_NF_TARGET_TTL=y
+CONFIG_IP_NF_RAW=y
+CONFIG_IP_NF_ARPTABLES=y
+CONFIG_IP_NF_ARPFILTER=y
+CONFIG_IP_NF_ARP_MANGLE=y
+CONFIG_IP6_NF_IPTABLES=m
+CONFIG_IP_SCTP=y
+CONFIG_VLAN_8021Q=y
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_CMA=y
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_PLATRAM=y
+CONFIG_MTD_M25P80=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_UBI=y
+CONFIG_PROC_DEVICETREE=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_EEPROM_AT24=y
+CONFIG_NETDEVICES=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_I2C=y
+# CONFIG_I2C_COMPAT is not set
+CONFIG_I2C_CHARDEV=y
+CONFIG_SPI=y
+CONFIG_SPI_SPIDEV=y
+# CONFIG_HWMON is not set
+CONFIG_WATCHDOG=y
+# CONFIG_USB_SUPPORT is not set
+CONFIG_DMADEVICES=y
+CONFIG_COMMON_CLK_DEBUG=y
+CONFIG_MEMORY=y
+CONFIG_TMPFS=y
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_WBUF_VERIFY=y
+CONFIG_UBIFS_FS=y
+CONFIG_CRAMFS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
+CONFIG_ROOT_NFS=y
+CONFIG_NFSD=y
+CONFIG_NFSD_V3=y
+CONFIG_NFSD_V3_ACL=y
+CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_SHIRQ=y
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_USER=y
+CONFIG_CRYPTO_USER=y
+CONFIG_CRYPTO_NULL=y
+CONFIG_CRYPTO_AUTHENC=y
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_CTR=y
+CONFIG_CRYPTO_XCBC=y
+CONFIG_CRYPTO_DES=y
+CONFIG_CRYPTO_ANSI_CPRNG=y
+CONFIG_CRYPTO_USER_API_HASH=y
+CONFIG_CRYPTO_USER_API_SKCIPHER=y
diff --git a/arch/arm/include/debug/keystone.S b/arch/arm/include/debug/keystone.S
new file mode 100644
index 0000000..9c75a4c
--- /dev/null
+++ b/arch/arm/include/debug/keystone.S
@@ -0,0 +1,43 @@
+/*
+ * Early serial debug output macro for Keystone SOCs
+ *
+ * Copyright 2013 Texas Instruments, Inc.
+ *	Santosh Shilimkar ,santosh.shilimkar at ti.com>
+ *
+ * Based on RMKs low level debug code.
+ *  Copyright (C) 1994-1999 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/serial_reg.h>
+
+#define UART_SHIFT 2
+#if defined(CONFIG_DEBUG_KEYSTONE_UART0)
+#define UART_PHYS		0x02530c00
+#define UART_VIRT		0xfeb30c00
+#elif defined(CONFIG_DEBUG_KEYSTONE_UART1)
+#define UART_PHYS		0x02531000
+#define UART_VIRT		0xfeb31000
+#endif
+
+	.macro	addruart, rp, rv, tmp
+	ldr	\rv, =UART_VIRT			@ physical base address
+	ldr	\rp, =UART_PHYS			@ virtual base address
+	.endm
+
+	.macro	senduart,rd,rx
+	str	\rd, [\rx, #UART_TX << UART_SHIFT]
+	.endm
+
+	.macro	busyuart,rd,rx
+1002:	ldr	\rd, [\rx, #UART_LSR << UART_SHIFT]
+	and	\rd, \rd, #UART_LSR_TEMT | UART_LSR_THRE
+	teq	\rd, #UART_LSR_TEMT | UART_LSR_THRE
+	bne	1002b
+	.endm
+
+	.macro	waituart,rd,rx
+	.endm
diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
new file mode 100644
index 0000000..39fab74
--- /dev/null
+++ b/arch/arm/mach-keystone/Kconfig
@@ -0,0 +1,16 @@
+config ARCH_KEYSTONE
+	bool "Texas Instruments Keystone Devices"
+	select CPU_V7
+	select ARM_GIC
+	select HAVE_ARM_ARCH_TIMER
+	select USE_OF
+	select MULTI_IRQ_HANDLER
+	select CLKSRC_MMIO
+	select GENERIC_CLOCKEVENTS
+	select SPARSE_IRQ
+	select HAVE_SCHED_CLOCK
+	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select ARM_ERRATA_798181
+	help
+	  Support for boards based on the Texas Instruments Keystone family of
+	  SoCs.
diff --git a/arch/arm/mach-keystone/Makefile b/arch/arm/mach-keystone/Makefile
new file mode 100644
index 0000000..d4671d5
--- /dev/null
+++ b/arch/arm/mach-keystone/Makefile
@@ -0,0 +1 @@
+obj-y					:= keystone.o
diff --git a/arch/arm/mach-keystone/Makefile.boot b/arch/arm/mach-keystone/Makefile.boot
new file mode 100644
index 0000000..f3835c4
--- /dev/null
+++ b/arch/arm/mach-keystone/Makefile.boot
@@ -0,0 +1 @@
+zreladdr-y	:= 0x80008000
diff --git a/arch/arm/mach-keystone/include/mach/timex.h b/arch/arm/mach-keystone/include/mach/timex.h
new file mode 100644
index 0000000..e4c595a
--- /dev/null
+++ b/arch/arm/mach-keystone/include/mach/timex.h
@@ -0,0 +1,15 @@
+/*
+ * Copyright 2013 Texas Instruments, Inc.
+ *	Cyril Chemparathy <cyril@ti.com>
+ *	Santosh Shilimkar <santosh.shillimkar@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+#ifndef __MACH_TIMEX_H
+#define __MACH_TIMEX_H
+
+#define CLOCK_TICK_RATE		1000000
+
+#endif
diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
new file mode 100644
index 0000000..6c6fc42
--- /dev/null
+++ b/arch/arm/mach-keystone/keystone.c
@@ -0,0 +1,74 @@
+/*
+ * Keystone2 based boards and SOC related code.
+ *
+ * Copyright 2013 Texas Instruments, Inc.
+ *	Cyril Chemparathy <cyril@ti.com>
+ *	Santosh Shilimkar <santosh.shillimkar@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/init.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+
+#include <asm/setup.h>
+#include <asm/mach/map.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+
+#define PLL_RESET_WRITE_KEY_MASK		0xffff0000
+#define PLL_RESET_WRITE_KEY			0x5a69
+#define PLL_RESET				BIT(16)
+
+static void __iomem *keystone_rstctrl;
+
+static void __init keystone_init(void)
+{
+	struct device_node *node;
+
+	node = of_find_compatible_node(NULL, NULL, "ti,keystone-reset");
+	if (WARN_ON(!node)) {
+		pr_warn("ti, keystone-reset node undefined\n");
+		return;
+	}
+
+	keystone_rstctrl = of_iomap(node, 0);
+	if (WARN_ON(!keystone_rstctrl)) {
+		pr_warn("ti, keystone-reset iomap error\n");
+		return;
+	}
+
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static const char *keystone_match[] __initconst = {
+	"ti,keystone-evm",
+	NULL,
+};
+
+void keystone_restart(char mode, const char *cmd)
+{
+	u32 val;
+
+	/* Enable write access to RSTCTRL */
+	val = __raw_readl(keystone_rstctrl);
+	val &= PLL_RESET_WRITE_KEY_MASK;
+	val |= PLL_RESET_WRITE_KEY;
+	__raw_writel(val, keystone_rstctrl);
+
+	/* Reset the SOC */
+	val = __raw_readl(keystone_rstctrl);
+	val &= ~PLL_RESET;
+	__raw_writel(val, keystone_rstctrl);
+}
+
+DT_MACHINE_START(KEYSTONE, "Keystone")
+	.map_io		= debug_ll_io_init,
+	.init_machine	= keystone_init,
+	.dt_compat	= keystone_match,
+	.restart	= keystone_restart,
+MACHINE_END
-- 
1.7.9.5
