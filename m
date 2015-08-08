From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 08 Aug 2015 17:10:32 +0100
Subject: [PATCH 6/9] drm: bridge/dw_hdmi: adjust pixel clock values in N
 calculation
In-Reply-To: <20150808160936.GN7557@n2100.arm.linux.org.uk>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZO6hc-0003NW-55@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adjust the pixel clock values in the N calculation to match the more
accurate clock values we're given by the DRM subsystem, which are the
kHz pixel rate, with any fractional kHz rounded down in the case of
the non-240, non-480 line modes, or rounded up for the others.  So,

	 25.20 / 1.001 =>  25175
	 27.00 * 1.001 =>  27027
	 74.25 / 1.001 =>  74176
	148.50 / 1.001 => 148352

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/bridge/dw_hdmi.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index f0e6059f818a..5576cd7d7abb 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -230,11 +230,11 @@ static unsigned int hdmi_compute_n(unsigned int freq, unsigned long pixel_clk,
 
 	switch (freq) {
 	case 32000:
-		if (pixel_clk == 25170000)
+		if (pixel_clk == 25175000)
 			n = (ratio == 150) ? 9152 : 4576;
-		else if (pixel_clk == 27020000)
+		else if (pixel_clk == 27027000)
 			n = (ratio == 150) ? 8192 : 4096;
-		else if (pixel_clk == 74170000 || pixel_clk == 148350000)
+		else if (pixel_clk == 74176000 || pixel_clk == 148352000)
 			n = 11648;
 		else
 			n = 4096;
@@ -242,11 +242,11 @@ static unsigned int hdmi_compute_n(unsigned int freq, unsigned long pixel_clk,
 		break;
 
 	case 44100:
-		if (pixel_clk == 25170000)
+		if (pixel_clk == 25175000)
 			n = 7007;
-		else if (pixel_clk == 74170000)
+		else if (pixel_clk == 74176000)
 			n = 17836;
-		else if (pixel_clk == 148350000)
+		else if (pixel_clk == 148352000)
 			n = (ratio == 150) ? 17836 : 8918;
 		else
 			n = 6272;
@@ -254,13 +254,13 @@ static unsigned int hdmi_compute_n(unsigned int freq, unsigned long pixel_clk,
 		break;
 
 	case 48000:
-		if (pixel_clk == 25170000)
+		if (pixel_clk == 25175000)
 			n = (ratio == 150) ? 9152 : 6864;
-		else if (pixel_clk == 27020000)
+		else if (pixel_clk == 27027000)
 			n = (ratio == 150) ? 8192 : 6144;
-		else if (pixel_clk == 74170000)
+		else if (pixel_clk == 74176000)
 			n = 11648;
-		else if (pixel_clk == 148350000)
+		else if (pixel_clk == 148352000)
 			n = (ratio == 150) ? 11648 : 5824;
 		else
 			n = 6144;
-- 
2.1.0
