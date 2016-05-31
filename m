From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 31 May 2016 17:05:18 +0900
Subject: [PATCH 12/17] pinctrl: uniphier: support pin configuration for
 dedicated pins
In-Reply-To: <1464681923-7469-1-git-send-email-yamada.masahiro@socionext.com>
References: <1464681923-7469-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1464681923-7469-13-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PH1-LD4 and PH1-sLD8 SoCs have pins that support pin configuration
(pin biasing, drive strength control), but not pin-muxing.

Allow to fill the mux value table with -1 for those pins; pins with
mux value -1 will be skipped in the pin-mux set function.  The mux
value type should be changed from "unsigned" to "int" in order to
accommodate -1 as a special case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c |  5 ++-
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c  | 45 ++++++++++-----------
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c | 47 +++++++++++-----------
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c | 47 +++++++++++-----------
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c | 51 ++++++++++++------------
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c | 49 +++++++++++------------
 drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c | 45 ++++++++++-----------
 drivers/pinctrl/uniphier/pinctrl-uniphier.h      |  2 +-
 8 files changed, 144 insertions(+), 147 deletions(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
index d774a8e..5bfcfa8 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
@@ -551,7 +551,7 @@ static int uniphier_pmx_get_function_groups(struct pinctrl_dev *pctldev,
 }
 
 static int uniphier_pmx_set_one_mux(struct pinctrl_dev *pctldev, unsigned pin,
-				    unsigned muxval)
+				    int muxval)
 {
 	struct uniphier_pinctrl_priv *priv = pinctrl_dev_get_drvdata(pctldev);
 	unsigned int mux_bits, reg_stride, reg, reg_end, shift, mask;
@@ -564,6 +564,9 @@ static int uniphier_pmx_set_one_mux(struct pinctrl_dev *pctldev, unsigned pin,
 	if (ret)
 		return ret;
 
+	if (muxval < 0)
+		return 0;	/* dedicated pin; nothing to do for pin-mux */
+
 	if (priv->socdata->caps & UNIPHIER_PINCTRL_CAPS_DBGMUX_SEPARATE) {
 		/*
 		 *  Mode     reg_offset     bit_position
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
index edea90d..9b59f8d 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
@@ -518,43 +518,42 @@ static const struct pinctrl_pin_desc uniphier_ld4_pins[] = {
 };
 
 static const unsigned emmc_pins[] = {21, 22, 23, 24, 25, 26, 27};
-static const unsigned emmc_muxvals[] = {0, 1, 1, 1, 1, 1, 1};
+static const int emmc_muxvals[] = {0, 1, 1, 1, 1, 1, 1};
 static const unsigned emmc_dat8_pins[] = {28, 29, 30, 31};
-static const unsigned emmc_dat8_muxvals[] = {1, 1, 1, 1};
+static const int emmc_dat8_muxvals[] = {1, 1, 1, 1};
 static const unsigned i2c0_pins[] = {102, 103};
-static const unsigned i2c0_muxvals[] = {0, 0};
+static const int i2c0_muxvals[] = {0, 0};
 static const unsigned i2c1_pins[] = {104, 105};
-static const unsigned i2c1_muxvals[] = {0, 0};
+static const int i2c1_muxvals[] = {0, 0};
 static const unsigned i2c2_pins[] = {108, 109};
-static const unsigned i2c2_muxvals[] = {2, 2};
+static const int i2c2_muxvals[] = {2, 2};
 static const unsigned i2c3_pins[] = {108, 109};
-static const unsigned i2c3_muxvals[] = {3, 3};
+static const int i2c3_muxvals[] = {3, 3};
 static const unsigned nand_pins[] = {24, 25, 26, 27, 28, 29, 30, 31, 158, 159,
 				     160, 161, 162, 163, 164};
-static const unsigned nand_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-					0, 0};
+static const int nand_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned nand_cs1_pins[] = {22, 23};
-static const unsigned nand_cs1_muxvals[] = {0, 0};
+static const int nand_cs1_muxvals[] = {0, 0};
 static const unsigned sd_pins[] = {44, 45, 46, 47, 48, 49, 50, 51, 52};
-static const unsigned sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
+static const int sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned uart0_pins[] = {85, 88};
-static const unsigned uart0_muxvals[] = {1, 1};
+static const int uart0_muxvals[] = {1, 1};
 static const unsigned uart1_pins[] = {155, 156};
-static const unsigned uart1_muxvals[] = {13, 13};
+static const int uart1_muxvals[] = {13, 13};
 static const unsigned uart1b_pins[] = {69, 70};
-static const unsigned uart1b_muxvals[] = {23, 23};
+static const int uart1b_muxvals[] = {23, 23};
 static const unsigned uart2_pins[] = {128, 129};
-static const unsigned uart2_muxvals[] = {13, 13};
+static const int uart2_muxvals[] = {13, 13};
 static const unsigned uart3_pins[] = {110, 111};
-static const unsigned uart3_muxvals[] = {1, 1};
+static const int uart3_muxvals[] = {1, 1};
 static const unsigned usb0_pins[] = {53, 54};
-static const unsigned usb0_muxvals[] = {0, 0};
+static const int usb0_muxvals[] = {0, 0};
 static const unsigned usb1_pins[] = {55, 56};
-static const unsigned usb1_muxvals[] = {0, 0};
+static const int usb1_muxvals[] = {0, 0};
 static const unsigned usb2_pins[] = {155, 156};
-static const unsigned usb2_muxvals[] = {4, 4};
+static const int usb2_muxvals[] = {4, 4};
 static const unsigned usb2b_pins[] = {67, 68};
-static const unsigned usb2b_muxvals[] = {23, 23};
+static const int usb2b_muxvals[] = {23, 23};
 static const unsigned port_range0_pins[] = {
 	135, 136, 137, 138, 139, 140, 141, 142,		/* PORT0x */
 	143, 144, 145, 146, 147, 148, 149, 150,		/* PORT1x */
@@ -572,7 +571,7 @@ static const unsigned port_range0_pins[] = {
 	98, 99, 100, 6, 101, 114, 115, 116,		/* PORT13x */
 	103, 108, 21, 22, 23, 117, 118, 119,		/* PORT14x */
 };
-static const unsigned port_range0_muxvals[] = {
+static const int port_range0_muxvals[] = {
 	0, 0, 0, 0, 0, 0, 0, 0,				/* PORT0x */
 	0, 0, 0, 0, 0, 0, 0, 0,				/* PORT1x */
 	0, 0, 0, 0, 0, 0, 0, 15,			/* PORT2x */
@@ -592,21 +591,21 @@ static const unsigned port_range0_muxvals[] = {
 static const unsigned port_range1_pins[] = {
 	7,						/* PORT166 */
 };
-static const unsigned port_range1_muxvals[] = {
+static const int port_range1_muxvals[] = {
 	15,						/* PORT166 */
 };
 static const unsigned xirq_range0_pins[] = {
 	151, 123, 124, 125, 126, 127, 128, 129,		/* XIRQ0-7 */
 	130, 131, 132, 133, 62,				/* XIRQ8-12 */
 };
-static const unsigned xirq_range0_muxvals[] = {
+static const int xirq_range0_muxvals[] = {
 	14, 0, 0, 0, 0, 0, 0, 0,			/* XIRQ0-7 */
 	0, 0, 0, 0, 14,					/* XIRQ8-12 */
 };
 static const unsigned xirq_range1_pins[] = {
 	134, 63,					/* XIRQ14-15 */
 };
-static const unsigned xirq_range1_muxvals[] = {
+static const int xirq_range1_muxvals[] = {
 	0, 14,						/* XIRQ14-15 */
 };
 
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
index 2c9747b..638b342e 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
@@ -735,52 +735,51 @@ static const unsigned adinter_pins[] = {
 	215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228,
 	229, 230, 231, 232, 233, 234,
 };
-static const unsigned adinter_muxvals[] = {
+static const int adinter_muxvals[] = {
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 	0, 0, 0, 0,
 };
 static const unsigned emmc_pins[] = {36, 37, 38, 39, 40, 41, 42};
-static const unsigned emmc_muxvals[] = {1, 1, 1, 1, 1, 1, 1};
+static const int emmc_muxvals[] = {1, 1, 1, 1, 1, 1, 1};
 static const unsigned emmc_dat8_pins[] = {43, 44, 45, 46};
-static const unsigned emmc_dat8_muxvals[] = {1, 1, 1, 1};
+static const int emmc_dat8_muxvals[] = {1, 1, 1, 1};
 static const unsigned i2c0_pins[] = {109, 110};
-static const unsigned i2c0_muxvals[] = {0, 0};
+static const int i2c0_muxvals[] = {0, 0};
 static const unsigned i2c1_pins[] = {111, 112};
-static const unsigned i2c1_muxvals[] = {0, 0};
+static const int i2c1_muxvals[] = {0, 0};
 static const unsigned i2c2_pins[] = {115, 116};
-static const unsigned i2c2_muxvals[] = {1, 1};
+static const int i2c2_muxvals[] = {1, 1};
 static const unsigned i2c3_pins[] = {118, 119};
-static const unsigned i2c3_muxvals[] = {1, 1};
+static const int i2c3_muxvals[] = {1, 1};
 static const unsigned nand_pins[] = {30, 31, 32, 33, 34, 35, 36, 39, 40, 41,
 				     42, 43, 44, 45, 46};
-static const unsigned nand_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-					0, 0};
+static const int nand_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned nand_cs1_pins[] = {37, 38};
-static const unsigned nand_cs1_muxvals[] = {0, 0};
+static const int nand_cs1_muxvals[] = {0, 0};
 static const unsigned sd_pins[] = {47, 48, 49, 50, 51, 52, 53, 54, 55};
-static const unsigned sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
+static const int sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned uart0_pins[] = {135, 136};
-static const unsigned uart0_muxvals[] = {3, 3};
+static const int uart0_muxvals[] = {3, 3};
 static const unsigned uart0b_pins[] = {11, 12};
-static const unsigned uart0b_muxvals[] = {2, 2};
+static const int uart0b_muxvals[] = {2, 2};
 static const unsigned uart1_pins[] = {115, 116};
-static const unsigned uart1_muxvals[] = {0, 0};
+static const int uart1_muxvals[] = {0, 0};
 static const unsigned uart1b_pins[] = {113, 114};
-static const unsigned uart1b_muxvals[] = {1, 1};
+static const int uart1b_muxvals[] = {1, 1};
 static const unsigned uart2_pins[] = {113, 114};
-static const unsigned uart2_muxvals[] = {2, 2};
+static const int uart2_muxvals[] = {2, 2};
 static const unsigned uart2b_pins[] = {86, 87};
-static const unsigned uart2b_muxvals[] = {1, 1};
+static const int uart2b_muxvals[] = {1, 1};
 static const unsigned usb0_pins[] = {56, 57};
-static const unsigned usb0_muxvals[] = {0, 0};
+static const int usb0_muxvals[] = {0, 0};
 static const unsigned usb1_pins[] = {58, 59};
-static const unsigned usb1_muxvals[] = {0, 0};
+static const int usb1_muxvals[] = {0, 0};
 static const unsigned usb2_pins[] = {60, 61};
-static const unsigned usb2_muxvals[] = {0, 0};
+static const int usb2_muxvals[] = {0, 0};
 static const unsigned usb3_pins[] = {62, 63};
-static const unsigned usb3_muxvals[] = {0, 0};
+static const int usb3_muxvals[] = {0, 0};
 static const unsigned port_range0_pins[] = {
 	127, 128, 129, 130, 131, 132, 133, 134,		/* PORT0x */
 	135, 136, 137, 138, 139, 140, 141, 142,		/* PORT1x */
@@ -794,7 +793,7 @@ static const unsigned port_range0_pins[] = {
 	61, 62, 63, 64, 65, 66, 67, 68,			/* PORT9x */
 	69, 70, 71, 76, 77, 78, 79, 80,			/* PORT10x */
 };
-static const unsigned port_range0_muxvals[] = {
+static const int port_range0_muxvals[] = {
 	15, 15, 15, 15, 15, 15, 15, 15,			/* PORT0x */
 	15, 15, 15, 15, 15, 15, 15, 15,			/* PORT1x */
 	15, 15, 15, 15, 15, 15, 15, 15,			/* PORT2x */
@@ -826,7 +825,7 @@ static const unsigned port_range1_pins[] = {
 	218, 219, 220, 221, 223, 224, 225, 226,		/* PORT27x */
 	227, 228, 229, 230, 231, 232, 233, 234,		/* PORT28x */
 };
-static const unsigned port_range1_muxvals[] = {
+static const int port_range1_muxvals[] = {
 	15, 15, 15, 15, 15, 15, 15, 15,			/* PORT12x */
 	15, 15, 15, 15, 15, 15, 15, 15,			/* PORT13x */
 	15, 15, 15, 15, 15, 15, 15, 15,			/* PORT14x */
@@ -850,7 +849,7 @@ static const unsigned xirq_pins[] = {
 	126, 72, 73, 92, 177, 93, 94, 176,		/* XIRQ8-15 */
 	74, 91, 27, 28, 29, 75, 20, 26,			/* XIRQ16-23 */
 };
-static const unsigned xirq_muxvals[] = {
+static const int xirq_muxvals[] = {
 	14, 14, 14, 14, 14, 14, 14, 14,			/* XIRQ0-7 */
 	14, 14, 14, 14, 14, 14, 14, 14,			/* XIRQ8-15 */
 	14, 14, 14, 14, 14, 14, 14, 14,			/* XIRQ16-23 */
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
index 547359e..e973dd8 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
@@ -1010,46 +1010,45 @@ static const struct pinctrl_pin_desc uniphier_pro4_pins[] = {
 };
 
 static const unsigned emmc_pins[] = {40, 41, 42, 43, 51, 52, 53};
-static const unsigned emmc_muxvals[] = {1, 1, 1, 1, 1, 1, 1};
+static const int emmc_muxvals[] = {1, 1, 1, 1, 1, 1, 1};
 static const unsigned emmc_dat8_pins[] = {44, 45, 46, 47};
-static const unsigned emmc_dat8_muxvals[] = {1, 1, 1, 1};
+static const int emmc_dat8_muxvals[] = {1, 1, 1, 1};
 static const unsigned i2c0_pins[] = {142, 143};
-static const unsigned i2c0_muxvals[] = {0, 0};
+static const int i2c0_muxvals[] = {0, 0};
 static const unsigned i2c1_pins[] = {144, 145};
-static const unsigned i2c1_muxvals[] = {0, 0};
+static const int i2c1_muxvals[] = {0, 0};
 static const unsigned i2c2_pins[] = {146, 147};
-static const unsigned i2c2_muxvals[] = {0, 0};
+static const int i2c2_muxvals[] = {0, 0};
 static const unsigned i2c3_pins[] = {148, 149};
-static const unsigned i2c3_muxvals[] = {0, 0};
+static const int i2c3_muxvals[] = {0, 0};
 static const unsigned i2c6_pins[] = {308, 309};
-static const unsigned i2c6_muxvals[] = {6, 6};
+static const int i2c6_muxvals[] = {6, 6};
 static const unsigned nand_pins[] = {40, 41, 42, 43, 44, 45, 46, 47, 48, 49,
 				     50, 51, 52, 53, 54};
-static const unsigned nand_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-					0, 0};
+static const int nand_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned nand_cs1_pins[] = {131, 132};
-static const unsigned nand_cs1_muxvals[] = {1, 1};
+static const int nand_cs1_muxvals[] = {1, 1};
 static const unsigned sd_pins[] = {150, 151, 152, 153, 154, 155, 156, 157, 158};
-static const unsigned sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
+static const int sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned sd1_pins[] = {319, 320, 321, 322, 323, 324, 325, 326,
 				    327};
-static const unsigned sd1_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
+static const int sd1_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned uart0_pins[] = {127, 128};
-static const unsigned uart0_muxvals[] = {0, 0};
+static const int uart0_muxvals[] = {0, 0};
 static const unsigned uart1_pins[] = {129, 130};
-static const unsigned uart1_muxvals[] = {0, 0};
+static const int uart1_muxvals[] = {0, 0};
 static const unsigned uart2_pins[] = {131, 132};
-static const unsigned uart2_muxvals[] = {0, 0};
+static const int uart2_muxvals[] = {0, 0};
 static const unsigned uart3_pins[] = {88, 89};
-static const unsigned uart3_muxvals[] = {2, 2};
+static const int uart3_muxvals[] = {2, 2};
 static const unsigned usb0_pins[] = {180, 181};
-static const unsigned usb0_muxvals[] = {0, 0};
+static const int usb0_muxvals[] = {0, 0};
 static const unsigned usb1_pins[] = {182, 183};
-static const unsigned usb1_muxvals[] = {0, 0};
+static const int usb1_muxvals[] = {0, 0};
 static const unsigned usb2_pins[] = {184, 185};
-static const unsigned usb2_muxvals[] = {0, 0};
+static const int usb2_muxvals[] = {0, 0};
 static const unsigned usb3_pins[] = {186, 187};
-static const unsigned usb3_muxvals[] = {0, 0};
+static const int usb3_muxvals[] = {0, 0};
 static const unsigned port_range0_pins[] = {
 	300, 301, 302, 303, 304, 305, 306, 307,		/* PORT0x */
 	308, 309, 310, 311, 312, 313, 314, 315,		/* PORT1x */
@@ -1067,7 +1066,7 @@ static const unsigned port_range0_pins[] = {
 	76, 77, 78, 79, 80, 81, 82, 83,			/* PORT13x */
 	84, 85, 86, 87, 88, 89, 90, 91,			/* PORT14x */
 };
-static const unsigned port_range0_muxvals[] = {
+static const int port_range0_muxvals[] = {
 	7, 7, 7, 7, 7, 7, 7, 7,				/* PORT0x */
 	7, 7, 7, 7, 7, 7, 7, 7,				/* PORT1x */
 	7, 7, 7, 7, 7, 7, 7, 7,				/* PORT2x */
@@ -1100,7 +1099,7 @@ static const unsigned port_range1_pins[] = {
 	251, 252, 261, 262, 263, 264, 273, 274,		/* PORT29x */
 	31, 32, 33, 34, 35, 36, 37, 38,			/* PORT30x */
 };
-static const unsigned port_range1_muxvals[] = {
+static const int port_range1_muxvals[] = {
 	7, 7, 7,					/* PORT175-177 */
 	7, 7, 7, 7, 7, 7, 7, 7,				/* PORT18x */
 	7, 7, 7, 7, 7, 7, 7, 7,				/* PORT19x */
@@ -1121,7 +1120,7 @@ static const unsigned xirq_pins[] = {
 	234, 186, 99, 100, 101, 102, 184, 301,		/* XIRQ8-15 */
 	302, 303, 304, 305, 306,			/* XIRQ16-20 */
 };
-static const unsigned xirq_muxvals[] = {
+static const int xirq_muxvals[] = {
 	7, 7, 7, 7, 7, 7, 7, 7,				/* XIRQ0-7 */
 	7, 7, 7, 7, 7, 7, 2, 2,				/* XIRQ8-15 */
 	2, 2, 2, 2, 2,					/* XIRQ16-20 */
@@ -1129,7 +1128,7 @@ static const unsigned xirq_muxvals[] = {
 static const unsigned xirq_alternatives_pins[] = {
 	184, 310, 316,
 };
-static const unsigned xirq_alternatives_muxvals[] = {
+static const int xirq_alternatives_muxvals[] = {
 	2, 2, 2,
 };
 
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
index 080332d..191c200 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
@@ -791,49 +791,48 @@ static const struct pinctrl_pin_desc uniphier_pro5_pins[] = {
 };
 
 static const unsigned emmc_pins[] = {36, 37, 38, 39, 40, 41, 42};
-static const unsigned emmc_muxvals[] = {0, 0, 0, 0, 0, 0, 0};
+static const int emmc_muxvals[] = {0, 0, 0, 0, 0, 0, 0};
 static const unsigned emmc_dat8_pins[] = {43, 44, 45, 46};
-static const unsigned emmc_dat8_muxvals[] = {0, 0, 0, 0};
+static const int emmc_dat8_muxvals[] = {0, 0, 0, 0};
 static const unsigned i2c0_pins[] = {112, 113};
-static const unsigned i2c0_muxvals[] = {0, 0};
+static const int i2c0_muxvals[] = {0, 0};
 static const unsigned i2c1_pins[] = {114, 115};
-static const unsigned i2c1_muxvals[] = {0, 0};
+static const int i2c1_muxvals[] = {0, 0};
 static const unsigned i2c2_pins[] = {116, 117};
-static const unsigned i2c2_muxvals[] = {0, 0};
+static const int i2c2_muxvals[] = {0, 0};
 static const unsigned i2c3_pins[] = {118, 119};
-static const unsigned i2c3_muxvals[] = {0, 0};
+static const int i2c3_muxvals[] = {0, 0};
 static const unsigned i2c5_pins[] = {87, 88};
-static const unsigned i2c5_muxvals[] = {2, 2};
+static const int i2c5_muxvals[] = {2, 2};
 static const unsigned i2c5b_pins[] = {196, 197};
-static const unsigned i2c5b_muxvals[] = {2, 2};
+static const int i2c5b_muxvals[] = {2, 2};
 static const unsigned i2c5c_pins[] = {215, 216};
-static const unsigned i2c5c_muxvals[] = {2, 2};
+static const int i2c5c_muxvals[] = {2, 2};
 static const unsigned i2c6_pins[] = {101, 102};
-static const unsigned i2c6_muxvals[] = {2, 2};
+static const int i2c6_muxvals[] = {2, 2};
 static const unsigned nand_pins[] = {19, 20, 21, 22, 23, 24, 25, 28, 29, 30,
 				     31, 32, 33, 34, 35};
-static const unsigned nand_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-					0, 0};
+static const int nand_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned nand_cs1_pins[] = {26, 27};
-static const unsigned nand_cs1_muxvals[] = {0, 0};
+static const int nand_cs1_muxvals[] = {0, 0};
 static const unsigned sd_pins[] = {250, 251, 252, 253, 254, 255, 256, 257, 258};
-static const unsigned sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
+static const int sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned uart0_pins[] = {47, 48};
-static const unsigned uart0_muxvals[] = {0, 0};
+static const int uart0_muxvals[] = {0, 0};
 static const unsigned uart0b_pins[] = {227, 228};
-static const unsigned uart0b_muxvals[] = {3, 3};
+static const int uart0b_muxvals[] = {3, 3};
 static const unsigned uart1_pins[] = {49, 50};
-static const unsigned uart1_muxvals[] = {0, 0};
+static const int uart1_muxvals[] = {0, 0};
 static const unsigned uart2_pins[] = {51, 52};
-static const unsigned uart2_muxvals[] = {0, 0};
+static const int uart2_muxvals[] = {0, 0};
 static const unsigned uart3_pins[] = {53, 54};
-static const unsigned uart3_muxvals[] = {0, 0};
+static const int uart3_muxvals[] = {0, 0};
 static const unsigned usb0_pins[] = {124, 125};
-static const unsigned usb0_muxvals[] = {0, 0};
+static const int usb0_muxvals[] = {0, 0};
 static const unsigned usb1_pins[] = {126, 127};
-static const unsigned usb1_muxvals[] = {0, 0};
+static const int usb1_muxvals[] = {0, 0};
 static const unsigned usb2_pins[] = {128, 129};
-static const unsigned usb2_muxvals[] = {0, 0};
+static const int usb2_muxvals[] = {0, 0};
 static const unsigned port_range0_pins[] = {
 	89, 90, 91, 92, 93, 94, 95, 96,			/* PORT0x */
 	97, 98, 99, 100, 101, 102, 103, 104,		/* PORT1x */
@@ -851,7 +850,7 @@ static const unsigned port_range0_pins[] = {
 	179, 180, 181, 182, 186, 187, 188, 189,		/* PORT13x */
 	4, 5, 6, 7, 8, 9, 10, 11,			/* PORT14x */
 };
-static const unsigned port_range0_muxvals[] = {
+static const int port_range0_muxvals[] = {
 	15, 15, 15, 15, 15, 15, 15, 15,			/* PORT0x */
 	15, 15, 15, 15, 15, 15, 15, 15,			/* PORT1x */
 	15, 15, 15, 15, 15, 15, 15, 15,			/* PORT2x */
@@ -884,7 +883,7 @@ static const unsigned port_range1_pins[] = {
 	105, 106, 18, 27, 36, 128, 132, 137,		/* PORT29x */
 	183, 184, 185, 84, 47, 48, 51, 52,		/* PORT30x */
 };
-static const unsigned port_range1_muxvals[] = {
+static const int port_range1_muxvals[] = {
 	15, 15, 15,					/* PORT175-177 */
 	15, 15, 15, 15, 15, 15, 15, 15,			/* PORT18x */
 	15, 15, 15, 15, 15, 15, 15, 15,			/* PORT19x */
@@ -905,7 +904,7 @@ static const unsigned xirq_pins[] = {
 	76, 77, 78, 79, 80, 81, 82, 83,			/* XIRQ8-15 */
 	84, 85, 86, 87, 88,				/* XIRQ16-20 */
 };
-static const unsigned xirq_muxvals[] = {
+static const int xirq_muxvals[] = {
 	14, 14, 14, 14, 14, 14, 14, 14,			/* XIRQ0-7 */
 	14, 14, 14, 14, 14, 14, 14, 14,			/* XIRQ8-15 */
 	14, 14, 14, 14, 14,				/* XIRQ16-20 */
@@ -913,7 +912,7 @@ static const unsigned xirq_muxvals[] = {
 static const unsigned xirq_alternatives_pins[] = {
 	91, 92, 239, 144, 240, 156, 241, 106, 128,
 };
-static const unsigned xirq_alternatives_muxvals[] = {
+static const int xirq_alternatives_muxvals[] = {
 	14, 14, 14, 14, 14, 14, 14, 14, 14,
 };
 
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
index a2bf3f7..4349e99ff 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
@@ -728,49 +728,48 @@ static const struct pinctrl_pin_desc uniphier_pxs2_pins[] = {
 };
 
 static const unsigned emmc_pins[] = {36, 37, 38, 39, 40, 41, 42};
-static const unsigned emmc_muxvals[] = {9, 9, 9, 9, 9, 9, 9};
+static const int emmc_muxvals[] = {9, 9, 9, 9, 9, 9, 9};
 static const unsigned emmc_dat8_pins[] = {43, 44, 45, 46};
-static const unsigned emmc_dat8_muxvals[] = {9, 9, 9, 9};
+static const int emmc_dat8_muxvals[] = {9, 9, 9, 9};
 static const unsigned i2c0_pins[] = {109, 110};
-static const unsigned i2c0_muxvals[] = {8, 8};
+static const int i2c0_muxvals[] = {8, 8};
 static const unsigned i2c1_pins[] = {111, 112};
-static const unsigned i2c1_muxvals[] = {8, 8};
+static const int i2c1_muxvals[] = {8, 8};
 static const unsigned i2c2_pins[] = {171, 172};
-static const unsigned i2c2_muxvals[] = {8, 8};
+static const int i2c2_muxvals[] = {8, 8};
 static const unsigned i2c3_pins[] = {159, 160};
-static const unsigned i2c3_muxvals[] = {8, 8};
+static const int i2c3_muxvals[] = {8, 8};
 static const unsigned i2c5_pins[] = {183, 184};
-static const unsigned i2c5_muxvals[] = {11, 11};
+static const int i2c5_muxvals[] = {11, 11};
 static const unsigned i2c6_pins[] = {185, 186};
-static const unsigned i2c6_muxvals[] = {11, 11};
+static const int i2c6_muxvals[] = {11, 11};
 static const unsigned nand_pins[] = {30, 31, 32, 33, 34, 35, 36, 39, 40, 41,
 				     42, 43, 44, 45, 46};
-static const unsigned nand_muxvals[] = {8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
-					8, 8};
+static const int nand_muxvals[] = {8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8};
 static const unsigned nand_cs1_pins[] = {37, 38};
-static const unsigned nand_cs1_muxvals[] = {8, 8};
+static const int nand_cs1_muxvals[] = {8, 8};
 static const unsigned sd_pins[] = {47, 48, 49, 50, 51, 52, 53, 54, 55};
-static const unsigned sd_muxvals[] = {8, 8, 8, 8, 8, 8, 8, 8, 8};
+static const int sd_muxvals[] = {8, 8, 8, 8, 8, 8, 8, 8, 8};
 static const unsigned uart0_pins[] = {217, 218};
-static const unsigned uart0_muxvals[] = {8, 8};
+static const int uart0_muxvals[] = {8, 8};
 static const unsigned uart0b_pins[] = {179, 180};
-static const unsigned uart0b_muxvals[] = {10, 10};
+static const int uart0b_muxvals[] = {10, 10};
 static const unsigned uart1_pins[] = {115, 116};
-static const unsigned uart1_muxvals[] = {8, 8};
+static const int uart1_muxvals[] = {8, 8};
 static const unsigned uart2_pins[] = {113, 114};
-static const unsigned uart2_muxvals[] = {8, 8};
+static const int uart2_muxvals[] = {8, 8};
 static const unsigned uart3_pins[] = {219, 220};
-static const unsigned uart3_muxvals[] = {8, 8};
+static const int uart3_muxvals[] = {8, 8};
 static const unsigned uart3b_pins[] = {181, 182};
-static const unsigned uart3b_muxvals[] = {10, 10};
+static const int uart3b_muxvals[] = {10, 10};
 static const unsigned usb0_pins[] = {56, 57};
-static const unsigned usb0_muxvals[] = {8, 8};
+static const int usb0_muxvals[] = {8, 8};
 static const unsigned usb1_pins[] = {58, 59};
-static const unsigned usb1_muxvals[] = {8, 8};
+static const int usb1_muxvals[] = {8, 8};
 static const unsigned usb2_pins[] = {60, 61};
-static const unsigned usb2_muxvals[] = {8, 8};
+static const int usb2_muxvals[] = {8, 8};
 static const unsigned usb3_pins[] = {62, 63};
-static const unsigned usb3_muxvals[] = {8, 8};
+static const int usb3_muxvals[] = {8, 8};
 static const unsigned port_range0_pins[] = {
 	127, 128, 129, 130, 131, 132, 133, 134,		/* PORT0x */
 	135, 136, 137, 138, 139, 140, 141, 142,		/* PORT1x */
@@ -784,7 +783,7 @@ static const unsigned port_range0_pins[] = {
 	61, 62, 63, 64, 65, 66, 67, 68,			/* PORT9x */
 	69, 70, 71, 76, 77, 78, 79, 80,			/* PORT10x */
 };
-static const unsigned port_range0_muxvals[] = {
+static const int port_range0_muxvals[] = {
 	15, 15, 15, 15, 15, 15, 15, 15,			/* PORT0x */
 	15, 15, 15, 15, 15, 15, 15, 15,			/* PORT1x */
 	15, 15, 15, 15, 15, 15, 15, 15,			/* PORT2x */
@@ -816,7 +815,7 @@ static const unsigned port_range1_pins[] = {
 	218, 219, 220, 221, 223, 224, 225, 226,		/* PORT27x */
 	227, 228, 229, 230, 231, 232, 233, 234,		/* PORT28x */
 };
-static const unsigned port_range1_muxvals[] = {
+static const int port_range1_muxvals[] = {
 	15, 15, 15, 15, 15, 15, 15, 15,			/* PORT12x */
 	15, 15, 15, 15, 15, 15, 15, 15,			/* PORT13x */
 	15, 15, 15, 15, 15, 15, 15, 15,			/* PORT14x */
@@ -840,7 +839,7 @@ static const unsigned xirq_pins[] = {
 	126, 72, 73, 92, 177, 93, 94, 176,		/* XIRQ8-15 */
 	74, 91, 27, 28, 29, 75, 20, 26,			/* XIRQ16-23 */
 };
-static const unsigned xirq_muxvals[] = {
+static const int xirq_muxvals[] = {
 	14, 14, 14, 14, 14, 14, 14, 14,			/* XIRQ0-7 */
 	14, 14, 14, 14, 14, 14, 14, 14,			/* XIRQ8-15 */
 	14, 14, 14, 14, 14, 14, 14, 14,			/* XIRQ16-23 */
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
index ef86693..d8b3655 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
@@ -431,39 +431,38 @@ static const struct pinctrl_pin_desc uniphier_sld8_pins[] = {
 };
 
 static const unsigned emmc_pins[] = {21, 22, 23, 24, 25, 26, 27};
-static const unsigned emmc_muxvals[] = {1, 1, 1, 1, 1, 1, 1};
+static const int emmc_muxvals[] = {1, 1, 1, 1, 1, 1, 1};
 static const unsigned emmc_dat8_pins[] = {28, 29, 30, 31};
-static const unsigned emmc_dat8_muxvals[] = {1, 1, 1, 1};
+static const int emmc_dat8_muxvals[] = {1, 1, 1, 1};
 static const unsigned i2c0_pins[] = {102, 103};
-static const unsigned i2c0_muxvals[] = {0, 0};
+static const int i2c0_muxvals[] = {0, 0};
 static const unsigned i2c1_pins[] = {104, 105};
-static const unsigned i2c1_muxvals[] = {0, 0};
+static const int i2c1_muxvals[] = {0, 0};
 static const unsigned i2c2_pins[] = {108, 109};
-static const unsigned i2c2_muxvals[] = {2, 2};
+static const int i2c2_muxvals[] = {2, 2};
 static const unsigned i2c3_pins[] = {108, 109};
-static const unsigned i2c3_muxvals[] = {3, 3};
+static const int i2c3_muxvals[] = {3, 3};
 static const unsigned nand_pins[] = {15, 16, 17, 18, 19, 20, 21, 24, 25, 26,
 				     27, 28, 29, 30, 31};
-static const unsigned nand_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-					0, 0};
+static const int nand_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned nand_cs1_pins[] = {22, 23};
-static const unsigned nand_cs1_muxvals[] = {0, 0};
+static const int nand_cs1_muxvals[] = {0, 0};
 static const unsigned sd_pins[] = {32, 33, 34, 35, 36, 37, 38, 39, 40};
-static const unsigned sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
+static const int sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned uart0_pins[] = {70, 71};
-static const unsigned uart0_muxvals[] = {3, 3};
+static const int uart0_muxvals[] = {3, 3};
 static const unsigned uart1_pins[] = {114, 115};
-static const unsigned uart1_muxvals[] = {0, 0};
+static const int uart1_muxvals[] = {0, 0};
 static const unsigned uart2_pins[] = {112, 113};
-static const unsigned uart2_muxvals[] = {1, 1};
+static const int uart2_muxvals[] = {1, 1};
 static const unsigned uart3_pins[] = {110, 111};
-static const unsigned uart3_muxvals[] = {1, 1};
+static const int uart3_muxvals[] = {1, 1};
 static const unsigned usb0_pins[] = {41, 42};
-static const unsigned usb0_muxvals[] = {0, 0};
+static const int usb0_muxvals[] = {0, 0};
 static const unsigned usb1_pins[] = {43, 44};
-static const unsigned usb1_muxvals[] = {0, 0};
+static const int usb1_muxvals[] = {0, 0};
 static const unsigned usb2_pins[] = {114, 115};
-static const unsigned usb2_muxvals[] = {1, 1};
+static const int usb2_muxvals[] = {1, 1};
 static const unsigned port_range0_pins[] = {
 	0, 1, 2, 3, 4, 5, 6, 7,				/* PORT0x */
 	8, 9, 10, 11, 12, 13, 14, 15,			/* PORT1x */
@@ -479,7 +478,7 @@ static const unsigned port_range0_pins[] = {
 	48, 49, 46, 45, 123, 124, 125, 126,		/* PORT11x */
 	47, 127, 20, 56, 22,				/* PORT120-124 */
 };
-static const unsigned port_range0_muxvals[] = {
+static const int port_range0_muxvals[] = {
 	15, 15, 15, 15, 15, 15, 15, 15,			/* PORT0x */
 	15, 15, 15, 15, 15, 15, 15, 15,			/* PORT1x */
 	15, 15, 15, 15, 15, 15, 15, 15,			/* PORT2x */
@@ -497,33 +496,33 @@ static const unsigned port_range0_muxvals[] = {
 static const unsigned port_range1_pins[] = {
 	116, 117,					/* PORT130-131 */
 };
-static const unsigned port_range1_muxvals[] = {
+static const int port_range1_muxvals[] = {
 	15, 15,						/* PORT130-131 */
 };
 static const unsigned port_range2_pins[] = {
 	102, 103, 104, 105, 106, 107, 108, 109,		/* PORT14x */
 };
-static const unsigned port_range2_muxvals[] = {
+static const int port_range2_muxvals[] = {
 	15, 15, 15, 15, 15, 15, 15, 15,			/* PORT14x */
 };
 static const unsigned port_range3_pins[] = {
 	23,						/* PORT166 */
 };
-static const unsigned port_range3_muxvals[] = {
+static const int port_range3_muxvals[] = {
 	15,						/* PORT166 */
 };
 static const unsigned xirq_range0_pins[] = {
 	128, 129, 130, 131, 132, 133, 134, 135,		/* XIRQ0-7 */
 	82, 87, 88, 50, 51,				/* XIRQ8-12 */
 };
-static const unsigned xirq_range0_muxvals[] = {
+static const int xirq_range0_muxvals[] = {
 	0, 0, 0, 0, 0, 0, 0, 0,				/* XIRQ0-7 */
 	14, 14, 14, 14, 14,				/* XIRQ8-12 */
 };
 static const unsigned xirq_range1_pins[] = {
 	52, 58,						/* XIRQ14-15 */
 };
-static const unsigned xirq_range1_muxvals[] = {
+static const int xirq_range1_muxvals[] = {
 	14, 14,						/* XIRQ14-15 */
 };
 
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier.h b/drivers/pinctrl/uniphier/pinctrl-uniphier.h
index 9941a4c..923f36c 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier.h
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier.h
@@ -148,7 +148,7 @@ struct uniphier_pinctrl_group {
 	const char *name;
 	const unsigned *pins;
 	unsigned num_pins;
-	const unsigned *muxvals;
+	const int *muxvals;
 	enum uniphier_pinmux_gpio_range_type range_type;
 };
 
-- 
1.9.1
