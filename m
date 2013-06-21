From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 21 Jun 2013 10:57:20 +0200
Subject: [PATCH 3/4] staging: drm/imx: ipuv3-crtc: immediately update crtc->fb
 in ipu_page_flip
In-Reply-To: <1371805041-9299-1-git-send-email-p.zabel@pengutronix.de>
References: <1371805041-9299-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1371805041-9299-4-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 8cf1e9811471f2910fa38dc1b28e1789080ba961
("drm: Add consistency check for page-flipping") drm_mode_page_flip_ioctl
contains a WARN_ON that triggers if the .page_flip callback didn't update
the crtc->fb pointer to the new framebuffer immediately.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/imx-drm/ipuv3-crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/imx-drm/ipuv3-crtc.c b/drivers/staging/imx-drm/ipuv3-crtc.c
index abcdaef..4a7eedf 100644
--- a/drivers/staging/imx-drm/ipuv3-crtc.c
+++ b/drivers/staging/imx-drm/ipuv3-crtc.c
@@ -147,6 +147,7 @@ static int ipu_page_flip(struct drm_crtc *crtc,
 
 	ipu_crtc->newfb = fb;
 	ipu_crtc->page_flip_event = event;
+	crtc->fb = fb;
 
 	return 0;
 }
@@ -329,7 +330,6 @@ static irqreturn_t ipu_irq_handler(int irq, void *dev_id)
 	imx_drm_handle_vblank(ipu_crtc->imx_crtc);
 
 	if (ipu_crtc->newfb) {
-		ipu_crtc->base.fb = ipu_crtc->newfb;
 		ipu_crtc->newfb = NULL;
 		ipu_drm_set_base(&ipu_crtc->base, 0, 0);
 		ipu_crtc_handle_pageflip(ipu_crtc);
-- 
1.8.3.1
