From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 30 Sep 2015 13:36:10 +0100
Subject: [PATCH 3/4] nvmem: core: Fix memory leak in nvmem_cell_write
In-Reply-To: <1443616298-17389-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1443616298-17389-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1443616570-17825-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Axel Lin <axel.lin@ingics.com>

A tmp buffer is allocated if cell->bit_offset || cell->nbits.
So the tmp buffer needs to be freed at the same condition to avoid leak.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 676607c..6fd4e5a 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -938,7 +938,7 @@ int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len)
 	rc = regmap_raw_write(nvmem->regmap, cell->offset, buf, cell->bytes);
 
 	/* free the tmp buffer */
-	if (cell->bit_offset)
+	if (cell->bit_offset || cell->nbits)
 		kfree(buf);
 
 	if (IS_ERR_VALUE(rc))
-- 
1.9.1
