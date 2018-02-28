From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Wed, 28 Feb 2018 17:46:53 +0100
Subject: [PATCH] drm/sun4i: Fix dclk_set_phase
Message-ID: <1519836413-35023-1-git-send-email-giulio.benetti@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Phase value is not shifted before writing.

Shift left of 28 bits to fit right bits

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/gpu/drm/sun4i/sun4i_dotclock.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_dotclock.c b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
index 023f39b..e36004f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_dotclock.c
+++ b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
@@ -132,10 +132,13 @@ static int sun4i_dclk_get_phase(struct clk_hw *hw)
 static int sun4i_dclk_set_phase(struct clk_hw *hw, int degrees)
 {
 	struct sun4i_dclk *dclk = hw_to_dclk(hw);
+	u32 val = degrees / 120;
+
+	val <<= 28;
 
 	regmap_update_bits(dclk->regmap, SUN4I_TCON0_IO_POL_REG,
 			   GENMASK(29, 28),
-			   degrees / 120);
+			   val);
 
 	return 0;
 }
-- 
2.7.4
