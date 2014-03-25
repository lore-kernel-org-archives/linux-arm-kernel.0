From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 25 Mar 2014 08:19:51 +0000
Subject: [RFC 34/47] mtd: nand: stm_nand_bch: load flash-resident BBT
In-Reply-To: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
References: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1395735604-26706-35-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If load of existing BBT fails (first run), scan device for factory-set
BBMs (Bad-Block Markers) and create a new flash-resident.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/nand/stm_nand_bch.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/mtd/nand/stm_nand_bch.c b/drivers/mtd/nand/stm_nand_bch.c
index d1d84c1..6698b1f 100644
--- a/drivers/mtd/nand/stm_nand_bch.c
+++ b/drivers/mtd/nand/stm_nand_bch.c
@@ -1834,6 +1834,21 @@ static int stm_nand_bch_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	/* Load Flash-resident BBT */
+	err = bch_load_bbt(nandi, bbt_info);
+	if (err) {
+		dev_warn(nandi->dev,
+			"failed to find BBTs:"
+			"  scanning device for bad-block markers\n");
+
+		/* Scan, build, and write BBT */
+		nandi_scan_build_bbt(nandi, bbt_info);
+		err = bch_update_bbts(nandi, bbt_info, NAND_IBBT_UPDATE_BOTH,
+				      bbt_info->bbt_vers[0] + 1);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
-- 
1.8.3.2
