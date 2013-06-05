From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:25:57 +0900
Subject: [PATCH 066/130] sh-pfc: r8a7740: Hardcode the LCDC0 output
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-67-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The r8a7740 has two LCDC units and two sets of LCDC output signals. By
default LCDC0 is routed to the LCD0 signals, and LCDC1 to the LCD1
signals. However, LCDC1 can be routed to the LCD0 signals by setting bit
MSEL6 in MSEL3CR (the LCD0 signals are further pinmuxed the usual way).

This could be configured by duplicating the LCD0 pin groups for LCDC1.
However, this would unnecessarily complicate the LCD pin groups, as no
r8a7740 board supported in mainline use such a configuration. Hardcode
the MSEL3CR MSEL6 bit to 0 for now.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index 5a77d39..9afc7b0 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -277,8 +277,6 @@ enum {
 	SCIFB_CTS_PORT173_MARK,
 
 	/* LCD0 */
-	LCDC0_SELECT_MARK,
-
 	LCD0_D0_MARK,	LCD0_D1_MARK,	LCD0_D2_MARK,	LCD0_D3_MARK,
 	LCD0_D4_MARK,	LCD0_D5_MARK,	LCD0_D6_MARK,	LCD0_D7_MARK,
 	LCD0_D8_MARK,	LCD0_D9_MARK,	LCD0_D10_MARK,	LCD0_D11_MARK,
@@ -301,8 +299,6 @@ enum {
 	LCD0_LCLK_PORT102_MARK,
 
 	/* LCD1 */
-	LCDC1_SELECT_MARK,
-
 	LCD1_D0_MARK,	LCD1_D1_MARK,	LCD1_D2_MARK,	LCD1_D3_MARK,
 	LCD1_D4_MARK,	LCD1_D5_MARK,	LCD1_D6_MARK,	LCD1_D7_MARK,
 	LCD1_D8_MARK,	LCD1_D9_MARK,	LCD1_D10_MARK,	LCD1_D11_MARK,
@@ -1002,7 +998,7 @@ static const pinmux_enum_t pinmux_data[] = {
 	PINMUX_DATA(IRQ27_PORT57_MARK,		PORT57_FN0,	MSEL1CR_27_1),
 
 	/* Port58 */
-	PINMUX_DATA(LCD0_D0_MARK,		PORT58_FN1),
+	PINMUX_DATA(LCD0_D0_MARK,		PORT58_FN1,	MSEL3CR_6_0),
 	PINMUX_DATA(KEYOUT7_MARK,		PORT58_FN3),
 	PINMUX_DATA(KEYIN0_PORT58_MARK,		PORT58_FN4,	MSEL4CR_18_1),
 	PINMUX_DATA(DV_D0_MARK,			PORT58_FN6),
@@ -1649,10 +1645,6 @@ static const pinmux_enum_t pinmux_data[] = {
 	PINMUX_DATA(IRQ16_PORT211_MARK,		PORT211_FN0,	MSEL1CR_16_1),
 	PINMUX_DATA(HDMI_CEC_MARK,		PORT211_FN1),
 
-	/* LCDC select */
-	PINMUX_DATA(LCDC0_SELECT_MARK,				MSEL3CR_6_0),
-	PINMUX_DATA(LCDC1_SELECT_MARK,				MSEL3CR_6_1),
-
 	/* SDENC */
 	PINMUX_DATA(SDENC_CPG_MARK,				MSEL4CR_19_0),
 	PINMUX_DATA(SDENC_DV_CLKI_MARK,				MSEL4CR_19_1),
@@ -3578,10 +3570,6 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	/* IRREM */
 	GPIO_FN(IROUT),
 
-	/* LCDC */
-	GPIO_FN(LCDC0_SELECT),
-	GPIO_FN(LCDC1_SELECT),
-
 	/* SDENC */
 	GPIO_FN(SDENC_CPG),
 	GPIO_FN(SDENC_DV_CLKI),
-- 
1.8.2.1
