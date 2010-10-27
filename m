From: mike@compulab.co.il (Mike Rapoport)
Date: Wed, 27 Oct 2010 10:12:01 +0200
Subject: [PATCH 2/2] [ARM] Dove: add support for multi-purpose pins
	configuration
In-Reply-To: <cover.1288166960.git.mike@compulab.co.il>
References: <cover.1288166960.git.mike@compulab.co.il>
Message-ID: <63829134f147c923e9785f62482183efcbe62cc0.1288166961.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-dove/Makefile            |    2 +-
 arch/arm/mach-dove/include/mach/dove.h |    8 +-
 arch/arm/mach-dove/mpp.c               |  215 ++++++++++++++++++++++++++++++++
 arch/arm/mach-dove/mpp.h               |  214 +++++++++++++++++++++++++++++++
 4 files changed, 437 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-dove/mpp.c
 create mode 100644 arch/arm/mach-dove/mpp.h

diff --git a/arch/arm/mach-dove/Makefile b/arch/arm/mach-dove/Makefile
index 7ab3be5..1515f61 100644
--- a/arch/arm/mach-dove/Makefile
+++ b/arch/arm/mach-dove/Makefile
@@ -1,3 +1,3 @@
-obj-y				+= common.o addr-map.o irq.o pcie.o
+obj-y				+= common.o addr-map.o irq.o pcie.o mpp.o
 
 obj-$(CONFIG_MACH_DOVE_DB)	+= dove-db-setup.o
diff --git a/arch/arm/mach-dove/include/mach/dove.h b/arch/arm/mach-dove/include/mach/dove.h
index 148f4f0..27b4145 100644
--- a/arch/arm/mach-dove/include/mach/dove.h
+++ b/arch/arm/mach-dove/include/mach/dove.h
@@ -136,10 +136,16 @@
 #define  DOVE_AU1_SPDIFO_GPIO_EN	(1 << 1)
 #define  DOVE_NAND_GPIO_EN		(1 << 0)
 #define DOVE_MPP_CTRL4_VIRT_BASE	(DOVE_GPIO_VIRT_BASE + 0x40)
-
+#define  DOVE_SPI_GPIO_SEL		(1 << 5)
+#define  DOVE_UART1_GPIO_SEL		(1 << 4)
+#define  DOVE_AU1_GPIO_SEL		(1 << 3)
+#define  DOVE_CAM_GPIO_SEL		(1 << 2)
+#define  DOVE_SD1_GPIO_SEL		(1 << 1)
+#define  DOVE_SD0_GPIO_SEL		(1 << 0)
 
 /* Power Management */
 #define DOVE_PMU_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE | 0xd0000)
+#define DOVE_PMU_SIG_CTRL	(DOVE_PMU_VIRT_BASE + 0x802c)
 
 /* Real Time Clock */
 #define DOVE_RTC_PHYS_BASE	(DOVE_SB_REGS_PHYS_BASE | 0xd8500)
diff --git a/arch/arm/mach-dove/mpp.c b/arch/arm/mach-dove/mpp.c
new file mode 100644
index 0000000..919dd7f
--- /dev/null
+++ b/arch/arm/mach-dove/mpp.c
@@ -0,0 +1,215 @@
+/*
+ * arch/arm/mach-dove/mpp.c
+ *
+ * MPP functions for Marvell Dove SoCs
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+
+#include <mach/dove.h>
+
+#include "mpp.h"
+
+#define MPP_NR_REGS 4
+#define MPP_CTRL(i)	((i) == 3 ?				\
+			 DOVE_MPP_CTRL4_VIRT_BASE :		\
+			 DOVE_MPP_VIRT_BASE + (i) * 4)
+#define PMU_SIG_REGS 2
+#define PMU_SIG_CTRL(i)	(DOVE_PMU_SIG_CTRL + (i) * 4)
+
+struct dove_mpp_grp {
+	int start;
+	int end;
+};
+
+static struct dove_mpp_grp dove_mpp_grp[] = {
+	[MPP_24_39] = {
+		.start	= 24,
+		.end	= 39,
+	},
+	[MPP_40_45] = {
+		.start	= 40,
+		.end	= 45,
+	},
+	[MPP_46_51] = {
+		.start	= 40,
+		.end	= 45,
+	},
+	[MPP_58_61] = {
+		.start	= 58,
+		.end	= 61,
+	},
+	[MPP_62_63] = {
+		.start	= 62,
+		.end	= 63,
+	},
+};
+
+static void dove_mpp_gpio_mode(int start, int end, int gpio_mode)
+{
+	int i;
+
+	for (i = start; i <= end; i++)
+		orion_gpio_set_valid(i, gpio_mode);
+}
+
+static void dove_mpp_dump_regs(void)
+{
+#ifdef DEBUG
+	int i;
+
+	pr_debug("MPP_CTRL regs:");
+	for (i = 0; i < MPP_NR_REGS; i++)
+		printk(" %08x", readl(MPP_CTRL(i)));
+	printk("\n");
+
+	pr_debug("PMU_SIG_CTRL regs:");
+	for (i = 0; i < PMU_SIG_REGS; i++)
+		printk(" %08x", readl(PMU_SIG_CTRL(i)));
+	printk("\n");
+
+	pr_debug("PMU_MPP_GENERAL_CTRL: %08x\n", readl(DOVE_PMU_MPP_GENERAL_CTRL));
+	pr_debug("MPP_GENERAL: %08x\n", readl(DOVE_MPP_GENERAL_VIRT_BASE));
+#endif
+}
+
+static void dove_mpp_cfg_nfc(int sel)
+{
+	u32 mpp_gen_cfg = readl(DOVE_MPP_GENERAL_VIRT_BASE);
+
+	mpp_gen_cfg &= ~0x1;
+	mpp_gen_cfg |= sel;
+	writel(mpp_gen_cfg, DOVE_MPP_GENERAL_VIRT_BASE);
+
+	dove_mpp_gpio_mode(64, 71, GPIO_OUTPUT_OK);
+}
+
+static void dove_mpp_cfg_au1(int sel)
+{
+	u32 mpp_ctrl4		= readl(DOVE_MPP_CTRL4_VIRT_BASE);
+	u32 ssp_ctrl1 = readl(DOVE_SSP_CTRL_STATUS_1);
+	u32 mpp_gen_ctrl = readl(DOVE_MPP_GENERAL_VIRT_BASE);
+	u32 global_cfg_2 = readl(DOVE_GLOBAL_CONFIG_2);
+
+	mpp_ctrl4 &= ~(DOVE_AU1_GPIO_SEL);
+	ssp_ctrl1 &= ~(DOVE_SSP_ON_AU1);
+	mpp_gen_ctrl &= ~(DOVE_AU1_SPDIFO_GPIO_EN);
+	global_cfg_2 &= ~(DOVE_TWSI_OPTION3_GPIO);
+
+	if (!sel || sel == 0x2)
+		dove_mpp_gpio_mode(52, 57, 0);
+	else
+		dove_mpp_gpio_mode(52, 57, GPIO_OUTPUT_OK | GPIO_INPUT_OK);
+
+	if (sel & 0x1) {
+		global_cfg_2 |= DOVE_TWSI_OPTION3_GPIO;
+		dove_mpp_gpio_mode(56, 57, 0);
+	}
+	if (sel & 0x2) {
+		mpp_gen_ctrl |= DOVE_AU1_SPDIFO_GPIO_EN;
+		dove_mpp_gpio_mode(57, 57, GPIO_OUTPUT_OK | GPIO_INPUT_OK);
+	}
+	if (sel & 0x4) {
+		ssp_ctrl1 |= DOVE_SSP_ON_AU1;
+		dove_mpp_gpio_mode(52, 55, 0);
+	}
+	if (sel & 0x8)
+		mpp_ctrl4 |= DOVE_AU1_GPIO_SEL;
+
+	writel(mpp_ctrl4, DOVE_MPP_CTRL4_VIRT_BASE);
+	writel(ssp_ctrl1, DOVE_SSP_CTRL_STATUS_1);
+	writel(mpp_gen_ctrl, DOVE_MPP_GENERAL_VIRT_BASE);
+	writel(global_cfg_2, DOVE_GLOBAL_CONFIG_2);
+}
+
+static void dove_mpp_conf_grp(int num, int sel, u32 *mpp_ctrl)
+{
+	int start = dove_mpp_grp[num].start;
+	int end = dove_mpp_grp[num].start;
+	int gpio_mode = sel ? GPIO_OUTPUT_OK | GPIO_INPUT_OK : 0;
+
+	*mpp_ctrl &= ~(0x1 << num);
+	*mpp_ctrl |= sel << num;
+
+	dove_mpp_gpio_mode(start, end, gpio_mode);
+}
+
+void __init dove_mpp_conf(unsigned int *mpp_list)
+{
+	u32 mpp_ctrl[MPP_NR_REGS];
+	u32 pmu_mpp_ctrl = 0;
+	u32 pmu_sig_ctrl[PMU_SIG_REGS];
+	int i;
+
+	/* Initialize gpiolib. */
+	orion_gpio_init();
+
+	for (i = 0; i < MPP_NR_REGS; i++)
+		mpp_ctrl[i] = readl(MPP_CTRL(i));
+
+	for (i = 0; i < PMU_SIG_REGS; i++)
+		pmu_sig_ctrl[i] = readl(PMU_SIG_CTRL(i));
+
+	pmu_mpp_ctrl = readl(DOVE_PMU_MPP_GENERAL_CTRL);
+
+	dove_mpp_dump_regs();
+
+	while (*mpp_list != MPP_END) {
+		unsigned int num = MPP_NUM(*mpp_list);
+		unsigned int sel = MPP_SEL(*mpp_list);
+		int shift, gpio_mode;
+
+		if (num > MPP_MAX) {
+			pr_err("dove: invalid MPP number (%u)\n", num);
+			goto next_pin;
+		}
+
+		if (*mpp_list & MPP_NFC_MASK) {
+			dove_mpp_cfg_nfc(sel);
+			goto next_pin;
+		}
+
+		if (*mpp_list & MPP_AU1_MASK) {
+			dove_mpp_cfg_au1(sel);
+			goto next_pin;
+		}
+
+		if (*mpp_list & MPP_GRP_MASK) {
+			dove_mpp_conf_grp(num, sel, &mpp_ctrl[3]);
+			goto next_pin;
+		}
+
+		shift = (num & 7) << 2;
+		if (*mpp_list & MPP_PMU_MASK) {
+			pmu_mpp_ctrl |= (0x1 << num);
+			pmu_sig_ctrl[num / 8] &= ~(0xf << shift);
+			pmu_sig_ctrl[num / 8] |= ~(0xf << shift);
+			gpio_mode = 0;
+		} else {
+			mpp_ctrl[num / 8] &= ~(0xf << shift);
+			mpp_ctrl[num / 8] |= sel << shift;
+			gpio_mode = GPIO_OUTPUT_OK | GPIO_INPUT_OK;
+		}
+
+		orion_gpio_set_valid(num, gpio_mode);
+
+next_pin:
+		mpp_list++;
+	}
+
+	for (i = 0; i < MPP_NR_REGS; i++)
+		writel(mpp_ctrl[i], MPP_CTRL(i));
+
+	for (i = 0; i < PMU_SIG_REGS; i++)
+		writel(pmu_sig_ctrl[i], PMU_SIG_CTRL(i));
+
+	writel(pmu_mpp_ctrl, DOVE_PMU_MPP_GENERAL_CTRL);
+
+	dove_mpp_dump_regs();
+}
diff --git a/arch/arm/mach-dove/mpp.h b/arch/arm/mach-dove/mpp.h
new file mode 100644
index 0000000..c7b8acf
--- /dev/null
+++ b/arch/arm/mach-dove/mpp.h
@@ -0,0 +1,214 @@
+#ifndef __ARCH_DOVE_MPP_CODED_H
+#define __ARCH_DOVE_MPP_CODED_H
+
+#define MPP(_num, _mode, _pmu, _grp, _au1, _nfc) (	\
+/* MPP/group number */		((_num) & 0xff) |		\
+/* MPP select value */		(((_mode) & 0xf) << 8) |	\
+/* MPP PMU */			((!!(_pmu)) << 12) |		\
+/* group flag */		((!!(_grp)) << 13) |		\
+/* AU1 flag */			((!!(_au1)) << 14) |		\
+/* NFCE flag */			((!!(_nfc)) << 15))
+
+#define MPP_MAX	71
+
+#define MPP_NUM(x)    ((x) & 0xff)
+#define MPP_SEL(x)    (((x) >> 8) & 0xf)
+
+#define MPP_PMU_MASK		MPP(0, 0x0, 1, 0, 0, 0)
+#define MPP_GRP_MASK		MPP(0, 0x0, 0, 1, 0, 0)
+#define MPP_AU1_MASK		MPP(0, 0x0, 0, 0, 1, 0)
+#define MPP_NFC_MASK		MPP(0, 0x0, 0, 0, 0, 1)
+#define MPP_END			MPP(0xff, 0xf, 1, 1, 1, 1)
+
+#define MPP_PMU_DRIVE_0		0x1
+#define MPP_PMU_DRIVE_1		0x2
+#define MPP_PMU_SDI		0x3
+#define MPP_PMU_CPU_PWRDWN	0x4
+#define MPP_PMU_STBY_PWRDWN	0x5
+#define MPP_PMU_CORE_PWR_GOOD	0x8
+#define MPP_PMU_BAT_FAULT	0xa
+#define MPP_PMU_EXT0_WU		0xb
+#define MPP_PMU_EXT1_WU		0xc
+#define MPP_PMU_EXT2_WU		0xd
+#define MPP_PMU_BLINK		0xe
+#define MPP_PMU(_num, _func)	MPP((_num), MPP_PMU_##_func, 1, 0, 0, 0)
+
+#define MPP0_GPIO0		MPP(0, 0x0, 0, 0, 0, 0)
+#define MPP0_UA2_RTSn		MPP(0, 0x2, 0, 0, 0, 0)
+#define MPP0_SDIO0_CD		MPP(0, 0x3, 0, 0, 0, 0)
+#define MPP0_LCD0_PWM		MPP(0, 0xf, 0, 0, 0, 0)
+
+#define MPP1_GPIO1		MPP(1, 0x0, 0, 0, 0, 0)
+#define MPP1_UA2_CTSn		MPP(1, 0x2, 0, 0, 0, 0)
+#define MPP1_SDIO0_WP		MPP(1, 0x3, 0, 0, 0, 0)
+#define MPP1_LCD1_PWM		MPP(1, 0xf, 0, 0, 0, 0)
+
+#define MPP2_GPIO2		MPP(2, 0x0, 0, 0, 0, 0)
+#define MPP2_SATA_PRESENT	MPP(2, 0x1, 0, 0, 0, 0)
+#define MPP2_UA2_TXD		MPP(2, 0x2, 0, 0, 0, 0)
+#define MPP2_SDIO0_BUS_POWER	MPP(2, 0x3, 0, 0, 0, 0)
+#define MPP2_UA_RTSn1		MPP(2, 0x4, 0, 0, 0, 0)
+
+#define MPP3_GPIO3		MPP(3, 0x0, 0, 0, 0, 0)
+#define MPP3_SATA_ACT		MPP(3, 0x1, 0, 0, 0, 0)
+#define MPP3_UA2_RXD		MPP(3, 0x2, 0, 0, 0, 0)
+#define MPP3_SDIO0_LED_CTRL	MPP(3, 0x3, 0, 0, 0, 0)
+#define MPP3_UA_CTSn1		MPP(3, 0x4, 0, 0, 0, 0)
+#define MPP3_SPI_2_CS1		MPP(3, 0xf, 0, 0, 0, 0)
+
+#define MPP4_GPIO4		MPP(4, 0x0, 0, 0, 0, 0)
+#define MPP4_UA3_RTSn		MPP(4, 0x2, 0, 0, 0, 0)
+#define MPP4_SDIO1_CD		MPP(4, 0x3, 0, 0, 0, 0)
+#define MPP4_SPI_1_MISO		MPP(4, 0x4, 0, 0, 0, 0)
+
+#define MPP5_GPIO5		MPP(5, 0x0, 0, 0, 0, 0)
+#define MPP5_UA3_CTSn		MPP(5, 0x2, 0, 0, 0, 0)
+#define MPP5_SDIO1_WP		MPP(5, 0x3, 0, 0, 0, 0)
+#define MPP5_SPI_1_CS		MPP(5, 0x4, 0, 0, 0, 0)
+
+#define MPP6_GPIO6		MPP(6, 0x0, 0, 0, 0, 0)
+#define MPP6_UA3_TXD		MPP(6, 0x2, 0, 0, 0, 0)
+#define MPP6_SDIO1_BUS_POWER	MPP(6, 0x3, 0, 0, 0, 0)
+#define MPP6_SPI_1_MOSI		MPP(6, 0x4, 0, 0, 0, 0)
+
+#define MPP7_GPIO7		MPP( 7, 0x0, 0, 0, 0, 0)
+#define MPP7_UA3_RXD		MPP( 7, 0x2, 0, 0, 0, 0)
+#define MPP7_SDIO1_LED_CTRL	MPP( 7, 0x3, 0, 0, 0, 0)
+#define MPP7_SPI_1_SCK		MPP( 7, 0x4, 0, 0, 0, 0)
+
+#define MPP8_GPIO8		MPP( 8, 0x0, 0, 0, 0, 0)
+#define MPP8_WD_RST_OUT		MPP( 8, 0x1, 0, 0, 0, 0)
+
+#define MPP9_GPIO9		MPP( 9, 0x0, 0, 0, 0, 0)
+#define MPP9_PEX1_CLKREQn	MPP( 9, 0x5, 0, 0, 0, 0)
+
+#define MPP10_GPIO10		MPP(10, 0x0, 0, 0, 0, 0)
+#define MPP10_SSP_SCLK		MPP(10, 0x5, 0, 0, 0, 0)
+
+#define MPP11_GPIO11		MPP(11, 0x0, 0, 0, 0, 0)
+#define MPP11_SATA_PRESENT	MPP(11, 0x1, 0, 0, 0, 0)
+#define MPP11_SATA_ACT		MPP(11, 0x2, 0, 0, 0, 0)
+#define MPP11_SDIO0_LED_CTRL	MPP(11, 0x3, 0, 0, 0, 0)
+#define MPP11_SDIO1_LED_CTRL	MPP(11, 0x4, 0, 0, 0, 0)
+#define MPP11_PEX0_CLKREQn	MPP(11, 0x5, 0, 0, 0, 0)
+
+#define MPP12_GPIO12		MPP(12, 0x0, 0, 0, 0, 0)
+#define MPP12_SATA_ACT		MPP(12, 0x1, 0, 0, 0, 0)
+#define MPP12_UA2_RTSn		MPP(12, 0x2, 0, 0, 0, 0)
+#define MPP12_AD0_I2S_EXT_MCLK	MPP(12, 0x3, 0, 0, 0, 0)
+#define MPP12_SDIO1_CD		MPP(12, 0x4, 0, 0, 0, 0)
+
+#define MPP13_GPIO13		MPP(13, 0x0, 0, 0, 0, 0)
+#define MPP13_UA2_CTSn		MPP(13, 0x2, 0, 0, 0, 0)
+#define MPP13_AD1_I2S_EXT_MCLK	MPP(13, 0x3, 0, 0, 0, 0)
+#define MPP13_SDIO1WP		MPP(13, 0x4, 0, 0, 0, 0)
+#define MPP13_SSP_EXTCLK	MPP(13, 0x5, 0, 0, 0, 0)
+
+#define MPP14_GPIO14		MPP(14, 0x0, 0, 0, 0, 0)
+#define MPP14_UA2_TXD		MPP(14, 0x2, 0, 0, 0, 0)
+#define MPP14_SDIO1_BUS_POWER	MPP(14, 0x4, 0, 0, 0, 0)
+#define MPP14_SSP_RXD		MPP(14, 0x5, 0, 0, 0, 0)
+
+#define MPP15_GPIO15		MPP(15, 0x0, 0, 0, 0, 0)
+#define MPP15_UA2_RXD		MPP(15, 0x2, 0, 0, 0, 0)
+#define MPP15_SDIO1_LED_CTRL	MPP(15, 0x4, 0, 0, 0, 0)
+#define MPP15_SSP_SFRM		MPP(15, 0x5, 0, 0, 0, 0)
+
+#define MPP16_GPIO16		MPP(16, 0x0, 0, 0, 0, 0)
+#define MPP16_UA3_RTSn		MPP(16, 0x2, 0, 0, 0, 0)
+#define MPP16_SDIO0_CD		MPP(16, 0x3, 0, 0, 0, 0)
+#define MPP16_SPI_2_CS1		MPP(16, 0x4, 0, 0, 0, 0)
+#define MPP16_AC97_SDATA_IN1	MPP(16, 0x5, 0, 0, 0, 0)
+
+#define MPP17_GPIO17		MPP(17, 0x0, 0, 0, 0, 0)
+#define MPP17_AC97_SYSCLK_OUT	MPP(17, 0x1, 0, 0, 0, 0)
+#define MPP17_UA3_CTSn		MPP(17, 0x2, 0, 0, 0, 0)
+#define MPP17_SDIO0_WP		MPP(17, 0x3, 0, 0, 0, 0)
+#define MPP17_TW_SDA2		MPP(17, 0x4, 0, 0, 0, 0)
+#define MPP17_AC97_SDATA_IN2	MPP(17, 0x5, 0, 0, 0, 0)
+
+#define MPP18_GPIO18		MPP(18, 0x0, 0, 0, 0, 0)
+#define MPP18_UA3_TXD		MPP(18, 0x2, 0, 0, 0, 0)
+#define MPP18_SDIO0_BUS_POWER	MPP(18, 0x3, 0, 0, 0, 0)
+#define MPP18_LCD0_PWM		MPP(18, 0x4, 0, 0, 0, 0)
+#define MPP18_AC_SDATA_IN3	MPP(18, 0x5, 0, 0, 0, 0)
+
+#define MPP19_GPIO19		MPP(19, 0x0, 0, 0, 0, 0)
+#define MPP19_UA3_RXD		MPP(19, 0x2, 0, 0, 0, 0)
+#define MPP19_SDIO0_LED_CTRL	MPP(19, 0x3, 0, 0, 0, 0)
+#define MPP19_TW_SCK2		MPP(19, 0x4, 0, 0, 0, 0)
+
+#define MPP20_GPIO20		MPP(20, 0x0, 0, 0, 0, 0)
+#define MPP20_AC97_SYSCLK_OUT	MPP(20, 0x1, 0, 0, 0, 0)
+#define MPP20_SPI_2_MISO	MPP(20, 0x2, 0, 0, 0, 0)
+#define MPP20_SDIO1_CD		MPP(20, 0x3, 0, 0, 0, 0)
+#define MPP20_SDIO0_CD		MPP(20, 0x5, 0, 0, 0, 0)
+#define MPP20_SPI_1_MISO	MPP(20, 0x6, 0, 0, 0, 0)
+
+#define MPP21_GPIO21		MPP(21, 0x0, 0, 0, 0, 0)
+#define MPP21_UA1_RTSn		MPP(21, 0x1, 0, 0, 0, 0)
+#define MPP21_SPI_2_CS0		MPP(21, 0x2, 0, 0, 0, 0)
+#define MPP21_SDIO1_WP		MPP(21, 0x3, 0, 0, 0, 0)
+#define MPP21_SSP_SFRM		MPP(21, 0x4, 0, 0, 0, 0)
+#define MPP21_SDIO0_WP		MPP(21, 0x5, 0, 0, 0, 0)
+#define MPP21_SPI_1_CS		MPP(21, 0x6, 0, 0, 0, 0)
+
+#define MPP22_GPIO22		MPP(22, 0x0, 0, 0, 0, 0)
+#define MPP22_UA1_CTSn		MPP(22, 0x1, 0, 0, 0, 0)
+#define MPP22_SPI_2_MOSI	MPP(22, 0x2, 0, 0, 0, 0)
+#define MPP22_SDIO1_BUS_POWER	MPP(22, 0x3, 0, 0, 0, 0)
+#define MPP22_SSP_TXD		MPP(22, 0x4, 0, 0, 0, 0)
+#define MPP22_SDIO0_BUS_POWER	MPP(22, 0x5, 0, 0, 0, 0)
+#define MPP22_SPI_1_MOSI	MPP(22, 0x6, 0, 0, 0, 0)
+
+#define MPP23_GPIO23		MPP(23, 0x0, 0, 0, 0, 0)
+#define MPP23_SPI_2_SCK		MPP(23, 0x2, 0, 0, 0, 0)
+#define MPP23_SDIO1_LED_CTRL	MPP(23, 0x3, 0, 0, 0, 0)
+#define MPP23_SSP_SCLK		MPP(23, 0x4, 0, 0, 0, 0)
+#define MPP23_SDIO0_LED_CTRL	MPP(23, 0x5, 0, 0, 0, 0)
+#define MPP23_SPI_1_SCK		MPP(23, 0x6, 0, 0, 0, 0)
+
+/* for MPP groups _num is a group index */
+enum dove_mpp_grp_idx {
+	MPP_24_39 = 2,
+	MPP_40_45 = 0,
+	MPP_46_51 = 1,
+	MPP_58_61 = 5,
+	MPP_62_63 = 4,
+};
+
+#define MPP24_39_GPIO		MPP(MPP_24_39, 0x1, 0, 1, 0, 0)
+#define MPP24_39_CAM		MPP(MPP_24_39, 0x0, 0, 1, 0, 0)
+
+#define MPP40_45_GPIO		MPP(MPP_40_45, 0x1, 0, 1, 0, 0)
+#define MPP40_45_SD0		MPP(MPP_40_45, 0x0, 0, 1, 0, 0)
+
+#define MPP46_51_GPIO		MPP(MPP_46_51, 0x1, 0, 1, 0, 0)
+#define MPP46_51_SD1		MPP(MPP_46_51, 0x0, 0, 1, 0, 0)
+
+#define MPP58_61_GPIO		MPP(MPP_58_61, 0x1, 0, 1, 0, 0)
+#define MPP58_61_SPI		MPP(MPP_58_61, 0x0, 0, 1, 0, 0)
+
+#define MPP62_63_GPIO		MPP(MPP_62_63, 0x1, 0, 1, 0, 0)
+#define MPP62_63_UA1		MPP(MPP_62_63, 0x0, 0, 1, 0, 0)
+
+/* The MPP[64:71] control differs from other groups */
+#define MPP64_71_GPO		MPP(0, 0x1, 0, 0, 0, 1)
+#define MPP64_71_NFC		MPP(0, 0x0, 0, 0, 0, 1)
+
+/*
+ * The MPP[52:57] functionality is encoded by 4 bits in different
+ * registers. The _num field in this case encodes those bits in
+ * correspodence with Table 135 of 88AP510 Functional specification
+ */
+#define MPP52_57_AU1		MPP(0, 0x0, 0, 0, 1, 0)
+#define MPP52_57_AU1_GPIO57	MPP(0, 0x2, 0, 0, 1, 0)
+#define MPP52_57_GPIO		MPP(0, 0xa, 0, 0, 1, 0)
+#define MPP52_57_TW_GPIO	MPP(0, 0xb, 0, 0, 1, 0)
+#define MPP52_57_AU1_SSP	MPP(0, 0xc, 0, 0, 1, 0)
+#define MPP52_57_SSP_GPIO	MPP(0, 0xe, 0, 0, 1, 0)
+#define MPP52_57_SSP_TW		MPP(0, 0xf, 0, 0, 1, 0)
+
+void dove_mpp_conf(unsigned int *mpp_list);
+
+#endif	/* __ARCH_DOVE_MPP_CODED_H */
-- 
1.7.3.1
