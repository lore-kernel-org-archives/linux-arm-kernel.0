From: andrzej.p@samsung.com (Andrzej Pietrasiewicz)
Date: Tue, 08 Aug 2017 13:27:08 +0200
Subject: [PATCH 5/5] media: platform: s5p-jpeg: directly use parsed subsampling
 on 5433
In-Reply-To: <1502191628-11958-1-git-send-email-andrzej.p@samsung.com>
References: <1502191352-11595-1-git-send-email-andrzej.p@samsung.com>
 <1502191628-11958-1-git-send-email-andrzej.p@samsung.com>
 <CGME20170808112717eucas1p21f42a5991fc862df2d010a7ccfae634b@eucas1p2.samsung.com>
Message-ID: <1502191628-11958-5-git-send-email-andrzej.p@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5433 variant JPEG data is parsed by hardware only from SOS marker,
so subsampling is parsed by software. As such, its value need not be
translated from hardware-specific encoding to V4L2 encoding.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
---
 drivers/media/platform/s5p-jpeg/jpeg-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/s5p-jpeg/jpeg-core.c b/drivers/media/platform/s5p-jpeg/jpeg-core.c
index 492fab1..0225c82 100644
--- a/drivers/media/platform/s5p-jpeg/jpeg-core.c
+++ b/drivers/media/platform/s5p-jpeg/jpeg-core.c
@@ -627,10 +627,11 @@ static int s5p_jpeg_to_user_subsampling(struct s5p_jpeg_ctx *ctx)
 			return V4L2_JPEG_CHROMA_SUBSAMPLING_411;
 		return exynos3250_decoded_subsampling[ctx->subsampling];
 	case SJPEG_EXYNOS4:
-	case SJPEG_EXYNOS5433:
 		if (ctx->subsampling > 2)
 			return V4L2_JPEG_CHROMA_SUBSAMPLING_420;
 		return exynos4x12_decoded_subsampling[ctx->subsampling];
+	case SJPEG_EXYNOS5433:
+		return ctx->subsampling; /* parsed from header */
 	default:
 		return V4L2_JPEG_CHROMA_SUBSAMPLING_GRAY;
 	}
-- 
1.9.1
