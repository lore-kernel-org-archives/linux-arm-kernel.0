From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Fri,  9 Sep 2016 16:44:11 +0200
Subject: [PATCH BUGFIX] mtd: nand: mxc: fix obiwan error in
 mxc_nand_v[12]_ooblayout_free() functions
Message-ID: <1473432251-24728-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit a894cf6c5a82 ("mtd: nand: mxc: switch to mtd_ooblayout_ops")
introduced a regression accessing the OOB area from the mxc_nand
driver due to an Obiwan error in the mxc_nand_v[12]_ooblayout_free()
functions. They report a bogus oobregion { 64, 7 } which leads to
errors accessing bogus data when reading the oob area.

Prior to the commit the mtd-oobtest module could be run without any
errors. With the offending commit, this test fails with results like:
|Running mtd-oobtest
|
|=================================================
|mtd_oobtest: MTD device: 5
|mtd_oobtest: MTD device size 524288, eraseblock size 131072, page size 2048, count of eraseblocks 4, pages per eraseblock 64, OOB size 64
|mtd_test: scanning for bad eraseblocks
|mtd_test: scanned 4 eraseblocks, 0 are bad
|mtd_oobtest: test 1 of 5
|mtd_oobtest: writing OOBs of whole device
|mtd_oobtest: written up to eraseblock 0
|mtd_oobtest: written 4 eraseblocks
|mtd_oobtest: verifying all eraseblocks
|mtd_oobtest: error @addr[0x0:0x19] 0x9a -> 0x78 diff 0xe2
|mtd_oobtest: error @addr[0x0:0x1a] 0xcc -> 0x0 diff 0xcc
|mtd_oobtest: error @addr[0x0:0x1b] 0xe0 -> 0x85 diff 0x65
|mtd_oobtest: error @addr[0x0:0x1c] 0x60 -> 0x62 diff 0x2
|mtd_oobtest: error @addr[0x0:0x1d] 0x69 -> 0x45 diff 0x2c
|mtd_oobtest: error @addr[0x0:0x1e] 0xcd -> 0xa0 diff 0x6d
|mtd_oobtest: error @addr[0x0:0x1f] 0xf2 -> 0x60 diff 0x92
|mtd_oobtest: error: verify failed at 0x0
[...]

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 drivers/mtd/nand/mxc_nand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 5173fad..fdee907 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -893,7 +893,7 @@ static int mxc_v1_ooblayout_free(struct mtd_info *mtd, int section,
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
 
-	if (section > nand_chip->ecc.steps)
+	if (section >= nand_chip->ecc.steps)
 		return -ERANGE;
 
 	if (!section) {
@@ -943,7 +943,7 @@ static int mxc_v2_ooblayout_free(struct mtd_info *mtd, int section,
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
 	int stepsize = nand_chip->ecc.bytes == 9 ? 16 : 26;
 
-	if (section > nand_chip->ecc.steps)
+	if (section >= nand_chip->ecc.steps)
 		return -ERANGE;
 
 	if (!section) {
-- 
2.1.4
