From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Thu, 29 Sep 2016 11:29:49 +0800
Subject: [PATCH 2/2] drm/mediatek: clear IRQ status before enable OVL interrupt
In-Reply-To: <1475119789-64619-1-git-send-email-bibby.hsieh@mediatek.com>
References: <1475119789-64619-1-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <1475119789-64619-3-git-send-email-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To make sure that the first vblank IRQ after enabling
vblank isn't too short or immediate, we have to clear
the IRQ status before enable OVL interrupt.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 019b7ca..f75c5b5 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -80,6 +80,7 @@ static void mtk_ovl_enable_vblank(struct mtk_ddp_comp *comp,
 						 ddp_comp);
 
 	priv->crtc = crtc;
+	writel(0x0, comp->regs + DISP_REG_OVL_INTSTA);
 	writel_relaxed(OVL_FME_CPL_INT, comp->regs + DISP_REG_OVL_INTEN);
 }
 
-- 
1.7.9.5
