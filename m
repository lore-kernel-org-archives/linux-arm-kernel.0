From: jason77.wang@gmail.com (Jason Wang)
Date: Fri,  4 Jun 2010 22:09:26 +0800
Subject: [V3 5/7] mxc/mx51: Add support for the imx51 3-stack board
In-Reply-To: <1275660568-7738-5-git-send-email-jason77.wang@gmail.com>
References: <1275660568-7738-1-git-send-email-jason77.wang@gmail.com>
	<1275660568-7738-2-git-send-email-jason77.wang@gmail.com>
	<1275660568-7738-3-git-send-email-jason77.wang@gmail.com>
	<1275660568-7738-4-git-send-email-jason77.wang@gmail.com>
	<1275660568-7738-5-git-send-email-jason77.wang@gmail.com>
Message-ID: <1275660568-7738-6-git-send-email-jason77.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

3-stack is a reference board from Freescale for their i.MX51 SoC.

Add board definition, Kconfig and Makefile to enable Freescale 3-stack
board.

Boot tested on a i.MX51 3-stack Rev2.0 board

Signed-off-by: Jason Wang <jason77.wang@gmail.com>
---
 arch/arm/mach-mx5/Kconfig                       |    6 ++
 arch/arm/mach-mx5/Makefile                      |    2 +-
 arch/arm/mach-mx5/board-mx51_3ds.c              |  100 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/board-mx51_3ds.h |   27 ++++++
 4 files changed, 134 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-mx5/board-mx51_3ds.c
 create mode 100644 arch/arm/plat-mxc/include/mach/board-mx51_3ds.h

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 1576d51..6ef3428 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -15,4 +15,10 @@ config MACH_MX51_BABBAGE
 	  u-boot. This includes specific configurations for the board and its
 	  peripherals.
 
+config MACH_MX51_3DS
+	bool "Support MX51PDK (3DS)"
+	select MXC_DEBUG_BOARD
+	help
+	  Include support for MX51PDK (3DS) platform. This includes specific
+	  configurations for the board and its peripherals.
 endif
diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
index bf23f86..c757c59 100644
--- a/arch/arm/mach-mx5/Makefile
+++ b/arch/arm/mach-mx5/Makefile
@@ -6,4 +6,4 @@
 obj-y   := cpu.o mm.o clock-mx51.o devices.o
 
 obj-$(CONFIG_MACH_MX51_BABBAGE) += board-mx51_babbage.o
-
+obj-$(CONFIG_MACH_MX51_3DS) += board-mx51_3ds.o
diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
new file mode 100644
index 0000000..af0362c
--- /dev/null
+++ b/arch/arm/mach-mx5/board-mx51_3ds.c
@@ -0,0 +1,100 @@
+/*
+ * Copyright 2008-2009 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright (C) 2010 Jason Wang <jason77.wang@gmail.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/irq.h>
+#include <linux/platform_device.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+
+#include <mach/hardware.h>
+#include <mach/common.h>
+#include <mach/iomux-mx51.h>
+#include <mach/board-mx51_3ds.h>
+#include <mach/imx-uart.h>
+#include <mach/cpld_debugboard.h>
+
+#include "devices.h"
+
+static struct pad_desc mx51_3ds_pads[] = {
+	/* UART1 */
+	MX51_PAD_UART1_RXD__UART1_RXD,
+	MX51_PAD_UART1_TXD__UART1_TXD,
+	MX51_PAD_UART1_RTS__UART1_RTS,
+	MX51_PAD_UART1_CTS__UART1_CTS,
+
+	/* UART2 */
+	MX51_PAD_UART2_RXD__UART2_RXD,
+	MX51_PAD_UART2_TXD__UART2_TXD,
+	MX51_PAD_EIM_D25__UART2_CTS,
+	MX51_PAD_EIM_D26__UART2_RTS,
+
+	/* UART3 */
+	MX51_PAD_UART3_RXD__UART3_RXD,
+	MX51_PAD_UART3_TXD__UART3_TXD,
+	MX51_PAD_EIM_D24__UART3_CTS,
+	MX51_PAD_EIM_D27__UART3_RTS,
+
+	/* CPLD PARENT IRQ PIN */
+	MX51_PAD_GPIO_1_6__GPIO1_6,
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
+	mxc_iomux_v3_setup_multiple_pads(mx51_3ds_pads,
+					ARRAY_SIZE(mx51_3ds_pads));
+	mxc_init_imx_uart();
+
+	if (!mxc_expio_init(MX51_CS5_BASE_ADDR, EXPIO_PARENT_INT))
+		platform_device_register(&smsc_lan9217_device);
+}
+
+static void __init mx51_3ds_timer_init(void)
+{
+	mx51_clocks_init(32768, 24000000, 22579200, 0);
+}
+
+static struct sys_timer mxc_timer = {
+	.init	= mx51_3ds_timer_init,
+};
+
+MACHINE_START(MX51_3DS, "Freescale MX51 3-Stack Board")
+	.phys_io = MX51_AIPS1_BASE_ADDR,
+	.io_pg_offst = ((MX51_AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
+	.boot_params = PHYS_OFFSET + 0x100,
+	.map_io = mx51_map_io,
+	.init_irq = mx51_init_irq,
+	.init_machine = mxc_board_init,
+	.timer = &mxc_timer,
+MACHINE_END
diff --git a/arch/arm/plat-mxc/include/mach/board-mx51_3ds.h b/arch/arm/plat-mxc/include/mach/board-mx51_3ds.h
new file mode 100644
index 0000000..c2aa016
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/board-mx51_3ds.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright 2008-2009 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#ifndef __ASM_ARCH_MXC_BOARD_MX51_3DS_H__
+#define __ASM_ARCH_MXC_BOARD_MX51_3DS_H__
+
+/*
+ * plat-mxc/include/mach/board-mx51_3ds.h
+ *
+ * This file contains all the board level configuration options.
+ *
+ * It currently hold the options defined for MX51 3Stack Platform.
+ *
+ */
+
+#define EXPIO_PARENT_INT	(MXC_INTERNAL_IRQS + GPIO_PORTA + 6)
+
+#endif	/* __ASM_ARCH_MXC_BOARD_MX51_3DS_H__ */
-- 
1.5.6.5
