From: b32955@freescale.com (Huang Shijie)
Date: Mon, 14 Jan 2013 15:19:29 +0800
Subject: [PATCH] mtd: gpmi: dump the BCH registers
Message-ID: <1358147969-31878-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dump the BCH registers in gpmi_dump_info().

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/nand/gpmi-nand/bch-regs.h |    2 ++
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c |    5 +++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/bch-regs.h b/drivers/mtd/nand/gpmi-nand/bch-regs.h
index a092451..d67bca5 100644
--- a/drivers/mtd/nand/gpmi-nand/bch-regs.h
+++ b/drivers/mtd/nand/gpmi-nand/bch-regs.h
@@ -103,4 +103,6 @@
 		? (((v) >> 2) & MX6Q_BM_BCH_FLASH0LAYOUT1_DATAN_SIZE)	\
 		: ((v) & BM_BCH_FLASH0LAYOUT1_DATAN_SIZE)		\
 	)
+
+#define HW_BCH_VERSION				0x00000160
 #endif
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
index d84699c..01cc570 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
@@ -208,6 +208,11 @@ void gpmi_dump_info(struct gpmi_nand_data *this)
 	}
 
 	/* start to print out the BCH info */
+	pr_err("Show BCH registers :\n");
+	for (i = 0; i <= HW_BCH_VERSION / 0x10 + 1; i++) {
+		reg = readl(r->bch_regs + i * 0x10);
+		pr_err("offset 0x%.3x : 0x%.8x\n", i * 0x10, reg);
+	}
 	pr_err("BCH Geometry :\n");
 	pr_err("GF length              : %u\n", geo->gf_len);
 	pr_err("ECC Strength           : %u\n", geo->ecc_strength);
-- 
1.7.0.4
