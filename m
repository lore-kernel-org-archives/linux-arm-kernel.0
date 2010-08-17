From: leiwen@marvell.com (Lei Wen)
Date: Tue, 17 Aug 2010 17:25:57 +0800
Subject: [PATCH 05/06] pxa3xx_nand: remove the flash info in driver structure
Message-ID: <mailman.190.1282048218.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After probe, all info already transfer to driver structure.
There is no need to keep the original flash info.
So that we could safely free the flash info in memory, which may grows
larger when more flash is suported.

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |  115 +++++++++++++++-------------------------
 1 files changed, 43 insertions(+), 72 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 61fe2e2..27ed63f 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -117,7 +117,7 @@ struct pxa3xx_nand_info {
 	struct nand_chip	nand_chip;

 	struct platform_device	 *pdev;
-	const struct pxa3xx_nand_flash *flash_info;
+	struct pxa3xx_nand_cmdset *cmdset;

 	struct clk		*clk;
 	void __iomem		*mmio_base;
@@ -131,6 +131,7 @@ struct pxa3xx_nand_info {
 	int			drcmr_cmd;

 	unsigned char		*data_buff;
+	unsigned char		*oob_buff;
 	dma_addr_t 		data_buff_phys;
 	size_t			data_buff_size;
 	int 			data_dma_ch;
@@ -149,7 +150,8 @@ struct pxa3xx_nand_info {
 	int			use_ecc;	/* use HW ECC ? */
 	int			use_dma;	/* use DMA ? */

-	size_t			data_size;	/* data size in FIFO */
+	unsigned int		page_size;	/* page size of attached chip */
+	unsigned int		data_size;	/* data size in FIFO */
 	int 			retcode;
 	struct completion 	cmd_complete;

@@ -158,6 +160,10 @@ struct pxa3xx_nand_info {
 	uint32_t		ndcb1;
 	uint32_t		ndcb2;

+	/* timing calcuted from setting */
+	uint32_t		ndtr0cs0;
+	uint32_t		ndtr1cs0;
+
 	/* calculated from pxa3xx_nand_flash data */
 	size_t		oob_size;
 	size_t		read_id_bytes;
@@ -174,8 +180,6 @@ MODULE_PARM_DESC(use_dma, "enable DMA for data
transfering to/from NAND HW");
  * Default NAND flash controller configuration setup by the
  * bootloader. This configuration is used only when pdata->keep_config is set
  */
-static struct pxa3xx_nand_timing default_timing;
-static struct pxa3xx_nand_flash default_flash;
 static struct pxa3xx_nand_cmdset default_cmdset = {
 	.read1		= 0x3000,
 	.read2		= 0x0050,
@@ -222,23 +226,9 @@ static struct pxa3xx_nand_flash __devinitdata
builtin_flash_types[] = {
 #define NDTR1_tWHR(c)	(min((c), 15) << 4)
 #define NDTR1_tAR(c)	(min((c), 15) << 0)

-#define tCH_NDTR0(r)	(((r) >> 19) & 0x7)
-#define tCS_NDTR0(r)	(((r) >> 16) & 0x7)
-#define tWH_NDTR0(r)	(((r) >> 11) & 0x7)
-#define tWP_NDTR0(r)	(((r) >> 8) & 0x7)
-#define tRH_NDTR0(r)	(((r) >> 3) & 0x7)
-#define tRP_NDTR0(r)	(((r) >> 0) & 0x7)
-
-#define tR_NDTR1(r)	(((r) >> 16) & 0xffff)
-#define tWHR_NDTR1(r)	(((r) >> 4) & 0xf)
-#define tAR_NDTR1(r)	(((r) >> 0) & 0xf)
-
 /* convert nano-seconds to nand flash controller clock cycles */
 #define ns2cycle(ns, clk)	(int)((ns) * (clk / 1000000) / 1000)

-/* convert nand flash controller clock cycles to nano-seconds */
-#define cycle2ns(c, clk)	((((c) + 1) * 1000000 + clk / 500) / (clk / 1000))
-
 static void pxa3xx_nand_set_timing(struct pxa3xx_nand_info *info,
 				   const struct pxa3xx_nand_timing *t)
 {
@@ -256,6 +246,8 @@ static void pxa3xx_nand_set_timing(struct
pxa3xx_nand_info *info,
 		NDTR1_tWHR(ns2cycle(t->tWHR, nand_clk)) |
 		NDTR1_tAR(ns2cycle(t->tAR, nand_clk));

+	info->ndtr0cs0 = ndtr0;
+	info->ndtr1cs0 = ndtr1;
 	nand_writel(info, NDTR0CS0, ndtr0);
 	nand_writel(info, NDTR1CS0, ndtr1);
 }
@@ -279,23 +271,24 @@ static int wait_for_event(struct
pxa3xx_nand_info *info, uint32_t event)
 	return -ETIMEDOUT;
 }

-static int prepare_read_prog_cmd(struct pxa3xx_nand_info *info,
-			uint16_t cmd, int column, int page_addr)
+static void pxa3xx_set_datasize(struct pxa3xx_nand_info *info)
 {
-	const struct pxa3xx_nand_flash *f = info->flash_info;
-	const struct pxa3xx_nand_cmdset *cmdset = f->cmdset;
-
 	/* calculate data size */
-	switch (f->page_size) {
+	switch (info->page_size) {
 	case 2048:
 		info->data_size = (info->use_ecc) ? 2088 : 2112;
 		break;
 	case 512:
 		info->data_size = (info->use_ecc) ? 520 : 528;
 		break;
-	default:
-		return -EINVAL;
 	}
+}
+
+static int prepare_read_prog_cmd(struct pxa3xx_nand_info *info,
+		uint16_t cmd, int column, int page_addr)
+{
+	const struct pxa3xx_nand_cmdset *cmdset = info->cmdset;
+	pxa3xx_set_datasize(info);

 	/* generate values for NDCBx registers */
 	info->ndcb0 = cmd | ((cmd & 0xff00) ? NDCB0_DBC : 0);
@@ -334,7 +327,7 @@ static int prepare_erase_cmd(struct pxa3xx_nand_info *info,

 static int prepare_other_cmd(struct pxa3xx_nand_info *info, uint16_t cmd)
 {
-	const struct pxa3xx_nand_cmdset *cmdset = info->flash_info->cmdset;
+	const struct pxa3xx_nand_cmdset *cmdset = info->cmdset;

 	info->ndcb0 = cmd | ((cmd & 0xff00) ? NDCB0_DBC : 0);
 	info->ndcb1 = 0;
@@ -571,8 +564,7 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info
*mtd, unsigned command,
 				int column, int page_addr)
 {
 	struct pxa3xx_nand_info *info = mtd->priv;
-	const struct pxa3xx_nand_flash *flash_info = info->flash_info;
-	const struct pxa3xx_nand_cmdset *cmdset = flash_info->cmdset;
+	const struct pxa3xx_nand_cmdset *cmdset = info->cmdset;
 	int ret;

 	info->use_dma = (use_dma) ? 1 : 0;
@@ -796,8 +788,7 @@ static int pxa3xx_nand_ecc_correct(struct mtd_info *mtd,

 static int __readid(struct pxa3xx_nand_info *info, uint32_t *id)
 {
-	const struct pxa3xx_nand_flash *f = info->flash_info;
-	const struct pxa3xx_nand_cmdset *cmdset = f->cmdset;
+	const struct pxa3xx_nand_cmdset *cmdset = info->cmdset;
 	uint32_t ndcr;
 	uint8_t  id_buff[8];

@@ -839,6 +830,9 @@ static int pxa3xx_nand_config_flash(struct
pxa3xx_nand_info *info,
 		return -EINVAL;

 	/* calculate flash information */
+	info->cmdset = f->cmdset;
+	info->page_size = f->page_size;
+	info->oob_buff = info->data_buff + f->page_size;
 	info->oob_size = (f->page_size == 2048) ? 64 : 16;
 	info->read_id_bytes = (f->page_size == 2048) ? 4 : 2;

@@ -863,44 +857,20 @@ static int pxa3xx_nand_config_flash(struct
pxa3xx_nand_info *info,
 	info->reg_ndcr = ndcr;

 	pxa3xx_nand_set_timing(info, f->timing);
-	info->flash_info = f;
 	return 0;
 }

-static void pxa3xx_nand_detect_timing(struct pxa3xx_nand_info *info,
-				      struct pxa3xx_nand_timing *t)
-{
-	unsigned long nand_clk = clk_get_rate(info->clk);
-	uint32_t ndtr0 = nand_readl(info, NDTR0CS0);
-	uint32_t ndtr1 = nand_readl(info, NDTR1CS0);
-
-	t->tCH = cycle2ns(tCH_NDTR0(ndtr0), nand_clk);
-	t->tCS = cycle2ns(tCS_NDTR0(ndtr0), nand_clk);
-	t->tWH = cycle2ns(tWH_NDTR0(ndtr0), nand_clk);
-	t->tWP = cycle2ns(tWP_NDTR0(ndtr0), nand_clk);
-	t->tRH = cycle2ns(tRH_NDTR0(ndtr0), nand_clk);
-	t->tRP = cycle2ns(tRP_NDTR0(ndtr0), nand_clk);
-
-	t->tR = cycle2ns(tR_NDTR1(ndtr1), nand_clk);
-	t->tWHR = cycle2ns(tWHR_NDTR1(ndtr1), nand_clk);
-	t->tAR = cycle2ns(tAR_NDTR1(ndtr1), nand_clk);
-}
-
 static int pxa3xx_nand_detect_config(struct pxa3xx_nand_info *info)
 {
 	uint32_t ndcr = nand_readl(info, NDCR);
 	struct nand_flash_dev *type = NULL;
-	uint32_t id = -1;
+	uint32_t id = -1, page_per_block, num_blocks;
 	int i;

-	default_flash.page_per_block = ndcr & NDCR_PG_PER_BLK ? 64 : 32;
-	default_flash.page_size = ndcr & NDCR_PAGE_SZ ? 2048 : 512;
-	default_flash.flash_width = ndcr & NDCR_DWIDTH_M ? 16 : 8;
-	default_flash.dfc_width = ndcr & NDCR_DWIDTH_C ? 16 : 8;
-
+	page_per_block = ndcr & NDCR_PG_PER_BLK ? 64 : 32;
+	info->page_size = ndcr & NDCR_PAGE_SZ ? 2048 : 512;
 	/* set info fields needed to __readid */
-	info->flash_info = &default_flash;
-	info->read_id_bytes = (default_flash.page_size == 2048) ? 4 : 2;
+	info->read_id_bytes = (info->page_size == 2048) ? 4 : 2;
 	info->reg_ndcr = ndcr;

 	if (__readid(info, &id))
@@ -919,22 +889,22 @@ static int pxa3xx_nand_detect_config(struct
pxa3xx_nand_info *info)
 		return -ENODEV;

 	/* fill the missing flash information */
-	i = __ffs(default_flash.page_per_block * default_flash.page_size);
-	default_flash.num_blocks = type->chipsize << (20 - i);
+	i = __ffs(page_per_block * info->page_size);
+	num_blocks = type->chipsize << (20 - i);

-	info->oob_size = (default_flash.page_size == 2048) ? 64 : 16;
+	info->oob_size = (info->page_size == 2048) ? 64 : 16;

 	/* calculate addressing information */
-	info->col_addr_cycles = (default_flash.page_size == 2048) ? 2 : 1;
+	info->col_addr_cycles = (info->page_size == 2048) ? 2 : 1;

-	if (default_flash.num_blocks * default_flash.page_per_block > 65536)
+	if (num_blocks * page_per_block > 65536)
 		info->row_addr_cycles = 3;
 	else
 		info->row_addr_cycles = 2;

-	pxa3xx_nand_detect_timing(info, &default_timing);
-	default_flash.timing = &default_timing;
-	default_flash.cmdset = &default_cmdset;
+	info->ndtr0cs0 = nand_readl(info, NDTR0CS0);
+	info->ndtr1cs0 = nand_readl(info, NDTR1CS0);
+	info->cmdset = &default_cmdset;

 	return 0;
 }
@@ -1035,10 +1005,9 @@ static struct nand_ecclayout hw_largepage_ecclayout = {
 static void pxa3xx_nand_init_mtd(struct mtd_info *mtd,
 				 struct pxa3xx_nand_info *info)
 {
-	const struct pxa3xx_nand_flash *f = info->flash_info;
 	struct nand_chip *this = &info->nand_chip;

-	this->options = (f->flash_width == 16) ? NAND_BUSWIDTH_16: 0;
+	this->options = (info->reg_ndcr & NDCR_DWIDTH_C) ? NAND_BUSWIDTH_16: 0;

 	this->waitfunc		= pxa3xx_nand_waitfunc;
 	this->select_chip	= pxa3xx_nand_select_chip;
@@ -1054,9 +1023,9 @@ static void pxa3xx_nand_init_mtd(struct mtd_info *mtd,
 	this->ecc.hwctl		= pxa3xx_nand_ecc_hwctl;
 	this->ecc.calculate	= pxa3xx_nand_ecc_calculate;
 	this->ecc.correct	= pxa3xx_nand_ecc_correct;
-	this->ecc.size		= f->page_size;
+	this->ecc.size		= info->page_size;

-	if (f->page_size == 2048)
+	if (info->page_size == 2048)
 		this->ecc.layout = &hw_largepage_ecclayout;
 	else
 		this->ecc.layout = &hw_smallpage_ecclayout;
@@ -1263,9 +1232,11 @@ static int pxa3xx_nand_resume(struct
platform_device *pdev)
 	struct mtd_info *mtd = (struct mtd_info *)platform_get_drvdata(pdev);
 	struct pxa3xx_nand_info *info = mtd->priv;

+	nand_writel(info, NDTR0CS0, info->ndtr0cs0);
+	nand_writel(info, NDTR1CS0, info->ndtr1cs0);
 	clk_enable(info->clk);

-	return pxa3xx_nand_config_flash(info, info->flash_info);
+	return 0;
 }
 #else
 #define pxa3xx_nand_suspend	NULL
-- 
1.7.0.4

--000e0cdf9dfc0da4cd048e041c62
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0005-pxa3xx_nand-remove-the-flash-info-in-driver-structur.patch"
Content-Disposition: attachment; 
	filename="0005-pxa3xx_nand-remove-the-flash-info-in-driver-structur.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gcyq48yu0

RnJvbSA0ZTVkZjUxMDkyNDRjMjA3MGZkMzYyMTBhY2E4MDY4ZDRlODkwYTc2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMZWkgV2VuIDxsZWl3ZW5AbWFydmVsbC5jb20+CkRhdGU6IFR1
ZSwgMTcgQXVnIDIwMTAgMTc6MjU6NTcgKzA4MDAKU3ViamVjdDogW1BBVENIIDA1LzEyXSBweGEz
eHhfbmFuZDogcmVtb3ZlIHRoZSBmbGFzaCBpbmZvIGluIGRyaXZlciBzdHJ1Y3R1cmUKCkFmdGVy
IHByb2JlLCBhbGwgaW5mbyBhbHJlYWR5IHRyYW5zZmVyIHRvIGRyaXZlciBzdHJ1Y3R1cmUuClRo
ZXJlIGlzIG5vIG5lZWQgdG8ga2VlcCB0aGUgb3JpZ2luYWwgZmxhc2ggaW5mby4KU28gdGhhdCB3
ZSBjb3VsZCBzYWZlbHkgZnJlZSB0aGUgZmxhc2ggaW5mbyBpbiBtZW1vcnksIHdoaWNoIG1heSBn
cm93cwpsYXJnZXIgd2hlbiBtb3JlIGZsYXNoIGlzIHN1cG9ydGVkLgoKU2lnbmVkLW9mZi1ieTog
TGVpIFdlbiA8bGVpd2VuQG1hcnZlbGwuY29tPgpTaWduZWQtb2ZmLWJ5OiBIYW9qaWFuIFpodWFu
ZyA8aGFvamlhbi56aHVhbmdAbWFydmVsbC5jb20+Ci0tLQogZHJpdmVycy9tdGQvbmFuZC9weGEz
eHhfbmFuZC5jIHwgIDExNSArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
CiAxIGZpbGVzIGNoYW5nZWQsIDQzIGluc2VydGlvbnMoKyksIDcyIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbXRkL25hbmQvcHhhM3h4X25hbmQuYyBiL2RyaXZlcnMvbXRkL25h
bmQvcHhhM3h4X25hbmQuYwppbmRleCA2MWZlMmUyLi4yN2VkNjNmIDEwMDY0NAotLS0gYS9kcml2
ZXJzL210ZC9uYW5kL3B4YTN4eF9uYW5kLmMKKysrIGIvZHJpdmVycy9tdGQvbmFuZC9weGEzeHhf
bmFuZC5jCkBAIC0xMTcsNyArMTE3LDcgQEAgc3RydWN0IHB4YTN4eF9uYW5kX2luZm8gewogCXN0
cnVjdCBuYW5kX2NoaXAJbmFuZF9jaGlwOwogCiAJc3RydWN0IHBsYXRmb3JtX2RldmljZQkgKnBk
ZXY7Ci0JY29uc3Qgc3RydWN0IHB4YTN4eF9uYW5kX2ZsYXNoICpmbGFzaF9pbmZvOworCXN0cnVj
dCBweGEzeHhfbmFuZF9jbWRzZXQgKmNtZHNldDsKIAogCXN0cnVjdCBjbGsJCSpjbGs7CiAJdm9p
ZCBfX2lvbWVtCQkqbW1pb19iYXNlOwpAQCAtMTMxLDYgKzEzMSw3IEBAIHN0cnVjdCBweGEzeHhf
bmFuZF9pbmZvIHsKIAlpbnQJCQlkcmNtcl9jbWQ7CiAKIAl1bnNpZ25lZCBjaGFyCQkqZGF0YV9i
dWZmOworCXVuc2lnbmVkIGNoYXIJCSpvb2JfYnVmZjsKIAlkbWFfYWRkcl90IAkJZGF0YV9idWZm
X3BoeXM7CiAJc2l6ZV90CQkJZGF0YV9idWZmX3NpemU7CiAJaW50IAkJCWRhdGFfZG1hX2NoOwpA
QCAtMTQ5LDcgKzE1MCw4IEBAIHN0cnVjdCBweGEzeHhfbmFuZF9pbmZvIHsKIAlpbnQJCQl1c2Vf
ZWNjOwkvKiB1c2UgSFcgRUNDID8gKi8KIAlpbnQJCQl1c2VfZG1hOwkvKiB1c2UgRE1BID8gKi8K
IAotCXNpemVfdAkJCWRhdGFfc2l6ZTsJLyogZGF0YSBzaXplIGluIEZJRk8gKi8KKwl1bnNpZ25l
ZCBpbnQJCXBhZ2Vfc2l6ZTsJLyogcGFnZSBzaXplIG9mIGF0dGFjaGVkIGNoaXAgKi8KKwl1bnNp
Z25lZCBpbnQJCWRhdGFfc2l6ZTsJLyogZGF0YSBzaXplIGluIEZJRk8gKi8KIAlpbnQgCQkJcmV0
Y29kZTsKIAlzdHJ1Y3QgY29tcGxldGlvbiAJY21kX2NvbXBsZXRlOwogCkBAIC0xNTgsNiArMTYw
LDEwIEBAIHN0cnVjdCBweGEzeHhfbmFuZF9pbmZvIHsKIAl1aW50MzJfdAkJbmRjYjE7CiAJdWlu
dDMyX3QJCW5kY2IyOwogCisJLyogdGltaW5nIGNhbGN1dGVkIGZyb20gc2V0dGluZyAqLworCXVp
bnQzMl90CQluZHRyMGNzMDsKKwl1aW50MzJfdAkJbmR0cjFjczA7CisKIAkvKiBjYWxjdWxhdGVk
IGZyb20gcHhhM3h4X25hbmRfZmxhc2ggZGF0YSAqLwogCXNpemVfdAkJb29iX3NpemU7CiAJc2l6
ZV90CQlyZWFkX2lkX2J5dGVzOwpAQCAtMTc0LDggKzE4MCw2IEBAIE1PRFVMRV9QQVJNX0RFU0Mo
dXNlX2RtYSwgImVuYWJsZSBETUEgZm9yIGRhdGEgdHJhbnNmZXJpbmcgdG8vZnJvbSBOQU5EIEhX
Iik7CiAgKiBEZWZhdWx0IE5BTkQgZmxhc2ggY29udHJvbGxlciBjb25maWd1cmF0aW9uIHNldHVw
IGJ5IHRoZQogICogYm9vdGxvYWRlci4gVGhpcyBjb25maWd1cmF0aW9uIGlzIHVzZWQgb25seSB3
aGVuIHBkYXRhLT5rZWVwX2NvbmZpZyBpcyBzZXQKICAqLwotc3RhdGljIHN0cnVjdCBweGEzeHhf
bmFuZF90aW1pbmcgZGVmYXVsdF90aW1pbmc7Ci1zdGF0aWMgc3RydWN0IHB4YTN4eF9uYW5kX2Zs
YXNoIGRlZmF1bHRfZmxhc2g7CiBzdGF0aWMgc3RydWN0IHB4YTN4eF9uYW5kX2NtZHNldCBkZWZh
dWx0X2NtZHNldCA9IHsKIAkucmVhZDEJCT0gMHgzMDAwLAogCS5yZWFkMgkJPSAweDAwNTAsCkBA
IC0yMjIsMjMgKzIyNiw5IEBAIHN0YXRpYyBzdHJ1Y3QgcHhhM3h4X25hbmRfZmxhc2ggX19kZXZp
bml0ZGF0YSBidWlsdGluX2ZsYXNoX3R5cGVzW10gPSB7CiAjZGVmaW5lIE5EVFIxX3RXSFIoYykJ
KG1pbigoYyksIDE1KSA8PCA0KQogI2RlZmluZSBORFRSMV90QVIoYykJKG1pbigoYyksIDE1KSA8
PCAwKQogCi0jZGVmaW5lIHRDSF9ORFRSMChyKQkoKChyKSA+PiAxOSkgJiAweDcpCi0jZGVmaW5l
IHRDU19ORFRSMChyKQkoKChyKSA+PiAxNikgJiAweDcpCi0jZGVmaW5lIHRXSF9ORFRSMChyKQko
KChyKSA+PiAxMSkgJiAweDcpCi0jZGVmaW5lIHRXUF9ORFRSMChyKQkoKChyKSA+PiA4KSAmIDB4
NykKLSNkZWZpbmUgdFJIX05EVFIwKHIpCSgoKHIpID4+IDMpICYgMHg3KQotI2RlZmluZSB0UlBf
TkRUUjAocikJKCgocikgPj4gMCkgJiAweDcpCi0KLSNkZWZpbmUgdFJfTkRUUjEocikJKCgocikg
Pj4gMTYpICYgMHhmZmZmKQotI2RlZmluZSB0V0hSX05EVFIxKHIpCSgoKHIpID4+IDQpICYgMHhm
KQotI2RlZmluZSB0QVJfTkRUUjEocikJKCgocikgPj4gMCkgJiAweGYpCi0KIC8qIGNvbnZlcnQg
bmFuby1zZWNvbmRzIHRvIG5hbmQgZmxhc2ggY29udHJvbGxlciBjbG9jayBjeWNsZXMgKi8KICNk
ZWZpbmUgbnMyY3ljbGUobnMsIGNsaykJKGludCkoKG5zKSAqIChjbGsgLyAxMDAwMDAwKSAvIDEw
MDApCiAKLS8qIGNvbnZlcnQgbmFuZCBmbGFzaCBjb250cm9sbGVyIGNsb2NrIGN5Y2xlcyB0byBu
YW5vLXNlY29uZHMgKi8KLSNkZWZpbmUgY3ljbGUybnMoYywgY2xrKQkoKCgoYykgKyAxKSAqIDEw
MDAwMDAgKyBjbGsgLyA1MDApIC8gKGNsayAvIDEwMDApKQotCiBzdGF0aWMgdm9pZCBweGEzeHhf
bmFuZF9zZXRfdGltaW5nKHN0cnVjdCBweGEzeHhfbmFuZF9pbmZvICppbmZvLAogCQkJCSAgIGNv
bnN0IHN0cnVjdCBweGEzeHhfbmFuZF90aW1pbmcgKnQpCiB7CkBAIC0yNTYsNiArMjQ2LDggQEAg
c3RhdGljIHZvaWQgcHhhM3h4X25hbmRfc2V0X3RpbWluZyhzdHJ1Y3QgcHhhM3h4X25hbmRfaW5m
byAqaW5mbywKIAkJTkRUUjFfdFdIUihuczJjeWNsZSh0LT50V0hSLCBuYW5kX2NsaykpIHwKIAkJ
TkRUUjFfdEFSKG5zMmN5Y2xlKHQtPnRBUiwgbmFuZF9jbGspKTsKIAorCWluZm8tPm5kdHIwY3Mw
ID0gbmR0cjA7CisJaW5mby0+bmR0cjFjczAgPSBuZHRyMTsKIAluYW5kX3dyaXRlbChpbmZvLCBO
RFRSMENTMCwgbmR0cjApOwogCW5hbmRfd3JpdGVsKGluZm8sIE5EVFIxQ1MwLCBuZHRyMSk7CiB9
CkBAIC0yNzksMjMgKzI3MSwyNCBAQCBzdGF0aWMgaW50IHdhaXRfZm9yX2V2ZW50KHN0cnVjdCBw
eGEzeHhfbmFuZF9pbmZvICppbmZvLCB1aW50MzJfdCBldmVudCkKIAlyZXR1cm4gLUVUSU1FRE9V
VDsKIH0KIAotc3RhdGljIGludCBwcmVwYXJlX3JlYWRfcHJvZ19jbWQoc3RydWN0IHB4YTN4eF9u
YW5kX2luZm8gKmluZm8sCi0JCQl1aW50MTZfdCBjbWQsIGludCBjb2x1bW4sIGludCBwYWdlX2Fk
ZHIpCitzdGF0aWMgdm9pZCBweGEzeHhfc2V0X2RhdGFzaXplKHN0cnVjdCBweGEzeHhfbmFuZF9p
bmZvICppbmZvKQogewotCWNvbnN0IHN0cnVjdCBweGEzeHhfbmFuZF9mbGFzaCAqZiA9IGluZm8t
PmZsYXNoX2luZm87Ci0JY29uc3Qgc3RydWN0IHB4YTN4eF9uYW5kX2NtZHNldCAqY21kc2V0ID0g
Zi0+Y21kc2V0OwotCiAJLyogY2FsY3VsYXRlIGRhdGEgc2l6ZSAqLwotCXN3aXRjaCAoZi0+cGFn
ZV9zaXplKSB7CisJc3dpdGNoIChpbmZvLT5wYWdlX3NpemUpIHsKIAljYXNlIDIwNDg6CiAJCWlu
Zm8tPmRhdGFfc2l6ZSA9IChpbmZvLT51c2VfZWNjKSA/IDIwODggOiAyMTEyOwogCQlicmVhazsK
IAljYXNlIDUxMjoKIAkJaW5mby0+ZGF0YV9zaXplID0gKGluZm8tPnVzZV9lY2MpID8gNTIwIDog
NTI4OwogCQlicmVhazsKLQlkZWZhdWx0OgotCQlyZXR1cm4gLUVJTlZBTDsKIAl9Cit9CisKK3N0
YXRpYyBpbnQgcHJlcGFyZV9yZWFkX3Byb2dfY21kKHN0cnVjdCBweGEzeHhfbmFuZF9pbmZvICpp
bmZvLAorCQl1aW50MTZfdCBjbWQsIGludCBjb2x1bW4sIGludCBwYWdlX2FkZHIpCit7CisJY29u
c3Qgc3RydWN0IHB4YTN4eF9uYW5kX2NtZHNldCAqY21kc2V0ID0gaW5mby0+Y21kc2V0OworCXB4
YTN4eF9zZXRfZGF0YXNpemUoaW5mbyk7CiAKIAkvKiBnZW5lcmF0ZSB2YWx1ZXMgZm9yIE5EQ0J4
IHJlZ2lzdGVycyAqLwogCWluZm8tPm5kY2IwID0gY21kIHwgKChjbWQgJiAweGZmMDApID8gTkRD
QjBfREJDIDogMCk7CkBAIC0zMzQsNyArMzI3LDcgQEAgc3RhdGljIGludCBwcmVwYXJlX2VyYXNl
X2NtZChzdHJ1Y3QgcHhhM3h4X25hbmRfaW5mbyAqaW5mbywKIAogc3RhdGljIGludCBwcmVwYXJl
X290aGVyX2NtZChzdHJ1Y3QgcHhhM3h4X25hbmRfaW5mbyAqaW5mbywgdWludDE2X3QgY21kKQog
ewotCWNvbnN0IHN0cnVjdCBweGEzeHhfbmFuZF9jbWRzZXQgKmNtZHNldCA9IGluZm8tPmZsYXNo
X2luZm8tPmNtZHNldDsKKwljb25zdCBzdHJ1Y3QgcHhhM3h4X25hbmRfY21kc2V0ICpjbWRzZXQg
PSBpbmZvLT5jbWRzZXQ7CiAKIAlpbmZvLT5uZGNiMCA9IGNtZCB8ICgoY21kICYgMHhmZjAwKSA/
IE5EQ0IwX0RCQyA6IDApOwogCWluZm8tPm5kY2IxID0gMDsKQEAgLTU3MSw4ICs1NjQsNyBAQCBz
dGF0aWMgdm9pZCBweGEzeHhfbmFuZF9jbWRmdW5jKHN0cnVjdCBtdGRfaW5mbyAqbXRkLCB1bnNp
Z25lZCBjb21tYW5kLAogCQkJCWludCBjb2x1bW4sIGludCBwYWdlX2FkZHIpCiB7CiAJc3RydWN0
IHB4YTN4eF9uYW5kX2luZm8gKmluZm8gPSBtdGQtPnByaXY7Ci0JY29uc3Qgc3RydWN0IHB4YTN4
eF9uYW5kX2ZsYXNoICpmbGFzaF9pbmZvID0gaW5mby0+Zmxhc2hfaW5mbzsKLQljb25zdCBzdHJ1
Y3QgcHhhM3h4X25hbmRfY21kc2V0ICpjbWRzZXQgPSBmbGFzaF9pbmZvLT5jbWRzZXQ7CisJY29u
c3Qgc3RydWN0IHB4YTN4eF9uYW5kX2NtZHNldCAqY21kc2V0ID0gaW5mby0+Y21kc2V0OwogCWlu
dCByZXQ7CiAKIAlpbmZvLT51c2VfZG1hID0gKHVzZV9kbWEpID8gMSA6IDA7CkBAIC03OTYsOCAr
Nzg4LDcgQEAgc3RhdGljIGludCBweGEzeHhfbmFuZF9lY2NfY29ycmVjdChzdHJ1Y3QgbXRkX2lu
Zm8gKm10ZCwKIAogc3RhdGljIGludCBfX3JlYWRpZChzdHJ1Y3QgcHhhM3h4X25hbmRfaW5mbyAq
aW5mbywgdWludDMyX3QgKmlkKQogewotCWNvbnN0IHN0cnVjdCBweGEzeHhfbmFuZF9mbGFzaCAq
ZiA9IGluZm8tPmZsYXNoX2luZm87Ci0JY29uc3Qgc3RydWN0IHB4YTN4eF9uYW5kX2NtZHNldCAq
Y21kc2V0ID0gZi0+Y21kc2V0OworCWNvbnN0IHN0cnVjdCBweGEzeHhfbmFuZF9jbWRzZXQgKmNt
ZHNldCA9IGluZm8tPmNtZHNldDsKIAl1aW50MzJfdCBuZGNyOwogCXVpbnQ4X3QgIGlkX2J1ZmZb
OF07CiAKQEAgLTgzOSw2ICs4MzAsOSBAQCBzdGF0aWMgaW50IHB4YTN4eF9uYW5kX2NvbmZpZ19m
bGFzaChzdHJ1Y3QgcHhhM3h4X25hbmRfaW5mbyAqaW5mbywKIAkJcmV0dXJuIC1FSU5WQUw7CiAK
IAkvKiBjYWxjdWxhdGUgZmxhc2ggaW5mb3JtYXRpb24gKi8KKwlpbmZvLT5jbWRzZXQgPSBmLT5j
bWRzZXQ7CisJaW5mby0+cGFnZV9zaXplID0gZi0+cGFnZV9zaXplOworCWluZm8tPm9vYl9idWZm
ID0gaW5mby0+ZGF0YV9idWZmICsgZi0+cGFnZV9zaXplOwogCWluZm8tPm9vYl9zaXplID0gKGYt
PnBhZ2Vfc2l6ZSA9PSAyMDQ4KSA/IDY0IDogMTY7CiAJaW5mby0+cmVhZF9pZF9ieXRlcyA9IChm
LT5wYWdlX3NpemUgPT0gMjA0OCkgPyA0IDogMjsKIApAQCAtODYzLDQ0ICs4NTcsMjAgQEAgc3Rh
dGljIGludCBweGEzeHhfbmFuZF9jb25maWdfZmxhc2goc3RydWN0IHB4YTN4eF9uYW5kX2luZm8g
KmluZm8sCiAJaW5mby0+cmVnX25kY3IgPSBuZGNyOwogCiAJcHhhM3h4X25hbmRfc2V0X3RpbWlu
ZyhpbmZvLCBmLT50aW1pbmcpOwotCWluZm8tPmZsYXNoX2luZm8gPSBmOwogCXJldHVybiAwOwog
fQogCi1zdGF0aWMgdm9pZCBweGEzeHhfbmFuZF9kZXRlY3RfdGltaW5nKHN0cnVjdCBweGEzeHhf
bmFuZF9pbmZvICppbmZvLAotCQkJCSAgICAgIHN0cnVjdCBweGEzeHhfbmFuZF90aW1pbmcgKnQp
Ci17Ci0JdW5zaWduZWQgbG9uZyBuYW5kX2NsayA9IGNsa19nZXRfcmF0ZShpbmZvLT5jbGspOwot
CXVpbnQzMl90IG5kdHIwID0gbmFuZF9yZWFkbChpbmZvLCBORFRSMENTMCk7Ci0JdWludDMyX3Qg
bmR0cjEgPSBuYW5kX3JlYWRsKGluZm8sIE5EVFIxQ1MwKTsKLQotCXQtPnRDSCA9IGN5Y2xlMm5z
KHRDSF9ORFRSMChuZHRyMCksIG5hbmRfY2xrKTsKLQl0LT50Q1MgPSBjeWNsZTJucyh0Q1NfTkRU
UjAobmR0cjApLCBuYW5kX2Nsayk7Ci0JdC0+dFdIID0gY3ljbGUybnModFdIX05EVFIwKG5kdHIw
KSwgbmFuZF9jbGspOwotCXQtPnRXUCA9IGN5Y2xlMm5zKHRXUF9ORFRSMChuZHRyMCksIG5hbmRf
Y2xrKTsKLQl0LT50UkggPSBjeWNsZTJucyh0UkhfTkRUUjAobmR0cjApLCBuYW5kX2Nsayk7Ci0J
dC0+dFJQID0gY3ljbGUybnModFJQX05EVFIwKG5kdHIwKSwgbmFuZF9jbGspOwotCi0JdC0+dFIg
PSBjeWNsZTJucyh0Ul9ORFRSMShuZHRyMSksIG5hbmRfY2xrKTsKLQl0LT50V0hSID0gY3ljbGUy
bnModFdIUl9ORFRSMShuZHRyMSksIG5hbmRfY2xrKTsKLQl0LT50QVIgPSBjeWNsZTJucyh0QVJf
TkRUUjEobmR0cjEpLCBuYW5kX2Nsayk7Ci19Ci0KIHN0YXRpYyBpbnQgcHhhM3h4X25hbmRfZGV0
ZWN0X2NvbmZpZyhzdHJ1Y3QgcHhhM3h4X25hbmRfaW5mbyAqaW5mbykKIHsKIAl1aW50MzJfdCBu
ZGNyID0gbmFuZF9yZWFkbChpbmZvLCBORENSKTsKIAlzdHJ1Y3QgbmFuZF9mbGFzaF9kZXYgKnR5
cGUgPSBOVUxMOwotCXVpbnQzMl90IGlkID0gLTE7CisJdWludDMyX3QgaWQgPSAtMSwgcGFnZV9w
ZXJfYmxvY2ssIG51bV9ibG9ja3M7CiAJaW50IGk7CiAKLQlkZWZhdWx0X2ZsYXNoLnBhZ2VfcGVy
X2Jsb2NrID0gbmRjciAmIE5EQ1JfUEdfUEVSX0JMSyA/IDY0IDogMzI7Ci0JZGVmYXVsdF9mbGFz
aC5wYWdlX3NpemUgPSBuZGNyICYgTkRDUl9QQUdFX1NaID8gMjA0OCA6IDUxMjsKLQlkZWZhdWx0
X2ZsYXNoLmZsYXNoX3dpZHRoID0gbmRjciAmIE5EQ1JfRFdJRFRIX00gPyAxNiA6IDg7Ci0JZGVm
YXVsdF9mbGFzaC5kZmNfd2lkdGggPSBuZGNyICYgTkRDUl9EV0lEVEhfQyA/IDE2IDogODsKLQor
CXBhZ2VfcGVyX2Jsb2NrID0gbmRjciAmIE5EQ1JfUEdfUEVSX0JMSyA/IDY0IDogMzI7CisJaW5m
by0+cGFnZV9zaXplID0gbmRjciAmIE5EQ1JfUEFHRV9TWiA/IDIwNDggOiA1MTI7CiAJLyogc2V0
IGluZm8gZmllbGRzIG5lZWRlZCB0byBfX3JlYWRpZCAqLwotCWluZm8tPmZsYXNoX2luZm8gPSAm
ZGVmYXVsdF9mbGFzaDsKLQlpbmZvLT5yZWFkX2lkX2J5dGVzID0gKGRlZmF1bHRfZmxhc2gucGFn
ZV9zaXplID09IDIwNDgpID8gNCA6IDI7CisJaW5mby0+cmVhZF9pZF9ieXRlcyA9IChpbmZvLT5w
YWdlX3NpemUgPT0gMjA0OCkgPyA0IDogMjsKIAlpbmZvLT5yZWdfbmRjciA9IG5kY3I7CiAKIAlp
ZiAoX19yZWFkaWQoaW5mbywgJmlkKSkKQEAgLTkxOSwyMiArODg5LDIyIEBAIHN0YXRpYyBpbnQg
cHhhM3h4X25hbmRfZGV0ZWN0X2NvbmZpZyhzdHJ1Y3QgcHhhM3h4X25hbmRfaW5mbyAqaW5mbykK
IAkJcmV0dXJuIC1FTk9ERVY7CiAKIAkvKiBmaWxsIHRoZSBtaXNzaW5nIGZsYXNoIGluZm9ybWF0
aW9uICovCi0JaSA9IF9fZmZzKGRlZmF1bHRfZmxhc2gucGFnZV9wZXJfYmxvY2sgKiBkZWZhdWx0
X2ZsYXNoLnBhZ2Vfc2l6ZSk7Ci0JZGVmYXVsdF9mbGFzaC5udW1fYmxvY2tzID0gdHlwZS0+Y2hp
cHNpemUgPDwgKDIwIC0gaSk7CisJaSA9IF9fZmZzKHBhZ2VfcGVyX2Jsb2NrICogaW5mby0+cGFn
ZV9zaXplKTsKKwludW1fYmxvY2tzID0gdHlwZS0+Y2hpcHNpemUgPDwgKDIwIC0gaSk7CiAKLQlp
bmZvLT5vb2Jfc2l6ZSA9IChkZWZhdWx0X2ZsYXNoLnBhZ2Vfc2l6ZSA9PSAyMDQ4KSA/IDY0IDog
MTY7CisJaW5mby0+b29iX3NpemUgPSAoaW5mby0+cGFnZV9zaXplID09IDIwNDgpID8gNjQgOiAx
NjsKIAogCS8qIGNhbGN1bGF0ZSBhZGRyZXNzaW5nIGluZm9ybWF0aW9uICovCi0JaW5mby0+Y29s
X2FkZHJfY3ljbGVzID0gKGRlZmF1bHRfZmxhc2gucGFnZV9zaXplID09IDIwNDgpID8gMiA6IDE7
CisJaW5mby0+Y29sX2FkZHJfY3ljbGVzID0gKGluZm8tPnBhZ2Vfc2l6ZSA9PSAyMDQ4KSA/IDIg
OiAxOwogCi0JaWYgKGRlZmF1bHRfZmxhc2gubnVtX2Jsb2NrcyAqIGRlZmF1bHRfZmxhc2gucGFn
ZV9wZXJfYmxvY2sgPiA2NTUzNikKKwlpZiAobnVtX2Jsb2NrcyAqIHBhZ2VfcGVyX2Jsb2NrID4g
NjU1MzYpCiAJCWluZm8tPnJvd19hZGRyX2N5Y2xlcyA9IDM7CiAJZWxzZQogCQlpbmZvLT5yb3df
YWRkcl9jeWNsZXMgPSAyOwogCi0JcHhhM3h4X25hbmRfZGV0ZWN0X3RpbWluZyhpbmZvLCAmZGVm
YXVsdF90aW1pbmcpOwotCWRlZmF1bHRfZmxhc2gudGltaW5nID0gJmRlZmF1bHRfdGltaW5nOwot
CWRlZmF1bHRfZmxhc2guY21kc2V0ID0gJmRlZmF1bHRfY21kc2V0OworCWluZm8tPm5kdHIwY3Mw
ID0gbmFuZF9yZWFkbChpbmZvLCBORFRSMENTMCk7CisJaW5mby0+bmR0cjFjczAgPSBuYW5kX3Jl
YWRsKGluZm8sIE5EVFIxQ1MwKTsKKwlpbmZvLT5jbWRzZXQgPSAmZGVmYXVsdF9jbWRzZXQ7CiAK
IAlyZXR1cm4gMDsKIH0KQEAgLTEwMzUsMTAgKzEwMDUsOSBAQCBzdGF0aWMgc3RydWN0IG5hbmRf
ZWNjbGF5b3V0IGh3X2xhcmdlcGFnZV9lY2NsYXlvdXQgPSB7CiBzdGF0aWMgdm9pZCBweGEzeHhf
bmFuZF9pbml0X210ZChzdHJ1Y3QgbXRkX2luZm8gKm10ZCwKIAkJCQkgc3RydWN0IHB4YTN4eF9u
YW5kX2luZm8gKmluZm8pCiB7Ci0JY29uc3Qgc3RydWN0IHB4YTN4eF9uYW5kX2ZsYXNoICpmID0g
aW5mby0+Zmxhc2hfaW5mbzsKIAlzdHJ1Y3QgbmFuZF9jaGlwICp0aGlzID0gJmluZm8tPm5hbmRf
Y2hpcDsKIAotCXRoaXMtPm9wdGlvbnMgPSAoZi0+Zmxhc2hfd2lkdGggPT0gMTYpID8gTkFORF9C
VVNXSURUSF8xNjogMDsKKwl0aGlzLT5vcHRpb25zID0gKGluZm8tPnJlZ19uZGNyICYgTkRDUl9E
V0lEVEhfQykgPyBOQU5EX0JVU1dJRFRIXzE2OiAwOwogCiAJdGhpcy0+d2FpdGZ1bmMJCT0gcHhh
M3h4X25hbmRfd2FpdGZ1bmM7CiAJdGhpcy0+c2VsZWN0X2NoaXAJPSBweGEzeHhfbmFuZF9zZWxl
Y3RfY2hpcDsKQEAgLTEwNTQsOSArMTAyMyw5IEBAIHN0YXRpYyB2b2lkIHB4YTN4eF9uYW5kX2lu
aXRfbXRkKHN0cnVjdCBtdGRfaW5mbyAqbXRkLAogCXRoaXMtPmVjYy5od2N0bAkJPSBweGEzeHhf
bmFuZF9lY2NfaHdjdGw7CiAJdGhpcy0+ZWNjLmNhbGN1bGF0ZQk9IHB4YTN4eF9uYW5kX2VjY19j
YWxjdWxhdGU7CiAJdGhpcy0+ZWNjLmNvcnJlY3QJPSBweGEzeHhfbmFuZF9lY2NfY29ycmVjdDsK
LQl0aGlzLT5lY2Muc2l6ZQkJPSBmLT5wYWdlX3NpemU7CisJdGhpcy0+ZWNjLnNpemUJCT0gaW5m
by0+cGFnZV9zaXplOwogCi0JaWYgKGYtPnBhZ2Vfc2l6ZSA9PSAyMDQ4KQorCWlmIChpbmZvLT5w
YWdlX3NpemUgPT0gMjA0OCkKIAkJdGhpcy0+ZWNjLmxheW91dCA9ICZod19sYXJnZXBhZ2VfZWNj
bGF5b3V0OwogCWVsc2UKIAkJdGhpcy0+ZWNjLmxheW91dCA9ICZod19zbWFsbHBhZ2VfZWNjbGF5
b3V0OwpAQCAtMTI2Myw5ICsxMjMyLDExIEBAIHN0YXRpYyBpbnQgcHhhM3h4X25hbmRfcmVzdW1l
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJc3RydWN0IG10ZF9pbmZvICptdGQgPSAo
c3RydWN0IG10ZF9pbmZvICopcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7CiAJc3RydWN0IHB4
YTN4eF9uYW5kX2luZm8gKmluZm8gPSBtdGQtPnByaXY7CiAKKwluYW5kX3dyaXRlbChpbmZvLCBO
RFRSMENTMCwgaW5mby0+bmR0cjBjczApOworCW5hbmRfd3JpdGVsKGluZm8sIE5EVFIxQ1MwLCBp
bmZvLT5uZHRyMWNzMCk7CiAJY2xrX2VuYWJsZShpbmZvLT5jbGspOwogCi0JcmV0dXJuIHB4YTN4
eF9uYW5kX2NvbmZpZ19mbGFzaChpbmZvLCBpbmZvLT5mbGFzaF9pbmZvKTsKKwlyZXR1cm4gMDsK
IH0KICNlbHNlCiAjZGVmaW5lIHB4YTN4eF9uYW5kX3N1c3BlbmQJTlVMTAotLSAKMS43LjAuNAoK
--000e0cdf9dfc0da4cd048e041c62--
