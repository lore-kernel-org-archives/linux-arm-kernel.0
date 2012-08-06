From: pieterg@gmx.com (pieterg at gmx.com)
Date: Mon,  6 Aug 2012 14:55:43 +0200
Subject: [PATCH] pxafb: fix BLW / ELW smart panel timing parameters
Message-ID: <1344257743-25692-1-git-send-email-pieterg@gmx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pieter Grimmerink <p.grimmerink@inepro.com>

The parameters were swapped;
LCCR1[BLW] configures rd_pulse_width and wr_pulse_width
LCCR1[ELW] configures a0csrd_set_hld and a0cswr_set_hld
---
 drivers/video/pxafb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 3f90255..04c395a 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -1230,18 +1230,18 @@ static unsigned int __smart_timing(unsigned time_ns, unsigned long lcd_clk)
 static void setup_smart_timing(struct pxafb_info *fbi,
 				struct fb_var_screeninfo *var)
 {
 	struct pxafb_mach_info *inf = fbi->dev->platform_data;
 	struct pxafb_mode_info *mode = &inf->modes[0];
 	unsigned long lclk = clk_get_rate(fbi->clk);
 	unsigned t1, t2, t3, t4;
 
-	t1 = max(mode->a0csrd_set_hld, mode->a0cswr_set_hld);
-	t2 = max(mode->rd_pulse_width, mode->wr_pulse_width);
+	t1 = max(mode->rd_pulse_width, mode->wr_pulse_width);
+	t2 = max(mode->a0csrd_set_hld, mode->a0cswr_set_hld);
 	t3 = mode->op_hold_time;
 	t4 = mode->cmd_inh_time;
 
 	fbi->reg_lccr1 =
 		LCCR1_DisWdth(var->xres) |
 		LCCR1_BegLnDel(__smart_timing(t1, lclk)) |
 		LCCR1_EndLnDel(__smart_timing(t2, lclk)) |
 		LCCR1_HorSnchWdth(__smart_timing(t3, lclk));
-- 
1.7.9.5
