From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Wed, 11 Sep 2013 06:56:35 +0800
Subject: [PATCH] drm/exynos: fix return value check in
 lowlevel_buffer_allocate()
Message-ID: <CAPgLHd-vMjfQEBfun=c8j7x-FPx_pGoTvOBBwKtmF+LTQjVNQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function drm_prime_pages_to_sg() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should
be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/gpu/drm/exynos/exynos_drm_buf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_buf.c b/drivers/gpu/drm/exynos/exynos_drm_buf.c
index 3445a0f..e3ee833 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_buf.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_buf.c
@@ -90,9 +90,9 @@ static int lowlevel_buffer_allocate(struct drm_device *dev,
 	}
 
 	buf->sgt = drm_prime_pages_to_sg(buf->pages, nr_pages);
-	if (!buf->sgt) {
+	if (IS_ERR(buf->sgt)) {
 		DRM_ERROR("failed to get sg table.\n");
-		ret = -ENOMEM;
+		ret = PTR_ERR(buf->sgt);
 		goto err_free_attrs;
 	}
 
