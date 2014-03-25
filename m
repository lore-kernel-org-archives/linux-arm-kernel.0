From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 25 Mar 2014 08:19:53 +0000
Subject: [RFC 36/47] mtd: nand: stm_nand_bch: parse partitions and register an
 MTD device
In-Reply-To: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
References: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1395735604-26706-37-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Issue the core parse partitions and register as MTD device call.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/nand/stm_nand_bch.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/stm_nand_bch.c b/drivers/mtd/nand/stm_nand_bch.c
index abbb4d9..a0f0ae2 100644
--- a/drivers/mtd/nand/stm_nand_bch.c
+++ b/drivers/mtd/nand/stm_nand_bch.c
@@ -1738,6 +1738,7 @@ static void *stm_bch_dt_get_pdata(struct platform_device *pdev)
 
 static int stm_nand_bch_probe(struct platform_device *pdev)
 {
+	const char *part_probes[] = { "cmdlinepart", "ofpart", NULL, };
 	struct stm_plat_nand_bch_data *pdata = pdev->dev.platform_data;
 	struct device_node *np = pdev->dev.of_node;
 	struct mtd_part_parser_data ppdata;
@@ -1873,7 +1874,9 @@ static int stm_nand_bch_probe(struct platform_device *pdev)
 
 	nandi_dump_bad_blocks(nandi);
 
-	return 0;
+	/* Add partitions */
+	return mtd_device_parse_register(mtd, part_probes, &ppdata,
+					bank->partitions, bank->nr_partitions);
 }
 
 static int stm_nand_bch_remove(struct platform_device *pdev)
-- 
1.8.3.2
