From: prakity@marvell.com (Philip Rakity)
Date: Sun, 19 Dec 2010 20:28:40 -0800
Subject: [PATCH] plat-pxa: Enable ability to adjust SD/MMC clocks
Message-ID: <mailman.79.1293002018.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PXA168, PXA910, and MMP2 SoC have the ability to adjust the SD/MMC
clock.  This feature is useful and required depending on the board
design.  Add infrastructure to support SD clock tuning.

Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Mark F. Brown <markb@marvell.com>
Tested-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/plat-pxa/include/plat/sdhci.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h b/arch/arm/plat-pxa/inc=
lude/plat/sdhci.h
index 2762f99..3f73f1f 100644
--- a/arch/arm/plat-pxa/include/plat/sdhci.h
+++ b/arch/arm/plat-pxa/include/plat/sdhci.h
@@ -28,6 +28,9 @@
 struct sdhci_pxa_platdata {
 	unsigned int	max_speed;
 	unsigned int	flags;
+	unsigned short	adjust_clocks;
+	unsigned short	clk_select;
+	unsigned short	clk_delay;
 };
=20
 #endif /* __PLAT_PXA_SDHCI_H */
--=20
1.6.0.4

--_002_1F0BAC0EEB604E73A1C789667289DDAAmarvellcom_
Content-Type: application/octet-stream;
	name="0012-plat-pxa-Enable-ability-to-adjust-SD-MMC-clocks.patch"
Content-Description: 0012-plat-pxa-Enable-ability-to-adjust-SD-MMC-clocks.patch
Content-Disposition: attachment;
	filename="0012-plat-pxa-Enable-ability-to-adjust-SD-MMC-clocks.patch";
	size=1115; creation-date="Tue, 21 Dec 2010 23:09:27 GMT";
	modification-date="Tue, 21 Dec 2010 23:09:27 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1NTc3OWI4NjEwMTkyMWNmNjRjMGNjNGEyZTk1Nzg5ZDkxYzliMTZlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgpE
YXRlOiBTdW4sIDE5IERlYyAyMDEwIDIwOjI4OjQwIC0wODAwClN1YmplY3Q6IFtQQVRDSF0gcGxh
dC1weGE6IEVuYWJsZSBhYmlsaXR5IHRvIGFkanVzdCBTRC9NTUMgY2xvY2tzCgpUaGUgUFhBMTY4
LCBQWEE5MTAsIGFuZCBNTVAyIFNvQyBoYXZlIHRoZSBhYmlsaXR5IHRvIGFkanVzdCB0aGUgU0Qv
TU1DCmNsb2NrLiAgVGhpcyBmZWF0dXJlIGlzIHVzZWZ1bCBhbmQgcmVxdWlyZWQgZGVwZW5kaW5n
IG9uIHRoZSBib2FyZApkZXNpZ24uICBBZGQgaW5mcmFzdHJ1Y3R1cmUgdG8gc3VwcG9ydCBTRCBj
bG9jayB0dW5pbmcuCgpTaWduZWQtb2ZmLWJ5OiBQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZl
bGwuY29tPgpTaWduZWQtb2ZmLWJ5OiBNYXJrIEYuIEJyb3duIDxtYXJrYkBtYXJ2ZWxsLmNvbT4K
VGVzdGVkLWJ5OiBQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgotLS0KIGFyY2gv
YXJtL3BsYXQtcHhhL2luY2x1ZGUvcGxhdC9zZGhjaS5oIHwgICAgMyArKysKIDEgZmlsZXMgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL3BsYXQtcHhhL2luY2x1ZGUvcGxhdC9zZGhjaS5oIGIvYXJjaC9hcm0vcGxhdC1weGEvaW5j
bHVkZS9wbGF0L3NkaGNpLmgKaW5kZXggMjc2MmY5OS4uM2Y3M2YxZiAxMDA2NDQKLS0tIGEvYXJj
aC9hcm0vcGxhdC1weGEvaW5jbHVkZS9wbGF0L3NkaGNpLmgKKysrIGIvYXJjaC9hcm0vcGxhdC1w
eGEvaW5jbHVkZS9wbGF0L3NkaGNpLmgKQEAgLTI4LDYgKzI4LDkgQEAKIHN0cnVjdCBzZGhjaV9w
eGFfcGxhdGRhdGEgewogCXVuc2lnbmVkIGludAltYXhfc3BlZWQ7CiAJdW5zaWduZWQgaW50CWZs
YWdzOworCXVuc2lnbmVkIHNob3J0CWFkanVzdF9jbG9ja3M7CisJdW5zaWduZWQgc2hvcnQJY2xr
X3NlbGVjdDsKKwl1bnNpZ25lZCBzaG9ydAljbGtfZGVsYXk7CiB9OwogCiAjZW5kaWYgLyogX19Q
TEFUX1BYQV9TREhDSV9IICovCi0tIAoxLjYuMC40Cgo=

--_002_1F0BAC0EEB604E73A1C789667289DDAAmarvellcom_--
