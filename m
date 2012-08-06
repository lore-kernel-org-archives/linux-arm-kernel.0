From: pieterg@gmx.com (pieterg at gmx.com)
Date: Mon,  6 Aug 2012 14:56:18 +0200
Subject: [PATCH] pxafb: allow zero for smart panel timings
Message-ID: <1344257778-25737-1-git-send-email-pieterg@gmx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pieter Grimmerink <p.grimmerink@inepro.com>

The LCCR1[BLW] description states:
"For LCD panels with an internal frame buffer, BLW
specifies the pulse width of the Write or Read signal
(...) which is equal to (BLW+1)*LCD_CLK_PERIOD"

And the LCD Smart Panel Timing Specifications states:
"L_PCLK_WR pulse width duration:
Min: 1
Typical: LCCR1[BLW] + 1
Max: 256
Units: LCLK"

The BLW field has a value range of 0 to 255, resulting in
a write or read pulse width range of
1*LCD_CLK_PERIOD..256*LCD_CLK_PERIOD

So LCCR1[BLW] = 0 is a valid configuration.
The same is the case for LCCR1[ELW] and LCCR3[PCD],
the other two smart panel timing values.
---
 drivers/video/pxafb.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 04c395a..7ea5e23 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -1223,8 +1223,7 @@ int pxafb_smart_queue(struct fb_info *info, uint16_t *cmds, int n_cmds)
 
 static unsigned int __smart_timing(unsigned time_ns, unsigned long lcd_clk)
 {
-	unsigned int t = (time_ns * (lcd_clk / 1000000) / 1000);
-	return (t == 0) ? 1 : t;
+	return time_ns * (lcd_clk / 1000000) / 1000;
 }
 
 static void setup_smart_timing(struct pxafb_info *fbi,
-- 
1.7.9.5
