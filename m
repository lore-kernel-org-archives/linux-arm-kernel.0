From: matthias.bgg@kernel.org (matthias.bgg at kernel.org)
Date: Tue, 17 Jul 2018 23:59:51 +0200
Subject: [PATCH v4--to=ulrich.hecht+renesas@gmail.com 5/5] drm: mediatek: Omit
 warning on probe defers
In-Reply-To: <20180717215951.378-1-matthias.bgg@kernel.org>
References: <20180717215951.378-1-matthias.bgg@kernel.org>
Message-ID: <20180717215951.378-6-matthias.bgg@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthias Brugger <mbrugger@suse.com>

It can happen that the clock drivers wasn't probed before the
ddp driver gets invoked. The driver used to omit a warning
that the driver failed to get the clocks. Omit this error on
the defered probe path.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Acked-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index bafc5c77c4fb..6b399348a2dc 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -374,7 +374,8 @@ static int mtk_ddp_probe(struct platform_device *pdev)
 
 	ddp->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(ddp->clk)) {
-		dev_err(dev, "Failed to get clock\n");
+		if (PTR_ERR(ddp->clk) != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get clock\n");
 		return PTR_ERR(ddp->clk);
 	}
 
-- 
2.17.1
