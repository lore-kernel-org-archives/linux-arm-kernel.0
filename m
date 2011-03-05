From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 6 Mar 2011 00:18:50 +0800
Subject: [PATCH 2/3] video: mxsfb: fix the incorrect error checking for
	alloc_pages_exact
In-Reply-To: <1299341931-30241-1-git-send-email-shawn.guo@freescale.com>
References: <1299341931-30241-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1299341931-30241-3-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fb_virt than fb_info->screen_base should be checked here, or the path
of framebuffer allocation always ends up with 'return -ENOMEM'.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 drivers/video/mxsfb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 8a57f8b..927a682 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -717,7 +717,7 @@ static int __devinit mxsfb_init_fbinfo(struct mxsfb_info *host)
 		if (!fb_size)
 			fb_size = SZ_2M; /* default */
 		fb_virt = alloc_pages_exact(fb_size, GFP_DMA);
-		if (!fb_info->screen_base)
+		if (!fb_virt)
 			return -ENOMEM;
 
 		fb_phys = virt_to_phys(fb_virt);
-- 
1.7.1
