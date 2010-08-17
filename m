From: leiwen@marvell.com (Lei Wen)
Date: Tue, 17 Aug 2010 14:01:15 +0800
Subject: [PATCH 04/06] pxa3xx_nand: introduce default timing to reduce
Message-ID: <mailman.188.1282048214.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

read id times

We certainly don't need to send read id command times by times, since
we already know what the id is after the first read id...

So create a default timing which could ensure it would successfully read
id out all supported chip. Then follow the build-in table to reconfigure
the timing.

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |   68 +++++++++++++++++++--------------------
 1 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index e3061bc..61fe2e2 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -190,22 +190,27 @@ static struct pxa3xx_nand_cmdset default_cmdset = {
 };

 static struct pxa3xx_nand_timing __devinitdata timing[] = {
-	{ 10,  0, 20, 40, 30, 40, 11123, 110, 10, },
-	{ 10, 25, 15, 25, 15, 30, 25000,  60, 10, },
-	{ 10, 35, 15, 25, 15, 25, 25000,  60, 10, },
+	{ 40, 80, 60, 100, 80, 100, 90000, 400, 40, },
+	{ 10,  0, 20,  40, 30,  40, 11123, 110, 10, },
+	{ 10, 25, 15,  25, 15,  30, 25000,  60, 10, },
+	{ 10, 35, 15,  25, 15,  25, 25000,  60, 10, },
 };

 static struct pxa3xx_nand_flash __devinitdata builtin_flash_types[] = {
-	{ 0x46ec,  32,  512, 16, 16, 4096, &default_cmdset, &timing[0] },
-	{ 0xdaec,  64, 2048,  8,  8, 2048, &default_cmdset, &timing[0] },
-	{ 0xd7ec, 128, 4096,  8,  8, 8192, &default_cmdset, &timing[0] },
-	{ 0xa12c,  64, 2048,  8,  8, 1024, &default_cmdset, &timing[1] },
-	{ 0xb12c,  64, 2048, 16, 16, 1024, &default_cmdset, &timing[1] },
-	{ 0xdc2c,  64, 2048,  8,  8, 4096, &default_cmdset, &timing[1] },
-	{ 0xcc2c,  64, 2048, 16, 16, 4096, &default_cmdset, &timing[1] },
-	{ 0xba20,  64, 2048, 16, 16, 2048, &default_cmdset, &timing[2] },
+	{      0,   0, 2048,  8,  8,    0, &default_cmdset, &timing[0] },
+	{ 0x46ec,  32,  512, 16, 16, 4096, &default_cmdset, &timing[1] },
+	{ 0xdaec,  64, 2048,  8,  8, 2048, &default_cmdset, &timing[1] },
+	{ 0xd7ec, 128, 4096,  8,  8, 8192, &default_cmdset, &timing[1] },
+	{ 0xa12c,  64, 2048,  8,  8, 1024, &default_cmdset, &timing[2] },
+	{ 0xb12c,  64, 2048, 16, 16, 1024, &default_cmdset, &timing[2] },
+	{ 0xdc2c,  64, 2048,  8,  8, 4096, &default_cmdset, &timing[2] },
+	{ 0xcc2c,  64, 2048, 16, 16, 4096, &default_cmdset, &timing[2] },
+	{ 0xba20,  64, 2048, 16, 16, 2048, &default_cmdset, &timing[3] },
 };

+/* Define a default flash type setting serve as flash detecting only */
+#define DEFAULT_FLASH_TYPE (&builtin_flash_types[0])
+
 #define NDTR0_tCH(c)	(min((c), 7) << 19)
 #define NDTR0_tCS(c)	(min((c), 7) << 16)
 #define NDTR0_tWH(c)	(min((c), 7) << 11)
@@ -945,36 +950,29 @@ static int pxa3xx_nand_detect_flash(struct
pxa3xx_nand_info *info,
 		if (pxa3xx_nand_detect_config(info) == 0)
 			return 0;

-	for (i = 0; i<pdata->num_flash; ++i) {
-		f = pdata->flash + i;
-
-		if (pxa3xx_nand_config_flash(info, f))
-			continue;
-
-		if (__readid(info, &id))
-			continue;
-
-		if (id == f->chip_id)
-			return 0;
-	}
-
-	for (i = 0; i < ARRAY_SIZE(builtin_flash_types); i++) {
-
-		f = &builtin_flash_types[i];
-
-		if (pxa3xx_nand_config_flash(info, f))
-			continue;
-
-		if (__readid(info, &id))
-			continue;
-
-		if (id == f->chip_id)
+	/* we use default timing to detect id */
+	f = DEFAULT_FLASH_TYPE;
+	pxa3xx_nand_config_flash(info, f);
+	if (__readid(info, &id))
+		goto fail_detect;
+
+	for (i=0; i<ARRAY_SIZE(builtin_flash_types) + pdata->num_flash - 1; i++) {
+		/* we first choose the flash definition from platfrom */
+		if (i < pdata->num_flash)
+			f = pdata->flash + i;
+		else
+			f = &builtin_flash_types[i - pdata->num_flash + 1];
+		if (f->chip_id == id) {
+			dev_info(&info->pdev->dev, "detect chip id: 0x%x\n", id);
+			pxa3xx_nand_config_flash(info, f);
 			return 0;
+		}
 	}

 	dev_warn(&info->pdev->dev,
 		 "failed to detect configured nand flash; found %04x instead of\n",
 		 id);
+fail_detect:
 	return -ENODEV;
 }

-- 
1.7.0.4

--0016364c7bd1941297048e041bf3
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0004-pxa3xx_nand-introduce-default-timing-to-reduce-read-.patch"
Content-Disposition: attachment; 
	filename="0004-pxa3xx_nand-introduce-default-timing-to-reduce-read-.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gcyq3x7u0

RnJvbSA5OGY4NzMxM2RkY2JiMTliNDFkN2M2MmI2OTE2OTI3OTM3MWU4M2Q4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMZWkgV2VuIDxsZWl3ZW5AbWFydmVsbC5jb20+CkRhdGU6IFR1
ZSwgMTcgQXVnIDIwMTAgMTQ6MDE6MTUgKzA4MDAKU3ViamVjdDogW1BBVENIIDA0LzEyXSBweGEz
eHhfbmFuZDogaW50cm9kdWNlIGRlZmF1bHQgdGltaW5nIHRvIHJlZHVjZSByZWFkIGlkIHRpbWVz
CgpXZSBjZXJ0YWlubHkgZG9uJ3QgbmVlZCB0byBzZW5kIHJlYWQgaWQgY29tbWFuZCB0aW1lcyBi
eSB0aW1lcywgc2luY2UKd2UgYWxyZWFkeSBrbm93IHdoYXQgdGhlIGlkIGlzIGFmdGVyIHRoZSBm
aXJzdCByZWFkIGlkLi4uCgpTbyBjcmVhdGUgYSBkZWZhdWx0IHRpbWluZyB3aGljaCBjb3VsZCBl
bnN1cmUgaXQgd291bGQgc3VjY2Vzc2Z1bGx5IHJlYWQKaWQgb3V0IGFsbCBzdXBwb3J0ZWQgY2hp
cC4gVGhlbiBmb2xsb3cgdGhlIGJ1aWxkLWluIHRhYmxlIHRvIHJlY29uZmlndXJlCnRoZSB0aW1p
bmcuCgpTaWduZWQtb2ZmLWJ5OiBMZWkgV2VuIDxsZWl3ZW5AbWFydmVsbC5jb20+ClNpZ25lZC1v
ZmYtYnk6IEhhb2ppYW4gWmh1YW5nIDxoYW9qaWFuLnpodWFuZ0BtYXJ2ZWxsLmNvbT4KLS0tCiBk
cml2ZXJzL210ZC9uYW5kL3B4YTN4eF9uYW5kLmMgfCAgIDY4ICsrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspLCAz
NSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9uYW5kL3B4YTN4eF9uYW5k
LmMgYi9kcml2ZXJzL210ZC9uYW5kL3B4YTN4eF9uYW5kLmMKaW5kZXggZTMwNjFiYy4uNjFmZTJl
MiAxMDA2NDQKLS0tIGEvZHJpdmVycy9tdGQvbmFuZC9weGEzeHhfbmFuZC5jCisrKyBiL2RyaXZl
cnMvbXRkL25hbmQvcHhhM3h4X25hbmQuYwpAQCAtMTkwLDIyICsxOTAsMjcgQEAgc3RhdGljIHN0
cnVjdCBweGEzeHhfbmFuZF9jbWRzZXQgZGVmYXVsdF9jbWRzZXQgPSB7CiB9OwogCiBzdGF0aWMg
c3RydWN0IHB4YTN4eF9uYW5kX3RpbWluZyBfX2RldmluaXRkYXRhIHRpbWluZ1tdID0gewotCXsg
MTAsICAwLCAyMCwgNDAsIDMwLCA0MCwgMTExMjMsIDExMCwgMTAsIH0sCi0JeyAxMCwgMjUsIDE1
LCAyNSwgMTUsIDMwLCAyNTAwMCwgIDYwLCAxMCwgfSwKLQl7IDEwLCAzNSwgMTUsIDI1LCAxNSwg
MjUsIDI1MDAwLCAgNjAsIDEwLCB9LAorCXsgNDAsIDgwLCA2MCwgMTAwLCA4MCwgMTAwLCA5MDAw
MCwgNDAwLCA0MCwgfSwKKwl7IDEwLCAgMCwgMjAsICA0MCwgMzAsICA0MCwgMTExMjMsIDExMCwg
MTAsIH0sCisJeyAxMCwgMjUsIDE1LCAgMjUsIDE1LCAgMzAsIDI1MDAwLCAgNjAsIDEwLCB9LAor
CXsgMTAsIDM1LCAxNSwgIDI1LCAxNSwgIDI1LCAyNTAwMCwgIDYwLCAxMCwgfSwKIH07CiAKIHN0
YXRpYyBzdHJ1Y3QgcHhhM3h4X25hbmRfZmxhc2ggX19kZXZpbml0ZGF0YSBidWlsdGluX2ZsYXNo
X3R5cGVzW10gPSB7Ci0JeyAweDQ2ZWMsICAzMiwgIDUxMiwgMTYsIDE2LCA0MDk2LCAmZGVmYXVs
dF9jbWRzZXQsICZ0aW1pbmdbMF0gfSwKLQl7IDB4ZGFlYywgIDY0LCAyMDQ4LCAgOCwgIDgsIDIw
NDgsICZkZWZhdWx0X2NtZHNldCwgJnRpbWluZ1swXSB9LAotCXsgMHhkN2VjLCAxMjgsIDQwOTYs
ICA4LCAgOCwgODE5MiwgJmRlZmF1bHRfY21kc2V0LCAmdGltaW5nWzBdIH0sCi0JeyAweGExMmMs
ICA2NCwgMjA0OCwgIDgsICA4LCAxMDI0LCAmZGVmYXVsdF9jbWRzZXQsICZ0aW1pbmdbMV0gfSwK
LQl7IDB4YjEyYywgIDY0LCAyMDQ4LCAxNiwgMTYsIDEwMjQsICZkZWZhdWx0X2NtZHNldCwgJnRp
bWluZ1sxXSB9LAotCXsgMHhkYzJjLCAgNjQsIDIwNDgsICA4LCAgOCwgNDA5NiwgJmRlZmF1bHRf
Y21kc2V0LCAmdGltaW5nWzFdIH0sCi0JeyAweGNjMmMsICA2NCwgMjA0OCwgMTYsIDE2LCA0MDk2
LCAmZGVmYXVsdF9jbWRzZXQsICZ0aW1pbmdbMV0gfSwKLQl7IDB4YmEyMCwgIDY0LCAyMDQ4LCAx
NiwgMTYsIDIwNDgsICZkZWZhdWx0X2NtZHNldCwgJnRpbWluZ1syXSB9LAorCXsgICAgICAwLCAg
IDAsIDIwNDgsICA4LCAgOCwgICAgMCwgJmRlZmF1bHRfY21kc2V0LCAmdGltaW5nWzBdIH0sCisJ
eyAweDQ2ZWMsICAzMiwgIDUxMiwgMTYsIDE2LCA0MDk2LCAmZGVmYXVsdF9jbWRzZXQsICZ0aW1p
bmdbMV0gfSwKKwl7IDB4ZGFlYywgIDY0LCAyMDQ4LCAgOCwgIDgsIDIwNDgsICZkZWZhdWx0X2Nt
ZHNldCwgJnRpbWluZ1sxXSB9LAorCXsgMHhkN2VjLCAxMjgsIDQwOTYsICA4LCAgOCwgODE5Miwg
JmRlZmF1bHRfY21kc2V0LCAmdGltaW5nWzFdIH0sCisJeyAweGExMmMsICA2NCwgMjA0OCwgIDgs
ICA4LCAxMDI0LCAmZGVmYXVsdF9jbWRzZXQsICZ0aW1pbmdbMl0gfSwKKwl7IDB4YjEyYywgIDY0
LCAyMDQ4LCAxNiwgMTYsIDEwMjQsICZkZWZhdWx0X2NtZHNldCwgJnRpbWluZ1syXSB9LAorCXsg
MHhkYzJjLCAgNjQsIDIwNDgsICA4LCAgOCwgNDA5NiwgJmRlZmF1bHRfY21kc2V0LCAmdGltaW5n
WzJdIH0sCisJeyAweGNjMmMsICA2NCwgMjA0OCwgMTYsIDE2LCA0MDk2LCAmZGVmYXVsdF9jbWRz
ZXQsICZ0aW1pbmdbMl0gfSwKKwl7IDB4YmEyMCwgIDY0LCAyMDQ4LCAxNiwgMTYsIDIwNDgsICZk
ZWZhdWx0X2NtZHNldCwgJnRpbWluZ1szXSB9LAogfTsKIAorLyogRGVmaW5lIGEgZGVmYXVsdCBm
bGFzaCB0eXBlIHNldHRpbmcgc2VydmUgYXMgZmxhc2ggZGV0ZWN0aW5nIG9ubHkgKi8KKyNkZWZp
bmUgREVGQVVMVF9GTEFTSF9UWVBFICgmYnVpbHRpbl9mbGFzaF90eXBlc1swXSkKKwogI2RlZmlu
ZSBORFRSMF90Q0goYykJKG1pbigoYyksIDcpIDw8IDE5KQogI2RlZmluZSBORFRSMF90Q1MoYykJ
KG1pbigoYyksIDcpIDw8IDE2KQogI2RlZmluZSBORFRSMF90V0goYykJKG1pbigoYyksIDcpIDw8
IDExKQpAQCAtOTQ1LDM2ICs5NTAsMjkgQEAgc3RhdGljIGludCBweGEzeHhfbmFuZF9kZXRlY3Rf
Zmxhc2goc3RydWN0IHB4YTN4eF9uYW5kX2luZm8gKmluZm8sCiAJCWlmIChweGEzeHhfbmFuZF9k
ZXRlY3RfY29uZmlnKGluZm8pID09IDApCiAJCQlyZXR1cm4gMDsKIAotCWZvciAoaSA9IDA7IGk8
cGRhdGEtPm51bV9mbGFzaDsgKytpKSB7Ci0JCWYgPSBwZGF0YS0+Zmxhc2ggKyBpOwotCi0JCWlm
IChweGEzeHhfbmFuZF9jb25maWdfZmxhc2goaW5mbywgZikpCi0JCQljb250aW51ZTsKLQotCQlp
ZiAoX19yZWFkaWQoaW5mbywgJmlkKSkKLQkJCWNvbnRpbnVlOwotCi0JCWlmIChpZCA9PSBmLT5j
aGlwX2lkKQotCQkJcmV0dXJuIDA7Ci0JfQotCi0JZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUo
YnVpbHRpbl9mbGFzaF90eXBlcyk7IGkrKykgewotCi0JCWYgPSAmYnVpbHRpbl9mbGFzaF90eXBl
c1tpXTsKLQotCQlpZiAocHhhM3h4X25hbmRfY29uZmlnX2ZsYXNoKGluZm8sIGYpKQotCQkJY29u
dGludWU7Ci0KLQkJaWYgKF9fcmVhZGlkKGluZm8sICZpZCkpCi0JCQljb250aW51ZTsKLQotCQlp
ZiAoaWQgPT0gZi0+Y2hpcF9pZCkKKwkvKiB3ZSB1c2UgZGVmYXVsdCB0aW1pbmcgdG8gZGV0ZWN0
IGlkICovCisJZiA9IERFRkFVTFRfRkxBU0hfVFlQRTsKKwlweGEzeHhfbmFuZF9jb25maWdfZmxh
c2goaW5mbywgZik7CisJaWYgKF9fcmVhZGlkKGluZm8sICZpZCkpCisJCWdvdG8gZmFpbF9kZXRl
Y3Q7CisKKwlmb3IgKGk9MDsgaTxBUlJBWV9TSVpFKGJ1aWx0aW5fZmxhc2hfdHlwZXMpICsgcGRh
dGEtPm51bV9mbGFzaCAtIDE7IGkrKykgeworCQkvKiB3ZSBmaXJzdCBjaG9vc2UgdGhlIGZsYXNo
IGRlZmluaXRpb24gZnJvbSBwbGF0ZnJvbSAqLworCQlpZiAoaSA8IHBkYXRhLT5udW1fZmxhc2gp
CisJCQlmID0gcGRhdGEtPmZsYXNoICsgaTsKKwkJZWxzZQorCQkJZiA9ICZidWlsdGluX2ZsYXNo
X3R5cGVzW2kgLSBwZGF0YS0+bnVtX2ZsYXNoICsgMV07CisJCWlmIChmLT5jaGlwX2lkID09IGlk
KSB7CisJCQlkZXZfaW5mbygmaW5mby0+cGRldi0+ZGV2LCAiZGV0ZWN0IGNoaXAgaWQ6IDB4JXhc
biIsIGlkKTsKKwkJCXB4YTN4eF9uYW5kX2NvbmZpZ19mbGFzaChpbmZvLCBmKTsKIAkJCXJldHVy
biAwOworCQl9CiAJfQogCiAJZGV2X3dhcm4oJmluZm8tPnBkZXYtPmRldiwKIAkJICJmYWlsZWQg
dG8gZGV0ZWN0IGNvbmZpZ3VyZWQgbmFuZCBmbGFzaDsgZm91bmQgJTA0eCBpbnN0ZWFkIG9mXG4i
LAogCQkgaWQpOworZmFpbF9kZXRlY3Q6CiAJcmV0dXJuIC1FTk9ERVY7CiB9CiAKLS0gCjEuNy4w
LjQKCg==
--0016364c7bd1941297048e041bf3--
