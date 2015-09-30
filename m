From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 30 Sep 2015 13:35:15 +0100
Subject: [PATCH 2/4] nvmem: core: Handle shift bits in-place if cell->nbits is
 non-zero
In-Reply-To: <1443616298-17389-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1443616298-17389-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1443616515-17763-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Axel Lin <axel.lin@ingics.com>

It's pointless to test (cell->bit_offset || cell->bit_offset).
nvmem_shift_read_buffer_in_place() should be called when
(cell->bit_offset || cell->nbits).

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index f4af8e5..676607c 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -825,7 +825,7 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
 		return rc;
 
 	/* shift bits in-place */
-	if (cell->bit_offset || cell->bit_offset)
+	if (cell->bit_offset || cell->nbits)
 		nvmem_shift_read_buffer_in_place(cell, buf);
 
 	*len = cell->bytes;
-- 
1.9.1
