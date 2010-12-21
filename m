From: prakity@marvell.com (Philip Rakity)
Date: Tue, 21 Dec 2010 11:29:33 -0800
Subject: [PATCH] mmc: fix regression testing bus width when CAP not defined
Message-ID: <mailman.88.1293002145.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

First reported by Zhangfei Gao.

set mmc bus width before checking for CAP for mmc bus width testing.
set bus width when card is not ddr

Signed-off-by: Philip Rakity <prakity@marvell.com>
Tested-by: Philip Rakity
---
 drivers/mmc/core/mmc.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 1d8409f..3a2905f 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -558,6 +558,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr=
,
 					 EXT_CSD_BUS_WIDTH,
 					 ext_csd_bits[idx][0]);
 			if (!err) {
+				mmc_set_bus_width_ddr(card->host,
+						      bus_width, MMC_SDR_MODE);
 				/*
 				 * If controller can't handle bus width test,
 				 * use the highest bus width to maintain
@@ -565,8 +567,6 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr=
,
 				 */
 				if (!(host->caps & MMC_CAP_BUS_WIDTH_TEST))
 					break;
-				mmc_set_bus_width_ddr(card->host,
-						      bus_width, MMC_SDR_MODE);
 				err =3D mmc_bus_test(card, bus_width);
 				if (!err)
 					break;
@@ -586,7 +586,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr=
,
 		} else if (ddr) {
 			mmc_card_set_ddr_mode(card);
 			mmc_set_bus_width_ddr(card->host, bus_width, ddr);
-		}
+		} else
+			mmc_set_bus_width (card->host, bus_width);
 	}
=20
 	if (!oldcard)
--=20
1.6.0.4

--_002_809DAEAF39234E7E968F62579BA961A5marvellcom_
Content-Type: application/octet-stream;
	name="0022-mmc-fix-regression-testing-bus-width-when-CAP-not-d.patch"
Content-Description: 0022-mmc-fix-regression-testing-bus-width-when-CAP-not-d.patch
Content-Disposition: attachment;
	filename="0022-mmc-fix-regression-testing-bus-width-when-CAP-not-d.patch";
	size=1596; creation-date="Tue, 21 Dec 2010 23:11:27 GMT";
	modification-date="Tue, 21 Dec 2010 23:11:27 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4YjM1ZTAwN2Q2N2RkNTkzZmY1ZThhMDdiNTY0YzQzOGU4MzAzYWFlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgpE
YXRlOiBUdWUsIDIxIERlYyAyMDEwIDExOjI5OjMzIC0wODAwClN1YmplY3Q6IFtQQVRDSF0gbW1j
OiBmaXggcmVncmVzc2lvbiB0ZXN0aW5nIGJ1cyB3aWR0aCB3aGVuIENBUCBub3QgZGVmaW5lZAoK
Rmlyc3QgcmVwb3J0ZWQgYnkgWmhhbmdmZWkgR2FvLgoKc2V0IG1tYyBidXMgd2lkdGggYmVmb3Jl
IGNoZWNraW5nIGZvciBDQVAgZm9yIG1tYyBidXMgd2lkdGggdGVzdGluZy4Kc2V0IGJ1cyB3aWR0
aCB3aGVuIGNhcmQgaXMgbm90IGRkcgoKU2lnbmVkLW9mZi1ieTogUGhpbGlwIFJha2l0eSA8cHJh
a2l0eUBtYXJ2ZWxsLmNvbT4KVGVzdGVkLWJ5OiBQaGlsaXAgUmFraXR5Ci0tLQogZHJpdmVycy9t
bWMvY29yZS9tbWMuYyB8ICAgIDcgKysrKy0tLQogMSBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9tbWMu
YyBiL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMKaW5kZXggMWQ4NDA5Zi4uM2EyOTA1ZiAxMDA2NDQK
LS0tIGEvZHJpdmVycy9tbWMvY29yZS9tbWMuYworKysgYi9kcml2ZXJzL21tYy9jb3JlL21tYy5j
CkBAIC01NTgsNiArNTU4LDggQEAgc3RhdGljIGludCBtbWNfaW5pdF9jYXJkKHN0cnVjdCBtbWNf
aG9zdCAqaG9zdCwgdTMyIG9jciwKIAkJCQkJIEVYVF9DU0RfQlVTX1dJRFRILAogCQkJCQkgZXh0
X2NzZF9iaXRzW2lkeF1bMF0pOwogCQkJaWYgKCFlcnIpIHsKKwkJCQltbWNfc2V0X2J1c193aWR0
aF9kZHIoY2FyZC0+aG9zdCwKKwkJCQkJCSAgICAgIGJ1c193aWR0aCwgTU1DX1NEUl9NT0RFKTsK
IAkJCQkvKgogCQkJCSAqIElmIGNvbnRyb2xsZXIgY2FuJ3QgaGFuZGxlIGJ1cyB3aWR0aCB0ZXN0
LAogCQkJCSAqIHVzZSB0aGUgaGlnaGVzdCBidXMgd2lkdGggdG8gbWFpbnRhaW4KQEAgLTU2NSw4
ICs1NjcsNiBAQCBzdGF0aWMgaW50IG1tY19pbml0X2NhcmQoc3RydWN0IG1tY19ob3N0ICpob3N0
LCB1MzIgb2NyLAogCQkJCSAqLwogCQkJCWlmICghKGhvc3QtPmNhcHMgJiBNTUNfQ0FQX0JVU19X
SURUSF9URVNUKSkKIAkJCQkJYnJlYWs7Ci0JCQkJbW1jX3NldF9idXNfd2lkdGhfZGRyKGNhcmQt
Pmhvc3QsCi0JCQkJCQkgICAgICBidXNfd2lkdGgsIE1NQ19TRFJfTU9ERSk7CiAJCQkJZXJyID0g
bW1jX2J1c190ZXN0KGNhcmQsIGJ1c193aWR0aCk7CiAJCQkJaWYgKCFlcnIpCiAJCQkJCWJyZWFr
OwpAQCAtNTg2LDcgKzU4Niw4IEBAIHN0YXRpYyBpbnQgbW1jX2luaXRfY2FyZChzdHJ1Y3QgbW1j
X2hvc3QgKmhvc3QsIHUzMiBvY3IsCiAJCX0gZWxzZSBpZiAoZGRyKSB7CiAJCQltbWNfY2FyZF9z
ZXRfZGRyX21vZGUoY2FyZCk7CiAJCQltbWNfc2V0X2J1c193aWR0aF9kZHIoY2FyZC0+aG9zdCwg
YnVzX3dpZHRoLCBkZHIpOwotCQl9CisJCX0gZWxzZQorCQkJbW1jX3NldF9idXNfd2lkdGggKGNh
cmQtPmhvc3QsIGJ1c193aWR0aCk7CiAJfQogCiAJaWYgKCFvbGRjYXJkKQotLSAKMS42LjAuNAoK

--_002_809DAEAF39234E7E968F62579BA961A5marvellcom_--
