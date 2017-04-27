From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 27 Apr 2017 21:46:28 +0200
Subject: [PATCH 1/2] coresight-stm: Use devm_kcalloc() in stm_probe()
In-Reply-To: <52619d05-65c4-149d-f355-cf9c037a0c9b@users.sourceforge.net>
References: <52619d05-65c4-149d-f355-cf9c037a0c9b@users.sourceforge.net>
Message-ID: <47e6431f-1093-3a58-3ca4-406284c081aa@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 27 Apr 2017 21:18:57 +0200

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus use the corresponding function "devm_kcalloc".

  This issue was detected by using the Coccinelle software.

* Delete the local variable "bitmap_size" which became unnecessary
  with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hwtracing/coresight/coresight-stm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 93fc26f01bab..bbb5275bf0d2 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -799,7 +799,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 	struct stm_drvdata *drvdata;
 	struct resource *res = &adev->res;
 	struct resource ch_res;
-	size_t res_size, bitmap_size;
+	size_t res_size;
 	struct coresight_desc desc = { 0 };
 	struct device_node *np = adev->dev.of_node;
 
@@ -848,9 +848,9 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 		res_size = min((resource_size_t)(drvdata->numsp *
 				 BYTES_PER_CHANNEL), resource_size(res));
 	}
-	bitmap_size = BITS_TO_LONGS(drvdata->numsp) * sizeof(long);
 
-	guaranteed = devm_kzalloc(dev, bitmap_size, GFP_KERNEL);
+	guaranteed = devm_kcalloc(dev, BITS_TO_LONGS(drvdata->numsp),
+				  sizeof(long), GFP_KERNEL);
 	if (!guaranteed)
 		return -ENOMEM;
 	drvdata->chs.guaranteed = guaranteed;
-- 
2.12.2
