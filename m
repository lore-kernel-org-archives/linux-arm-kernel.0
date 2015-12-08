From: linux@rasmusvillemoes.dk (Rasmus Villemoes)
Date: Tue,  8 Dec 2015 15:15:54 +0100
Subject: [PATCH] [media] exynos4-is: fix a format string bug
Message-ID: <1449584155-20644-1-git-send-email-linux@rasmusvillemoes.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ironically, 7d4020c3c400 ("[media] exynos4-is: fix some warnings when
compiling on arm64") fixed some format string bugs but introduced a
new one. buf_index is a simple int, so it should be printed with %d,
not %pad (which is correctly used for dma_addr_t).

Fixes: 7d4020c3c400 ("[media] exynos4-is: fix some warnings when compiling on arm64")
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/media/platform/exynos4-is/fimc-isp-video.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/exynos4-is/fimc-isp-video.c b/drivers/media/platform/exynos4-is/fimc-isp-video.c
index 6e6648446f00..337d49b4d103 100644
--- a/drivers/media/platform/exynos4-is/fimc-isp-video.c
+++ b/drivers/media/platform/exynos4-is/fimc-isp-video.c
@@ -221,8 +221,8 @@ static void isp_video_capture_buffer_queue(struct vb2_buffer *vb)
 							ivb->dma_addr[i];
 
 			isp_dbg(2, &video->ve.vdev,
-				"dma_buf %pad (%d/%d/%d) addr: %pad\n",
-				&buf_index, ivb->index, i, vb->index,
+				"dma_buf %d (%d/%d/%d) addr: %pad\n",
+				buf_index, ivb->index, i, vb->index,
 				&ivb->dma_addr[i]);
 		}
 
-- 
2.6.1
