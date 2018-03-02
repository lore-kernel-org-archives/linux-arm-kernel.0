From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:09 +0100
Subject: [PATCH 01/52] mtd: rawnand: add hooks that may be called during
 nand_scan()
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-2-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to remove the limitation that forbids dynamic allocation in
nand_scan_ident(), we must create a path that will be the same for all
controller drivers. The idea is to use nand_scan() instead of the widely
implemented nand_scan_ident()/nand_scan_tail() couple. In order to
achieve this, controller drivers will need to adjust some parameters
between these two functions depending on the NAND chip wired on them.

For that, a hook called ->attach_chip() is created in the
nand_hw_control structure (called *controller in struct nand_chip) of
the NAND chip structure.

Another hook, ->detach_chip() is also introduced in order to clean the
controller driver's potential allocations in case of failure of
nand_scan_tail(). There is no need for the controller driver to call the
->detach_chip() hook directly upon error after a successful nand_scan().
In this situation, calling nand_release() as before is enough.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/nand_base.c | 21 +++++++++++++++++++--
 include/linux/mtd/rawnand.h      |  6 ++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index ef0a44a8c3d5..182904b2fc07 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -6647,11 +6647,23 @@ EXPORT_SYMBOL(nand_scan_tail);
  */
 int nand_scan(struct mtd_info *mtd, int maxchips)
 {
+	struct nand_chip *chip = mtd_to_nand(mtd);
 	int ret;
 
 	ret = nand_scan_ident(mtd, maxchips, NULL);
-	if (!ret)
-		ret = nand_scan_tail(mtd);
+	if (ret)
+		return ret;
+
+	if (chip->ecc.attach_chip) {
+		ret = chip->ecc.attach_chip(chip);
+		if (ret)
+			return ret;
+	}
+
+	ret = nand_scan_tail(mtd);
+	if (ret && chip->ecc.detach_chip)
+		chip->ecc.detach_chip(chip);
+
 	return ret;
 }
 EXPORT_SYMBOL(nand_scan);
@@ -6679,7 +6691,12 @@ void nand_cleanup(struct nand_chip *chip)
 
 	/* Free manufacturer priv data. */
 	nand_manufacturer_cleanup(chip);
+
+	/* Free controller specific allocations after chip identification */
+	if (chip->ecc.detach_chip)
+		chip->ecc.detach_chip(chip);
 }
+
 EXPORT_SYMBOL_GPL(nand_cleanup);
 
 /**
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 348f2aba0b9e..53bb6ef1a7c2 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -576,6 +576,10 @@ static const struct nand_ecc_caps __name = {			\
  * @read_oob_raw:	function to read chip OOB data without ECC
  * @read_oob:	function to read chip OOB data
  * @write_oob:	function to write chip OOB data
+ * @attach_chip:	Callback that may be called between nand_detec() and
+ *			nand_scan_tail() during nand_scan() (optional).
+ * @detach_chip:	Callback that may be called if nand_scan_tail() fails
+ *			(optional).
  */
 struct nand_ecc_ctrl {
 	nand_ecc_modes_t mode;
@@ -616,6 +620,8 @@ struct nand_ecc_ctrl {
 	int (*read_oob)(struct mtd_info *mtd, struct nand_chip *chip, int page);
 	int (*write_oob)(struct mtd_info *mtd, struct nand_chip *chip,
 			int page);
+	int (*attach_chip)(struct nand_chip *chip);
+	void (*detach_chip)(struct nand_chip *chip);
 };
 
 /**
-- 
2.14.1
