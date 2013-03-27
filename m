From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 27 Mar 2013 22:59:40 +0900
Subject: [PATCH] fbdev: sh_mobile_lcdc: fixup B side hsync adjust settings
In-Reply-To: <1364392780-3847-1-git-send-email-horms+renesas@verge.net.au>
References: <1364392780-3847-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364392780-3847-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

The lcdc B side horizon output is shifted
if sh_mobile_lcdc_pan() was called.
This patch fixup this issue.
It is tested on R8A7740 Armadillo800eva HDMI output.
Special thanks to Fukushima-san, and Sano-san

Reported-by: Osamu Fukushima <osamu.fukushima.wr@renesas.com>
Signed-off-by: Hideyuki Sano <hideyuki.sano.dn@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/video/sh_mobile_lcdcfb.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 63203ac..0264704 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -858,6 +858,7 @@ static void sh_mobile_lcdc_geometry(struct sh_mobile_lcdc_chan *ch)
 	tmp = ((mode->xres & 7) << 24) | ((display_h_total & 7) << 16)
 	    | ((mode->hsync_len & 7) << 8) | (hsync_pos & 7);
 	lcdc_write_chan(ch, LDHAJR, tmp);
+	lcdc_write_chan_mirror(ch, LDHAJR, tmp);
 }
 
 static void sh_mobile_lcdc_overlay_setup(struct sh_mobile_lcdc_overlay *ovl)
-- 
1.7.10.4
