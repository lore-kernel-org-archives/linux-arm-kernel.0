From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:18 +0100
Subject: [PATCH 10/52] mtd: rawnand: denali: fix probe function error path
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-11-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An error after nand_scan_tail() should trigger a nand_release().
The helper mtd_device_register() returns an error code that should
be checked and nand_release() called accordingly.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/denali.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 313c7f50621b..d1942155fc92 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -1384,10 +1384,12 @@ int denali_init(struct denali_nand_info *denali)
 	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret) {
 		dev_err(denali->dev, "Failed to register MTD: %d\n", ret);
-		goto free_buf;
+		goto detach;
 	}
 	return 0;
 
+detach:
+	nand_release(mtd);
 free_buf:
 	kfree(denali->buf);
 disable_irq:
-- 
2.14.1
