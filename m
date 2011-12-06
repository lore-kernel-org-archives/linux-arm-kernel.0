From: LW@KARO-electronics.de (=?utf-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue,  6 Dec 2011 13:27:05 +0100
Subject: [BUGFIX] video/mxsfb: fix crash when unblanking the display
Message-ID: <1323174425-24038-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VDCTRL4 register does not provide the MXS SET/CLR/TOGGLE feature.
The write in mxsfb_disable_controller() sets the data_cnt for the LCD
DMA to 0 which obviously means the max. count for the LCD DMA and
leads to overwriting arbitrary memory when the display is unblanked.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 drivers/video/mxsfb.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index d837d63..03cb95a 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -366,7 +366,8 @@ static void mxsfb_disable_controller(struct fb_info *fb_info)
 		loop--;
 	}
 
-	writel(VDCTRL4_SYNC_SIGNALS_ON, host->base + LCDC_VDCTRL4 + REG_CLR);
+	reg = readl(host->base + LCDC_VDCTRL4);
+	writel(reg & ~VDCTRL4_SYNC_SIGNALS_ON, host->base + LCDC_VDCTRL4);
 
 	clk_disable(host->clk);
 
-- 
1.5.6.5
