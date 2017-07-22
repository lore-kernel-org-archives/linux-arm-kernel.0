From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 22 Jul 2017 10:50:53 +0800
Subject: [PATCH v3 1/2] pinctrl: sunxi: add a missing function of A10/A20
 pinctrl driver
In-Reply-To: <20170722025054.32645-1-icenowy@aosc.io>
References: <20170722025054.32645-1-icenowy@aosc.io>
Message-ID: <20170722025054.32645-2-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PH16 pin has a function with mux id 0x5, which is the DET pin of the
"sim" (smart card reader) IP block.

This function is missing in old versions of A10/A20 SoCs' datasheets and
user manuals, so it's also missing in the old drivers. The newest A10
Datasheet V1.70 and A20 Datasheet V1.41 contain this pin function, and
it's discovered during implementing R40 pinctrl driver.

Add it to the driver. As we now merged A20 pinctrl driver to the A10
one, we need to only fix the A10 driver now.

Fixes: f2821b1ca3a2 ("pinctrl: sunxi: Move Allwinner A10 pinctrl
driver to a driver of its own")

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
Changes in v3:
- Added Chen-Yu's review tag.
- Added fix tag suggested by Chen-Yu.
Changes in v2:
- Commit message changes. (mentioning the datasheet versions which are
  used to discover this pin function.)

 drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
index 159580c04b14..47a392bc73c8 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
@@ -918,6 +918,7 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ETXD1 */
 					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* IN6 */
+		  SUNXI_FUNCTION(0x5, "sim"),		/* DET */
 		  SUNXI_FUNCTION_IRQ(0x6, 16),		/* EINT16 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* D16 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 17),
-- 
2.13.0
