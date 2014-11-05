From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  5 Nov 2014 16:59:48 +0000
Subject: [PATCH v4 06/11] mtd: nand: WARN() if EEC Bytes per page is larger
 than the OOB
In-Reply-To: <1415206793-25670-1-git-send-email-lee.jones@linaro.org>
References: <1415206793-25670-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1415206793-25670-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

EEC information is held in the Out-Of-Bounds (OOB) area, so can not be
larger than the area it's stored in.  If the math is out, we issue a
warning to the user.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/nand/nand_base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 4f3e80c..d0ebb05 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -4063,6 +4063,8 @@ int nand_scan_tail(struct mtd_info *mtd)
 	}
 	ecc->total = ecc->steps * ecc->bytes;
 
+	WARN_ON(ecc->total > mtd->oobsize);
+
 	/* Allow subpage writes up to ecc.steps. Not possible for MLC flash */
 	if (!(chip->options & NAND_NO_SUBPAGE_WRITE) && nand_is_slc(chip)) {
 		switch (ecc->steps) {
-- 
1.9.1
