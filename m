From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Sat, 26 Nov 2011 07:08:58 +0800
Subject: [PATCH 1/7] pinctrl: enable pxa3xx pinmux
In-Reply-To: <1322262544-7854-1-git-send-email-haojian.zhuang@marvell.com>
References: <1322262544-7854-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1322262544-7854-2-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support PXA300/PXA310/PXA320/PXA910 pinmux.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/pinctrl/Kconfig         |    5 +
 drivers/pinctrl/Makefile        |    1 +
 drivers/pinctrl/pinmux-pxa3xx.c |  931 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 937 insertions(+), 0 deletions(-)
 create mode 100644 drivers/pinctrl/pinmux-pxa3xx.c

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index e17e2f8..582f72d 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -20,6 +20,11 @@ config DEBUG_PINCTRL
 	help
 	  Say Y here to add some extra checks and diagnostics to PINCTRL calls.
 
+config PINMUX_PXA3xx
+	bool "PXA pinmux driver"
+	default y if ARCH_PXA || ARCH_MMP
+	select PINMUX
+
 config PINMUX_SIRF
 	bool "CSR SiRFprimaII pinmux driver"
 	depends on ARCH_PRIMA2
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index bdc548a..a364787 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -4,5 +4,6 @@ ccflags-$(CONFIG_DEBUG_PINMUX)	+= -DDEBUG
 
 obj-$(CONFIG_PINCTRL)		+= core.o
 obj-$(CONFIG_PINMUX)		+= pinmux.o
+obj-$(CONFIG_PINMUX_PXA3xx)	+= pinmux-pxa3xx.o
 obj-$(CONFIG_PINMUX_SIRF)	+= pinmux-sirf.o
 obj-$(CONFIG_PINMUX_U300)	+= pinmux-u300.o
diff --git a/drivers/pinctrl/pinmux-pxa3xx.c b/drivers/pinctrl/pinmux-pxa3xx.c
new file mode 100644
index 0000000..e4386fa
--- /dev/null
+++ b/drivers/pinctrl/pinmux-pxa3xx.c
@@ -0,0 +1,931 @@
+/*
+ *  linux/drivers/pinctrl/pinmux-pxa3xx.c
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  publishhed by the Free Software Foundation.
+ *
+ *  Copyright (C) 2011, Marvell Technology Group Ltd.
+ *
+ *  Author: Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/platform_device.h>
+
+#define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
+#define MFPR_FUNC		7
+#define MFPR_FUNC_MASK		(~MFPR_FUNC)
+
+
+enum {
+	PINMUX_PXA300 = 0,
+	PINMUX_PXA310,
+	PINMUX_PXA320,
+	PINMUX_PXA910,
+	PINMUX_MAX,
+};
+
+struct pxa3xx_pin_group {
+	const char *name;
+	const unsigned int *func;
+	const unsigned int *pins;
+	const unsigned int num_pins;
+};
+
+struct pxa3xx_pmx_func {
+	const char *name;
+	const char * const * groups;
+	const unsigned num_groups;
+};
+
+struct pxa3xx_pinmux_info {
+	struct device *dev;
+	struct pinctrl_dev *pctl;
+	unsigned int phy_base;
+	unsigned int phy_size;
+	void __iomem *virt_base;
+	unsigned int cpuid;
+	struct pxa3xx_pin_group *grp;
+	unsigned int num_grps;
+	struct pxa3xx_pmx_func *func;
+	unsigned int num_funcs;
+};
+
+/* These 135 pins exists in PXA300, PXA310 & PXA320 */
+#define PXA3XX_COMMON_PINS()						\
+	PINCTRL_PIN(0, "GPIO0"), 	PINCTRL_PIN(1, "GPIO1"),	\
+	PINCTRL_PIN(2, "GPIO2"),	PINCTRL_PIN(3, "GPIO3"),	\
+	PINCTRL_PIN(4, "GPIO4"),	PINCTRL_PIN(5, "GPIO5"),	\
+	PINCTRL_PIN(6, "GPIO6"),	PINCTRL_PIN(7, "GPIO7"),	\
+	PINCTRL_PIN(8, "GPIO8"),	PINCTRL_PIN(9, "GPIO9"),	\
+	PINCTRL_PIN(10, "GPIO10"),	PINCTRL_PIN(11, "GPIO11"),	\
+	PINCTRL_PIN(12, "GPIO12"),	PINCTRL_PIN(13, "GPIO13"),	\
+	PINCTRL_PIN(14, "GPIO14"),	PINCTRL_PIN(15, "GPIO15"),	\
+	PINCTRL_PIN(16, "GPIO16"),	PINCTRL_PIN(17, "GPIO17"),	\
+	PINCTRL_PIN(18, "GPIO18"),	PINCTRL_PIN(19, "GPIO19"),	\
+	PINCTRL_PIN(20, "GPIO20"),	PINCTRL_PIN(21, "GPIO21"),	\
+	PINCTRL_PIN(22, "GPIO22"),	PINCTRL_PIN(23, "GPIO23"),	\
+	PINCTRL_PIN(24, "GPIO24"),	PINCTRL_PIN(25, "GPIO25"),	\
+	PINCTRL_PIN(26, "GPIO26"),	PINCTRL_PIN(27, "GPIO27"),	\
+	PINCTRL_PIN(28, "GPIO28"),	PINCTRL_PIN(29, "GPIO29"),	\
+	PINCTRL_PIN(30, "GPIO30"),	PINCTRL_PIN(31, "GPIO31"),	\
+	PINCTRL_PIN(32, "GPIO32"),	PINCTRL_PIN(33, "GPIO33"),	\
+	PINCTRL_PIN(34, "GPIO34"),	PINCTRL_PIN(35, "GPIO35"),	\
+	PINCTRL_PIN(36, "GPIO36"),	PINCTRL_PIN(37, "GPIO37"),	\
+	PINCTRL_PIN(38, "GPIO38"),	PINCTRL_PIN(39, "GPIO39"),	\
+	PINCTRL_PIN(40, "GPIO40"),	PINCTRL_PIN(41, "GPIO41"),	\
+	PINCTRL_PIN(42, "GPIO42"),	PINCTRL_PIN(43, "GPIO43"),	\
+	PINCTRL_PIN(44, "GPIO44"),	PINCTRL_PIN(45, "GPIO45"),	\
+	PINCTRL_PIN(46, "GPIO46"),	PINCTRL_PIN(47, "GPIO47"),	\
+	PINCTRL_PIN(48, "GPIO48"),	PINCTRL_PIN(49, "GPIO49"),	\
+	PINCTRL_PIN(50, "GPIO50"),	PINCTRL_PIN(51, "GPIO51"),	\
+	PINCTRL_PIN(52, "GPIO52"),	PINCTRL_PIN(53, "GPIO53"),	\
+	PINCTRL_PIN(54, "GPIO54"),	PINCTRL_PIN(55, "GPIO55"),	\
+	PINCTRL_PIN(56, "GPIO56"),	PINCTRL_PIN(57, "GPIO57"),	\
+	PINCTRL_PIN(58, "GPIO58"),	PINCTRL_PIN(59, "GPIO59"),	\
+	PINCTRL_PIN(60, "GPIO60"),	PINCTRL_PIN(61, "GPIO61"),	\
+	PINCTRL_PIN(62, "GPIO62"),	PINCTRL_PIN(63, "GPIO63"),	\
+	PINCTRL_PIN(64, "GPIO64"),	PINCTRL_PIN(65, "GPIO65"),	\
+	PINCTRL_PIN(66, "GPIO66"),	PINCTRL_PIN(67, "GPIO67"),	\
+	PINCTRL_PIN(68, "GPIO68"),	PINCTRL_PIN(69, "GPIO69"),	\
+	PINCTRL_PIN(70, "GPIO70"),	PINCTRL_PIN(71, "GPIO71"),	\
+	PINCTRL_PIN(72, "GPIO72"),	PINCTRL_PIN(73, "GPIO73"),	\
+	PINCTRL_PIN(74, "GPIO74"),	PINCTRL_PIN(75, "GPIO75"),	\
+	PINCTRL_PIN(76, "GPIO76"),	PINCTRL_PIN(77, "GPIO77"),	\
+	PINCTRL_PIN(78, "GPIO78"),	PINCTRL_PIN(79, "GPIO79"),	\
+	PINCTRL_PIN(80, "GPIO80"),	PINCTRL_PIN(81, "GPIO81"),	\
+	PINCTRL_PIN(82, "GPIO82"),	PINCTRL_PIN(83, "GPIO83"),	\
+	PINCTRL_PIN(84, "GPIO84"),	PINCTRL_PIN(85, "GPIO85"),	\
+	PINCTRL_PIN(86, "GPIO86"),	PINCTRL_PIN(87, "GPIO87"),	\
+	PINCTRL_PIN(88, "GPIO88"),	PINCTRL_PIN(89, "GPIO89"),	\
+	PINCTRL_PIN(90, "GPIO90"),	PINCTRL_PIN(91, "GPIO91"),	\
+	PINCTRL_PIN(92, "GPIO92"),	PINCTRL_PIN(93, "GPIO93"),	\
+	PINCTRL_PIN(94, "GPIO94"),	PINCTRL_PIN(95, "GPIO95"),	\
+	PINCTRL_PIN(96, "GPIO96"),	PINCTRL_PIN(97, "GPIO97"),	\
+	PINCTRL_PIN(98, "GPIO98"),	PINCTRL_PIN(99, "GPIO99"),	\
+	PINCTRL_PIN(100, "GPIO100"),	PINCTRL_PIN(101, "GPIO101"),	\
+	PINCTRL_PIN(102, "GPIO102"),	PINCTRL_PIN(103, "GPIO103"),	\
+	PINCTRL_PIN(104, "GPIO104"),	PINCTRL_PIN(105, "GPIO105"),	\
+	PINCTRL_PIN(106, "GPIO106"),	PINCTRL_PIN(107, "GPIO107"),	\
+	PINCTRL_PIN(108, "GPIO108"),	PINCTRL_PIN(109, "GPIO109"),	\
+	PINCTRL_PIN(110, "GPIO110"),	PINCTRL_PIN(111, "GPIO111"),	\
+	PINCTRL_PIN(112, "GPIO112"),	PINCTRL_PIN(113, "GPIO113"),	\
+	PINCTRL_PIN(114, "GPIO114"),	PINCTRL_PIN(115, "GPIO115"),	\
+	PINCTRL_PIN(116, "GPIO116"),	PINCTRL_PIN(117, "GPIO117"),	\
+	PINCTRL_PIN(118, "GPIO118"),	PINCTRL_PIN(119, "GPIO119"),	\
+	PINCTRL_PIN(120, "GPIO120"),	PINCTRL_PIN(121, "GPIO121"),	\
+	PINCTRL_PIN(122, "GPIO122"),	PINCTRL_PIN(123, "GPIO123"),	\
+	PINCTRL_PIN(124, "GPIO124"),	PINCTRL_PIN(125, "GPIO125"),	\
+	PINCTRL_PIN(126, "GPIO126"),	PINCTRL_PIN(127, "GPIO127")
+
+#ifdef CONFIG_ARCH_PXA
+static struct pinctrl_pin_desc pxa300_pads[] = {
+	PXA3XX_COMMON_PINS(),
+	PINCTRL_PIN(128, "GPIO0_2"),	PINCTRL_PIN(129, "GPIO1_2"),
+	PINCTRL_PIN(130, "GPIO2_2"),	PINCTRL_PIN(131, "GPIO3_2"),
+	PINCTRL_PIN(132, "GPIO4_2"),	PINCTRL_PIN(133, "GPIO5_2"),
+	PINCTRL_PIN(134, "GPIO6_2"),
+};
+
+static struct pinctrl_pin_desc pxa310_pads[] = {
+	PXA3XX_COMMON_PINS(),
+	PINCTRL_PIN(128, "GPIO0_2"),	PINCTRL_PIN(129, "GPIO1_2"),
+	PINCTRL_PIN(130, "GPIO2_2"),	PINCTRL_PIN(131, "GPIO3_2"),
+	PINCTRL_PIN(132, "GPIO4_2"),	PINCTRL_PIN(133, "GPIO5_2"),
+	PINCTRL_PIN(134, "GPIO6_2"),	PINCTRL_PIN(135, "GPIO7_2"),
+	PINCTRL_PIN(136, "GPIO8_2"),	PINCTRL_PIN(137, "GPIO9_2"),
+	PINCTRL_PIN(138, "GPIO10_2"),
+};
+
+static struct pinctrl_pin_desc pxa320_pads[] = {
+	PXA3XX_COMMON_PINS(),
+	PINCTRL_PIN(128, "GPIO0_2"),	PINCTRL_PIN(129, "GPIO1_2"),
+	PINCTRL_PIN(130, "GPIO2_2"),	PINCTRL_PIN(131, "GPIO3_2"),
+	PINCTRL_PIN(132, "GPIO4_2"),	PINCTRL_PIN(133, "GPIO5_2"),
+	PINCTRL_PIN(134, "GPIO6_2"),	PINCTRL_PIN(135, "GPIO7_2"),
+	PINCTRL_PIN(136, "GPIO8_2"),	PINCTRL_PIN(137, "GPIO9_2"),
+	PINCTRL_PIN(138, "GPIO10_2"),	PINCTRL_PIN(139, "GPIO11_2"),
+	PINCTRL_PIN(140, "GPIO12_2"),	PINCTRL_PIN(141, "GPIO13_2"),
+	PINCTRL_PIN(142, "GPIO14_2"),	PINCTRL_PIN(143, "GPIO15_2"),
+	PINCTRL_PIN(144, "GPIO16_2"),	PINCTRL_PIN(145, "GPIO17_2"),
+};
+
+/* the sequence follows pxa300_pads[] */
+const static unsigned pxa300_mfpr[] = {
+	0x0B4, 0x0B8, 0x0BC, 0x27C, 0x280, 0x284, 0x288, 0x28C, 0x290, 0x294,
+	0x298, 0x29C, 0x2A0, 0x2A4, 0x2A8, 0x2AC, 0x2B0, 0x2B4, 0x2B8, 0x2BC,
+	0x2C0, 0x2C4, 0x2C8, 0x2CC, 0x2D0, 0x2D4, 0x2D8, 0x400, 0x404, 0x408,
+	0x40C, 0x410, 0x414, 0x418, 0x41C, 0x420, 0x424, 0x428, 0x42C, 0x430,
+	0x434, 0x438, 0x43C, 0x440, 0x444, 0x448, 0x44C, 0x450, 0x454, 0x458,
+	0x45C, 0x460, 0x464, 0x468, 0x46C, 0x470, 0x474, 0x478, 0x47C, 0x480,
+	0x484, 0x488, 0x48C, 0x490, 0x494, 0x498, 0x49C, 0x4A0, 0x4A4, 0x4A8,
+	0x4AC, 0x4B0, 0x4B4, 0x4B8, 0x4BC, 0x4C0, 0x4C4, 0x4C8, 0x4CC, 0x4D0,
+	0x4D4, 0x4D8, 0x4DC, 0x4E0, 0x4E4, 0x4E8, 0x4EC, 0x4F0, 0x4F4, 0x4F8,
+	0x4FC, 0x500, 0x504, 0x508, 0x50C, 0x510, 0x514, 0x518, 0x51C, 0x600,
+	0x604, 0x608, 0x60C, 0x610, 0x614, 0x618, 0x61C, 0x620, 0x624, 0x628,
+	0x62C, 0x630, 0x634, 0x638, 0x63C, 0x640, 0x644, 0x648, 0x64C, 0x650,
+	0x654, 0x658, 0x65C, 0x660, 0x664, 0x668, 0x66C, 0x670,
+	/* the below pins can also be configured as GPIO[6:0] */
+	0x674, 0x678, 0x2DC, 0x2E0, 0x2E4, 0x2E8, 0x2EC,
+};
+
+/* the sequence follows pxa310_pads[] */
+const static unsigned pxa310_mfpr[] = {
+	0x0B4, 0x0B8, 0x0BC, 0x27C, 0x280, 0x284, 0x288, 0x28C, 0x290, 0x294,
+	0x298, 0x29C, 0x2A0, 0x2A4, 0x2A8, 0x2AC, 0x2B0, 0x2B4, 0x2B8, 0x2BC,
+	0x2C0, 0x2C4, 0x2C8, 0x2CC, 0x2D0, 0x2D4, 0x2D8, 0x400, 0x404, 0x408,
+	0x418, 0x41C, 0x420, 0x424, 0x428, 0x42C, 0x430, 0x434, 0x438, 0x43C,
+	0x440, 0x444, 0x448, 0x44C, 0x450, 0x454, 0x458, 0x45C, 0x460, 0x464,
+	0x468, 0x46C, 0x470, 0x474, 0x478, 0x47C, 0x480, 0x484, 0x488, 0x48C,
+	0x490, 0x494, 0x498, 0x49C, 0x4A0, 0x4A4, 0x4A8, 0x4AC, 0x4B0, 0x4B4,
+	0x4B8, 0x4BC, 0x4C0, 0x4C4, 0x4C8, 0x4CC, 0x4D0, 0x4D4, 0x4D8, 0x4DC,
+	0x4E0, 0x4E4, 0x4E8, 0x4EC, 0x4F0, 0x4F4, 0x4F8, 0x4FC, 0x500, 0x504,
+	0x508, 0x50C, 0x510, 0x514, 0x518, 0x51C, 0x520, 0x524, 0x528, 0x600,
+	0x604, 0x608, 0x60C, 0x610, 0x614, 0x618, 0x61C, 0x620, 0x624, 0x628,
+	0x62C, 0x630, 0x634, 0x638, 0x63C, 0x640, 0x644, 0x648, 0x64C, 0x650,
+	0x654, 0x658, 0x65C, 0x660, 0x664, 0x668, 0x66C, 0x670,
+	/* the below pins can also be configured as GPIO[10:0] */
+	0x674, 0x678, 0x2DC, 0x2E0, 0x2E4, 0x2E8, 0x2EC, 0x52C, 0x530, 0x534,
+	0x538,
+};
+
+/* the sequence follows pxa320_pads[] */
+const static unsigned pxa320_mfpr[] = {
+	0x124, 0x128, 0x12C, 0x130, 0x134, 0x28C, 0x290, 0x294, 0x298, 0x29C,
+	0x458, 0x2A0, 0x2A4, 0x2A8, 0x2AC, 0x2B0, 0x2B4, 0x2B8, 0x2BC, 0x2C0,
+	0x2C4, 0x2C8, 0x2CC, 0x2D0, 0x2D4, 0x2D8, 0x2DC, 0x400, 0x404, 0x408,
+	0x40C, 0x410, 0x414, 0x418, 0x41C, 0x420, 0x424, 0x428, 0x42C, 0x430,
+	0x434, 0x438, 0x43C, 0x440, 0x444, 0x448, 0x44C, 0x450, 0x454, 0x45C,
+	0x460, 0x464, 0x468, 0x46C, 0x470, 0x474, 0x478, 0x47C, 0x480, 0x484,
+	0x488, 0x48C, 0x490, 0x4B4, 0x4B8, 0x4BC, 0x4C0, 0x4C4, 0x4C8, 0x4CC,
+	0x4D0, 0x4D4, 0x4D8, 0x4DC, 0x4F0, 0x4F4, 0x4F8, 0x4FC, 0x500, 0x504,
+	0x508, 0x50C, 0x510, 0x514, 0x518, 0x51C, 0x520, 0x524, 0x528, 0x52C,
+	0x530, 0x534, 0x538, 0x53C, 0x540, 0x544, 0x548, 0x54C, 0x550, 0x600,
+	0x604, 0x608, 0x60C, 0x610, 0x614, 0x618, 0x61C, 0x620, 0x624, 0x628,
+	0x62C, 0x630, 0x634, 0x638, 0x63C, 0x640, 0x644, 0x648, 0x64C, 0x650,
+	0x654, 0x658, 0x65C, 0x660, 0x664, 0x668, 0x66C, 0x670,
+	/* the below pins can also be configured as GPIO[17:0] */
+	0x674, 0x678, 0x67C, 0x680, 0x684, 0x688, 0x494, 0x498, 0x49C, 0x4A0,
+	0x4A4, 0x4A8, 0x4AC, 0x4B0, 0x4E0, 0x4E4, 0x4E8, 0x4EC,
+};
+
+/*
+ * pxa300_xxx_pins and pxa300_xxx_func are pairs.
+ * One is pin number, the other is function number.
+ */
+static const unsigned pxa300_uart1_0_pins[] = {30, 31, 32, 33, 34, 35, 36, 37};
+static const unsigned pxa300_uart1_0_func[] = {2, 2, 2, 2, 2, 2, 2, 2};
+static const unsigned pxa300_uart1_1_pins[] = {77, 78, 79, 81, 83, 84};
+static const unsigned pxa300_uart1_1_func[] = {1, 1, 1, 1, 1, 1};
+static const unsigned pxa300_uart2_pins[] = {111, 112, 113, 114};
+static const unsigned pxa300_uart2_func[] = {1, 1, 1, 1};
+static const unsigned pxa300_uart3_0_pins[] = {107, 108, 109, 110};
+static const unsigned pxa300_uart3_0_func[] = {1, 1, 1, 1};
+static const unsigned pxa300_uart3_1_pins[] = {109, 110};
+static const unsigned pxa300_uart3_1_func[] = {1, 1};
+static const unsigned pxa300_lcd0_pins[] = {54, 55, 56, 57, 58, 59, 60, 61, 62,
+		63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 127};
+static const unsigned pxa300_lcd0_func[] = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
+		1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1};
+/* not include LCD_CS */
+static const unsigned pxa300_lcd1_pins[] = {54, 55, 56, 57, 58, 59, 60, 61, 62,
+		63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76};
+static const unsigned pxa300_lcd1_func[] = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
+		1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2};
+/* pxa300_ac97[] not include SDATA_IN_1 pin */
+static const unsigned pxa300_ac97_pins[] = {23, 24, 25, 27, 28, 29};
+static const unsigned pxa300_ac97_func[] = {1, 1, 1, 1, 1, 1};
+static const unsigned pxa300_ssp1_pins[] = {85, 56, 87, 88, 89, 90};
+static const unsigned pxa300_ssp1_func[] = {1, 1, 1, 1, 1, 1};
+/* SSPSCLK2 & SSPTXD2 */
+static const unsigned pxa300_ssp2_0_pins[] = {25, 27};
+static const unsigned pxa300_ssp2_0_func[] = {2, 2};
+/* SSPSCLK2, SSPSFRM2, SSPTXD2 & SSPEXTCLK2 */
+static const unsigned pxa300_ssp2_1_pins[] = {25, 26, 27, 29};
+static const unsigned pxa300_ssp2_1_func[] = {2, 2, 2, 2};
+static const unsigned pxa300_ssp3_pins[] = {91, 92, 93, 94};
+static const unsigned pxa300_ssp3_func[] = {1, 1, 1, 1};
+/* DKIN[1:0], MKIN[7:0] & MKOUT[7:0] */
+static const unsigned pxa300_key0_pins[] = {107, 108, 115, 116, 117, 118,
+		119, 120, 130, 131, 121, 122, 123, 124, 125, 132, 133, 134};
+static const unsigned pxa300_key0_func[] = {2, 2, 1, 1, 1, 1, 1, 1, 1, 1,
+		1, 1, 1, 1, 1, 1, 1, 1};
+/* DKIN[1:0], MKIN[5:0] & MKOUT[4:0] */
+static const unsigned pxa300_key1_pins[] = {107, 108, 115, 116, 117, 118,
+		119, 120, 121, 122, 123, 124, 125};
+static const unsigned pxa300_key1_func[] = {2, 2, 1, 1, 1, 1, 1, 1, 1, 1,
+		1, 1, 1};
+/* MKIN[7:0] & MKOUT[5:0] */
+static const unsigned pxa300_key2_pins[] = {115, 116, 117, 118, 119, 120, 130,
+		131, 121, 122, 123, 124, 125, 132};
+static const unsigned pxa300_key2_func[] = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
+		1, 1, 1};
+static const unsigned pxa300_mmc1_0_pins[] = {3, 4, 5, 6, 7, 8};
+static const unsigned pxa300_mmc1_0_func[] = {4, 4, 4, 4, 4, 4};
+static const unsigned pxa300_mmc1_1_pins[] = {3, 4, 5, 6, 7, 14};
+static const unsigned pxa300_mmc1_1_func[] = {4, 4, 4, 4, 4, 5};
+static const unsigned pxa300_mmc2_pins[] = {9, 10, 11, 12, 13, 14};
+static const unsigned pxa300_mmc2_func[] = {4, 4, 4, 4, 4, 4};
+static const unsigned pxa300_usbh_pins[] = {128, 129};
+static const unsigned pxa300_usbh_func[] = {1, 1};
+static const unsigned pxa300_usbp3_pins[] = {77, 78, 79, 80, 81, 82};
+static const unsigned pxa300_usbp3_func[] = {2, 2, 2, 2, 2, 2};
+static const unsigned pxa300_i2c_pins[] = {21, 22};
+static const unsigned pxa300_i2c_func[] = {1, 1};
+static const unsigned pxa300_smc_pins[] = {2};
+static const unsigned pxa300_smc_func[] = {1};
+static const unsigned pxa300_pwm3_pins[] = {20};
+static const unsigned pxa300_pwm3_func[] = {1};
+
+static struct pxa3xx_pin_group pxa300_pin_groups[] = {
+	{"ffuart0", pxa300_uart1_0_func, ARRAY_AND_SIZE(pxa300_uart1_0_pins)},
+	{"ffuart1", pxa300_uart1_0_func, ARRAY_AND_SIZE(pxa300_uart1_1_pins)},
+	{"btuart", pxa300_uart2_func, ARRAY_AND_SIZE(pxa300_uart2_pins)},
+	{"stuart0", pxa300_uart3_0_func, ARRAY_AND_SIZE(pxa300_uart3_0_pins)},
+	{"stuart1", pxa300_uart3_1_func, ARRAY_AND_SIZE(pxa300_uart3_1_pins)},
+	{"lcd0", pxa300_lcd0_func, ARRAY_AND_SIZE(pxa300_lcd0_pins)},
+	{"lcd1", pxa300_lcd1_func, ARRAY_AND_SIZE(pxa300_lcd1_pins)},
+	{"ac97", pxa300_ac97_func, ARRAY_AND_SIZE(pxa300_ac97_pins)},
+	{"ssp2_0", pxa300_ssp2_0_func, ARRAY_AND_SIZE(pxa300_ssp2_0_pins)},
+	{"ssp2_1", pxa300_ssp2_1_func, ARRAY_AND_SIZE(pxa300_ssp2_1_pins)},
+	{"ssp3", pxa300_ssp3_func, ARRAY_AND_SIZE(pxa300_ssp3_pins)},
+	{"key0", pxa300_key0_func, ARRAY_AND_SIZE(pxa300_key0_pins)},
+	{"key1", pxa300_key1_func, ARRAY_AND_SIZE(pxa300_key1_pins)},
+	{"key2", pxa300_key2_func, ARRAY_AND_SIZE(pxa300_key2_pins)},
+	{"mmc1_0", pxa300_mmc1_0_func, ARRAY_AND_SIZE(pxa300_mmc1_0_pins)},
+	{"mmc1_1", pxa300_mmc1_1_func, ARRAY_AND_SIZE(pxa300_mmc1_1_pins)},
+	{"mmc2", pxa300_mmc2_func, ARRAY_AND_SIZE(pxa300_mmc2_pins)},
+	{"usbh", pxa300_usbh_func, ARRAY_AND_SIZE(pxa300_usbh_pins)},
+	{"usbp3", pxa300_usbp3_func, ARRAY_AND_SIZE(pxa300_usbp3_pins)},
+	{"i2c", pxa300_i2c_func, ARRAY_AND_SIZE(pxa300_i2c_pins)},
+	{"smc", pxa300_smc_func, ARRAY_AND_SIZE(pxa300_smc_pins)},
+	{"pwm3", pxa300_pwm3_func, ARRAY_AND_SIZE(pxa300_pwm3_pins)},
+};
+
+static const char * const pxa300_uart0_grps[] = {"ffuart0", "ffuart1"};
+static const char * const pxa300_uart1_grps[] = {"btuart"};
+static const char * const pxa300_uart2_grps[] = {"stuart0", "stuart1"};
+static const char * const pxa300_lcd_grps[] = {"lcd0", "lcd1"};
+static const char * const pxa300_ac97_grps[] = {"ac97"};
+static const char * const pxa300_ssp2_grps[] = {"ssp2_0", "ssp2_1"};
+static const char * const pxa300_ssp3_grps[] = {"ssp3"};
+static const char * const pxa300_key_grps[] = {"key0", "key1", "key2"};
+static const char * const pxa300_mmc1_grps[] = {"mmc1_0", "mmc1_1"};
+static const char * const pxa300_mmc2_grps[] = {"mmc2"};
+static const char * const pxa300_usbh_grps[] = {"usbh"};
+static const char * const pxa300_usbp3_grps[] = {"usbp3"};
+static const char * const pxa300_i2c_grps[] = {"i2c"};
+static const char * const pxa300_smc_grps[] = {"smc"};
+static const char * const pxa300_pwm3_grps[] = {"pwm3"};
+
+static struct pxa3xx_pmx_func pxa300_pmx_functions[] = {
+	{"uart0",	ARRAY_AND_SIZE(pxa300_uart0_grps)},
+	{"uart1",	ARRAY_AND_SIZE(pxa300_uart1_grps)},
+	{"uart2",	ARRAY_AND_SIZE(pxa300_uart2_grps)},
+	{"lcd",		ARRAY_AND_SIZE(pxa300_lcd_grps)},
+	{"ac97",	ARRAY_AND_SIZE(pxa300_ac97_grps)},
+	{"ssp2",	ARRAY_AND_SIZE(pxa300_ssp2_grps)},
+	{"ssp3",	ARRAY_AND_SIZE(pxa300_ssp3_grps)},
+	{"key",		ARRAY_AND_SIZE(pxa300_key_grps)},
+	{"mmc1",	ARRAY_AND_SIZE(pxa300_mmc1_grps)},
+	{"mmc2",	ARRAY_AND_SIZE(pxa300_mmc2_grps)},
+	{"usbh",	ARRAY_AND_SIZE(pxa300_usbh_grps)},
+	{"usbp3",	ARRAY_AND_SIZE(pxa300_usbp3_grps)},
+	{"i2c",		ARRAY_AND_SIZE(pxa300_i2c_grps)},
+	{"smc",		ARRAY_AND_SIZE(pxa300_smc_grps)},
+	{"pwm3",	ARRAY_AND_SIZE(pxa300_pwm3_grps)},
+};
+
+/* RxD, TxD, CTS, RTS of UART1 */
+static const unsigned pxa310_uart1_2_pins[] = {99, 100, 101, 106};
+static const unsigned pxa310_uart1_2_func[] = {1, 1, 1, 1};
+static const unsigned pxa310_mmc3_pins[] = {135, 136, 137, 138, 103, 105};
+static const unsigned pxa310_mmc3_func[] = {1, 1, 1, 1, 2, 2};
+static const unsigned pxa310_ulpi_pins[] = {30, 31, 32, 33, 34, 35, 36,
+		37, 38};
+static const unsigned pxa310_ulpi_func[] = {3, 3, 3, 3, 3, 3, 3, 3, 1};
+
+static struct pxa3xx_pin_group pxa310_pin_groups[] = {
+	{"ffuart2", pxa310_uart1_2_func, ARRAY_AND_SIZE(pxa310_uart1_2_pins)},
+	{"btuart", pxa300_uart2_func, ARRAY_AND_SIZE(pxa300_uart2_pins)},
+	{"stuart0", pxa300_uart3_0_func, ARRAY_AND_SIZE(pxa300_uart3_0_pins)},
+	{"stuart1", pxa300_uart3_1_func, ARRAY_AND_SIZE(pxa300_uart3_1_pins)},
+	{"lcd0", pxa300_lcd0_func, ARRAY_AND_SIZE(pxa300_lcd0_pins)},
+	{"lcd1", pxa300_lcd1_func, ARRAY_AND_SIZE(pxa300_lcd1_pins)},
+	{"ac97", pxa300_ac97_func, ARRAY_AND_SIZE(pxa300_ac97_pins)},
+	{"ssp2", pxa300_ssp2_0_func, ARRAY_AND_SIZE(pxa300_ssp2_0_pins)},
+	{"ssp3", pxa300_ssp3_func, ARRAY_AND_SIZE(pxa300_ssp3_pins)},
+	{"key0", pxa300_key0_func, ARRAY_AND_SIZE(pxa300_key0_pins)},
+	{"key1", pxa300_key1_func, ARRAY_AND_SIZE(pxa300_key1_pins)},
+	{"key2", pxa300_key2_func, ARRAY_AND_SIZE(pxa300_key2_pins)},
+	{"mmc1_0", pxa300_mmc1_0_func, ARRAY_AND_SIZE(pxa300_mmc1_0_pins)},
+	{"mmc1_1", pxa300_mmc1_1_func, ARRAY_AND_SIZE(pxa300_mmc1_1_pins)},
+	{"mmc2", pxa300_mmc2_func, ARRAY_AND_SIZE(pxa300_mmc2_pins)},
+	{"mmc3", pxa310_mmc3_func, ARRAY_AND_SIZE(pxa310_mmc3_pins)},
+	{"usbh", pxa300_usbh_func, ARRAY_AND_SIZE(pxa300_usbh_pins)},
+	{"ulpi", pxa310_ulpi_func, ARRAY_AND_SIZE(pxa310_ulpi_pins)},
+	{"usbp3", pxa300_usbp3_func, ARRAY_AND_SIZE(pxa300_usbp3_pins)},
+	{"i2c", pxa300_i2c_func, ARRAY_AND_SIZE(pxa300_i2c_pins)},
+	{"smc", pxa300_smc_func, ARRAY_AND_SIZE(pxa300_smc_pins)},
+	{"pwm3", pxa300_pwm3_func, ARRAY_AND_SIZE(pxa300_pwm3_pins)},
+};
+
+static const char * const pxa310_uart0_grps[] = {"ffuart2"};
+static const char * const pxa310_mmc3_grps[] = {"mmc3"};
+static const char * const pxa310_ulpi_grps[] = {"ulpi"};
+
+static struct pxa3xx_pmx_func pxa310_pmx_functions[] = {
+	{"uart1",	ARRAY_AND_SIZE(pxa300_uart1_grps)},
+	{"uart2",	ARRAY_AND_SIZE(pxa300_uart2_grps)},
+	{"lcd",		ARRAY_AND_SIZE(pxa300_lcd_grps)},
+	{"ac97",	ARRAY_AND_SIZE(pxa300_ac97_grps)},
+	{"ssp3",	ARRAY_AND_SIZE(pxa300_ssp3_grps)},
+	{"key",		ARRAY_AND_SIZE(pxa300_key_grps)},
+	{"mmc1",	ARRAY_AND_SIZE(pxa300_mmc1_grps)},
+	{"mmc2",	ARRAY_AND_SIZE(pxa300_mmc2_grps)},
+	{"usbh",	ARRAY_AND_SIZE(pxa300_usbh_grps)},
+	{"usbp3",	ARRAY_AND_SIZE(pxa300_usbp3_grps)},
+	{"i2c",		ARRAY_AND_SIZE(pxa300_i2c_grps)},
+	{"smc",		ARRAY_AND_SIZE(pxa300_smc_grps)},
+	{"pwm3",	ARRAY_AND_SIZE(pxa300_pwm3_grps)},
+	/* new in PXA310 */
+	{"uart0",	ARRAY_AND_SIZE(pxa310_uart0_grps)},
+	{"mmc3",	ARRAY_AND_SIZE(pxa310_mmc3_grps)},
+	{"ulpi",	ARRAY_AND_SIZE(pxa310_ulpi_grps)},
+};
+
+static const unsigned pxa320_lcd_pins[] = {134, 135, 136, 137, 138, 139,
+		140, 141, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74,
+		142, 143, 144, 145};
+static const unsigned pxa320_lcd_func[] = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
+		1, 1, 1, 1, 1, 1, 1, 2, 2, 1, 1, 1, 1};
+static const unsigned pxa320_uart0_pins[] = {41, 42, 43, 44, 45, 46, 47, 48};
+static const unsigned pxa320_uart0_func[] = {2, 2, 2, 2, 2, 2, 2, 2};
+/* not include SDATA_IN_1 */
+static const unsigned pxa320_ac97_pins[] = {34, 35, 37, 38, 39, 40};
+static const unsigned pxa320_ac97_func[] = {1, 1, 1, 1, 1, 1};
+static const unsigned pxa320_ssp3_pins[] = {89, 90, 91, 92};
+static const unsigned pxa320_ssp3_func[] = {1, 1, 1, 1};
+static const unsigned pxa320_i2c_pins[] = {32, 33};
+static const unsigned pxa320_i2c_func[] = {1, 1};
+/* DKIN[1:0], MKIN[7:0] & MKOUT[7:0] */
+static const unsigned pxa320_key_pins[] = {105, 106, 113, 114, 115, 116, 117,
+		118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 133};
+static const unsigned pxa320_key_func[] = {2, 2, 1, 1, 1, 1, 1, 1, 1, 1,
+		1, 1, 1, 1, 1, 1, 1, 1};
+static const unsigned pxa320_smc_pins[] = {4};
+static const unsigned pxa320_smc_func[] = {1};
+static const unsigned pxa320_mmc1_pins[] = {18, 19, 20, 21, 22, 23};
+static const unsigned pxa320_mmc1_func[] = {4, 4, 4, 4, 4, 4};
+static const unsigned pxa320_mmc2_pins[] = {24, 25, 26, 27, 28, 29};
+static const unsigned pxa320_mmc2_func[] = {4, 4, 4, 4, 4, 4};
+static const unsigned pxa320_usbh_pins[] = {130, 131};
+static const unsigned pxa320_usbh_func[] = {1, 1};
+static const unsigned pxa320_pwm3_pins[] = {14};
+static const unsigned pxa320_pwm3_func[] = {1};
+static const unsigned pxa320_usim_pins[] = {15, 17};
+static const unsigned pxa320_usim_func[] = {1};
+
+static struct pxa3xx_pin_group pxa320_pin_groups[] = {
+	{"lcd", pxa320_lcd_func, ARRAY_AND_SIZE(pxa320_lcd_pins)},
+	{"ffuart", pxa320_uart0_func, ARRAY_AND_SIZE(pxa320_uart0_pins)},
+	{"ac97", pxa320_ac97_func, ARRAY_AND_SIZE(pxa320_ac97_pins)},
+	{"ssp3", pxa320_ssp3_func, ARRAY_AND_SIZE(pxa320_ssp3_pins)},
+	{"i2c", pxa320_i2c_func, ARRAY_AND_SIZE(pxa320_i2c_pins)},
+	{"key", pxa320_key_func, ARRAY_AND_SIZE(pxa320_key_pins)},
+	{"smc", pxa320_smc_func, ARRAY_AND_SIZE(pxa320_smc_pins)},
+	{"mmc1", pxa320_mmc1_func, ARRAY_AND_SIZE(pxa320_mmc1_pins)},
+	{"mmc2", pxa320_mmc2_func, ARRAY_AND_SIZE(pxa320_mmc2_pins)},
+	{"usbh", pxa320_usbh_func, ARRAY_AND_SIZE(pxa320_usbh_pins)},
+	{"pwm3", pxa320_pwm3_func, ARRAY_AND_SIZE(pxa320_pwm3_pins)},
+	{"usim", pxa320_usim_func, ARRAY_AND_SIZE(pxa320_usim_pins)},
+};
+
+static const char * const pxa320_lcd_grps[] = {"lcd"};
+static const char * const pxa320_uart0_grps[] = {"ffuart"};
+static const char * const pxa320_ac97_grps[] = {"ac97"};
+static const char * const pxa320_ssp3_grps[] = {"ssp3"};
+static const char * const pxa320_i2c_grps[] = {"i2c"};
+static const char * const pxa320_key_grps[] = {"key"};
+static const char * const pxa320_smc_grps[] = {"smc"};
+static const char * const pxa320_mmc1_grps[] = {"mmc1"};
+static const char * const pxa320_mmc2_grps[] = {"mmc2"};
+static const char * const pxa320_usbh_grps[] = {"usbh"};
+static const char * const pxa320_pwm3_grps[] = {"pwm3"};
+static const char * const pxa320_usim_grps[] = {"usim"};
+
+static struct pxa3xx_pmx_func pxa320_pmx_functions[] = {
+	{"lcd",		ARRAY_AND_SIZE(pxa320_lcd_grps)},
+	{"uart0",	ARRAY_AND_SIZE(pxa320_uart0_grps)},
+	{"ac97",	ARRAY_AND_SIZE(pxa320_ac97_grps)},
+	{"ssp3",	ARRAY_AND_SIZE(pxa320_ssp3_grps)},
+	{"i2c",		ARRAY_AND_SIZE(pxa320_i2c_grps)},
+	{"key",		ARRAY_AND_SIZE(pxa320_key_grps)},
+	{"smc",		ARRAY_AND_SIZE(pxa320_smc_grps)},
+	{"mmc1",	ARRAY_AND_SIZE(pxa320_mmc1_grps)},
+	{"mmc2",	ARRAY_AND_SIZE(pxa320_mmc2_grps)},
+	{"usbh",	ARRAY_AND_SIZE(pxa320_usbh_grps)},
+	{"pwm3",	ARRAY_AND_SIZE(pxa320_pwm3_grps)},
+	{"usim",	ARRAY_AND_SIZE(pxa320_usim_grps)},
+};
+#endif
+
+#ifdef CONFIG_ARCH_MMP
+static struct pinctrl_pin_desc pxa910_pads[] = {
+	PXA3XX_COMMON_PINS(),
+};
+
+const static unsigned pxa910_mfpr[] = {
+	0x0DC, 0x0E0, 0x0E4, 0x0E8, 0x0EC, 0x0F0, 0x0F4, 0x0F8, 0x0FC, 0x100,
+	0x104, 0x108, 0x10C, 0x110, 0x114, 0x118, 0x11C, 0x120, 0x124, 0x128,
+	0x12C, 0x130, 0x134, 0x138, 0x13C, 0x140, 0x144, 0x148, 0x14C, 0x150,
+	0x154, 0x158, 0x15C, 0x160, 0x164, 0x168, 0x16C, 0x170, 0x174, 0x178,
+	0x17C, 0x180, 0x184, 0x188, 0x18C, 0x190, 0x194, 0x198, 0x19C, 0x1A0,
+	0x1A4, 0x1A8, 0x1AC, 0x1B0, 0x1B4, 0x2F0, 0x2F4, 0x2F8, 0x2FC, 0x300,
+	0x304, 0x308, 0x30C, 0x310, 0x314, 0x318, 0x31C, 0x1B8, 0x1BC, 0x1C0,
+	0x1C4, 0x1C8, 0x1CC, 0x1D0, 0x1D4, 0x1D8, 0x1DC, 0x1E0, 0x1E4, 0x1E8,
+	0x1EC, 0x1F0, 0x1F4, 0x1F8, 0x1FC, 0x200, 0x204, 0x208, 0x20C, 0x210,
+	0x214, 0x218, 0x21C, 0x220, 0x224, 0x228, 0x22C, 0x230, 0x234, 0x0B0,
+	0x238, 0x23C, 0x240, 0x244, 0x248, 0x24C, 0x250, 0x254, 0x258, 0x25C,
+	0x298, 0x29C, 0x2A0, 0x2A4, 0x2A8, 0x2AC, 0x2B0, 0x0B4, 0x0B8, 0x0BC,
+	0x0C0, 0x32C, 0x0C8, 0x0CC, 0x0D0, 0x0D4, 0x06C, 0x070,
+};
+
+static const unsigned pxa910_uart2_pins[] = {47, 48};
+static const unsigned pxa910_uart2_func[] = {6, 6};
+
+static struct pxa3xx_pin_group pxa910_pin_groups[] = {
+	{"uart2", pxa910_uart2_func, ARRAY_AND_SIZE(pxa910_uart2_pins)},
+};
+
+static const char * const pxa910_uart2_grps[] = {"uart2"};
+
+static struct pxa3xx_pmx_func pxa910_pmx_functions[] = {
+	{"uart2",	ARRAY_AND_SIZE(pxa910_uart2_grps)},
+};
+#endif
+
+static int pxa3xx_list_groups(struct pinctrl_dev *pctrldev, unsigned selector)
+{
+	struct pxa3xx_pinmux_info *info = pinctrl_dev_get_drvdata(pctrldev);
+	if (selector > info->num_grps)
+		return -EINVAL;
+	return 0;
+}
+
+static const char *pxa3xx_get_group_name(struct pinctrl_dev *pctrldev,
+					 unsigned selector)
+{
+	struct pxa3xx_pinmux_info *info = pinctrl_dev_get_drvdata(pctrldev);
+	if (selector >= info->num_grps)
+		return NULL;
+	return info->grp[selector].name;
+}
+
+static int pxa3xx_get_group_pins(struct pinctrl_dev *pctrldev,
+				 unsigned selector,
+				 const unsigned **pins,
+				 unsigned *num_pins)
+{
+	struct pxa3xx_pinmux_info *info = pinctrl_dev_get_drvdata(pctrldev);
+	if (selector > info->num_grps)
+		return -EINVAL;
+	*pins = info->grp[selector].pins;
+	*num_pins = info->grp[selector].num_pins;
+	return 0;
+}
+
+static struct pinctrl_ops pxa3xx_pctrl_ops = {
+	.list_groups	= pxa3xx_list_groups,
+	.get_group_name	= pxa3xx_get_group_name,
+	.get_group_pins	= pxa3xx_get_group_pins,
+};
+
+static int pxa3xx_get_gpio_func(unsigned int cpuid, unsigned int gpio)
+{
+	int ret = 0;
+
+	switch (cpuid) {
+#ifdef CONFIG_ARCH_PXA
+	case PINMUX_PXA300:
+	case PINMUX_PXA310:
+		if (gpio == 50)
+			ret = 2;
+		else if (gpio == 49 || gpio == 51 || gpio == 53)
+			ret = 3;
+		break;
+	case PINMUX_PXA320:
+		if (gpio == 56 || (gpio > 58 && gpio < 63))
+			goto out;
+		break;
+#endif
+#ifdef CONFIG_ARCH_MMP
+	case PINMUX_PXA910:
+		if ((gpio > 116 && gpio < 121) || gpio == 122 || gpio == 123 ||
+			gpio == 125 || gpio == 99 || gpio == 58 || gpio == 59)
+			ret = 1;
+		break;
+#endif
+	default:
+		goto out;
+	}
+	return ret & MFPR_FUNC;
+out:
+	return -1;
+}
+
+static int pxa3xx_get_mfpr(unsigned int cpuid, unsigned int pin)
+{
+	int ret;
+	switch (cpuid) {
+#ifdef CONFIG_ARCH_PXA
+	case PINMUX_PXA300:
+		if (pin > ARRAY_SIZE(pxa300_mfpr))
+			goto out;
+		ret = pxa300_mfpr[pin];
+		break;
+	case PINMUX_PXA310:
+		if (pin > ARRAY_SIZE(pxa310_mfpr))
+			goto out;
+		ret = pxa310_mfpr[pin];
+		break;
+	case PINMUX_PXA320:
+		if (pin > ARRAY_SIZE(pxa320_mfpr))
+			goto out;
+		ret = pxa320_mfpr[pin];
+		break;
+#endif
+#ifdef CONFIG_ARCH_MMP
+	case PINMUX_PXA910:
+		if (pin > ARRAY_SIZE(pxa910_mfpr))
+			goto out;
+		ret = pxa910_mfpr[pin];
+#endif
+	default:
+		goto out;
+	}
+	return ret;
+out:
+	return -EINVAL;
+}
+
+static int pxa3xx_pmx_request_gpio(struct pinctrl_dev *pctrldev,
+			       struct pinctrl_gpio_range *range,
+			       unsigned pin)
+{
+	struct pxa3xx_pinmux_info *info = pinctrl_dev_get_drvdata(pctrldev);
+	unsigned int data;
+	int mfpr, pin_func, gpio;
+
+	/* convert pin to gpio */
+	gpio = pin - range->pin_base + range->base;
+	pin_func = pxa3xx_get_gpio_func(info->cpuid, gpio);
+	if (pin_func < 0)
+		goto out;
+	mfpr = pxa3xx_get_mfpr(info->cpuid, pin);
+	if (mfpr < 0)
+		goto out;
+
+	/* write gpio function into mfpr register */
+	data = readl_relaxed(info->virt_base + mfpr) & MFPR_FUNC_MASK;
+	data |= pin_func;
+	writel_relaxed(data, info->virt_base + mfpr);
+	return 0;
+out:
+	return -EINVAL;
+}
+
+static int pxa3xx_pmx_enable(struct pinctrl_dev *pctrldev, unsigned func,
+			     unsigned group)
+{
+	struct pxa3xx_pinmux_info *info = pinctrl_dev_get_drvdata(pctrldev);
+	struct pxa3xx_pin_group *pin_grp = &info->grp[group];
+	unsigned int data, pin_func;
+	int i, mfpr;
+
+	for (i = 0; i < pin_grp->num_pins; i++) {
+		mfpr = pxa3xx_get_mfpr(info->cpuid, pin_grp->pins[i]);
+		if (mfpr < 0) {
+			dev_err(info->dev, "error pin:%d mfpr offset:%x\n",
+				pin_grp->pins[i], mfpr);
+			goto out;
+		}
+		pin_func = pin_grp->func[i];
+		data = readl_relaxed(info->virt_base + mfpr);
+	        data &= MFPR_FUNC_MASK;
+		data |= pin_func;
+		writel_relaxed(data, info->virt_base + mfpr);
+	}
+	return 0;
+out:
+	return -EINVAL;
+}
+
+static void pxa3xx_pmx_disable(struct pinctrl_dev *pctrldev, unsigned func,
+			       unsigned group)
+{
+}
+
+static int pxa3xx_pmx_list_func(struct pinctrl_dev *pctrldev, unsigned func)
+{
+	struct pxa3xx_pinmux_info *info = pinctrl_dev_get_drvdata(pctrldev);
+	if (func > info->num_funcs)
+		return -EINVAL;
+	return 0;
+}
+
+static const char *pxa3xx_pmx_get_func_name(struct pinctrl_dev *pctrldev,
+					    unsigned func)
+{
+	struct pxa3xx_pinmux_info *info = pinctrl_dev_get_drvdata(pctrldev);
+	return info->func[func].name;
+}
+
+static int pxa3xx_pmx_get_groups(struct pinctrl_dev *pctrldev, unsigned func,
+				 const char * const **groups,
+				 unsigned * const num_groups)
+{
+	struct pxa3xx_pinmux_info *info = pinctrl_dev_get_drvdata(pctrldev);
+	*groups = info->func[func].groups;
+	*num_groups = info->func[func].num_groups;
+	return 0;
+}
+
+static struct pinmux_ops pxa3xx_pmx_ops = {
+	.list_functions		= pxa3xx_pmx_list_func,
+	.get_function_name	= pxa3xx_pmx_get_func_name,
+	.get_function_groups	= pxa3xx_pmx_get_groups,
+	.enable			= pxa3xx_pmx_enable,
+	.disable		= pxa3xx_pmx_disable,
+	.gpio_request_enable	= pxa3xx_pmx_request_gpio,
+};
+
+#ifdef CONFIG_ARCH_PXA
+static struct pinctrl_desc pxa300_pctrl_desc = {
+	.name		= "pxa300-pinctrl",
+	.pins		= pxa300_pads,
+	.npins		= ARRAY_SIZE(pxa300_pads),
+	.maxpin		= 260,
+	.pctlops	= &pxa3xx_pctrl_ops,
+	.pmxops		= &pxa3xx_pmx_ops,
+	.owner		= THIS_MODULE,
+};
+
+static struct pinctrl_desc pxa310_pctrl_desc = {
+	.name		= "pxa310-pinctrl",
+	.pins		= pxa310_pads,
+	.npins		= ARRAY_SIZE(pxa310_pads),
+	.maxpin		= 260,
+	.pctlops	= &pxa3xx_pctrl_ops,
+	.pmxops		= &pxa3xx_pmx_ops,
+	.owner		= THIS_MODULE,
+};
+
+static struct pinctrl_desc pxa320_pctrl_desc = {
+	.name		= "pxa320-pinctrl",
+	.pins		= pxa320_pads,
+	.npins		= ARRAY_SIZE(pxa320_pads),
+	.maxpin		= 260,
+	.pctlops	= &pxa3xx_pctrl_ops,
+	.pmxops		= &pxa3xx_pmx_ops,
+	.owner		= THIS_MODULE,
+};
+
+static struct pinctrl_gpio_range pxa300_gpio_ranges[] = {
+	{
+		.name		= "gpio",
+		.id		= 0,
+		.base		= 0,
+		.pin_base	= 0,
+		.npins		= 128,
+	}, {
+		.name		= "gpio",
+		.id		= 1,
+		.base		= 0,
+		.pin_base	= 128,
+		.npins		= 7,
+	},
+};
+
+static struct pinctrl_gpio_range pxa310_gpio_ranges[] = {
+	{
+		.name		= "gpio",
+		.id		= 0,
+		.base		= 0,
+		.pin_base	= 0,
+		.npins		= 128,
+	}, {
+		.name		= "gpio",
+		.id		= 1,
+		.base		= 0,
+		.pin_base	= 128,
+		.npins		= 11,
+	},
+};
+
+static struct pinctrl_gpio_range pxa320_gpio_ranges[] = {
+	{
+		.name		= "gpio",
+		.id		= 0,
+		.base		= 0,
+		.pin_base	= 0,
+		.npins		= 128,
+	}, {
+		.name		= "gpio",
+		.id		= 1,
+		.base		= 0,
+		.pin_base	= 128,
+		.npins		= 18,
+	},
+};
+#endif
+
+#ifdef CONFIG_ARCH_MMP
+static struct pinctrl_desc pxa910_pctrl_desc = {
+	.name		= "pxa910-pinctrl",
+	.pins		= pxa910_pads,
+	.npins		= ARRAY_SIZE(pxa910_pads),
+	.maxpin		= 260,
+	.pctlops	= &pxa3xx_pctrl_ops,
+	.pmxops		= &pxa3xx_pmx_ops,
+	.owner		= THIS_MODULE,
+};
+
+static struct pinctrl_gpio_range pxa910_gpio_ranges[] = {
+	{
+		.name		= "gpio",
+		.id		= 0,
+		.base		= 0,
+		.pin_base	= 0,
+		.npins		= 128,
+	},
+};
+#endif
+
+static int __devinit pxa3xx_pinmux_probe(struct platform_device *pdev)
+{
+	struct pxa3xx_pinmux_info *info;
+	struct pinctrl_gpio_range *range = NULL;
+	struct resource *res;
+	int ret, i, range_num;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		return -ENOENT;
+	}
+	info = devm_kzalloc(&pdev->dev, sizeof(struct pxa3xx_pinmux_info),
+			GFP_KERNEL);
+	if (!info) {
+		return -ENOMEM;
+	}
+	info->phy_base = res->start;
+	info->phy_size = resource_size(res);
+	info->virt_base = ioremap(info->phy_base, info->phy_size);
+	if (!info->virt_base) {
+		ret = -ENOMEM;
+		goto out_remap;
+	}
+#ifdef CONFIG_ARCH_PXA
+	if (cpu_is_pxa300()) {
+		info->cpuid = PINMUX_PXA300;
+		info->grp = pxa300_pin_groups;
+		info->func = pxa300_pmx_functions;
+		info->num_grps = ARRAY_SIZE(pxa300_pin_groups);
+		info->num_funcs = ARRAY_SIZE(pxa300_pmx_functions);
+		info->pctl = pinctrl_register(&pxa300_pctrl_desc, &pdev->dev,
+				info);
+		range = pxa300_gpio_ranges;
+		range_num = ARRAY_SIZE(pxa300_gpio_ranges);
+	} else if (cpu_is_pxa310()) {
+		info->cpuid = PINMUX_PXA310;
+		info->grp = pxa310_pin_groups;
+		info->func = pxa310_pmx_functions;
+		info->num_grps = ARRAY_SIZE(pxa310_pin_groups);
+		info->num_funcs = ARRAY_SIZE(pxa310_pmx_functions);
+		info->pctl = pinctrl_register(&pxa310_pctrl_desc, &pdev->dev,
+				info);
+		range = pxa310_gpio_ranges;
+		range_num = ARRAY_SIZE(pxa310_gpio_ranges);
+	} else if (cpu_is_pxa320()) {
+		info->cpuid = PINMUX_PXA320;
+		info->grp = pxa320_pin_groups;
+		info->func = pxa320_pmx_functions;
+		info->num_grps = ARRAY_SIZE(pxa320_pin_groups);
+		info->num_funcs = ARRAY_SIZE(pxa320_pmx_functions);
+		info->pctl = pinctrl_register(&pxa320_pctrl_desc, &pdev->dev,
+				info);
+		range = pxa320_gpio_ranges;
+		range_num = ARRAY_SIZE(pxa320_gpio_ranges);
+	}
+#endif
+#ifdef CONFIG_ARCH_MMP
+	if (cpu_is_pxa910()) {
+		info->cpuid = PINMUX_PXA910;
+		info->grp = pxa910_pin_groups;
+		info->func = pxa910_pmx_functions;
+		info->num_grps = ARRAY_SIZE(pxa910_pin_groups);
+		info->num_funcs = ARRAY_SIZE(pxa910_pmx_functions);
+		info->pctl = pinctrl_register(&pxa910_pctrl_desc, &pdev->dev,
+				info);
+		range = pxa910_gpio_ranges;
+		range_num = ARRAY_SIZE(pxa910_gpio_ranges);
+	}
+#endif
+	if (!info->pctl) {
+		dev_err(&pdev->dev, "failed to register PXA pinmux driver\n");
+		ret = -EINVAL;
+		goto out_pctrl;
+	}
+	for (i = 0; i < range_num; i++)
+		pinctrl_add_gpio_range(info->pctl, &range[0]);
+	platform_set_drvdata(pdev, info);
+	return 0;
+out_pctrl:
+	release_mem_region(info->phy_base, info->phy_size);
+out_remap:
+	devm_kfree(&pdev->dev, info);
+	return ret;
+}
+
+static int __devexit pxa3xx_pinmux_remove(struct platform_device *pdev)
+{
+	struct pxa3xx_pinmux_info *info = platform_get_drvdata(pdev);
+
+	pinctrl_unregister(info->pctl);
+	iounmap(info->virt_base);
+	platform_set_drvdata(pdev, NULL);
+	devm_kfree(&pdev->dev, info);
+	return 0;
+}
+
+static struct platform_driver pxa3xx_pinmux_driver = {
+	.driver = {
+		.name = "pxa3xx-pinmux",
+		.owner = THIS_MODULE,
+	},
+	.probe = pxa3xx_pinmux_probe,
+	.remove = __devexit_p(pxa3xx_pinmux_remove),
+};
+
+static int __init pxa3xx_pinmux_init(void)
+{
+	return platform_driver_register(&pxa3xx_pinmux_driver);
+}
+postcore_initcall(pxa3xx_pinmux_init);
+
+static void __exit pxa3xx_pinmux_exit(void)
+{
+	platform_driver_unregister(&pxa3xx_pinmux_driver);
+}
+module_exit(pxa3xx_pinmux_exit);
+
+MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
+MODULE_DESCRIPTION("PXA pin control driver");
+MODULE_LICENSE("GPL");
-- 
1.7.0.4
