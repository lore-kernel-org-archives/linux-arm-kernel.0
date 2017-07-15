From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 15 Jul 2017 19:50:53 +0200
Subject: [PATCH 2/5] pinctrl: add a Gemini SoC pin controller
In-Reply-To: <20170715175056.13040-1-linus.walleij@linaro.org>
References: <20170715175056.13040-1-linus.walleij@linaro.org>
Message-ID: <20170715175056.13040-2-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a pin control (only multiplexing) driver for the Gemini
SoC so we can sort out this complex platform in an orderly manner.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/Kconfig          |    7 +
 drivers/pinctrl/Makefile         |    1 +
 drivers/pinctrl/pinctrl-gemini.c | 1457 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 1465 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-gemini.c

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index e14b46c7b37f..b219cf6df0bb 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -146,6 +146,13 @@ config PINCTRL_FALCON
 	depends on SOC_FALCON
 	depends on PINCTRL_LANTIQ
 
+config PINCTRL_GEMINI
+	bool
+	depends on ARCH_GEMINI
+	default ARCH_GEMINI
+	select PINMUX
+	select MFD_SYSCON
+
 config PINCTRL_MCP23S08
 	tristate "Microchip MCP23xxx I/O expander"
 	depends on SPI_MASTER || I2C
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 2bc641d62400..6b8c6e55ab55 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_PINCTRL_AMD)	+= pinctrl-amd.o
 obj-$(CONFIG_PINCTRL_DA850_PUPD) += pinctrl-da850-pupd.o
 obj-$(CONFIG_PINCTRL_DIGICOLOR)	+= pinctrl-digicolor.o
 obj-$(CONFIG_PINCTRL_FALCON)	+= pinctrl-falcon.o
+obj-$(CONFIG_PINCTRL_GEMINI)	+= pinctrl-gemini.o
 obj-$(CONFIG_PINCTRL_MAX77620)	+= pinctrl-max77620.o
 obj-$(CONFIG_PINCTRL_MCP23S08)	+= pinctrl-mcp23s08.o
 obj-$(CONFIG_PINCTRL_MESON)	+= meson/
diff --git a/drivers/pinctrl/pinctrl-gemini.c b/drivers/pinctrl/pinctrl-gemini.c
new file mode 100644
index 000000000000..295450b67dd5
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-gemini.c
@@ -0,0 +1,1457 @@
+/*
+ * Driver for the Gemini pin controller
+ *
+ * Copyright (C) 2017 Linus Walleij <linus.walleij@linaro.org>
+ *
+ * This is a group-only pin controller.
+ */
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/regmap.h>
+
+#include "pinctrl-utils.h"
+
+#define DRIVER_NAME "pinctrl-gemini"
+
+/*
+ * Global Miscellaneous Control Register
+ * This register controls all Gemini pad/pin multiplexing
+ *
+ * It is a tricky register though:
+ * - For the bits named *_ENABLE, once you DISABLE something, it simply cannot
+ *   be brought back online, so it means permanent disablement of the
+ *   corresponding pads.
+ * - For the bits named *_DISABLE, once you enable something, it cannot be
+ *   DISABLED again. So you select a flash configuration once, and then
+ *   you are stuck with it.
+ */
+#define GLOBAL_STATUS		0x04
+#define GLOBAL_STATUS_FLPIN	BIT(20)
+#define GLOBAL_MISC_CTRL	0x30
+#define TVC_CLK_PAD_ENABLE	BIT(20)
+#define PCI_CLK_PAD_ENABLE	BIT(17)
+#define LPC_CLK_PAD_ENABLE	BIT(16)
+#define TVC_PADS_ENABLE		BIT(9)
+#define SSP_PADS_ENABLE		BIT(8)
+#define LCD_PADS_ENABLE		BIT(7)
+#define LPC_PADS_ENABLE		BIT(6)
+#define PCI_PADS_ENABLE		BIT(5)
+#define IDE_PADS_ENABLE		BIT(4)
+#define DRAM_PADS_POWERDOWN	BIT(3)
+#define NAND_PADS_DISABLE	BIT(2)
+#define PFLASH_PADS_DISABLE	BIT(1)
+#define SFLASH_PADS_DISABLE	BIT(0)
+#define PADS_MASK		(GENMASK(9, 0) | BIT(16) | BIT(17) | BIT(20))
+#define PADS_MAXBIT		20
+
+/* Ordered by bit index */
+static const char * const gemini_padgroups[] = {
+	"serial flash",
+	"parallel flash",
+	"NAND flash",
+	"DRAM",
+	"IDE",
+	"PCI",
+	"LPC",
+	"LCD",
+	"SSP",
+	"TVC",
+	NULL, NULL, NULL, NULL, NULL, NULL,
+	"LPC CLK",
+	"PCI CLK",
+	NULL, NULL,
+	"TVC CLK",
+};
+
+/* Pin names for the pinmux subsystem */
+static const struct pinctrl_pin_desc gemini_pins[] = {
+	/* Row A */
+	PINCTRL_PIN(0, "A1 AVCC3IOHA"),
+	PINCTRL_PIN(1, "A2 DRAM CK N"),
+	PINCTRL_PIN(2, "A3 DRAM CK"),
+	PINCTRL_PIN(3, "A4 DRAM DQM1"),
+	PINCTRL_PIN(4, "A5 DRAM DQ9"),
+	PINCTRL_PIN(5, "A6 DRAM DQ13"),
+	PINCTRL_PIN(6, "A7 DRAM DQ1"),
+	PINCTRL_PIN(7, "A8 DRAM DQ2"),
+	PINCTRL_PIN(8, "A9 DRAM DQ4"),
+	PINCTRL_PIN(9, "A10 DRAM VREF"),
+	PINCTRL_PIN(10, "A11 DRAM DQ24"),
+	PINCTRL_PIN(11, "A12 DRAM DQ28"),
+	PINCTRL_PIN(12, "A13 DRAM DQ30"),
+	PINCTRL_PIN(13, "A14 DRAM DQ18"),
+	PINCTRL_PIN(14, "A15 DRAM DQ21"),
+	PINCTRL_PIN(15, "A16 DRAM CAS_N"),
+	PINCTRL_PIN(16, "A17 DRAM BA1"),
+	PINCTRL_PIN(17, "A18 PCI INTA N"),
+	PINCTRL_PIN(18, "A19 PCI INTB N"),
+	PINCTRL_PIN(19, "A20 PCI INTC N"),
+	/* Row B */
+	PINCTRL_PIN(20, "B1 PWR EN"),
+	PINCTRL_PIN(21, "B2 GND"),
+	PINCTRL_PIN(22, "B3 RTC CLKO"),
+	PINCTRL_PIN(23, "B4 DRAM A5"),
+	PINCTRL_PIN(24, "B5 DRAM A6"),
+	PINCTRL_PIN(25, "B6 DRAM DQS1"),
+	PINCTRL_PIN(26, "B7 DRAM DQ11"),
+	PINCTRL_PIN(27, "B8 DRAM DQ0"),
+	PINCTRL_PIN(28, "B9 DRAM DQS0"),
+	PINCTRL_PIN(29, "B10 DRAM DQ7"),
+	PINCTRL_PIN(30, "B11 DRAM DQS3"),
+	PINCTRL_PIN(31, "B12 DRAM DQ27"),
+	PINCTRL_PIN(32, "B13 DRAM DQ31"),
+	PINCTRL_PIN(33, "B14 DRAM DQ20"),
+	PINCTRL_PIN(34, "B15 DRAM DQS2"),
+	PINCTRL_PIN(35, "B16 DRAM WE N"),
+	PINCTRL_PIN(36, "B17 DRAM A10"),
+	PINCTRL_PIN(37, "B18 DRAM A2"),
+	PINCTRL_PIN(38, "B19 GND"),
+	PINCTRL_PIN(39, "B20 PCI GNT0 N"),
+	/* Row C */
+	PINCTRL_PIN(40, "C1 AGNDIOHA"),
+	PINCTRL_PIN(41, "C2 XTALI"),
+	PINCTRL_PIN(42, "C3 GND"),
+	PINCTRL_PIN(43, "C4 RTC CLKI"),
+	PINCTRL_PIN(44, "C5 DRAM A12"),
+	PINCTRL_PIN(45, "C6 DRAM A11"),
+	PINCTRL_PIN(46, "C7 DRAM DQ8"),
+	PINCTRL_PIN(47, "C8 DRAM DQ10"),
+	PINCTRL_PIN(48, "C9 DRAM DQ3"),
+	PINCTRL_PIN(49, "C10 DRAM DQ6"),
+	PINCTRL_PIN(50, "C11 DRAM DQM0"),
+	PINCTRL_PIN(51, "C12 DRAM DQ26"),
+	PINCTRL_PIN(52, "C13 DRAM DQ16"),
+	PINCTRL_PIN(53, "C14 DRAM DQ22"),
+	PINCTRL_PIN(54, "C15 DRAM DQM2"),
+	PINCTRL_PIN(55, "C16 DRAM BA0"),
+	PINCTRL_PIN(56, "C17 DRAM A3"),
+	PINCTRL_PIN(57, "C18 GND"),
+	PINCTRL_PIN(58, "C19 PCI GNT1 N"),
+	PINCTRL_PIN(59, "C20 PCI REQ2 N"),
+	/* Row D */
+	PINCTRL_PIN(60, "D1 AVCC3IOAHA"),
+	PINCTRL_PIN(61, "D2 AVCCKHA"),
+	PINCTRL_PIN(62, "D3 XTALO"),
+	PINCTRL_PIN(63, "D4 GND"),
+	PINCTRL_PIN(64, "D5 CIR RXD"),
+	PINCTRL_PIN(65, "D6 DRAM A7"),
+	PINCTRL_PIN(66, "D7 DRAM A4"),
+	PINCTRL_PIN(67, "D8 DRAM A8"),
+	PINCTRL_PIN(68, "D9 DRAM CKE"),
+	PINCTRL_PIN(69, "D10 DRAM DQ14"),
+	PINCTRL_PIN(70, "D11 DRAM DQ5"),
+	PINCTRL_PIN(71, "D12 DRAM DQ25"),
+	PINCTRL_PIN(72, "D13 DRAM DQ17"),
+	PINCTRL_PIN(73, "D14 DRAM DQ23"),
+	PINCTRL_PIN(74, "D15 DRAM RAS N"),
+	PINCTRL_PIN(75, "D16 DRAM A1"),
+	PINCTRL_PIN(76, "D17 GND"),
+	PINCTRL_PIN(77, "D18 EXT RESET N"),
+	PINCTRL_PIN(78, "D19 PCI REQ1 N"),
+	PINCTRL_PIN(79, "D20 PCI REQ3 N"),
+	/* Row E */
+	PINCTRL_PIN(80, "E1 VCC2IO CTRL"),
+	PINCTRL_PIN(81, "E2 VREF CTRL"),
+	PINCTRL_PIN(82, "E3 CIR RST N"),
+	PINCTRL_PIN(83, "E4 PWR BTN"),
+	PINCTRL_PIN(84, "E5 GND"),
+	PINCTRL_PIN(85, "E6 CIR TXD"),
+	PINCTRL_PIN(86, "E7 VCCK CTRL"),
+	PINCTRL_PIN(87, "E8 DRAM A9"),
+	PINCTRL_PIN(88, "E9 DRAM DQ12"),
+	PINCTRL_PIN(89, "E10 DRAM DQ15"),
+	PINCTRL_PIN(90, "E11 DRAM DQM3"),
+	PINCTRL_PIN(91, "E12 DRAM DQ29"),
+	PINCTRL_PIN(92, "E13 DRAM DQ19"),
+	PINCTRL_PIN(93, "E14 DRAM A13"),
+	PINCTRL_PIN(94, "E15 DRAM A0"),
+	PINCTRL_PIN(95, "E16 GND"),
+	PINCTRL_PIN(96, "E17 PCI INTD N"),
+	PINCTRL_PIN(97, "E18 PCI GNT3 N"),
+	PINCTRL_PIN(98, "E19 PCI AD29"),
+	PINCTRL_PIN(99, "E20 PCI AD28"),
+	/* Row F */
+	PINCTRL_PIN(100, "F1 AVCCKHB"),
+	PINCTRL_PIN(101, "F2 AVCCK P"),
+	PINCTRL_PIN(102, "F3 EBG"),
+	PINCTRL_PIN(103, "F4 REXT"),
+	PINCTRL_PIN(104, "F5 AVCC3IOHB"),
+	PINCTRL_PIN(105, "F6 GND"),
+	PINCTRL_PIN(106, "F7 VCC2IOHA 2"),
+	PINCTRL_PIN(107, "F8 VCC2IOHA 2"),
+	PINCTRL_PIN(108, "F9 VCC2IOHA 2"),
+	PINCTRL_PIN(109, "F10 V1"),
+	PINCTRL_PIN(110, "F11 V1"),
+	PINCTRL_PIN(111, "F12 VCC2IOHA 2"),
+	PINCTRL_PIN(112, "F13 VCC2IOHA 2"),
+	PINCTRL_PIN(113, "F14 VCC2IOHA 2"),
+	PINCTRL_PIN(114, "F15 GND"),
+	PINCTRL_PIN(115, "F16 PCI CLK"),
+	PINCTRL_PIN(116, "F17 PCI GNT2 N"),
+	PINCTRL_PIN(117, "F18 PCI AD31"),
+	PINCTRL_PIN(118, "F19 PCI AD26"),
+	PINCTRL_PIN(119, "F20 PCI CBE3 N"),
+	/* Row G */
+	PINCTRL_PIN(120, "G1 SATA0 RXDP"),
+	PINCTRL_PIN(121, "G2 SATA0 RXDN"),
+	PINCTRL_PIN(122, "G3 AGNDK 0"),
+	PINCTRL_PIN(123, "G4 AVCCK S"),
+	PINCTRL_PIN(124, "G5 AVCC3 S"),
+	PINCTRL_PIN(125, "G6 VCC2IOHA 2"),
+	PINCTRL_PIN(126, "G7 GND"),
+	PINCTRL_PIN(127, "G8 VCC2IOHA 2"),
+	PINCTRL_PIN(128, "G9 V1"),
+	PINCTRL_PIN(129, "G10 V1"),
+	PINCTRL_PIN(130, "G11 V1"),
+	PINCTRL_PIN(131, "G12 V1"),
+	PINCTRL_PIN(132, "G13 VCC2IOHA 2"),
+	PINCTRL_PIN(133, "G14 GND"),
+	PINCTRL_PIN(134, "G15 VCC3IOHA"),
+	PINCTRL_PIN(135, "G16 PCI REQ0 N"),
+	PINCTRL_PIN(136, "G17 PCI AD30"),
+	PINCTRL_PIN(137, "G18 PCI AD24"),
+	PINCTRL_PIN(138, "G19 PCI AD23"),
+	PINCTRL_PIN(139, "G20 PCI AD21"),
+	/* Row H */
+	PINCTRL_PIN(140, "H1 SATA0 TXDP"),
+	PINCTRL_PIN(141, "H2 SATA0 TXDN"),
+	PINCTRL_PIN(142, "H3 AGNDK 1"),
+	PINCTRL_PIN(143, "H4 AVCCK 0"),
+	PINCTRL_PIN(144, "H5 TEST CLKOUT"),
+	PINCTRL_PIN(145, "H6 AGND"),
+	PINCTRL_PIN(146, "H7 VCC2IOHA 2"),
+	PINCTRL_PIN(147, "H8 GND"),
+	PINCTRL_PIN(148, "H9 GND"),
+	PINCTRL_PIN(149, "H10 GDN"),
+	PINCTRL_PIN(150, "H11 GND"),
+	PINCTRL_PIN(151, "H12 GND"),
+	PINCTRL_PIN(152, "H13 GND"),
+	PINCTRL_PIN(153, "H14 VCC3IOHA"),
+	PINCTRL_PIN(154, "H15 VCC3IOHA"),
+	PINCTRL_PIN(155, "H16 PCI AD27"),
+	PINCTRL_PIN(156, "H17 PCI AD25"),
+	PINCTRL_PIN(157, "H18 PCI AD22"),
+	PINCTRL_PIN(158, "H19 PCI AD18"),
+	PINCTRL_PIN(159, "H20 PCI AD17"),
+	/* Row J (for some reason I is skipped) */
+	PINCTRL_PIN(160, "J1 SATA1 TXDP"),
+	PINCTRL_PIN(161, "J2 SATA1 TXDN"),
+	PINCTRL_PIN(162, "J3 AGNDK 2"),
+	PINCTRL_PIN(163, "J4 AVCCK 1"),
+	PINCTRL_PIN(164, "J5 AGND"),
+	PINCTRL_PIN(165, "J6 AGND"),
+	PINCTRL_PIN(166, "J7 V1"),
+	PINCTRL_PIN(167, "J8 GND"),
+	PINCTRL_PIN(168, "J9 GND"),
+	PINCTRL_PIN(169, "J10 GND"),
+	PINCTRL_PIN(170, "J11 GND"),
+	PINCTRL_PIN(171, "J12 GND"),
+	PINCTRL_PIN(172, "J13 GND"),
+	PINCTRL_PIN(173, "J14 V1"),
+	PINCTRL_PIN(174, "J15 VCC3IOHA"),
+	PINCTRL_PIN(175, "J16 PCI AD19"),
+	PINCTRL_PIN(176, "J17 PCI AD20"),
+	PINCTRL_PIN(177, "J18 PCI AD16"),
+	PINCTRL_PIN(178, "J19 PCI CBE2 N"),
+	PINCTRL_PIN(179, "J20 PCI FRAME N"),
+	/* Row K */
+	PINCTRL_PIN(180, "K1 SATA1 RXDP"),
+	PINCTRL_PIN(181, "K2 SATA1 RXDN"),
+	PINCTRL_PIN(182, "K3 AGNDK 3"),
+	PINCTRL_PIN(183, "K4 AVCCK 2"),
+	PINCTRL_PIN(184, "K5 AGND"),
+	PINCTRL_PIN(185, "K6 V1"),
+	PINCTRL_PIN(186, "K7 V1"),
+	PINCTRL_PIN(187, "K8 GND"),
+	PINCTRL_PIN(188, "K9 GND"),
+	PINCTRL_PIN(189, "K10 GND"),
+	PINCTRL_PIN(190, "K11 GND"),
+	PINCTRL_PIN(191, "K12 GND"),
+	PINCTRL_PIN(192, "K13 GND"),
+	PINCTRL_PIN(193, "K14 V1"),
+	PINCTRL_PIN(194, "K15 V1"),
+	PINCTRL_PIN(195, "K16 PCI TRDY N"),
+	PINCTRL_PIN(196, "K17 PCI IRDY N"),
+	PINCTRL_PIN(197, "K18 PCI DEVSEL N"),
+	PINCTRL_PIN(198, "K19 PCI STOP N"),
+	PINCTRL_PIN(199, "K20 PCI PAR"),
+	/* Row L */
+	PINCTRL_PIN(200, "L1 IDE CS0 N"),
+	PINCTRL_PIN(201, "L2 IDE DA0"),
+	PINCTRL_PIN(202, "L3 AVCCK 3"),
+	PINCTRL_PIN(203, "L4 AGND"),
+	PINCTRL_PIN(204, "L5 IDE DIOR N"),
+	PINCTRL_PIN(205, "L6 V1"),
+	PINCTRL_PIN(206, "L7 V1"),
+	PINCTRL_PIN(207, "L8 GND"),
+	PINCTRL_PIN(208, "L9 GND"),
+	PINCTRL_PIN(209, "L10 GND"),
+	PINCTRL_PIN(210, "L11 GND"),
+	PINCTRL_PIN(211, "L12 GND"),
+	PINCTRL_PIN(212, "L13 GND"),
+	PINCTRL_PIN(213, "L14 V1"),
+	PINCTRL_PIN(214, "L15 V1"),
+	PINCTRL_PIN(215, "L16 PCI AD12"),
+	PINCTRL_PIN(216, "L17 PCI AD13"),
+	PINCTRL_PIN(217, "L18 PCI AD14"),
+	PINCTRL_PIN(218, "L19 PCI AD15"),
+	PINCTRL_PIN(219, "L20 PCI CBE1 N"),
+	/* Row M */
+	PINCTRL_PIN(220, "M1 IDE DA1"),
+	PINCTRL_PIN(221, "M2 IDE CS1 N"),
+	PINCTRL_PIN(222, "M3 IDE DA2"),
+	PINCTRL_PIN(223, "M4 IDE DMACK N"),
+	PINCTRL_PIN(224, "M5 IDE DD1"),
+	PINCTRL_PIN(225, "M6 VCC3IOHA"),
+	PINCTRL_PIN(226, "M7 V1"),
+	PINCTRL_PIN(227, "M8 GND"),
+	PINCTRL_PIN(228, "M9 GND"),
+	PINCTRL_PIN(229, "M10 GND"),
+	PINCTRL_PIN(230, "M11 GND"),
+	PINCTRL_PIN(231, "M12 GND"),
+	PINCTRL_PIN(232, "M13 GND"),
+	PINCTRL_PIN(233, "M14 V1"),
+	PINCTRL_PIN(234, "M15 VCC3IOHA"),
+	PINCTRL_PIN(235, "M16 PCI AD7"),
+	PINCTRL_PIN(236, "M17 PCI AD6"),
+	PINCTRL_PIN(237, "M18 PCI AD9"),
+	PINCTRL_PIN(238, "M19 PCI AD10"),
+	PINCTRL_PIN(239, "M20 PCI AD11"),
+	/* Row N */
+	PINCTRL_PIN(240, "N1 IDE IORDY"),
+	PINCTRL_PIN(241, "N2 IDE INTRQ"),
+	PINCTRL_PIN(242, "N3 IDE DIOW N"),
+	PINCTRL_PIN(243, "N4 IDE DD15"),
+	PINCTRL_PIN(244, "N5 IDE DMARQ"),
+	PINCTRL_PIN(245, "N6 VCC3IOHA"),
+	PINCTRL_PIN(246, "N7 VCC3IOHA"),
+	PINCTRL_PIN(247, "N8 GND"),
+	PINCTRL_PIN(248, "N9 GND"),
+	PINCTRL_PIN(249, "N10 GND"),
+	PINCTRL_PIN(250, "N11 GND"),
+	PINCTRL_PIN(251, "N12 GND"),
+	PINCTRL_PIN(252, "N13 GND"),
+	PINCTRL_PIN(253, "N14 VCC3IOHA"),
+	PINCTRL_PIN(254, "N15 VCC3IOHA"),
+	PINCTRL_PIN(255, "N16 PCI CLKRUN N"),
+	PINCTRL_PIN(256, "N17 PCI AD0"),
+	PINCTRL_PIN(257, "N18 PCI AD4"),
+	PINCTRL_PIN(258, "N19 PCI CBE0 N"),
+	PINCTRL_PIN(259, "N20 PCI AD8"),
+	/* Row P (for some reason O is skipped) */
+	PINCTRL_PIN(260, "P1 IDE DD0"),
+	PINCTRL_PIN(261, "P2 IDE DD14"),
+	PINCTRL_PIN(262, "P3 IDE DD2"),
+	PINCTRL_PIN(263, "P4 IDE DD4"),
+	PINCTRL_PIN(264, "P5 IDE DD3"),
+	PINCTRL_PIN(265, "P6 VCC3IOHA"),
+	PINCTRL_PIN(266, "P7 GND"),
+	PINCTRL_PIN(267, "P8 VCC2IOHA 1"),
+	PINCTRL_PIN(268, "P9 V1"),
+	PINCTRL_PIN(269, "P10 V1"),
+	PINCTRL_PIN(270, "P11 V1"),
+	PINCTRL_PIN(271, "P12 V1"),
+	PINCTRL_PIN(272, "P13 VCC3IOHA"),
+	PINCTRL_PIN(273, "P14 GND"),
+	PINCTRL_PIN(274, "P15 VCC3IOHA"),
+	PINCTRL_PIN(275, "P16 GPIO0 30"),
+	PINCTRL_PIN(276, "P17 GPIO0 28"),
+	PINCTRL_PIN(277, "P18 PCI AD1"),
+	PINCTRL_PIN(278, "P19 PCI AD3"),
+	PINCTRL_PIN(279, "P20 PCI AD5"),
+	/* Row R (for some reason Q us skipped) */
+	PINCTRL_PIN(280, "R1 IDE DD13"),
+	PINCTRL_PIN(281, "R2 IDE DD12"),
+	PINCTRL_PIN(282, "R3 IDE DD10"),
+	PINCTRL_PIN(283, "R4 IDE DD6"),
+	PINCTRL_PIN(284, "R5 ICE0 IDI"),
+	PINCTRL_PIN(285, "R6 GND"),
+	PINCTRL_PIN(286, "R7 VCC2IOHA 1"),
+	PINCTRL_PIN(287, "R8 VCC2IOHA 1"),
+	PINCTRL_PIN(288, "R9 VCC2IOHA 1"),
+	PINCTRL_PIN(289, "R10 V1"),
+	PINCTRL_PIN(290, "R11 V1"),
+	PINCTRL_PIN(291, "R12 VCC3IOHA"),
+	PINCTRL_PIN(292, "R13 VCC3IOHA"),
+	PINCTRL_PIN(293, "R14 VCC3IOHA"),
+	PINCTRL_PIN(294, "R15 GND"),
+	PINCTRL_PIN(295, "R16 GPIO0 23"),
+	PINCTRL_PIN(296, "R17 GPIO0 21"),
+	PINCTRL_PIN(297, "R18 GPIO0 26"),
+	PINCTRL_PIN(298, "R19 GPIO0 31"),
+	PINCTRL_PIN(299, "R20 PCI AD2"),
+	/* Row T (for some reason S is skipped) */
+	PINCTRL_PIN(300, "T1 IDE DD11"),
+	PINCTRL_PIN(301, "T2 IDE DD5"),
+	PINCTRL_PIN(302, "T3 IDE DD8"),
+	PINCTRL_PIN(303, "T4 ICE0 IDO"),
+	PINCTRL_PIN(304, "T5 GND"),
+	PINCTRL_PIN(305, "T6 USB GNDA U20"),
+	PINCTRL_PIN(306, "T7 GMAC0 TXD0"),
+	PINCTRL_PIN(307, "T8 GMAC0 TXEN"),
+	PINCTRL_PIN(308, "T9 GMAC1 TXD3"),
+	PINCTRL_PIN(309, "T10 GMAC1 RXDV"),
+	PINCTRL_PIN(310, "T11 GMAC1 RXD2"),
+	PINCTRL_PIN(311, "T12 GPIO1 29"),
+	PINCTRL_PIN(312, "T13 GPIO0 3"),
+	PINCTRL_PIN(313, "T14 GPIO0 9"),
+	PINCTRL_PIN(314, "T15 GPIO0 16"),
+	PINCTRL_PIN(315, "T16 GND"),
+	PINCTRL_PIN(316, "T17 GPIO0 14"),
+	PINCTRL_PIN(317, "T18 GPIO0 19"),
+	PINCTRL_PIN(318, "T19 GPIO0 27"),
+	PINCTRL_PIN(319, "T20 GPIO0 29"),
+	/* Row U */
+	PINCTRL_PIN(320, "U1 IDE DD9"),
+	PINCTRL_PIN(321, "U2 IDE DD7"),
+	PINCTRL_PIN(322, "U3 ICE0 ICK"),
+	PINCTRL_PIN(323, "U4 GND"),
+	PINCTRL_PIN(324, "U5 USB XSCO"),
+	PINCTRL_PIN(325, "U6 GMAC0 TXD1"),
+	PINCTRL_PIN(326, "U7 GMAC0 TXD3"),
+	PINCTRL_PIN(327, "U8 GMAC0 TXC"),
+	PINCTRL_PIN(328, "U9 GMAC0 RXD3"),
+	PINCTRL_PIN(329, "U10 GMAC1 TXD0"),
+	PINCTRL_PIN(330, "U11 GMAC1 CRS"),
+	PINCTRL_PIN(331, "U12 EXT CLK"),
+	PINCTRL_PIN(332, "U13 DEV DEF"),
+	PINCTRL_PIN(333, "U14 GPIO0 0"),
+	PINCTRL_PIN(334, "U15 GPIO0 4"),
+	PINCTRL_PIN(335, "U16 GPIO0 10"),
+	PINCTRL_PIN(336, "U17 GND"),
+	PINCTRL_PIN(337, "U18 GPIO0 17"),
+	PINCTRL_PIN(338, "U19 GPIO0 22"),
+	PINCTRL_PIN(339, "U20 GPIO0 25"),
+	/* Row V */
+	PINCTRL_PIN(340, "V1 ICE0 DBGACK"),
+	PINCTRL_PIN(341, "V2 ICE0 DBGRQ"),
+	PINCTRL_PIN(342, "V3 GND"),
+	PINCTRL_PIN(343, "V4 ICE0 IRST N"),
+	PINCTRL_PIN(344, "V5 USB XSCI"),
+	PINCTRL_PIN(345, "V6 GMAC0 COL"),
+	PINCTRL_PIN(346, "V7 GMAC0 TXD2"),
+	PINCTRL_PIN(347, "V8 GMAC0 RXDV"),
+	PINCTRL_PIN(348, "V9 GMAC0 RXD1"),
+	PINCTRL_PIN(349, "V10 GMAC1 COL"),
+	PINCTRL_PIN(350, "V11 GMAC1 TXC"),
+	PINCTRL_PIN(351, "V12 GMAC1 RXD1"),
+	PINCTRL_PIN(352, "V13 MODE SEL1"),
+	PINCTRL_PIN(353, "V14 GPIO1 28"),
+	PINCTRL_PIN(354, "V15 GPIO0 1"),
+	PINCTRL_PIN(355, "V16 GPIO0 8"),
+	PINCTRL_PIN(356, "V17 GPIO0 11"),
+	PINCTRL_PIN(357, "V18 GND"),
+	PINCTRL_PIN(358, "V19 GPIO0 18"),
+	PINCTRL_PIN(359, "V20 GPIO0 24"),
+	/* Row W */
+	PINCTRL_PIN(360, "W1 IDE RESET N"),
+	PINCTRL_PIN(361, "W2 GND"),
+	PINCTRL_PIN(362, "W3 USB0 VCCHSRT"),
+	PINCTRL_PIN(363, "W4 USB0 DP"),
+	PINCTRL_PIN(364, "W5 USB VCCA U20"),
+	PINCTRL_PIN(365, "W6 USB1 DP"),
+	PINCTRL_PIN(366, "W7 USB1 GNDHSRT"),
+	PINCTRL_PIN(367, "W8 GMAC0 RXD0"),
+	PINCTRL_PIN(368, "W9 GMAC0 CRS"),
+	PINCTRL_PIN(369, "W10 GMAC1 TXD2"),
+	PINCTRL_PIN(370, "W11 GMAC1 TXEN"),
+	PINCTRL_PIN(371, "W12 GMAC1 RXD3"),
+	PINCTRL_PIN(372, "W13 MODE SEL0"),
+	PINCTRL_PIN(373, "W14 MODE SEL3"),
+	PINCTRL_PIN(374, "W15 GPIO1 31"),
+	PINCTRL_PIN(375, "W16 GPIO0 5"),
+	PINCTRL_PIN(376, "W17 GPIO0 7"),
+	PINCTRL_PIN(377, "W18 GPIO0 12"),
+	PINCTRL_PIN(378, "W19 GND"),
+	PINCTRL_PIN(379, "W20 GPIO0 20"),
+	/* Row Y */
+	PINCTRL_PIN(380, "Y1 ICE0 IMS"),
+	PINCTRL_PIN(381, "Y2 USB0 GNDHSRT"),
+	PINCTRL_PIN(382, "Y3 USB0 DM"),
+	PINCTRL_PIN(383, "Y4 USB RREF"),
+	PINCTRL_PIN(384, "Y5 USB1 DM"),
+	PINCTRL_PIN(385, "Y6 USB1 VCCHSRT"),
+	PINCTRL_PIN(386, "Y7 GMAC0 RXC"),
+	PINCTRL_PIN(387, "Y8 GMAC0 RXD2"),
+	PINCTRL_PIN(388, "Y9 REF CLK"),
+	PINCTRL_PIN(389, "Y10 GMAC1 TXD1"),
+	PINCTRL_PIN(390, "Y11 GMAC1 RXC"),
+	PINCTRL_PIN(391, "Y12 GMAC1 RXD0"),
+	PINCTRL_PIN(392, "Y13 M30 CLK"),
+	PINCTRL_PIN(393, "Y14 MODE SEL2"),
+	PINCTRL_PIN(394, "Y15 GPIO1 30"),
+	PINCTRL_PIN(395, "Y16 GPIO0 2"),
+	PINCTRL_PIN(396, "Y17 GPIO0 6"),
+	PINCTRL_PIN(397, "Y18 SYS RESET N"),
+	PINCTRL_PIN(398, "Y19 GPIO0 13"),
+	PINCTRL_PIN(399, "Y20 GPIO0 15"),
+};
+
+/**
+ * @dev: a pointer back to containing device
+ * @virtbase: the offset to the controller in virtual memory
+ * @map: regmap to access registers
+ * @flash_pin: whether the flash pin (extended pins for parallel
+ * flash) is set
+ */
+struct gemini_pmx {
+	struct device *dev;
+	struct pinctrl_dev *pctl;
+	struct regmap *map;
+	bool flash_pin;
+};
+
+/**
+ * struct gemini_pin_group - describes a Gemini pin group
+ * @name: the name of this specific pin group
+ * @pins: an array of discrete physical pins used in this group, taken
+ *	from the driver-local pin enumeration space
+ * @num_pins: the number of pins in this group array, i.e. the number of
+ *	elements in .pins so we can iterate over that array
+ * @mask: bits to clear to enable this when doing pin muxing
+ * @value: bits to set to enable this when doing pin muxing
+ */
+struct gemini_pin_group {
+	const char *name;
+	const unsigned int *pins;
+	const unsigned int num_pins;
+	u32 mask;
+	u32 value;
+};
+
+/* Digital ground */
+static const unsigned int gnd_pins[] = {
+	21, 38, 42, 57, 63, 76, 84, 95, 105, 114, 126, 133, 147, 148, 149, 150,
+	151, 152, 167, 168, 169, 170, 171, 172, 187, 188, 189, 190, 191, 192,
+	207, 208, 209, 210, 211, 212, 227, 228, 229, 230, 231, 232, 247, 248,
+	249, 250, 251, 252, 266, 273, 285, 294, 304, 315, 323, 336, 342, 357,
+	361, 378
+};
+
+static const unsigned int dram_pins[] = {
+	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 23, 24, 25, 26,
+	27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 44, 45, 46, 47, 48, 49, 50,
+	51, 52, 53, 54, 55, 56, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75,
+	87, 88, 89, 90, 91, 92, 93, 94
+};
+
+static const unsigned int rtc_pins[] = { 0, 43, 22 };
+
+static const unsigned int power_pins[] = { 20, 83, 40, 41, 60, 61, 62 };
+
+static const unsigned int cir_pins[] = { 85, 64, 82 };
+
+static const unsigned int system_pins[] = {
+	332, 392, 372, 373, 393, 352, 331, 388, 397, 77
+};
+
+static const unsigned int vcontrol_pins[] = { 86, 81, 80 };
+
+static const unsigned int ice_pins[] = { 340, 341, 303, 322, 380, 284, 343 };
+
+static const unsigned int ide_pins[] = {
+	200, 201, 204, 220, 221, 222, 223, 224, 240, 241, 242, 243, 244, 260,
+	261, 262, 263, 264, 280, 281, 282, 283, 300, 301, 302, 320, 321, 360
+};
+
+static const unsigned int sata_pins[] = {
+	100, 101, 102, 103, 104, 120, 121, 122, 123, 124, 140, 141, 142, 143,
+	144, 160, 161, 162, 163, 180, 181, 182, 183, 202
+};
+
+static const unsigned int usb_pins[] = {
+	305, 324, 344, 362, 363, 364, 365, 366, 381, 382, 383, 384, 385
+};
+
+/* GMII, ethernet pins */
+static const unsigned int gmii_pins[] = {
+	306, 307, 308, 309, 310, 325, 326, 327, 328, 329, 330, 345, 346, 347,
+	348, 349, 350, 351, 367, 368, 369, 370, 371, 386, 387, 389, 390, 391
+};
+
+static const unsigned int pci_pins[] = {
+	17, 18, 19, 39, 58, 59, 78, 79, 96, 97, 98, 99, 115, 116, 117, 118,
+	119, 135, 136, 137, 138, 139, 155, 156, 157, 158, 159, 175, 176, 177,
+	178, 179, 195, 196, 197, 198, 199, 215, 216, 217, 218, 219, 235, 236,
+	237, 238, 239, 255, 256, 257, 258, 259, 277, 278, 279, 299
+};
+
+/*
+ * Apparently the LPC interface is using the PCICLK for the clocking so
+ * PCI needs to be active at the same time.
+ */
+static const unsigned int lpc_pins[] = {
+	355, /* LPC_LAD[0] */
+	356, /* LPC_SERIRQ */
+	377, /* LPC_LAD[2] */
+	398, /* LPC_LFRAME# */
+	316, /* LPC_LAD[3] */
+	399, /* LPC_LAD[1] */
+};
+
+/* Character LCD */
+static const unsigned int lcd_pins[] = {
+	391, 351, 310, 371, 353, 311, 394, 374, 314, 359, 339
+};
+
+static const unsigned int ssp_pins[] = {
+	355, /* SSP_97RST# SSP AC97 Reset, active low */
+	356, /* SSP_FSC */
+	377, /* SSP_ECLK */
+	398, /* SSP_TXD */
+	316, /* SSP_RXD */
+	399, /* SSP_SCLK */
+};
+
+static const unsigned int uart_rxtx_pins[] = {
+	313, /* UART_SIN serial input, RX */
+	335, /* UART_SOUT serial output, TX */
+};
+
+static const unsigned int uart_modem_pins[] = {
+	355, /* UART_NDCD DCD carrier detect */
+	356, /* UART_NDTR DTR data terminal ready */
+	377, /* UART_NDSR DSR data set ready */
+	398, /* UART_NRTS RTS request to send */
+	316, /* UART_NCTS CTS clear to send */
+	399, /* UART_NRI RI ring indicator */
+};
+
+static const unsigned int tvc_pins[] = {
+	353, /* TVC_DATA[0] */
+	311, /* TVC_DATA[1] */
+	394, /* TVC_DATA[2] */
+	374, /* TVC_DATA[3] */
+	333, /* TVC_CLK */
+	354, /* TVC_DATA[4] */
+	395, /* TVC_DATA[5] */
+	312, /* TVC_DATA[6] */
+	334, /* TVC_DATA[7] */
+};
+
+/* NAND flash pins */
+static const unsigned int nflash_pins[] = {
+	243, 260, 261, 224, 280, 262, 281, 264, 300, 263, 282, 301, 320, 283,
+	302, 321, 337, 358, 295, 359, 339, 275, 298
+};
+
+/* Parallel (NOR) flash pins, D[0-15], A[16-25], CE0, CE1, RB, WE, OE, ALE */
+static const unsigned int pflash_pins[] = {
+	221, 200, 222, 201, 220, 243, 260, 261, 224, 280, 262, 281, 264, 300,
+	263, 282, 301, 320, 283, 302, 321, 317, 379, 295, 359, 339, 297, 318,
+	276, 319, 275, 298
+};
+
+/*
+ * The parallel flash can be set up in a 26-bit address bus mode exposing
+ * A[0-15] (A[15] takes the place of ALE), but it has the
+ * side effect of stealing pins from GMAC1 and TVC so these blocks cannot be
+ * used at the same time.
+ */
+static const unsigned int pflash_pins_extended[] = {
+	221, 200, 222, 201, 220, 243, 260, 261, 224, 280, 262, 281, 264, 300,
+	263, 282, 301, 320, 283, 302, 321, 317, 379, 295, 359, 339, 297, 318,
+	276, 319, 275, 298,
+	/* The extra pins */
+	349, 308, 369, 389, 329, 350, 370, 309, 390, 391, 351, 310, 371, 330,
+	333
+};
+
+/* Serial flash pins CE0, CE1, DI, DO, CK */
+static const unsigned int sflash_pins[] = { 296, 338, 295, 359, 339 };
+
+/* The GPIO0A (0-4) pins overlap with TVC and extended parallel flash */
+static const unsigned int gpio0a_pins[] = { 333, 354, 395, 312, 334 };
+
+/* The GPIO0B (5-7) pins overlap with ICE */
+static const unsigned int gpio0b_pins[] = { 375, 396, 376 };
+
+/* The GPIO0C (8,11-15) pins overlap with LPC, UART and SSP */
+static const unsigned int gpio0c_pins[] = { 355, 356, 377, 398, 316, 399 };
+
+/* The GPIO0D (9,10) pins overlap with UART RX/TX */
+static const unsigned int gpio0d_pins[] = { 313, 335 };
+
+/* The GPIO0E (16) pins overlap with LCD */
+static const unsigned int gpio0e_pins[] = { 314 };
+
+/* The GPIO0F (17,18) pins overlap with NAND flash CE0, CE1 */
+static const unsigned int gpio0f_pins[] = { 337, 358 };
+
+/* The GPIO0G (19,20,26-29) pins overlap with parallel flash */
+static const unsigned int gpio0g_pins[] = { 317, 379, 297, 318, 276, 319 };
+
+/* The GPIO0H (21,22) pins overlap with serial flash CE0, CE1 */
+static const unsigned int gpio0h_pins[] = { 296, 338 };
+
+/* The GPIO0I (23) pins overlap with all flash */
+static const unsigned int gpio0i_pins[] = { 295 };
+
+/* The GPIO0J (24,25) pins overlap with all flash and LCD */
+static const unsigned int gpio0j_pins[] = { 359, 339 };
+
+/* The GPIO0K (30,31) pins overlap with NAND flash */
+static const unsigned int gpio0k_pins[] = { 275, 298 };
+
+/* The GPIO1A (0-4) pins that overlap with IDE and parallel flash */
+static const unsigned int gpio1a_pins[] = { 221, 200, 222, 201, 220 };
+
+/* The GPIO1B (5-10,27) pins overlap with just IDE */
+static const unsigned int gpio1b_pins[] = { 241, 223, 240, 204, 242, 244, 360 };
+
+/* The GPIO1C (11-26) pins overlap with IDE, parallel flash and NAND flash */
+static const unsigned int gpio1c_pins[] = {
+	243, 260, 261, 224, 280, 262, 281, 264, 300, 263, 282, 301, 320, 283,
+	302, 321
+};
+
+/* The GPIO1D (28-31) pins overlap with TVC */
+static const unsigned int gpio1d_pins[] = { 353, 311, 394, 374 };
+
+/* The GPIO2A (0-3) pins overlap with GMII and extended parallel flash */
+static const unsigned int gpio2a_pins[] = { 308, 369, 389, 329 };
+
+/* The GPIO2B (4-7) pins overlap with GMII, extended parallel flash and LCD */
+static const unsigned int gpio2b_pins[] = { 391, 351, 310, 371 };
+
+/* The GPIO2C (8-31) pins overlap with PCI */
+static const unsigned int gpio2c_pins[] = {
+	259, 237, 238, 239, 215, 216, 217, 218, 177, 159, 158, 175, 176, 139,
+	157, 138, 137, 156, 118, 155, 99, 98, 136, 117
+};
+
+static const struct gemini_pin_group gemini_pin_groups[] = {
+	{
+		.name = "gndgrp",
+		.pins = gnd_pins,
+		.num_pins = ARRAY_SIZE(gnd_pins),
+	},
+	{
+		.name = "dramgrp",
+		.pins = dram_pins,
+		.num_pins = ARRAY_SIZE(dram_pins),
+		.mask = DRAM_PADS_POWERDOWN,
+	},
+	{
+		.name = "rtcgrp",
+		.pins = rtc_pins,
+		.num_pins = ARRAY_SIZE(rtc_pins),
+	},
+	{
+		.name = "powergrp",
+		.pins = power_pins,
+		.num_pins = ARRAY_SIZE(power_pins),
+	},
+	{
+		.name = "cirgrp",
+		.pins = cir_pins,
+		.num_pins = ARRAY_SIZE(cir_pins),
+	},
+	{
+		.name = "systemgrp",
+		.pins = system_pins,
+		.num_pins = ARRAY_SIZE(system_pins),
+	},
+	{
+		.name = "vcontrolgrp",
+		.pins = vcontrol_pins,
+		.num_pins = ARRAY_SIZE(vcontrol_pins),
+	},
+	{
+		.name = "icegrp",
+		.pins = ice_pins,
+		.num_pins = ARRAY_SIZE(ice_pins),
+		/* Conflict with some GPIO groups */
+	},
+	{
+		.name = "idegrp",
+		.pins = ide_pins,
+		.num_pins = ARRAY_SIZE(ide_pins),
+		/* Conflict with all flash usage */
+		.value = IDE_PADS_ENABLE | NAND_PADS_DISABLE |
+			PFLASH_PADS_DISABLE | SFLASH_PADS_DISABLE,
+	},
+	{
+		.name = "satagrp",
+		.pins = sata_pins,
+		.num_pins = ARRAY_SIZE(sata_pins),
+	},
+	{
+		.name = "usbgrp",
+		.pins = usb_pins,
+		.num_pins = ARRAY_SIZE(usb_pins),
+	},
+	{
+		.name = "gmiigrp",
+		.pins = gmii_pins,
+		.num_pins = ARRAY_SIZE(gmii_pins),
+	},
+	{
+		.name = "pcigrp",
+		.pins = pci_pins,
+		.num_pins = ARRAY_SIZE(pci_pins),
+		/* Conflict only with GPIO2 */
+		.value = PCI_PADS_ENABLE | PCI_CLK_PAD_ENABLE,
+	},
+	{
+		.name = "lpcgrp",
+		.pins = lpc_pins,
+		.num_pins = ARRAY_SIZE(lpc_pins),
+		/* Conflict with SSP */
+		.mask = SSP_PADS_ENABLE,
+		.value = LPC_PADS_ENABLE | LPC_CLK_PAD_ENABLE,
+	},
+	{
+		.name = "lcdgrp",
+		.pins = lcd_pins,
+		.num_pins = ARRAY_SIZE(lcd_pins),
+		.mask = TVC_PADS_ENABLE,
+		.value = LCD_PADS_ENABLE,
+	},
+	{
+		.name = "sspgrp",
+		.pins = ssp_pins,
+		.num_pins = ARRAY_SIZE(ssp_pins),
+		/* Conflict with LPC */
+		.mask = LPC_PADS_ENABLE,
+		.value = SSP_PADS_ENABLE,
+	},
+	{
+		.name = "uartrxtxgrp",
+		.pins = uart_rxtx_pins,
+		.num_pins = ARRAY_SIZE(uart_rxtx_pins),
+		/* No conflicts except GPIO */
+	},
+	{
+		.name = "uartmodemgrp",
+		.pins = uart_modem_pins,
+		.num_pins = ARRAY_SIZE(uart_modem_pins),
+		/*
+		 * Conflict with LPC and SSP,
+		 * so when those are both disabled, modem UART can thrive.
+		 */
+		.mask = LPC_PADS_ENABLE | SSP_PADS_ENABLE,
+	},
+	{
+		.name = "tvcgrp",
+		.pins = tvc_pins,
+		.num_pins = ARRAY_SIZE(tvc_pins),
+		/* Conflict with character LCD */
+		.mask = LCD_PADS_ENABLE,
+		.value = TVC_PADS_ENABLE | TVC_CLK_PAD_ENABLE,
+	},
+	/*
+	 * The construction is done such that it is possible to use a serial
+	 * flash together with a NAND or parallel (NOR) flash, but it is not
+	 * possible to use NAND and parallel flash together. To use serial
+	 * flash with one of the two others, the muxbits need to be flipped
+	 * around before any access.
+	 */
+	{
+		.name = "nflashgrp",
+		.pins = nflash_pins,
+		.num_pins = ARRAY_SIZE(nflash_pins),
+		/* Conflict with IDE, parallel and serial flash */
+		.mask = NAND_PADS_DISABLE | IDE_PADS_ENABLE,
+		.value = PFLASH_PADS_DISABLE | SFLASH_PADS_DISABLE,
+	},
+	{
+		.name = "pflashgrp",
+		.pins = pflash_pins,
+		.num_pins = ARRAY_SIZE(pflash_pins),
+		/* Conflict with IDE, NAND and serial flash */
+		.mask = PFLASH_PADS_DISABLE | IDE_PADS_ENABLE,
+		.value = NAND_PADS_DISABLE | SFLASH_PADS_DISABLE,
+	},
+	{
+		.name = "sflashgrp",
+		.pins = sflash_pins,
+		.num_pins = ARRAY_SIZE(sflash_pins),
+		/* Conflict with IDE, NAND and parallel flash */
+		.mask = SFLASH_PADS_DISABLE | IDE_PADS_ENABLE,
+		.value = NAND_PADS_DISABLE | PFLASH_PADS_DISABLE,
+	},
+	{
+		.name = "gpio0agrp",
+		.pins = gpio0a_pins,
+		.num_pins = ARRAY_SIZE(gpio0a_pins),
+		/* Conflict with TVC and ICE */
+		.mask = TVC_PADS_ENABLE,
+	},
+	{
+		.name = "gpio0bgrp",
+		.pins = gpio0b_pins,
+		.num_pins = ARRAY_SIZE(gpio0b_pins),
+		/* Conflict with ICE */
+	},
+	{
+		.name = "gpio0cgrp",
+		.pins = gpio0c_pins,
+		.num_pins = ARRAY_SIZE(gpio0c_pins),
+		/* Conflict with LPC, UART and SSP */
+		.mask = LPC_PADS_ENABLE | SSP_PADS_ENABLE,
+	},
+	{
+		.name = "gpio0dgrp",
+		.pins = gpio0d_pins,
+		.num_pins = ARRAY_SIZE(gpio0d_pins),
+		/* Conflict with UART */
+	},
+	{
+		.name = "gpio0egrp",
+		.pins = gpio0e_pins,
+		.num_pins = ARRAY_SIZE(gpio0e_pins),
+		/* Conflict with LCD */
+		.mask = LCD_PADS_ENABLE,
+	},
+	{
+		.name = "gpio0fgrp",
+		.pins = gpio0f_pins,
+		.num_pins = ARRAY_SIZE(gpio0f_pins),
+		/* Conflict with NAND flash */
+		.value = NAND_PADS_DISABLE,
+	},
+	{
+		.name = "gpio0ggrp",
+		.pins = gpio0g_pins,
+		.num_pins = ARRAY_SIZE(gpio0g_pins),
+		/* Conflict with parallel flash */
+		.value = PFLASH_PADS_DISABLE,
+	},
+	{
+		.name = "gpio0hgrp",
+		.pins = gpio0h_pins,
+		.num_pins = ARRAY_SIZE(gpio0h_pins),
+		/* Conflict with serial flash */
+		.value = SFLASH_PADS_DISABLE,
+	},
+	{
+		.name = "gpio0igrp",
+		.pins = gpio0i_pins,
+		.num_pins = ARRAY_SIZE(gpio0i_pins),
+		/* Conflict with all flash */
+		.value = PFLASH_PADS_DISABLE | NAND_PADS_DISABLE |
+			SFLASH_PADS_DISABLE,
+	},
+	{
+		.name = "gpio0jgrp",
+		.pins = gpio0j_pins,
+		.num_pins = ARRAY_SIZE(gpio0j_pins),
+		/* Conflict with all flash and LCD */
+		.mask = LCD_PADS_ENABLE,
+		.value = PFLASH_PADS_DISABLE | NAND_PADS_DISABLE |
+			SFLASH_PADS_DISABLE,
+	},
+	{
+		.name = "gpio0kgrp",
+		.pins = gpio0k_pins,
+		.num_pins = ARRAY_SIZE(gpio0k_pins),
+		/* Conflict with parallel and NAND flash */
+		.value = PFLASH_PADS_DISABLE | NAND_PADS_DISABLE,
+	},
+	{
+		.name = "gpio1agrp",
+		.pins = gpio1a_pins,
+		.num_pins = ARRAY_SIZE(gpio1a_pins),
+		/* Conflict with IDE and parallel flash */
+		.mask = IDE_PADS_ENABLE,
+		.value = PFLASH_PADS_DISABLE,
+	},
+	{
+		.name = "gpio1bgrp",
+		.pins = gpio1b_pins,
+		.num_pins = ARRAY_SIZE(gpio1b_pins),
+		/* Conflict with IDE only */
+		.mask = IDE_PADS_ENABLE,
+	},
+	{
+		.name = "gpio1cgrp",
+		.pins = gpio1c_pins,
+		.num_pins = ARRAY_SIZE(gpio1c_pins),
+		/* Conflict with IDE, parallel and NAND flash */
+		.mask = IDE_PADS_ENABLE,
+		.value = NAND_PADS_DISABLE | PFLASH_PADS_DISABLE,
+	},
+	{
+		.name = "gpio1dgrp",
+		.pins = gpio1d_pins,
+		.num_pins = ARRAY_SIZE(gpio1d_pins),
+		/* Conflict with TVC */
+		.mask = TVC_PADS_ENABLE,
+	},
+	{
+		.name = "gpio2agrp",
+		.pins = gpio2a_pins,
+		.num_pins = ARRAY_SIZE(gpio2a_pins),
+		/* Conflict with GMII and extended parallel flash */
+	},
+	{
+		.name = "gpio2bgrp",
+		.pins = gpio2b_pins,
+		.num_pins = ARRAY_SIZE(gpio2b_pins),
+		/* Conflict with GMII, extended parallel flash and LCD */
+		.mask = LCD_PADS_ENABLE,
+	},
+	{
+		.name = "gpio2cgrp",
+		.pins = gpio2c_pins,
+		.num_pins = ARRAY_SIZE(gpio2c_pins),
+		/* Conflict with PCI */
+		.mask = PCI_PADS_ENABLE,
+	},
+};
+
+static int gemini_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	return ARRAY_SIZE(gemini_pin_groups);
+}
+
+static const char *gemini_get_group_name(struct pinctrl_dev *pctldev,
+					 unsigned int selector)
+{
+	return gemini_pin_groups[selector].name;
+}
+
+static int gemini_get_group_pins(struct pinctrl_dev *pctldev,
+				 unsigned int selector,
+				 const unsigned int **pins,
+				 unsigned int *num_pins)
+{
+	struct gemini_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	/* The special case with the flash pin */
+	if (pmx->flash_pin &&
+	    !strcmp(gemini_pin_groups[selector].name, "pflashgrp")) {
+		*pins = pflash_pins_extended;
+		*num_pins = ARRAY_SIZE(pflash_pins_extended);
+		return 0;
+	}
+	*pins = gemini_pin_groups[selector].pins;
+	*num_pins = gemini_pin_groups[selector].num_pins;
+	return 0;
+}
+
+static void gemini_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
+				unsigned int offset)
+{
+	seq_printf(s, " " DRIVER_NAME);
+}
+
+static int gemini_pinctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
+					    struct device_node *np,
+					    struct pinctrl_map **map,
+					    unsigned int *reserved_maps,
+					    unsigned int *num_maps)
+{
+	int ret;
+	const char *function = NULL;
+	const char *group;
+	struct property *prop;
+
+	ret = of_property_read_string(np, "function", &function);
+	if (ret < 0)
+		return ret;
+
+	ret = of_property_count_strings(np, "groups");
+	if (ret < 0)
+		return ret;
+
+	ret = pinctrl_utils_reserve_map(pctldev, map, reserved_maps,
+					num_maps, ret);
+	if (ret < 0)
+		return ret;
+
+	of_property_for_each_string(np, "groups", prop, group) {
+		ret = pinctrl_utils_add_map_mux(pctldev, map, reserved_maps,
+						num_maps, group, function);
+		if (ret < 0)
+			return ret;
+		pr_debug("ADDED FUNCTION %s <-> GROUP %s\n",
+			 function, group);
+	}
+
+	return 0;
+}
+
+static int gemini_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
+				struct device_node *np_config,
+				struct pinctrl_map **map,
+				unsigned int *num_maps)
+{
+	unsigned int reserved_maps = 0;
+	struct device_node *np;
+	int ret;
+
+	*map = NULL;
+	*num_maps = 0;
+
+	for_each_child_of_node(np_config, np) {
+		ret = gemini_pinctrl_dt_subnode_to_map(pctldev, np, map,
+					&reserved_maps, num_maps);
+		if (ret < 0) {
+			pinctrl_utils_free_map(pctldev, *map, *num_maps);
+			return ret;
+		}
+	}
+
+	return 0;
+};
+
+static const struct pinctrl_ops gemini_pctrl_ops = {
+	.get_groups_count = gemini_get_groups_count,
+	.get_group_name = gemini_get_group_name,
+	.get_group_pins = gemini_get_group_pins,
+	.pin_dbg_show = gemini_pin_dbg_show,
+	.dt_node_to_map = gemini_pinctrl_dt_node_to_map,
+	.dt_free_map = pinctrl_utils_free_map,
+};
+
+/**
+ * struct gemini_pmx_func - describes Gemini pinmux functions
+ * @name: the name of this specific function
+ * @groups: corresponding pin groups
+ */
+struct gemini_pmx_func {
+	const char *name;
+	const char * const *groups;
+	const unsigned int num_groups;
+};
+
+static const char * const dramgrps[] = { "dramgrp" };
+static const char * const rtcgrps[] = { "rtcgrp" };
+static const char * const powergrps[] = { "powergrp" };
+static const char * const cirgrps[] = { "cirgrp" };
+static const char * const systemgrps[] = { "systemgrp" };
+static const char * const vcontrolgrps[] = { "vcontrolgrp" };
+static const char * const icegrps[] = { "icegrp" };
+static const char * const idegrps[] = { "idegrp" };
+static const char * const satagrps[] = { "satagrp" };
+static const char * const usbgrps[] = { "usbgrp" };
+static const char * const gmiigrps[] = { "gmiigrp" };
+static const char * const pcigrps[] = { "pcigrp" };
+static const char * const lpcgrps[] = { "lpcgrp" };
+static const char * const lcdgrps[] = { "lcdgrp" };
+static const char * const sspgrps[] = { "sspgrp" };
+static const char * const uartgrps[] = { "uartrxtxgrp", "uartmodemgrp" };
+static const char * const tvcgrps[] = { "tvcgrp" };
+static const char * const nflashgrps[] = { "nflashgrp" };
+static const char * const pflashgrps[] = { "pflashgrp", "pflashextgrp" };
+static const char * const sflashgrps[] = { "sflashgrp" };
+static const char * const gpio0grps[] = { "gpio0agrp", "gpio0bgrp", "gpio0cgrp",
+					  "gpio0dgrp", "gpio0egrp", "gpio0fgrp",
+					  "gpio0ggrp", "gpio0hgrp", "gpio0igrp",
+					  "gpio0jgrp", "gpio0kgrp" };
+static const char * const gpio1grps[] = { "gpio1agrp", "gpio1bgrp", "gpio1cgrp",
+					  "gpio1dgrp" };
+static const char * const gpio2grps[] = { "gpio2agrp", "gpio2bgrp", "gpio2cgrp" };
+
+static const struct gemini_pmx_func gemini_pmx_functions[] = {
+	{
+		.name = "dram",
+		.groups = dramgrps,
+		.num_groups = ARRAY_SIZE(idegrps),
+	},
+	{
+		.name = "rtc",
+		.groups = rtcgrps,
+		.num_groups = ARRAY_SIZE(rtcgrps),
+	},
+	{
+		.name = "power",
+		.groups = powergrps,
+		.num_groups = ARRAY_SIZE(powergrps),
+	},
+	{
+		.name = "cir",
+		.groups = cirgrps,
+		.num_groups = ARRAY_SIZE(cirgrps),
+	},
+	{
+		.name = "system",
+		.groups = systemgrps,
+		.num_groups = ARRAY_SIZE(systemgrps),
+	},
+	{
+		.name = "vcontrol",
+		.groups = vcontrolgrps,
+		.num_groups = ARRAY_SIZE(vcontrolgrps),
+	},
+	{
+		.name = "ice",
+		.groups = icegrps,
+		.num_groups = ARRAY_SIZE(icegrps),
+	},
+	{
+		.name = "ide",
+		.groups = idegrps,
+		.num_groups = ARRAY_SIZE(idegrps),
+	},
+	{
+		.name = "sata",
+		.groups = satagrps,
+		.num_groups = ARRAY_SIZE(satagrps),
+	},
+	{
+		.name = "pci",
+		.groups = pcigrps,
+		.num_groups = ARRAY_SIZE(pcigrps),
+	},
+	{
+		.name = "lpc",
+		.groups = lpcgrps,
+		.num_groups = ARRAY_SIZE(lpcgrps),
+	},
+	{
+		.name = "lcd",
+		.groups = lcdgrps,
+		.num_groups = ARRAY_SIZE(lcdgrps),
+	},
+	{
+		.name = "ssp",
+		.groups = sspgrps,
+		.num_groups = ARRAY_SIZE(sspgrps),
+	},
+	{
+		.name = "uart",
+		.groups = uartgrps,
+		.num_groups = ARRAY_SIZE(uartgrps),
+	},
+	{
+		.name = "tvc",
+		.groups = tvcgrps,
+		.num_groups = ARRAY_SIZE(tvcgrps),
+	},
+	{
+		.name = "nflash",
+		.groups = nflashgrps,
+		.num_groups = ARRAY_SIZE(nflashgrps),
+	},
+	{
+		.name = "pflash",
+		.groups = pflashgrps,
+		.num_groups = ARRAY_SIZE(pflashgrps),
+	},
+	{
+		.name = "sflash",
+		.groups = sflashgrps,
+		.num_groups = ARRAY_SIZE(sflashgrps),
+	},
+	{
+		.name = "gpio0",
+		.groups = gpio0grps,
+		.num_groups = ARRAY_SIZE(gpio0grps),
+	},
+	{
+		.name = "gpio1",
+		.groups = gpio1grps,
+		.num_groups = ARRAY_SIZE(gpio1grps),
+	},
+	{
+		.name = "gpio2",
+		.groups = gpio2grps,
+		.num_groups = ARRAY_SIZE(gpio2grps),
+	},
+};
+
+
+static int gemini_pmx_set_mux(struct pinctrl_dev *pctldev,
+			      unsigned int selector,
+			      unsigned int group)
+{
+	struct gemini_pmx *pmx;
+	const struct gemini_pmx_func *func;
+	const struct gemini_pin_group *grp;
+	u32 before, after, expected;
+	unsigned long tmp;
+	int i;
+
+	pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	func = &gemini_pmx_functions[selector];
+	grp = &gemini_pin_groups[group];
+
+	dev_info(pmx->dev,
+		 "ACTIVATE function \"%s\" with group \"%s\"\n",
+		 func->name, grp->name);
+
+	regmap_read(pmx->map, GLOBAL_MISC_CTRL, &before);
+	regmap_update_bits(pmx->map, GLOBAL_MISC_CTRL, grp->mask,
+			   grp->value);
+	regmap_read(pmx->map, GLOBAL_MISC_CTRL, &after);
+
+	/* Which bits changed */
+	before &= PADS_MASK;
+	after &= PADS_MASK;
+	expected = before &= ~grp->mask;
+	expected |= grp->value;
+	expected &= PADS_MASK;
+
+	/* Print changed states */
+	tmp = grp->mask;
+	for_each_set_bit(i, &tmp, PADS_MAXBIT) {
+		bool enabled = !(i > 3);
+
+		/* Did not go low though it should */
+		if (after & BIT(i)) {
+			dev_err(pmx->dev,
+				"pin group %s could not be %s: "
+				"probably a hardware limitation\n",
+				gemini_padgroups[i],
+				enabled ? "enabled" : "disabled");
+			dev_err(pmx->dev,
+				"GLOBAL MISC CTRL before: %08x, after %08x, expected %08x\n",
+				before, after, expected);
+		} else {
+			dev_info(pmx->dev,
+				 "padgroup %s %s\n",
+				 gemini_padgroups[i],
+				 enabled ? "enabled" : "disabled");
+		}
+	}
+
+	tmp = grp->value;
+	for_each_set_bit(i, &tmp, PADS_MAXBIT) {
+		bool enabled = (i > 3);
+
+		/* Did not go high though it should */
+		if (!(after & BIT(i))) {
+			dev_err(pmx->dev,
+				"pin group %s could not be %s: "
+				"probably a hardware limitation\n",
+				gemini_padgroups[i],
+				enabled ? "enabled" : "disabled");
+			dev_err(pmx->dev,
+				"GLOBAL MISC CTRL before: %08x, after %08x, expected %08x\n",
+				before, after, expected);
+		} else {
+			dev_info(pmx->dev,
+				 "padgroup %s %s\n",
+				 gemini_padgroups[i],
+				 enabled ? "enabled" : "disabled");
+		}
+	}
+
+	return 0;
+}
+
+static int gemini_pmx_get_funcs_count(struct pinctrl_dev *pctldev)
+{
+	return ARRAY_SIZE(gemini_pmx_functions);
+}
+
+static const char *gemini_pmx_get_func_name(struct pinctrl_dev *pctldev,
+					    unsigned int selector)
+{
+	return gemini_pmx_functions[selector].name;
+}
+
+static int gemini_pmx_get_groups(struct pinctrl_dev *pctldev,
+				 unsigned int selector,
+				 const char * const **groups,
+				 unsigned int * const num_groups)
+{
+	*groups = gemini_pmx_functions[selector].groups;
+	*num_groups = gemini_pmx_functions[selector].num_groups;
+	return 0;
+}
+
+static const struct pinmux_ops gemini_pmx_ops = {
+	.get_functions_count = gemini_pmx_get_funcs_count,
+	.get_function_name = gemini_pmx_get_func_name,
+	.get_function_groups = gemini_pmx_get_groups,
+	.set_mux = gemini_pmx_set_mux,
+};
+
+static struct pinctrl_desc gemini_pmx_desc = {
+	.name = DRIVER_NAME,
+	.pins = gemini_pins,
+	.npins = ARRAY_SIZE(gemini_pins),
+	.pctlops = &gemini_pctrl_ops,
+	.pmxops = &gemini_pmx_ops,
+	.owner = THIS_MODULE,
+};
+
+static int gemini_pmx_probe(struct platform_device *pdev)
+{
+	struct gemini_pmx *pmx;
+	struct regmap *map;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	unsigned long tmp;
+	u32 val;
+	int ret;
+	int i;
+
+	/* Create state holders etc for this driver */
+	pmx = devm_kzalloc(&pdev->dev, sizeof(*pmx), GFP_KERNEL);
+	if (!pmx)
+		return -ENOMEM;
+
+	pmx->dev = &pdev->dev;
+	map = syscon_regmap_lookup_by_phandle(np, "regmap");
+	if (IS_ERR(map)) {
+		dev_err(dev, "no syscon regmap\n");
+		return PTR_ERR(map);
+	}
+	pmx->map = map;
+
+	/* Check that regmap works at first call, then no more */
+	ret = regmap_read(map, GLOBAL_MISC_CTRL, &val);
+	if (ret) {
+		dev_err(dev, "cannot access regmap\n");
+		return ret;
+	}
+	dev_info(dev, "GLOBAL MISC CTRL at boot: 0x%08x\n", val);
+	/* Mask off relevant pads */
+	val &= PADS_MASK;
+	/* Invert the meaning of the DRAM+flash pads */
+	val ^= 0x0f;
+	/* Print initial state */
+	tmp = val;
+	for_each_set_bit(i, &tmp, PADS_MAXBIT) {
+		dev_info(dev, "pad group %s %s\n", gemini_padgroups[i],
+			 (val & BIT(i)) ? "enabled" : "disabled");
+	}
+
+	/* Check if flash pin is set */
+	regmap_read(map, GLOBAL_STATUS, &val);
+	pmx->flash_pin = !!(val & GLOBAL_STATUS_FLPIN);
+	dev_info(dev, "flash pin is %s\n", pmx->flash_pin ? "set" : "not set");
+
+	pmx->pctl = devm_pinctrl_register(dev, &gemini_pmx_desc, pmx);
+	if (IS_ERR(pmx->pctl)) {
+		dev_err(dev, "could not register pinmux driver\n");
+		return PTR_ERR(pmx->pctl);
+	}
+
+	dev_info(dev, "initialized Gemini pin control driver\n");
+
+	return 0;
+}
+
+static const struct of_device_id gemini_pinctrl_match[] = {
+	{ .compatible = "cortina,gemini-pinctrl" },
+	{},
+};
+
+static struct platform_driver gemini_pmx_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.of_match_table = gemini_pinctrl_match,
+	},
+	.probe = gemini_pmx_probe,
+};
+
+static int __init gemini_pmx_init(void)
+{
+	return platform_driver_register(&gemini_pmx_driver);
+}
+arch_initcall(gemini_pmx_init);
-- 
2.9.4
