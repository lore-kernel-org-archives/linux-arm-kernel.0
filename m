From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Tue,  9 Feb 2010 18:59:53 +0200
Subject: [PATCHv3 5/7] mxc: Add support for the Babbage board (i.MX5)
In-Reply-To: <a329b48c43e5e2e6b51ce159d99aefeb90c7c066.1265733173.git.amit.kucheria@canonical.com>
References: <cover.1265733173.git.amit.kucheria@canonical.com>
	<a003708ad4ee9384226251431c7953a24079ff80.1265733173.git.amit.kucheria@canonical.com>
	<0f3332c4fabb2227b1bc15dc7542017d08f10a09.1265733173.git.amit.kucheria@canonical.com>
	<438caa3f6c91ba21c539a8547c4075b619dc6500.1265733173.git.amit.kucheria@canonical.com>
	<a329b48c43e5e2e6b51ce159d99aefeb90c7c066.1265733173.git.amit.kucheria@canonical.com>
Message-ID: <b996b5830364c1b1d2469be574f4ebe831987ba9.1265733173.git.amit.kucheria@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Babbage is a reference board from Freescale for their i.MX51 SoC.

Add board definition, Kconfig and Makefiles to enable Freescale i.MX51
processor and Babbage board.

Boot tested on a Babbage2.5 board

Signed-off-by: Amit Kucheria <amit.kucheria@canonical.com>
---
 arch/arm/Makefile                      |    1 +
 arch/arm/mach-mx5/Kconfig              |   18 ++++++
 arch/arm/mach-mx5/Makefile             |    9 +++
 arch/arm/mach-mx5/Makefile.boot        |    3 +
 arch/arm/mach-mx5/board-mx51_babbage.c |   98 ++++++++++++++++++++++++++++++++
 arch/arm/plat-mxc/Kconfig              |    8 +++
 6 files changed, 137 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mx5/Kconfig
 create mode 100644 arch/arm/mach-mx5/Makefile
 create mode 100644 arch/arm/mach-mx5/Makefile.boot
 create mode 100644 arch/arm/mach-mx5/board-mx51_babbage.c

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index e9da084..056daf8 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -146,6 +146,7 @@ machine-$(CONFIG_ARCH_MX1)		:= mx1
 machine-$(CONFIG_ARCH_MX2)		:= mx2
 machine-$(CONFIG_ARCH_MX25)		:= mx25
 machine-$(CONFIG_ARCH_MX3)		:= mx3
+machine-$(CONFIG_ARCH_MX5)		:= mx5
 machine-$(CONFIG_ARCH_NETX)		:= netx
 machine-$(CONFIG_ARCH_NOMADIK)		:= nomadik
 machine-$(CONFIG_ARCH_NS9XXX)		:= ns9xxx
diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
new file mode 100644
index 0000000..1576d51
--- /dev/null
+++ b/arch/arm/mach-mx5/Kconfig
@@ -0,0 +1,18 @@
+if ARCH_MX5
+
+config ARCH_MX51
+	bool
+	default y
+	select MXC_TZIC
+	select ARCH_MXC_IOMUX_V3
+
+comment "MX5 platforms:"
+
+config MACH_MX51_BABBAGE
+	bool "Support MX51 BABBAGE platforms"
+	help
+	  Include support for MX51 Babbage platform, also known as MX51EVK in
+	  u-boot. This includes specific configurations for the board and its
+	  peripherals.
+
+endif
diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
new file mode 100644
index 0000000..bf23f86
--- /dev/null
+++ b/arch/arm/mach-mx5/Makefile
@@ -0,0 +1,9 @@
+#
+# Makefile for the linux kernel.
+#
+
+# Object file lists.
+obj-y   := cpu.o mm.o clock-mx51.o devices.o
+
+obj-$(CONFIG_MACH_MX51_BABBAGE) += board-mx51_babbage.o
+
diff --git a/arch/arm/mach-mx5/Makefile.boot b/arch/arm/mach-mx5/Makefile.boot
new file mode 100644
index 0000000..9939a19
--- /dev/null
+++ b/arch/arm/mach-mx5/Makefile.boot
@@ -0,0 +1,3 @@
+   zreladdr-y	:= 0x90008000
+params_phys-y	:= 0x90000100
+initrd_phys-y	:= 0x90800000
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
new file mode 100644
index 0000000..d5ccb5f
--- /dev/null
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -0,0 +1,98 @@
+/*
+ * Copyright 2009 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright (C) 2009-2010 Amit Kucheria <amit.kucheria@canonical.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/init.h>
+#include <linux/platform_device.h>
+
+#include <mach/common.h>
+#include <mach/hardware.h>
+#include <mach/imx-uart.h>
+#include <mach/iomux-mx51.h>
+
+#include <asm/irq.h>
+#include <asm/setup.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+
+#include "devices.h"
+
+static struct platform_device *devices[] __initdata = {
+	&mxc_fec_device,
+};
+
+static struct pad_desc mx51babbage_pads[] = {
+	/* UART1 */
+	MX51_PAD_UART1_RXD__UART1_RXD,
+	MX51_PAD_UART1_TXD__UART1_TXD,
+	MX51_PAD_UART1_RTS__UART1_RTS,
+	MX51_PAD_UART1_CTS__UART1_CTS,
+
+	/* UART2 */
+	MX51_PAD_UART2_RXD__UART2_RXD,
+	MX51_PAD_UART2_TXD__UART2_TXD,
+
+	/* UART3 */
+	MX51_PAD_EIM_D25__UART3_RXD,
+	MX51_PAD_EIM_D26__UART3_TXD,
+	MX51_PAD_EIM_D27__UART3_RTS,
+	MX51_PAD_EIM_D24__UART3_CTS,
+};
+
+/* Serial ports */
+#if defined(CONFIG_SERIAL_IMX) || defined(CONFIG_SERIAL_IMX_MODULE)
+static struct imxuart_platform_data uart_pdata = {
+	.flags = IMXUART_HAVE_RTSCTS,
+};
+
+static inline void mxc_init_imx_uart(void)
+{
+	mxc_register_device(&mxc_uart_device0, &uart_pdata);
+	mxc_register_device(&mxc_uart_device1, &uart_pdata);
+	mxc_register_device(&mxc_uart_device2, &uart_pdata);
+}
+#else /* !SERIAL_IMX */
+static inline void mxc_init_imx_uart(void)
+{
+}
+#endif /* SERIAL_IMX */
+
+/*
+ * Board specific initialization.
+ */
+static void __init mxc_board_init(void)
+{
+	mxc_iomux_v3_setup_multiple_pads(mx51babbage_pads,
+					ARRAY_SIZE(mx51babbage_pads));
+	mxc_init_imx_uart();
+	platform_add_devices(devices, ARRAY_SIZE(devices));
+}
+
+static void __init mx51_babbage_timer_init(void)
+{
+	mx51_clocks_init(32768, 24000000, 22579200, 24576000);
+}
+
+static struct sys_timer mxc_timer = {
+	.init	= mx51_babbage_timer_init,
+};
+
+MACHINE_START(MX51_BABBAGE, "Freescale MX51 Babbage Board")
+	/* Maintainer: Amit Kucheria <amit.kucheria@canonical.com> */
+	.phys_io = MX51_AIPS1_BASE_ADDR,
+	.io_pg_offst = ((MX51_AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
+	.boot_params = PHYS_OFFSET + 0x100,
+	.map_io = mx51_map_io,
+	.init_irq = mx51_init_irq,
+	.init_machine = mxc_board_init,
+	.timer = &mxc_timer,
+MACHINE_END
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index 59558c4..cea51a0 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -41,6 +41,13 @@ config ARCH_MXC91231
 	help
 	  This enables support for systems based on the Freescale MXC91231 family
 
+config ARCH_MX5
+	bool "MX5-based"
+	select CPU_V7
+	select COMMON_CLKDEV
+	help
+	  This enables support for systems based on the Freescale i.MX51 family
+
 endchoice
 
 source "arch/arm/mach-mx1/Kconfig"
@@ -48,6 +55,7 @@ source "arch/arm/mach-mx2/Kconfig"
 source "arch/arm/mach-mx3/Kconfig"
 source "arch/arm/mach-mx25/Kconfig"
 source "arch/arm/mach-mxc91231/Kconfig"
+source "arch/arm/mach-mx5/Kconfig"
 
 endmenu
 
-- 
1.6.3.3
