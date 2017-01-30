From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Mon, 30 Jan 2017 20:33:47 +0100
Subject: [PATCH v3] mmc: meson-gx: set max block count
Message-ID: <b199dad5-e171-9c4a-2a44-83e0fe2365a9@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far max_blk_count isn't set what results in a default of value 8
to be used (PAGE_SIZE / block size).

Block length field has 9 bits, so set max_blk_count to 2^9-1 = 511.
In addition set max_req_size because max_blk_count is also limited
by max_req_size / block_size.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Acked-by: Kevin Hilman <khilman@baylibre.com>
---
v2:
- block length field has 9 bits, so set max_blk_count to 2^9-1 = 511
- in addition set max_req_size because max_blk_count is also limited
  by max_req_size / block_size
v3:
- extend commit message
---
 drivers/mmc/host/meson-gx-mmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 83361f1f..d4d174ed 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -810,6 +810,8 @@ static int meson_mmc_probe(struct platform_device *pdev)
 		goto free_host;
 	}
 
+	mmc->max_blk_count = CMD_CFG_LENGTH_MASK;
+	mmc->max_req_size = mmc->max_blk_count * mmc->max_blk_size;
 	mmc->ops = &meson_mmc_ops;
 	mmc_add_host(mmc);
 
-- 
2.11.0
