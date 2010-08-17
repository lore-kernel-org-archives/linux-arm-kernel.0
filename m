From: leiwen@marvell.com (Lei Wen)
Date: Tue, 17 Aug 2010 13:50:23 +0800
Subject: [PATCH 02/12] pxa3xx_nand: condense the flash definition
Message-ID: <mailman.184.1282048191.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding a new flash definition would need less code.
Keep the platform passing flash definition method.
If one flash is both defined in platform data and builtin table,
driver would select the one from platform data first.

By this way, platform could select the timing most suit for itself,
not need to follow the common settings.

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/plat-pxa/include/plat/pxa3xx_nand.h |   18 ++--
 drivers/mtd/nand/Kconfig                     |    7 -
 drivers/mtd/nand/pxa3xx_nand.c               |  172 +++-----------------------
 3 files changed, 25 insertions(+), 172 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
b/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
index 3478eae..b0ae994 100644
--- a/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
+++ b/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
@@ -30,15 +30,15 @@ struct pxa3xx_nand_cmdset {
 };

 struct pxa3xx_nand_flash {
-	const struct pxa3xx_nand_timing *timing; /* NAND Flash timing */
-	const struct pxa3xx_nand_cmdset *cmdset;
-
-	uint32_t page_per_block;/* Pages per block (PG_PER_BLK) */
-	uint32_t page_size;	/* Page size in bytes (PAGE_SZ) */
-	uint32_t flash_width;	/* Width of Flash memory (DWIDTH_M) */
-	uint32_t dfc_width;	/* Width of flash controller(DWIDTH_C) */
-	uint32_t num_blocks;	/* Number of physical blocks in Flash */
-	uint32_t chip_id;
+	uint32_t	chip_id;
+	uint32_t	page_per_block; /* Pages per block (PG_PER_BLK) */
+	uint32_t	page_size;	/* Page size in bytes (PAGE_SZ) */
+	uint32_t	flash_width;	/* Width of Flash memory (DWIDTH_M) */
+	uint32_t	dfc_width;	/* Width of flash controller(DWIDTH_C) */
+	uint32_t	num_blocks;	/* Number of physical blocks in Flash */
+
+	struct pxa3xx_nand_cmdset *cmdset;	/* NAND command set */
+	struct pxa3xx_nand_timing *timing;	/* NAND Flash timing */
 };

 struct pxa3xx_nand_platform_data {
diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 8b4b67c..a6f22f5 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -400,13 +400,6 @@ config MTD_NAND_PXA3xx
 	  This enables the driver for the NAND flash device found on
 	  PXA3xx processors

-config MTD_NAND_PXA3xx_BUILTIN
-	bool "Use builtin definitions for some NAND chips (deprecated)"
-	depends on MTD_NAND_PXA3xx
-	help
-	  This enables builtin definitions for some NAND chips. This
-	  is deprecated in favor of platform specific data.
-
 config MTD_NAND_CM_X270
 	tristate "Support for NAND Flash on CM-X270 modules"
 	depends on MACH_ARMCORE
diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 4d89f37..02a4466 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -176,21 +176,7 @@ MODULE_PARM_DESC(use_dma, "enable DMA for data
transfering to/from NAND HW");
  */
 static struct pxa3xx_nand_timing default_timing;
 static struct pxa3xx_nand_flash default_flash;
-
-static struct pxa3xx_nand_cmdset smallpage_cmdset = {
-	.read1		= 0x0000,
-	.read2		= 0x0050,
-	.program	= 0x1080,
-	.read_status	= 0x0070,
-	.read_id	= 0x0090,
-	.erase		= 0xD060,
-	.reset		= 0x00FF,
-	.lock		= 0x002A,
-	.unlock		= 0x2423,
-	.lock_status	= 0x007A,
-};
-
-static struct pxa3xx_nand_cmdset largepage_cmdset = {
+static struct pxa3xx_nand_cmdset default_cmdset = {
 	.read1		= 0x3000,
 	.read2		= 0x0050,
 	.program	= 0x1080,
@@ -203,143 +189,23 @@ static struct pxa3xx_nand_cmdset largepage_cmdset = {
 	.lock_status	= 0x007A,
 };

-#ifdef CONFIG_MTD_NAND_PXA3xx_BUILTIN
-static struct pxa3xx_nand_timing samsung512MbX16_timing = {
-	.tCH	= 10,
-	.tCS	= 0,
-	.tWH	= 20,
-	.tWP	= 40,
-	.tRH	= 30,
-	.tRP	= 40,
-	.tR	= 11123,
-	.tWHR	= 110,
-	.tAR	= 10,
-};
-
-static struct pxa3xx_nand_flash samsung512MbX16 = {
-	.timing		= &samsung512MbX16_timing,
-	.cmdset		= &smallpage_cmdset,
-	.page_per_block	= 32,
-	.page_size	= 512,
-	.flash_width	= 16,
-	.dfc_width	= 16,
-	.num_blocks	= 4096,
-	.chip_id	= 0x46ec,
-};
-
-static struct pxa3xx_nand_flash samsung2GbX8 = {
-	.timing		= &samsung512MbX16_timing,
-	.cmdset		= &smallpage_cmdset,
-	.page_per_block	= 64,
-	.page_size	= 2048,
-	.flash_width	= 8,
-	.dfc_width	= 8,
-	.num_blocks	= 2048,
-	.chip_id	= 0xdaec,
-};
-
-static struct pxa3xx_nand_flash samsung32GbX8 = {
-	.timing		= &samsung512MbX16_timing,
-	.cmdset		= &smallpage_cmdset,
-	.page_per_block	= 128,
-	.page_size	= 4096,
-	.flash_width	= 8,
-	.dfc_width	= 8,
-	.num_blocks	= 8192,
-	.chip_id	= 0xd7ec,
+static struct pxa3xx_nand_timing __devinitdata timing[] = {
+	{ 10,  0, 20, 40, 30, 40, 11123, 110, 10, },
+	{ 10, 25, 15, 25, 15, 30, 25000,  60, 10, },
+	{ 10, 35, 15, 25, 15, 25, 25000,  60, 10, },
 };

-static struct pxa3xx_nand_timing micron_timing = {
-	.tCH	= 10,
-	.tCS	= 25,
-	.tWH	= 15,
-	.tWP	= 25,
-	.tRH	= 15,
-	.tRP	= 30,
-	.tR	= 25000,
-	.tWHR	= 60,
-	.tAR	= 10,
+static struct pxa3xx_nand_flash __devinitdata builtin_flash_types[] = {
+	{ 0x46ec,  32,  512, 16, 16, 4096, &default_cmdset, &timing[0] },
+	{ 0xdaec,  64, 2048,  8,  8, 2048, &default_cmdset, &timing[0] },
+	{ 0xd7ec, 128, 4096,  8,  8, 8192, &default_cmdset, &timing[0] },
+	{ 0xa12c,  64, 2048,  8,  8, 1024, &default_cmdset, &timing[1] },
+	{ 0xb12c,  64, 2048, 16, 16, 1024, &default_cmdset, &timing[1] },
+	{ 0xdc2c,  64, 2048,  8,  8, 4096, &default_cmdset, &timing[1] },
+	{ 0xcc2c,  64, 2048, 16, 16, 4096, &default_cmdset, &timing[1] },
+	{ 0xba20,  64, 2048, 16, 16, 2048, &default_cmdset, &timing[2] },
 };

-static struct pxa3xx_nand_flash micron1GbX8 = {
-	.timing		= &micron_timing,
-	.cmdset		= &largepage_cmdset,
-	.page_per_block	= 64,
-	.page_size	= 2048,
-	.flash_width	= 8,
-	.dfc_width	= 8,
-	.num_blocks	= 1024,
-	.chip_id	= 0xa12c,
-};
-
-static struct pxa3xx_nand_flash micron1GbX16 = {
-	.timing		= &micron_timing,
-	.cmdset		= &largepage_cmdset,
-	.page_per_block	= 64,
-	.page_size	= 2048,
-	.flash_width	= 16,
-	.dfc_width	= 16,
-	.num_blocks	= 1024,
-	.chip_id	= 0xb12c,
-};
-
-static struct pxa3xx_nand_flash micron4GbX8 = {
-	.timing		= &micron_timing,
-	.cmdset		= &largepage_cmdset,
-	.page_per_block	= 64,
-	.page_size	= 2048,
-	.flash_width	= 8,
-	.dfc_width	= 8,
-	.num_blocks	= 4096,
-	.chip_id	= 0xdc2c,
-};
-
-static struct pxa3xx_nand_flash micron4GbX16 = {
-	.timing		= &micron_timing,
-	.cmdset		= &largepage_cmdset,
-	.page_per_block	= 64,
-	.page_size	= 2048,
-	.flash_width	= 16,
-	.dfc_width	= 16,
-	.num_blocks	= 4096,
-	.chip_id	= 0xcc2c,
-};
-
-static struct pxa3xx_nand_timing stm2GbX16_timing = {
-	.tCH = 10,
-	.tCS = 35,
-	.tWH = 15,
-	.tWP = 25,
-	.tRH = 15,
-	.tRP = 25,
-	.tR = 25000,
-	.tWHR = 60,
-	.tAR = 10,
-};
-
-static struct pxa3xx_nand_flash stm2GbX16 = {
-	.timing = &stm2GbX16_timing,
-	.cmdset	= &largepage_cmdset,
-	.page_per_block = 64,
-	.page_size = 2048,
-	.flash_width = 16,
-	.dfc_width = 16,
-	.num_blocks = 2048,
-	.chip_id = 0xba20,
-};
-
-static struct pxa3xx_nand_flash *builtin_flash_types[] = {
-	&samsung512MbX16,
-	&samsung2GbX8,
-	&samsung32GbX8,
-	&micron1GbX8,
-	&micron1GbX16,
-	&micron4GbX8,
-	&micron4GbX16,
-	&stm2GbX16,
-};
-#endif /* CONFIG_MTD_NAND_PXA3xx_BUILTIN */
-
 #define NDTR0_tCH(c)	(min((c), 7) << 19)
 #define NDTR0_tCS(c)	(min((c), 7) << 16)
 #define NDTR0_tWH(c)	(min((c), 7) << 11)
@@ -1027,11 +893,6 @@ static int pxa3xx_nand_detect_config(struct
pxa3xx_nand_info *info)
 	default_flash.flash_width = ndcr & NDCR_DWIDTH_M ? 16 : 8;
 	default_flash.dfc_width = ndcr & NDCR_DWIDTH_C ? 16 : 8;

-	if (default_flash.page_size == 2048)
-		default_flash.cmdset = &largepage_cmdset;
-	else
-		default_flash.cmdset = &smallpage_cmdset;
-
 	/* set info fields needed to __readid */
 	info->flash_info = &default_flash;
 	info->read_id_bytes = (default_flash.page_size == 2048) ? 4 : 2;
@@ -1068,6 +929,7 @@ static int pxa3xx_nand_detect_config(struct
pxa3xx_nand_info *info)

 	pxa3xx_nand_detect_timing(info, &default_timing);
 	default_flash.timing = &default_timing;
+	default_flash.cmdset = &default_cmdset;

 	return 0;
 }
@@ -1096,10 +958,9 @@ static int pxa3xx_nand_detect_flash(struct
pxa3xx_nand_info *info,
 			return 0;
 	}

-#ifdef CONFIG_MTD_NAND_PXA3xx_BUILTIN
 	for (i = 0; i < ARRAY_SIZE(builtin_flash_types); i++) {

-		f = builtin_flash_types[i];
+		f = &builtin_flash_types[i];

 		if (pxa3xx_nand_config_flash(info, f))
 			continue;
@@ -1110,7 +971,6 @@ static int pxa3xx_nand_detect_flash(struct
pxa3xx_nand_info *info,
 		if (id == f->chip_id)
 			return 0;
 	}
-#endif

 	dev_warn(&info->pdev->dev,
 		 "failed to detect configured nand flash; found %04x instead of\n",
-- 
1.7.0.4

--0016e6dee753be2abc048e041a52
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0002-pxa3xx_nand-condense-the-flash-definition.patch"
Content-Disposition: attachment; 
	filename="0002-pxa3xx_nand-condense-the-flash-definition.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gcypyu7h0

RnJvbSA4MGFjNDE3MmYwYjA3NWVhMTc5OTQ3MDcyNThiNTU0NjRiYTViNmJmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMZWkgV2VuIDxsZWl3ZW5AbWFydmVsbC5jb20+CkRhdGU6IFR1
ZSwgMTcgQXVnIDIwMTAgMTM6NTA6MjMgKzA4MDAKU3ViamVjdDogW1BBVENIIDAyLzEyXSBweGEz
eHhfbmFuZDogY29uZGVuc2UgdGhlIGZsYXNoIGRlZmluaXRpb24KCkFkZGluZyBhIG5ldyBmbGFz
aCBkZWZpbml0aW9uIHdvdWxkIG5lZWQgbGVzcyBjb2RlLgpLZWVwIHRoZSBwbGF0Zm9ybSBwYXNz
aW5nIGZsYXNoIGRlZmluaXRpb24gbWV0aG9kLgpJZiBvbmUgZmxhc2ggaXMgYm90aCBkZWZpbmVk
IGluIHBsYXRmb3JtIGRhdGEgYW5kIGJ1aWx0aW4gdGFibGUsCmRyaXZlciB3b3VsZCBzZWxlY3Qg
dGhlIG9uZSBmcm9tIHBsYXRmb3JtIGRhdGEgZmlyc3QuCgpCeSB0aGlzIHdheSwgcGxhdGZvcm0g
Y291bGQgc2VsZWN0IHRoZSB0aW1pbmcgbW9zdCBzdWl0IGZvciBpdHNlbGYsCm5vdCBuZWVkIHRv
IGZvbGxvdyB0aGUgY29tbW9uIHNldHRpbmdzLgoKU2lnbmVkLW9mZi1ieTogTGVpIFdlbiA8bGVp
d2VuQG1hcnZlbGwuY29tPgpTaWduZWQtb2ZmLWJ5OiBIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56
aHVhbmdAbWFydmVsbC5jb20+Ci0tLQogYXJjaC9hcm0vcGxhdC1weGEvaW5jbHVkZS9wbGF0L3B4
YTN4eF9uYW5kLmggfCAgIDE4ICsrLS0KIGRyaXZlcnMvbXRkL25hbmQvS2NvbmZpZyAgICAgICAg
ICAgICAgICAgICAgIHwgICAgNyAtCiBkcml2ZXJzL210ZC9uYW5kL3B4YTN4eF9uYW5kLmMgICAg
ICAgICAgICAgICB8ICAxNzIgKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDMgZmlsZXMgY2hh
bmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgMTcyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtL3BsYXQtcHhhL2luY2x1ZGUvcGxhdC9weGEzeHhfbmFuZC5oIGIvYXJjaC9hcm0vcGxh
dC1weGEvaW5jbHVkZS9wbGF0L3B4YTN4eF9uYW5kLmgKaW5kZXggMzQ3OGVhZS4uYjBhZTk5NCAx
MDA2NDQKLS0tIGEvYXJjaC9hcm0vcGxhdC1weGEvaW5jbHVkZS9wbGF0L3B4YTN4eF9uYW5kLmgK
KysrIGIvYXJjaC9hcm0vcGxhdC1weGEvaW5jbHVkZS9wbGF0L3B4YTN4eF9uYW5kLmgKQEAgLTMw
LDE1ICszMCwxNSBAQCBzdHJ1Y3QgcHhhM3h4X25hbmRfY21kc2V0IHsKIH07CiAKIHN0cnVjdCBw
eGEzeHhfbmFuZF9mbGFzaCB7Ci0JY29uc3Qgc3RydWN0IHB4YTN4eF9uYW5kX3RpbWluZyAqdGlt
aW5nOyAvKiBOQU5EIEZsYXNoIHRpbWluZyAqLwotCWNvbnN0IHN0cnVjdCBweGEzeHhfbmFuZF9j
bWRzZXQgKmNtZHNldDsKLQotCXVpbnQzMl90IHBhZ2VfcGVyX2Jsb2NrOy8qIFBhZ2VzIHBlciBi
bG9jayAoUEdfUEVSX0JMSykgKi8KLQl1aW50MzJfdCBwYWdlX3NpemU7CS8qIFBhZ2Ugc2l6ZSBp
biBieXRlcyAoUEFHRV9TWikgKi8KLQl1aW50MzJfdCBmbGFzaF93aWR0aDsJLyogV2lkdGggb2Yg
Rmxhc2ggbWVtb3J5IChEV0lEVEhfTSkgKi8KLQl1aW50MzJfdCBkZmNfd2lkdGg7CS8qIFdpZHRo
IG9mIGZsYXNoIGNvbnRyb2xsZXIoRFdJRFRIX0MpICovCi0JdWludDMyX3QgbnVtX2Jsb2NrczsJ
LyogTnVtYmVyIG9mIHBoeXNpY2FsIGJsb2NrcyBpbiBGbGFzaCAqLwotCXVpbnQzMl90IGNoaXBf
aWQ7CisJdWludDMyX3QJY2hpcF9pZDsKKwl1aW50MzJfdAlwYWdlX3Blcl9ibG9jazsgLyogUGFn
ZXMgcGVyIGJsb2NrIChQR19QRVJfQkxLKSAqLworCXVpbnQzMl90CXBhZ2Vfc2l6ZTsJLyogUGFn
ZSBzaXplIGluIGJ5dGVzIChQQUdFX1NaKSAqLworCXVpbnQzMl90CWZsYXNoX3dpZHRoOwkvKiBX
aWR0aCBvZiBGbGFzaCBtZW1vcnkgKERXSURUSF9NKSAqLworCXVpbnQzMl90CWRmY193aWR0aDsJ
LyogV2lkdGggb2YgZmxhc2ggY29udHJvbGxlcihEV0lEVEhfQykgKi8KKwl1aW50MzJfdAludW1f
YmxvY2tzOwkvKiBOdW1iZXIgb2YgcGh5c2ljYWwgYmxvY2tzIGluIEZsYXNoICovCisKKwlzdHJ1
Y3QgcHhhM3h4X25hbmRfY21kc2V0ICpjbWRzZXQ7CS8qIE5BTkQgY29tbWFuZCBzZXQgKi8KKwlz
dHJ1Y3QgcHhhM3h4X25hbmRfdGltaW5nICp0aW1pbmc7CS8qIE5BTkQgRmxhc2ggdGltaW5nICov
CiB9OwogCiBzdHJ1Y3QgcHhhM3h4X25hbmRfcGxhdGZvcm1fZGF0YSB7CmRpZmYgLS1naXQgYS9k
cml2ZXJzL210ZC9uYW5kL0tjb25maWcgYi9kcml2ZXJzL210ZC9uYW5kL0tjb25maWcKaW5kZXgg
OGI0YjY3Yy4uYTZmMjJmNSAxMDA2NDQKLS0tIGEvZHJpdmVycy9tdGQvbmFuZC9LY29uZmlnCisr
KyBiL2RyaXZlcnMvbXRkL25hbmQvS2NvbmZpZwpAQCAtNDAwLDEzICs0MDAsNiBAQCBjb25maWcg
TVREX05BTkRfUFhBM3h4CiAJICBUaGlzIGVuYWJsZXMgdGhlIGRyaXZlciBmb3IgdGhlIE5BTkQg
Zmxhc2ggZGV2aWNlIGZvdW5kIG9uCiAJICBQWEEzeHggcHJvY2Vzc29ycwogCi1jb25maWcgTVRE
X05BTkRfUFhBM3h4X0JVSUxUSU4KLQlib29sICJVc2UgYnVpbHRpbiBkZWZpbml0aW9ucyBmb3Ig
c29tZSBOQU5EIGNoaXBzIChkZXByZWNhdGVkKSIKLQlkZXBlbmRzIG9uIE1URF9OQU5EX1BYQTN4
eAotCWhlbHAKLQkgIFRoaXMgZW5hYmxlcyBidWlsdGluIGRlZmluaXRpb25zIGZvciBzb21lIE5B
TkQgY2hpcHMuIFRoaXMKLQkgIGlzIGRlcHJlY2F0ZWQgaW4gZmF2b3Igb2YgcGxhdGZvcm0gc3Bl
Y2lmaWMgZGF0YS4KLQogY29uZmlnIE1URF9OQU5EX0NNX1gyNzAKIAl0cmlzdGF0ZSAiU3VwcG9y
dCBmb3IgTkFORCBGbGFzaCBvbiBDTS1YMjcwIG1vZHVsZXMiCiAJZGVwZW5kcyBvbiBNQUNIX0FS
TUNPUkUKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL25hbmQvcHhhM3h4X25hbmQuYyBiL2RyaXZl
cnMvbXRkL25hbmQvcHhhM3h4X25hbmQuYwppbmRleCA0ZDg5ZjM3Li4wMmE0NDY2IDEwMDY0NAot
LS0gYS9kcml2ZXJzL210ZC9uYW5kL3B4YTN4eF9uYW5kLmMKKysrIGIvZHJpdmVycy9tdGQvbmFu
ZC9weGEzeHhfbmFuZC5jCkBAIC0xNzYsMjEgKzE3Niw3IEBAIE1PRFVMRV9QQVJNX0RFU0ModXNl
X2RtYSwgImVuYWJsZSBETUEgZm9yIGRhdGEgdHJhbnNmZXJpbmcgdG8vZnJvbSBOQU5EIEhXIik7
CiAgKi8KIHN0YXRpYyBzdHJ1Y3QgcHhhM3h4X25hbmRfdGltaW5nIGRlZmF1bHRfdGltaW5nOwog
c3RhdGljIHN0cnVjdCBweGEzeHhfbmFuZF9mbGFzaCBkZWZhdWx0X2ZsYXNoOwotCi1zdGF0aWMg
c3RydWN0IHB4YTN4eF9uYW5kX2NtZHNldCBzbWFsbHBhZ2VfY21kc2V0ID0gewotCS5yZWFkMQkJ
PSAweDAwMDAsCi0JLnJlYWQyCQk9IDB4MDA1MCwKLQkucHJvZ3JhbQk9IDB4MTA4MCwKLQkucmVh
ZF9zdGF0dXMJPSAweDAwNzAsCi0JLnJlYWRfaWQJPSAweDAwOTAsCi0JLmVyYXNlCQk9IDB4RDA2
MCwKLQkucmVzZXQJCT0gMHgwMEZGLAotCS5sb2NrCQk9IDB4MDAyQSwKLQkudW5sb2NrCQk9IDB4
MjQyMywKLQkubG9ja19zdGF0dXMJPSAweDAwN0EsCi19OwotCi1zdGF0aWMgc3RydWN0IHB4YTN4
eF9uYW5kX2NtZHNldCBsYXJnZXBhZ2VfY21kc2V0ID0geworc3RhdGljIHN0cnVjdCBweGEzeHhf
bmFuZF9jbWRzZXQgZGVmYXVsdF9jbWRzZXQgPSB7CiAJLnJlYWQxCQk9IDB4MzAwMCwKIAkucmVh
ZDIJCT0gMHgwMDUwLAogCS5wcm9ncmFtCT0gMHgxMDgwLApAQCAtMjAzLDE0MyArMTg5LDIzIEBA
IHN0YXRpYyBzdHJ1Y3QgcHhhM3h4X25hbmRfY21kc2V0IGxhcmdlcGFnZV9jbWRzZXQgPSB7CiAJ
LmxvY2tfc3RhdHVzCT0gMHgwMDdBLAogfTsKIAotI2lmZGVmIENPTkZJR19NVERfTkFORF9QWEEz
eHhfQlVJTFRJTgotc3RhdGljIHN0cnVjdCBweGEzeHhfbmFuZF90aW1pbmcgc2Ftc3VuZzUxMk1i
WDE2X3RpbWluZyA9IHsKLQkudENICT0gMTAsCi0JLnRDUwk9IDAsCi0JLnRXSAk9IDIwLAotCS50
V1AJPSA0MCwKLQkudFJICT0gMzAsCi0JLnRSUAk9IDQwLAotCS50Ugk9IDExMTIzLAotCS50V0hS
CT0gMTEwLAotCS50QVIJPSAxMCwKLX07Ci0KLXN0YXRpYyBzdHJ1Y3QgcHhhM3h4X25hbmRfZmxh
c2ggc2Ftc3VuZzUxMk1iWDE2ID0gewotCS50aW1pbmcJCT0gJnNhbXN1bmc1MTJNYlgxNl90aW1p
bmcsCi0JLmNtZHNldAkJPSAmc21hbGxwYWdlX2NtZHNldCwKLQkucGFnZV9wZXJfYmxvY2sJPSAz
MiwKLQkucGFnZV9zaXplCT0gNTEyLAotCS5mbGFzaF93aWR0aAk9IDE2LAotCS5kZmNfd2lkdGgJ
PSAxNiwKLQkubnVtX2Jsb2Nrcwk9IDQwOTYsCi0JLmNoaXBfaWQJPSAweDQ2ZWMsCi19OwotCi1z
dGF0aWMgc3RydWN0IHB4YTN4eF9uYW5kX2ZsYXNoIHNhbXN1bmcyR2JYOCA9IHsKLQkudGltaW5n
CQk9ICZzYW1zdW5nNTEyTWJYMTZfdGltaW5nLAotCS5jbWRzZXQJCT0gJnNtYWxscGFnZV9jbWRz
ZXQsCi0JLnBhZ2VfcGVyX2Jsb2NrCT0gNjQsCi0JLnBhZ2Vfc2l6ZQk9IDIwNDgsCi0JLmZsYXNo
X3dpZHRoCT0gOCwKLQkuZGZjX3dpZHRoCT0gOCwKLQkubnVtX2Jsb2Nrcwk9IDIwNDgsCi0JLmNo
aXBfaWQJPSAweGRhZWMsCi19OwotCi1zdGF0aWMgc3RydWN0IHB4YTN4eF9uYW5kX2ZsYXNoIHNh
bXN1bmczMkdiWDggPSB7Ci0JLnRpbWluZwkJPSAmc2Ftc3VuZzUxMk1iWDE2X3RpbWluZywKLQku
Y21kc2V0CQk9ICZzbWFsbHBhZ2VfY21kc2V0LAotCS5wYWdlX3Blcl9ibG9jawk9IDEyOCwKLQku
cGFnZV9zaXplCT0gNDA5NiwKLQkuZmxhc2hfd2lkdGgJPSA4LAotCS5kZmNfd2lkdGgJPSA4LAot
CS5udW1fYmxvY2tzCT0gODE5MiwKLQkuY2hpcF9pZAk9IDB4ZDdlYywKK3N0YXRpYyBzdHJ1Y3Qg
cHhhM3h4X25hbmRfdGltaW5nIF9fZGV2aW5pdGRhdGEgdGltaW5nW10gPSB7CisJeyAxMCwgIDAs
IDIwLCA0MCwgMzAsIDQwLCAxMTEyMywgMTEwLCAxMCwgfSwKKwl7IDEwLCAyNSwgMTUsIDI1LCAx
NSwgMzAsIDI1MDAwLCAgNjAsIDEwLCB9LAorCXsgMTAsIDM1LCAxNSwgMjUsIDE1LCAyNSwgMjUw
MDAsICA2MCwgMTAsIH0sCiB9OwogCi1zdGF0aWMgc3RydWN0IHB4YTN4eF9uYW5kX3RpbWluZyBt
aWNyb25fdGltaW5nID0gewotCS50Q0gJPSAxMCwKLQkudENTCT0gMjUsCi0JLnRXSAk9IDE1LAot
CS50V1AJPSAyNSwKLQkudFJICT0gMTUsCi0JLnRSUAk9IDMwLAotCS50Ugk9IDI1MDAwLAotCS50
V0hSCT0gNjAsCi0JLnRBUgk9IDEwLAorc3RhdGljIHN0cnVjdCBweGEzeHhfbmFuZF9mbGFzaCBf
X2RldmluaXRkYXRhIGJ1aWx0aW5fZmxhc2hfdHlwZXNbXSA9IHsKKwl7IDB4NDZlYywgIDMyLCAg
NTEyLCAxNiwgMTYsIDQwOTYsICZkZWZhdWx0X2NtZHNldCwgJnRpbWluZ1swXSB9LAorCXsgMHhk
YWVjLCAgNjQsIDIwNDgsICA4LCAgOCwgMjA0OCwgJmRlZmF1bHRfY21kc2V0LCAmdGltaW5nWzBd
IH0sCisJeyAweGQ3ZWMsIDEyOCwgNDA5NiwgIDgsICA4LCA4MTkyLCAmZGVmYXVsdF9jbWRzZXQs
ICZ0aW1pbmdbMF0gfSwKKwl7IDB4YTEyYywgIDY0LCAyMDQ4LCAgOCwgIDgsIDEwMjQsICZkZWZh
dWx0X2NtZHNldCwgJnRpbWluZ1sxXSB9LAorCXsgMHhiMTJjLCAgNjQsIDIwNDgsIDE2LCAxNiwg
MTAyNCwgJmRlZmF1bHRfY21kc2V0LCAmdGltaW5nWzFdIH0sCisJeyAweGRjMmMsICA2NCwgMjA0
OCwgIDgsICA4LCA0MDk2LCAmZGVmYXVsdF9jbWRzZXQsICZ0aW1pbmdbMV0gfSwKKwl7IDB4Y2My
YywgIDY0LCAyMDQ4LCAxNiwgMTYsIDQwOTYsICZkZWZhdWx0X2NtZHNldCwgJnRpbWluZ1sxXSB9
LAorCXsgMHhiYTIwLCAgNjQsIDIwNDgsIDE2LCAxNiwgMjA0OCwgJmRlZmF1bHRfY21kc2V0LCAm
dGltaW5nWzJdIH0sCiB9OwogCi1zdGF0aWMgc3RydWN0IHB4YTN4eF9uYW5kX2ZsYXNoIG1pY3Jv
bjFHYlg4ID0gewotCS50aW1pbmcJCT0gJm1pY3Jvbl90aW1pbmcsCi0JLmNtZHNldAkJPSAmbGFy
Z2VwYWdlX2NtZHNldCwKLQkucGFnZV9wZXJfYmxvY2sJPSA2NCwKLQkucGFnZV9zaXplCT0gMjA0
OCwKLQkuZmxhc2hfd2lkdGgJPSA4LAotCS5kZmNfd2lkdGgJPSA4LAotCS5udW1fYmxvY2tzCT0g
MTAyNCwKLQkuY2hpcF9pZAk9IDB4YTEyYywKLX07Ci0KLXN0YXRpYyBzdHJ1Y3QgcHhhM3h4X25h
bmRfZmxhc2ggbWljcm9uMUdiWDE2ID0gewotCS50aW1pbmcJCT0gJm1pY3Jvbl90aW1pbmcsCi0J
LmNtZHNldAkJPSAmbGFyZ2VwYWdlX2NtZHNldCwKLQkucGFnZV9wZXJfYmxvY2sJPSA2NCwKLQku
cGFnZV9zaXplCT0gMjA0OCwKLQkuZmxhc2hfd2lkdGgJPSAxNiwKLQkuZGZjX3dpZHRoCT0gMTYs
Ci0JLm51bV9ibG9ja3MJPSAxMDI0LAotCS5jaGlwX2lkCT0gMHhiMTJjLAotfTsKLQotc3RhdGlj
IHN0cnVjdCBweGEzeHhfbmFuZF9mbGFzaCBtaWNyb240R2JYOCA9IHsKLQkudGltaW5nCQk9ICZt
aWNyb25fdGltaW5nLAotCS5jbWRzZXQJCT0gJmxhcmdlcGFnZV9jbWRzZXQsCi0JLnBhZ2VfcGVy
X2Jsb2NrCT0gNjQsCi0JLnBhZ2Vfc2l6ZQk9IDIwNDgsCi0JLmZsYXNoX3dpZHRoCT0gOCwKLQku
ZGZjX3dpZHRoCT0gOCwKLQkubnVtX2Jsb2Nrcwk9IDQwOTYsCi0JLmNoaXBfaWQJPSAweGRjMmMs
Ci19OwotCi1zdGF0aWMgc3RydWN0IHB4YTN4eF9uYW5kX2ZsYXNoIG1pY3JvbjRHYlgxNiA9IHsK
LQkudGltaW5nCQk9ICZtaWNyb25fdGltaW5nLAotCS5jbWRzZXQJCT0gJmxhcmdlcGFnZV9jbWRz
ZXQsCi0JLnBhZ2VfcGVyX2Jsb2NrCT0gNjQsCi0JLnBhZ2Vfc2l6ZQk9IDIwNDgsCi0JLmZsYXNo
X3dpZHRoCT0gMTYsCi0JLmRmY193aWR0aAk9IDE2LAotCS5udW1fYmxvY2tzCT0gNDA5NiwKLQku
Y2hpcF9pZAk9IDB4Y2MyYywKLX07Ci0KLXN0YXRpYyBzdHJ1Y3QgcHhhM3h4X25hbmRfdGltaW5n
IHN0bTJHYlgxNl90aW1pbmcgPSB7Ci0JLnRDSCA9IDEwLAotCS50Q1MgPSAzNSwKLQkudFdIID0g
MTUsCi0JLnRXUCA9IDI1LAotCS50UkggPSAxNSwKLQkudFJQID0gMjUsCi0JLnRSID0gMjUwMDAs
Ci0JLnRXSFIgPSA2MCwKLQkudEFSID0gMTAsCi19OwotCi1zdGF0aWMgc3RydWN0IHB4YTN4eF9u
YW5kX2ZsYXNoIHN0bTJHYlgxNiA9IHsKLQkudGltaW5nID0gJnN0bTJHYlgxNl90aW1pbmcsCi0J
LmNtZHNldAk9ICZsYXJnZXBhZ2VfY21kc2V0LAotCS5wYWdlX3Blcl9ibG9jayA9IDY0LAotCS5w
YWdlX3NpemUgPSAyMDQ4LAotCS5mbGFzaF93aWR0aCA9IDE2LAotCS5kZmNfd2lkdGggPSAxNiwK
LQkubnVtX2Jsb2NrcyA9IDIwNDgsCi0JLmNoaXBfaWQgPSAweGJhMjAsCi19OwotCi1zdGF0aWMg
c3RydWN0IHB4YTN4eF9uYW5kX2ZsYXNoICpidWlsdGluX2ZsYXNoX3R5cGVzW10gPSB7Ci0JJnNh
bXN1bmc1MTJNYlgxNiwKLQkmc2Ftc3VuZzJHYlg4LAotCSZzYW1zdW5nMzJHYlg4LAotCSZtaWNy
b24xR2JYOCwKLQkmbWljcm9uMUdiWDE2LAotCSZtaWNyb240R2JYOCwKLQkmbWljcm9uNEdiWDE2
LAotCSZzdG0yR2JYMTYsCi19OwotI2VuZGlmIC8qIENPTkZJR19NVERfTkFORF9QWEEzeHhfQlVJ
TFRJTiAqLwotCiAjZGVmaW5lIE5EVFIwX3RDSChjKQkobWluKChjKSwgNykgPDwgMTkpCiAjZGVm
aW5lIE5EVFIwX3RDUyhjKQkobWluKChjKSwgNykgPDwgMTYpCiAjZGVmaW5lIE5EVFIwX3RXSChj
KQkobWluKChjKSwgNykgPDwgMTEpCkBAIC0xMDI3LDExICs4OTMsNiBAQCBzdGF0aWMgaW50IHB4
YTN4eF9uYW5kX2RldGVjdF9jb25maWcoc3RydWN0IHB4YTN4eF9uYW5kX2luZm8gKmluZm8pCiAJ
ZGVmYXVsdF9mbGFzaC5mbGFzaF93aWR0aCA9IG5kY3IgJiBORENSX0RXSURUSF9NID8gMTYgOiA4
OwogCWRlZmF1bHRfZmxhc2guZGZjX3dpZHRoID0gbmRjciAmIE5EQ1JfRFdJRFRIX0MgPyAxNiA6
IDg7CiAKLQlpZiAoZGVmYXVsdF9mbGFzaC5wYWdlX3NpemUgPT0gMjA0OCkKLQkJZGVmYXVsdF9m
bGFzaC5jbWRzZXQgPSAmbGFyZ2VwYWdlX2NtZHNldDsKLQllbHNlCi0JCWRlZmF1bHRfZmxhc2gu
Y21kc2V0ID0gJnNtYWxscGFnZV9jbWRzZXQ7Ci0KIAkvKiBzZXQgaW5mbyBmaWVsZHMgbmVlZGVk
IHRvIF9fcmVhZGlkICovCiAJaW5mby0+Zmxhc2hfaW5mbyA9ICZkZWZhdWx0X2ZsYXNoOwogCWlu
Zm8tPnJlYWRfaWRfYnl0ZXMgPSAoZGVmYXVsdF9mbGFzaC5wYWdlX3NpemUgPT0gMjA0OCkgPyA0
IDogMjsKQEAgLTEwNjgsNiArOTI5LDcgQEAgc3RhdGljIGludCBweGEzeHhfbmFuZF9kZXRlY3Rf
Y29uZmlnKHN0cnVjdCBweGEzeHhfbmFuZF9pbmZvICppbmZvKQogCiAJcHhhM3h4X25hbmRfZGV0
ZWN0X3RpbWluZyhpbmZvLCAmZGVmYXVsdF90aW1pbmcpOwogCWRlZmF1bHRfZmxhc2gudGltaW5n
ID0gJmRlZmF1bHRfdGltaW5nOworCWRlZmF1bHRfZmxhc2guY21kc2V0ID0gJmRlZmF1bHRfY21k
c2V0OwogCiAJcmV0dXJuIDA7CiB9CkBAIC0xMDk2LDEwICs5NTgsOSBAQCBzdGF0aWMgaW50IHB4
YTN4eF9uYW5kX2RldGVjdF9mbGFzaChzdHJ1Y3QgcHhhM3h4X25hbmRfaW5mbyAqaW5mbywKIAkJ
CXJldHVybiAwOwogCX0KIAotI2lmZGVmIENPTkZJR19NVERfTkFORF9QWEEzeHhfQlVJTFRJTgog
CWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKGJ1aWx0aW5fZmxhc2hfdHlwZXMpOyBpKyspIHsK
IAotCQlmID0gYnVpbHRpbl9mbGFzaF90eXBlc1tpXTsKKwkJZiA9ICZidWlsdGluX2ZsYXNoX3R5
cGVzW2ldOwogCiAJCWlmIChweGEzeHhfbmFuZF9jb25maWdfZmxhc2goaW5mbywgZikpCiAJCQlj
b250aW51ZTsKQEAgLTExMTAsNyArOTcxLDYgQEAgc3RhdGljIGludCBweGEzeHhfbmFuZF9kZXRl
Y3RfZmxhc2goc3RydWN0IHB4YTN4eF9uYW5kX2luZm8gKmluZm8sCiAJCWlmIChpZCA9PSBmLT5j
aGlwX2lkKQogCQkJcmV0dXJuIDA7CiAJfQotI2VuZGlmCiAKIAlkZXZfd2FybigmaW5mby0+cGRl
di0+ZGV2LAogCQkgImZhaWxlZCB0byBkZXRlY3QgY29uZmlndXJlZCBuYW5kIGZsYXNoOyBmb3Vu
ZCAlMDR4IGluc3RlYWQgb2ZcbiIsCi0tIAoxLjcuMC40Cgo=
--0016e6dee753be2abc048e041a52--
