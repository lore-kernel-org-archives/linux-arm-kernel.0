From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 08 Aug 2015 17:10:27 +0100
Subject: [PATCH 5/9] drm: bridge/dw_hdmi: avoid being recursive in N
 calculation
In-Reply-To: <20150808160936.GN7557@n2100.arm.linux.org.uk>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZO6hX-0003NK-0H@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no need to be recursive when computing the N value for the ACR
packet - we can instead calculate the multiplier prior to our switch()
based lookup, and multiply the N value appropriately afterwards.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/bridge/dw_hdmi.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index a8b243278774..f0e6059f818a 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -221,6 +221,12 @@ static unsigned int hdmi_compute_n(unsigned int freq, unsigned long pixel_clk,
 				   unsigned int ratio)
 {
 	unsigned int n = (128 * freq) / 1000;
+	unsigned int mult = 1;
+
+	while (freq > 48000) {
+		mult *= 2;
+		freq /= 2;
+	}
 
 	switch (freq) {
 	case 32000:
@@ -232,6 +238,7 @@ static unsigned int hdmi_compute_n(unsigned int freq, unsigned long pixel_clk,
 			n = 11648;
 		else
 			n = 4096;
+		n *= mult;
 		break;
 
 	case 44100:
@@ -243,6 +250,7 @@ static unsigned int hdmi_compute_n(unsigned int freq, unsigned long pixel_clk,
 			n = (ratio == 150) ? 17836 : 8918;
 		else
 			n = 6272;
+		n *= mult;
 		break;
 
 	case 48000:
@@ -256,22 +264,7 @@ static unsigned int hdmi_compute_n(unsigned int freq, unsigned long pixel_clk,
 			n = (ratio == 150) ? 11648 : 5824;
 		else
 			n = 6144;
-		break;
-
-	case 88200:
-		n = hdmi_compute_n(44100, pixel_clk, ratio) * 2;
-		break;
-
-	case 96000:
-		n = hdmi_compute_n(48000, pixel_clk, ratio) * 2;
-		break;
-
-	case 176400:
-		n = hdmi_compute_n(44100, pixel_clk, ratio) * 4;
-		break;
-
-	case 192000:
-		n = hdmi_compute_n(48000, pixel_clk, ratio) * 4;
+		n *= mult;
 		break;
 
 	default:
-- 
2.1.0
