From: net147@gmail.com (Jonathan Liu)
Date: Tue, 26 Dec 2017 22:12:27 +1100
Subject: [PATCH v2 3/3] drm/sun4i: hdmi: Add missing rate halving check in
 sun4i_tmds_determine_rate
In-Reply-To: <20171226111227.4526-1-net147@gmail.com>
References: <20171226111227.4526-1-net147@gmail.com>
Message-ID: <20171226111227.4526-4-net147@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It was only checking the divider when determing the closest match if
it could not match the requested rate exactly.

For a projector connected to an Olimex A20-OLinuXino-LIME using HDMI
with a native resolution of 1280x800 and pixel clock of 83.5 MHz, this
resulted in 1280x800 mode not being available and the following in dmesg
when the kernel is booted with drm.debug=0x3e:
[drm:drm_mode_debug_printmodeline] Modeline 37:"1280x800" 60 83500 1280 1352 1480 1680 800 810 816 831 0x48 0x5
[drm:drm_mode_prune_invalid] Not using 1280x800 mode: NOCLOCK

Fixes: 9c5681011a0c ("drm/sun4i: Add HDMI support")
Signed-off-by: Jonathan Liu <net147@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
index 88eeeaf34638..3ecffa52c814 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
@@ -102,9 +102,12 @@ static int sun4i_tmds_determine_rate(struct clk_hw *hw,
 					goto out;
 				}
 
-				if (!best_parent || abs(rate - rounded / i) <
-				    abs(rate - best_parent / best_div)) {
+				if (!best_parent ||
+				    abs(rate - rounded / i / j) <
+				    abs(rate - best_parent / best_half /
+					best_div)) {
 					best_parent = rounded;
+					best_half = i;
 					best_div = j;
 				}
 			}
-- 
2.15.0
