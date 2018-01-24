From: gurchetansingh@chromium.org (Gurchetan Singh)
Date: Tue, 23 Jan 2018 18:56:05 -0800
Subject: [PATCH 4/5] drm/vgem: flush page during page fault
In-Reply-To: <20180124025606.3020-2-gurchetansingh@chromium.org>
References: <20180124025606.3020-2-gurchetansingh@chromium.org>
Message-ID: <20180124025606.3020-4-gurchetansingh@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is required to use buffers allocated by vgem on AMD and ARM devices.
We're experiencing a case where eviction of the cache races with userspace
writes. To fix this, flush the cache after retrieving a page.

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
---
 drivers/gpu/drm/vgem/vgem_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
index 802a97e1a4bf..ed6db7218f04 100644
--- a/drivers/gpu/drm/vgem/vgem_drv.c
+++ b/drivers/gpu/drm/vgem/vgem_drv.c
@@ -112,6 +112,7 @@ static int vgem_gem_fault(struct vm_fault *vmf)
 				break;
 		}
 
+		drm_flush_pages(&page, 1);
 	}
 	return ret;
 }
-- 
2.13.5
