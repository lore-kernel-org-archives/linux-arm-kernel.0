From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 11 May 2017 11:09:55 +0100
Subject: [PATCH] drm/hisilicon: Ensure LDI regs are properly configured.
Message-ID: <1494497395-20594-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following soft lockup:
  BUG: soft lockup - CPU#0 stuck for 23s! [weston:307]

On weston idle-timeout the IP is powered down and reset
asserted. On weston resume we get a massive vblank
IRQ storm due to the LDI registers having lost some state.

This state loss is caused by ade_crtc_atomic_begin() not
calling ade_ldi_set_mode(). With this patch applied
resuming from Weston idle-timeout works well.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 9a0678a..c09600c 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -521,9 +521,12 @@ static void ade_crtc_atomic_begin(struct drm_crtc *crtc,
 {
 	struct ade_crtc *acrtc = to_ade_crtc(crtc);
 	struct ade_hw_ctx *ctx = acrtc->ctx;
+	struct drm_display_mode *mode = &crtc->state->mode;
+	struct drm_display_mode *adj_mode = &crtc->state->adjusted_mode;
 
 	if (!ctx->power_on)
 		(void)ade_power_up(ctx);
+	ade_ldi_set_mode(acrtc, mode, adj_mode);
 }
 
 static void ade_crtc_atomic_flush(struct drm_crtc *crtc,
-- 
2.7.4
