From: prakity@marvell.com (Philip Rakity)
Date: Sun, 19 Dec 2010 19:08:31 -0800
Subject: [PATCH] sdhci: delete clk gating code since not correct
Message-ID: <mailman.76.1293001980.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clock gating is using wrong registers for mmp2.
remove code -- future patch will add back support

Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Mark F. Brown <markb@marvell.com>
---
 arch/arm/plat-pxa/include/plat/sdhci.h |    1 -
 drivers/mmc/host/sdhci-pxa.c           |    9 ---------
 2 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h b/arch/arm/plat-pxa/inc=
lude/plat/sdhci.h
index 1ab332e..270fb2b 100644
--- a/arch/arm/plat-pxa/include/plat/sdhci.h
+++ b/arch/arm/plat-pxa/include/plat/sdhci.h
@@ -15,7 +15,6 @@
=20
 /* pxa specific flag */
 /* Require clock free running */
-#define PXA_FLAG_DISABLE_CLOCK_GATING (1<<0)
=20
 /* Board design supports 8-bit data on SD/SDIO BUS */
 #define PXA_FLAG_SD_8_BIT_CAPABLE_SLOT (1<<2)
diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index 5a61208..4713238 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -29,9 +29,6 @@
=20
 #define DRIVER_NAME	"sdhci-pxa"
=20
-#define SD_FIFO_PARAM		0x104
-#define DIS_PAD_SD_CLK_GATE	0x400
-
 struct sdhci_pxa {
 	struct sdhci_host		*host;
 	struct sdhci_pxa_platdata	*pdata;
@@ -49,7 +46,6 @@ struct sdhci_pxa {
 static void set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pxa *pxa =3D sdhci_priv(host);
-	u32 tmp =3D 0;
=20
 	if (clock =3D=3D 0) {
 		if (pxa->clk_enable) {
@@ -58,11 +54,6 @@ static void set_clock(struct sdhci_host *host, unsigned =
int clock)
 		}
 	} else {
 		if (0 =3D=3D pxa->clk_enable) {
-			if (pxa->pdata->flags & PXA_FLAG_DISABLE_CLOCK_GATING) {
-				tmp =3D readl(host->ioaddr + SD_FIFO_PARAM);
-				tmp |=3D DIS_PAD_SD_CLK_GATE;
-				writel(tmp, host->ioaddr + SD_FIFO_PARAM);
-			}
 			clk_enable(pxa->clk);
 			pxa->clk_enable =3D 1;
 		}
--=20
1.6.0.4



--_002_B8EC55D2F154492DAF7C39A779B4E740marvellcom_
Content-Type: application/octet-stream;
	name="0003-sdhci-delete-clk-gating-code-since-not-correct.patch"
Content-Description: 0003-sdhci-delete-clk-gating-code-since-not-correct.patch
Content-Disposition: attachment;
	filename="0003-sdhci-delete-clk-gating-code-since-not-correct.patch";
	size=2012; creation-date="Tue, 21 Dec 2010 23:07:47 GMT";
	modification-date="Tue, 21 Dec 2010 23:07:47 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1M2MyOGQ4MDU4NTM4ZjBiNzMxOTgyYWE2ZjBiNGVlMzhiZjUyZTQ0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgpE
YXRlOiBTdW4sIDE5IERlYyAyMDEwIDE5OjA4OjMxIC0wODAwClN1YmplY3Q6IFtQQVRDSF0gc2Ro
Y2k6IGRlbGV0ZSBjbGsgZ2F0aW5nIGNvZGUgc2luY2Ugbm90IGNvcnJlY3QKCmNsb2NrIGdhdGlu
ZyBpcyB1c2luZyB3cm9uZyByZWdpc3RlcnMgZm9yIG1tcDIuCnJlbW92ZSBjb2RlIC0tIGZ1dHVy
ZSBwYXRjaCB3aWxsIGFkZCBiYWNrIHN1cHBvcnQKClNpZ25lZC1vZmYtYnk6IFBoaWxpcCBSYWtp
dHkgPHByYWtpdHlAbWFydmVsbC5jb20+ClNpZ25lZC1vZmYtYnk6IE1hcmsgRi4gQnJvd24gPG1h
cmtiQG1hcnZlbGwuY29tPgotLS0KIGFyY2gvYXJtL3BsYXQtcHhhL2luY2x1ZGUvcGxhdC9zZGhj
aS5oIHwgICAgMSAtCiBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLXB4YS5jICAgICAgICAgICB8ICAg
IDkgLS0tLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDAgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vcGxhdC1weGEvaW5jbHVkZS9wbGF0L3NkaGNp
LmggYi9hcmNoL2FybS9wbGF0LXB4YS9pbmNsdWRlL3BsYXQvc2RoY2kuaAppbmRleCAxYWIzMzJl
Li4yNzBmYjJiIDEwMDY0NAotLS0gYS9hcmNoL2FybS9wbGF0LXB4YS9pbmNsdWRlL3BsYXQvc2Ro
Y2kuaAorKysgYi9hcmNoL2FybS9wbGF0LXB4YS9pbmNsdWRlL3BsYXQvc2RoY2kuaApAQCAtMTUs
NyArMTUsNiBAQAogCiAvKiBweGEgc3BlY2lmaWMgZmxhZyAqLwogLyogUmVxdWlyZSBjbG9jayBm
cmVlIHJ1bm5pbmcgKi8KLSNkZWZpbmUgUFhBX0ZMQUdfRElTQUJMRV9DTE9DS19HQVRJTkcgKDE8
PDApCiAKIC8qIEJvYXJkIGRlc2lnbiBzdXBwb3J0cyA4LWJpdCBkYXRhIG9uIFNEL1NESU8gQlVT
ICovCiAjZGVmaW5lIFBYQV9GTEFHX1NEXzhfQklUX0NBUEFCTEVfU0xPVCAoMTw8MikKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcHhhLmMgYi9kcml2ZXJzL21tYy9ob3N0L3Nk
aGNpLXB4YS5jCmluZGV4IDVhNjEyMDguLjQ3MTMyMzggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1j
L2hvc3Qvc2RoY2ktcHhhLmMKKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1weGEuYwpAQCAt
MjksOSArMjksNiBAQAogCiAjZGVmaW5lIERSSVZFUl9OQU1FCSJzZGhjaS1weGEiCiAKLSNkZWZp
bmUgU0RfRklGT19QQVJBTQkJMHgxMDQKLSNkZWZpbmUgRElTX1BBRF9TRF9DTEtfR0FURQkweDQw
MAotCiBzdHJ1Y3Qgc2RoY2lfcHhhIHsKIAlzdHJ1Y3Qgc2RoY2lfaG9zdAkJKmhvc3Q7CiAJc3Ry
dWN0IHNkaGNpX3B4YV9wbGF0ZGF0YQkqcGRhdGE7CkBAIC00OSw3ICs0Niw2IEBAIHN0cnVjdCBz
ZGhjaV9weGEgewogc3RhdGljIHZvaWQgc2V0X2Nsb2NrKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0
LCB1bnNpZ25lZCBpbnQgY2xvY2spCiB7CiAJc3RydWN0IHNkaGNpX3B4YSAqcHhhID0gc2RoY2lf
cHJpdihob3N0KTsKLQl1MzIgdG1wID0gMDsKIAogCWlmIChjbG9jayA9PSAwKSB7CiAJCWlmIChw
eGEtPmNsa19lbmFibGUpIHsKQEAgLTU4LDExICs1NCw2IEBAIHN0YXRpYyB2b2lkIHNldF9jbG9j
ayhzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgdW5zaWduZWQgaW50IGNsb2NrKQogCQl9CiAJfSBl
bHNlIHsKIAkJaWYgKDAgPT0gcHhhLT5jbGtfZW5hYmxlKSB7Ci0JCQlpZiAocHhhLT5wZGF0YS0+
ZmxhZ3MgJiBQWEFfRkxBR19ESVNBQkxFX0NMT0NLX0dBVElORykgewotCQkJCXRtcCA9IHJlYWRs
KGhvc3QtPmlvYWRkciArIFNEX0ZJRk9fUEFSQU0pOwotCQkJCXRtcCB8PSBESVNfUEFEX1NEX0NM
S19HQVRFOwotCQkJCXdyaXRlbCh0bXAsIGhvc3QtPmlvYWRkciArIFNEX0ZJRk9fUEFSQU0pOwot
CQkJfQogCQkJY2xrX2VuYWJsZShweGEtPmNsayk7CiAJCQlweGEtPmNsa19lbmFibGUgPSAxOwog
CQl9Ci0tIAoxLjYuMC40Cgo=

--_002_B8EC55D2F154492DAF7C39A779B4E740marvellcom_--
