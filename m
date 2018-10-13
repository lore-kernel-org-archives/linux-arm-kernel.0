From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Sat, 13 Oct 2018 12:56:54 +0200
Subject: [PATCH] drm/rockchip: psr: do not dereference encoder before it is
 null checked.
Message-ID: <20181013105654.11827-1-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'encoder' is deferenced before it is null sanity checked, hence we
potentially have a null pointer dereference bug. Instead, initialise
drm_drv from encoder->dev->dev_private after we are sure 'encoder' is
not null.

Fixes: 5182c1a556d7f ("drm/rockchip: add an common abstracted PSR driver")
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/gpu/drm/rockchip/rockchip_drm_psr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
index 1635485955d3..22a70ab6e214 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
@@ -226,12 +226,14 @@ EXPORT_SYMBOL(rockchip_drm_psr_flush_all);
 int rockchip_drm_psr_register(struct drm_encoder *encoder,
 			int (*psr_set)(struct drm_encoder *, bool enable))
 {
-	struct rockchip_drm_private *drm_drv = encoder->dev->dev_private;
+	struct rockchip_drm_private *drm_drv;
 	struct psr_drv *psr;
 
 	if (!encoder || !psr_set)
 		return -EINVAL;
 
+	drm_drv = encoder->dev->dev_private;
+
 	psr = kzalloc(sizeof(struct psr_drv), GFP_KERNEL);
 	if (!psr)
 		return -ENOMEM;
-- 
2.19.1
