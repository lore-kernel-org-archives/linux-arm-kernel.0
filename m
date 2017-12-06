From: flavio.ceolin@intel.com (Flavio Ceolin)
Date: Wed,  6 Dec 2017 08:37:45 -0800
Subject: [PATCH] media: s5p-jpeg: Fix off-by-one problem
Message-ID: <20171206163746.8456-1-flavio.ceolin@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s5p_jpeg_runtime_resume() does not call clk_disable_unprepare() for
jpeg->clocks[0] when one of the clk_prepare_enable() fails.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Flavio Ceolin <flavio.ceolin@intel.com>
---
 drivers/media/platform/s5p-jpeg/jpeg-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/s5p-jpeg/jpeg-core.c b/drivers/media/platform/s5p-jpeg/jpeg-core.c
index faac816..79b63da 100644
--- a/drivers/media/platform/s5p-jpeg/jpeg-core.c
+++ b/drivers/media/platform/s5p-jpeg/jpeg-core.c
@@ -3086,7 +3086,7 @@ static int s5p_jpeg_runtime_resume(struct device *dev)
 	for (i = 0; i < jpeg->variant->num_clocks; i++) {
 		ret = clk_prepare_enable(jpeg->clocks[i]);
 		if (ret) {
-			while (--i > 0)
+			while (--i >= 0)
 				clk_disable_unprepare(jpeg->clocks[i]);
 			return ret;
 		}
-- 
2.9.5
