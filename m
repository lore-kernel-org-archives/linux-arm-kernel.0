From: mchehab@s-opensource.com (Mauro Carvalho Chehab)
Date: Fri, 23 Mar 2018 08:57:20 -0400
Subject: [PATCH] media: fimc-capture: get rid of two warnings
Message-ID: <6ccd228e0cfce2a4f44558422d25c60fcb1a6710.1521809837.git.mchehab@s-opensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Smatch produces two warnings when building this file:
	./arch/x86/include/asm/bitops.h:433:22: warning: asm output is not an lvalue
	./arch/x86/include/asm/bitops.h:433:22: warning: asm output is not an lvalue

On some asm instructions.

I suspect that those asm instructions might not be producing the
right code, so, better to use two intermediate vars, get rid of
the warnings and of the risk of producing a wrong code.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 drivers/media/platform/exynos4-is/fimc-capture.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/exynos4-is/fimc-capture.c b/drivers/media/platform/exynos4-is/fimc-capture.c
index ed9302caa004..a3cdac188190 100644
--- a/drivers/media/platform/exynos4-is/fimc-capture.c
+++ b/drivers/media/platform/exynos4-is/fimc-capture.c
@@ -670,10 +670,13 @@ static void fimc_capture_try_selection(struct fimc_ctx *ctx,
 		return;
 	}
 	if (target == V4L2_SEL_TGT_COMPOSE) {
+		u32 tmp_min_h = ffs(sink->width) - 3;
+		u32 tmp_min_v = ffs(sink->height) - 1;
+
 		if (ctx->rotation != 90 && ctx->rotation != 270)
 			align_h = 1;
-		max_sc_h = min(SCALER_MAX_HRATIO, 1 << (ffs(sink->width) - 3));
-		max_sc_v = min(SCALER_MAX_VRATIO, 1 << (ffs(sink->height) - 1));
+		max_sc_h = min(SCALER_MAX_HRATIO, 1 << tmp_min_h);
+		max_sc_v = min(SCALER_MAX_VRATIO, 1 << tmp_min_v);
 		min_sz = var->min_out_pixsize;
 	} else {
 		u32 depth = fimc_get_format_depth(sink->fmt);
-- 
2.14.3
