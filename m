From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:19 +0200
Subject: [PATCH 23/61] ARM: imx: move mx1 support to mach-imx
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-24-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Makefile                       |    2 +-
 arch/arm/mach-imx/Kconfig               |   19 +
 arch/arm/mach-imx/Makefile              |    8 +
 arch/arm/mach-imx/Makefile.boot         |    4 +
 arch/arm/mach-imx/clock-imx1.c          |  636 +++++++++++++++++++++++++++++++
 arch/arm/mach-imx/devices.c             |  197 ++++++++++
 arch/arm/mach-imx/devices.h             |   12 +
 arch/arm/mach-imx/mach-mx1ads.c         |  165 ++++++++
 arch/arm/mach-imx/mach-scb9328.c        |  157 ++++++++
 arch/arm/mach-imx/mm-imx1.c             |   55 +++
 arch/arm/mach-imx/mx1-camera-fiq-ksym.c |   18 +
 arch/arm/mach-imx/mx1-camera-fiq.S      |   35 ++
 arch/arm/mach-mx1/Kconfig               |   19 -
 arch/arm/mach-mx1/Makefile              |   14 -
 arch/arm/mach-mx1/Makefile.boot         |    4 -
 arch/arm/mach-mx1/clock.c               |  636 -------------------------------
 arch/arm/mach-mx1/devices.c             |  220 -----------
 arch/arm/mach-mx1/devices.h             |    7 -
 arch/arm/mach-mx1/generic.c             |   55 ---
 arch/arm/mach-mx1/ksym_mx1.c            |   18 -
 arch/arm/mach-mx1/mach-mx1ads.c         |  165 --------
 arch/arm/mach-mx1/mach-scb9328.c        |  157 --------
 arch/arm/mach-mx1/mx1_camera_fiq.S      |   35 --
 arch/arm/plat-mxc/Kconfig               |    1 -
 24 files changed, 1307 insertions(+), 1332 deletions(-)
 create mode 100644 arch/arm/mach-imx/clock-imx1.c
 create mode 100644 arch/arm/mach-imx/mach-mx1ads.c
 create mode 100644 arch/arm/mach-imx/mach-scb9328.c
 create mode 100644 arch/arm/mach-imx/mm-imx1.c
 create mode 100644 arch/arm/mach-imx/mx1-camera-fiq-ksym.c
 create mode 100644 arch/arm/mach-imx/mx1-camera-fiq.S
 delete mode 100644 arch/arm/mach-mx1/Kconfig
 delete mode 100644 arch/arm/mach-mx1/Makefile
 delete mode 100644 arch/arm/mach-mx1/Makefile.boot
 delete mode 100644 arch/arm/mach-mx1/clock.c
 delete mode 100644 arch/arm/mach-mx1/devices.c
 delete mode 100644 arch/arm/mach-mx1/devices.h
 delete mode 100644 arch/arm/mach-mx1/generic.c
 delete mode 100644 arch/arm/mach-mx1/ksym_mx1.c
 delete mode 100644 arch/arm/mach-mx1/mach-mx1ads.c
 delete mode 100644 arch/arm/mach-mx1/mach-scb9328.c
 delete mode 100644 arch/arm/mach-mx1/mx1_camera_fiq.S

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index c60d604..ad81ece 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -145,7 +145,7 @@ machine-$(CONFIG_ARCH_LOKI) 		:= loki
 machine-$(CONFIG_ARCH_MMP)		:= mmp
 machine-$(CONFIG_ARCH_MSM)		:= msm
 machine-$(CONFIG_ARCH_MV78XX0)		:= mv78xx0
-machine-$(CONFIG_ARCH_MX1)		:= mx1
+machine-$(CONFIG_ARCH_MX1)		:= imx
 machine-$(CONFIG_ARCH_MX2)		:= imx
 machine-$(CONFIG_ARCH_MX25)		:= mx25
 machine-$(CONFIG_ARCH_MX3)		:= mx3
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 742fd4e..c6eddd7 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -1,3 +1,22 @@
+if ARCH_MX1
+
+comment "MX1 platforms:"
+config MACH_MXLADS
+	bool
+
+config ARCH_MX1ADS
+	bool "MX1ADS platform"
+	select MACH_MXLADS
+	help
+	  Say Y here if you are using Motorola MX1ADS/MXLADS boards
+
+config MACH_SCB9328
+	bool "Synertronixx scb9328"
+	help
+	  Say Y here if you are using a Synertronixx scb9328 board
+
+endif
+
 if ARCH_MX2
 
 choice
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 9d57ba6..e56a119 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -6,12 +6,20 @@
 
 obj-y	:=  devices.o
 
+obj-$(CONFIG_ARCH_MX1) += clock-imx1.o mm-imx1.o
 obj-$(CONFIG_MACH_MX21) += clock-imx21.o mm-imx21.o
 
 obj-$(CONFIG_MACH_MX27) += cpu-imx27.o
 obj-$(CONFIG_MACH_MX27) += clock-imx27.o mm-imx27.o
 
+# Support for CMOS sensor interface
+obj-$(CONFIG_MX1_VIDEO)	+= mx1-camera-fiq.o mx1-camera-fiq-ksym.o
+
+obj-$(CONFIG_ARCH_MX1ADS) += mach-mx1ads.o
+obj-$(CONFIG_MACH_SCB9328) += mach-scb9328.o
+
 obj-$(CONFIG_MACH_MX21ADS) += mach-mx21ads.o
+
 obj-$(CONFIG_MACH_MX27ADS) += mach-mx27ads.o
 obj-$(CONFIG_MACH_PCM038) += mach-pcm038.o
 obj-$(CONFIG_MACH_PCM970_BASEBOARD) += pcm970-baseboard.o
diff --git a/arch/arm/mach-imx/Makefile.boot b/arch/arm/mach-imx/Makefile.boot
index e867398..7988a85 100644
--- a/arch/arm/mach-imx/Makefile.boot
+++ b/arch/arm/mach-imx/Makefile.boot
@@ -1,3 +1,7 @@
+zreladdr-$(CONFIG_ARCH_MX1)	:= 0x08008000
+params_phys-$(CONFIG_ARCH_MX1)	:= 0x08000100
+initrd_phys-$(CONFIG_ARCH_MX1)	:= 0x08800000
+
 zreladdr-$(CONFIG_MACH_MX21)	:= 0xC0008000
 params_phys-$(CONFIG_MACH_MX21)	:= 0xC0000100
 initrd_phys-$(CONFIG_MACH_MX21)	:= 0xC0800000
diff --git a/arch/arm/mach-imx/clock-imx1.c b/arch/arm/mach-imx/clock-imx1.c
new file mode 100644
index 0000000..c05096c
--- /dev/null
+++ b/arch/arm/mach-imx/clock-imx1.c
@@ -0,0 +1,636 @@
+/*
+ *  Copyright (C) 2008 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/math64.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <asm/clkdev.h>
+
+#include <mach/clock.h>
+#include <mach/hardware.h>
+#include <mach/common.h>
+
+#define IO_ADDR_CCM(off)	(MX1_IO_ADDRESS(MX1_CCM_BASE_ADDR + (off)))
+
+/* CCM register addresses */
+#define CCM_CSCR	IO_ADDR_CCM(0x0)
+#define CCM_MPCTL0	IO_ADDR_CCM(0x4)
+#define CCM_SPCTL0	IO_ADDR_CCM(0xc)
+#define CCM_PCDR	IO_ADDR_CCM(0x20)
+
+#define CCM_CSCR_CLKO_OFFSET	29
+#define CCM_CSCR_CLKO_MASK	(0x7 << 29)
+#define CCM_CSCR_USB_OFFSET	26
+#define CCM_CSCR_USB_MASK	(0x7 << 26)
+#define CCM_CSCR_OSC_EN_SHIFT	17
+#define CCM_CSCR_SYSTEM_SEL	(1 << 16)
+#define CCM_CSCR_BCLK_OFFSET	10
+#define CCM_CSCR_BCLK_MASK	(0xf << 10)
+#define CCM_CSCR_PRESC		(1 << 15)
+
+#define CCM_PCDR_PCLK3_OFFSET	16
+#define CCM_PCDR_PCLK3_MASK	(0x7f << 16)
+#define CCM_PCDR_PCLK2_OFFSET	4
+#define CCM_PCDR_PCLK2_MASK	(0xf << 4)
+#define CCM_PCDR_PCLK1_OFFSET	0
+#define CCM_PCDR_PCLK1_MASK	0xf
+
+#define IO_ADDR_SCM(off)	(MX1_IO_ADDRESS(MX1_SCM_BASE_ADDR + (off)))
+
+/* SCM register addresses */
+#define SCM_GCCR	IO_ADDR_SCM(0xc)
+
+#define SCM_GCCR_DMA_CLK_EN_OFFSET	3
+#define SCM_GCCR_CSI_CLK_EN_OFFSET	2
+#define SCM_GCCR_MMA_CLK_EN_OFFSET	1
+#define SCM_GCCR_USBD_CLK_EN_OFFSET	0
+
+static int _clk_enable(struct clk *clk)
+{
+	unsigned int reg;
+
+	reg = __raw_readl(clk->enable_reg);
+	reg |= 1 << clk->enable_shift;
+	__raw_writel(reg, clk->enable_reg);
+
+	return 0;
+}
+
+static void _clk_disable(struct clk *clk)
+{
+	unsigned int reg;
+
+	reg = __raw_readl(clk->enable_reg);
+	reg &= ~(1 << clk->enable_shift);
+	__raw_writel(reg, clk->enable_reg);
+}
+
+static int _clk_can_use_parent(const struct clk *clk_arr[], unsigned int size,
+			       struct clk *parent)
+{
+	int i;
+
+	for (i = 0; i < size; i++)
+		if (parent == clk_arr[i])
+			return i;
+
+	return -EINVAL;
+}
+
+static unsigned long
+_clk_simple_round_rate(struct clk *clk, unsigned long rate, unsigned int limit)
+{
+	int div;
+	unsigned long parent_rate;
+
+	parent_rate = clk_get_rate(clk->parent);
+
+	div = parent_rate / rate;
+	if (parent_rate % rate)
+		div++;
+
+	if (div > limit)
+		div = limit;
+
+	return parent_rate / div;
+}
+
+static unsigned long _clk_parent_round_rate(struct clk *clk, unsigned long rate)
+{
+	return clk->parent->round_rate(clk->parent, rate);
+}
+
+static int _clk_parent_set_rate(struct clk *clk, unsigned long rate)
+{
+	return clk->parent->set_rate(clk->parent, rate);
+}
+
+static unsigned long clk16m_get_rate(struct clk *clk)
+{
+	return 16000000;
+}
+
+static struct clk clk16m = {
+	.get_rate = clk16m_get_rate,
+	.enable = _clk_enable,
+	.enable_reg = CCM_CSCR,
+	.enable_shift = CCM_CSCR_OSC_EN_SHIFT,
+	.disable = _clk_disable,
+};
+
+/* in Hz */
+static unsigned long clk32_rate;
+
+static unsigned long clk32_get_rate(struct clk *clk)
+{
+	return clk32_rate;
+}
+
+static struct clk clk32 = {
+	.get_rate = clk32_get_rate,
+};
+
+static unsigned long clk32_premult_get_rate(struct clk *clk)
+{
+	return clk_get_rate(clk->parent) * 512;
+}
+
+static struct clk clk32_premult = {
+	.parent = &clk32,
+	.get_rate = clk32_premult_get_rate,
+};
+
+static const struct clk *prem_clk_clocks[] = {
+	&clk32_premult,
+	&clk16m,
+};
+
+static int prem_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	int i;
+	unsigned int reg = __raw_readl(CCM_CSCR);
+
+	i = _clk_can_use_parent(prem_clk_clocks, ARRAY_SIZE(prem_clk_clocks),
+				parent);
+
+	switch (i) {
+	case 0:
+		reg &= ~CCM_CSCR_SYSTEM_SEL;
+		break;
+	case 1:
+		reg |= CCM_CSCR_SYSTEM_SEL;
+		break;
+	default:
+		return i;
+	}
+
+	__raw_writel(reg, CCM_CSCR);
+
+	return 0;
+}
+
+static struct clk prem_clk = {
+	.set_parent = prem_clk_set_parent,
+};
+
+static unsigned long system_clk_get_rate(struct clk *clk)
+{
+	return mxc_decode_pll(__raw_readl(CCM_SPCTL0),
+			      clk_get_rate(clk->parent));
+}
+
+static struct clk system_clk = {
+	.parent = &prem_clk,
+	.get_rate = system_clk_get_rate,
+};
+
+static unsigned long mcu_clk_get_rate(struct clk *clk)
+{
+	return mxc_decode_pll(__raw_readl(CCM_MPCTL0),
+			      clk_get_rate(clk->parent));
+}
+
+static struct clk mcu_clk = {
+	.parent = &clk32_premult,
+	.get_rate = mcu_clk_get_rate,
+};
+
+static unsigned long fclk_get_rate(struct clk *clk)
+{
+	unsigned long fclk = clk_get_rate(clk->parent);
+
+	if (__raw_readl(CCM_CSCR) & CCM_CSCR_PRESC)
+		fclk /= 2;
+
+	return fclk;
+}
+
+static struct clk fclk = {
+	.parent = &mcu_clk,
+	.get_rate = fclk_get_rate,
+};
+
+/*
+ *  get hclk ( SDRAM, CSI, Memory Stick, I2C, DMA )
+ */
+static unsigned long hclk_get_rate(struct clk *clk)
+{
+	return clk_get_rate(clk->parent) / (((__raw_readl(CCM_CSCR) &
+			CCM_CSCR_BCLK_MASK) >> CCM_CSCR_BCLK_OFFSET) + 1);
+}
+
+static unsigned long hclk_round_rate(struct clk *clk, unsigned long rate)
+{
+	return _clk_simple_round_rate(clk, rate, 16);
+}
+
+static int hclk_set_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned int div;
+	unsigned int reg;
+	unsigned long parent_rate;
+
+	parent_rate = clk_get_rate(clk->parent);
+
+	div = parent_rate / rate;
+
+	if (div > 16 || div < 1 || ((parent_rate / div) != rate))
+		return -EINVAL;
+
+	div--;
+
+	reg = __raw_readl(CCM_CSCR);
+	reg &= ~CCM_CSCR_BCLK_MASK;
+	reg |= div << CCM_CSCR_BCLK_OFFSET;
+	__raw_writel(reg, CCM_CSCR);
+
+	return 0;
+}
+
+static struct clk hclk = {
+	.parent = &system_clk,
+	.get_rate = hclk_get_rate,
+	.round_rate = hclk_round_rate,
+	.set_rate = hclk_set_rate,
+};
+
+static unsigned long clk48m_get_rate(struct clk *clk)
+{
+	return clk_get_rate(clk->parent) / (((__raw_readl(CCM_CSCR) &
+			CCM_CSCR_USB_MASK) >> CCM_CSCR_USB_OFFSET) + 1);
+}
+
+static unsigned long clk48m_round_rate(struct clk *clk, unsigned long rate)
+{
+	return _clk_simple_round_rate(clk, rate, 8);
+}
+
+static int clk48m_set_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned int div;
+	unsigned int reg;
+	unsigned long parent_rate;
+
+	parent_rate = clk_get_rate(clk->parent);
+
+	div = parent_rate / rate;
+
+	if (div > 8 || div < 1 || ((parent_rate / div) != rate))
+		return -EINVAL;
+
+	div--;
+
+	reg = __raw_readl(CCM_CSCR);
+	reg &= ~CCM_CSCR_USB_MASK;
+	reg |= div << CCM_CSCR_USB_OFFSET;
+	__raw_writel(reg, CCM_CSCR);
+
+	return 0;
+}
+
+static struct clk clk48m = {
+	.parent = &system_clk,
+	.get_rate = clk48m_get_rate,
+	.round_rate = clk48m_round_rate,
+	.set_rate = clk48m_set_rate,
+};
+
+/*
+ *  get peripheral clock 1 ( UART[12], Timer[12], PWM )
+ */
+static unsigned long perclk1_get_rate(struct clk *clk)
+{
+	return clk_get_rate(clk->parent) / (((__raw_readl(CCM_PCDR) &
+			CCM_PCDR_PCLK1_MASK) >> CCM_PCDR_PCLK1_OFFSET) + 1);
+}
+
+static unsigned long perclk1_round_rate(struct clk *clk, unsigned long rate)
+{
+	return _clk_simple_round_rate(clk, rate, 16);
+}
+
+static int perclk1_set_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned int div;
+	unsigned int reg;
+	unsigned long parent_rate;
+
+	parent_rate = clk_get_rate(clk->parent);
+
+	div = parent_rate / rate;
+
+	if (div > 16 || div < 1 || ((parent_rate / div) != rate))
+		return -EINVAL;
+
+	div--;
+
+	reg = __raw_readl(CCM_PCDR);
+	reg &= ~CCM_PCDR_PCLK1_MASK;
+	reg |= div << CCM_PCDR_PCLK1_OFFSET;
+	__raw_writel(reg, CCM_PCDR);
+
+	return 0;
+}
+
+/*
+ *  get peripheral clock 2 ( LCD, SD, SPI[12] )
+ */
+static unsigned long perclk2_get_rate(struct clk *clk)
+{
+	return clk_get_rate(clk->parent) / (((__raw_readl(CCM_PCDR) &
+			CCM_PCDR_PCLK2_MASK) >> CCM_PCDR_PCLK2_OFFSET) + 1);
+}
+
+static unsigned long perclk2_round_rate(struct clk *clk, unsigned long rate)
+{
+	return _clk_simple_round_rate(clk, rate, 16);
+}
+
+static int perclk2_set_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned int div;
+	unsigned int reg;
+	unsigned long parent_rate;
+
+	parent_rate = clk_get_rate(clk->parent);
+
+	div = parent_rate / rate;
+
+	if (div > 16 || div < 1 || ((parent_rate / div) != rate))
+		return -EINVAL;
+
+	div--;
+
+	reg = __raw_readl(CCM_PCDR);
+	reg &= ~CCM_PCDR_PCLK2_MASK;
+	reg |= div << CCM_PCDR_PCLK2_OFFSET;
+	__raw_writel(reg, CCM_PCDR);
+
+	return 0;
+}
+
+/*
+ *  get peripheral clock 3 ( SSI )
+ */
+static unsigned long perclk3_get_rate(struct clk *clk)
+{
+	return clk_get_rate(clk->parent) / (((__raw_readl(CCM_PCDR) &
+			CCM_PCDR_PCLK3_MASK) >> CCM_PCDR_PCLK3_OFFSET) + 1);
+}
+
+static unsigned long perclk3_round_rate(struct clk *clk, unsigned long rate)
+{
+	return _clk_simple_round_rate(clk, rate, 128);
+}
+
+static int perclk3_set_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned int div;
+	unsigned int reg;
+	unsigned long parent_rate;
+
+	parent_rate = clk_get_rate(clk->parent);
+
+	div = parent_rate / rate;
+
+	if (div > 128 || div < 1 || ((parent_rate / div) != rate))
+		return -EINVAL;
+
+	div--;
+
+	reg = __raw_readl(CCM_PCDR);
+	reg &= ~CCM_PCDR_PCLK3_MASK;
+	reg |= div << CCM_PCDR_PCLK3_OFFSET;
+	__raw_writel(reg, CCM_PCDR);
+
+	return 0;
+}
+
+static struct clk perclk[] = {
+	{
+		.id = 0,
+		.parent = &system_clk,
+		.get_rate = perclk1_get_rate,
+		.round_rate = perclk1_round_rate,
+		.set_rate = perclk1_set_rate,
+	}, {
+		.id = 1,
+		.parent = &system_clk,
+		.get_rate = perclk2_get_rate,
+		.round_rate = perclk2_round_rate,
+		.set_rate = perclk2_set_rate,
+	}, {
+		.id = 2,
+		.parent = &system_clk,
+		.get_rate = perclk3_get_rate,
+		.round_rate = perclk3_round_rate,
+		.set_rate = perclk3_set_rate,
+	}
+};
+
+static const struct clk *clko_clocks[] = {
+	&perclk[0],
+	&hclk,
+	&clk48m,
+	&clk16m,
+	&prem_clk,
+	&fclk,
+};
+
+static int clko_set_parent(struct clk *clk, struct clk *parent)
+{
+	int i;
+	unsigned int reg;
+
+	i = _clk_can_use_parent(clko_clocks, ARRAY_SIZE(clko_clocks), parent);
+	if (i < 0)
+		return i;
+
+	reg = __raw_readl(CCM_CSCR) & ~CCM_CSCR_CLKO_MASK;
+	reg |= i << CCM_CSCR_CLKO_OFFSET;
+	__raw_writel(reg, CCM_CSCR);
+
+	if (clko_clocks[i]->set_rate && clko_clocks[i]->round_rate) {
+		clk->set_rate = _clk_parent_set_rate;
+		clk->round_rate = _clk_parent_round_rate;
+	} else {
+		clk->set_rate = NULL;
+		clk->round_rate = NULL;
+	}
+
+	return 0;
+}
+
+static struct clk clko_clk = {
+	.set_parent = clko_set_parent,
+};
+
+static struct clk dma_clk = {
+	.parent = &hclk,
+	.round_rate = _clk_parent_round_rate,
+	.set_rate = _clk_parent_set_rate,
+	.enable = _clk_enable,
+	.enable_reg = SCM_GCCR,
+	.enable_shift = SCM_GCCR_DMA_CLK_EN_OFFSET,
+	.disable = _clk_disable,
+};
+
+static struct clk csi_clk = {
+	.parent = &hclk,
+	.round_rate = _clk_parent_round_rate,
+	.set_rate = _clk_parent_set_rate,
+	.enable = _clk_enable,
+	.enable_reg = SCM_GCCR,
+	.enable_shift = SCM_GCCR_CSI_CLK_EN_OFFSET,
+	.disable = _clk_disable,
+};
+
+static struct clk mma_clk = {
+	.parent = &hclk,
+	.round_rate = _clk_parent_round_rate,
+	.set_rate = _clk_parent_set_rate,
+	.enable = _clk_enable,
+	.enable_reg = SCM_GCCR,
+	.enable_shift = SCM_GCCR_MMA_CLK_EN_OFFSET,
+	.disable = _clk_disable,
+};
+
+static struct clk usbd_clk = {
+	.parent = &clk48m,
+	.round_rate = _clk_parent_round_rate,
+	.set_rate = _clk_parent_set_rate,
+	.enable = _clk_enable,
+	.enable_reg = SCM_GCCR,
+	.enable_shift = SCM_GCCR_USBD_CLK_EN_OFFSET,
+	.disable = _clk_disable,
+};
+
+static struct clk gpt_clk = {
+	.parent = &perclk[0],
+	.round_rate = _clk_parent_round_rate,
+	.set_rate = _clk_parent_set_rate,
+};
+
+static struct clk uart_clk = {
+	.parent = &perclk[0],
+	.round_rate = _clk_parent_round_rate,
+	.set_rate = _clk_parent_set_rate,
+};
+
+static struct clk i2c_clk = {
+	.parent = &hclk,
+	.round_rate = _clk_parent_round_rate,
+	.set_rate = _clk_parent_set_rate,
+};
+
+static struct clk spi_clk = {
+	.parent = &perclk[1],
+	.round_rate = _clk_parent_round_rate,
+	.set_rate = _clk_parent_set_rate,
+};
+
+static struct clk sdhc_clk = {
+	.parent = &perclk[1],
+	.round_rate = _clk_parent_round_rate,
+	.set_rate = _clk_parent_set_rate,
+};
+
+static struct clk lcdc_clk = {
+	.parent = &perclk[1],
+	.round_rate = _clk_parent_round_rate,
+	.set_rate = _clk_parent_set_rate,
+};
+
+static struct clk mshc_clk = {
+	.parent = &hclk,
+	.round_rate = _clk_parent_round_rate,
+	.set_rate = _clk_parent_set_rate,
+};
+
+static struct clk ssi_clk = {
+	.parent = &perclk[2],
+	.round_rate = _clk_parent_round_rate,
+	.set_rate = _clk_parent_set_rate,
+};
+
+static struct clk rtc_clk = {
+	.parent = &clk32,
+};
+
+#define _REGISTER_CLOCK(d, n, c) \
+	{ \
+		.dev_id = d, \
+		.con_id = n, \
+		.clk = &c, \
+	},
+static struct clk_lookup lookups[] __initdata = {
+	_REGISTER_CLOCK(NULL, "dma", dma_clk)
+	_REGISTER_CLOCK("mx1-camera.0", NULL, csi_clk)
+	_REGISTER_CLOCK(NULL, "mma", mma_clk)
+	_REGISTER_CLOCK("imx_udc.0", NULL, usbd_clk)
+	_REGISTER_CLOCK(NULL, "gpt", gpt_clk)
+	_REGISTER_CLOCK("imx-uart.0", NULL, uart_clk)
+	_REGISTER_CLOCK("imx-uart.1", NULL, uart_clk)
+	_REGISTER_CLOCK("imx-uart.2", NULL, uart_clk)
+	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c_clk)
+	_REGISTER_CLOCK("spi_imx.0", NULL, spi_clk)
+	_REGISTER_CLOCK("imx-mmc.0", NULL, sdhc_clk)
+	_REGISTER_CLOCK("imx-fb.0", NULL, lcdc_clk)
+	_REGISTER_CLOCK(NULL, "mshc", mshc_clk)
+	_REGISTER_CLOCK(NULL, "ssi", ssi_clk)
+	_REGISTER_CLOCK("mxc_rtc.0", NULL, rtc_clk)
+};
+
+int __init mx1_clocks_init(unsigned long fref)
+{
+	unsigned int reg;
+
+	/* disable clocks we are able to */
+	__raw_writel(0, SCM_GCCR);
+
+	clk32_rate = fref;
+	reg = __raw_readl(CCM_CSCR);
+
+	/* detect clock reference for system PLL */
+	if (reg & CCM_CSCR_SYSTEM_SEL) {
+		prem_clk.parent = &clk16m;
+	} else {
+		/* ensure that oscillator is disabled */
+		reg &= ~(1 << CCM_CSCR_OSC_EN_SHIFT);
+		__raw_writel(reg, CCM_CSCR);
+		prem_clk.parent = &clk32_premult;
+	}
+
+	/* detect reference for CLKO */
+	reg = (reg & CCM_CSCR_CLKO_MASK) >> CCM_CSCR_CLKO_OFFSET;
+	clko_clk.parent = (struct clk *)clko_clocks[reg];
+
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+
+	clk_enable(&hclk);
+	clk_enable(&fclk);
+
+	mxc_timer_init(&gpt_clk, MX1_IO_ADDRESS(MX1_TIM1_BASE_ADDR),
+			MX1_TIM1_INT);
+
+	return 0;
+}
diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
index b372805..ceae641 100644
--- a/arch/arm/mach-imx/devices.c
+++ b/arch/arm/mach-imx/devices.c
@@ -11,6 +11,9 @@
  *
  * Copyright 2006-2007 Freescale Semiconductor, Inc. All Rights Reserved.
  * Copyright 2008 Juergen Beisert, kernel at pengutronix.de
+ * Copyright 2008 Sascha Hauer, kernel at pengutronix.de
+ * Copyright (c) 2008 Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
+ * Copyright (c) 2008 Darius Augulis <darius.augulis@teltonika.lt>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -41,6 +44,199 @@
 
 #include "devices.h"
 
+#if defined(CONFIG_ARCH_MX1)
+static struct resource imx1_camera_resources[] = {
+	{
+		.start  = 0x00224000,
+		.end    = 0x00224010,
+		.flags  = IORESOURCE_MEM,
+	}, {
+		.start  = MX1_CSI_INT,
+		.end    = MX1_CSI_INT,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static u64 imx1_camera_dmamask = DMA_BIT_MASK(32);
+
+struct platform_device imx1_camera_device = {
+	.name           = "mx1-camera",
+	.id             = 0, /* This is used to put cameras on this interface */
+	.dev		= {
+		.dma_mask = &imx1_camera_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+	},
+	.resource       = imx1_camera_resources,
+	.num_resources  = ARRAY_SIZE(imx1_camera_resources),
+};
+
+static struct resource imx_i2c_resources[] = {
+	{
+		.start  = 0x00217000,
+		.end    = 0x00217010,
+		.flags  = IORESOURCE_MEM,
+	}, {
+		.start  = MX1_I2C_INT,
+		.end    = MX1_I2C_INT,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device imx_i2c_device0 = {
+	.name           = "imx-i2c",
+	.id             = 0,
+	.resource       = imx_i2c_resources,
+	.num_resources  = ARRAY_SIZE(imx_i2c_resources),
+};
+
+#define DEFINE_IMX1_UART_DEVICE(n, baseaddr, irqrx, irqtx, irqrts)	\
+	static struct resource imx1_uart_resources ## n[] = {		\
+		{							\
+			.start = baseaddr,				\
+			.end = baseaddr + 0xd0,				\
+			.flags = IORESOURCE_MEM,			\
+		}, {							\
+			.start = irqrx,					\
+			.end = irqrx,					\
+			.flags = IORESOURCE_IRQ,			\
+		}, {							\
+			.start = irqtx,					\
+			.end = irqtx,					\
+			.flags = IORESOURCE_IRQ,			\
+		}, {							\
+			.start = irqrts,				\
+			.end = irqrts,					\
+			.flags = IORESOURCE_IRQ,			\
+		},							\
+	};								\
+									\
+	struct platform_device imx1_uart_device ## n = {		\
+		.name = "imx-uart",					\
+		.id = n,						\
+		.num_resources = ARRAY_SIZE(imx1_uart_resources ## n),	\
+		.resource = imx1_uart_resources ## n,			\
+	}
+
+DEFINE_IMX1_UART_DEVICE(0, MX1_UART1_BASE_ADDR, MX1_UART1_MINT_RX, MX1_UART1_MINT_TX, MX1_UART1_MINT_RTS);
+DEFINE_IMX1_UART_DEVICE(1, MX1_UART2_BASE_ADDR, MX1_UART2_MINT_RX, MX1_UART2_MINT_TX, MX1_UART2_MINT_RTS);
+
+static struct resource imx_rtc_resources[] = {
+	{
+		.start  = 0x00204000,
+		.end    = 0x00204024,
+		.flags  = IORESOURCE_MEM,
+	}, {
+		.start  = MX1_RTC_INT,
+		.end    = MX1_RTC_INT,
+		.flags  = IORESOURCE_IRQ,
+	}, {
+		.start  = MX1_RTC_SAMINT,
+		.end    = MX1_RTC_SAMINT,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device imx_rtc_device = {
+	.name           = "rtc-imx",
+	.id             = 0,
+	.resource       = imx_rtc_resources,
+	.num_resources  = ARRAY_SIZE(imx_rtc_resources),
+};
+
+static struct resource imx_wdt_resources[] = {
+	{
+		.start  = 0x00201000,
+		.end    = 0x00201008,
+		.flags  = IORESOURCE_MEM,
+	}, {
+		.start  = MX1_WDT_INT,
+		.end    = MX1_WDT_INT,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device imx_wdt_device = {
+	.name           = "imx-wdt",
+	.id             = 0,
+	.resource       = imx_wdt_resources,
+	.num_resources  = ARRAY_SIZE(imx_wdt_resources),
+};
+
+static struct resource imx_usb_resources[] = {
+	{
+		.start	= 0x00212000,
+		.end	= 0x00212148,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= MX1_USBD_INT0,
+		.end	= MX1_USBD_INT0,
+		.flags	= IORESOURCE_IRQ,
+	}, {
+		.start	= MX1_USBD_INT1,
+		.end	= MX1_USBD_INT1,
+		.flags	= IORESOURCE_IRQ,
+	}, {
+		.start	= MX1_USBD_INT2,
+		.end	= MX1_USBD_INT2,
+		.flags	= IORESOURCE_IRQ,
+	}, {
+		.start	= MX1_USBD_INT3,
+		.end	= MX1_USBD_INT3,
+		.flags	= IORESOURCE_IRQ,
+	}, {
+		.start	= MX1_USBD_INT4,
+		.end	= MX1_USBD_INT4,
+		.flags	= IORESOURCE_IRQ,
+	}, {
+		.start	= MX1_USBD_INT5,
+		.end	= MX1_USBD_INT5,
+		.flags	= IORESOURCE_IRQ,
+	}, {
+		.start	= MX1_USBD_INT6,
+		.end	= MX1_USBD_INT6,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device imx_usb_device = {
+	.name		= "imx_udc",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(imx_usb_resources),
+	.resource	= imx_usb_resources,
+};
+
+/* GPIO port description */
+static struct mxc_gpio_port imx_gpio_ports[] = {
+	{
+		.chip.label = "gpio-0",
+		.base = (void __iomem *)MX1_IO_ADDRESS(MX1_GPIO_BASE_ADDR),
+		.irq = MX1_GPIO_INT_PORTA,
+		.virtual_irq_start = MXC_GPIO_IRQ_START,
+	}, {
+		.chip.label = "gpio-1",
+		.base = (void __iomem *)MX1_IO_ADDRESS(MX1_GPIO_BASE_ADDR + 0x100),
+		.irq = MX1_GPIO_INT_PORTB,
+		.virtual_irq_start = MXC_GPIO_IRQ_START + 32,
+	}, {
+		.chip.label = "gpio-2",
+		.base = (void __iomem *)MX1_IO_ADDRESS(MX1_GPIO_BASE_ADDR + 0x200),
+		.irq = MX1_GPIO_INT_PORTC,
+		.virtual_irq_start = MXC_GPIO_IRQ_START + 64,
+	}, {
+		.chip.label = "gpio-3",
+		.base = (void __iomem *)MX1_IO_ADDRESS(MX1_GPIO_BASE_ADDR + 0x300),
+		.irq = MX1_GPIO_INT_PORTD,
+		.virtual_irq_start = MXC_GPIO_IRQ_START + 96,
+	}
+};
+
+int __init imx1_register_gpios(void)
+{
+	return mxc_gpio_init(imx_gpio_ports, ARRAY_SIZE(imx_gpio_ports));
+}
+#endif
+
+#if defined(CONFIG_MACH_MX21) || defined(CONFIG_MACH_MX27)
 /*
  * SPI master controller
  *
@@ -526,3 +722,4 @@ struct platform_device mx21_usbhc_device = {
 	.resource	= mx21_usbhc_resources,
 };
 #endif
+#endif
diff --git a/arch/arm/mach-imx/devices.h b/arch/arm/mach-imx/devices.h
index 65c4a43..5c1a0dc 100644
--- a/arch/arm/mach-imx/devices.h
+++ b/arch/arm/mach-imx/devices.h
@@ -1,3 +1,14 @@
+#ifdef CONFIG_ARCH_MX1
+extern struct platform_device imx1_camera_device;
+extern struct platform_device imx_i2c_device0;
+extern struct platform_device imx1_uart_device0;
+extern struct platform_device imx1_uart_device1;
+extern struct platform_device imx_rtc_device;
+extern struct platform_device imx_wdt_device;
+extern struct platform_device imx_usb_device;
+#endif
+
+#if defined(CONFIG_MACH_MX21) || defined(CONFIG_MACH_MX27)
 extern struct platform_device mxc_gpt1;
 extern struct platform_device mxc_gpt2;
 #ifdef CONFIG_MACH_MX27
@@ -42,3 +53,4 @@ extern struct platform_device mxc_spi_device2;
 extern struct platform_device mx21_usbhc_device;
 extern struct platform_device imx_ssi_device0;
 extern struct platform_device imx_ssi_device1;
+#endif
diff --git a/arch/arm/mach-imx/mach-mx1ads.c b/arch/arm/mach-imx/mach-mx1ads.c
new file mode 100644
index 0000000..5d7c85f
--- /dev/null
+++ b/arch/arm/mach-imx/mach-mx1ads.c
@@ -0,0 +1,165 @@
+/*
+ * arch/arm/mach-imx/mach-mx1ads.c
+ *
+ * Initially based on:
+ *	linux-2.6.7-imx/arch/arm/mach-imx/scb9328.c
+ *	Copyright (c) 2004 Sascha Hauer <sascha@saschahauer.de>
+ *
+ * 2004 (c) MontaVista Software, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/i2c.h>
+#include <linux/i2c/pcf857x.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/physmap.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+
+#include <mach/common.h>
+#include <mach/hardware.h>
+#include <mach/i2c.h>
+#include <mach/imx-uart.h>
+#include <mach/iomux-mx1.h>
+#include <mach/irqs.h>
+
+#include "devices.h"
+
+static int mx1ads_pins[] = {
+	/* UART1 */
+	PC9_PF_UART1_CTS,
+	PC10_PF_UART1_RTS,
+	PC11_PF_UART1_TXD,
+	PC12_PF_UART1_RXD,
+	/* UART2 */
+	PB28_PF_UART2_CTS,
+	PB29_PF_UART2_RTS,
+	PB30_PF_UART2_TXD,
+	PB31_PF_UART2_RXD,
+	/* I2C */
+	PA15_PF_I2C_SDA,
+	PA16_PF_I2C_SCL,
+	/* SPI */
+	PC13_PF_SPI1_SPI_RDY,
+	PC14_PF_SPI1_SCLK,
+	PC15_PF_SPI1_SS,
+	PC16_PF_SPI1_MISO,
+	PC17_PF_SPI1_MOSI,
+};
+
+/*
+ * UARTs platform data
+ */
+
+static struct imxuart_platform_data uart_pdata[] = {
+	{
+		.flags = IMXUART_HAVE_RTSCTS,
+	}, {
+		.flags = IMXUART_HAVE_RTSCTS,
+	},
+};
+
+/*
+ * Physmap flash
+ */
+
+static struct physmap_flash_data mx1ads_flash_data = {
+	.width		= 4,		/* bankwidth in bytes */
+};
+
+static struct resource flash_resource = {
+	.start	= MX1_CS0_PHYS,
+	.end	= MX1_CS0_PHYS + SZ_32M - 1,
+	.flags	= IORESOURCE_MEM,
+};
+
+static struct platform_device flash_device = {
+	.name	= "physmap-flash",
+	.id	= 0,
+	.resource = &flash_resource,
+	.num_resources = 1,
+};
+
+/*
+ * I2C
+ */
+static struct pcf857x_platform_data pcf857x_data[] = {
+	{
+		.gpio_base = 4 * 32,
+	}, {
+		.gpio_base = 4 * 32 + 16,
+	}
+};
+
+static struct imxi2c_platform_data mx1ads_i2c_data = {
+	.bitrate = 100000,
+};
+
+static struct i2c_board_info mx1ads_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("pcf8575", 0x22),
+		.platform_data = &pcf857x_data[0],
+	}, {
+		I2C_BOARD_INFO("pcf8575", 0x24),
+		.platform_data = &pcf857x_data[1],
+	},
+};
+
+/*
+ * Board init
+ */
+static void __init mx1ads_init(void)
+{
+	mxc_gpio_setup_multiple_pins(mx1ads_pins,
+		ARRAY_SIZE(mx1ads_pins), "mx1ads");
+
+	/* UART */
+	mxc_register_device(&imx1_uart_device0, &uart_pdata[0]);
+	mxc_register_device(&imx1_uart_device1, &uart_pdata[1]);
+
+	/* Physmap flash */
+	mxc_register_device(&flash_device, &mx1ads_flash_data);
+
+	/* I2C */
+	i2c_register_board_info(0, mx1ads_i2c_devices,
+				ARRAY_SIZE(mx1ads_i2c_devices));
+
+	mxc_register_device(&imx_i2c_device0, &mx1ads_i2c_data);
+}
+
+static void __init mx1ads_timer_init(void)
+{
+	mx1_clocks_init(32000);
+}
+
+struct sys_timer mx1ads_timer = {
+	.init	= mx1ads_timer_init,
+};
+
+MACHINE_START(MX1ADS, "Freescale MX1ADS")
+	/* Maintainer: Sascha Hauer, Pengutronix */
+	.phys_io	= MX1_IO_BASE_ADDR,
+	.io_pg_offst	= (MX1_IO_BASE_ADDR_VIRT >> 18) & 0xfffc,
+	.boot_params	= MX1_PHYS_OFFSET + 0x100,
+	.map_io		= mx1_map_io,
+	.init_irq	= mx1_init_irq,
+	.timer		= &mx1ads_timer,
+	.init_machine	= mx1ads_init,
+MACHINE_END
+
+MACHINE_START(MXLADS, "Freescale MXLADS")
+	.phys_io	= MX1_IO_BASE_ADDR,
+	.io_pg_offst	= (MX1_IO_BASE_ADDR_VIRT >> 18) & 0xfffc,
+	.boot_params	= MX1_PHYS_OFFSET + 0x100,
+	.map_io		= mx1_map_io,
+	.init_irq	= mx1_init_irq,
+	.timer		= &mx1ads_timer,
+	.init_machine	= mx1ads_init,
+MACHINE_END
diff --git a/arch/arm/mach-imx/mach-scb9328.c b/arch/arm/mach-imx/mach-scb9328.c
new file mode 100644
index 0000000..482b24d
--- /dev/null
+++ b/arch/arm/mach-imx/mach-scb9328.c
@@ -0,0 +1,157 @@
+/*
+ * linux/arch/arm/mach-mx1/mach-scb9328.c
+ *
+ * Copyright (c) 2004 Sascha Hauer <saschahauer@web.de>
+ * Copyright (c) 2006-2008 Juergen Beisert <jbeisert@netscape.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/platform_device.h>
+#include <linux/mtd/physmap.h>
+#include <linux/interrupt.h>
+#include <linux/dm9000.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+
+#include <mach/common.h>
+#include <mach/hardware.h>
+#include <mach/irqs.h>
+#include <mach/imx-uart.h>
+#include <mach/iomux-mx1.h>
+
+#include "devices.h"
+
+/*
+ * This scb9328 has a 32MiB flash
+ */
+static struct resource flash_resource = {
+	.start	= MX1_CS0_PHYS,
+	.end	= MX1_CS0_PHYS + (32 * 1024 * 1024) - 1,
+	.flags	= IORESOURCE_MEM,
+};
+
+static struct physmap_flash_data scb_flash_data = {
+	.width  = 2,
+};
+
+static struct platform_device scb_flash_device = {
+	.name		= "physmap-flash",
+	.id		= 0,
+	.dev = {
+		.platform_data = &scb_flash_data,
+	},
+	.resource = &flash_resource,
+	.num_resources = 1,
+};
+
+/*
+ * scb9328 has a DM9000 network controller
+ * connected to CS5, with 16 bit data path
+ * and interrupt connected to GPIO 3
+ */
+
+/*
+ * internal datapath is fixed 16 bit
+ */
+static struct dm9000_plat_data dm9000_platdata = {
+	.flags	= DM9000_PLATF_16BITONLY,
+};
+
+/*
+ * the DM9000 drivers wants two defined address spaces
+ * to gain access to address latch registers and the data path.
+ */
+static struct resource dm9000x_resources[] = {
+	{
+		.name	= "address area",
+		.start	= MX1_CS5_PHYS,
+		.end	= MX1_CS5_PHYS + 1,
+		.flags	= IORESOURCE_MEM,	/* address access */
+	}, {
+		.name	= "data area",
+		.start	= MX1_CS5_PHYS + 4,
+		.end	= MX1_CS5_PHYS + 5,
+		.flags	= IORESOURCE_MEM,	/* data access */
+	}, {
+		.start	= IRQ_GPIOC(3),
+		.end	= IRQ_GPIOC(3),
+		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
+	},
+};
+
+static struct platform_device dm9000x_device = {
+	.name		= "dm9000",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(dm9000x_resources),
+	.resource	= dm9000x_resources,
+	.dev		= {
+		.platform_data = &dm9000_platdata,
+	}
+};
+
+static int mxc_uart1_pins[] = {
+	PC9_PF_UART1_CTS,
+	PC10_PF_UART1_RTS,
+	PC11_PF_UART1_TXD,
+	PC12_PF_UART1_RXD,
+};
+
+static int uart1_mxc_init(struct platform_device *pdev)
+{
+	return mxc_gpio_setup_multiple_pins(mxc_uart1_pins,
+			ARRAY_SIZE(mxc_uart1_pins), "UART1");
+}
+
+static void uart1_mxc_exit(struct platform_device *pdev)
+{
+	mxc_gpio_release_multiple_pins(mxc_uart1_pins,
+			ARRAY_SIZE(mxc_uart1_pins));
+}
+
+static struct imxuart_platform_data uart_pdata = {
+	.init = uart1_mxc_init,
+	.exit = uart1_mxc_exit,
+	.flags = IMXUART_HAVE_RTSCTS,
+};
+
+static struct platform_device *devices[] __initdata = {
+	&scb_flash_device,
+	&dm9000x_device,
+};
+
+/*
+ * scb9328_init - Init the CPU card itself
+ */
+static void __init scb9328_init(void)
+{
+	mxc_register_device(&imx1_uart_device0, &uart_pdata);
+
+	printk(KERN_INFO"Scb9328: Adding devices\n");
+	platform_add_devices(devices, ARRAY_SIZE(devices));
+}
+
+static void __init scb9328_timer_init(void)
+{
+	mx1_clocks_init(32000);
+}
+
+static struct sys_timer scb9328_timer = {
+	.init	= scb9328_timer_init,
+};
+
+MACHINE_START(SCB9328, "Synertronixx scb9328")
+    /* Sascha Hauer */
+	.phys_io	= 0x00200000,
+	.io_pg_offst	= ((0xe0200000) >> 18) & 0xfffc,
+	.boot_params	= 0x08000100,
+	.map_io		= mx1_map_io,
+	.init_irq	= mx1_init_irq,
+	.timer		= &scb9328_timer,
+	.init_machine	= scb9328_init,
+MACHINE_END
diff --git a/arch/arm/mach-imx/mm-imx1.c b/arch/arm/mach-imx/mm-imx1.c
new file mode 100644
index 0000000..396d0a5
--- /dev/null
+++ b/arch/arm/mach-imx/mm-imx1.c
@@ -0,0 +1,55 @@
+/*
+ *  author: Sascha Hauer
+ *  Created: april 20th, 2004
+ *  Copyright: Synertronixx GmbH
+ *
+ *  Common code for i.MX1 machines
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
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+
+#include <asm/mach/map.h>
+
+#include <mach/common.h>
+#include <mach/hardware.h>
+
+static struct map_desc imx_io_desc[] __initdata = {
+	{
+		.virtual = MX1_IO_BASE_ADDR_VIRT,
+		.pfn = __phys_to_pfn(MX1_IO_BASE_ADDR),
+		.length = MX1_IO_SIZE,
+		.type = MT_DEVICE
+	}
+};
+
+void __init mx1_map_io(void)
+{
+	mxc_set_cpu_type(MXC_CPU_MX1);
+	mxc_arch_reset_init(MX1_IO_ADDRESS(MX1_WDT_BASE_ADDR));
+
+	iotable_init(imx_io_desc, ARRAY_SIZE(imx_io_desc));
+}
+
+int imx1_register_gpios(void);
+
+void __init mx1_init_irq(void)
+{
+	imx1_register_gpios();
+	mxc_init_irq(MX1_IO_ADDRESS(MX1_AVIC_BASE_ADDR));
+}
diff --git a/arch/arm/mach-imx/mx1-camera-fiq-ksym.c b/arch/arm/mach-imx/mx1-camera-fiq-ksym.c
new file mode 100644
index 0000000..b09ee12
--- /dev/null
+++ b/arch/arm/mach-imx/mx1-camera-fiq-ksym.c
@@ -0,0 +1,18 @@
+/*
+ * Exported ksyms of ARCH_MX1
+ *
+ * Copyright (C) 2008, Darius Augulis <augulis.darius@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/module.h>
+
+#include <mach/mx1_camera.h>
+
+/* IMX camera FIQ handler */
+EXPORT_SYMBOL(mx1_camera_sof_fiq_start);
+EXPORT_SYMBOL(mx1_camera_sof_fiq_end);
diff --git a/arch/arm/mach-imx/mx1-camera-fiq.S b/arch/arm/mach-imx/mx1-camera-fiq.S
new file mode 100644
index 0000000..9c69aa6
--- /dev/null
+++ b/arch/arm/mach-imx/mx1-camera-fiq.S
@@ -0,0 +1,35 @@
+/*
+ *  Copyright (C) 2008 Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
+ *
+ *  Based on linux/arch/arm/lib/floppydma.S
+ *      Copyright (C) 1995, 1996 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+
+		.text
+		.global	mx1_camera_sof_fiq_end
+		.global	mx1_camera_sof_fiq_start
+mx1_camera_sof_fiq_start:
+		@ enable dma
+		ldr	r12, [r9]
+		orr	r12, r12, #0x00000001
+		str	r12, [r9]
+		@ unmask DMA interrupt
+		ldr	r12, [r8]
+		bic	r12, r12, r13
+		str	r12, [r8]
+		@ disable SOF interrupt
+		ldr	r12, [r10]
+		bic	r12, r12, #0x00010000
+		str	r12, [r10]
+		@ clear SOF flag
+		mov	r12, #0x00010000
+		str	r12, [r11]
+		@ return from FIQ
+		subs	pc, lr, #4
+mx1_camera_sof_fiq_end:
diff --git a/arch/arm/mach-mx1/Kconfig b/arch/arm/mach-mx1/Kconfig
deleted file mode 100644
index eb7660f..0000000
--- a/arch/arm/mach-mx1/Kconfig
+++ /dev/null
@@ -1,19 +0,0 @@
-if ARCH_MX1
-
-comment "MX1 platforms:"
-
-config MACH_MXLADS
-	bool
-
-config ARCH_MX1ADS
-	bool "MX1ADS platform"
-	select MACH_MXLADS
-	help
-	  Say Y here if you are using Motorola MX1ADS/MXLADS boards
-
-config MACH_SCB9328
-	bool "Synertronixx scb9328"
-	help
-	  Say Y here if you are using a Synertronixx scb9328 board
-
-endif
diff --git a/arch/arm/mach-mx1/Makefile b/arch/arm/mach-mx1/Makefile
deleted file mode 100644
index 297d172..0000000
--- a/arch/arm/mach-mx1/Makefile
+++ /dev/null
@@ -1,14 +0,0 @@
-#
-# Makefile for the linux kernel.
-#
-
-# Object file lists.
-
-obj-y			+= generic.o clock.o devices.o
-
-# Support for CMOS sensor interface
-obj-$(CONFIG_MX1_VIDEO)	+= ksym_mx1.o mx1_camera_fiq.o
-
-# Specific board support
-obj-$(CONFIG_ARCH_MX1ADS) += mach-mx1ads.o
-obj-$(CONFIG_MACH_SCB9328) += mach-scb9328.o
diff --git a/arch/arm/mach-mx1/Makefile.boot b/arch/arm/mach-mx1/Makefile.boot
deleted file mode 100644
index 8ed1492..0000000
--- a/arch/arm/mach-mx1/Makefile.boot
+++ /dev/null
@@ -1,4 +0,0 @@
-   zreladdr-y	:= 0x08008000
-params_phys-y	:= 0x08000100
-initrd_phys-y	:= 0x08800000
-
diff --git a/arch/arm/mach-mx1/clock.c b/arch/arm/mach-mx1/clock.c
deleted file mode 100644
index c05096c..0000000
--- a/arch/arm/mach-mx1/clock.c
+++ /dev/null
@@ -1,636 +0,0 @@
-/*
- *  Copyright (C) 2008 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/list.h>
-#include <linux/math64.h>
-#include <linux/err.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-
-#include <asm/clkdev.h>
-
-#include <mach/clock.h>
-#include <mach/hardware.h>
-#include <mach/common.h>
-
-#define IO_ADDR_CCM(off)	(MX1_IO_ADDRESS(MX1_CCM_BASE_ADDR + (off)))
-
-/* CCM register addresses */
-#define CCM_CSCR	IO_ADDR_CCM(0x0)
-#define CCM_MPCTL0	IO_ADDR_CCM(0x4)
-#define CCM_SPCTL0	IO_ADDR_CCM(0xc)
-#define CCM_PCDR	IO_ADDR_CCM(0x20)
-
-#define CCM_CSCR_CLKO_OFFSET	29
-#define CCM_CSCR_CLKO_MASK	(0x7 << 29)
-#define CCM_CSCR_USB_OFFSET	26
-#define CCM_CSCR_USB_MASK	(0x7 << 26)
-#define CCM_CSCR_OSC_EN_SHIFT	17
-#define CCM_CSCR_SYSTEM_SEL	(1 << 16)
-#define CCM_CSCR_BCLK_OFFSET	10
-#define CCM_CSCR_BCLK_MASK	(0xf << 10)
-#define CCM_CSCR_PRESC		(1 << 15)
-
-#define CCM_PCDR_PCLK3_OFFSET	16
-#define CCM_PCDR_PCLK3_MASK	(0x7f << 16)
-#define CCM_PCDR_PCLK2_OFFSET	4
-#define CCM_PCDR_PCLK2_MASK	(0xf << 4)
-#define CCM_PCDR_PCLK1_OFFSET	0
-#define CCM_PCDR_PCLK1_MASK	0xf
-
-#define IO_ADDR_SCM(off)	(MX1_IO_ADDRESS(MX1_SCM_BASE_ADDR + (off)))
-
-/* SCM register addresses */
-#define SCM_GCCR	IO_ADDR_SCM(0xc)
-
-#define SCM_GCCR_DMA_CLK_EN_OFFSET	3
-#define SCM_GCCR_CSI_CLK_EN_OFFSET	2
-#define SCM_GCCR_MMA_CLK_EN_OFFSET	1
-#define SCM_GCCR_USBD_CLK_EN_OFFSET	0
-
-static int _clk_enable(struct clk *clk)
-{
-	unsigned int reg;
-
-	reg = __raw_readl(clk->enable_reg);
-	reg |= 1 << clk->enable_shift;
-	__raw_writel(reg, clk->enable_reg);
-
-	return 0;
-}
-
-static void _clk_disable(struct clk *clk)
-{
-	unsigned int reg;
-
-	reg = __raw_readl(clk->enable_reg);
-	reg &= ~(1 << clk->enable_shift);
-	__raw_writel(reg, clk->enable_reg);
-}
-
-static int _clk_can_use_parent(const struct clk *clk_arr[], unsigned int size,
-			       struct clk *parent)
-{
-	int i;
-
-	for (i = 0; i < size; i++)
-		if (parent == clk_arr[i])
-			return i;
-
-	return -EINVAL;
-}
-
-static unsigned long
-_clk_simple_round_rate(struct clk *clk, unsigned long rate, unsigned int limit)
-{
-	int div;
-	unsigned long parent_rate;
-
-	parent_rate = clk_get_rate(clk->parent);
-
-	div = parent_rate / rate;
-	if (parent_rate % rate)
-		div++;
-
-	if (div > limit)
-		div = limit;
-
-	return parent_rate / div;
-}
-
-static unsigned long _clk_parent_round_rate(struct clk *clk, unsigned long rate)
-{
-	return clk->parent->round_rate(clk->parent, rate);
-}
-
-static int _clk_parent_set_rate(struct clk *clk, unsigned long rate)
-{
-	return clk->parent->set_rate(clk->parent, rate);
-}
-
-static unsigned long clk16m_get_rate(struct clk *clk)
-{
-	return 16000000;
-}
-
-static struct clk clk16m = {
-	.get_rate = clk16m_get_rate,
-	.enable = _clk_enable,
-	.enable_reg = CCM_CSCR,
-	.enable_shift = CCM_CSCR_OSC_EN_SHIFT,
-	.disable = _clk_disable,
-};
-
-/* in Hz */
-static unsigned long clk32_rate;
-
-static unsigned long clk32_get_rate(struct clk *clk)
-{
-	return clk32_rate;
-}
-
-static struct clk clk32 = {
-	.get_rate = clk32_get_rate,
-};
-
-static unsigned long clk32_premult_get_rate(struct clk *clk)
-{
-	return clk_get_rate(clk->parent) * 512;
-}
-
-static struct clk clk32_premult = {
-	.parent = &clk32,
-	.get_rate = clk32_premult_get_rate,
-};
-
-static const struct clk *prem_clk_clocks[] = {
-	&clk32_premult,
-	&clk16m,
-};
-
-static int prem_clk_set_parent(struct clk *clk, struct clk *parent)
-{
-	int i;
-	unsigned int reg = __raw_readl(CCM_CSCR);
-
-	i = _clk_can_use_parent(prem_clk_clocks, ARRAY_SIZE(prem_clk_clocks),
-				parent);
-
-	switch (i) {
-	case 0:
-		reg &= ~CCM_CSCR_SYSTEM_SEL;
-		break;
-	case 1:
-		reg |= CCM_CSCR_SYSTEM_SEL;
-		break;
-	default:
-		return i;
-	}
-
-	__raw_writel(reg, CCM_CSCR);
-
-	return 0;
-}
-
-static struct clk prem_clk = {
-	.set_parent = prem_clk_set_parent,
-};
-
-static unsigned long system_clk_get_rate(struct clk *clk)
-{
-	return mxc_decode_pll(__raw_readl(CCM_SPCTL0),
-			      clk_get_rate(clk->parent));
-}
-
-static struct clk system_clk = {
-	.parent = &prem_clk,
-	.get_rate = system_clk_get_rate,
-};
-
-static unsigned long mcu_clk_get_rate(struct clk *clk)
-{
-	return mxc_decode_pll(__raw_readl(CCM_MPCTL0),
-			      clk_get_rate(clk->parent));
-}
-
-static struct clk mcu_clk = {
-	.parent = &clk32_premult,
-	.get_rate = mcu_clk_get_rate,
-};
-
-static unsigned long fclk_get_rate(struct clk *clk)
-{
-	unsigned long fclk = clk_get_rate(clk->parent);
-
-	if (__raw_readl(CCM_CSCR) & CCM_CSCR_PRESC)
-		fclk /= 2;
-
-	return fclk;
-}
-
-static struct clk fclk = {
-	.parent = &mcu_clk,
-	.get_rate = fclk_get_rate,
-};
-
-/*
- *  get hclk ( SDRAM, CSI, Memory Stick, I2C, DMA )
- */
-static unsigned long hclk_get_rate(struct clk *clk)
-{
-	return clk_get_rate(clk->parent) / (((__raw_readl(CCM_CSCR) &
-			CCM_CSCR_BCLK_MASK) >> CCM_CSCR_BCLK_OFFSET) + 1);
-}
-
-static unsigned long hclk_round_rate(struct clk *clk, unsigned long rate)
-{
-	return _clk_simple_round_rate(clk, rate, 16);
-}
-
-static int hclk_set_rate(struct clk *clk, unsigned long rate)
-{
-	unsigned int div;
-	unsigned int reg;
-	unsigned long parent_rate;
-
-	parent_rate = clk_get_rate(clk->parent);
-
-	div = parent_rate / rate;
-
-	if (div > 16 || div < 1 || ((parent_rate / div) != rate))
-		return -EINVAL;
-
-	div--;
-
-	reg = __raw_readl(CCM_CSCR);
-	reg &= ~CCM_CSCR_BCLK_MASK;
-	reg |= div << CCM_CSCR_BCLK_OFFSET;
-	__raw_writel(reg, CCM_CSCR);
-
-	return 0;
-}
-
-static struct clk hclk = {
-	.parent = &system_clk,
-	.get_rate = hclk_get_rate,
-	.round_rate = hclk_round_rate,
-	.set_rate = hclk_set_rate,
-};
-
-static unsigned long clk48m_get_rate(struct clk *clk)
-{
-	return clk_get_rate(clk->parent) / (((__raw_readl(CCM_CSCR) &
-			CCM_CSCR_USB_MASK) >> CCM_CSCR_USB_OFFSET) + 1);
-}
-
-static unsigned long clk48m_round_rate(struct clk *clk, unsigned long rate)
-{
-	return _clk_simple_round_rate(clk, rate, 8);
-}
-
-static int clk48m_set_rate(struct clk *clk, unsigned long rate)
-{
-	unsigned int div;
-	unsigned int reg;
-	unsigned long parent_rate;
-
-	parent_rate = clk_get_rate(clk->parent);
-
-	div = parent_rate / rate;
-
-	if (div > 8 || div < 1 || ((parent_rate / div) != rate))
-		return -EINVAL;
-
-	div--;
-
-	reg = __raw_readl(CCM_CSCR);
-	reg &= ~CCM_CSCR_USB_MASK;
-	reg |= div << CCM_CSCR_USB_OFFSET;
-	__raw_writel(reg, CCM_CSCR);
-
-	return 0;
-}
-
-static struct clk clk48m = {
-	.parent = &system_clk,
-	.get_rate = clk48m_get_rate,
-	.round_rate = clk48m_round_rate,
-	.set_rate = clk48m_set_rate,
-};
-
-/*
- *  get peripheral clock 1 ( UART[12], Timer[12], PWM )
- */
-static unsigned long perclk1_get_rate(struct clk *clk)
-{
-	return clk_get_rate(clk->parent) / (((__raw_readl(CCM_PCDR) &
-			CCM_PCDR_PCLK1_MASK) >> CCM_PCDR_PCLK1_OFFSET) + 1);
-}
-
-static unsigned long perclk1_round_rate(struct clk *clk, unsigned long rate)
-{
-	return _clk_simple_round_rate(clk, rate, 16);
-}
-
-static int perclk1_set_rate(struct clk *clk, unsigned long rate)
-{
-	unsigned int div;
-	unsigned int reg;
-	unsigned long parent_rate;
-
-	parent_rate = clk_get_rate(clk->parent);
-
-	div = parent_rate / rate;
-
-	if (div > 16 || div < 1 || ((parent_rate / div) != rate))
-		return -EINVAL;
-
-	div--;
-
-	reg = __raw_readl(CCM_PCDR);
-	reg &= ~CCM_PCDR_PCLK1_MASK;
-	reg |= div << CCM_PCDR_PCLK1_OFFSET;
-	__raw_writel(reg, CCM_PCDR);
-
-	return 0;
-}
-
-/*
- *  get peripheral clock 2 ( LCD, SD, SPI[12] )
- */
-static unsigned long perclk2_get_rate(struct clk *clk)
-{
-	return clk_get_rate(clk->parent) / (((__raw_readl(CCM_PCDR) &
-			CCM_PCDR_PCLK2_MASK) >> CCM_PCDR_PCLK2_OFFSET) + 1);
-}
-
-static unsigned long perclk2_round_rate(struct clk *clk, unsigned long rate)
-{
-	return _clk_simple_round_rate(clk, rate, 16);
-}
-
-static int perclk2_set_rate(struct clk *clk, unsigned long rate)
-{
-	unsigned int div;
-	unsigned int reg;
-	unsigned long parent_rate;
-
-	parent_rate = clk_get_rate(clk->parent);
-
-	div = parent_rate / rate;
-
-	if (div > 16 || div < 1 || ((parent_rate / div) != rate))
-		return -EINVAL;
-
-	div--;
-
-	reg = __raw_readl(CCM_PCDR);
-	reg &= ~CCM_PCDR_PCLK2_MASK;
-	reg |= div << CCM_PCDR_PCLK2_OFFSET;
-	__raw_writel(reg, CCM_PCDR);
-
-	return 0;
-}
-
-/*
- *  get peripheral clock 3 ( SSI )
- */
-static unsigned long perclk3_get_rate(struct clk *clk)
-{
-	return clk_get_rate(clk->parent) / (((__raw_readl(CCM_PCDR) &
-			CCM_PCDR_PCLK3_MASK) >> CCM_PCDR_PCLK3_OFFSET) + 1);
-}
-
-static unsigned long perclk3_round_rate(struct clk *clk, unsigned long rate)
-{
-	return _clk_simple_round_rate(clk, rate, 128);
-}
-
-static int perclk3_set_rate(struct clk *clk, unsigned long rate)
-{
-	unsigned int div;
-	unsigned int reg;
-	unsigned long parent_rate;
-
-	parent_rate = clk_get_rate(clk->parent);
-
-	div = parent_rate / rate;
-
-	if (div > 128 || div < 1 || ((parent_rate / div) != rate))
-		return -EINVAL;
-
-	div--;
-
-	reg = __raw_readl(CCM_PCDR);
-	reg &= ~CCM_PCDR_PCLK3_MASK;
-	reg |= div << CCM_PCDR_PCLK3_OFFSET;
-	__raw_writel(reg, CCM_PCDR);
-
-	return 0;
-}
-
-static struct clk perclk[] = {
-	{
-		.id = 0,
-		.parent = &system_clk,
-		.get_rate = perclk1_get_rate,
-		.round_rate = perclk1_round_rate,
-		.set_rate = perclk1_set_rate,
-	}, {
-		.id = 1,
-		.parent = &system_clk,
-		.get_rate = perclk2_get_rate,
-		.round_rate = perclk2_round_rate,
-		.set_rate = perclk2_set_rate,
-	}, {
-		.id = 2,
-		.parent = &system_clk,
-		.get_rate = perclk3_get_rate,
-		.round_rate = perclk3_round_rate,
-		.set_rate = perclk3_set_rate,
-	}
-};
-
-static const struct clk *clko_clocks[] = {
-	&perclk[0],
-	&hclk,
-	&clk48m,
-	&clk16m,
-	&prem_clk,
-	&fclk,
-};
-
-static int clko_set_parent(struct clk *clk, struct clk *parent)
-{
-	int i;
-	unsigned int reg;
-
-	i = _clk_can_use_parent(clko_clocks, ARRAY_SIZE(clko_clocks), parent);
-	if (i < 0)
-		return i;
-
-	reg = __raw_readl(CCM_CSCR) & ~CCM_CSCR_CLKO_MASK;
-	reg |= i << CCM_CSCR_CLKO_OFFSET;
-	__raw_writel(reg, CCM_CSCR);
-
-	if (clko_clocks[i]->set_rate && clko_clocks[i]->round_rate) {
-		clk->set_rate = _clk_parent_set_rate;
-		clk->round_rate = _clk_parent_round_rate;
-	} else {
-		clk->set_rate = NULL;
-		clk->round_rate = NULL;
-	}
-
-	return 0;
-}
-
-static struct clk clko_clk = {
-	.set_parent = clko_set_parent,
-};
-
-static struct clk dma_clk = {
-	.parent = &hclk,
-	.round_rate = _clk_parent_round_rate,
-	.set_rate = _clk_parent_set_rate,
-	.enable = _clk_enable,
-	.enable_reg = SCM_GCCR,
-	.enable_shift = SCM_GCCR_DMA_CLK_EN_OFFSET,
-	.disable = _clk_disable,
-};
-
-static struct clk csi_clk = {
-	.parent = &hclk,
-	.round_rate = _clk_parent_round_rate,
-	.set_rate = _clk_parent_set_rate,
-	.enable = _clk_enable,
-	.enable_reg = SCM_GCCR,
-	.enable_shift = SCM_GCCR_CSI_CLK_EN_OFFSET,
-	.disable = _clk_disable,
-};
-
-static struct clk mma_clk = {
-	.parent = &hclk,
-	.round_rate = _clk_parent_round_rate,
-	.set_rate = _clk_parent_set_rate,
-	.enable = _clk_enable,
-	.enable_reg = SCM_GCCR,
-	.enable_shift = SCM_GCCR_MMA_CLK_EN_OFFSET,
-	.disable = _clk_disable,
-};
-
-static struct clk usbd_clk = {
-	.parent = &clk48m,
-	.round_rate = _clk_parent_round_rate,
-	.set_rate = _clk_parent_set_rate,
-	.enable = _clk_enable,
-	.enable_reg = SCM_GCCR,
-	.enable_shift = SCM_GCCR_USBD_CLK_EN_OFFSET,
-	.disable = _clk_disable,
-};
-
-static struct clk gpt_clk = {
-	.parent = &perclk[0],
-	.round_rate = _clk_parent_round_rate,
-	.set_rate = _clk_parent_set_rate,
-};
-
-static struct clk uart_clk = {
-	.parent = &perclk[0],
-	.round_rate = _clk_parent_round_rate,
-	.set_rate = _clk_parent_set_rate,
-};
-
-static struct clk i2c_clk = {
-	.parent = &hclk,
-	.round_rate = _clk_parent_round_rate,
-	.set_rate = _clk_parent_set_rate,
-};
-
-static struct clk spi_clk = {
-	.parent = &perclk[1],
-	.round_rate = _clk_parent_round_rate,
-	.set_rate = _clk_parent_set_rate,
-};
-
-static struct clk sdhc_clk = {
-	.parent = &perclk[1],
-	.round_rate = _clk_parent_round_rate,
-	.set_rate = _clk_parent_set_rate,
-};
-
-static struct clk lcdc_clk = {
-	.parent = &perclk[1],
-	.round_rate = _clk_parent_round_rate,
-	.set_rate = _clk_parent_set_rate,
-};
-
-static struct clk mshc_clk = {
-	.parent = &hclk,
-	.round_rate = _clk_parent_round_rate,
-	.set_rate = _clk_parent_set_rate,
-};
-
-static struct clk ssi_clk = {
-	.parent = &perclk[2],
-	.round_rate = _clk_parent_round_rate,
-	.set_rate = _clk_parent_set_rate,
-};
-
-static struct clk rtc_clk = {
-	.parent = &clk32,
-};
-
-#define _REGISTER_CLOCK(d, n, c) \
-	{ \
-		.dev_id = d, \
-		.con_id = n, \
-		.clk = &c, \
-	},
-static struct clk_lookup lookups[] __initdata = {
-	_REGISTER_CLOCK(NULL, "dma", dma_clk)
-	_REGISTER_CLOCK("mx1-camera.0", NULL, csi_clk)
-	_REGISTER_CLOCK(NULL, "mma", mma_clk)
-	_REGISTER_CLOCK("imx_udc.0", NULL, usbd_clk)
-	_REGISTER_CLOCK(NULL, "gpt", gpt_clk)
-	_REGISTER_CLOCK("imx-uart.0", NULL, uart_clk)
-	_REGISTER_CLOCK("imx-uart.1", NULL, uart_clk)
-	_REGISTER_CLOCK("imx-uart.2", NULL, uart_clk)
-	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c_clk)
-	_REGISTER_CLOCK("spi_imx.0", NULL, spi_clk)
-	_REGISTER_CLOCK("imx-mmc.0", NULL, sdhc_clk)
-	_REGISTER_CLOCK("imx-fb.0", NULL, lcdc_clk)
-	_REGISTER_CLOCK(NULL, "mshc", mshc_clk)
-	_REGISTER_CLOCK(NULL, "ssi", ssi_clk)
-	_REGISTER_CLOCK("mxc_rtc.0", NULL, rtc_clk)
-};
-
-int __init mx1_clocks_init(unsigned long fref)
-{
-	unsigned int reg;
-
-	/* disable clocks we are able to */
-	__raw_writel(0, SCM_GCCR);
-
-	clk32_rate = fref;
-	reg = __raw_readl(CCM_CSCR);
-
-	/* detect clock reference for system PLL */
-	if (reg & CCM_CSCR_SYSTEM_SEL) {
-		prem_clk.parent = &clk16m;
-	} else {
-		/* ensure that oscillator is disabled */
-		reg &= ~(1 << CCM_CSCR_OSC_EN_SHIFT);
-		__raw_writel(reg, CCM_CSCR);
-		prem_clk.parent = &clk32_premult;
-	}
-
-	/* detect reference for CLKO */
-	reg = (reg & CCM_CSCR_CLKO_MASK) >> CCM_CSCR_CLKO_OFFSET;
-	clko_clk.parent = (struct clk *)clko_clocks[reg];
-
-	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
-
-	clk_enable(&hclk);
-	clk_enable(&fclk);
-
-	mxc_timer_init(&gpt_clk, MX1_IO_ADDRESS(MX1_TIM1_BASE_ADDR),
-			MX1_TIM1_INT);
-
-	return 0;
-}
diff --git a/arch/arm/mach-mx1/devices.c b/arch/arm/mach-mx1/devices.c
deleted file mode 100644
index a79e613..0000000
--- a/arch/arm/mach-mx1/devices.c
+++ /dev/null
@@ -1,220 +0,0 @@
-/*
- * Copyright 2006-2007 Freescale Semiconductor, Inc. All Rights Reserved.
- * Copyright 2008 Sascha Hauer, kernel at pengutronix.de
- * Copyright (c) 2008 Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
- * Copyright (c) 2008 Darius Augulis <darius.augulis@teltonika.lt>
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
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/dma-mapping.h>
-#include <linux/platform_device.h>
-#include <linux/gpio.h>
-#include <mach/irqs.h>
-#include <mach/hardware.h>
-
-#include "devices.h"
-
-static struct resource imx1_camera_resources[] = {
-	{
-		.start  = 0x00224000,
-		.end    = 0x00224010,
-		.flags  = IORESOURCE_MEM,
-	}, {
-		.start  = MX1_CSI_INT,
-		.end    = MX1_CSI_INT,
-		.flags  = IORESOURCE_IRQ,
-	},
-};
-
-static u64 imx1_camera_dmamask = DMA_BIT_MASK(32);
-
-struct platform_device imx1_camera_device = {
-	.name           = "mx1-camera",
-	.id             = 0, /* This is used to put cameras on this interface */
-	.dev		= {
-		.dma_mask = &imx1_camera_dmamask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-	},
-	.resource       = imx1_camera_resources,
-	.num_resources  = ARRAY_SIZE(imx1_camera_resources),
-};
-
-static struct resource imx_i2c_resources[] = {
-	{
-		.start  = 0x00217000,
-		.end    = 0x00217010,
-		.flags  = IORESOURCE_MEM,
-	}, {
-		.start  = MX1_I2C_INT,
-		.end    = MX1_I2C_INT,
-		.flags  = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device imx_i2c_device0 = {
-	.name           = "imx-i2c",
-	.id             = 0,
-	.resource       = imx_i2c_resources,
-	.num_resources  = ARRAY_SIZE(imx_i2c_resources),
-};
-
-#define DEFINE_IMX1_UART_DEVICE(n, baseaddr, irqrx, irqtx, irqrts)	\
-	static struct resource imx1_uart_resources ## n[] = {		\
-		{							\
-			.start = baseaddr,				\
-			.end = baseaddr + 0xd0,				\
-			.flags = IORESOURCE_MEM,			\
-		}, {							\
-			.start = irqrx,					\
-			.end = irqrx,					\
-			.flags = IORESOURCE_IRQ,			\
-		}, {							\
-			.start = irqtx,					\
-			.end = irqtx,					\
-			.flags = IORESOURCE_IRQ,			\
-		}, {							\
-			.start = irqrts,				\
-			.end = irqrts,					\
-			.flags = IORESOURCE_IRQ,			\
-		},							\
-	};								\
-									\
-	struct platform_device imx1_uart_device ## n = {		\
-		.name = "imx-uart",					\
-		.id = n,						\
-		.num_resources = ARRAY_SIZE(imx1_uart_resources ## n),	\
-		.resource = imx1_uart_resources ## n,			\
-	}
-
-DEFINE_IMX1_UART_DEVICE(0, MX1_UART1_BASE_ADDR, MX1_UART1_MINT_RX, MX1_UART1_MINT_TX, MX1_UART1_MINT_RTS);
-DEFINE_IMX1_UART_DEVICE(1, MX1_UART2_BASE_ADDR, MX1_UART2_MINT_RX, MX1_UART2_MINT_TX, MX1_UART2_MINT_RTS);
-
-static struct resource imx_rtc_resources[] = {
-	{
-		.start  = 0x00204000,
-		.end    = 0x00204024,
-		.flags  = IORESOURCE_MEM,
-	}, {
-		.start  = MX1_RTC_INT,
-		.end    = MX1_RTC_INT,
-		.flags  = IORESOURCE_IRQ,
-	}, {
-		.start  = MX1_RTC_SAMINT,
-		.end    = MX1_RTC_SAMINT,
-		.flags  = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device imx_rtc_device = {
-	.name           = "rtc-imx",
-	.id             = 0,
-	.resource       = imx_rtc_resources,
-	.num_resources  = ARRAY_SIZE(imx_rtc_resources),
-};
-
-static struct resource imx_wdt_resources[] = {
-	{
-		.start  = 0x00201000,
-		.end    = 0x00201008,
-		.flags  = IORESOURCE_MEM,
-	}, {
-		.start  = MX1_WDT_INT,
-		.end    = MX1_WDT_INT,
-		.flags  = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device imx_wdt_device = {
-	.name           = "imx-wdt",
-	.id             = 0,
-	.resource       = imx_wdt_resources,
-	.num_resources  = ARRAY_SIZE(imx_wdt_resources),
-};
-
-static struct resource imx_usb_resources[] = {
-	{
-		.start	= 0x00212000,
-		.end	= 0x00212148,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= MX1_USBD_INT0,
-		.end	= MX1_USBD_INT0,
-		.flags	= IORESOURCE_IRQ,
-	}, {
-		.start	= MX1_USBD_INT1,
-		.end	= MX1_USBD_INT1,
-		.flags	= IORESOURCE_IRQ,
-	}, {
-		.start	= MX1_USBD_INT2,
-		.end	= MX1_USBD_INT2,
-		.flags	= IORESOURCE_IRQ,
-	}, {
-		.start	= MX1_USBD_INT3,
-		.end	= MX1_USBD_INT3,
-		.flags	= IORESOURCE_IRQ,
-	}, {
-		.start	= MX1_USBD_INT4,
-		.end	= MX1_USBD_INT4,
-		.flags	= IORESOURCE_IRQ,
-	}, {
-		.start	= MX1_USBD_INT5,
-		.end	= MX1_USBD_INT5,
-		.flags	= IORESOURCE_IRQ,
-	}, {
-		.start	= MX1_USBD_INT6,
-		.end	= MX1_USBD_INT6,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device imx_usb_device = {
-	.name		= "imx_udc",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(imx_usb_resources),
-	.resource	= imx_usb_resources,
-};
-
-/* GPIO port description */
-static struct mxc_gpio_port imx_gpio_ports[] = {
-	{
-		.chip.label = "gpio-0",
-		.base = (void __iomem *)MX1_IO_ADDRESS(MX1_GPIO_BASE_ADDR),
-		.irq = MX1_GPIO_INT_PORTA,
-		.virtual_irq_start = MXC_GPIO_IRQ_START,
-	}, {
-		.chip.label = "gpio-1",
-		.base = (void __iomem *)MX1_IO_ADDRESS(MX1_GPIO_BASE_ADDR + 0x100),
-		.irq = MX1_GPIO_INT_PORTB,
-		.virtual_irq_start = MXC_GPIO_IRQ_START + 32,
-	}, {
-		.chip.label = "gpio-2",
-		.base = (void __iomem *)MX1_IO_ADDRESS(MX1_GPIO_BASE_ADDR + 0x200),
-		.irq = MX1_GPIO_INT_PORTC,
-		.virtual_irq_start = MXC_GPIO_IRQ_START + 64,
-	}, {
-		.chip.label = "gpio-3",
-		.base = (void __iomem *)MX1_IO_ADDRESS(MX1_GPIO_BASE_ADDR + 0x300),
-		.irq = MX1_GPIO_INT_PORTD,
-		.virtual_irq_start = MXC_GPIO_IRQ_START + 96,
-	}
-};
-
-int __init imx1_register_gpios(void)
-{
-	return mxc_gpio_init(imx_gpio_ports, ARRAY_SIZE(imx_gpio_ports));
-}
diff --git a/arch/arm/mach-mx1/devices.h b/arch/arm/mach-mx1/devices.h
deleted file mode 100644
index 1332516..0000000
--- a/arch/arm/mach-mx1/devices.h
+++ /dev/null
@@ -1,7 +0,0 @@
-extern struct platform_device imx1_camera_device;
-extern struct platform_device imx_i2c_device0;
-extern struct platform_device imx1_uart_device0;
-extern struct platform_device imx1_uart_device1;
-extern struct platform_device imx_rtc_device;
-extern struct platform_device imx_wdt_device;
-extern struct platform_device imx_usb_device;
diff --git a/arch/arm/mach-mx1/generic.c b/arch/arm/mach-mx1/generic.c
deleted file mode 100644
index a9be5f1..0000000
--- a/arch/arm/mach-mx1/generic.c
+++ /dev/null
@@ -1,55 +0,0 @@
-/*
- *  author: Sascha Hauer
- *  Created: april 20th, 2004
- *  Copyright: Synertronixx GmbH
- *
- *  Common code for i.MX machines
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
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
- */
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/io.h>
-
-#include <asm/mach/map.h>
-
-#include <mach/common.h>
-#include <mach/hardware.h>
-
-static struct map_desc imx_io_desc[] __initdata = {
-	{
-		.virtual = MX1_IO_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(MX1_IO_BASE_ADDR),
-		.length = MX1_IO_SIZE,
-		.type = MT_DEVICE
-	}
-};
-
-void __init mx1_map_io(void)
-{
-	mxc_set_cpu_type(MXC_CPU_MX1);
-	mxc_arch_reset_init(MX1_IO_ADDRESS(MX1_WDT_BASE_ADDR));
-
-	iotable_init(imx_io_desc, ARRAY_SIZE(imx_io_desc));
-}
-
-int imx1_register_gpios(void);
-
-void __init mx1_init_irq(void)
-{
-	imx1_register_gpios();
-	mxc_init_irq(MX1_IO_ADDRESS(MX1_AVIC_BASE_ADDR));
-}
diff --git a/arch/arm/mach-mx1/ksym_mx1.c b/arch/arm/mach-mx1/ksym_mx1.c
deleted file mode 100644
index b09ee12..0000000
--- a/arch/arm/mach-mx1/ksym_mx1.c
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * Exported ksyms of ARCH_MX1
- *
- * Copyright (C) 2008, Darius Augulis <augulis.darius@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/platform_device.h>
-#include <linux/module.h>
-
-#include <mach/mx1_camera.h>
-
-/* IMX camera FIQ handler */
-EXPORT_SYMBOL(mx1_camera_sof_fiq_start);
-EXPORT_SYMBOL(mx1_camera_sof_fiq_end);
diff --git a/arch/arm/mach-mx1/mach-mx1ads.c b/arch/arm/mach-mx1/mach-mx1ads.c
deleted file mode 100644
index 5d7c85f..0000000
--- a/arch/arm/mach-mx1/mach-mx1ads.c
+++ /dev/null
@@ -1,165 +0,0 @@
-/*
- * arch/arm/mach-imx/mach-mx1ads.c
- *
- * Initially based on:
- *	linux-2.6.7-imx/arch/arm/mach-imx/scb9328.c
- *	Copyright (c) 2004 Sascha Hauer <sascha@saschahauer.de>
- *
- * 2004 (c) MontaVista Software, Inc.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/i2c.h>
-#include <linux/i2c/pcf857x.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/mtd/physmap.h>
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/time.h>
-
-#include <mach/common.h>
-#include <mach/hardware.h>
-#include <mach/i2c.h>
-#include <mach/imx-uart.h>
-#include <mach/iomux-mx1.h>
-#include <mach/irqs.h>
-
-#include "devices.h"
-
-static int mx1ads_pins[] = {
-	/* UART1 */
-	PC9_PF_UART1_CTS,
-	PC10_PF_UART1_RTS,
-	PC11_PF_UART1_TXD,
-	PC12_PF_UART1_RXD,
-	/* UART2 */
-	PB28_PF_UART2_CTS,
-	PB29_PF_UART2_RTS,
-	PB30_PF_UART2_TXD,
-	PB31_PF_UART2_RXD,
-	/* I2C */
-	PA15_PF_I2C_SDA,
-	PA16_PF_I2C_SCL,
-	/* SPI */
-	PC13_PF_SPI1_SPI_RDY,
-	PC14_PF_SPI1_SCLK,
-	PC15_PF_SPI1_SS,
-	PC16_PF_SPI1_MISO,
-	PC17_PF_SPI1_MOSI,
-};
-
-/*
- * UARTs platform data
- */
-
-static struct imxuart_platform_data uart_pdata[] = {
-	{
-		.flags = IMXUART_HAVE_RTSCTS,
-	}, {
-		.flags = IMXUART_HAVE_RTSCTS,
-	},
-};
-
-/*
- * Physmap flash
- */
-
-static struct physmap_flash_data mx1ads_flash_data = {
-	.width		= 4,		/* bankwidth in bytes */
-};
-
-static struct resource flash_resource = {
-	.start	= MX1_CS0_PHYS,
-	.end	= MX1_CS0_PHYS + SZ_32M - 1,
-	.flags	= IORESOURCE_MEM,
-};
-
-static struct platform_device flash_device = {
-	.name	= "physmap-flash",
-	.id	= 0,
-	.resource = &flash_resource,
-	.num_resources = 1,
-};
-
-/*
- * I2C
- */
-static struct pcf857x_platform_data pcf857x_data[] = {
-	{
-		.gpio_base = 4 * 32,
-	}, {
-		.gpio_base = 4 * 32 + 16,
-	}
-};
-
-static struct imxi2c_platform_data mx1ads_i2c_data = {
-	.bitrate = 100000,
-};
-
-static struct i2c_board_info mx1ads_i2c_devices[] = {
-	{
-		I2C_BOARD_INFO("pcf8575", 0x22),
-		.platform_data = &pcf857x_data[0],
-	}, {
-		I2C_BOARD_INFO("pcf8575", 0x24),
-		.platform_data = &pcf857x_data[1],
-	},
-};
-
-/*
- * Board init
- */
-static void __init mx1ads_init(void)
-{
-	mxc_gpio_setup_multiple_pins(mx1ads_pins,
-		ARRAY_SIZE(mx1ads_pins), "mx1ads");
-
-	/* UART */
-	mxc_register_device(&imx1_uart_device0, &uart_pdata[0]);
-	mxc_register_device(&imx1_uart_device1, &uart_pdata[1]);
-
-	/* Physmap flash */
-	mxc_register_device(&flash_device, &mx1ads_flash_data);
-
-	/* I2C */
-	i2c_register_board_info(0, mx1ads_i2c_devices,
-				ARRAY_SIZE(mx1ads_i2c_devices));
-
-	mxc_register_device(&imx_i2c_device0, &mx1ads_i2c_data);
-}
-
-static void __init mx1ads_timer_init(void)
-{
-	mx1_clocks_init(32000);
-}
-
-struct sys_timer mx1ads_timer = {
-	.init	= mx1ads_timer_init,
-};
-
-MACHINE_START(MX1ADS, "Freescale MX1ADS")
-	/* Maintainer: Sascha Hauer, Pengutronix */
-	.phys_io	= MX1_IO_BASE_ADDR,
-	.io_pg_offst	= (MX1_IO_BASE_ADDR_VIRT >> 18) & 0xfffc,
-	.boot_params	= MX1_PHYS_OFFSET + 0x100,
-	.map_io		= mx1_map_io,
-	.init_irq	= mx1_init_irq,
-	.timer		= &mx1ads_timer,
-	.init_machine	= mx1ads_init,
-MACHINE_END
-
-MACHINE_START(MXLADS, "Freescale MXLADS")
-	.phys_io	= MX1_IO_BASE_ADDR,
-	.io_pg_offst	= (MX1_IO_BASE_ADDR_VIRT >> 18) & 0xfffc,
-	.boot_params	= MX1_PHYS_OFFSET + 0x100,
-	.map_io		= mx1_map_io,
-	.init_irq	= mx1_init_irq,
-	.timer		= &mx1ads_timer,
-	.init_machine	= mx1ads_init,
-MACHINE_END
diff --git a/arch/arm/mach-mx1/mach-scb9328.c b/arch/arm/mach-mx1/mach-scb9328.c
deleted file mode 100644
index 482b24d..0000000
--- a/arch/arm/mach-mx1/mach-scb9328.c
+++ /dev/null
@@ -1,157 +0,0 @@
-/*
- * linux/arch/arm/mach-mx1/mach-scb9328.c
- *
- * Copyright (c) 2004 Sascha Hauer <saschahauer@web.de>
- * Copyright (c) 2006-2008 Juergen Beisert <jbeisert@netscape.net>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-
-#include <linux/platform_device.h>
-#include <linux/mtd/physmap.h>
-#include <linux/interrupt.h>
-#include <linux/dm9000.h>
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/time.h>
-
-#include <mach/common.h>
-#include <mach/hardware.h>
-#include <mach/irqs.h>
-#include <mach/imx-uart.h>
-#include <mach/iomux-mx1.h>
-
-#include "devices.h"
-
-/*
- * This scb9328 has a 32MiB flash
- */
-static struct resource flash_resource = {
-	.start	= MX1_CS0_PHYS,
-	.end	= MX1_CS0_PHYS + (32 * 1024 * 1024) - 1,
-	.flags	= IORESOURCE_MEM,
-};
-
-static struct physmap_flash_data scb_flash_data = {
-	.width  = 2,
-};
-
-static struct platform_device scb_flash_device = {
-	.name		= "physmap-flash",
-	.id		= 0,
-	.dev = {
-		.platform_data = &scb_flash_data,
-	},
-	.resource = &flash_resource,
-	.num_resources = 1,
-};
-
-/*
- * scb9328 has a DM9000 network controller
- * connected to CS5, with 16 bit data path
- * and interrupt connected to GPIO 3
- */
-
-/*
- * internal datapath is fixed 16 bit
- */
-static struct dm9000_plat_data dm9000_platdata = {
-	.flags	= DM9000_PLATF_16BITONLY,
-};
-
-/*
- * the DM9000 drivers wants two defined address spaces
- * to gain access to address latch registers and the data path.
- */
-static struct resource dm9000x_resources[] = {
-	{
-		.name	= "address area",
-		.start	= MX1_CS5_PHYS,
-		.end	= MX1_CS5_PHYS + 1,
-		.flags	= IORESOURCE_MEM,	/* address access */
-	}, {
-		.name	= "data area",
-		.start	= MX1_CS5_PHYS + 4,
-		.end	= MX1_CS5_PHYS + 5,
-		.flags	= IORESOURCE_MEM,	/* data access */
-	}, {
-		.start	= IRQ_GPIOC(3),
-		.end	= IRQ_GPIOC(3),
-		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
-	},
-};
-
-static struct platform_device dm9000x_device = {
-	.name		= "dm9000",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(dm9000x_resources),
-	.resource	= dm9000x_resources,
-	.dev		= {
-		.platform_data = &dm9000_platdata,
-	}
-};
-
-static int mxc_uart1_pins[] = {
-	PC9_PF_UART1_CTS,
-	PC10_PF_UART1_RTS,
-	PC11_PF_UART1_TXD,
-	PC12_PF_UART1_RXD,
-};
-
-static int uart1_mxc_init(struct platform_device *pdev)
-{
-	return mxc_gpio_setup_multiple_pins(mxc_uart1_pins,
-			ARRAY_SIZE(mxc_uart1_pins), "UART1");
-}
-
-static void uart1_mxc_exit(struct platform_device *pdev)
-{
-	mxc_gpio_release_multiple_pins(mxc_uart1_pins,
-			ARRAY_SIZE(mxc_uart1_pins));
-}
-
-static struct imxuart_platform_data uart_pdata = {
-	.init = uart1_mxc_init,
-	.exit = uart1_mxc_exit,
-	.flags = IMXUART_HAVE_RTSCTS,
-};
-
-static struct platform_device *devices[] __initdata = {
-	&scb_flash_device,
-	&dm9000x_device,
-};
-
-/*
- * scb9328_init - Init the CPU card itself
- */
-static void __init scb9328_init(void)
-{
-	mxc_register_device(&imx1_uart_device0, &uart_pdata);
-
-	printk(KERN_INFO"Scb9328: Adding devices\n");
-	platform_add_devices(devices, ARRAY_SIZE(devices));
-}
-
-static void __init scb9328_timer_init(void)
-{
-	mx1_clocks_init(32000);
-}
-
-static struct sys_timer scb9328_timer = {
-	.init	= scb9328_timer_init,
-};
-
-MACHINE_START(SCB9328, "Synertronixx scb9328")
-    /* Sascha Hauer */
-	.phys_io	= 0x00200000,
-	.io_pg_offst	= ((0xe0200000) >> 18) & 0xfffc,
-	.boot_params	= 0x08000100,
-	.map_io		= mx1_map_io,
-	.init_irq	= mx1_init_irq,
-	.timer		= &scb9328_timer,
-	.init_machine	= scb9328_init,
-MACHINE_END
diff --git a/arch/arm/mach-mx1/mx1_camera_fiq.S b/arch/arm/mach-mx1/mx1_camera_fiq.S
deleted file mode 100644
index 9c69aa6..0000000
--- a/arch/arm/mach-mx1/mx1_camera_fiq.S
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- *  Copyright (C) 2008 Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
- *
- *  Based on linux/arch/arm/lib/floppydma.S
- *      Copyright (C) 1995, 1996 Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/linkage.h>
-#include <asm/assembler.h>
-
-		.text
-		.global	mx1_camera_sof_fiq_end
-		.global	mx1_camera_sof_fiq_start
-mx1_camera_sof_fiq_start:
-		@ enable dma
-		ldr	r12, [r9]
-		orr	r12, r12, #0x00000001
-		str	r12, [r9]
-		@ unmask DMA interrupt
-		ldr	r12, [r8]
-		bic	r12, r12, r13
-		str	r12, [r8]
-		@ disable SOF interrupt
-		ldr	r12, [r10]
-		bic	r12, r12, #0x00010000
-		str	r12, [r10]
-		@ clear SOF flag
-		mov	r12, #0x00010000
-		str	r12, [r11]
-		@ return from FIQ
-		subs	pc, lr, #4
-mx1_camera_sof_fiq_end:
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index 4974fcc..3adad38 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -48,7 +48,6 @@ config ARCH_MX5
 
 endchoice
 
-source "arch/arm/mach-mx1/Kconfig"
 source "arch/arm/mach-imx/Kconfig"
 source "arch/arm/mach-mx3/Kconfig"
 source "arch/arm/mach-mx25/Kconfig"
-- 
1.7.1
