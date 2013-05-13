From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Mon, 13 May 2013 13:49:13 +0800
Subject: [PATCH] [media] s5p-tv: fix error return code in mxr_acquire_video()
Message-ID: <CAPgLHd80d_pLtTbDQLEAMiLzfoF6AZ5fpjxtxqAoAZ1myNKw+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return a negative error code in the vb2_dma_contig_init_ctx()
error handling case instead of 0, as done elsewhere in this function.
Also vb2_dma_contig_init_ctx() return ERR_PTR() in case of error and
never return NULL, so use IS_ERR() replace IS_ERR_OR_NULL().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/media/platform/s5p-tv/mixer_video.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/s5p-tv/mixer_video.c b/drivers/media/platform/s5p-tv/mixer_video.c
index ef0efdf..641b1f0 100644
--- a/drivers/media/platform/s5p-tv/mixer_video.c
+++ b/drivers/media/platform/s5p-tv/mixer_video.c
@@ -81,8 +81,9 @@ int mxr_acquire_video(struct mxr_device *mdev,
 	}
 
 	mdev->alloc_ctx = vb2_dma_contig_init_ctx(mdev->dev);
-	if (IS_ERR_OR_NULL(mdev->alloc_ctx)) {
+	if (IS_ERR(mdev->alloc_ctx)) {
 		mxr_err(mdev, "could not acquire vb2 allocator\n");
+		ret = PTR_ERR(mdev->alloc_ctx);
 		goto fail_v4l2_dev;
 	}
 
