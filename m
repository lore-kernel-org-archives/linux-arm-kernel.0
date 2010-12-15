From: prakity@marvell.com (Philip Rakity)
Date: Tue, 14 Dec 2010 17:02:19 -0800
Subject: [PATCH] sdhci: add platform support for setting f_max clock
Message-ID: <mailman.77.1293001992.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci-pxa.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index 0afc763..4c2a252 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -53,7 +53,15 @@ static void enable_clock(struct sdhci_host *host)
 	}
 }
=20
+static unsigned int get_f_max_clock(struct sdhci_host *host)
+{
+	struct sdhci_pxa *pxa =3D sdhci_priv(host);
+
+	return pxa->pdata->max_speed;
+}
+
 static struct sdhci_ops sdhci_pxa_ops =3D {
+	.get_f_max_clock =3D NULL,
 };
=20
 /*************************************************************************=
****\
@@ -131,15 +139,17 @@ static int __devinit sdhci_pxa_probe(struct platform_=
device *pdev)
 	/* do not rely on u-boot to enable the clocks */
 	enable_clock(host);
=20
+	if (pxa->pdata->max_speed)
+		sdhci_pxa_ops.get_f_max_clock =3D get_f_max_clock;
+	else
+		sdhci_pxa_ops.get_f_max_clock =3D NULL;
+
 	ret =3D sdhci_add_host(host);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add host\n");
 		goto out;
 	}
=20
-	if (pxa->pdata->max_speed)
-		host->mmc->f_max =3D pxa->pdata->max_speed;
-
 	platform_set_drvdata(pdev, host);
=20
 	return 0;
--=20
1.6.0.4

--_002_80760F7740FC43E6A8A0CB1814D8A191marvellcom_
Content-Type: application/octet-stream;
	name="0009-sdhci-add-platform-support-for-setting-f_max-clock.patch"
Content-Description: 0009-sdhci-add-platform-support-for-setting-f_max-clock.patch
Content-Disposition: attachment;
	filename="0009-sdhci-add-platform-support-for-setting-f_max-clock.patch";
	size=1482; creation-date="Tue, 21 Dec 2010 23:08:57 GMT";
	modification-date="Tue, 21 Dec 2010 23:08:57 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5Y2NhYmUyMzIwMjYxM2IyMDM3MDM3NGVkMjgyZjI1Yjk2YTRkNTdmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgpE
YXRlOiBUdWUsIDE0IERlYyAyMDEwIDE3OjAyOjE5IC0wODAwClN1YmplY3Q6IFtQQVRDSF0gc2Ro
Y2k6IGFkZCBwbGF0Zm9ybSBzdXBwb3J0IGZvciBzZXR0aW5nIGZfbWF4IGNsb2NrCgpTaWduZWQt
b2ZmLWJ5OiBQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgotLS0KIGRyaXZlcnMv
bW1jL2hvc3Qvc2RoY2ktcHhhLmMgfCAgIDE2ICsrKysrKysrKysrKystLS0KIDEgZmlsZXMgY2hh
bmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL21tYy9ob3N0L3NkaGNpLXB4YS5jIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1weGEuYwpp
bmRleCAwYWZjNzYzLi40YzJhMjUyIDEwMDY0NAotLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNp
LXB4YS5jCisrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcHhhLmMKQEAgLTUzLDcgKzUzLDE1
IEBAIHN0YXRpYyB2b2lkIGVuYWJsZV9jbG9jayhzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCkKIAl9
CiB9CiAKK3N0YXRpYyB1bnNpZ25lZCBpbnQgZ2V0X2ZfbWF4X2Nsb2NrKHN0cnVjdCBzZGhjaV9o
b3N0ICpob3N0KQoreworCXN0cnVjdCBzZGhjaV9weGEgKnB4YSA9IHNkaGNpX3ByaXYoaG9zdCk7
CisKKwlyZXR1cm4gcHhhLT5wZGF0YS0+bWF4X3NwZWVkOworfQorCiBzdGF0aWMgc3RydWN0IHNk
aGNpX29wcyBzZGhjaV9weGFfb3BzID0geworCS5nZXRfZl9tYXhfY2xvY2sgPSBOVUxMLAogfTsK
IAogLyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqXApAQCAtMTMxLDE1ICsxMzksMTcgQEAgc3RhdGljIGlu
dCBfX2RldmluaXQgc2RoY2lfcHhhX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
CiAJLyogZG8gbm90IHJlbHkgb24gdS1ib290IHRvIGVuYWJsZSB0aGUgY2xvY2tzICovCiAJZW5h
YmxlX2Nsb2NrKGhvc3QpOwogCisJaWYgKHB4YS0+cGRhdGEtPm1heF9zcGVlZCkKKwkJc2RoY2lf
cHhhX29wcy5nZXRfZl9tYXhfY2xvY2sgPSBnZXRfZl9tYXhfY2xvY2s7CisJZWxzZQorCQlzZGhj
aV9weGFfb3BzLmdldF9mX21heF9jbG9jayA9IE5VTEw7CisKIAlyZXQgPSBzZGhjaV9hZGRfaG9z
dChob3N0KTsKIAlpZiAocmV0KSB7CiAJCWRldl9lcnIoJnBkZXYtPmRldiwgImZhaWxlZCB0byBh
ZGQgaG9zdFxuIik7CiAJCWdvdG8gb3V0OwogCX0KIAotCWlmIChweGEtPnBkYXRhLT5tYXhfc3Bl
ZWQpCi0JCWhvc3QtPm1tYy0+Zl9tYXggPSBweGEtPnBkYXRhLT5tYXhfc3BlZWQ7Ci0KIAlwbGF0
Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBob3N0KTsKIAogCXJldHVybiAwOwotLSAKMS42LjAuNAoK

--_002_80760F7740FC43E6A8A0CB1814D8A191marvellcom_--
