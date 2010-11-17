From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:30:06 +0100
Subject: [PATCH 38/51] ARM: imx: move mx25 support to mach-imx
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-38-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Makefile                              |    2 +-
 arch/arm/mach-imx/Kconfig                      |   85 +++++--
 arch/arm/mach-imx/Makefile                     |    6 +
 arch/arm/mach-imx/Makefile.boot                |    4 +
 arch/arm/mach-imx/clock-imx25.c                |  332 ++++++++++++++++++++++++
 arch/arm/mach-imx/devices-imx25.h              |   86 ++++++
 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c |  296 +++++++++++++++++++++
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c       |  161 ++++++++++++
 arch/arm/mach-imx/mach-mx25_3ds.c              |  223 ++++++++++++++++
 arch/arm/mach-imx/mm-imx25.c                   |   62 +++++
 arch/arm/mach-mx25/Kconfig                     |   43 ---
 arch/arm/mach-mx25/Makefile                    |    5 -
 arch/arm/mach-mx25/Makefile.boot               |    3 -
 arch/arm/mach-mx25/clock.c                     |  332 ------------------------
 arch/arm/mach-mx25/devices-imx25.h             |   86 ------
 arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c  |  296 ---------------------
 arch/arm/mach-mx25/mach-cpuimx25.c             |  161 ------------
 arch/arm/mach-mx25/mach-mx25_3ds.c             |  223 ----------------
 arch/arm/mach-mx25/mm.c                        |   62 -----
 arch/arm/plat-mxc/Kconfig                      |    5 -
 20 files changed, 1240 insertions(+), 1233 deletions(-)
 create mode 100644 arch/arm/mach-imx/clock-imx25.c
 create mode 100644 arch/arm/mach-imx/devices-imx25.h
 create mode 100644 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
 create mode 100644 arch/arm/mach-imx/mach-eukrea_cpuimx25.c
 create mode 100644 arch/arm/mach-imx/mach-mx25_3ds.c
 create mode 100644 arch/arm/mach-imx/mm-imx25.c
 delete mode 100644 arch/arm/mach-mx25/Kconfig
 delete mode 100644 arch/arm/mach-mx25/Makefile
 delete mode 100644 arch/arm/mach-mx25/Makefile.boot
 delete mode 100644 arch/arm/mach-mx25/clock.c
 delete mode 100644 arch/arm/mach-mx25/devices-imx25.h
 delete mode 100644 arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
 delete mode 100644 arch/arm/mach-mx25/mach-cpuimx25.c
 delete mode 100644 arch/arm/mach-mx25/mach-mx25_3ds.c
 delete mode 100644 arch/arm/mach-mx25/mm.c

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index b87aed0..057beb8 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -154,7 +154,7 @@ machine-$(CONFIG_ARCH_MSM)		:= msm
 machine-$(CONFIG_ARCH_MV78XX0)		:= mv78xx0
 machine-$(CONFIG_ARCH_MX1)		:= imx
 machine-$(CONFIG_ARCH_MX2)		:= imx
-machine-$(CONFIG_ARCH_MX25)		:= mx25
+machine-$(CONFIG_ARCH_MX25)		:= imx
 machine-$(CONFIG_ARCH_MX3)		:= mx3
 machine-$(CONFIG_ARCH_MX5)		:= mx5
 machine-$(CONFIG_ARCH_MXC91231)		:= mxc91231
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 86bab49..4423df6 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -1,13 +1,34 @@
 config IMX_HAVE_DMA_V1
 	bool
 
-if ARCH_MX1
-
 config SOC_IMX1
+	bool
 	select CPU_ARM920T
 	select IMX_HAVE_DMA_V1
 	select IMX_HAVE_IOMUX_V1
+
+config SOC_IMX21
+	bool
+	select CPU_ARM926T
+	select ARCH_MXC_AUDMUX_V1
+	select IMX_HAVE_DMA_V1
+	select IMX_HAVE_IOMUX_V1
+
+config SOC_IMX25
+	bool
+	select CPU_ARM926T
+	select ARCH_MXC_IOMUX_V3
+	select HAVE_FB_IMX
+	select ARCH_MXC_AUDMUX_V2
+
+config SOC_IMX27
 	bool
+	select CPU_ARM926T
+	select ARCH_MXC_AUDMUX_V1
+	select IMX_HAVE_DMA_V1
+	select IMX_HAVE_IOMUX_V1
+
+if ARCH_MX1
 
 comment "MX1 platforms:"
 config MACH_MXLADS
@@ -31,20 +52,6 @@ endif
 
 if ARCH_MX2
 
-config SOC_IMX21
-	select CPU_ARM926T
-	select ARCH_MXC_AUDMUX_V1
-	select IMX_HAVE_DMA_V1
-	select IMX_HAVE_IOMUX_V1
-	bool
-
-config SOC_IMX27
-	select CPU_ARM926T
-	select ARCH_MXC_AUDMUX_V1
-	select IMX_HAVE_DMA_V1
-	select IMX_HAVE_IOMUX_V1
-	bool
-
 choice
 	prompt "CPUs:"
 	default MACH_MX21
@@ -81,6 +88,52 @@ config MACH_MX21ADS
 
 endif
 
+if ARCH_MX25
+
+comment "MX25 platforms:"
+
+config MACH_MX25_3DS
+	bool "Support MX25PDK (3DS) Platform"
+	select SOC_IMX25
+	select IMX_HAVE_PLATFORM_ESDHC
+	select IMX_HAVE_PLATFORM_IMXDI_RTC
+	select IMX_HAVE_PLATFORM_IMX2_WDT
+	select IMX_HAVE_PLATFORM_IMX_FB
+	select IMX_HAVE_PLATFORM_IMX_KEYPAD
+	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_EHCI
+	select IMX_HAVE_PLATFORM_MXC_NAND
+
+config MACH_EUKREA_CPUIMX25
+	bool "Support Eukrea CPUIMX25 Platform"
+	select SOC_IMX25
+	select IMX_HAVE_PLATFORM_ESDHC
+	select IMX_HAVE_PLATFORM_FLEXCAN
+	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
+	select IMX_HAVE_PLATFORM_IMXDI_RTC
+	select IMX_HAVE_PLATFORM_IMX_FB
+	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_EHCI
+	select IMX_HAVE_PLATFORM_MXC_NAND
+	select MXC_ULPI if USB_ULPI
+
+choice
+	prompt "Baseboard"
+	depends on MACH_EUKREA_CPUIMX25
+	default MACH_EUKREA_MBIMXSD25_BASEBOARD
+
+config MACH_EUKREA_MBIMXSD25_BASEBOARD
+	bool "Eukrea MBIMXSD development board"
+	select IMX_HAVE_PLATFORM_IMX_SSI
+	help
+	  This adds board specific devices that can be found on Eukrea's
+	  MBIMXSD evaluation board.
+
+endchoice
+
+endif
+
 if MACH_MX27
 
 comment "MX27 platforms:"
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index d099c4a..77100bf 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -9,6 +9,8 @@ obj-$(CONFIG_IMX_HAVE_DMA_V1) += dma-v1.o
 obj-$(CONFIG_ARCH_MX1) += clock-imx1.o mm-imx1.o
 obj-$(CONFIG_MACH_MX21) += clock-imx21.o mm-imx21.o
 
+obj-$(CONFIG_ARCH_MX25) += clock-imx25.o mm-imx25.o
+
 obj-$(CONFIG_MACH_MX27) += cpu-imx27.o pm-imx27.o
 obj-$(CONFIG_MACH_MX27) += clock-imx27.o mm-imx27.o
 
@@ -20,6 +22,10 @@ obj-$(CONFIG_MACH_SCB9328) += mach-scb9328.o
 
 obj-$(CONFIG_MACH_MX21ADS) += mach-mx21ads.o
 
+obj-$(CONFIG_MACH_MX25_3DS) += mach-mx25_3ds.o
+obj-$(CONFIG_MACH_EUKREA_CPUIMX25) += mach-eukrea_cpuimx25.o
+obj-$(CONFIG_MACH_EUKREA_MBIMXSD25_BASEBOARD) += eukrea_mbimxsd25-baseboard.o
+
 obj-$(CONFIG_MACH_MX27ADS) += mach-mx27ads.o
 obj-$(CONFIG_MACH_PCM038) += mach-pcm038.o
 obj-$(CONFIG_MACH_PCM970_BASEBOARD) += pcm970-baseboard.o
diff --git a/arch/arm/mach-imx/Makefile.boot b/arch/arm/mach-imx/Makefile.boot
index 7988a85..3953d60 100644
--- a/arch/arm/mach-imx/Makefile.boot
+++ b/arch/arm/mach-imx/Makefile.boot
@@ -6,6 +6,10 @@ zreladdr-$(CONFIG_MACH_MX21)	:= 0xC0008000
 params_phys-$(CONFIG_MACH_MX21)	:= 0xC0000100
 initrd_phys-$(CONFIG_MACH_MX21)	:= 0xC0800000
 
+zreladdr-$(CONFIG_ARCH_MX25)	:= 0x80008000
+params_phys-$(CONFIG_ARCH_MX25)	:= 0x80000100
+initrd_phys-$(CONFIG_ARCH_MX25)	:= 0x80800000
+
 zreladdr-$(CONFIG_MACH_MX27)	:= 0xA0008000
 params_phys-$(CONFIG_MACH_MX27)	:= 0xA0000100
 initrd_phys-$(CONFIG_MACH_MX27)	:= 0xA0800000
diff --git a/arch/arm/mach-imx/clock-imx25.c b/arch/arm/mach-imx/clock-imx25.c
new file mode 100644
index 0000000..9e4a557
--- /dev/null
+++ b/arch/arm/mach-imx/clock-imx25.c
@@ -0,0 +1,332 @@
+/*
+ * Copyright (C) 2009 by Sascha Hauer, Pengutronix
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301, USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <asm/clkdev.h>
+
+#include <mach/clock.h>
+#include <mach/hardware.h>
+#include <mach/common.h>
+#include <mach/mx25.h>
+
+#define CRM_BASE	MX25_IO_ADDRESS(MX25_CRM_BASE_ADDR)
+
+#define CCM_MPCTL	0x00
+#define CCM_UPCTL	0x04
+#define CCM_CCTL	0x08
+#define CCM_CGCR0	0x0C
+#define CCM_CGCR1	0x10
+#define CCM_CGCR2	0x14
+#define CCM_PCDR0	0x18
+#define CCM_PCDR1	0x1C
+#define CCM_PCDR2	0x20
+#define CCM_PCDR3	0x24
+#define CCM_RCSR	0x28
+#define CCM_CRDR	0x2C
+#define CCM_DCVR0	0x30
+#define CCM_DCVR1	0x34
+#define CCM_DCVR2	0x38
+#define CCM_DCVR3	0x3c
+#define CCM_LTR0	0x40
+#define CCM_LTR1	0x44
+#define CCM_LTR2	0x48
+#define CCM_LTR3	0x4c
+
+static unsigned long get_rate_mpll(void)
+{
+	ulong mpctl = __raw_readl(CRM_BASE + CCM_MPCTL);
+
+	return mxc_decode_pll(mpctl, 24000000);
+}
+
+static unsigned long get_rate_upll(void)
+{
+	ulong mpctl = __raw_readl(CRM_BASE + CCM_UPCTL);
+
+	return mxc_decode_pll(mpctl, 24000000);
+}
+
+unsigned long get_rate_arm(struct clk *clk)
+{
+	unsigned long cctl = readl(CRM_BASE + CCM_CCTL);
+	unsigned long rate = get_rate_mpll();
+
+	if (cctl & (1 << 14))
+		rate = (rate * 3) >> 2;
+
+	return rate / ((cctl >> 30) + 1);
+}
+
+static unsigned long get_rate_ahb(struct clk *clk)
+{
+	unsigned long cctl = readl(CRM_BASE + CCM_CCTL);
+
+	return get_rate_arm(NULL) / (((cctl >> 28) & 0x3) + 1);
+}
+
+static unsigned long get_rate_ipg(struct clk *clk)
+{
+	return get_rate_ahb(NULL) >> 1;
+}
+
+static unsigned long get_rate_per(int per)
+{
+	unsigned long ofs = (per & 0x3) * 8;
+	unsigned long reg = per & ~0x3;
+	unsigned long val = (readl(CRM_BASE + CCM_PCDR0 + reg) >> ofs) & 0x3f;
+	unsigned long fref;
+
+	if (readl(CRM_BASE + 0x64) & (1 << per))
+		fref = get_rate_upll();
+	else
+		fref = get_rate_ahb(NULL);
+
+	return fref / (val + 1);
+}
+
+static unsigned long get_rate_uart(struct clk *clk)
+{
+	return get_rate_per(15);
+}
+
+static unsigned long get_rate_ssi2(struct clk *clk)
+{
+	return get_rate_per(14);
+}
+
+static unsigned long get_rate_ssi1(struct clk *clk)
+{
+	return get_rate_per(13);
+}
+
+static unsigned long get_rate_i2c(struct clk *clk)
+{
+	return get_rate_per(6);
+}
+
+static unsigned long get_rate_nfc(struct clk *clk)
+{
+	return get_rate_per(8);
+}
+
+static unsigned long get_rate_gpt(struct clk *clk)
+{
+	return get_rate_per(5);
+}
+
+static unsigned long get_rate_lcdc(struct clk *clk)
+{
+	return get_rate_per(7);
+}
+
+static unsigned long get_rate_esdhc1(struct clk *clk)
+{
+	return get_rate_per(3);
+}
+
+static unsigned long get_rate_esdhc2(struct clk *clk)
+{
+	return get_rate_per(4);
+}
+
+static unsigned long get_rate_csi(struct clk *clk)
+{
+	return get_rate_per(0);
+}
+
+static unsigned long get_rate_otg(struct clk *clk)
+{
+	unsigned long cctl = readl(CRM_BASE + CCM_CCTL);
+	unsigned long rate = get_rate_upll();
+
+	return (cctl & (1 << 23)) ? 0 : rate / ((0x3F & (cctl >> 16)) + 1);
+}
+
+static int clk_cgcr_enable(struct clk *clk)
+{
+	u32 reg;
+
+	reg = __raw_readl(clk->enable_reg);
+	reg |= 1 << clk->enable_shift;
+	__raw_writel(reg, clk->enable_reg);
+
+	return 0;
+}
+
+static void clk_cgcr_disable(struct clk *clk)
+{
+	u32 reg;
+
+	reg = __raw_readl(clk->enable_reg);
+	reg &= ~(1 << clk->enable_shift);
+	__raw_writel(reg, clk->enable_reg);
+}
+
+#define DEFINE_CLOCK(name, i, er, es, gr, sr, s)	\
+	static struct clk name = {			\
+		.id		= i,			\
+		.enable_reg	= CRM_BASE + er,	\
+		.enable_shift	= es,			\
+		.get_rate	= gr,			\
+		.set_rate	= sr,			\
+		.enable		= clk_cgcr_enable,	\
+		.disable	= clk_cgcr_disable,	\
+		.secondary	= s,			\
+	}
+
+/*
+ * Note: the following IPG clock gating bits are wrongly marked "Reserved" in
+ * the i.MX25 Reference Manual Rev 1, table 15-13. The information below is
+ * taken from the Freescale released BSP.
+ *
+ * bit	reg	offset	clock
+ *
+ * 0	CGCR1	0	AUDMUX
+ * 12	CGCR1	12	ESAI
+ * 16	CGCR1	16	GPIO1
+ * 17	CGCR1	17	GPIO2
+ * 18	CGCR1	18	GPIO3
+ * 23	CGCR1	23	I2C1
+ * 24	CGCR1	24	I2C2
+ * 25	CGCR1	25	I2C3
+ * 27	CGCR1	27	IOMUXC
+ * 28	CGCR1	28	KPP
+ * 30	CGCR1	30	OWIRE
+ * 36	CGCR2	4	RTIC
+ * 51	CGCR2	19	WDOG
+ */
+
+DEFINE_CLOCK(gpt_clk,    0, CCM_CGCR0,  5, get_rate_gpt, NULL, NULL);
+DEFINE_CLOCK(uart_per_clk, 0, CCM_CGCR0, 15, get_rate_uart, NULL, NULL);
+DEFINE_CLOCK(ssi1_per_clk, 0, CCM_CGCR0, 13, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(ssi2_per_clk, 0, CCM_CGCR0, 14, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(cspi1_clk,  0, CCM_CGCR1,  5, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(cspi2_clk,  0, CCM_CGCR1,  6, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(cspi3_clk,  0, CCM_CGCR1,  7, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(esdhc1_ahb_clk, 0, CCM_CGCR0, 21, get_rate_esdhc1,	 NULL, NULL);
+DEFINE_CLOCK(esdhc1_per_clk, 0, CCM_CGCR0,  3, get_rate_esdhc1,	 NULL,
+		&esdhc1_ahb_clk);
+DEFINE_CLOCK(esdhc2_ahb_clk, 0, CCM_CGCR0, 22, get_rate_esdhc2,	 NULL, NULL);
+DEFINE_CLOCK(esdhc2_per_clk, 0, CCM_CGCR0,  4, get_rate_esdhc2,	 NULL,
+		&esdhc2_ahb_clk);
+DEFINE_CLOCK(fec_ahb_clk, 0, CCM_CGCR0, 23, NULL,	 NULL, NULL);
+DEFINE_CLOCK(lcdc_ahb_clk, 0, CCM_CGCR0, 24, NULL,	 NULL, NULL);
+DEFINE_CLOCK(lcdc_per_clk, 0, CCM_CGCR0,  7, NULL,	 NULL, &lcdc_ahb_clk);
+DEFINE_CLOCK(csi_ahb_clk, 0, CCM_CGCR0, 18, get_rate_csi, NULL, NULL);
+DEFINE_CLOCK(csi_per_clk, 0, CCM_CGCR0, 0, get_rate_csi, NULL, &csi_ahb_clk);
+DEFINE_CLOCK(uart1_clk,  0, CCM_CGCR2, 14, get_rate_uart, NULL, &uart_per_clk);
+DEFINE_CLOCK(uart2_clk,  0, CCM_CGCR2, 15, get_rate_uart, NULL, &uart_per_clk);
+DEFINE_CLOCK(uart3_clk,  0, CCM_CGCR2, 16, get_rate_uart, NULL, &uart_per_clk);
+DEFINE_CLOCK(uart4_clk,  0, CCM_CGCR2, 17, get_rate_uart, NULL, &uart_per_clk);
+DEFINE_CLOCK(uart5_clk,  0, CCM_CGCR2, 18, get_rate_uart, NULL, &uart_per_clk);
+DEFINE_CLOCK(nfc_clk,    0, CCM_CGCR0,  8, get_rate_nfc, NULL, NULL);
+DEFINE_CLOCK(usbotg_clk, 0, CCM_CGCR0, 28, get_rate_otg, NULL, NULL);
+DEFINE_CLOCK(pwm1_clk,	 0, CCM_CGCR1, 31, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(pwm2_clk,	 0, CCM_CGCR2,  0, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(pwm3_clk,	 0, CCM_CGCR2,  1, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(pwm4_clk,	 0, CCM_CGCR2,  2, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(kpp_clk,	 0, CCM_CGCR1, 28, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(tsc_clk,	 0, CCM_CGCR2, 13, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(i2c_clk,	 0, CCM_CGCR0,  6, get_rate_i2c, NULL, NULL);
+DEFINE_CLOCK(fec_clk,	 0, CCM_CGCR1, 15, get_rate_ipg, NULL, &fec_ahb_clk);
+DEFINE_CLOCK(dryice_clk, 0, CCM_CGCR1,  8, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(lcdc_clk,	 0, CCM_CGCR1, 29, get_rate_lcdc, NULL, &lcdc_per_clk);
+DEFINE_CLOCK(wdt_clk,    0, CCM_CGCR2, 19, get_rate_ipg, NULL,  NULL);
+DEFINE_CLOCK(ssi1_clk,  0, CCM_CGCR2, 11, get_rate_ssi1, NULL, &ssi1_per_clk);
+DEFINE_CLOCK(ssi2_clk,  1, CCM_CGCR2, 12, get_rate_ssi2, NULL, &ssi2_per_clk);
+DEFINE_CLOCK(esdhc1_clk,  0, CCM_CGCR1, 13, get_rate_esdhc1, NULL,
+		&esdhc1_per_clk);
+DEFINE_CLOCK(esdhc2_clk,  1, CCM_CGCR1, 14, get_rate_esdhc2, NULL,
+		&esdhc2_per_clk);
+DEFINE_CLOCK(audmux_clk, 0, CCM_CGCR1, 0, NULL, NULL, NULL);
+DEFINE_CLOCK(csi_clk,    0, CCM_CGCR1,  4, get_rate_csi, NULL,  &csi_per_clk);
+DEFINE_CLOCK(can1_clk,	 0, CCM_CGCR1,  2, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(can2_clk,	 1, CCM_CGCR1,  3, get_rate_ipg, NULL, NULL);
+
+#define _REGISTER_CLOCK(d, n, c)	\
+	{				\
+		.dev_id = d,		\
+		.con_id = n,		\
+		.clk = &c,		\
+	},
+
+static struct clk_lookup lookups[] = {
+	_REGISTER_CLOCK("imx-uart.0", NULL, uart1_clk)
+	_REGISTER_CLOCK("imx-uart.1", NULL, uart2_clk)
+	_REGISTER_CLOCK("imx-uart.2", NULL, uart3_clk)
+	_REGISTER_CLOCK("imx-uart.3", NULL, uart4_clk)
+	_REGISTER_CLOCK("imx-uart.4", NULL, uart5_clk)
+	_REGISTER_CLOCK("mxc-ehci.0", "usb", usbotg_clk)
+	_REGISTER_CLOCK("mxc-ehci.1", "usb", usbotg_clk)
+	_REGISTER_CLOCK("mxc-ehci.2", "usb", usbotg_clk)
+	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usbotg_clk)
+	_REGISTER_CLOCK("mxc_nand.0", NULL, nfc_clk)
+	_REGISTER_CLOCK("imx25-cspi.0", NULL, cspi1_clk)
+	_REGISTER_CLOCK("imx25-cspi.1", NULL, cspi2_clk)
+	_REGISTER_CLOCK("imx25-cspi.2", NULL, cspi3_clk)
+	_REGISTER_CLOCK("mxc_pwm.0", NULL, pwm1_clk)
+	_REGISTER_CLOCK("mxc_pwm.1", NULL, pwm2_clk)
+	_REGISTER_CLOCK("mxc_pwm.2", NULL, pwm3_clk)
+	_REGISTER_CLOCK("mxc_pwm.3", NULL, pwm4_clk)
+	_REGISTER_CLOCK("imx-keypad", NULL, kpp_clk)
+	_REGISTER_CLOCK("mx25-adc", NULL, tsc_clk)
+	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c_clk)
+	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c_clk)
+	_REGISTER_CLOCK("imx-i2c.2", NULL, i2c_clk)
+	_REGISTER_CLOCK("fec.0", NULL, fec_clk)
+	_REGISTER_CLOCK("imxdi_rtc.0", NULL, dryice_clk)
+	_REGISTER_CLOCK("imx-fb.0", NULL, lcdc_clk)
+	_REGISTER_CLOCK("imx-wdt.0", NULL, wdt_clk)
+	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
+	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx.0", NULL, esdhc1_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx.1", NULL, esdhc2_clk)
+	_REGISTER_CLOCK("mx2-camera.0", NULL, csi_clk)
+	_REGISTER_CLOCK(NULL, "audmux", audmux_clk)
+	_REGISTER_CLOCK("flexcan.0", NULL, can1_clk)
+	_REGISTER_CLOCK("flexcan.1", NULL, can2_clk)
+};
+
+int __init mx25_clocks_init(void)
+{
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+
+	/* Turn off all clocks except the ones we need to survive, namely:
+	 * EMI, GPIO1-3 (CCM_CGCR1[18:16]), GPT1, IOMUXC (CCM_CGCR1[27]), IIM,
+	 * SCC
+	 */
+	__raw_writel((1 << 19), CRM_BASE + CCM_CGCR0);
+	__raw_writel((0xf << 16) | (3 << 26), CRM_BASE + CCM_CGCR1);
+	__raw_writel((1 << 5), CRM_BASE + CCM_CGCR2);
+#if defined(CONFIG_DEBUG_LL) && !defined(CONFIG_DEBUG_ICEDCC)
+	clk_enable(&uart1_clk);
+#endif
+
+	/* Clock source for lcdc and csi is upll */
+	__raw_writel(__raw_readl(CRM_BASE+0x64) | (1 << 7) | (1 << 0),
+			CRM_BASE + 0x64);
+
+	mxc_timer_init(&gpt_clk, MX25_IO_ADDRESS(MX25_GPT1_BASE_ADDR), 54);
+
+	return 0;
+}
diff --git a/arch/arm/mach-imx/devices-imx25.h b/arch/arm/mach-imx/devices-imx25.h
new file mode 100644
index 0000000..953e1ce
--- /dev/null
+++ b/arch/arm/mach-imx/devices-imx25.h
@@ -0,0 +1,86 @@
+/*
+ * Copyright (C) 2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <mach/mx25.h>
+#include <mach/devices-common.h>
+
+extern const struct imx_fec_data imx25_fec_data __initconst;
+#define imx25_add_fec(pdata)	\
+	imx_add_fec(&imx25_fec_data, pdata)
+
+extern const struct imx_flexcan_data imx25_flexcan_data[] __initconst;
+#define imx25_add_flexcan(id, pdata)	\
+	imx_add_flexcan(&imx25_flexcan_data[id], pdata)
+#define imx25_add_flexcan0(pdata)	imx25_add_flexcan(0, pdata)
+#define imx25_add_flexcan1(pdata)	imx25_add_flexcan(1, pdata)
+
+extern const struct imx_fsl_usb2_udc_data imx25_fsl_usb2_udc_data __initconst;
+#define imx25_add_fsl_usb2_udc(pdata)	\
+	imx_add_fsl_usb2_udc(&imx25_fsl_usb2_udc_data, pdata)
+
+extern struct imx_imxdi_rtc_data imx25_imxdi_rtc_data __initconst;
+#define imx25_add_imxdi_rtc(pdata)	\
+	imx_add_imxdi_rtc(&imx25_imxdi_rtc_data)
+
+extern const struct imx_imx2_wdt_data imx25_imx2_wdt_data __initconst;
+#define imx25_add_imx2_wdt(pdata)	\
+	imx_add_imx2_wdt(&imx25_imx2_wdt_data)
+
+extern const struct imx_imx_fb_data imx25_imx_fb_data __initconst;
+#define imx25_add_imx_fb(pdata)	\
+	imx_add_imx_fb(&imx25_imx_fb_data, pdata)
+
+extern const struct imx_imx_i2c_data imx25_imx_i2c_data[] __initconst;
+#define imx25_add_imx_i2c(id, pdata)	\
+	imx_add_imx_i2c(&imx25_imx_i2c_data[id], pdata)
+#define imx25_add_imx_i2c0(pdata)	imx25_add_imx_i2c(0, pdata)
+#define imx25_add_imx_i2c1(pdata)	imx25_add_imx_i2c(1, pdata)
+#define imx25_add_imx_i2c2(pdata)	imx25_add_imx_i2c(2, pdata)
+
+extern const struct imx_imx_keypad_data imx25_imx_keypad_data __initconst;
+#define imx25_add_imx_keypad(pdata)	\
+	imx_add_imx_keypad(&imx25_imx_keypad_data, pdata)
+
+extern const struct imx_imx_ssi_data imx25_imx_ssi_data[] __initconst;
+#define imx25_add_imx_ssi(id, pdata)	\
+	imx_add_imx_ssi(&imx25_imx_ssi_data[id], pdata)
+
+extern const struct imx_imx_uart_1irq_data imx25_imx_uart_data[] __initconst;
+#define imx25_add_imx_uart(id, pdata)	\
+	imx_add_imx_uart_1irq(&imx25_imx_uart_data[id], pdata)
+#define imx25_add_imx_uart0(pdata)	imx25_add_imx_uart(0, pdata)
+#define imx25_add_imx_uart1(pdata)	imx25_add_imx_uart(1, pdata)
+#define imx25_add_imx_uart2(pdata)	imx25_add_imx_uart(2, pdata)
+#define imx25_add_imx_uart3(pdata)	imx25_add_imx_uart(3, pdata)
+#define imx25_add_imx_uart4(pdata)	imx25_add_imx_uart(4, pdata)
+
+extern const struct imx_mx2_camera_data imx25_mx2_camera_data __initconst;
+#define imx25_add_mx2_camera(pdata)	\
+	imx_add_mx2_camera(&imx25_mx2_camera_data, pdata)
+
+extern const struct imx_mxc_ehci_data imx25_mxc_ehci_otg_data __initconst;
+#define imx25_add_mxc_ehci_otg(pdata)	\
+	imx_add_mxc_ehci(&imx25_mxc_ehci_otg_data, pdata)
+extern const struct imx_mxc_ehci_data imx25_mxc_ehci_hs_data __initconst;
+#define imx25_add_mxc_ehci_hs(pdata)	\
+	imx_add_mxc_ehci(&imx25_mxc_ehci_hs_data, pdata)
+
+extern const struct imx_mxc_nand_data imx25_mxc_nand_data __initconst;
+#define imx25_add_mxc_nand(pdata)	\
+	imx_add_mxc_nand(&imx25_mxc_nand_data, pdata)
+
+extern const struct imx_spi_imx_data imx25_spi_imx_data[] __initconst;
+#define imx25_add_spi_imx(id, pdata)	\
+	imx_add_spi_imx(&imx25_spi_imx_data[id], pdata)
+#define imx25_add_spi_imx0(pdata)	imx25_add_spi_imx(0, pdata)
+#define imx25_add_spi_imx1(pdata)	imx25_add_spi_imx(1, pdata)
+#define imx25_add_spi_imx2(pdata)	imx25_add_spi_imx(2, pdata)
+
+extern const struct imx_esdhc_imx_data imx25_esdhc_data[] __initconst;
+#define imx25_add_esdhc(id, pdata)	\
+	imx_add_esdhc(&imx25_esdhc_data[id], pdata)
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
new file mode 100644
index 0000000..75a5db5
--- /dev/null
+++ b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
@@ -0,0 +1,296 @@
+/*
+ * Copyright (C) 2010 Eric Benard - eric at eukrea.com
+ *
+ * Based on pcm970-baseboard.c which is :
+ * Copyright (C) 2008 Juergen Beisert (kernel at pengutronix.de)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301, USA.
+ */
+
+#include <linux/gpio.h>
+#include <linux/leds.h>
+#include <linux/platform_device.h>
+#include <linux/gpio_keys.h>
+#include <linux/input.h>
+#include <video/platform_lcd.h>
+
+#include <mach/hardware.h>
+#include <mach/iomux-mx25.h>
+#include <mach/common.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <mach/mx25.h>
+#include <mach/imx-uart.h>
+#include <mach/audmux.h>
+
+#include "devices-imx25.h"
+
+static struct pad_desc eukrea_mbimxsd_pads[] = {
+	/* LCD */
+	MX25_PAD_LD0__LD0,
+	MX25_PAD_LD1__LD1,
+	MX25_PAD_LD2__LD2,
+	MX25_PAD_LD3__LD3,
+	MX25_PAD_LD4__LD4,
+	MX25_PAD_LD5__LD5,
+	MX25_PAD_LD6__LD6,
+	MX25_PAD_LD7__LD7,
+	MX25_PAD_LD8__LD8,
+	MX25_PAD_LD9__LD9,
+	MX25_PAD_LD10__LD10,
+	MX25_PAD_LD11__LD11,
+	MX25_PAD_LD12__LD12,
+	MX25_PAD_LD13__LD13,
+	MX25_PAD_LD14__LD14,
+	MX25_PAD_LD15__LD15,
+	MX25_PAD_GPIO_E__LD16,
+	MX25_PAD_GPIO_F__LD17,
+	MX25_PAD_HSYNC__HSYNC,
+	MX25_PAD_VSYNC__VSYNC,
+	MX25_PAD_LSCLK__LSCLK,
+	MX25_PAD_OE_ACD__OE_ACD,
+	MX25_PAD_CONTRAST__CONTRAST,
+	/* LCD_PWR */
+	MX25_PAD_PWM__GPIO_1_26,
+	/* LED */
+	MX25_PAD_POWER_FAIL__GPIO_3_19,
+	/* SWITCH */
+	MX25_PAD_VSTBY_ACK__GPIO_3_18,
+	/* UART2 */
+	MX25_PAD_UART2_RTS__UART2_RTS,
+	MX25_PAD_UART2_CTS__UART2_CTS,
+	MX25_PAD_UART2_TXD__UART2_TXD,
+	MX25_PAD_UART2_RXD__UART2_RXD,
+	/* SD1 */
+	MX25_PAD_SD1_CMD__SD1_CMD,
+	MX25_PAD_SD1_CLK__SD1_CLK,
+	MX25_PAD_SD1_DATA0__SD1_DATA0,
+	MX25_PAD_SD1_DATA1__SD1_DATA1,
+	MX25_PAD_SD1_DATA2__SD1_DATA2,
+	MX25_PAD_SD1_DATA3__SD1_DATA3,
+	/* SD1 CD */
+	MX25_PAD_DE_B__GPIO_2_20,
+	/* I2S */
+	MX25_PAD_KPP_COL3__AUD5_TXFS,
+	MX25_PAD_KPP_COL2__AUD5_TXC,
+	MX25_PAD_KPP_COL1__AUD5_RXD,
+	MX25_PAD_KPP_COL0__AUD5_TXD,
+	/* CAN */
+	MX25_PAD_GPIO_D__CAN2_RX,
+	MX25_PAD_GPIO_C__CAN2_TX,
+};
+
+#define GPIO_LED1	83
+#define GPIO_SWITCH1	82
+#define GPIO_SD1CD	52
+#define GPIO_LCDPWR	26
+
+static struct imx_fb_videomode eukrea_mximxsd_modes[] = {
+	{
+		.mode	= {
+			.name		= "CMO-QVGA",
+			.refresh	= 60,
+			.xres		= 320,
+			.yres		= 240,
+			.pixclock	= KHZ2PICOS(6500),
+			.left_margin	= 30,
+			.right_margin	= 38,
+			.upper_margin	= 20,
+			.lower_margin	= 3,
+			.hsync_len	= 15,
+			.vsync_len	= 4,
+		},
+		.bpp	= 16,
+		.pcr	= 0xCAD08B80,
+	}, {
+		.mode = {
+			.name		= "DVI-VGA",
+			.refresh	= 60,
+			.xres		= 640,
+			.yres		= 480,
+			.pixclock	= 32000,
+			.hsync_len	= 7,
+			.left_margin	= 100,
+			.right_margin	= 100,
+			.vsync_len	= 7,
+			.upper_margin	= 7,
+			.lower_margin	= 100,
+		},
+		.pcr		= 0xFA208B80,
+		.bpp		= 16,
+	}, {
+		.mode = {
+			.name		= "DVI-SVGA",
+			.refresh	= 60,
+			.xres		= 800,
+			.yres		= 600,
+			.pixclock	= 25000,
+			.hsync_len	= 7,
+			.left_margin	= 75,
+			.right_margin	= 75,
+			.vsync_len	= 7,
+			.upper_margin	= 7,
+			.lower_margin	= 75,
+		},
+		.pcr		= 0xFA208B80,
+		.bpp		= 16,
+	},
+};
+
+static const struct imx_fb_platform_data eukrea_mximxsd_fb_pdata __initconst = {
+	.mode		= eukrea_mximxsd_modes,
+	.num_modes	= ARRAY_SIZE(eukrea_mximxsd_modes),
+	.pwmr		= 0x00A903FF,
+	.lscr1		= 0x00120300,
+	.dmacr		= 0x00040060,
+};
+
+static void eukrea_mbimxsd_lcd_power_set(struct plat_lcd_data *pd,
+				   unsigned int power)
+{
+	if (power)
+		gpio_direction_output(GPIO_LCDPWR, 1);
+	else
+		gpio_direction_output(GPIO_LCDPWR, 0);
+}
+
+static struct plat_lcd_data eukrea_mbimxsd_lcd_power_data = {
+	.set_power		= eukrea_mbimxsd_lcd_power_set,
+};
+
+static struct platform_device eukrea_mbimxsd_lcd_powerdev = {
+	.name			= "platform-lcd",
+	.dev.platform_data	= &eukrea_mbimxsd_lcd_power_data,
+};
+
+static struct gpio_led eukrea_mbimxsd_leds[] = {
+	{
+		.name			= "led1",
+		.default_trigger	= "heartbeat",
+		.active_low		= 1,
+		.gpio			= GPIO_LED1,
+	},
+};
+
+static struct gpio_led_platform_data eukrea_mbimxsd_led_info = {
+	.leds		= eukrea_mbimxsd_leds,
+	.num_leds	= ARRAY_SIZE(eukrea_mbimxsd_leds),
+};
+
+static struct platform_device eukrea_mbimxsd_leds_gpio = {
+	.name	= "leds-gpio",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &eukrea_mbimxsd_led_info,
+	},
+};
+
+static struct gpio_keys_button eukrea_mbimxsd_gpio_buttons[] = {
+	{
+		.gpio		= GPIO_SWITCH1,
+		.code		= BTN_0,
+		.desc		= "BP1",
+		.active_low	= 1,
+		.wakeup		= 1,
+	},
+};
+
+static struct gpio_keys_platform_data eukrea_mbimxsd_button_data = {
+	.buttons	= eukrea_mbimxsd_gpio_buttons,
+	.nbuttons	= ARRAY_SIZE(eukrea_mbimxsd_gpio_buttons),
+};
+
+static struct platform_device eukrea_mbimxsd_button_device = {
+	.name		= "gpio-keys",
+	.id		= -1,
+	.num_resources	= 0,
+	.dev		= {
+		.platform_data	= &eukrea_mbimxsd_button_data,
+	}
+};
+
+static struct platform_device *platform_devices[] __initdata = {
+	&eukrea_mbimxsd_leds_gpio,
+	&eukrea_mbimxsd_button_device,
+	&eukrea_mbimxsd_lcd_powerdev,
+};
+
+static const struct imxuart_platform_data uart_pdata __initconst = {
+	.flags = IMXUART_HAVE_RTSCTS,
+};
+
+static struct i2c_board_info eukrea_mbimxsd_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("tlv320aic23", 0x1a),
+	},
+};
+
+static const
+struct imx_ssi_platform_data eukrea_mbimxsd_ssi_pdata __initconst = {
+	.flags = IMX_SSI_SYN | IMX_SSI_NET | IMX_SSI_USE_I2S_SLAVE,
+};
+
+/*
+ * system init for baseboard usage. Will be called by cpuimx25 init.
+ *
+ * Add platform devices present on this baseboard and init
+ * them from CPU side as far as required to use them later on
+ */
+void __init eukrea_mbimxsd25_baseboard_init(void)
+{
+	if (mxc_iomux_v3_setup_multiple_pads(eukrea_mbimxsd_pads,
+			ARRAY_SIZE(eukrea_mbimxsd_pads)))
+		printk(KERN_ERR "error setting mbimxsd pads !\n");
+
+#if defined(CONFIG_SND_SOC_EUKREA_TLV320)
+	/* SSI unit master I2S codec connected to SSI_AUD5*/
+	mxc_audmux_v2_configure_port(0,
+			MXC_AUDMUX_V2_PTCR_SYN |
+			MXC_AUDMUX_V2_PTCR_TFSDIR |
+			MXC_AUDMUX_V2_PTCR_TFSEL(4) |
+			MXC_AUDMUX_V2_PTCR_TCLKDIR |
+			MXC_AUDMUX_V2_PTCR_TCSEL(4),
+			MXC_AUDMUX_V2_PDCR_RXDSEL(4)
+	);
+	mxc_audmux_v2_configure_port(4,
+			MXC_AUDMUX_V2_PTCR_SYN,
+			MXC_AUDMUX_V2_PDCR_RXDSEL(0)
+	);
+#endif
+
+	imx25_add_imx_uart1(&uart_pdata);
+	imx25_add_imx_fb(&eukrea_mximxsd_fb_pdata);
+	imx25_add_imx_ssi(0, &eukrea_mbimxsd_ssi_pdata);
+
+	imx25_add_flexcan1(NULL);
+	imx25_add_esdhc(0, NULL);
+
+	gpio_request(GPIO_LED1, "LED1");
+	gpio_direction_output(GPIO_LED1, 1);
+	gpio_free(GPIO_LED1);
+
+	gpio_request(GPIO_SWITCH1, "SWITCH1");
+	gpio_direction_input(GPIO_SWITCH1);
+	gpio_free(GPIO_SWITCH1);
+
+	gpio_request(GPIO_LCDPWR, "LCDPWR");
+	gpio_direction_output(GPIO_LCDPWR, 1);
+	gpio_free(GPIO_SWITCH1);
+
+	i2c_register_board_info(0, eukrea_mbimxsd_i2c_devices,
+				ARRAY_SIZE(eukrea_mbimxsd_i2c_devices));
+
+	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+}
diff --git a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
new file mode 100644
index 0000000..67a7d55
--- /dev/null
+++ b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
@@ -0,0 +1,161 @@
+/*
+ * Copyright 2009 Sascha Hauer, <kernel@pengutronix.de>
+ * Copyright 2010 Eric B?nard - Eukr?a Electromatique, <eric@eukrea.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor,
+ * Boston, MA  02110-1301, USA.
+ */
+
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/irq.h>
+#include <linux/gpio.h>
+#include <linux/platform_device.h>
+#include <linux/usb/otg.h>
+#include <linux/usb/ulpi.h>
+
+#include <mach/eukrea-baseboards.h>
+#include <mach/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+#include <asm/memory.h>
+#include <asm/mach/map.h>
+#include <mach/common.h>
+#include <mach/mx25.h>
+#include <mach/mxc_nand.h>
+#include <mach/imxfb.h>
+#include <mach/iomux-mx25.h>
+
+#include "devices-imx25.h"
+
+static const struct imxuart_platform_data uart_pdata __initconst = {
+	.flags = IMXUART_HAVE_RTSCTS,
+};
+
+static struct pad_desc eukrea_cpuimx25_pads[] = {
+	/* FEC - RMII */
+	MX25_PAD_FEC_MDC__FEC_MDC,
+	MX25_PAD_FEC_MDIO__FEC_MDIO,
+	MX25_PAD_FEC_TDATA0__FEC_TDATA0,
+	MX25_PAD_FEC_TDATA1__FEC_TDATA1,
+	MX25_PAD_FEC_TX_EN__FEC_TX_EN,
+	MX25_PAD_FEC_RDATA0__FEC_RDATA0,
+	MX25_PAD_FEC_RDATA1__FEC_RDATA1,
+	MX25_PAD_FEC_RX_DV__FEC_RX_DV,
+	MX25_PAD_FEC_TX_CLK__FEC_TX_CLK,
+	/* I2C1 */
+	MX25_PAD_I2C1_CLK__I2C1_CLK,
+	MX25_PAD_I2C1_DAT__I2C1_DAT,
+};
+
+static const struct fec_platform_data mx25_fec_pdata __initconst = {
+	.phy	= PHY_INTERFACE_MODE_RMII,
+};
+
+static const struct mxc_nand_platform_data
+eukrea_cpuimx25_nand_board_info __initconst = {
+	.width		= 1,
+	.hw_ecc		= 1,
+	.flash_bbt	= 1,
+};
+
+static const struct imxi2c_platform_data
+eukrea_cpuimx25_i2c0_data __initconst = {
+	.bitrate = 100000,
+};
+
+static struct i2c_board_info eukrea_cpuimx25_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("pcf8563", 0x51),
+	},
+};
+
+static const struct mxc_usbh_platform_data otg_pdata __initconst = {
+	.portsc	= MXC_EHCI_MODE_UTMI,
+	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
+};
+
+static const struct mxc_usbh_platform_data usbh2_pdata __initconst = {
+	.portsc	= MXC_EHCI_MODE_SERIAL,
+	.flags	= MXC_EHCI_INTERFACE_SINGLE_UNI | MXC_EHCI_INTERNAL_PHY |
+		  MXC_EHCI_IPPUE_DOWN,
+};
+
+static const struct fsl_usb2_platform_data otg_device_pdata __initconst = {
+	.operating_mode = FSL_USB2_DR_DEVICE,
+	.phy_mode       = FSL_USB2_PHY_UTMI,
+};
+
+static int otg_mode_host;
+
+static int __init eukrea_cpuimx25_otg_mode(char *options)
+{
+	if (!strcmp(options, "host"))
+		otg_mode_host = 1;
+	else if (!strcmp(options, "device"))
+		otg_mode_host = 0;
+	else
+		pr_info("otg_mode neither \"host\" nor \"device\". "
+			"Defaulting to device\n");
+	return 0;
+}
+__setup("otg_mode=", eukrea_cpuimx25_otg_mode);
+
+static void __init eukrea_cpuimx25_init(void)
+{
+	if (mxc_iomux_v3_setup_multiple_pads(eukrea_cpuimx25_pads,
+			ARRAY_SIZE(eukrea_cpuimx25_pads)))
+		printk(KERN_ERR "error setting cpuimx25 pads !\n");
+
+	imx25_add_imx_uart0(&uart_pdata);
+	imx25_add_mxc_nand(&eukrea_cpuimx25_nand_board_info);
+	imx25_add_imxdi_rtc(NULL);
+	imx25_add_fec(&mx25_fec_pdata);
+
+	i2c_register_board_info(0, eukrea_cpuimx25_i2c_devices,
+				ARRAY_SIZE(eukrea_cpuimx25_i2c_devices));
+	imx25_add_imx_i2c0(&eukrea_cpuimx25_i2c0_data);
+
+	if (otg_mode_host)
+		imx25_add_mxc_ehci_otg(&otg_pdata);
+	else
+		imx25_add_fsl_usb2_udc(&otg_device_pdata);
+
+	imx25_add_mxc_ehci_hs(&usbh2_pdata);
+
+#ifdef CONFIG_MACH_EUKREA_MBIMXSD25_BASEBOARD
+	eukrea_mbimxsd25_baseboard_init();
+#endif
+}
+
+static void __init eukrea_cpuimx25_timer_init(void)
+{
+	mx25_clocks_init();
+}
+
+static struct sys_timer eukrea_cpuimx25_timer = {
+	.init   = eukrea_cpuimx25_timer_init,
+};
+
+MACHINE_START(EUKREA_CPUIMX25, "Eukrea CPUIMX25")
+	/* Maintainer: Eukrea Electromatique */
+	.boot_params    = MX25_PHYS_OFFSET + 0x100,
+	.map_io         = mx25_map_io,
+	.init_irq       = mx25_init_irq,
+	.init_machine   = eukrea_cpuimx25_init,
+	.timer          = &eukrea_cpuimx25_timer,
+MACHINE_END
diff --git a/arch/arm/mach-imx/mach-mx25_3ds.c b/arch/arm/mach-imx/mach-mx25_3ds.c
new file mode 100644
index 0000000..328e1af
--- /dev/null
+++ b/arch/arm/mach-imx/mach-mx25_3ds.c
@@ -0,0 +1,223 @@
+/*
+ * Copyright 2009 Sascha Hauer, <kernel@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor,
+ * Boston, MA  02110-1301, USA.
+ */
+
+/*
+ * This machine is known as:
+ *  - i.MX25 3-Stack Development System
+ *  - i.MX25 Platform Development Kit (i.MX25 PDK)
+ */
+
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/irq.h>
+#include <linux/gpio.h>
+#include <linux/platform_device.h>
+#include <linux/input/matrix_keypad.h>
+
+#include <mach/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+#include <asm/memory.h>
+#include <asm/mach/map.h>
+#include <mach/common.h>
+#include <mach/mx25.h>
+#include <mach/iomux-mx25.h>
+
+#include "devices-imx25.h"
+
+static const struct imxuart_platform_data uart_pdata __initconst = {
+	.flags = IMXUART_HAVE_RTSCTS,
+};
+
+static struct pad_desc mx25pdk_pads[] = {
+	MX25_PAD_FEC_MDC__FEC_MDC,
+	MX25_PAD_FEC_MDIO__FEC_MDIO,
+	MX25_PAD_FEC_TDATA0__FEC_TDATA0,
+	MX25_PAD_FEC_TDATA1__FEC_TDATA1,
+	MX25_PAD_FEC_TX_EN__FEC_TX_EN,
+	MX25_PAD_FEC_RDATA0__FEC_RDATA0,
+	MX25_PAD_FEC_RDATA1__FEC_RDATA1,
+	MX25_PAD_FEC_RX_DV__FEC_RX_DV,
+	MX25_PAD_FEC_TX_CLK__FEC_TX_CLK,
+	MX25_PAD_A17__GPIO_2_3, /* FEC_EN, GPIO 35 */
+	MX25_PAD_D12__GPIO_4_8, /* FEC_RESET_B, GPIO 104 */
+
+	/* LCD */
+	MX25_PAD_LD0__LD0,
+	MX25_PAD_LD1__LD1,
+	MX25_PAD_LD2__LD2,
+	MX25_PAD_LD3__LD3,
+	MX25_PAD_LD4__LD4,
+	MX25_PAD_LD5__LD5,
+	MX25_PAD_LD6__LD6,
+	MX25_PAD_LD7__LD7,
+	MX25_PAD_LD8__LD8,
+	MX25_PAD_LD9__LD9,
+	MX25_PAD_LD10__LD10,
+	MX25_PAD_LD11__LD11,
+	MX25_PAD_LD12__LD12,
+	MX25_PAD_LD13__LD13,
+	MX25_PAD_LD14__LD14,
+	MX25_PAD_LD15__LD15,
+	MX25_PAD_GPIO_E__LD16,
+	MX25_PAD_GPIO_F__LD17,
+	MX25_PAD_HSYNC__HSYNC,
+	MX25_PAD_VSYNC__VSYNC,
+	MX25_PAD_LSCLK__LSCLK,
+	MX25_PAD_OE_ACD__OE_ACD,
+	MX25_PAD_CONTRAST__CONTRAST,
+
+	/* Keypad */
+	MX25_PAD_KPP_ROW0__KPP_ROW0,
+	MX25_PAD_KPP_ROW1__KPP_ROW1,
+	MX25_PAD_KPP_ROW2__KPP_ROW2,
+	MX25_PAD_KPP_ROW3__KPP_ROW3,
+	MX25_PAD_KPP_COL0__KPP_COL0,
+	MX25_PAD_KPP_COL1__KPP_COL1,
+	MX25_PAD_KPP_COL2__KPP_COL2,
+	MX25_PAD_KPP_COL3__KPP_COL3,
+
+	/* SD1 */
+	MX25_PAD_SD1_CMD__SD1_CMD,
+	MX25_PAD_SD1_CLK__SD1_CLK,
+	MX25_PAD_SD1_DATA0__SD1_DATA0,
+	MX25_PAD_SD1_DATA1__SD1_DATA1,
+	MX25_PAD_SD1_DATA2__SD1_DATA2,
+	MX25_PAD_SD1_DATA3__SD1_DATA3,
+};
+
+static const struct fec_platform_data mx25_fec_pdata __initconst = {
+        .phy    = PHY_INTERFACE_MODE_RMII,
+};
+
+#define FEC_ENABLE_GPIO		35
+#define FEC_RESET_B_GPIO	104
+
+static void __init mx25pdk_fec_reset(void)
+{
+	gpio_request(FEC_ENABLE_GPIO, "FEC PHY enable");
+	gpio_request(FEC_RESET_B_GPIO, "FEC PHY reset");
+
+	gpio_direction_output(FEC_ENABLE_GPIO, 0);  /* drop PHY power */
+	gpio_direction_output(FEC_RESET_B_GPIO, 0); /* assert reset */
+	udelay(2);
+
+	/* turn on PHY power and lift reset */
+	gpio_set_value(FEC_ENABLE_GPIO, 1);
+	gpio_set_value(FEC_RESET_B_GPIO, 1);
+}
+
+static const struct mxc_nand_platform_data
+mx25pdk_nand_board_info __initconst = {
+	.width		= 1,
+	.hw_ecc		= 1,
+	.flash_bbt	= 1,
+};
+
+static struct imx_fb_videomode mx25pdk_modes[] = {
+	{
+		.mode	= {
+			.name		= "CRT-VGA",
+			.refresh	= 60,
+			.xres		= 640,
+			.yres		= 480,
+			.pixclock	= 39683,
+			.left_margin	= 45,
+			.right_margin	= 114,
+			.upper_margin	= 33,
+			.lower_margin	= 11,
+			.hsync_len	= 1,
+			.vsync_len	= 1,
+		},
+		.bpp	= 16,
+		.pcr	= 0xFA208B80,
+	},
+};
+
+static const struct imx_fb_platform_data mx25pdk_fb_pdata __initconst = {
+	.mode		= mx25pdk_modes,
+	.num_modes	= ARRAY_SIZE(mx25pdk_modes),
+	.pwmr		= 0x00A903FF,
+	.lscr1		= 0x00120300,
+	.dmacr		= 0x00020010,
+};
+
+static const uint32_t mx25pdk_keymap[] = {
+	KEY(0, 0, KEY_UP),
+	KEY(0, 1, KEY_DOWN),
+	KEY(0, 2, KEY_VOLUMEDOWN),
+	KEY(0, 3, KEY_HOME),
+	KEY(1, 0, KEY_RIGHT),
+	KEY(1, 1, KEY_LEFT),
+	KEY(1, 2, KEY_ENTER),
+	KEY(1, 3, KEY_VOLUMEUP),
+	KEY(2, 0, KEY_F6),
+	KEY(2, 1, KEY_F8),
+	KEY(2, 2, KEY_F9),
+	KEY(2, 3, KEY_F10),
+	KEY(3, 0, KEY_F1),
+	KEY(3, 1, KEY_F2),
+	KEY(3, 2, KEY_F3),
+	KEY(3, 3, KEY_POWER),
+};
+
+static const struct matrix_keymap_data mx25pdk_keymap_data __initdata = {
+	.keymap		= mx25pdk_keymap,
+	.keymap_size	= ARRAY_SIZE(mx25pdk_keymap),
+};
+
+static void __init mx25pdk_init(void)
+{
+	mxc_iomux_v3_setup_multiple_pads(mx25pdk_pads,
+			ARRAY_SIZE(mx25pdk_pads));
+
+	imx25_add_imx_uart0(&uart_pdata);
+	imx25_add_mxc_ehci_hs(NULL);
+	imx25_add_mxc_nand(&mx25pdk_nand_board_info);
+	imx25_add_imxdi_rtc(NULL);
+	imx25_add_imx_fb(&mx25pdk_fb_pdata);
+	imx25_add_imx2_wdt(NULL);
+
+	mx25pdk_fec_reset();
+	imx25_add_fec(&mx25_fec_pdata);
+	imx25_add_imx_keypad(&mx25pdk_keymap_data);
+
+	imx25_add_esdhc(0, NULL);
+}
+
+static void __init mx25pdk_timer_init(void)
+{
+	mx25_clocks_init();
+}
+
+static struct sys_timer mx25pdk_timer = {
+	.init   = mx25pdk_timer_init,
+};
+
+MACHINE_START(MX25_3DS, "Freescale MX25PDK (3DS)")
+	/* Maintainer: Freescale Semiconductor, Inc. */
+	.boot_params    = MX25_PHYS_OFFSET + 0x100,
+	.map_io         = mx25_map_io,
+	.init_irq       = mx25_init_irq,
+	.init_machine   = mx25pdk_init,
+	.timer          = &mx25pdk_timer,
+MACHINE_END
+
diff --git a/arch/arm/mach-imx/mm-imx25.c b/arch/arm/mach-imx/mm-imx25.c
new file mode 100644
index 0000000..2edec6c
--- /dev/null
+++ b/arch/arm/mach-imx/mm-imx25.c
@@ -0,0 +1,62 @@
+/*
+ *  Copyright (C) 1999,2000 Arm Limited
+ *  Copyright (C) 2000 Deep Blue Solutions Ltd
+ *  Copyright (C) 2002 Shane Nay (shane at minirl.com)
+ *  Copyright 2005-2007 Freescale Semiconductor, Inc. All Rights Reserved.
+ *    - add MX31 specific definitions
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
+ */
+
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/err.h>
+
+#include <asm/pgtable.h>
+#include <asm/mach/map.h>
+
+#include <mach/common.h>
+#include <mach/hardware.h>
+#include <mach/mx25.h>
+#include <mach/iomux-v3.h>
+
+/*
+ * This table defines static virtual address mappings for I/O regions.
+ * These are the mappings common across all MX25 boards.
+ */
+static struct map_desc mx25_io_desc[] __initdata = {
+	imx_map_entry(MX25, AVIC, MT_DEVICE_NONSHARED),
+	imx_map_entry(MX25, AIPS1, MT_DEVICE_NONSHARED),
+	imx_map_entry(MX25, AIPS2, MT_DEVICE_NONSHARED),
+};
+
+/*
+ * This function initializes the memory map. It is called during the
+ * system startup to create static physical to virtual memory mappings
+ * for the IO modules.
+ */
+void __init mx25_map_io(void)
+{
+	mxc_set_cpu_type(MXC_CPU_MX25);
+	mxc_iomux_v3_init(MX25_IO_ADDRESS(MX25_IOMUXC_BASE_ADDR));
+	mxc_arch_reset_init(MX25_IO_ADDRESS(MX25_WDOG_BASE_ADDR));
+
+	iotable_init(mx25_io_desc, ARRAY_SIZE(mx25_io_desc));
+}
+
+int imx25_register_gpios(void);
+
+void __init mx25_init_irq(void)
+{
+	mxc_init_irq(MX25_IO_ADDRESS(MX25_AVIC_BASE_ADDR));
+	imx25_register_gpios();
+}
+
diff --git a/arch/arm/mach-mx25/Kconfig b/arch/arm/mach-mx25/Kconfig
deleted file mode 100644
index d152af2..0000000
--- a/arch/arm/mach-mx25/Kconfig
+++ /dev/null
@@ -1,43 +0,0 @@
-if ARCH_MX25
-
-comment "MX25 platforms:"
-
-config MACH_MX25_3DS
-	bool "Support MX25PDK (3DS) Platform"
-	select IMX_HAVE_PLATFORM_ESDHC
-	select IMX_HAVE_PLATFORM_IMXDI_RTC
-	select IMX_HAVE_PLATFORM_IMX2_WDT
-	select IMX_HAVE_PLATFORM_IMX_FB
-	select IMX_HAVE_PLATFORM_IMX_KEYPAD
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_MXC_EHCI
-	select IMX_HAVE_PLATFORM_MXC_NAND
-
-config MACH_EUKREA_CPUIMX25
-	bool "Support Eukrea CPUIMX25 Platform"
-	select IMX_HAVE_PLATFORM_ESDHC
-	select IMX_HAVE_PLATFORM_FLEXCAN
-	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
-	select IMX_HAVE_PLATFORM_IMXDI_RTC
-	select IMX_HAVE_PLATFORM_IMX_FB
-	select IMX_HAVE_PLATFORM_IMX_I2C
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_MXC_EHCI
-	select IMX_HAVE_PLATFORM_MXC_NAND
-	select MXC_ULPI if USB_ULPI
-
-choice
-	prompt "Baseboard"
-	depends on MACH_EUKREA_CPUIMX25
-	default MACH_EUKREA_MBIMXSD25_BASEBOARD
-
-config MACH_EUKREA_MBIMXSD25_BASEBOARD
-	bool "Eukrea MBIMXSD development board"
-	select IMX_HAVE_PLATFORM_IMX_SSI
-	help
-	  This adds board specific devices that can be found on Eukrea's
-	  MBIMXSD evaluation board.
-
-endchoice
-
-endif
diff --git a/arch/arm/mach-mx25/Makefile b/arch/arm/mach-mx25/Makefile
deleted file mode 100644
index f7f7648..0000000
--- a/arch/arm/mach-mx25/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-obj-y				:= mm.o
-obj-$(CONFIG_ARCH_MX25)		+= clock.o
-obj-$(CONFIG_MACH_MX25_3DS)	+= mach-mx25_3ds.o
-obj-$(CONFIG_MACH_EUKREA_CPUIMX25)		+= mach-cpuimx25.o
-obj-$(CONFIG_MACH_EUKREA_MBIMXSD25_BASEBOARD)	+= eukrea_mbimxsd-baseboard.o
diff --git a/arch/arm/mach-mx25/Makefile.boot b/arch/arm/mach-mx25/Makefile.boot
deleted file mode 100644
index e1dd366..0000000
--- a/arch/arm/mach-mx25/Makefile.boot
+++ /dev/null
@@ -1,3 +0,0 @@
-   zreladdr-y	:= 0x80008000
-params_phys-y	:= 0x80000100
-initrd_phys-y	:= 0x80800000
diff --git a/arch/arm/mach-mx25/clock.c b/arch/arm/mach-mx25/clock.c
deleted file mode 100644
index 9e4a557..0000000
--- a/arch/arm/mach-mx25/clock.c
+++ /dev/null
@@ -1,332 +0,0 @@
-/*
- * Copyright (C) 2009 by Sascha Hauer, Pengutronix
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
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/list.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-
-#include <asm/clkdev.h>
-
-#include <mach/clock.h>
-#include <mach/hardware.h>
-#include <mach/common.h>
-#include <mach/mx25.h>
-
-#define CRM_BASE	MX25_IO_ADDRESS(MX25_CRM_BASE_ADDR)
-
-#define CCM_MPCTL	0x00
-#define CCM_UPCTL	0x04
-#define CCM_CCTL	0x08
-#define CCM_CGCR0	0x0C
-#define CCM_CGCR1	0x10
-#define CCM_CGCR2	0x14
-#define CCM_PCDR0	0x18
-#define CCM_PCDR1	0x1C
-#define CCM_PCDR2	0x20
-#define CCM_PCDR3	0x24
-#define CCM_RCSR	0x28
-#define CCM_CRDR	0x2C
-#define CCM_DCVR0	0x30
-#define CCM_DCVR1	0x34
-#define CCM_DCVR2	0x38
-#define CCM_DCVR3	0x3c
-#define CCM_LTR0	0x40
-#define CCM_LTR1	0x44
-#define CCM_LTR2	0x48
-#define CCM_LTR3	0x4c
-
-static unsigned long get_rate_mpll(void)
-{
-	ulong mpctl = __raw_readl(CRM_BASE + CCM_MPCTL);
-
-	return mxc_decode_pll(mpctl, 24000000);
-}
-
-static unsigned long get_rate_upll(void)
-{
-	ulong mpctl = __raw_readl(CRM_BASE + CCM_UPCTL);
-
-	return mxc_decode_pll(mpctl, 24000000);
-}
-
-unsigned long get_rate_arm(struct clk *clk)
-{
-	unsigned long cctl = readl(CRM_BASE + CCM_CCTL);
-	unsigned long rate = get_rate_mpll();
-
-	if (cctl & (1 << 14))
-		rate = (rate * 3) >> 2;
-
-	return rate / ((cctl >> 30) + 1);
-}
-
-static unsigned long get_rate_ahb(struct clk *clk)
-{
-	unsigned long cctl = readl(CRM_BASE + CCM_CCTL);
-
-	return get_rate_arm(NULL) / (((cctl >> 28) & 0x3) + 1);
-}
-
-static unsigned long get_rate_ipg(struct clk *clk)
-{
-	return get_rate_ahb(NULL) >> 1;
-}
-
-static unsigned long get_rate_per(int per)
-{
-	unsigned long ofs = (per & 0x3) * 8;
-	unsigned long reg = per & ~0x3;
-	unsigned long val = (readl(CRM_BASE + CCM_PCDR0 + reg) >> ofs) & 0x3f;
-	unsigned long fref;
-
-	if (readl(CRM_BASE + 0x64) & (1 << per))
-		fref = get_rate_upll();
-	else
-		fref = get_rate_ahb(NULL);
-
-	return fref / (val + 1);
-}
-
-static unsigned long get_rate_uart(struct clk *clk)
-{
-	return get_rate_per(15);
-}
-
-static unsigned long get_rate_ssi2(struct clk *clk)
-{
-	return get_rate_per(14);
-}
-
-static unsigned long get_rate_ssi1(struct clk *clk)
-{
-	return get_rate_per(13);
-}
-
-static unsigned long get_rate_i2c(struct clk *clk)
-{
-	return get_rate_per(6);
-}
-
-static unsigned long get_rate_nfc(struct clk *clk)
-{
-	return get_rate_per(8);
-}
-
-static unsigned long get_rate_gpt(struct clk *clk)
-{
-	return get_rate_per(5);
-}
-
-static unsigned long get_rate_lcdc(struct clk *clk)
-{
-	return get_rate_per(7);
-}
-
-static unsigned long get_rate_esdhc1(struct clk *clk)
-{
-	return get_rate_per(3);
-}
-
-static unsigned long get_rate_esdhc2(struct clk *clk)
-{
-	return get_rate_per(4);
-}
-
-static unsigned long get_rate_csi(struct clk *clk)
-{
-	return get_rate_per(0);
-}
-
-static unsigned long get_rate_otg(struct clk *clk)
-{
-	unsigned long cctl = readl(CRM_BASE + CCM_CCTL);
-	unsigned long rate = get_rate_upll();
-
-	return (cctl & (1 << 23)) ? 0 : rate / ((0x3F & (cctl >> 16)) + 1);
-}
-
-static int clk_cgcr_enable(struct clk *clk)
-{
-	u32 reg;
-
-	reg = __raw_readl(clk->enable_reg);
-	reg |= 1 << clk->enable_shift;
-	__raw_writel(reg, clk->enable_reg);
-
-	return 0;
-}
-
-static void clk_cgcr_disable(struct clk *clk)
-{
-	u32 reg;
-
-	reg = __raw_readl(clk->enable_reg);
-	reg &= ~(1 << clk->enable_shift);
-	__raw_writel(reg, clk->enable_reg);
-}
-
-#define DEFINE_CLOCK(name, i, er, es, gr, sr, s)	\
-	static struct clk name = {			\
-		.id		= i,			\
-		.enable_reg	= CRM_BASE + er,	\
-		.enable_shift	= es,			\
-		.get_rate	= gr,			\
-		.set_rate	= sr,			\
-		.enable		= clk_cgcr_enable,	\
-		.disable	= clk_cgcr_disable,	\
-		.secondary	= s,			\
-	}
-
-/*
- * Note: the following IPG clock gating bits are wrongly marked "Reserved" in
- * the i.MX25 Reference Manual Rev 1, table 15-13. The information below is
- * taken from the Freescale released BSP.
- *
- * bit	reg	offset	clock
- *
- * 0	CGCR1	0	AUDMUX
- * 12	CGCR1	12	ESAI
- * 16	CGCR1	16	GPIO1
- * 17	CGCR1	17	GPIO2
- * 18	CGCR1	18	GPIO3
- * 23	CGCR1	23	I2C1
- * 24	CGCR1	24	I2C2
- * 25	CGCR1	25	I2C3
- * 27	CGCR1	27	IOMUXC
- * 28	CGCR1	28	KPP
- * 30	CGCR1	30	OWIRE
- * 36	CGCR2	4	RTIC
- * 51	CGCR2	19	WDOG
- */
-
-DEFINE_CLOCK(gpt_clk,    0, CCM_CGCR0,  5, get_rate_gpt, NULL, NULL);
-DEFINE_CLOCK(uart_per_clk, 0, CCM_CGCR0, 15, get_rate_uart, NULL, NULL);
-DEFINE_CLOCK(ssi1_per_clk, 0, CCM_CGCR0, 13, get_rate_ipg, NULL, NULL);
-DEFINE_CLOCK(ssi2_per_clk, 0, CCM_CGCR0, 14, get_rate_ipg, NULL, NULL);
-DEFINE_CLOCK(cspi1_clk,  0, CCM_CGCR1,  5, get_rate_ipg, NULL, NULL);
-DEFINE_CLOCK(cspi2_clk,  0, CCM_CGCR1,  6, get_rate_ipg, NULL, NULL);
-DEFINE_CLOCK(cspi3_clk,  0, CCM_CGCR1,  7, get_rate_ipg, NULL, NULL);
-DEFINE_CLOCK(esdhc1_ahb_clk, 0, CCM_CGCR0, 21, get_rate_esdhc1,	 NULL, NULL);
-DEFINE_CLOCK(esdhc1_per_clk, 0, CCM_CGCR0,  3, get_rate_esdhc1,	 NULL,
-		&esdhc1_ahb_clk);
-DEFINE_CLOCK(esdhc2_ahb_clk, 0, CCM_CGCR0, 22, get_rate_esdhc2,	 NULL, NULL);
-DEFINE_CLOCK(esdhc2_per_clk, 0, CCM_CGCR0,  4, get_rate_esdhc2,	 NULL,
-		&esdhc2_ahb_clk);
-DEFINE_CLOCK(fec_ahb_clk, 0, CCM_CGCR0, 23, NULL,	 NULL, NULL);
-DEFINE_CLOCK(lcdc_ahb_clk, 0, CCM_CGCR0, 24, NULL,	 NULL, NULL);
-DEFINE_CLOCK(lcdc_per_clk, 0, CCM_CGCR0,  7, NULL,	 NULL, &lcdc_ahb_clk);
-DEFINE_CLOCK(csi_ahb_clk, 0, CCM_CGCR0, 18, get_rate_csi, NULL, NULL);
-DEFINE_CLOCK(csi_per_clk, 0, CCM_CGCR0, 0, get_rate_csi, NULL, &csi_ahb_clk);
-DEFINE_CLOCK(uart1_clk,  0, CCM_CGCR2, 14, get_rate_uart, NULL, &uart_per_clk);
-DEFINE_CLOCK(uart2_clk,  0, CCM_CGCR2, 15, get_rate_uart, NULL, &uart_per_clk);
-DEFINE_CLOCK(uart3_clk,  0, CCM_CGCR2, 16, get_rate_uart, NULL, &uart_per_clk);
-DEFINE_CLOCK(uart4_clk,  0, CCM_CGCR2, 17, get_rate_uart, NULL, &uart_per_clk);
-DEFINE_CLOCK(uart5_clk,  0, CCM_CGCR2, 18, get_rate_uart, NULL, &uart_per_clk);
-DEFINE_CLOCK(nfc_clk,    0, CCM_CGCR0,  8, get_rate_nfc, NULL, NULL);
-DEFINE_CLOCK(usbotg_clk, 0, CCM_CGCR0, 28, get_rate_otg, NULL, NULL);
-DEFINE_CLOCK(pwm1_clk,	 0, CCM_CGCR1, 31, get_rate_ipg, NULL, NULL);
-DEFINE_CLOCK(pwm2_clk,	 0, CCM_CGCR2,  0, get_rate_ipg, NULL, NULL);
-DEFINE_CLOCK(pwm3_clk,	 0, CCM_CGCR2,  1, get_rate_ipg, NULL, NULL);
-DEFINE_CLOCK(pwm4_clk,	 0, CCM_CGCR2,  2, get_rate_ipg, NULL, NULL);
-DEFINE_CLOCK(kpp_clk,	 0, CCM_CGCR1, 28, get_rate_ipg, NULL, NULL);
-DEFINE_CLOCK(tsc_clk,	 0, CCM_CGCR2, 13, get_rate_ipg, NULL, NULL);
-DEFINE_CLOCK(i2c_clk,	 0, CCM_CGCR0,  6, get_rate_i2c, NULL, NULL);
-DEFINE_CLOCK(fec_clk,	 0, CCM_CGCR1, 15, get_rate_ipg, NULL, &fec_ahb_clk);
-DEFINE_CLOCK(dryice_clk, 0, CCM_CGCR1,  8, get_rate_ipg, NULL, NULL);
-DEFINE_CLOCK(lcdc_clk,	 0, CCM_CGCR1, 29, get_rate_lcdc, NULL, &lcdc_per_clk);
-DEFINE_CLOCK(wdt_clk,    0, CCM_CGCR2, 19, get_rate_ipg, NULL,  NULL);
-DEFINE_CLOCK(ssi1_clk,  0, CCM_CGCR2, 11, get_rate_ssi1, NULL, &ssi1_per_clk);
-DEFINE_CLOCK(ssi2_clk,  1, CCM_CGCR2, 12, get_rate_ssi2, NULL, &ssi2_per_clk);
-DEFINE_CLOCK(esdhc1_clk,  0, CCM_CGCR1, 13, get_rate_esdhc1, NULL,
-		&esdhc1_per_clk);
-DEFINE_CLOCK(esdhc2_clk,  1, CCM_CGCR1, 14, get_rate_esdhc2, NULL,
-		&esdhc2_per_clk);
-DEFINE_CLOCK(audmux_clk, 0, CCM_CGCR1, 0, NULL, NULL, NULL);
-DEFINE_CLOCK(csi_clk,    0, CCM_CGCR1,  4, get_rate_csi, NULL,  &csi_per_clk);
-DEFINE_CLOCK(can1_clk,	 0, CCM_CGCR1,  2, get_rate_ipg, NULL, NULL);
-DEFINE_CLOCK(can2_clk,	 1, CCM_CGCR1,  3, get_rate_ipg, NULL, NULL);
-
-#define _REGISTER_CLOCK(d, n, c)	\
-	{				\
-		.dev_id = d,		\
-		.con_id = n,		\
-		.clk = &c,		\
-	},
-
-static struct clk_lookup lookups[] = {
-	_REGISTER_CLOCK("imx-uart.0", NULL, uart1_clk)
-	_REGISTER_CLOCK("imx-uart.1", NULL, uart2_clk)
-	_REGISTER_CLOCK("imx-uart.2", NULL, uart3_clk)
-	_REGISTER_CLOCK("imx-uart.3", NULL, uart4_clk)
-	_REGISTER_CLOCK("imx-uart.4", NULL, uart5_clk)
-	_REGISTER_CLOCK("mxc-ehci.0", "usb", usbotg_clk)
-	_REGISTER_CLOCK("mxc-ehci.1", "usb", usbotg_clk)
-	_REGISTER_CLOCK("mxc-ehci.2", "usb", usbotg_clk)
-	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usbotg_clk)
-	_REGISTER_CLOCK("mxc_nand.0", NULL, nfc_clk)
-	_REGISTER_CLOCK("imx25-cspi.0", NULL, cspi1_clk)
-	_REGISTER_CLOCK("imx25-cspi.1", NULL, cspi2_clk)
-	_REGISTER_CLOCK("imx25-cspi.2", NULL, cspi3_clk)
-	_REGISTER_CLOCK("mxc_pwm.0", NULL, pwm1_clk)
-	_REGISTER_CLOCK("mxc_pwm.1", NULL, pwm2_clk)
-	_REGISTER_CLOCK("mxc_pwm.2", NULL, pwm3_clk)
-	_REGISTER_CLOCK("mxc_pwm.3", NULL, pwm4_clk)
-	_REGISTER_CLOCK("imx-keypad", NULL, kpp_clk)
-	_REGISTER_CLOCK("mx25-adc", NULL, tsc_clk)
-	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c_clk)
-	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c_clk)
-	_REGISTER_CLOCK("imx-i2c.2", NULL, i2c_clk)
-	_REGISTER_CLOCK("fec.0", NULL, fec_clk)
-	_REGISTER_CLOCK("imxdi_rtc.0", NULL, dryice_clk)
-	_REGISTER_CLOCK("imx-fb.0", NULL, lcdc_clk)
-	_REGISTER_CLOCK("imx-wdt.0", NULL, wdt_clk)
-	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
-	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx.0", NULL, esdhc1_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx.1", NULL, esdhc2_clk)
-	_REGISTER_CLOCK("mx2-camera.0", NULL, csi_clk)
-	_REGISTER_CLOCK(NULL, "audmux", audmux_clk)
-	_REGISTER_CLOCK("flexcan.0", NULL, can1_clk)
-	_REGISTER_CLOCK("flexcan.1", NULL, can2_clk)
-};
-
-int __init mx25_clocks_init(void)
-{
-	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
-
-	/* Turn off all clocks except the ones we need to survive, namely:
-	 * EMI, GPIO1-3 (CCM_CGCR1[18:16]), GPT1, IOMUXC (CCM_CGCR1[27]), IIM,
-	 * SCC
-	 */
-	__raw_writel((1 << 19), CRM_BASE + CCM_CGCR0);
-	__raw_writel((0xf << 16) | (3 << 26), CRM_BASE + CCM_CGCR1);
-	__raw_writel((1 << 5), CRM_BASE + CCM_CGCR2);
-#if defined(CONFIG_DEBUG_LL) && !defined(CONFIG_DEBUG_ICEDCC)
-	clk_enable(&uart1_clk);
-#endif
-
-	/* Clock source for lcdc and csi is upll */
-	__raw_writel(__raw_readl(CRM_BASE+0x64) | (1 << 7) | (1 << 0),
-			CRM_BASE + 0x64);
-
-	mxc_timer_init(&gpt_clk, MX25_IO_ADDRESS(MX25_GPT1_BASE_ADDR), 54);
-
-	return 0;
-}
diff --git a/arch/arm/mach-mx25/devices-imx25.h b/arch/arm/mach-mx25/devices-imx25.h
deleted file mode 100644
index 953e1ce..0000000
--- a/arch/arm/mach-mx25/devices-imx25.h
+++ /dev/null
@@ -1,86 +0,0 @@
-/*
- * Copyright (C) 2010 Pengutronix
- * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
- *
- * This program is free software; you can redistribute it and/or modify it under
- * the terms of the GNU General Public License version 2 as published by the
- * Free Software Foundation.
- */
-#include <mach/mx25.h>
-#include <mach/devices-common.h>
-
-extern const struct imx_fec_data imx25_fec_data __initconst;
-#define imx25_add_fec(pdata)	\
-	imx_add_fec(&imx25_fec_data, pdata)
-
-extern const struct imx_flexcan_data imx25_flexcan_data[] __initconst;
-#define imx25_add_flexcan(id, pdata)	\
-	imx_add_flexcan(&imx25_flexcan_data[id], pdata)
-#define imx25_add_flexcan0(pdata)	imx25_add_flexcan(0, pdata)
-#define imx25_add_flexcan1(pdata)	imx25_add_flexcan(1, pdata)
-
-extern const struct imx_fsl_usb2_udc_data imx25_fsl_usb2_udc_data __initconst;
-#define imx25_add_fsl_usb2_udc(pdata)	\
-	imx_add_fsl_usb2_udc(&imx25_fsl_usb2_udc_data, pdata)
-
-extern struct imx_imxdi_rtc_data imx25_imxdi_rtc_data __initconst;
-#define imx25_add_imxdi_rtc(pdata)	\
-	imx_add_imxdi_rtc(&imx25_imxdi_rtc_data)
-
-extern const struct imx_imx2_wdt_data imx25_imx2_wdt_data __initconst;
-#define imx25_add_imx2_wdt(pdata)	\
-	imx_add_imx2_wdt(&imx25_imx2_wdt_data)
-
-extern const struct imx_imx_fb_data imx25_imx_fb_data __initconst;
-#define imx25_add_imx_fb(pdata)	\
-	imx_add_imx_fb(&imx25_imx_fb_data, pdata)
-
-extern const struct imx_imx_i2c_data imx25_imx_i2c_data[] __initconst;
-#define imx25_add_imx_i2c(id, pdata)	\
-	imx_add_imx_i2c(&imx25_imx_i2c_data[id], pdata)
-#define imx25_add_imx_i2c0(pdata)	imx25_add_imx_i2c(0, pdata)
-#define imx25_add_imx_i2c1(pdata)	imx25_add_imx_i2c(1, pdata)
-#define imx25_add_imx_i2c2(pdata)	imx25_add_imx_i2c(2, pdata)
-
-extern const struct imx_imx_keypad_data imx25_imx_keypad_data __initconst;
-#define imx25_add_imx_keypad(pdata)	\
-	imx_add_imx_keypad(&imx25_imx_keypad_data, pdata)
-
-extern const struct imx_imx_ssi_data imx25_imx_ssi_data[] __initconst;
-#define imx25_add_imx_ssi(id, pdata)	\
-	imx_add_imx_ssi(&imx25_imx_ssi_data[id], pdata)
-
-extern const struct imx_imx_uart_1irq_data imx25_imx_uart_data[] __initconst;
-#define imx25_add_imx_uart(id, pdata)	\
-	imx_add_imx_uart_1irq(&imx25_imx_uart_data[id], pdata)
-#define imx25_add_imx_uart0(pdata)	imx25_add_imx_uart(0, pdata)
-#define imx25_add_imx_uart1(pdata)	imx25_add_imx_uart(1, pdata)
-#define imx25_add_imx_uart2(pdata)	imx25_add_imx_uart(2, pdata)
-#define imx25_add_imx_uart3(pdata)	imx25_add_imx_uart(3, pdata)
-#define imx25_add_imx_uart4(pdata)	imx25_add_imx_uart(4, pdata)
-
-extern const struct imx_mx2_camera_data imx25_mx2_camera_data __initconst;
-#define imx25_add_mx2_camera(pdata)	\
-	imx_add_mx2_camera(&imx25_mx2_camera_data, pdata)
-
-extern const struct imx_mxc_ehci_data imx25_mxc_ehci_otg_data __initconst;
-#define imx25_add_mxc_ehci_otg(pdata)	\
-	imx_add_mxc_ehci(&imx25_mxc_ehci_otg_data, pdata)
-extern const struct imx_mxc_ehci_data imx25_mxc_ehci_hs_data __initconst;
-#define imx25_add_mxc_ehci_hs(pdata)	\
-	imx_add_mxc_ehci(&imx25_mxc_ehci_hs_data, pdata)
-
-extern const struct imx_mxc_nand_data imx25_mxc_nand_data __initconst;
-#define imx25_add_mxc_nand(pdata)	\
-	imx_add_mxc_nand(&imx25_mxc_nand_data, pdata)
-
-extern const struct imx_spi_imx_data imx25_spi_imx_data[] __initconst;
-#define imx25_add_spi_imx(id, pdata)	\
-	imx_add_spi_imx(&imx25_spi_imx_data[id], pdata)
-#define imx25_add_spi_imx0(pdata)	imx25_add_spi_imx(0, pdata)
-#define imx25_add_spi_imx1(pdata)	imx25_add_spi_imx(1, pdata)
-#define imx25_add_spi_imx2(pdata)	imx25_add_spi_imx(2, pdata)
-
-extern const struct imx_esdhc_imx_data imx25_esdhc_data[] __initconst;
-#define imx25_add_esdhc(id, pdata)	\
-	imx_add_esdhc(&imx25_esdhc_data[id], pdata)
diff --git a/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
deleted file mode 100644
index 75a5db5..0000000
--- a/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
+++ /dev/null
@@ -1,296 +0,0 @@
-/*
- * Copyright (C) 2010 Eric Benard - eric at eukrea.com
- *
- * Based on pcm970-baseboard.c which is :
- * Copyright (C) 2008 Juergen Beisert (kernel at pengutronix.de)
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
-
-#include <linux/gpio.h>
-#include <linux/leds.h>
-#include <linux/platform_device.h>
-#include <linux/gpio_keys.h>
-#include <linux/input.h>
-#include <video/platform_lcd.h>
-
-#include <mach/hardware.h>
-#include <mach/iomux-mx25.h>
-#include <mach/common.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <mach/mx25.h>
-#include <mach/imx-uart.h>
-#include <mach/audmux.h>
-
-#include "devices-imx25.h"
-
-static struct pad_desc eukrea_mbimxsd_pads[] = {
-	/* LCD */
-	MX25_PAD_LD0__LD0,
-	MX25_PAD_LD1__LD1,
-	MX25_PAD_LD2__LD2,
-	MX25_PAD_LD3__LD3,
-	MX25_PAD_LD4__LD4,
-	MX25_PAD_LD5__LD5,
-	MX25_PAD_LD6__LD6,
-	MX25_PAD_LD7__LD7,
-	MX25_PAD_LD8__LD8,
-	MX25_PAD_LD9__LD9,
-	MX25_PAD_LD10__LD10,
-	MX25_PAD_LD11__LD11,
-	MX25_PAD_LD12__LD12,
-	MX25_PAD_LD13__LD13,
-	MX25_PAD_LD14__LD14,
-	MX25_PAD_LD15__LD15,
-	MX25_PAD_GPIO_E__LD16,
-	MX25_PAD_GPIO_F__LD17,
-	MX25_PAD_HSYNC__HSYNC,
-	MX25_PAD_VSYNC__VSYNC,
-	MX25_PAD_LSCLK__LSCLK,
-	MX25_PAD_OE_ACD__OE_ACD,
-	MX25_PAD_CONTRAST__CONTRAST,
-	/* LCD_PWR */
-	MX25_PAD_PWM__GPIO_1_26,
-	/* LED */
-	MX25_PAD_POWER_FAIL__GPIO_3_19,
-	/* SWITCH */
-	MX25_PAD_VSTBY_ACK__GPIO_3_18,
-	/* UART2 */
-	MX25_PAD_UART2_RTS__UART2_RTS,
-	MX25_PAD_UART2_CTS__UART2_CTS,
-	MX25_PAD_UART2_TXD__UART2_TXD,
-	MX25_PAD_UART2_RXD__UART2_RXD,
-	/* SD1 */
-	MX25_PAD_SD1_CMD__SD1_CMD,
-	MX25_PAD_SD1_CLK__SD1_CLK,
-	MX25_PAD_SD1_DATA0__SD1_DATA0,
-	MX25_PAD_SD1_DATA1__SD1_DATA1,
-	MX25_PAD_SD1_DATA2__SD1_DATA2,
-	MX25_PAD_SD1_DATA3__SD1_DATA3,
-	/* SD1 CD */
-	MX25_PAD_DE_B__GPIO_2_20,
-	/* I2S */
-	MX25_PAD_KPP_COL3__AUD5_TXFS,
-	MX25_PAD_KPP_COL2__AUD5_TXC,
-	MX25_PAD_KPP_COL1__AUD5_RXD,
-	MX25_PAD_KPP_COL0__AUD5_TXD,
-	/* CAN */
-	MX25_PAD_GPIO_D__CAN2_RX,
-	MX25_PAD_GPIO_C__CAN2_TX,
-};
-
-#define GPIO_LED1	83
-#define GPIO_SWITCH1	82
-#define GPIO_SD1CD	52
-#define GPIO_LCDPWR	26
-
-static struct imx_fb_videomode eukrea_mximxsd_modes[] = {
-	{
-		.mode	= {
-			.name		= "CMO-QVGA",
-			.refresh	= 60,
-			.xres		= 320,
-			.yres		= 240,
-			.pixclock	= KHZ2PICOS(6500),
-			.left_margin	= 30,
-			.right_margin	= 38,
-			.upper_margin	= 20,
-			.lower_margin	= 3,
-			.hsync_len	= 15,
-			.vsync_len	= 4,
-		},
-		.bpp	= 16,
-		.pcr	= 0xCAD08B80,
-	}, {
-		.mode = {
-			.name		= "DVI-VGA",
-			.refresh	= 60,
-			.xres		= 640,
-			.yres		= 480,
-			.pixclock	= 32000,
-			.hsync_len	= 7,
-			.left_margin	= 100,
-			.right_margin	= 100,
-			.vsync_len	= 7,
-			.upper_margin	= 7,
-			.lower_margin	= 100,
-		},
-		.pcr		= 0xFA208B80,
-		.bpp		= 16,
-	}, {
-		.mode = {
-			.name		= "DVI-SVGA",
-			.refresh	= 60,
-			.xres		= 800,
-			.yres		= 600,
-			.pixclock	= 25000,
-			.hsync_len	= 7,
-			.left_margin	= 75,
-			.right_margin	= 75,
-			.vsync_len	= 7,
-			.upper_margin	= 7,
-			.lower_margin	= 75,
-		},
-		.pcr		= 0xFA208B80,
-		.bpp		= 16,
-	},
-};
-
-static const struct imx_fb_platform_data eukrea_mximxsd_fb_pdata __initconst = {
-	.mode		= eukrea_mximxsd_modes,
-	.num_modes	= ARRAY_SIZE(eukrea_mximxsd_modes),
-	.pwmr		= 0x00A903FF,
-	.lscr1		= 0x00120300,
-	.dmacr		= 0x00040060,
-};
-
-static void eukrea_mbimxsd_lcd_power_set(struct plat_lcd_data *pd,
-				   unsigned int power)
-{
-	if (power)
-		gpio_direction_output(GPIO_LCDPWR, 1);
-	else
-		gpio_direction_output(GPIO_LCDPWR, 0);
-}
-
-static struct plat_lcd_data eukrea_mbimxsd_lcd_power_data = {
-	.set_power		= eukrea_mbimxsd_lcd_power_set,
-};
-
-static struct platform_device eukrea_mbimxsd_lcd_powerdev = {
-	.name			= "platform-lcd",
-	.dev.platform_data	= &eukrea_mbimxsd_lcd_power_data,
-};
-
-static struct gpio_led eukrea_mbimxsd_leds[] = {
-	{
-		.name			= "led1",
-		.default_trigger	= "heartbeat",
-		.active_low		= 1,
-		.gpio			= GPIO_LED1,
-	},
-};
-
-static struct gpio_led_platform_data eukrea_mbimxsd_led_info = {
-	.leds		= eukrea_mbimxsd_leds,
-	.num_leds	= ARRAY_SIZE(eukrea_mbimxsd_leds),
-};
-
-static struct platform_device eukrea_mbimxsd_leds_gpio = {
-	.name	= "leds-gpio",
-	.id	= -1,
-	.dev	= {
-		.platform_data	= &eukrea_mbimxsd_led_info,
-	},
-};
-
-static struct gpio_keys_button eukrea_mbimxsd_gpio_buttons[] = {
-	{
-		.gpio		= GPIO_SWITCH1,
-		.code		= BTN_0,
-		.desc		= "BP1",
-		.active_low	= 1,
-		.wakeup		= 1,
-	},
-};
-
-static struct gpio_keys_platform_data eukrea_mbimxsd_button_data = {
-	.buttons	= eukrea_mbimxsd_gpio_buttons,
-	.nbuttons	= ARRAY_SIZE(eukrea_mbimxsd_gpio_buttons),
-};
-
-static struct platform_device eukrea_mbimxsd_button_device = {
-	.name		= "gpio-keys",
-	.id		= -1,
-	.num_resources	= 0,
-	.dev		= {
-		.platform_data	= &eukrea_mbimxsd_button_data,
-	}
-};
-
-static struct platform_device *platform_devices[] __initdata = {
-	&eukrea_mbimxsd_leds_gpio,
-	&eukrea_mbimxsd_button_device,
-	&eukrea_mbimxsd_lcd_powerdev,
-};
-
-static const struct imxuart_platform_data uart_pdata __initconst = {
-	.flags = IMXUART_HAVE_RTSCTS,
-};
-
-static struct i2c_board_info eukrea_mbimxsd_i2c_devices[] = {
-	{
-		I2C_BOARD_INFO("tlv320aic23", 0x1a),
-	},
-};
-
-static const
-struct imx_ssi_platform_data eukrea_mbimxsd_ssi_pdata __initconst = {
-	.flags = IMX_SSI_SYN | IMX_SSI_NET | IMX_SSI_USE_I2S_SLAVE,
-};
-
-/*
- * system init for baseboard usage. Will be called by cpuimx25 init.
- *
- * Add platform devices present on this baseboard and init
- * them from CPU side as far as required to use them later on
- */
-void __init eukrea_mbimxsd25_baseboard_init(void)
-{
-	if (mxc_iomux_v3_setup_multiple_pads(eukrea_mbimxsd_pads,
-			ARRAY_SIZE(eukrea_mbimxsd_pads)))
-		printk(KERN_ERR "error setting mbimxsd pads !\n");
-
-#if defined(CONFIG_SND_SOC_EUKREA_TLV320)
-	/* SSI unit master I2S codec connected to SSI_AUD5*/
-	mxc_audmux_v2_configure_port(0,
-			MXC_AUDMUX_V2_PTCR_SYN |
-			MXC_AUDMUX_V2_PTCR_TFSDIR |
-			MXC_AUDMUX_V2_PTCR_TFSEL(4) |
-			MXC_AUDMUX_V2_PTCR_TCLKDIR |
-			MXC_AUDMUX_V2_PTCR_TCSEL(4),
-			MXC_AUDMUX_V2_PDCR_RXDSEL(4)
-	);
-	mxc_audmux_v2_configure_port(4,
-			MXC_AUDMUX_V2_PTCR_SYN,
-			MXC_AUDMUX_V2_PDCR_RXDSEL(0)
-	);
-#endif
-
-	imx25_add_imx_uart1(&uart_pdata);
-	imx25_add_imx_fb(&eukrea_mximxsd_fb_pdata);
-	imx25_add_imx_ssi(0, &eukrea_mbimxsd_ssi_pdata);
-
-	imx25_add_flexcan1(NULL);
-	imx25_add_esdhc(0, NULL);
-
-	gpio_request(GPIO_LED1, "LED1");
-	gpio_direction_output(GPIO_LED1, 1);
-	gpio_free(GPIO_LED1);
-
-	gpio_request(GPIO_SWITCH1, "SWITCH1");
-	gpio_direction_input(GPIO_SWITCH1);
-	gpio_free(GPIO_SWITCH1);
-
-	gpio_request(GPIO_LCDPWR, "LCDPWR");
-	gpio_direction_output(GPIO_LCDPWR, 1);
-	gpio_free(GPIO_SWITCH1);
-
-	i2c_register_board_info(0, eukrea_mbimxsd_i2c_devices,
-				ARRAY_SIZE(eukrea_mbimxsd_i2c_devices));
-
-	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
-}
diff --git a/arch/arm/mach-mx25/mach-cpuimx25.c b/arch/arm/mach-mx25/mach-cpuimx25.c
deleted file mode 100644
index 67a7d55..0000000
--- a/arch/arm/mach-mx25/mach-cpuimx25.c
+++ /dev/null
@@ -1,161 +0,0 @@
-/*
- * Copyright 2009 Sascha Hauer, <kernel@pengutronix.de>
- * Copyright 2010 Eric B?nard - Eukr?a Electromatique, <eric@eukrea.com>
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
- * Foundation, Inc., 51 Franklin Street, Fifth Floor,
- * Boston, MA  02110-1301, USA.
- */
-
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/clk.h>
-#include <linux/irq.h>
-#include <linux/gpio.h>
-#include <linux/platform_device.h>
-#include <linux/usb/otg.h>
-#include <linux/usb/ulpi.h>
-
-#include <mach/eukrea-baseboards.h>
-#include <mach/hardware.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/time.h>
-#include <asm/memory.h>
-#include <asm/mach/map.h>
-#include <mach/common.h>
-#include <mach/mx25.h>
-#include <mach/mxc_nand.h>
-#include <mach/imxfb.h>
-#include <mach/iomux-mx25.h>
-
-#include "devices-imx25.h"
-
-static const struct imxuart_platform_data uart_pdata __initconst = {
-	.flags = IMXUART_HAVE_RTSCTS,
-};
-
-static struct pad_desc eukrea_cpuimx25_pads[] = {
-	/* FEC - RMII */
-	MX25_PAD_FEC_MDC__FEC_MDC,
-	MX25_PAD_FEC_MDIO__FEC_MDIO,
-	MX25_PAD_FEC_TDATA0__FEC_TDATA0,
-	MX25_PAD_FEC_TDATA1__FEC_TDATA1,
-	MX25_PAD_FEC_TX_EN__FEC_TX_EN,
-	MX25_PAD_FEC_RDATA0__FEC_RDATA0,
-	MX25_PAD_FEC_RDATA1__FEC_RDATA1,
-	MX25_PAD_FEC_RX_DV__FEC_RX_DV,
-	MX25_PAD_FEC_TX_CLK__FEC_TX_CLK,
-	/* I2C1 */
-	MX25_PAD_I2C1_CLK__I2C1_CLK,
-	MX25_PAD_I2C1_DAT__I2C1_DAT,
-};
-
-static const struct fec_platform_data mx25_fec_pdata __initconst = {
-	.phy	= PHY_INTERFACE_MODE_RMII,
-};
-
-static const struct mxc_nand_platform_data
-eukrea_cpuimx25_nand_board_info __initconst = {
-	.width		= 1,
-	.hw_ecc		= 1,
-	.flash_bbt	= 1,
-};
-
-static const struct imxi2c_platform_data
-eukrea_cpuimx25_i2c0_data __initconst = {
-	.bitrate = 100000,
-};
-
-static struct i2c_board_info eukrea_cpuimx25_i2c_devices[] = {
-	{
-		I2C_BOARD_INFO("pcf8563", 0x51),
-	},
-};
-
-static const struct mxc_usbh_platform_data otg_pdata __initconst = {
-	.portsc	= MXC_EHCI_MODE_UTMI,
-	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
-};
-
-static const struct mxc_usbh_platform_data usbh2_pdata __initconst = {
-	.portsc	= MXC_EHCI_MODE_SERIAL,
-	.flags	= MXC_EHCI_INTERFACE_SINGLE_UNI | MXC_EHCI_INTERNAL_PHY |
-		  MXC_EHCI_IPPUE_DOWN,
-};
-
-static const struct fsl_usb2_platform_data otg_device_pdata __initconst = {
-	.operating_mode = FSL_USB2_DR_DEVICE,
-	.phy_mode       = FSL_USB2_PHY_UTMI,
-};
-
-static int otg_mode_host;
-
-static int __init eukrea_cpuimx25_otg_mode(char *options)
-{
-	if (!strcmp(options, "host"))
-		otg_mode_host = 1;
-	else if (!strcmp(options, "device"))
-		otg_mode_host = 0;
-	else
-		pr_info("otg_mode neither \"host\" nor \"device\". "
-			"Defaulting to device\n");
-	return 0;
-}
-__setup("otg_mode=", eukrea_cpuimx25_otg_mode);
-
-static void __init eukrea_cpuimx25_init(void)
-{
-	if (mxc_iomux_v3_setup_multiple_pads(eukrea_cpuimx25_pads,
-			ARRAY_SIZE(eukrea_cpuimx25_pads)))
-		printk(KERN_ERR "error setting cpuimx25 pads !\n");
-
-	imx25_add_imx_uart0(&uart_pdata);
-	imx25_add_mxc_nand(&eukrea_cpuimx25_nand_board_info);
-	imx25_add_imxdi_rtc(NULL);
-	imx25_add_fec(&mx25_fec_pdata);
-
-	i2c_register_board_info(0, eukrea_cpuimx25_i2c_devices,
-				ARRAY_SIZE(eukrea_cpuimx25_i2c_devices));
-	imx25_add_imx_i2c0(&eukrea_cpuimx25_i2c0_data);
-
-	if (otg_mode_host)
-		imx25_add_mxc_ehci_otg(&otg_pdata);
-	else
-		imx25_add_fsl_usb2_udc(&otg_device_pdata);
-
-	imx25_add_mxc_ehci_hs(&usbh2_pdata);
-
-#ifdef CONFIG_MACH_EUKREA_MBIMXSD25_BASEBOARD
-	eukrea_mbimxsd25_baseboard_init();
-#endif
-}
-
-static void __init eukrea_cpuimx25_timer_init(void)
-{
-	mx25_clocks_init();
-}
-
-static struct sys_timer eukrea_cpuimx25_timer = {
-	.init   = eukrea_cpuimx25_timer_init,
-};
-
-MACHINE_START(EUKREA_CPUIMX25, "Eukrea CPUIMX25")
-	/* Maintainer: Eukrea Electromatique */
-	.boot_params    = MX25_PHYS_OFFSET + 0x100,
-	.map_io         = mx25_map_io,
-	.init_irq       = mx25_init_irq,
-	.init_machine   = eukrea_cpuimx25_init,
-	.timer          = &eukrea_cpuimx25_timer,
-MACHINE_END
diff --git a/arch/arm/mach-mx25/mach-mx25_3ds.c b/arch/arm/mach-mx25/mach-mx25_3ds.c
deleted file mode 100644
index 328e1af..0000000
--- a/arch/arm/mach-mx25/mach-mx25_3ds.c
+++ /dev/null
@@ -1,223 +0,0 @@
-/*
- * Copyright 2009 Sascha Hauer, <kernel@pengutronix.de>
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
- * Foundation, Inc., 51 Franklin Street, Fifth Floor,
- * Boston, MA  02110-1301, USA.
- */
-
-/*
- * This machine is known as:
- *  - i.MX25 3-Stack Development System
- *  - i.MX25 Platform Development Kit (i.MX25 PDK)
- */
-
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/clk.h>
-#include <linux/irq.h>
-#include <linux/gpio.h>
-#include <linux/platform_device.h>
-#include <linux/input/matrix_keypad.h>
-
-#include <mach/hardware.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/time.h>
-#include <asm/memory.h>
-#include <asm/mach/map.h>
-#include <mach/common.h>
-#include <mach/mx25.h>
-#include <mach/iomux-mx25.h>
-
-#include "devices-imx25.h"
-
-static const struct imxuart_platform_data uart_pdata __initconst = {
-	.flags = IMXUART_HAVE_RTSCTS,
-};
-
-static struct pad_desc mx25pdk_pads[] = {
-	MX25_PAD_FEC_MDC__FEC_MDC,
-	MX25_PAD_FEC_MDIO__FEC_MDIO,
-	MX25_PAD_FEC_TDATA0__FEC_TDATA0,
-	MX25_PAD_FEC_TDATA1__FEC_TDATA1,
-	MX25_PAD_FEC_TX_EN__FEC_TX_EN,
-	MX25_PAD_FEC_RDATA0__FEC_RDATA0,
-	MX25_PAD_FEC_RDATA1__FEC_RDATA1,
-	MX25_PAD_FEC_RX_DV__FEC_RX_DV,
-	MX25_PAD_FEC_TX_CLK__FEC_TX_CLK,
-	MX25_PAD_A17__GPIO_2_3, /* FEC_EN, GPIO 35 */
-	MX25_PAD_D12__GPIO_4_8, /* FEC_RESET_B, GPIO 104 */
-
-	/* LCD */
-	MX25_PAD_LD0__LD0,
-	MX25_PAD_LD1__LD1,
-	MX25_PAD_LD2__LD2,
-	MX25_PAD_LD3__LD3,
-	MX25_PAD_LD4__LD4,
-	MX25_PAD_LD5__LD5,
-	MX25_PAD_LD6__LD6,
-	MX25_PAD_LD7__LD7,
-	MX25_PAD_LD8__LD8,
-	MX25_PAD_LD9__LD9,
-	MX25_PAD_LD10__LD10,
-	MX25_PAD_LD11__LD11,
-	MX25_PAD_LD12__LD12,
-	MX25_PAD_LD13__LD13,
-	MX25_PAD_LD14__LD14,
-	MX25_PAD_LD15__LD15,
-	MX25_PAD_GPIO_E__LD16,
-	MX25_PAD_GPIO_F__LD17,
-	MX25_PAD_HSYNC__HSYNC,
-	MX25_PAD_VSYNC__VSYNC,
-	MX25_PAD_LSCLK__LSCLK,
-	MX25_PAD_OE_ACD__OE_ACD,
-	MX25_PAD_CONTRAST__CONTRAST,
-
-	/* Keypad */
-	MX25_PAD_KPP_ROW0__KPP_ROW0,
-	MX25_PAD_KPP_ROW1__KPP_ROW1,
-	MX25_PAD_KPP_ROW2__KPP_ROW2,
-	MX25_PAD_KPP_ROW3__KPP_ROW3,
-	MX25_PAD_KPP_COL0__KPP_COL0,
-	MX25_PAD_KPP_COL1__KPP_COL1,
-	MX25_PAD_KPP_COL2__KPP_COL2,
-	MX25_PAD_KPP_COL3__KPP_COL3,
-
-	/* SD1 */
-	MX25_PAD_SD1_CMD__SD1_CMD,
-	MX25_PAD_SD1_CLK__SD1_CLK,
-	MX25_PAD_SD1_DATA0__SD1_DATA0,
-	MX25_PAD_SD1_DATA1__SD1_DATA1,
-	MX25_PAD_SD1_DATA2__SD1_DATA2,
-	MX25_PAD_SD1_DATA3__SD1_DATA3,
-};
-
-static const struct fec_platform_data mx25_fec_pdata __initconst = {
-        .phy    = PHY_INTERFACE_MODE_RMII,
-};
-
-#define FEC_ENABLE_GPIO		35
-#define FEC_RESET_B_GPIO	104
-
-static void __init mx25pdk_fec_reset(void)
-{
-	gpio_request(FEC_ENABLE_GPIO, "FEC PHY enable");
-	gpio_request(FEC_RESET_B_GPIO, "FEC PHY reset");
-
-	gpio_direction_output(FEC_ENABLE_GPIO, 0);  /* drop PHY power */
-	gpio_direction_output(FEC_RESET_B_GPIO, 0); /* assert reset */
-	udelay(2);
-
-	/* turn on PHY power and lift reset */
-	gpio_set_value(FEC_ENABLE_GPIO, 1);
-	gpio_set_value(FEC_RESET_B_GPIO, 1);
-}
-
-static const struct mxc_nand_platform_data
-mx25pdk_nand_board_info __initconst = {
-	.width		= 1,
-	.hw_ecc		= 1,
-	.flash_bbt	= 1,
-};
-
-static struct imx_fb_videomode mx25pdk_modes[] = {
-	{
-		.mode	= {
-			.name		= "CRT-VGA",
-			.refresh	= 60,
-			.xres		= 640,
-			.yres		= 480,
-			.pixclock	= 39683,
-			.left_margin	= 45,
-			.right_margin	= 114,
-			.upper_margin	= 33,
-			.lower_margin	= 11,
-			.hsync_len	= 1,
-			.vsync_len	= 1,
-		},
-		.bpp	= 16,
-		.pcr	= 0xFA208B80,
-	},
-};
-
-static const struct imx_fb_platform_data mx25pdk_fb_pdata __initconst = {
-	.mode		= mx25pdk_modes,
-	.num_modes	= ARRAY_SIZE(mx25pdk_modes),
-	.pwmr		= 0x00A903FF,
-	.lscr1		= 0x00120300,
-	.dmacr		= 0x00020010,
-};
-
-static const uint32_t mx25pdk_keymap[] = {
-	KEY(0, 0, KEY_UP),
-	KEY(0, 1, KEY_DOWN),
-	KEY(0, 2, KEY_VOLUMEDOWN),
-	KEY(0, 3, KEY_HOME),
-	KEY(1, 0, KEY_RIGHT),
-	KEY(1, 1, KEY_LEFT),
-	KEY(1, 2, KEY_ENTER),
-	KEY(1, 3, KEY_VOLUMEUP),
-	KEY(2, 0, KEY_F6),
-	KEY(2, 1, KEY_F8),
-	KEY(2, 2, KEY_F9),
-	KEY(2, 3, KEY_F10),
-	KEY(3, 0, KEY_F1),
-	KEY(3, 1, KEY_F2),
-	KEY(3, 2, KEY_F3),
-	KEY(3, 3, KEY_POWER),
-};
-
-static const struct matrix_keymap_data mx25pdk_keymap_data __initdata = {
-	.keymap		= mx25pdk_keymap,
-	.keymap_size	= ARRAY_SIZE(mx25pdk_keymap),
-};
-
-static void __init mx25pdk_init(void)
-{
-	mxc_iomux_v3_setup_multiple_pads(mx25pdk_pads,
-			ARRAY_SIZE(mx25pdk_pads));
-
-	imx25_add_imx_uart0(&uart_pdata);
-	imx25_add_mxc_ehci_hs(NULL);
-	imx25_add_mxc_nand(&mx25pdk_nand_board_info);
-	imx25_add_imxdi_rtc(NULL);
-	imx25_add_imx_fb(&mx25pdk_fb_pdata);
-	imx25_add_imx2_wdt(NULL);
-
-	mx25pdk_fec_reset();
-	imx25_add_fec(&mx25_fec_pdata);
-	imx25_add_imx_keypad(&mx25pdk_keymap_data);
-
-	imx25_add_esdhc(0, NULL);
-}
-
-static void __init mx25pdk_timer_init(void)
-{
-	mx25_clocks_init();
-}
-
-static struct sys_timer mx25pdk_timer = {
-	.init   = mx25pdk_timer_init,
-};
-
-MACHINE_START(MX25_3DS, "Freescale MX25PDK (3DS)")
-	/* Maintainer: Freescale Semiconductor, Inc. */
-	.boot_params    = MX25_PHYS_OFFSET + 0x100,
-	.map_io         = mx25_map_io,
-	.init_irq       = mx25_init_irq,
-	.init_machine   = mx25pdk_init,
-	.timer          = &mx25pdk_timer,
-MACHINE_END
-
diff --git a/arch/arm/mach-mx25/mm.c b/arch/arm/mach-mx25/mm.c
deleted file mode 100644
index 2edec6c..0000000
--- a/arch/arm/mach-mx25/mm.c
+++ /dev/null
@@ -1,62 +0,0 @@
-/*
- *  Copyright (C) 1999,2000 Arm Limited
- *  Copyright (C) 2000 Deep Blue Solutions Ltd
- *  Copyright (C) 2002 Shane Nay (shane at minirl.com)
- *  Copyright 2005-2007 Freescale Semiconductor, Inc. All Rights Reserved.
- *    - add MX31 specific definitions
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
-
-#include <linux/mm.h>
-#include <linux/init.h>
-#include <linux/err.h>
-
-#include <asm/pgtable.h>
-#include <asm/mach/map.h>
-
-#include <mach/common.h>
-#include <mach/hardware.h>
-#include <mach/mx25.h>
-#include <mach/iomux-v3.h>
-
-/*
- * This table defines static virtual address mappings for I/O regions.
- * These are the mappings common across all MX25 boards.
- */
-static struct map_desc mx25_io_desc[] __initdata = {
-	imx_map_entry(MX25, AVIC, MT_DEVICE_NONSHARED),
-	imx_map_entry(MX25, AIPS1, MT_DEVICE_NONSHARED),
-	imx_map_entry(MX25, AIPS2, MT_DEVICE_NONSHARED),
-};
-
-/*
- * This function initializes the memory map. It is called during the
- * system startup to create static physical to virtual memory mappings
- * for the IO modules.
- */
-void __init mx25_map_io(void)
-{
-	mxc_set_cpu_type(MXC_CPU_MX25);
-	mxc_iomux_v3_init(MX25_IO_ADDRESS(MX25_IOMUXC_BASE_ADDR));
-	mxc_arch_reset_init(MX25_IO_ADDRESS(MX25_WDOG_BASE_ADDR));
-
-	iotable_init(mx25_io_desc, ARRAY_SIZE(mx25_io_desc));
-}
-
-int imx25_register_gpios(void);
-
-void __init mx25_init_irq(void)
-{
-	mxc_init_irq(MX25_IO_ADDRESS(MX25_AVIC_BASE_ADDR));
-	imx25_register_gpios();
-}
-
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index 64e3a64..a31fa16 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -21,10 +21,6 @@ config ARCH_MX2
 
 config ARCH_MX25
 	bool "MX25-based"
-	select CPU_ARM926T
-	select ARCH_MXC_IOMUX_V3
-	select HAVE_FB_IMX
-	select ARCH_MXC_AUDMUX_V2
 	help
 	  This enables support for systems based on the Freescale i.MX25 family
 
@@ -51,7 +47,6 @@ endchoice
 
 source "arch/arm/mach-imx/Kconfig"
 source "arch/arm/mach-mx3/Kconfig"
-source "arch/arm/mach-mx25/Kconfig"
 source "arch/arm/mach-mxc91231/Kconfig"
 source "arch/arm/mach-mx5/Kconfig"
 
-- 
1.7.2.3
