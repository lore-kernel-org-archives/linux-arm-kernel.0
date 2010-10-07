From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Thu,  7 Oct 2010 03:58:12 +0300
Subject: [PATCH 1/3] mx51: add support for genesi efikamx nettop
In-Reply-To: <cover.1286412080.git.amit.kucheria@linaro.org>
References: <cover.1286412080.git.amit.kucheria@linaro.org>
Message-ID: <84f910cebd5121a8510d03e0308635a1af2e611b.1286412080.git.amit.kucheria@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Get serial port working for now

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm/mach-mx5/Kconfig              |    7 +++
 arch/arm/mach-mx5/Makefile             |    1 +
 arch/arm/mach-mx5/board-mx51_efikamx.c |   91 ++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mx5/board-mx51_efikamx.c

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 3a4c3b3..fad31cc 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -49,4 +49,11 @@ config MACH_EUKREA_MBIMX51_BASEBOARD
 
 endchoice
 
+config MACH_MX51_EFIKAMX
+	bool "Support MX51 Genesi Efika MX nettop"
+	select IMX_HAVE_PLATFORM_IMX_UART
+	help
+	  Include support for Genesi Efika MX nettop. This includes specific
+	  configurations for the board and its peripherals.
+
 endif
diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
index 86c66e7..d1aac9c 100644
--- a/arch/arm/mach-mx5/Makefile
+++ b/arch/arm/mach-mx5/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_MACH_MX51_BABBAGE) += board-mx51_babbage.o
 obj-$(CONFIG_MACH_MX51_3DS) += board-mx51_3ds.o
 obj-$(CONFIG_MACH_EUKREA_CPUIMX51) += board-cpuimx51.o
 obj-$(CONFIG_MACH_EUKREA_MBIMX51_BASEBOARD) += eukrea_mbimx51-baseboard.o
+obj-$(CONFIG_MACH_MX51_EFIKAMX) += board-mx51_efikamx.o
diff --git a/arch/arm/mach-mx5/board-mx51_efikamx.c b/arch/arm/mach-mx5/board-mx51_efikamx.c
new file mode 100644
index 0000000..4c921fc
--- /dev/null
+++ b/arch/arm/mach-mx5/board-mx51_efikamx.c
@@ -0,0 +1,91 @@
+/*
+ * Copyright (C) 2010 Linaro Limited
+ *
+ * based on code from the following
+ * Copyright 2009-2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright 2009-2010 Pegatron Corporation. All Rights Reserved.
+ * Copyright 2009-2010 Genesi USA, Inc. All Rights Reserved.
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
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/fsl_devices.h>
+
+#include <mach/common.h>
+#include <mach/hardware.h>
+#include <mach/iomux-mx51.h>
+#include <mach/i2c.h>
+#include <mach/mxc_ehci.h>
+
+#include <asm/irq.h>
+#include <asm/setup.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+
+#include "devices-imx51.h"
+#include "devices.h"
+
+static struct pad_desc mx51efikamx_pads[] = {
+	/* UART1 */
+	MX51_PAD_UART1_RXD__UART1_RXD,
+	MX51_PAD_UART1_TXD__UART1_TXD,
+	MX51_PAD_UART1_RTS__UART1_RTS,
+	MX51_PAD_UART1_CTS__UART1_CTS,
+};
+
+/* Serial ports */
+#if defined(CONFIG_SERIAL_IMX) || defined(CONFIG_SERIAL_IMX_MODULE)
+static const struct imxuart_platform_data uart_pdata = {
+	.flags = IMXUART_HAVE_RTSCTS,
+};
+
+static inline void mxc_init_imx_uart(void)
+{
+	imx51_add_imx_uart(0, &uart_pdata);
+	imx51_add_imx_uart(1, &uart_pdata);
+	imx51_add_imx_uart(2, &uart_pdata);
+}
+#else /* !SERIAL_IMX */
+static inline void mxc_init_imx_uart(void)
+{
+}
+#endif /* SERIAL_IMX */
+
+static void __init mxc_board_init(void)
+{
+	mxc_iomux_v3_setup_multiple_pads(mx51efikamx_pads,
+					ARRAY_SIZE(mx51efikamx_pads));
+	mxc_init_imx_uart();
+}
+
+static void __init mx51_efikamx_timer_init(void)
+{
+	mx51_clocks_init(32768, 24000000, 22579200, 24576000);
+}
+
+static struct sys_timer mxc_timer = {
+	.init	= mx51_efikamx_timer_init,
+};
+
+MACHINE_START(MX51_EFIKAMX, "Genesi EfikaMX nettop")
+	/* Maintainer: Amit Kucheria <amit.kucheria@linaro.org> */
+	.phys_io = MX51_AIPS1_BASE_ADDR,
+	.io_pg_offst = ((MX51_AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
+	.boot_params = MX51_PHYS_OFFSET + 0x100,
+	.map_io = mx51_map_io,
+	.init_irq = mx51_init_irq,
+	.init_machine =  mxc_board_init,
+	.timer = &mxc_timer,
+MACHINE_END
-- 
1.7.0.4
