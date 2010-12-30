From: yong.shen@freescale.com (yong.shen at freescale.com)
Date: Thu, 30 Dec 2010 13:28:01 +0800
Subject: [PATCH v2 2/2] ARM i.MX53: Make MX53 EVK bootable
In-Reply-To: <1293686881-15046-1-git-send-email-yong.shen@freescale.com>
References: <1293686881-15046-1-git-send-email-yong.shen@freescale.com>
Message-ID: <1293686881-15046-3-git-send-email-yong.shen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yong Shen <yong.shen@linaro.org>

1. Add entries to Kconfig
2. Add machine definition
3. Add Uart platform data, pad setting and base address
4. Adjust GPIO irq number

Signed-off-by: Yong Shen <yong.shen@linaro.org>
---
 arch/arm/mach-mx5/Kconfig                     |   17 +++++
 arch/arm/mach-mx5/Makefile                    |    1 +
 arch/arm/mach-mx5/Makefile.boot               |    9 ++-
 arch/arm/mach-mx5/board-mx53_evk.c            |   90 +++++++++++++++++++++++++
 arch/arm/mach-mx5/devices-imx53.h             |   13 ++++
 arch/arm/plat-mxc/devices/platform-imx-uart.c |   10 +++
 arch/arm/plat-mxc/include/mach/iomux-mx53.h   |   20 ++++++
 arch/arm/plat-mxc/include/mach/irqs.h         |    4 +-
 arch/arm/plat-mxc/include/mach/uncompress.h   |    4 +
 9 files changed, 164 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-mx5/board-mx53_evk.c
 create mode 100644 arch/arm/mach-mx5/devices-imx53.h

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 5011f42..97ac558 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -4,6 +4,9 @@ if ARCH_MX5
 config ARCH_MX51
 	bool
 
+config ARCH_MX53
+	bool
+
 config	SOC_IMX51
 	bool
 	select MXC_TZIC
@@ -12,6 +15,12 @@ config	SOC_IMX51
 	select ARCH_HAS_CPUFREQ
 	select ARCH_MX51
 
+config	SOC_IMX53
+	bool
+	select MXC_TZIC
+	select ARCH_MXC_IOMUX_V3
+	select ARCH_MX53
+
 comment "MX5 platforms:"
 
 config MACH_MX51_BABBAGE
@@ -100,4 +109,12 @@ config MACH_MX51_EFIKAMX
 	  Include support for Genesi Efika MX nettop. This includes specific
 	  configurations for the board and its peripherals.
 
+config MACH_MX53_EVK
+	bool "Support MX53 EVK platforms"
+	select SOC_IMX53
+	select IMX_HAVE_PLATFORM_IMX_UART
+	help
+	  Include support for MX53 EVK platform. This includes specific
+	  configurations for the board and its peripherals.
+
 endif
diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
index 026cd85..d631a4d 100644
--- a/arch/arm/mach-mx5/Makefile
+++ b/arch/arm/mach-mx5/Makefile
@@ -8,6 +8,7 @@ obj-y   := cpu.o mm.o clock-mx51-mx53.o devices.o
 obj-$(CONFIG_CPU_FREQ_IMX)    += cpu_op-mx51.o
 obj-$(CONFIG_MACH_MX51_BABBAGE) += board-mx51_babbage.o
 obj-$(CONFIG_MACH_MX51_3DS) += board-mx51_3ds.o
+obj-$(CONFIG_MACH_MX53_EVK) += board-mx53_evk.o
 obj-$(CONFIG_MACH_EUKREA_CPUIMX51) += board-cpuimx51.o
 obj-$(CONFIG_MACH_EUKREA_MBIMX51_BASEBOARD) += eukrea_mbimx51-baseboard.o
 obj-$(CONFIG_MACH_EUKREA_CPUIMX51SD) += board-cpuimx51sd.o
diff --git a/arch/arm/mach-mx5/Makefile.boot b/arch/arm/mach-mx5/Makefile.boot
index 9939a19..845aa01 100644
--- a/arch/arm/mach-mx5/Makefile.boot
+++ b/arch/arm/mach-mx5/Makefile.boot
@@ -1,3 +1,6 @@
-   zreladdr-y	:= 0x90008000
-params_phys-y	:= 0x90000100
-initrd_phys-y	:= 0x90800000
+   zreladdr-$(CONFIG_SOC_IMX51)        := 0x90008000
+params_phys-$(CONFIG_SOC_IMX51)        := 0x90000100
+initrd_phys-$(CONFIG_SOC_IMX51)        := 0x90800000
+   zreladdr-$(CONFIG_SOC_IMX53)        := 0x70008000
+params_phys-$(CONFIG_SOC_IMX53)        := 0x70000100
+initrd_phys-$(CONFIG_SOC_IMX53)        := 0x70800000
diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
new file mode 100644
index 0000000..84ff63a
--- /dev/null
+++ b/arch/arm/mach-mx5/board-mx53_evk.c
@@ -0,0 +1,90 @@
+/*
+ * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright (C) 2010 Yong Shen. <Yong.Shen@linaro.org>
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
+#include <mach/common.h>
+#include <mach/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+#include <mach/imx-uart.h>
+#include <mach/iomux-mx53.h>
+
+#include "crm_regs.h"
+#include "devices-imx53.h"
+
+static iomux_v3_cfg_t mx53evk_pads[] = {
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
+#if defined(CONFIG_SERIAL_IMX) || defined(CONFIG_SERIAL_IMX_MODULE)
+static const struct imxuart_platform_data uart_pdata __initconst = {
+	.flags = IMXUART_HAVE_RTSCTS,
+};
+
+static inline void mxc_init_imx_uart(void)
+{
+	imx53_add_imx_uart(0, &uart_pdata);
+	imx53_add_imx_uart(1, &uart_pdata);
+	imx53_add_imx_uart(2, &uart_pdata);
+}
+#else /* !SERIAL_IMX */
+static inline void mxc_init_imx_uart(void)
+{
+}
+#endif /* SERIAL_IMX */
+
+static void __init mxc_board_init(void)
+{
+	mxc_iomux_v3_setup_multiple_pads(mx53evk_pads,
+					ARRAY_SIZE(mx53evk_pads));
+	mxc_init_imx_uart();
+}
+
+static void __init mx53_evk_timer_init(void)
+{
+	mx53_clocks_init(32768, 24000000, 22579200, 0);
+}
+
+static struct sys_timer mxc_timer = {
+	.init	= mx53_evk_timer_init,
+};
+
+MACHINE_START(MX53_EVK, "Freescale MX53 EVK Board")
+	.map_io = mx53_map_io,
+	.init_irq = mx53_init_irq,
+	.init_machine = mxc_board_init,
+	.timer = &mxc_timer,
+MACHINE_END
diff --git a/arch/arm/mach-mx5/devices-imx53.h b/arch/arm/mach-mx5/devices-imx53.h
new file mode 100644
index 0000000..9d0ec25
--- /dev/null
+++ b/arch/arm/mach-mx5/devices-imx53.h
@@ -0,0 +1,13 @@
+/*
+ * Copyright (C) 2010 Yong Shen. <Yong.Shen@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <mach/mx53.h>
+#include <mach/devices-common.h>
+
+extern const struct imx_imx_uart_1irq_data imx53_imx_uart_data[] __initconst;
+#define imx53_add_imx_uart(id, pdata)	\
+	imx_add_imx_uart_1irq(&imx53_imx_uart_data[id], pdata)
diff --git a/arch/arm/plat-mxc/devices/platform-imx-uart.c b/arch/arm/plat-mxc/devices/platform-imx-uart.c
index 7b45b78..3367706 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-uart.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-uart.c
@@ -104,6 +104,16 @@ const struct imx_imx_uart_1irq_data imx51_imx_uart_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_SOC_IMX51 */
 
+#ifdef CONFIG_SOC_IMX53
+const struct imx_imx_uart_1irq_data imx53_imx_uart_data[] __initconst = {
+#define imx53_imx_uart_data_entry(_id, _hwid)				\
+	imx_imx_uart_1irq_data_entry(MX53, _id, _hwid, SZ_4K)
+	imx53_imx_uart_data_entry(0, 1),
+	imx53_imx_uart_data_entry(1, 2),
+	imx53_imx_uart_data_entry(2, 3),
+};
+#endif /* ifdef CONFIG_SOC_IMX53 */
+
 struct platform_device *__init imx_add_imx_uart_3irq(
 		const struct imx_imx_uart_3irq_data *data,
 		const struct imxuart_platform_data *pdata)
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx53.h b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
index 80cb3c5..5deee01 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx53.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
@@ -42,6 +42,26 @@ typedef enum iomux_config {
 #define NON_MUX_I	0x00
 #define NON_PAD_I	0x00
 
+#define MX53_UART_PAD_CTRL		(PAD_CTL_PKE | PAD_CTL_PUE |	\
+		PAD_CTL_DSE_HIGH | PAD_CTL_SRE_FAST | PAD_CTL_HYS)
+/* UART1 */
+#define MX53_PAD_CSI0_D10__UART1_TXD	IOMUX_PAD(0x414, 0xE8, 2, 0x0, 0, MX53_UART_PAD_CTRL)
+#define MX53_PAD_CSI0_D11__UART1_RXD	IOMUX_PAD(0x418, 0xEC, 2, 0x878, 1, MX53_UART_PAD_CTRL)
+#define MX53_PAD_ATA_DIOW__UART1_TXD	IOMUX_PAD(0x5F0, 0x270, 3, 0x0,	0, MX53_UART_PAD_CTRL)
+#define MX53_PAD_ATA_DMACK__UART1_RXD	IOMUX_PAD(0x5F4, 0x274, 3, 0x880, 3, MX53_UART_PAD_CTRL)
+
+/* UART2 */
+#define MX53_PAD_ATA_BUFFER_EN__UART2_RXD	IOMUX_PAD(0x5FC, 0x27C, 3, 0x880, 3, MX53_UART_PAD_CTRL)
+#define MX53_PAD_ATA_DMARQ__UART2_TXD	IOMUX_PAD(0x5F8, 0x278, 3, 0x0, 0, MX53_UART_PAD_CTRL)
+#define MX53_PAD_ATA_DIOR__UART2_RTS	IOMUX_PAD(0x604, 0x284, 3, 0x87C, 3, MX53_UART_PAD_CTRL)
+#define MX53_PAD_ATA_INTRQ__UART2_CTS	IOMUX_PAD(0x600, 0x280, 3, 0x0, 0, MX53_UART_PAD_CTRL)
+
+/* UART3 */
+#define MX53_PAD_ATA_CS_0__UART3_TXD	IOMUX_PAD(0x61C, 0x29C, 4, 0x0, 0, MX53_UART_PAD_CTRL)
+#define MX53_PAD_ATA_CS_1__UART3_RXD	IOMUX_PAD(0x620, 0x2A0, 4, 0x888, 3, MX53_UART_PAD_CTRL)
+#define MX53_PAD_ATA_DA_1__UART3_CTS	IOMUX_PAD(0x614, 0x294, 4, 0x0, 0, MX53_UART_PAD_CTRL)
+#define MX53_PAD_ATA_DA_2__UART3_RTS	IOMUX_PAD(0x618, 0x298, 4, 0x884, 5, MX53_UART_PAD_CTRL)
+
 #define MX53_PAD_GPIO_19__GPIO_4_5		IOMUX_PAD(0x348, 0x20,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
 #define MX53_PAD_KEY_COL0__GPIO_4_6		IOMUX_PAD(0x34C, 0x24,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
 #define MX53_PAD_KEY_ROW0__GPIO_4_7		IOMUX_PAD(0x350, 0x28,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
index 86781f7..8f11cfa 100644
--- a/arch/arm/plat-mxc/include/mach/irqs.h
+++ b/arch/arm/plat-mxc/include/mach/irqs.h
@@ -29,8 +29,10 @@
 #define MXC_GPIO_IRQS		(32 * 4)
 #elif defined CONFIG_ARCH_MX25
 #define MXC_GPIO_IRQS		(32 * 4)
-#elif defined CONFIG_ARCH_MX5
+#elif defined CONFIG_ARCH_MX51
 #define MXC_GPIO_IRQS		(32 * 4)
+#elif defined CONFIG_ARCH_MX53
+#define MXC_GPIO_IRQS		(32 * 7)
 #elif defined CONFIG_ARCH_MXC91231
 #define MXC_GPIO_IRQS		(32 * 4)
 #elif defined CONFIG_ARCH_MX3
diff --git a/arch/arm/plat-mxc/include/mach/uncompress.h b/arch/arm/plat-mxc/include/mach/uncompress.h
index 9dd9c20..ff034e0 100644
--- a/arch/arm/plat-mxc/include/mach/uncompress.h
+++ b/arch/arm/plat-mxc/include/mach/uncompress.h
@@ -63,6 +63,7 @@ static inline void flush(void)
 #define MX3X_UART1_BASE_ADDR	0x43F90000
 #define MX3X_UART2_BASE_ADDR	0x43F94000
 #define MX51_UART1_BASE_ADDR	0x73fbc000
+#define MX53_UART1_BASE_ADDR	0x53fbc000
 
 static __inline__ void __arch_decomp_setup(unsigned long arch_id)
 {
@@ -102,6 +103,9 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
 	case MACH_TYPE_EUKREA_CPUIMX51SD:
 		uart_base = MX51_UART1_BASE_ADDR;
 		break;
+	case MACH_TYPE_MX53_EVK:
+		uart_base = MX53_UART1_BASE_ADDR;
+		break;
 	default:
 		break;
 	}
-- 
1.7.0.4
