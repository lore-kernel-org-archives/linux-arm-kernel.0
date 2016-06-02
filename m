From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu,  2 Jun 2016 16:31:42 +0200
Subject: [PATCH 15/20] drm: virtgpu: Rely on the default ->best_encoder()
 behavior
In-Reply-To: <1464877907-27723-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1464877907-27723-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1464877907-27723-16-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The virtgpu output exposes a 1:1 relationship between connectors and
encoders and the driver is relying on the atomic helpers: we can drop
the custom ->best_encoder() implementation and let the core call
drm_atomic_helper_best_encoder() for us.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index d4305da..4d41dcb 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -341,15 +341,6 @@ static int virtio_gpu_conn_mode_valid(struct drm_connector *connector,
 	return MODE_BAD;
 }
 
-static struct drm_encoder*
-virtio_gpu_best_encoder(struct drm_connector *connector)
-{
-	struct virtio_gpu_output *virtio_gpu_output =
-		drm_connector_to_virtio_gpu_output(connector);
-
-	return &virtio_gpu_output->enc;
-}
-
 static const struct drm_encoder_helper_funcs virtio_gpu_enc_helper_funcs = {
 	.mode_set   = virtio_gpu_enc_mode_set,
 	.enable     = virtio_gpu_enc_enable,
@@ -359,7 +350,6 @@ static const struct drm_encoder_helper_funcs virtio_gpu_enc_helper_funcs = {
 static const struct drm_connector_helper_funcs virtio_gpu_conn_helper_funcs = {
 	.get_modes    = virtio_gpu_conn_get_modes,
 	.mode_valid   = virtio_gpu_conn_mode_valid,
-	.best_encoder = virtio_gpu_best_encoder,
 };
 
 static enum drm_connector_status virtio_gpu_conn_detect(
-- 
2.7.4
