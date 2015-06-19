From: ykk@rock-chips.com (Yakir Yang)
Date: Sat, 20 Jun 2015 00:19:12 +0800
Subject: [PATCH v5 1/6] drm: bridge/dw_hdmi: add audio support for more
 display resolutions
In-Reply-To: <1434730417-10629-1-git-send-email-ykk@rock-chips.com>
References: <1434730417-10629-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1434730752-10829-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just like HDMISpecification 1.4 document descripted, the soure shall
determine the fractional relationship between the TMDS clock an an
audio reference clock, the sink may then recreate the audio clock from
the TMDS clock by using an clock divider. So if we can make sink generate
the correct samplerate, then we can say those display resolutions with
this pixelclock could support audio play.

The exact relationship between the two clocks will be:
	128 * SampleRate = TmdsClock * N / CTS.
So this patch would generate the correct N/CTS values, add audio support
for the below  tmds clocks:
25.175MHz, 40MHz, 54MHz, 65MHz, 74.25MHz, 83.5MHz, 106.5MHz, 108Mhz

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v5:
- make more words in commit message.

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/gpu/drm/bridge/dw_hdmi.c | 56 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index dc0aed1..f717a2a 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -222,8 +222,24 @@ static unsigned int hdmi_compute_n(unsigned int freq, unsigned long pixel_clk,
 	case 44100:
 		if (pixel_clk == 25170000)
 			n = 7007;
+		else if (pixel_clk == 25175000)
+			n = 28224;
+		else if (pixel_clk == 40000000)
+			n = 7056;
+		else if (pixel_clk == 54000000)
+			n = 6272;
+		else if (pixel_clk == 65000000)
+			n = 7056;
 		else if (pixel_clk == 74170000)
 			n = 17836;
+		else if (pixel_clk == 74250000)
+			n = 6272;
+		else if (pixel_clk == 83500000)
+			n = 7056;
+		else if (pixel_clk == 106500000)
+			n = 4074;
+		else if (pixel_clk == 108000000)
+			n = 4018;
 		else if (pixel_clk == 148350000)
 			n = (ratio == 150) ? 17836 : 8918;
 		else
@@ -233,10 +249,26 @@ static unsigned int hdmi_compute_n(unsigned int freq, unsigned long pixel_clk,
 	case 48000:
 		if (pixel_clk == 25170000)
 			n = (ratio == 150) ? 9152 : 6864;
+		else if (pixel_clk == 25175000)
+			n = 6144;
 		else if (pixel_clk == 27020000)
 			n = (ratio == 150) ? 8192 : 6144;
+		else if (pixel_clk == 40000000)
+			n = 6144;
+		else if (pixel_clk == 54000000)
+			n = 6144;
+		else if (pixel_clk == 65000000)
+			n = 6144;
 		else if (pixel_clk == 74170000)
 			n = 11648;
+		else if (pixel_clk == 74250000)
+			n = 6144;
+		else if (pixel_clk == 83500000)
+			n = 6144;
+		else if (pixel_clk == 106500000)
+			n = 6144;
+		else if (pixel_clk == 108000000)
+			n = 6144;
 		else if (pixel_clk == 148350000)
 			n = (ratio == 150) ? 11648 : 5824;
 		else
@@ -284,10 +316,16 @@ static unsigned int hdmi_compute_cts(unsigned int freq, unsigned long pixel_clk,
 	case 96000:
 	case 192000:
 		switch (pixel_clk) {
+		case 25175000:
 		case 25200000:
 		case 27000000:
+		case 40000000:
 		case 54000000:
+		case 65000000:
 		case 74250000:
+		case 83500000:
+		case 106500000:
+		case 108000000:
 		case 148500000:
 			cts = pixel_clk / 1000;
 			break;
@@ -308,18 +346,36 @@ static unsigned int hdmi_compute_cts(unsigned int freq, unsigned long pixel_clk,
 	case 88200:
 	case 176400:
 		switch (pixel_clk) {
+		case 25175000:
+			cts = 125875;
+			break;
 		case 25200000:
 			cts = 28000;
 			break;
 		case 27000000:
 			cts = 30000;
 			break;
+		case 40000000:
+			cts = 50000;
+			break;
 		case 54000000:
 			cts = 60000;
 			break;
+		case 65000000:
+			cts = 81250;
+			break;
 		case 74250000:
 			cts = 82500;
 			break;
+		case 83500000:
+			cts = 104375;
+			break;
+		case 106500000:
+			cts = 88750;
+			break;
+		case 108000000:
+			cts = 76875;
+			break;
 		case 148500000:
 			cts = 165000;
 			break;
-- 
2.1.2
