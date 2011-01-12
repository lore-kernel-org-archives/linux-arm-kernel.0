From: yong.shen@freescale.com (yong.shen at freescale.com)
Date: Wed, 12 Jan 2011 17:14:46 +0800
Subject: [PATCH v2 1/2] ARM i.MX53 enable SMD board bootup
In-Reply-To: <1294823687-20520-1-git-send-email-yong.shen@freescale.com>
References: <1294823687-20520-1-git-send-email-yong.shen@freescale.com>
Message-ID: <1294823687-20520-2-git-send-email-yong.shen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yong Shen <yong.shen@freescale.com>

1. Add Kconfig and Makefile entries
2. Add board definition
3. enable uart and fec for SMD board

Signed-off-by: Yong Shen <yong.shen@freescale.com>
---
 arch/arm/mach-mx5/Kconfig          |    7 ++
 arch/arm/mach-mx5/Makefile         |    1 +
 arch/arm/mach-mx5/board-mx53_smd.c |  111 ++++++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mx5/board-mx53_smd.c

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 777740b..f9706df 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -131,6 +131,13 @@ config MACH_MX53_EVK
 	  Include support for MX53 EVK platform. This includes specific
 	  configurations for the board and its peripherals.
 
+config MACH_MX53_SMD
+	bool "Support MX53 SMD platforms"
+	select SOC_IMX53
+	select IMX_HAVE_PLATFORM_IMX_UART
+	help
+	  Include support for MX53 SMD platform. This includes specific
+	  configurations for the board and its peripherals.
 
 config MACH_MX50_RDP
 	bool "Support MX50 reference design platform"
diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
index 0c398ba..895bfe3 100644
--- a/arch/arm/mach-mx5/Makefile
+++ b/arch/arm/mach-mx5/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_CPU_FREQ_IMX)    += cpu_op-mx51.o
 obj-$(CONFIG_MACH_MX51_BABBAGE) += board-mx51_babbage.o
 obj-$(CONFIG_MACH_MX51_3DS) += board-mx51_3ds.o
 obj-$(CONFIG_MACH_MX53_EVK) += board-mx53_evk.o
+obj-$(CONFIG_MACH_MX53_SMD) += board-mx53_smd.o
 obj-$(CONFIG_MACH_EUKREA_CPUIMX51) += board-cpuimx51.o
 obj-$(CONFIG_MACH_EUKREA_MBIMX51_BASEBOARD) += eukrea_mbimx51-baseboard.o
 obj-$(CONFIG_MACH_EUKREA_CPUIMX51SD) += board-cpuimx51sd.o
diff --git a/arch/arm/mach-mx5/board-mx53_smd.c b/arch/arm/mach-mx5/board-mx53_smd.c
new file mode 100644
index 0000000..7970f7a
--- /dev/null
+++ b/arch/arm/mach-mx5/board-mx53_smd.c
@@ -0,0 +1,111 @@
+/*
+ * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <linux/init.h>
+#include <linux/clk.h>
+#include <linux/fec.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+
+#include <mach/common.h>
+#include <mach/hardware.h>
+#include <mach/imx-uart.h>
+#include <mach/iomux-mx53.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+
+#include "crm_regs.h"
+#include "devices-imx53.h"
+
+#define SMD_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
+
+static iomux_v3_cfg_t mx53_smd_pads[] = {
+	MX53_PAD_CSI0_D10__UART1_TXD,
+	MX53_PAD_CSI0_D11__UART1_RXD,
+	MX53_PAD_ATA_DIOW__UART1_TXD,
+	MX53_PAD_ATA_DMACK__UART1_RXD,
+
+	MX53_PAD_ATA_BUFFER_EN__UART2_RXD,
+	MX53_PAD_ATA_DMARQ__UART2_TXD,
+	MX53_PAD_ATA_DIOR__UART2_RTS,
+	MX53_PAD_ATA_INTRQ__UART2_CTS,
+
+	MX53_PAD_ATA_CS_0__UART3_TXD,
+	MX53_PAD_ATA_CS_1__UART3_RXD,
+	MX53_PAD_ATA_DA_1__UART3_CTS,
+	MX53_PAD_ATA_DA_2__UART3_RTS,
+};
+
+static const struct imxuart_platform_data mx53_smd_uart_data __initconst = {
+	.flags = IMXUART_HAVE_RTSCTS,
+};
+
+static inline void mx53_smd_init_uart(void)
+{
+	imx53_add_imx_uart(0, &mx53_smd_uart_data);
+	imx53_add_imx_uart(1, &mx53_smd_uart_data);
+	imx53_add_imx_uart(2, &mx53_smd_uart_data);
+}
+
+static inline void mx53_smd_fec_reset(void)
+{
+	int ret;
+
+	/* reset FEC PHY */
+	ret = gpio_request(SMD_FEC_PHY_RST, "fec-phy-reset");
+	if (ret) {
+		printk(KERN_ERR"failed to get GPIO_FEC_PHY_RESET: %d\n", ret);
+		return;
+	}
+	gpio_direction_output(SMD_FEC_PHY_RST, 0);
+	msleep(1);
+	gpio_set_value(SMD_FEC_PHY_RST, 1);
+}
+
+static struct fec_platform_data mx53_smd_fec_data = {
+	.phy = PHY_INTERFACE_MODE_RMII,
+};
+
+static void __init mx53_smd_board_init(void)
+{
+	mxc_iomux_v3_setup_multiple_pads(mx53_smd_pads,
+					ARRAY_SIZE(mx53_smd_pads));
+	mx53_smd_init_uart();
+	mx53_smd_fec_reset();
+	imx53_add_fec(&mx53_smd_fec_data);
+}
+
+static void __init mx53_smd_timer_init(void)
+{
+	mx53_clocks_init(32768, 24000000, 22579200, 0);
+}
+
+static struct sys_timer mx53_smd_timer = {
+	.init	= mx53_smd_timer_init,
+};
+
+MACHINE_START(MX53_SMD, "Freescale MX53 SMD Board")
+	.map_io = mx53_map_io,
+	.init_irq = mx53_init_irq,
+	.init_machine = mx53_smd_board_init,
+	.timer = &mx53_smd_timer,
+MACHINE_END
-- 
1.7.1
