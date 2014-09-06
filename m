From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  6 Sep 2014 08:34:42 +0400
Subject: [PATCH 3/4] ARM: i.MX: Remove i.MX1 non-DT support
In-Reply-To: <1409978083-20047-1-git-send-email-shc_work@mail.ru>
References: <1409978083-20047-1-git-send-email-shc_work@mail.ru>
Message-ID: <1409978083-20047-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes registration helpers and support files,
used for non-DT i.MX1 targets.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/Kconfig                     |   1 -
 arch/arm/mach-imx/Makefile                    |   2 +-
 arch/arm/mach-imx/clk-imx1.c                  |  49 ++------
 arch/arm/mach-imx/common.h                    |   5 -
 arch/arm/mach-imx/devices-imx1.h              |  30 -----
 arch/arm/mach-imx/devices/devices-common.h    |  12 --
 arch/arm/mach-imx/devices/platform-imx-fb.c   |   5 -
 arch/arm/mach-imx/devices/platform-imx-i2c.c  |   5 -
 arch/arm/mach-imx/devices/platform-imx-uart.c |  37 ------
 arch/arm/mach-imx/devices/platform-spi_imx.c  |   9 --
 arch/arm/mach-imx/hardware.h                  |   1 -
 arch/arm/mach-imx/imx1-dt.c                   |  23 +++-
 arch/arm/mach-imx/iomux-mx1.h                 | 155 -----------------------
 arch/arm/mach-imx/mm-imx1.c                   |  67 ----------
 arch/arm/mach-imx/mx1.h                       | 172 --------------------------
 15 files changed, 29 insertions(+), 544 deletions(-)
 delete mode 100644 arch/arm/mach-imx/devices-imx1.h
 delete mode 100644 arch/arm/mach-imx/iomux-mx1.h
 delete mode 100644 arch/arm/mach-imx/mm-imx1.c
 delete mode 100644 arch/arm/mach-imx/mx1.h

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 41a5753..6333d30 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -67,7 +67,6 @@ config ARCH_MXC_IOMUX_V3
 config SOC_IMX1
 	bool
 	select CPU_ARM920T
-	select IMX_HAVE_IOMUX_V1
 	select MXC_AVIC
 	select PINCTRL_IMX1
 
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 6a9c897..ce7e05fb 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -1,6 +1,6 @@
 obj-y := time.o cpu.o system.o irq-common.o
 
-obj-$(CONFIG_SOC_IMX1) += clk-imx1.o mm-imx1.o
+obj-$(CONFIG_SOC_IMX1) += clk-imx1.o
 obj-$(CONFIG_SOC_IMX21) += clk-imx21.o mm-imx21.o
 
 obj-$(CONFIG_SOC_IMX25) += clk-imx25.o mm-imx25.o ehci-imx25.o cpu-imx25.o
diff --git a/arch/arm/mach-imx/clk-imx1.c b/arch/arm/mach-imx/clk-imx1.c
index 37c307a..12b2a57 100644
--- a/arch/arm/mach-imx/clk-imx1.c
+++ b/arch/arm/mach-imx/clk-imx1.c
@@ -26,7 +26,6 @@
 
 #include "clk.h"
 #include "common.h"
-#include "hardware.h"
 
 static const char *prem_sel_clks[] = { "clk32_premult", "clk16m", };
 static const char *clko_sel_clks[] = { "per1", "hclk", "clk48m", "clk16m",
@@ -35,17 +34,21 @@ static const char *clko_sel_clks[] = { "per1", "hclk", "clk48m", "clk16m",
 static struct clk *clk[IMX1_CLK_MAX];
 static struct clk_onecell_data clk_data;
 
-static void __iomem *ccm __initdata;
 #define CCM_CSCR	(ccm + 0x0000)
 #define CCM_MPCTL0	(ccm + 0x0004)
 #define CCM_SPCTL0	(ccm + 0x000c)
 #define CCM_PCDR	(ccm + 0x0020)
 #define SCM_GCCR	(ccm + 0x0810)
 
-static void __init _mx1_clocks_init(unsigned long fref)
+static void __init mx1_clocks_init_dt(struct device_node *np)
 {
+	void __iomem *ccm;
+
+	ccm = of_iomap(np, 0);
+	BUG_ON(!ccm);
+
 	clk[IMX1_CLK_DUMMY] = imx_clk_fixed("dummy", 0);
-	clk[IMX1_CLK_CLK32] = imx_obtain_fixed_clock("clk32", fref);
+	clk[IMX1_CLK_CLK32] = imx_obtain_fixed_clock("clk32", 32768);
 	clk[IMX1_CLK_CLK16M_EXT] = imx_clk_fixed("clk16m_ext", 16000000);
 	clk[IMX1_CLK_CLK16M] = imx_clk_gate("clk16m", "clk16m_ext", CCM_CSCR, 17);
 	clk[IMX1_CLK_CLK32_PREMULT] = imx_clk_fixed_factor("clk32_premult", "clk32", 512, 1);
@@ -71,44 +74,6 @@ static void __init _mx1_clocks_init(unsigned long fref)
 	clk[IMX1_CLK_USBD_GATE] = imx_clk_gate("usbd_gate", "clk48m", SCM_GCCR, 0);
 
 	imx_check_clocks(clk, ARRAY_SIZE(clk));
-}
-
-int __init mx1_clocks_init(unsigned long fref)
-{
-	ccm = MX1_IO_ADDRESS(MX1_CCM_BASE_ADDR);
-
-	_mx1_clocks_init(fref);
-
-	clk_register_clkdev(clk[IMX1_CLK_PER1], "per", "imx-gpt.0");
-	clk_register_clkdev(clk[IMX1_CLK_HCLK], "ipg", "imx-gpt.0");
-	clk_register_clkdev(clk[IMX1_CLK_DMA_GATE], "ahb", "imx1-dma");
-	clk_register_clkdev(clk[IMX1_CLK_HCLK], "ipg", "imx1-dma");
-	clk_register_clkdev(clk[IMX1_CLK_PER1], "per", "imx1-uart.0");
-	clk_register_clkdev(clk[IMX1_CLK_HCLK], "ipg", "imx1-uart.0");
-	clk_register_clkdev(clk[IMX1_CLK_PER1], "per", "imx1-uart.1");
-	clk_register_clkdev(clk[IMX1_CLK_HCLK], "ipg", "imx1-uart.1");
-	clk_register_clkdev(clk[IMX1_CLK_PER1], "per", "imx1-uart.2");
-	clk_register_clkdev(clk[IMX1_CLK_UART3_GATE], "ipg", "imx1-uart.2");
-	clk_register_clkdev(clk[IMX1_CLK_HCLK], NULL, "imx1-i2c.0");
-	clk_register_clkdev(clk[IMX1_CLK_PER2], "per", "imx1-cspi.0");
-	clk_register_clkdev(clk[IMX1_CLK_DUMMY], "ipg", "imx1-cspi.0");
-	clk_register_clkdev(clk[IMX1_CLK_PER2], "per", "imx1-cspi.1");
-	clk_register_clkdev(clk[IMX1_CLK_DUMMY], "ipg", "imx1-cspi.1");
-	clk_register_clkdev(clk[IMX1_CLK_PER2], "per", "imx1-fb.0");
-	clk_register_clkdev(clk[IMX1_CLK_DUMMY], "ipg", "imx1-fb.0");
-	clk_register_clkdev(clk[IMX1_CLK_DUMMY], "ahb", "imx1-fb.0");
-
-	mxc_timer_init(MX1_IO_ADDRESS(MX1_TIM1_BASE_ADDR), MX1_TIM1_INT);
-
-	return 0;
-}
-
-static void __init mx1_clocks_init_dt(struct device_node *np)
-{
-	ccm = of_iomap(np, 0);
-	BUG_ON(!ccm);
-
-	_mx1_clocks_init(32768);
 
 	clk_data.clks = clk;
 	clk_data.clk_num = ARRAY_SIZE(clk);
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 1dabf43..df7a633 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -21,13 +21,11 @@ struct device_node;
 enum mxc_cpu_pwr_mode;
 struct of_device_id;
 
-void mx1_map_io(void);
 void mx21_map_io(void);
 void mx25_map_io(void);
 void mx27_map_io(void);
 void mx31_map_io(void);
 void mx35_map_io(void);
-void imx1_init_early(void);
 void imx21_init_early(void);
 void imx25_init_early(void);
 void imx27_init_early(void);
@@ -35,13 +33,11 @@ void imx31_init_early(void);
 void imx35_init_early(void);
 void mxc_init_irq(void __iomem *);
 void tzic_init_irq(void);
-void mx1_init_irq(void);
 void mx21_init_irq(void);
 void mx25_init_irq(void);
 void mx27_init_irq(void);
 void mx31_init_irq(void);
 void mx35_init_irq(void);
-void imx1_soc_init(void);
 void imx21_soc_init(void);
 void imx25_soc_init(void);
 void imx27_soc_init(void);
@@ -49,7 +45,6 @@ void imx31_soc_init(void);
 void imx35_soc_init(void);
 void epit_timer_init(void __iomem *base, int irq);
 void mxc_timer_init(void __iomem *, int);
-int mx1_clocks_init(unsigned long fref);
 int mx21_clocks_init(unsigned long lref, unsigned long fref);
 int mx25_clocks_init(void);
 int mx27_clocks_init(unsigned long fref);
diff --git a/arch/arm/mach-imx/devices-imx1.h b/arch/arm/mach-imx/devices-imx1.h
deleted file mode 100644
index f9b5afc..0000000
--- a/arch/arm/mach-imx/devices-imx1.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * Copyright (C) 2010 Pengutronix
- * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
- *
- * This program is free software; you can redistribute it and/or modify it under
- * the terms of the GNU General Public License version 2 as published by the
- * Free Software Foundation.
- */
-#include "devices/devices-common.h"
-
-extern const struct imx_imx_fb_data imx1_imx_fb_data;
-#define imx1_add_imx_fb(pdata) \
-    imx_add_imx_fb(&imx1_imx_fb_data, pdata)
-
-extern const struct imx_imx_i2c_data imx1_imx_i2c_data;
-#define imx1_add_imx_i2c(pdata)		\
-	imx_add_imx_i2c(&imx1_imx_i2c_data, pdata)
-
-extern const struct imx_imx_uart_3irq_data imx1_imx_uart_data[];
-#define imx1_add_imx_uart(id, pdata)	\
-	imx_add_imx_uart_3irq(&imx1_imx_uart_data[id], pdata)
-#define imx1_add_imx_uart0(pdata)	imx1_add_imx_uart(0, pdata)
-#define imx1_add_imx_uart1(pdata)	imx1_add_imx_uart(1, pdata)
-
-extern const struct imx_spi_imx_data imx1_cspi_data[];
-#define imx1_add_cspi(id, pdata)   \
-	imx_add_spi_imx(&imx1_cspi_data[id], pdata)
-
-#define imx1_add_spi_imx0(pdata) imx1_add_cspi(0, pdata)
-#define imx1_add_spi_imx1(pdata) imx1_add_cspi(1, pdata)
diff --git a/arch/arm/mach-imx/devices/devices-common.h b/arch/arm/mach-imx/devices/devices-common.h
index 67f7fb1..7edc8cc0 100644
--- a/arch/arm/mach-imx/devices/devices-common.h
+++ b/arch/arm/mach-imx/devices/devices-common.h
@@ -154,18 +154,6 @@ struct platform_device *__init imx_add_imx_ssi(
 		const struct imx_ssi_platform_data *pdata);
 
 #include <linux/platform_data/serial-imx.h>
-struct imx_imx_uart_3irq_data {
-	int id;
-	resource_size_t iobase;
-	resource_size_t iosize;
-	resource_size_t irqrx;
-	resource_size_t irqtx;
-	resource_size_t irqrts;
-};
-struct platform_device *__init imx_add_imx_uart_3irq(
-		const struct imx_imx_uart_3irq_data *data,
-		const struct imxuart_platform_data *pdata);
-
 struct imx_imx_uart_1irq_data {
 	int id;
 	resource_size_t iobase;
diff --git a/arch/arm/mach-imx/devices/platform-imx-fb.c b/arch/arm/mach-imx/devices/platform-imx-fb.c
index 25a47c6..07bbd26 100644
--- a/arch/arm/mach-imx/devices/platform-imx-fb.c
+++ b/arch/arm/mach-imx/devices/platform-imx-fb.c
@@ -19,11 +19,6 @@
 		.irq = soc ## _INT_LCDC,				\
 	}
 
-#ifdef CONFIG_SOC_IMX1
-const struct imx_imx_fb_data imx1_imx_fb_data __initconst =
-	imx_imx_fb_data_entry_single(MX1, "imx1-fb", SZ_4K);
-#endif /* ifdef CONFIG_SOC_IMX1 */
-
 #ifdef CONFIG_SOC_IMX21
 const struct imx_imx_fb_data imx21_imx_fb_data __initconst =
 	imx_imx_fb_data_entry_single(MX21, "imx21-fb", SZ_4K);
diff --git a/arch/arm/mach-imx/devices/platform-imx-i2c.c b/arch/arm/mach-imx/devices/platform-imx-i2c.c
index 644ac26..010fc75 100644
--- a/arch/arm/mach-imx/devices/platform-imx-i2c.c
+++ b/arch/arm/mach-imx/devices/platform-imx-i2c.c
@@ -21,11 +21,6 @@
 #define imx_imx_i2c_data_entry(soc, _devid, _id, _hwid, _size)		\
 	[_id] = imx_imx_i2c_data_entry_single(soc, _devid, _id, _hwid, _size)
 
-#ifdef CONFIG_SOC_IMX1
-const struct imx_imx_i2c_data imx1_imx_i2c_data __initconst =
-	imx_imx_i2c_data_entry_single(MX1, "imx1-i2c", 0, , SZ_4K);
-#endif /* ifdef CONFIG_SOC_IMX1 */
-
 #ifdef CONFIG_SOC_IMX21
 const struct imx_imx_i2c_data imx21_imx_i2c_data __initconst =
 	imx_imx_i2c_data_entry_single(MX21, "imx21-i2c", 0, , SZ_4K);
diff --git a/arch/arm/mach-imx/devices/platform-imx-uart.c b/arch/arm/mach-imx/devices/platform-imx-uart.c
index 8c01836..97f1c95 100644
--- a/arch/arm/mach-imx/devices/platform-imx-uart.c
+++ b/arch/arm/mach-imx/devices/platform-imx-uart.c
@@ -27,15 +27,6 @@
 		.irq = soc ## _INT_UART ## _hwid,			\
 	}
 
-#ifdef CONFIG_SOC_IMX1
-const struct imx_imx_uart_3irq_data imx1_imx_uart_data[] __initconst = {
-#define imx1_imx_uart_data_entry(_id, _hwid)				\
-	imx_imx_uart_3irq_data_entry(MX1, _id, _hwid, 0xd0)
-	imx1_imx_uart_data_entry(0, 1),
-	imx1_imx_uart_data_entry(1, 2),
-};
-#endif /* ifdef CONFIG_SOC_IMX1 */
-
 #ifdef CONFIG_SOC_IMX21
 const struct imx_imx_uart_1irq_data imx21_imx_uart_data[] __initconst = {
 #define imx21_imx_uart_data_entry(_id, _hwid)				\
@@ -94,34 +85,6 @@ const struct imx_imx_uart_1irq_data imx35_imx_uart_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_SOC_IMX35 */
 
-struct platform_device *__init imx_add_imx_uart_3irq(
-		const struct imx_imx_uart_3irq_data *data,
-		const struct imxuart_platform_data *pdata)
-{
-	struct resource res[] = {
-		{
-			.start = data->iobase,
-			.end = data->iobase + data->iosize - 1,
-			.flags = IORESOURCE_MEM,
-		}, {
-			.start = data->irqrx,
-			.end = data->irqrx,
-			.flags = IORESOURCE_IRQ,
-		}, {
-			.start = data->irqtx,
-			.end = data->irqtx,
-			.flags = IORESOURCE_IRQ,
-		}, {
-			.start = data->irqrts,
-			.end = data->irqrx,
-			.flags = IORESOURCE_IRQ,
-		},
-	};
-
-	return imx_add_platform_device("imx1-uart", data->id, res,
-			ARRAY_SIZE(res), pdata, sizeof(*pdata));
-}
-
 struct platform_device *__init imx_add_imx_uart_1irq(
 		const struct imx_imx_uart_1irq_data *data,
 		const struct imxuart_platform_data *pdata)
diff --git a/arch/arm/mach-imx/devices/platform-spi_imx.c b/arch/arm/mach-imx/devices/platform-spi_imx.c
index aca825d..62cd5d4 100644
--- a/arch/arm/mach-imx/devices/platform-spi_imx.c
+++ b/arch/arm/mach-imx/devices/platform-spi_imx.c
@@ -21,15 +21,6 @@
 #define imx_spi_imx_data_entry(soc, type, devid, id, hwid, size)	\
 	[id] = imx_spi_imx_data_entry_single(soc, type, devid, id, hwid, size)
 
-#ifdef CONFIG_SOC_IMX1
-const struct imx_spi_imx_data imx1_cspi_data[] __initconst = {
-#define imx1_cspi_data_entry(_id, _hwid) \
-	imx_spi_imx_data_entry(MX1, CSPI, "imx1-cspi", _id, _hwid, SZ_4K)
-	imx1_cspi_data_entry(0, 1),
-	imx1_cspi_data_entry(1, 2),
-};
-#endif
-
 #ifdef CONFIG_SOC_IMX21
 const struct imx_spi_imx_data imx21_cspi_data[] __initconst = {
 #define imx21_cspi_data_entry(_id, _hwid)                            \
diff --git a/arch/arm/mach-imx/hardware.h b/arch/arm/mach-imx/hardware.h
index 66b2b56..32935bf 100644
--- a/arch/arm/mach-imx/hardware.h
+++ b/arch/arm/mach-imx/hardware.h
@@ -111,7 +111,6 @@
 #include "mx2x.h"
 #include "mx21.h"
 #include "mx27.h"
-#include "mx1.h"
 #include "mx25.h"
 
 #define imx_map_entry(soc, name, _type)	{				\
diff --git a/arch/arm/mach-imx/imx1-dt.c b/arch/arm/mach-imx/imx1-dt.c
index 6f915b0..de5ab8d 100644
--- a/arch/arm/mach-imx/imx1-dt.c
+++ b/arch/arm/mach-imx/imx1-dt.c
@@ -9,8 +9,27 @@
 
 #include <linux/of_platform.h>
 #include <asm/mach/arch.h>
+#include <asm/mach/map.h>
 
 #include "common.h"
+#include "hardware.h"
+
+#define MX1_AVIC_ADDR	0x00223000
+
+static void __init imx1_init_early(void)
+{
+	mxc_set_cpu_type(MXC_CPU_MX1);
+}
+
+static void __init imx1_init_irq(void)
+{
+	void __iomem *avic_addr;
+
+	avic_addr = ioremap(MX1_AVIC_ADDR, SZ_4K);
+	WARN_ON(!avic_addr);
+
+	mxc_init_irq(avic_addr);
+}
 
 static const char * const imx1_dt_board_compat[] __initconst = {
 	"fsl,imx1",
@@ -18,9 +37,9 @@ static const char * const imx1_dt_board_compat[] __initconst = {
 };
 
 DT_MACHINE_START(IMX1_DT, "Freescale i.MX1 (Device Tree Support)")
-	.map_io		= mx1_map_io,
+	.map_io		= debug_ll_io_init,
 	.init_early	= imx1_init_early,
-	.init_irq	= mx1_init_irq,
+	.init_irq	= imx1_init_irq,
 	.dt_compat	= imx1_dt_board_compat,
 	.restart	= mxc_restart,
 MACHINE_END
diff --git a/arch/arm/mach-imx/iomux-mx1.h b/arch/arm/mach-imx/iomux-mx1.h
deleted file mode 100644
index 95f4681..0000000
--- a/arch/arm/mach-imx/iomux-mx1.h
+++ /dev/null
@@ -1,155 +0,0 @@
-/*
- * Copyright (C) 2008 by Sascha Hauer <kernel@pengutronix.de>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- * MA 02110-1301, USA.
- */
-#ifndef __MACH_IOMUX_MX1_H__
-#define __MACH_IOMUX_MX1_H__
-
-#include "iomux-v1.h"
-
-#define PA0_AIN_SPI2_CLK	(GPIO_PORTA | GPIO_AIN | GPIO_OUT | 0)
-#define PA0_AF_ETMTRACESYNC	(GPIO_PORTA | GPIO_AF | 0)
-#define PA1_AOUT_SPI2_RXD	(GPIO_PORTA | GPIO_AOUT | GPIO_IN | 1)
-#define PA1_PF_TIN		(GPIO_PORTA | GPIO_PF | 1)
-#define PA2_PF_PWM0		(GPIO_PORTA | GPIO_PF | GPIO_OUT | 2)
-#define PA3_PF_CSI_MCLK		(GPIO_PORTA | GPIO_PF | 3)
-#define PA4_PF_CSI_D0		(GPIO_PORTA | GPIO_PF | 4)
-#define PA5_PF_CSI_D1		(GPIO_PORTA | GPIO_PF | 5)
-#define PA6_PF_CSI_D2		(GPIO_PORTA | GPIO_PF | 6)
-#define PA7_PF_CSI_D3		(GPIO_PORTA | GPIO_PF | 7)
-#define PA8_PF_CSI_D4		(GPIO_PORTA | GPIO_PF | 8)
-#define PA9_PF_CSI_D5		(GPIO_PORTA | GPIO_PF | 9)
-#define PA10_PF_CSI_D6		(GPIO_PORTA | GPIO_PF | 10)
-#define PA11_PF_CSI_D7		(GPIO_PORTA | GPIO_PF | 11)
-#define PA12_PF_CSI_VSYNC	(GPIO_PORTA | GPIO_PF | 12)
-#define PA13_PF_CSI_HSYNC	(GPIO_PORTA | GPIO_PF | 13)
-#define PA14_PF_CSI_PIXCLK	(GPIO_PORTA | GPIO_PF | 14)
-#define PA15_PF_I2C_SDA		(GPIO_PORTA | GPIO_PF | GPIO_OUT | 15)
-#define PA16_PF_I2C_SCL		(GPIO_PORTA | GPIO_PF | GPIO_OUT | 16)
-#define PA17_AF_ETMTRACEPKT4	(GPIO_PORTA | GPIO_AF | 17)
-#define PA17_AIN_SPI2_SS	(GPIO_PORTA | GPIO_AIN | GPIO_OUT | 17)
-#define PA18_AF_ETMTRACEPKT5	(GPIO_PORTA | GPIO_AF | 18)
-#define PA19_AF_ETMTRACEPKT6	(GPIO_PORTA | GPIO_AF | 19)
-#define PA20_AF_ETMTRACEPKT7	(GPIO_PORTA | GPIO_AF | 20)
-#define PA21_PF_A0		(GPIO_PORTA | GPIO_PF | 21)
-#define PA22_PF_CS4		(GPIO_PORTA | GPIO_PF | 22)
-#define PA23_PF_CS5		(GPIO_PORTA | GPIO_PF | 23)
-#define PA24_PF_A16		(GPIO_PORTA | GPIO_PF | 24)
-#define PA24_AF_ETMTRACEPKT0	(GPIO_PORTA | GPIO_AF | 24)
-#define PA25_PF_A17		(GPIO_PORTA | GPIO_PF | 25)
-#define PA25_AF_ETMTRACEPKT1	(GPIO_PORTA | GPIO_AF | 25)
-#define PA26_PF_A18		(GPIO_PORTA | GPIO_PF | 26)
-#define PA26_AF_ETMTRACEPKT2	(GPIO_PORTA | GPIO_AF | 26)
-#define PA27_PF_A19		(GPIO_PORTA | GPIO_PF | 27)
-#define PA27_AF_ETMTRACEPKT3	(GPIO_PORTA | GPIO_AF | 27)
-#define PA28_PF_A20		(GPIO_PORTA | GPIO_PF | 28)
-#define PA28_AF_ETMPIPESTAT0	(GPIO_PORTA | GPIO_AF | 28)
-#define PA29_PF_A21		(GPIO_PORTA | GPIO_PF | 29)
-#define PA29_AF_ETMPIPESTAT1	(GPIO_PORTA | GPIO_AF | 29)
-#define PA30_PF_A22		(GPIO_PORTA | GPIO_PF | 30)
-#define PA30_AF_ETMPIPESTAT2	(GPIO_PORTA | GPIO_AF | 30)
-#define PA31_PF_A23		(GPIO_PORTA | GPIO_PF | 31)
-#define PA31_AF_ETMTRACECLK	(GPIO_PORTA | GPIO_AF | 31)
-#define PB8_PF_SD_DAT0		(GPIO_PORTB | GPIO_PF | GPIO_PUEN | 8)
-#define PB8_AF_MS_PIO		(GPIO_PORTB | GPIO_AF | 8)
-#define PB9_PF_SD_DAT1		(GPIO_PORTB | GPIO_PF | GPIO_PUEN | 9)
-#define PB9_AF_MS_PI1		(GPIO_PORTB | GPIO_AF | 9)
-#define PB10_PF_SD_DAT2		(GPIO_PORTB | GPIO_PF | GPIO_PUEN | 10)
-#define PB10_AF_MS_SCLKI	(GPIO_PORTB | GPIO_AF | 10)
-#define PB11_PF_SD_DAT3		(GPIO_PORTB | GPIO_PF | 11)
-#define PB11_AF_MS_SDIO		(GPIO_PORTB | GPIO_AF | 11)
-#define PB12_PF_SD_CLK		(GPIO_PORTB | GPIO_PF | 12)
-#define PB12_AF_MS_SCLK0	(GPIO_PORTB | GPIO_AF | 12)
-#define PB13_PF_SD_CMD		(GPIO_PORTB | GPIO_PF | GPIO_PUEN | 13)
-#define PB13_AF_MS_BS		(GPIO_PORTB | GPIO_AF | 13)
-#define PB14_AF_SSI_RXFS	(GPIO_PORTB | GPIO_AF | 14)
-#define PB15_AF_SSI_RXCLK	(GPIO_PORTB | GPIO_AF | 15)
-#define PB16_AF_SSI_RXDAT	(GPIO_PORTB | GPIO_AF | GPIO_IN | 16)
-#define PB17_AF_SSI_TXDAT	(GPIO_PORTB | GPIO_AF | GPIO_OUT | 17)
-#define PB18_AF_SSI_TXFS	(GPIO_PORTB | GPIO_AF | 18)
-#define PB19_AF_SSI_TXCLK	(GPIO_PORTB | GPIO_AF | 19)
-#define PB20_PF_USBD_AFE	(GPIO_PORTB | GPIO_PF | 20)
-#define PB21_PF_USBD_OE		(GPIO_PORTB | GPIO_PF | 21)
-#define PB22_PF_USBD_RCV	(GPIO_PORTB | GPIO_PF | 22)
-#define PB23_PF_USBD_SUSPND	(GPIO_PORTB | GPIO_PF | 23)
-#define PB24_PF_USBD_VP		(GPIO_PORTB | GPIO_PF | 24)
-#define PB25_PF_USBD_VM		(GPIO_PORTB | GPIO_PF | 25)
-#define PB26_PF_USBD_VPO	(GPIO_PORTB | GPIO_PF | 26)
-#define PB27_PF_USBD_VMO	(GPIO_PORTB | GPIO_PF | 27)
-#define PB28_PF_UART2_CTS	(GPIO_PORTB | GPIO_PF | GPIO_OUT | 28)
-#define PB29_PF_UART2_RTS	(GPIO_PORTB | GPIO_PF | GPIO_IN | 29)
-#define PB30_PF_UART2_TXD	(GPIO_PORTB | GPIO_PF | GPIO_OUT | 30)
-#define PB31_PF_UART2_RXD	(GPIO_PORTB | GPIO_PF | GPIO_IN | 31)
-#define PC3_PF_SSI_RXFS		(GPIO_PORTC | GPIO_PF | 3)
-#define PC4_PF_SSI_RXCLK	(GPIO_PORTC | GPIO_PF | 4)
-#define PC5_PF_SSI_RXDAT	(GPIO_PORTC | GPIO_PF | GPIO_IN | 5)
-#define PC6_PF_SSI_TXDAT	(GPIO_PORTC | GPIO_PF | GPIO_OUT | 6)
-#define PC7_PF_SSI_TXFS		(GPIO_PORTC | GPIO_PF | 7)
-#define PC8_PF_SSI_TXCLK	(GPIO_PORTC | GPIO_PF | 8)
-#define PC9_PF_UART1_CTS	(GPIO_PORTC | GPIO_PF | GPIO_OUT | 9)
-#define PC10_PF_UART1_RTS	(GPIO_PORTC | GPIO_PF | GPIO_IN | 10)
-#define PC11_PF_UART1_TXD	(GPIO_PORTC | GPIO_PF | GPIO_OUT | 11)
-#define PC12_PF_UART1_RXD	(GPIO_PORTC | GPIO_PF | GPIO_IN | 12)
-#define PC13_PF_SPI1_SPI_RDY	(GPIO_PORTC | GPIO_PF | 13)
-#define PC14_PF_SPI1_SCLK	(GPIO_PORTC | GPIO_PF | 14)
-#define PC15_PF_SPI1_SS		(GPIO_PORTC | GPIO_PF | 15)
-#define PC16_PF_SPI1_MISO	(GPIO_PORTC | GPIO_PF | 16)
-#define PC17_PF_SPI1_MOSI	(GPIO_PORTC | GPIO_PF | 17)
-#define PC24_BIN_UART3_RI	(GPIO_PORTC | GPIO_BIN | GPIO_OUT | 24)
-#define PC25_BIN_UART3_DSR	(GPIO_PORTC | GPIO_BIN | GPIO_OUT | 25)
-#define PC26_AOUT_UART3_DTR	(GPIO_PORTC | GPIO_AOUT | GPIO_IN | 26)
-#define PC27_BIN_UART3_DCD	(GPIO_PORTC | GPIO_BIN | GPIO_OUT | 27)
-#define PC28_BIN_UART3_CTS	(GPIO_PORTC | GPIO_BIN | GPIO_OUT | 28)
-#define PC29_AOUT_UART3_RTS	(GPIO_PORTC | GPIO_AOUT | GPIO_IN | 29)
-#define PC30_BIN_UART3_TX	(GPIO_PORTC | GPIO_BIN | 30)
-#define PC31_AOUT_UART3_RX	(GPIO_PORTC | GPIO_AOUT | GPIO_IN | 31)
-#define PD6_PF_LSCLK		(GPIO_PORTD | GPIO_PF | GPIO_OUT | 6)
-#define PD7_PF_REV		(GPIO_PORTD | GPIO_PF | 7)
-#define PD7_AF_UART2_DTR	(GPIO_PORTD | GPIO_AF | GPIO_IN | 7)
-#define PD7_AIN_SPI2_SCLK	(GPIO_PORTD | GPIO_AIN | 7)
-#define PD8_PF_CLS		(GPIO_PORTD | GPIO_PF | 8)
-#define PD8_AF_UART2_DCD	(GPIO_PORTD | GPIO_AF | GPIO_OUT | 8)
-#define PD8_AIN_SPI2_SS		(GPIO_PORTD | GPIO_AIN | 8)
-#define PD9_PF_PS		(GPIO_PORTD | GPIO_PF | 9)
-#define PD9_AF_UART2_RI		(GPIO_PORTD | GPIO_AF | GPIO_OUT | 9)
-#define PD9_AOUT_SPI2_RXD	(GPIO_PORTD | GPIO_AOUT | GPIO_IN | 9)
-#define PD10_PF_SPL_SPR		(GPIO_PORTD | GPIO_PF | GPIO_OUT | 10)
-#define PD10_AF_UART2_DSR	(GPIO_PORTD | GPIO_AF | GPIO_OUT | 10)
-#define PD10_AIN_SPI2_TXD	(GPIO_PORTD | GPIO_AIN | GPIO_OUT | 10)
-#define PD11_PF_CONTRAST	(GPIO_PORTD | GPIO_PF | GPIO_OUT | 11)
-#define PD12_PF_ACD_OE		(GPIO_PORTD | GPIO_PF | GPIO_OUT | 12)
-#define PD13_PF_LP_HSYNC	(GPIO_PORTD | GPIO_PF | GPIO_OUT | 13)
-#define PD14_PF_FLM_VSYNC	(GPIO_PORTD | GPIO_PF | GPIO_OUT | 14)
-#define PD15_PF_LD0		(GPIO_PORTD | GPIO_PF | GPIO_OUT | 15)
-#define PD16_PF_LD1		(GPIO_PORTD | GPIO_PF | GPIO_OUT | 16)
-#define PD17_PF_LD2		(GPIO_PORTD | GPIO_PF | GPIO_OUT | 17)
-#define PD18_PF_LD3		(GPIO_PORTD | GPIO_PF | GPIO_OUT | 18)
-#define PD19_PF_LD4		(GPIO_PORTD | GPIO_PF | GPIO_OUT | 19)
-#define PD20_PF_LD5		(GPIO_PORTD | GPIO_PF | GPIO_OUT | 20)
-#define PD21_PF_LD6		(GPIO_PORTD | GPIO_PF | GPIO_OUT | 21)
-#define PD22_PF_LD7		(GPIO_PORTD | GPIO_PF | GPIO_OUT | 22)
-#define PD23_PF_LD8		(GPIO_PORTD | GPIO_PF | GPIO_OUT | 23)
-#define PD24_PF_LD9		(GPIO_PORTD | GPIO_PF | GPIO_OUT | 24)
-#define PD25_PF_LD10		(GPIO_PORTD | GPIO_PF | GPIO_OUT | 25)
-#define PD26_PF_LD11		(GPIO_PORTD | GPIO_PF | GPIO_OUT | 26)
-#define PD27_PF_LD12		(GPIO_PORTD | GPIO_PF | GPIO_OUT | 27)
-#define PD28_PF_LD13		(GPIO_PORTD | GPIO_PF | GPIO_OUT | 28)
-#define PD29_PF_LD14		(GPIO_PORTD | GPIO_PF | GPIO_OUT | 29)
-#define PD30_PF_LD15		(GPIO_PORTD | GPIO_PF | GPIO_OUT | 30)
-#define PD31_PF_TMR2OUT		(GPIO_PORTD | GPIO_PF | 31)
-#define PD31_BIN_SPI2_TXD	(GPIO_PORTD | GPIO_BIN | 31)
-
-#endif /* ifndef __MACH_IOMUX_MX1_H__ */
diff --git a/arch/arm/mach-imx/mm-imx1.c b/arch/arm/mach-imx/mm-imx1.c
deleted file mode 100644
index e065fed..0000000
--- a/arch/arm/mach-imx/mm-imx1.c
+++ /dev/null
@@ -1,67 +0,0 @@
-/*
- *  author: Sascha Hauer
- *  Created: april 20th, 2004
- *  Copyright: Synertronixx GmbH
- *
- *  Common code for i.MX1 machines
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/pinctrl/machine.h>
-
-#include <asm/mach/map.h>
-
-#include "common.h"
-#include "devices/devices-common.h"
-#include "hardware.h"
-#include "iomux-v1.h"
-
-static struct map_desc imx_io_desc[] __initdata = {
-	imx_map_entry(MX1, IO, MT_DEVICE),
-};
-
-void __init mx1_map_io(void)
-{
-	iotable_init(imx_io_desc, ARRAY_SIZE(imx_io_desc));
-}
-
-void __init imx1_init_early(void)
-{
-	mxc_set_cpu_type(MXC_CPU_MX1);
-	imx_iomuxv1_init(MX1_IO_ADDRESS(MX1_GPIO_BASE_ADDR),
-			MX1_NUM_GPIO_PORT);
-}
-
-void __init mx1_init_irq(void)
-{
-	mxc_init_irq(MX1_IO_ADDRESS(MX1_AVIC_BASE_ADDR));
-}
-
-void __init imx1_soc_init(void)
-{
-	mxc_arch_reset_init(MX1_IO_ADDRESS(MX1_WDT_BASE_ADDR));
-	mxc_device_init();
-
-	mxc_register_gpio("imx1-gpio", 0, MX1_GPIO1_BASE_ADDR, SZ_256,
-						MX1_GPIO_INT_PORTA, 0);
-	mxc_register_gpio("imx1-gpio", 1, MX1_GPIO2_BASE_ADDR, SZ_256,
-						MX1_GPIO_INT_PORTB, 0);
-	mxc_register_gpio("imx1-gpio", 2, MX1_GPIO3_BASE_ADDR, SZ_256,
-						MX1_GPIO_INT_PORTC, 0);
-	mxc_register_gpio("imx1-gpio", 3, MX1_GPIO4_BASE_ADDR, SZ_256,
-						MX1_GPIO_INT_PORTD, 0);
-	imx_add_imx_dma("imx1-dma", MX1_DMA_BASE_ADDR,
-			MX1_DMA_INT, MX1_DMA_ERR);
-	pinctrl_provide_dummies();
-}
diff --git a/arch/arm/mach-imx/mx1.h b/arch/arm/mach-imx/mx1.h
deleted file mode 100644
index 45bd31c..0000000
--- a/arch/arm/mach-imx/mx1.h
+++ /dev/null
@@ -1,172 +0,0 @@
-/*
- * Copyright (C) 1997,1998 Russell King
- * Copyright (C) 1999 ARM Limited
- * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
- * Copyright (c) 2008 Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __MACH_MX1_H__
-#define __MACH_MX1_H__
-
-/*
- * Memory map
- */
-#define MX1_IO_BASE_ADDR	0x00200000
-#define MX1_IO_SIZE		SZ_1M
-
-#define MX1_CS0_PHYS		0x10000000
-#define MX1_CS0_SIZE		0x02000000
-
-#define MX1_CS1_PHYS		0x12000000
-#define MX1_CS1_SIZE		0x01000000
-
-#define MX1_CS2_PHYS		0x13000000
-#define MX1_CS2_SIZE		0x01000000
-
-#define MX1_CS3_PHYS		0x14000000
-#define MX1_CS3_SIZE		0x01000000
-
-#define MX1_CS4_PHYS		0x15000000
-#define MX1_CS4_SIZE		0x01000000
-
-#define MX1_CS5_PHYS		0x16000000
-#define MX1_CS5_SIZE		0x01000000
-
-/*
- *  Register BASEs, based on OFFSETs
- */
-#define MX1_AIPI1_BASE_ADDR		(0x00000 + MX1_IO_BASE_ADDR)
-#define MX1_WDT_BASE_ADDR		(0x01000 + MX1_IO_BASE_ADDR)
-#define MX1_TIM1_BASE_ADDR		(0x02000 + MX1_IO_BASE_ADDR)
-#define MX1_TIM2_BASE_ADDR		(0x03000 + MX1_IO_BASE_ADDR)
-#define MX1_RTC_BASE_ADDR		(0x04000 + MX1_IO_BASE_ADDR)
-#define MX1_LCDC_BASE_ADDR		(0x05000 + MX1_IO_BASE_ADDR)
-#define MX1_UART1_BASE_ADDR		(0x06000 + MX1_IO_BASE_ADDR)
-#define MX1_UART2_BASE_ADDR		(0x07000 + MX1_IO_BASE_ADDR)
-#define MX1_PWM_BASE_ADDR		(0x08000 + MX1_IO_BASE_ADDR)
-#define MX1_DMA_BASE_ADDR		(0x09000 + MX1_IO_BASE_ADDR)
-#define MX1_AIPI2_BASE_ADDR		(0x10000 + MX1_IO_BASE_ADDR)
-#define MX1_SIM_BASE_ADDR		(0x11000 + MX1_IO_BASE_ADDR)
-#define MX1_USBD_BASE_ADDR		(0x12000 + MX1_IO_BASE_ADDR)
-#define MX1_CSPI1_BASE_ADDR		(0x13000 + MX1_IO_BASE_ADDR)
-#define MX1_MMC_BASE_ADDR		(0x14000 + MX1_IO_BASE_ADDR)
-#define MX1_ASP_BASE_ADDR		(0x15000 + MX1_IO_BASE_ADDR)
-#define MX1_BTA_BASE_ADDR		(0x16000 + MX1_IO_BASE_ADDR)
-#define MX1_I2C_BASE_ADDR		(0x17000 + MX1_IO_BASE_ADDR)
-#define MX1_SSI_BASE_ADDR		(0x18000 + MX1_IO_BASE_ADDR)
-#define MX1_CSPI2_BASE_ADDR		(0x19000 + MX1_IO_BASE_ADDR)
-#define MX1_MSHC_BASE_ADDR		(0x1A000 + MX1_IO_BASE_ADDR)
-#define MX1_CCM_BASE_ADDR		(0x1B000 + MX1_IO_BASE_ADDR)
-#define MX1_SCM_BASE_ADDR		(0x1B804 + MX1_IO_BASE_ADDR)
-#define MX1_GPIO_BASE_ADDR		(0x1C000 + MX1_IO_BASE_ADDR)
-#define MX1_GPIO1_BASE_ADDR		(0x1C000 + MX1_IO_BASE_ADDR)
-#define MX1_GPIO2_BASE_ADDR		(0x1C100 + MX1_IO_BASE_ADDR)
-#define MX1_GPIO3_BASE_ADDR		(0x1C200 + MX1_IO_BASE_ADDR)
-#define MX1_GPIO4_BASE_ADDR		(0x1C300 + MX1_IO_BASE_ADDR)
-#define MX1_EIM_BASE_ADDR		(0x20000 + MX1_IO_BASE_ADDR)
-#define MX1_SDRAMC_BASE_ADDR		(0x21000 + MX1_IO_BASE_ADDR)
-#define MX1_MMA_BASE_ADDR		(0x22000 + MX1_IO_BASE_ADDR)
-#define MX1_AVIC_BASE_ADDR		(0x23000 + MX1_IO_BASE_ADDR)
-#define MX1_CSI_BASE_ADDR		(0x24000 + MX1_IO_BASE_ADDR)
-
-/* macro to get at IO space when running virtually */
-#define MX1_IO_P2V(x)			IMX_IO_P2V(x)
-#define MX1_IO_ADDRESS(x)		IOMEM(MX1_IO_P2V(x))
-
-/* fixed interrput numbers */
-#include <asm/irq.h>
-#define MX1_INT_SOFTINT		(NR_IRQS_LEGACY + 0)
-#define MX1_INT_CSI		(NR_IRQS_LEGACY + 6)
-#define MX1_DSPA_MAC_INT	(NR_IRQS_LEGACY + 7)
-#define MX1_DSPA_INT		(NR_IRQS_LEGACY + 8)
-#define MX1_COMP_INT		(NR_IRQS_LEGACY + 9)
-#define MX1_MSHC_XINT		(NR_IRQS_LEGACY + 10)
-#define MX1_GPIO_INT_PORTA	(NR_IRQS_LEGACY + 11)
-#define MX1_GPIO_INT_PORTB	(NR_IRQS_LEGACY + 12)
-#define MX1_GPIO_INT_PORTC	(NR_IRQS_LEGACY + 13)
-#define MX1_INT_LCDC		(NR_IRQS_LEGACY + 14)
-#define MX1_SIM_INT		(NR_IRQS_LEGACY + 15)
-#define MX1_SIM_DATA_INT	(NR_IRQS_LEGACY + 16)
-#define MX1_RTC_INT		(NR_IRQS_LEGACY + 17)
-#define MX1_RTC_SAMINT		(NR_IRQS_LEGACY + 18)
-#define MX1_INT_UART2PFERR	(NR_IRQS_LEGACY + 19)
-#define MX1_INT_UART2RTS	(NR_IRQS_LEGACY + 20)
-#define MX1_INT_UART2DTR	(NR_IRQS_LEGACY + 21)
-#define MX1_INT_UART2UARTC	(NR_IRQS_LEGACY + 22)
-#define MX1_INT_UART2TX		(NR_IRQS_LEGACY + 23)
-#define MX1_INT_UART2RX		(NR_IRQS_LEGACY + 24)
-#define MX1_INT_UART1PFERR	(NR_IRQS_LEGACY + 25)
-#define MX1_INT_UART1RTS	(NR_IRQS_LEGACY + 26)
-#define MX1_INT_UART1DTR	(NR_IRQS_LEGACY + 27)
-#define MX1_INT_UART1UARTC	(NR_IRQS_LEGACY + 28)
-#define MX1_INT_UART1TX		(NR_IRQS_LEGACY + 29)
-#define MX1_INT_UART1RX		(NR_IRQS_LEGACY + 30)
-#define MX1_VOICE_DAC_INT	(NR_IRQS_LEGACY + 31)
-#define MX1_VOICE_ADC_INT	(NR_IRQS_LEGACY + 32)
-#define MX1_PEN_DATA_INT	(NR_IRQS_LEGACY + 33)
-#define MX1_PWM_INT		(NR_IRQS_LEGACY + 34)
-#define MX1_SDHC_INT		(NR_IRQS_LEGACY + 35)
-#define MX1_INT_I2C		(NR_IRQS_LEGACY + 39)
-#define MX1_INT_CSPI2		(NR_IRQS_LEGACY + 40)
-#define MX1_INT_CSPI1		(NR_IRQS_LEGACY + 41)
-#define MX1_SSI_TX_INT		(NR_IRQS_LEGACY + 42)
-#define MX1_SSI_TX_ERR_INT	(NR_IRQS_LEGACY + 43)
-#define MX1_SSI_RX_INT		(NR_IRQS_LEGACY + 44)
-#define MX1_SSI_RX_ERR_INT	(NR_IRQS_LEGACY + 45)
-#define MX1_TOUCH_INT		(NR_IRQS_LEGACY + 46)
-#define MX1_INT_USBD0		(NR_IRQS_LEGACY + 47)
-#define MX1_INT_USBD1		(NR_IRQS_LEGACY + 48)
-#define MX1_INT_USBD2		(NR_IRQS_LEGACY + 49)
-#define MX1_INT_USBD3		(NR_IRQS_LEGACY + 50)
-#define MX1_INT_USBD4		(NR_IRQS_LEGACY + 51)
-#define MX1_INT_USBD5		(NR_IRQS_LEGACY + 52)
-#define MX1_INT_USBD6		(NR_IRQS_LEGACY + 53)
-#define MX1_BTSYS_INT		(NR_IRQS_LEGACY + 55)
-#define MX1_BTTIM_INT		(NR_IRQS_LEGACY + 56)
-#define MX1_BTWUI_INT		(NR_IRQS_LEGACY + 57)
-#define MX1_TIM2_INT		(NR_IRQS_LEGACY + 58)
-#define MX1_TIM1_INT		(NR_IRQS_LEGACY + 59)
-#define MX1_DMA_ERR		(NR_IRQS_LEGACY + 60)
-#define MX1_DMA_INT		(NR_IRQS_LEGACY + 61)
-#define MX1_GPIO_INT_PORTD	(NR_IRQS_LEGACY + 62)
-#define MX1_WDT_INT		(NR_IRQS_LEGACY + 63)
-
-/* DMA */
-#define MX1_DMA_REQ_UART3_T		2
-#define MX1_DMA_REQ_UART3_R		3
-#define MX1_DMA_REQ_SSI2_T		4
-#define MX1_DMA_REQ_SSI2_R		5
-#define MX1_DMA_REQ_CSI_STAT		6
-#define MX1_DMA_REQ_CSI_R		7
-#define MX1_DMA_REQ_MSHC		8
-#define MX1_DMA_REQ_DSPA_DCT_DOUT	9
-#define MX1_DMA_REQ_DSPA_DCT_DIN	10
-#define MX1_DMA_REQ_DSPA_MAC		11
-#define MX1_DMA_REQ_EXT			12
-#define MX1_DMA_REQ_SDHC		13
-#define MX1_DMA_REQ_SPI1_R		14
-#define MX1_DMA_REQ_SPI1_T		15
-#define MX1_DMA_REQ_SSI_T		16
-#define MX1_DMA_REQ_SSI_R		17
-#define MX1_DMA_REQ_ASP_DAC		18
-#define MX1_DMA_REQ_ASP_ADC		19
-#define MX1_DMA_REQ_USP_EP(x)		(20 + (x))
-#define MX1_DMA_REQ_SPI2_R		26
-#define MX1_DMA_REQ_SPI2_T		27
-#define MX1_DMA_REQ_UART2_T		28
-#define MX1_DMA_REQ_UART2_R		29
-#define MX1_DMA_REQ_UART1_T		30
-#define MX1_DMA_REQ_UART1_R		31
-
-/*
- * This doesn't depend on IMX_NEEDS_DEPRECATED_SYMBOLS
- * to not break drivers/usb/gadget/imx_udc.  Should go
- * away after this driver uses the new name.
- */
-#define USBD_INT0		MX1_INT_USBD0
-
-#endif /* ifndef __MACH_MX1_H__ */
-- 
1.8.5.5
