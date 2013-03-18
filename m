From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:05:52 +0900
Subject: [PATCH 056/142] sh-pfc: sh73a0: Add bias (pull-up/down) pinconf
 support
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-57-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c |  351 ++++++++++++++++++++++++++++++++++-
 1 file changed, 350 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index 3200fc2..f31adfc 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -18,10 +18,14 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
+#include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/pinctrl/pinconf-generic.h>
+
 #include <mach/sh73a0.h>
 #include <mach/irqs.h>
 
+#include "core.h"
 #include "sh_pfc.h"
 
 #define CPU_ALL_PORT(fn, pfx, sfx)				\
@@ -1539,8 +1543,300 @@ static const pinmux_enum_t pinmux_data[] = {
 	PINMUX_DATA(FSIAISLD_PU_MARK, PORT55_FN1, PORT55_IN_PU),
 };
 
+#define SH73A0_PIN(pin, cfgs)						\
+	{								\
+		.name = __stringify(PORT##pin),				\
+		.enum_id = PORT##pin##_DATA,				\
+		.configs = cfgs,					\
+	}
+
+#define __I		(SH_PFC_PIN_CFG_INPUT)
+#define __O		(SH_PFC_PIN_CFG_OUTPUT)
+#define __IO		(SH_PFC_PIN_CFG_INPUT | SH_PFC_PIN_CFG_OUTPUT)
+#define __PD		(SH_PFC_PIN_CFG_PULL_DOWN)
+#define __PU		(SH_PFC_PIN_CFG_PULL_UP)
+#define __PUD		(SH_PFC_PIN_CFG_PULL_DOWN | SH_PFC_PIN_CFG_PULL_UP)
+
+#define SH73A0_PIN_I_PD(pin)		SH73A0_PIN(pin, __I | __PD)
+#define SH73A0_PIN_I_PU(pin)		SH73A0_PIN(pin, __I | __PU)
+#define SH73A0_PIN_I_PU_PD(pin)		SH73A0_PIN(pin, __I | __PUD)
+#define SH73A0_PIN_IO(pin)		SH73A0_PIN(pin, __IO)
+#define SH73A0_PIN_IO_PD(pin)		SH73A0_PIN(pin, __IO | __PD)
+#define SH73A0_PIN_IO_PU(pin)		SH73A0_PIN(pin, __IO | __PU)
+#define SH73A0_PIN_IO_PU_PD(pin)	SH73A0_PIN(pin, __IO | __PUD)
+#define SH73A0_PIN_O(pin)		SH73A0_PIN(pin, __O)
+
 static struct sh_pfc_pin pinmux_pins[] = {
-	GPIO_PORT_ALL(),
+	/* Table 25-1 (I/O and Pull U/D) */
+	SH73A0_PIN_I_PD(0),
+	SH73A0_PIN_I_PU(1),
+	SH73A0_PIN_I_PU(2),
+	SH73A0_PIN_I_PU(3),
+	SH73A0_PIN_I_PU(4),
+	SH73A0_PIN_I_PU(5),
+	SH73A0_PIN_I_PU(6),
+	SH73A0_PIN_I_PU(7),
+	SH73A0_PIN_I_PU(8),
+	SH73A0_PIN_I_PD(9),
+	SH73A0_PIN_I_PD(10),
+	SH73A0_PIN_I_PU_PD(11),
+	SH73A0_PIN_IO_PU_PD(12),
+	SH73A0_PIN_IO_PU_PD(13),
+	SH73A0_PIN_IO_PU_PD(14),
+	SH73A0_PIN_IO_PU_PD(15),
+	SH73A0_PIN_IO_PD(16),
+	SH73A0_PIN_IO_PD(17),
+	SH73A0_PIN_IO_PU(18),
+	SH73A0_PIN_IO_PU(19),
+	SH73A0_PIN_O(20),
+	SH73A0_PIN_O(21),
+	SH73A0_PIN_O(22),
+	SH73A0_PIN_O(23),
+	SH73A0_PIN_O(24),
+	SH73A0_PIN_I_PD(25),
+	SH73A0_PIN_I_PD(26),
+	SH73A0_PIN_IO_PU(27),
+	SH73A0_PIN_IO_PU(28),
+	SH73A0_PIN_IO_PD(29),
+	SH73A0_PIN_IO_PD(30),
+	SH73A0_PIN_IO_PU(31),
+	SH73A0_PIN_IO_PD(32),
+	SH73A0_PIN_I_PU_PD(33),
+	SH73A0_PIN_IO_PD(34),
+	SH73A0_PIN_I_PU_PD(35),
+	SH73A0_PIN_IO_PD(36),
+	SH73A0_PIN_IO(37),
+	SH73A0_PIN_O(38),
+	SH73A0_PIN_I_PU(39),
+	SH73A0_PIN_I_PU_PD(40),
+	SH73A0_PIN_O(41),
+	SH73A0_PIN_IO_PD(42),
+	SH73A0_PIN_IO_PU_PD(43),
+	SH73A0_PIN_IO_PU_PD(44),
+	SH73A0_PIN_IO_PD(45),
+	SH73A0_PIN_IO_PD(46),
+	SH73A0_PIN_IO_PD(47),
+	SH73A0_PIN_I_PD(48),
+	SH73A0_PIN_IO_PU_PD(49),
+	SH73A0_PIN_IO_PD(50),
+	SH73A0_PIN_IO_PD(51),
+	SH73A0_PIN_O(52),
+	SH73A0_PIN_IO_PU_PD(53),
+	SH73A0_PIN_IO_PU_PD(54),
+	SH73A0_PIN_IO_PD(55),
+	SH73A0_PIN_I_PU_PD(56),
+	SH73A0_PIN_IO(57),
+	SH73A0_PIN_IO(58),
+	SH73A0_PIN_IO(59),
+	SH73A0_PIN_IO(60),
+	SH73A0_PIN_IO(61),
+	SH73A0_PIN_IO_PD(62),
+	SH73A0_PIN_IO_PD(63),
+	SH73A0_PIN_IO_PU_PD(64),
+	SH73A0_PIN_IO_PD(65),
+	SH73A0_PIN_IO_PU_PD(66),
+	SH73A0_PIN_IO_PU_PD(67),
+	SH73A0_PIN_IO_PU_PD(68),
+	SH73A0_PIN_IO_PU_PD(69),
+	SH73A0_PIN_IO_PU_PD(70),
+	SH73A0_PIN_IO_PU_PD(71),
+	SH73A0_PIN_IO_PU_PD(72),
+	SH73A0_PIN_I_PU_PD(73),
+	SH73A0_PIN_IO_PU(74),
+	SH73A0_PIN_IO_PU(75),
+	SH73A0_PIN_IO_PU(76),
+	SH73A0_PIN_IO_PU(77),
+	SH73A0_PIN_IO_PU(78),
+	SH73A0_PIN_IO_PU(79),
+	SH73A0_PIN_IO_PU(80),
+	SH73A0_PIN_IO_PU(81),
+	SH73A0_PIN_IO_PU(82),
+	SH73A0_PIN_IO_PU(83),
+	SH73A0_PIN_IO_PU(84),
+	SH73A0_PIN_IO_PU(85),
+	SH73A0_PIN_IO_PU(86),
+	SH73A0_PIN_IO_PU(87),
+	SH73A0_PIN_IO_PU(88),
+	SH73A0_PIN_IO_PU(89),
+	SH73A0_PIN_O(90),
+	SH73A0_PIN_IO_PU(91),
+	SH73A0_PIN_O(92),
+	SH73A0_PIN_IO_PU(93),
+	SH73A0_PIN_O(94),
+	SH73A0_PIN_I_PU_PD(95),
+	SH73A0_PIN_IO(96),
+	SH73A0_PIN_IO(97),
+	SH73A0_PIN_IO(98),
+	SH73A0_PIN_I_PU(99),
+	SH73A0_PIN_O(100),
+	SH73A0_PIN_O(101),
+	SH73A0_PIN_I_PU(102),
+	SH73A0_PIN_IO_PD(103),
+	SH73A0_PIN_I_PU_PD(104),
+	SH73A0_PIN_I_PD(105),
+	SH73A0_PIN_I_PD(106),
+	SH73A0_PIN_I_PU_PD(107),
+	SH73A0_PIN_I_PU_PD(108),
+	SH73A0_PIN_IO_PD(109),
+	SH73A0_PIN_IO_PD(110),
+	SH73A0_PIN_IO_PU_PD(111),
+	SH73A0_PIN_IO_PU_PD(112),
+	SH73A0_PIN_IO_PU_PD(113),
+	SH73A0_PIN_IO_PD(114),
+	SH73A0_PIN_IO_PU(115),
+	SH73A0_PIN_IO_PU(116),
+	SH73A0_PIN_IO_PU_PD(117),
+	SH73A0_PIN_IO_PU_PD(118),
+	SH73A0_PIN_IO_PD(128),
+	SH73A0_PIN_IO_PD(129),
+	SH73A0_PIN_IO_PU_PD(130),
+	SH73A0_PIN_IO_PD(131),
+	SH73A0_PIN_IO_PD(132),
+	SH73A0_PIN_IO_PD(133),
+	SH73A0_PIN_IO_PU_PD(134),
+	SH73A0_PIN_IO_PU_PD(135),
+	SH73A0_PIN_IO_PU_PD(136),
+	SH73A0_PIN_IO_PU_PD(137),
+	SH73A0_PIN_IO_PD(138),
+	SH73A0_PIN_IO_PD(139),
+	SH73A0_PIN_IO_PD(140),
+	SH73A0_PIN_IO_PD(141),
+	SH73A0_PIN_IO_PD(142),
+	SH73A0_PIN_IO_PD(143),
+	SH73A0_PIN_IO_PU_PD(144),
+	SH73A0_PIN_IO_PD(145),
+	SH73A0_PIN_IO_PU_PD(146),
+	SH73A0_PIN_IO_PU_PD(147),
+	SH73A0_PIN_IO_PU_PD(148),
+	SH73A0_PIN_IO_PU_PD(149),
+	SH73A0_PIN_I_PU_PD(150),
+	SH73A0_PIN_IO_PU_PD(151),
+	SH73A0_PIN_IO_PU_PD(152),
+	SH73A0_PIN_IO_PD(153),
+	SH73A0_PIN_IO_PD(154),
+	SH73A0_PIN_I_PU_PD(155),
+	SH73A0_PIN_IO_PU_PD(156),
+	SH73A0_PIN_I_PD(157),
+	SH73A0_PIN_IO_PD(158),
+	SH73A0_PIN_IO_PU_PD(159),
+	SH73A0_PIN_IO_PU_PD(160),
+	SH73A0_PIN_I_PU_PD(161),
+	SH73A0_PIN_I_PU_PD(162),
+	SH73A0_PIN_IO_PU_PD(163),
+	SH73A0_PIN_I_PU_PD(164),
+	SH73A0_PIN_IO_PD(192),
+	SH73A0_PIN_IO_PU_PD(193),
+	SH73A0_PIN_IO_PD(194),
+	SH73A0_PIN_IO_PU_PD(195),
+	SH73A0_PIN_IO_PD(196),
+	SH73A0_PIN_IO_PD(197),
+	SH73A0_PIN_IO_PD(198),
+	SH73A0_PIN_IO_PD(199),
+	SH73A0_PIN_IO_PU_PD(200),
+	SH73A0_PIN_IO_PU_PD(201),
+	SH73A0_PIN_IO_PU_PD(202),
+	SH73A0_PIN_IO_PU_PD(203),
+	SH73A0_PIN_IO_PU_PD(204),
+	SH73A0_PIN_IO_PU_PD(205),
+	SH73A0_PIN_IO_PU_PD(206),
+	SH73A0_PIN_IO_PD(207),
+	SH73A0_PIN_IO_PD(208),
+	SH73A0_PIN_IO_PD(209),
+	SH73A0_PIN_IO_PD(210),
+	SH73A0_PIN_IO_PD(211),
+	SH73A0_PIN_IO_PD(212),
+	SH73A0_PIN_IO_PD(213),
+	SH73A0_PIN_IO_PU_PD(214),
+	SH73A0_PIN_IO_PU_PD(215),
+	SH73A0_PIN_IO_PD(216),
+	SH73A0_PIN_IO_PD(217),
+	SH73A0_PIN_O(218),
+	SH73A0_PIN_IO_PD(219),
+	SH73A0_PIN_IO_PD(220),
+	SH73A0_PIN_IO_PU_PD(221),
+	SH73A0_PIN_IO_PU_PD(222),
+	SH73A0_PIN_I_PU_PD(223),
+	SH73A0_PIN_I_PU_PD(224),
+	SH73A0_PIN_IO_PU_PD(225),
+	SH73A0_PIN_O(226),
+	SH73A0_PIN_IO_PU_PD(227),
+	SH73A0_PIN_I_PU_PD(228),
+	SH73A0_PIN_I_PD(229),
+	SH73A0_PIN_IO(230),
+	SH73A0_PIN_IO_PU_PD(231),
+	SH73A0_PIN_IO_PU_PD(232),
+	SH73A0_PIN_I_PU_PD(233),
+	SH73A0_PIN_IO_PU_PD(234),
+	SH73A0_PIN_IO_PU_PD(235),
+	SH73A0_PIN_IO_PU_PD(236),
+	SH73A0_PIN_IO_PD(237),
+	SH73A0_PIN_IO_PU_PD(238),
+	SH73A0_PIN_IO_PU_PD(239),
+	SH73A0_PIN_IO_PU_PD(240),
+	SH73A0_PIN_O(241),
+	SH73A0_PIN_I_PD(242),
+	SH73A0_PIN_IO_PU_PD(243),
+	SH73A0_PIN_IO_PU_PD(244),
+	SH73A0_PIN_IO_PU_PD(245),
+	SH73A0_PIN_IO_PU_PD(246),
+	SH73A0_PIN_IO_PU_PD(247),
+	SH73A0_PIN_IO_PU_PD(248),
+	SH73A0_PIN_IO_PU_PD(249),
+	SH73A0_PIN_IO_PU_PD(250),
+	SH73A0_PIN_IO_PU_PD(251),
+	SH73A0_PIN_IO_PU_PD(252),
+	SH73A0_PIN_IO_PU_PD(253),
+	SH73A0_PIN_IO_PU_PD(254),
+	SH73A0_PIN_IO_PU_PD(255),
+	SH73A0_PIN_IO_PU_PD(256),
+	SH73A0_PIN_IO_PU_PD(257),
+	SH73A0_PIN_IO_PU_PD(258),
+	SH73A0_PIN_IO_PU_PD(259),
+	SH73A0_PIN_IO_PU_PD(260),
+	SH73A0_PIN_IO_PU_PD(261),
+	SH73A0_PIN_IO_PU_PD(262),
+	SH73A0_PIN_IO_PU_PD(263),
+	SH73A0_PIN_IO_PU_PD(264),
+	SH73A0_PIN_IO_PU_PD(265),
+	SH73A0_PIN_IO_PU_PD(266),
+	SH73A0_PIN_IO_PU_PD(267),
+	SH73A0_PIN_IO_PU_PD(268),
+	SH73A0_PIN_IO_PU_PD(269),
+	SH73A0_PIN_IO_PU_PD(270),
+	SH73A0_PIN_IO_PU_PD(271),
+	SH73A0_PIN_IO_PU_PD(272),
+	SH73A0_PIN_IO_PU_PD(273),
+	SH73A0_PIN_IO_PU_PD(274),
+	SH73A0_PIN_IO_PU_PD(275),
+	SH73A0_PIN_IO_PU_PD(276),
+	SH73A0_PIN_IO_PU_PD(277),
+	SH73A0_PIN_IO_PU_PD(278),
+	SH73A0_PIN_IO_PU_PD(279),
+	SH73A0_PIN_IO_PU_PD(280),
+	SH73A0_PIN_O(281),
+	SH73A0_PIN_O(282),
+	SH73A0_PIN_I_PU(288),
+	SH73A0_PIN_IO_PU_PD(289),
+	SH73A0_PIN_IO_PU_PD(290),
+	SH73A0_PIN_IO_PU_PD(291),
+	SH73A0_PIN_IO_PU_PD(292),
+	SH73A0_PIN_IO_PU_PD(293),
+	SH73A0_PIN_IO_PU_PD(294),
+	SH73A0_PIN_IO_PU_PD(295),
+	SH73A0_PIN_IO_PU_PD(296),
+	SH73A0_PIN_IO_PU_PD(297),
+	SH73A0_PIN_IO_PU_PD(298),
+	SH73A0_PIN_IO_PU_PD(299),
+	SH73A0_PIN_IO_PU_PD(300),
+	SH73A0_PIN_IO_PU_PD(301),
+	SH73A0_PIN_IO_PU_PD(302),
+	SH73A0_PIN_IO_PU_PD(303),
+	SH73A0_PIN_IO_PU_PD(304),
+	SH73A0_PIN_IO_PU_PD(305),
+	SH73A0_PIN_O(306),
+	SH73A0_PIN_O(307),
+	SH73A0_PIN_I_PU(308),
+	SH73A0_PIN_O(309),
 };
 
 static const struct pinmux_range pinmux_ranges[] = {
@@ -2779,8 +3075,61 @@ static const struct pinmux_irq pinmux_irqs[] = {
 	PINMUX_IRQ(EXT_IRQ16L(9), 308),
 };
 
+#define PORTnCR_PULMD_OFF	(0 << 6)
+#define PORTnCR_PULMD_DOWN	(2 << 6)
+#define PORTnCR_PULMD_UP	(3 << 6)
+#define PORTnCR_PULMD_MASK	(3 << 6)
+
+static const unsigned int sh73a0_portcr_offsets[] = {
+	0x00000000, 0x00001000, 0x00001000, 0x00002000, 0x00002000,
+	0x00002000, 0x00002000, 0x00003000, 0x00003000, 0x00002000,
+};
+
+static unsigned int sh73a0_pinmux_get_bias(struct sh_pfc *pfc, unsigned int pin)
+{
+	void __iomem *addr = pfc->window->virt
+			   + sh73a0_portcr_offsets[pin >> 5] + pin;
+	u32 value = ioread8(addr) & PORTnCR_PULMD_MASK;
+
+	switch (value) {
+	case PORTnCR_PULMD_UP:
+		return PIN_CONFIG_BIAS_PULL_UP;
+	case PORTnCR_PULMD_DOWN:
+		return PIN_CONFIG_BIAS_PULL_DOWN;
+	case PORTnCR_PULMD_OFF:
+	default:
+		return PIN_CONFIG_BIAS_DISABLE;
+	}
+}
+
+static void sh73a0_pinmux_set_bias(struct sh_pfc *pfc, unsigned int pin,
+				   unsigned int bias)
+{
+	void __iomem *addr = pfc->window->virt
+			   + sh73a0_portcr_offsets[pin >> 5] + pin;
+	u32 value = ioread8(addr) & ~PORTnCR_PULMD_MASK;
+
+	switch (bias) {
+	case PIN_CONFIG_BIAS_PULL_UP:
+		value |= PORTnCR_PULMD_UP;
+		break;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		value |= PORTnCR_PULMD_DOWN;
+		break;
+	}
+
+	iowrite8(value, addr);
+}
+
+static const struct sh_pfc_soc_operations sh73a0_pinmux_ops = {
+	.get_bias = sh73a0_pinmux_get_bias,
+	.set_bias = sh73a0_pinmux_set_bias,
+};
+
 const struct sh_pfc_soc_info sh73a0_pinmux_info = {
 	.name = "sh73a0_pfc",
+	.ops = &sh73a0_pinmux_ops,
+
 	.input = { PINMUX_INPUT_BEGIN, PINMUX_INPUT_END },
 	.input_pu = { PINMUX_INPUT_PULLUP_BEGIN, PINMUX_INPUT_PULLUP_END },
 	.input_pd = { PINMUX_INPUT_PULLDOWN_BEGIN, PINMUX_INPUT_PULLDOWN_END },
-- 
1.7.10.4
