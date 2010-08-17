From: leiwen@marvell.com (Lei Wen)
Date: Tue, 17 Aug 2010 14:09:30 +0800
Subject: [PATCH 06/06] pxa3xx_nand: set oob length in the runtime
Message-ID: <mailman.192.1282048239.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For different command need different oob requirement, set the proper
oob length by different cmd.

Signed-off-by: Lei Wen <leiwen@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |   25 ++++++++++++++++++-------
 1 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 27ed63f..70f2be0 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -273,13 +273,20 @@ static int wait_for_event(struct
pxa3xx_nand_info *info, uint32_t event)

 static void pxa3xx_set_datasize(struct pxa3xx_nand_info *info)
 {
-	/* calculate data size */
+	int oob_enable = info->reg_ndcr & NDCR_SPARE_EN;
+
+	info->data_size = info->page_size;
+	if (!oob_enable) {
+		info->oob_size = 0;
+		return;
+	}
+
 	switch (info->page_size) {
 	case 2048:
-		info->data_size = (info->use_ecc) ? 2088 : 2112;
+		info->oob_size = (info->use_ecc) ? 40 : 64;
 		break;
 	case 512:
-		info->data_size = (info->use_ecc) ? 520 : 528;
+		info->oob_size = (info->use_ecc) ? 8 : 16;
 		break;
 	}
 }
@@ -333,6 +340,7 @@ static int prepare_other_cmd(struct
pxa3xx_nand_info *info, uint16_t cmd)
 	info->ndcb1 = 0;
 	info->ndcb2 = 0;

+	info->oob_size = 0;
 	if (cmd == cmdset->read_id) {
 		info->ndcb0 |= NDCB0_CMD_TYPE(3);
 		info->data_size = 8;
@@ -401,6 +409,9 @@ static int handle_data_pio(struct pxa3xx_nand_info *info)
 	case STATE_PIO_WRITING:
 		__raw_writesl(info->mmio_base + NDDB, info->data_buff,
 				DIV_ROUND_UP(info->data_size, 4));
+		if (info->oob_size > 0)
+			__raw_writesl(info->mmio_base + NDDB, info->oob_buff,
+					DIV_ROUND_UP(info->oob_size, 4));

 		enable_int(info, NDSR_CS0_BBD | NDSR_CS0_CMDD);

@@ -413,6 +424,9 @@ static int handle_data_pio(struct pxa3xx_nand_info *info)
 	case STATE_PIO_READING:
 		__raw_readsl(info->mmio_base + NDDB, info->data_buff,
 				DIV_ROUND_UP(info->data_size, 4));
+		if (info->oob_size > 0)
+			__raw_readsl(info->mmio_base + NDDB, info->oob_buff,
+					DIV_ROUND_UP(info->oob_size, 4));
 		break;
 	default:
 		printk(KERN_ERR "%s: invalid state %d\n", __func__,
@@ -427,7 +441,7 @@ static int handle_data_pio(struct pxa3xx_nand_info *info)
 static void start_data_dma(struct pxa3xx_nand_info *info, int dir_out)
 {
 	struct pxa_dma_desc *desc = info->data_desc;
-	int dma_len = ALIGN(info->data_size, 32);
+	int dma_len = ALIGN(info->data_size + info->oob_size, 32);

 	desc->ddadr = DDADR_STOP;
 	desc->dcmd = DCMD_ENDIRQEN | DCMD_WIDTH4 | DCMD_BURST32 | dma_len;
@@ -833,7 +847,6 @@ static int pxa3xx_nand_config_flash(struct
pxa3xx_nand_info *info,
 	info->cmdset = f->cmdset;
 	info->page_size = f->page_size;
 	info->oob_buff = info->data_buff + f->page_size;
-	info->oob_size = (f->page_size == 2048) ? 64 : 16;
 	info->read_id_bytes = (f->page_size == 2048) ? 4 : 2;

 	/* calculate addressing information */
@@ -892,8 +905,6 @@ static int pxa3xx_nand_detect_config(struct
pxa3xx_nand_info *info)
 	i = __ffs(page_per_block * info->page_size);
 	num_blocks = type->chipsize << (20 - i);

-	info->oob_size = (info->page_size == 2048) ? 64 : 16;
-
 	/* calculate addressing information */
 	info->col_addr_cycles = (info->page_size == 2048) ? 2 : 1;

-- 
1.7.0.4

--0016e64c06fe8507a2048e041c98
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0006-pxa3xx_nand-set-oob-length-in-the-runtime.patch"
Content-Disposition: attachment; 
	filename="0006-pxa3xx_nand-set-oob-length-in-the-runtime.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gcyq4nte0

RnJvbSAxMDU0ZTZjYTRmNjAxMzlhZjE5MTVmNWQ0MWQ2ZTk4ODcwNTI4NjJlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMZWkgV2VuIDxsZWl3ZW5AbWFydmVsbC5jb20+CkRhdGU6IFR1
ZSwgMTcgQXVnIDIwMTAgMTQ6MDk6MzAgKzA4MDAKU3ViamVjdDogW1BBVENIIDA2LzEyXSBweGEz
eHhfbmFuZDogc2V0IG9vYiBsZW5ndGggaW4gdGhlIHJ1bnRpbWUKCkZvciBkaWZmZXJlbnQgY29t
bWFuZCBuZWVkIGRpZmZlcmVudCBvb2IgcmVxdWlyZW1lbnQsIHNldCB0aGUgcHJvcGVyCm9vYiBs
ZW5ndGggYnkgZGlmZmVyZW50IGNtZC4KClNpZ25lZC1vZmYtYnk6IExlaSBXZW4gPGxlaXdlbkBt
YXJ2ZWxsLmNvbT4KLS0tCiBkcml2ZXJzL210ZC9uYW5kL3B4YTN4eF9uYW5kLmMgfCAgIDI1ICsr
KysrKysrKysrKysrKysrKy0tLS0tLS0KIDEgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygr
KSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9uYW5kL3B4YTN4eF9u
YW5kLmMgYi9kcml2ZXJzL210ZC9uYW5kL3B4YTN4eF9uYW5kLmMKaW5kZXggMjdlZDYzZi4uNzBm
MmJlMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9tdGQvbmFuZC9weGEzeHhfbmFuZC5jCisrKyBiL2Ry
aXZlcnMvbXRkL25hbmQvcHhhM3h4X25hbmQuYwpAQCAtMjczLDEzICsyNzMsMjAgQEAgc3RhdGlj
IGludCB3YWl0X2Zvcl9ldmVudChzdHJ1Y3QgcHhhM3h4X25hbmRfaW5mbyAqaW5mbywgdWludDMy
X3QgZXZlbnQpCiAKIHN0YXRpYyB2b2lkIHB4YTN4eF9zZXRfZGF0YXNpemUoc3RydWN0IHB4YTN4
eF9uYW5kX2luZm8gKmluZm8pCiB7Ci0JLyogY2FsY3VsYXRlIGRhdGEgc2l6ZSAqLworCWludCBv
b2JfZW5hYmxlID0gaW5mby0+cmVnX25kY3IgJiBORENSX1NQQVJFX0VOOworCisJaW5mby0+ZGF0
YV9zaXplID0gaW5mby0+cGFnZV9zaXplOworCWlmICghb29iX2VuYWJsZSkgeworCQlpbmZvLT5v
b2Jfc2l6ZSA9IDA7CisJCXJldHVybjsKKwl9CisKIAlzd2l0Y2ggKGluZm8tPnBhZ2Vfc2l6ZSkg
ewogCWNhc2UgMjA0ODoKLQkJaW5mby0+ZGF0YV9zaXplID0gKGluZm8tPnVzZV9lY2MpID8gMjA4
OCA6IDIxMTI7CisJCWluZm8tPm9vYl9zaXplID0gKGluZm8tPnVzZV9lY2MpID8gNDAgOiA2NDsK
IAkJYnJlYWs7CiAJY2FzZSA1MTI6Ci0JCWluZm8tPmRhdGFfc2l6ZSA9IChpbmZvLT51c2VfZWNj
KSA/IDUyMCA6IDUyODsKKwkJaW5mby0+b29iX3NpemUgPSAoaW5mby0+dXNlX2VjYykgPyA4IDog
MTY7CiAJCWJyZWFrOwogCX0KIH0KQEAgLTMzMyw2ICszNDAsNyBAQCBzdGF0aWMgaW50IHByZXBh
cmVfb3RoZXJfY21kKHN0cnVjdCBweGEzeHhfbmFuZF9pbmZvICppbmZvLCB1aW50MTZfdCBjbWQp
CiAJaW5mby0+bmRjYjEgPSAwOwogCWluZm8tPm5kY2IyID0gMDsKIAorCWluZm8tPm9vYl9zaXpl
ID0gMDsKIAlpZiAoY21kID09IGNtZHNldC0+cmVhZF9pZCkgewogCQlpbmZvLT5uZGNiMCB8PSBO
RENCMF9DTURfVFlQRSgzKTsKIAkJaW5mby0+ZGF0YV9zaXplID0gODsKQEAgLTQwMSw2ICs0MDks
OSBAQCBzdGF0aWMgaW50IGhhbmRsZV9kYXRhX3BpbyhzdHJ1Y3QgcHhhM3h4X25hbmRfaW5mbyAq
aW5mbykKIAljYXNlIFNUQVRFX1BJT19XUklUSU5HOgogCQlfX3Jhd193cml0ZXNsKGluZm8tPm1t
aW9fYmFzZSArIE5EREIsIGluZm8tPmRhdGFfYnVmZiwKIAkJCQlESVZfUk9VTkRfVVAoaW5mby0+
ZGF0YV9zaXplLCA0KSk7CisJCWlmIChpbmZvLT5vb2Jfc2l6ZSA+IDApCisJCQlfX3Jhd193cml0
ZXNsKGluZm8tPm1taW9fYmFzZSArIE5EREIsIGluZm8tPm9vYl9idWZmLAorCQkJCQlESVZfUk9V
TkRfVVAoaW5mby0+b29iX3NpemUsIDQpKTsKIAogCQllbmFibGVfaW50KGluZm8sIE5EU1JfQ1Mw
X0JCRCB8IE5EU1JfQ1MwX0NNREQpOwogCkBAIC00MTMsNiArNDI0LDkgQEAgc3RhdGljIGludCBo
YW5kbGVfZGF0YV9waW8oc3RydWN0IHB4YTN4eF9uYW5kX2luZm8gKmluZm8pCiAJY2FzZSBTVEFU
RV9QSU9fUkVBRElORzoKIAkJX19yYXdfcmVhZHNsKGluZm8tPm1taW9fYmFzZSArIE5EREIsIGlu
Zm8tPmRhdGFfYnVmZiwKIAkJCQlESVZfUk9VTkRfVVAoaW5mby0+ZGF0YV9zaXplLCA0KSk7CisJ
CWlmIChpbmZvLT5vb2Jfc2l6ZSA+IDApCisJCQlfX3Jhd19yZWFkc2woaW5mby0+bW1pb19iYXNl
ICsgTkREQiwgaW5mby0+b29iX2J1ZmYsCisJCQkJCURJVl9ST1VORF9VUChpbmZvLT5vb2Jfc2l6
ZSwgNCkpOwogCQlicmVhazsKIAlkZWZhdWx0OgogCQlwcmludGsoS0VSTl9FUlIgIiVzOiBpbnZh
bGlkIHN0YXRlICVkXG4iLCBfX2Z1bmNfXywKQEAgLTQyNyw3ICs0NDEsNyBAQCBzdGF0aWMgaW50
IGhhbmRsZV9kYXRhX3BpbyhzdHJ1Y3QgcHhhM3h4X25hbmRfaW5mbyAqaW5mbykKIHN0YXRpYyB2
b2lkIHN0YXJ0X2RhdGFfZG1hKHN0cnVjdCBweGEzeHhfbmFuZF9pbmZvICppbmZvLCBpbnQgZGly
X291dCkKIHsKIAlzdHJ1Y3QgcHhhX2RtYV9kZXNjICpkZXNjID0gaW5mby0+ZGF0YV9kZXNjOwot
CWludCBkbWFfbGVuID0gQUxJR04oaW5mby0+ZGF0YV9zaXplLCAzMik7CisJaW50IGRtYV9sZW4g
PSBBTElHTihpbmZvLT5kYXRhX3NpemUgKyBpbmZvLT5vb2Jfc2l6ZSwgMzIpOwogCiAJZGVzYy0+
ZGRhZHIgPSBEREFEUl9TVE9QOwogCWRlc2MtPmRjbWQgPSBEQ01EX0VORElSUUVOIHwgRENNRF9X
SURUSDQgfCBEQ01EX0JVUlNUMzIgfCBkbWFfbGVuOwpAQCAtODMzLDcgKzg0Nyw2IEBAIHN0YXRp
YyBpbnQgcHhhM3h4X25hbmRfY29uZmlnX2ZsYXNoKHN0cnVjdCBweGEzeHhfbmFuZF9pbmZvICpp
bmZvLAogCWluZm8tPmNtZHNldCA9IGYtPmNtZHNldDsKIAlpbmZvLT5wYWdlX3NpemUgPSBmLT5w
YWdlX3NpemU7CiAJaW5mby0+b29iX2J1ZmYgPSBpbmZvLT5kYXRhX2J1ZmYgKyBmLT5wYWdlX3Np
emU7Ci0JaW5mby0+b29iX3NpemUgPSAoZi0+cGFnZV9zaXplID09IDIwNDgpID8gNjQgOiAxNjsK
IAlpbmZvLT5yZWFkX2lkX2J5dGVzID0gKGYtPnBhZ2Vfc2l6ZSA9PSAyMDQ4KSA/IDQgOiAyOwog
CiAJLyogY2FsY3VsYXRlIGFkZHJlc3NpbmcgaW5mb3JtYXRpb24gKi8KQEAgLTg5Miw4ICs5MDUs
NiBAQCBzdGF0aWMgaW50IHB4YTN4eF9uYW5kX2RldGVjdF9jb25maWcoc3RydWN0IHB4YTN4eF9u
YW5kX2luZm8gKmluZm8pCiAJaSA9IF9fZmZzKHBhZ2VfcGVyX2Jsb2NrICogaW5mby0+cGFnZV9z
aXplKTsKIAludW1fYmxvY2tzID0gdHlwZS0+Y2hpcHNpemUgPDwgKDIwIC0gaSk7CiAKLQlpbmZv
LT5vb2Jfc2l6ZSA9IChpbmZvLT5wYWdlX3NpemUgPT0gMjA0OCkgPyA2NCA6IDE2OwotCiAJLyog
Y2FsY3VsYXRlIGFkZHJlc3NpbmcgaW5mb3JtYXRpb24gKi8KIAlpbmZvLT5jb2xfYWRkcl9jeWNs
ZXMgPSAoaW5mby0+cGFnZV9zaXplID09IDIwNDgpID8gMiA6IDE7CiAKLS0gCjEuNy4wLjQKCg==
--0016e64c06fe8507a2048e041c98--
