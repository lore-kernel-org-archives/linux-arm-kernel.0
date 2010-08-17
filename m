From: leiwen@marvell.com (Lei Wen)
Date: Tue, 17 Aug 2010 17:24:06 +0800
Subject: [PATCH 01/06] pxa3xx_nand: update ns2cycle calculation method
Message-ID: <mailman.182.1282048185.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the original method change from plus 1 to minus 1,
this way make the default timing like tCS become 0 after calculation,
although we set the timing as 0xa...

Change the method to no plus and minus, and make the result
closer to what the timing specified in the NAND chip spec.

Signed-off-by: Lei Wen <leiwen@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index e02fa4f..4d89f37 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -363,7 +363,7 @@ static struct pxa3xx_nand_flash *builtin_flash_types[] = {
 #define tAR_NDTR1(r)	(((r) >> 0) & 0xf)

 /* convert nano-seconds to nand flash controller clock cycles */
-#define ns2cycle(ns, clk)	(int)(((ns) * (clk / 1000000) / 1000) - 1)
+#define ns2cycle(ns, clk)	(int)((ns) * (clk / 1000000) / 1000)

 /* convert nand flash controller clock cycles to nano-seconds */
 #define cycle2ns(c, clk)	((((c) + 1) * 1000000 + clk / 500) / (clk / 1000))
-- 
1.7.0.4

--0016363ba71c37c94b048e041a1c
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-pxa3xx_nand-update-ns2cycle-calculation-method.patch"
Content-Disposition: attachment; 
	filename="0001-pxa3xx_nand-update-ns2cycle-calculation-method.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gcypxq4k0

RnJvbSA5MDY0YjJjODc3Y2FkNTYwZmRhNzU3NzU2NGIzMzY5YzAwMjViN2RmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMZWkgV2VuIDxsZWl3ZW5AbWFydmVsbC5jb20+CkRhdGU6IFR1
ZSwgMTcgQXVnIDIwMTAgMTc6MjQ6MDYgKzA4MDAKU3ViamVjdDogW1BBVENIIDAxLzEyXSBweGEz
eHhfbmFuZDogdXBkYXRlIG5zMmN5Y2xlIGNhbGN1bGF0aW9uIG1ldGhvZAoKRm9yIHRoZSBvcmln
aW5hbCBtZXRob2QgY2hhbmdlIGZyb20gcGx1cyAxIHRvIG1pbnVzIDEsCnRoaXMgd2F5IG1ha2Ug
dGhlIGRlZmF1bHQgdGltaW5nIGxpa2UgdENTIGJlY29tZSAwIGFmdGVyIGNhbGN1bGF0aW9uLAph
bHRob3VnaCB3ZSBzZXQgdGhlIHRpbWluZyBhcyAweGEuLi4KCkNoYW5nZSB0aGUgbWV0aG9kIHRv
IG5vIHBsdXMgYW5kIG1pbnVzLCBhbmQgbWFrZSB0aGUgcmVzdWx0CmNsb3NlciB0byB3aGF0IHRo
ZSB0aW1pbmcgc3BlY2lmaWVkIGluIHRoZSBOQU5EIGNoaXAgc3BlYy4KClNpZ25lZC1vZmYtYnk6
IExlaSBXZW4gPGxlaXdlbkBtYXJ2ZWxsLmNvbT4KLS0tCiBkcml2ZXJzL210ZC9uYW5kL3B4YTN4
eF9uYW5kLmMgfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9uYW5kL3B4YTN4eF9uYW5kLmMg
Yi9kcml2ZXJzL210ZC9uYW5kL3B4YTN4eF9uYW5kLmMKaW5kZXggZTAyZmE0Zi4uNGQ4OWYzNyAx
MDA2NDQKLS0tIGEvZHJpdmVycy9tdGQvbmFuZC9weGEzeHhfbmFuZC5jCisrKyBiL2RyaXZlcnMv
bXRkL25hbmQvcHhhM3h4X25hbmQuYwpAQCAtMzYzLDcgKzM2Myw3IEBAIHN0YXRpYyBzdHJ1Y3Qg
cHhhM3h4X25hbmRfZmxhc2ggKmJ1aWx0aW5fZmxhc2hfdHlwZXNbXSA9IHsKICNkZWZpbmUgdEFS
X05EVFIxKHIpCSgoKHIpID4+IDApICYgMHhmKQogCiAvKiBjb252ZXJ0IG5hbm8tc2Vjb25kcyB0
byBuYW5kIGZsYXNoIGNvbnRyb2xsZXIgY2xvY2sgY3ljbGVzICovCi0jZGVmaW5lIG5zMmN5Y2xl
KG5zLCBjbGspCShpbnQpKCgobnMpICogKGNsayAvIDEwMDAwMDApIC8gMTAwMCkgLSAxKQorI2Rl
ZmluZSBuczJjeWNsZShucywgY2xrKQkoaW50KSgobnMpICogKGNsayAvIDEwMDAwMDApIC8gMTAw
MCkKIAogLyogY29udmVydCBuYW5kIGZsYXNoIGNvbnRyb2xsZXIgY2xvY2sgY3ljbGVzIHRvIG5h
bm8tc2Vjb25kcyAqLwogI2RlZmluZSBjeWNsZTJucyhjLCBjbGspCSgoKChjKSArIDEpICogMTAw
MDAwMCArIGNsayAvIDUwMCkgLyAoY2xrIC8gMTAwMCkpCi0tIAoxLjcuMC40Cgo=
--0016363ba71c37c94b048e041a1c--
