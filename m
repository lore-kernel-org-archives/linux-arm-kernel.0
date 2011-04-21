From: njun@marvell.com (Jun Nie)
Date: Thu, 21 Apr 2011 09:32:07 +0800
Subject: [PATCH 3/3] ARM: mmp: support mmc on pxa910 dkb board
Message-ID: <mailman.207.1303351047.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jun Nie <njun@marvell.com>
---
 arch/arm/mach-mmp/include/mach/mfp-pxa910.h |   12 ++++++++++
 arch/arm/mach-mmp/ttc_dkb.c                 |   31 +++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/mfp-pxa910.h
b/arch/arm/mach-mmp/include/mach/mfp-pxa910.h
index d1150ab..45f97cd 100644
--- a/arch/arm/mach-mmp/include/mach/mfp-pxa910.h
+++ b/arch/arm/mach-mmp/include/mach/mfp-pxa910.h
@@ -159,6 +159,18 @@
 #define MMC1_CD_MMC1_CD		MFP_CFG_DRV(MMC1_CD, AF0, MEDIUM)
 #define MMC1_WP_MMC1_WP		MFP_CFG_DRV(MMC1_WP, AF0, MEDIUM)

+/* MMC2 */
+#define MMC2_DAT3_GPIO_33       MFP_CFG_DRV(GPIO33, AF1, MEDIUM)
+#define MMC2_DAT3_GPIO_34       MFP_CFG_DRV(GPIO34, AF1, MEDIUM)
+#define MMC2_DAT3_GPIO_35       MFP_CFG_DRV(GPIO35, AF1, MEDIUM)
+#define MMC2_DAT3_GPIO_36       MFP_CFG_DRV(GPIO36, AF1, MEDIUM)
+#define MMC2_DAT3_GPIO_37       MFP_CFG_DRV(GPIO37, AF1, MEDIUM)
+#define MMC2_DAT2_GPIO_38       MFP_CFG_DRV(GPIO38, AF1, MEDIUM)
+#define MMC2_DAT1_GPIO_39       MFP_CFG_DRV(GPIO39, AF1, MEDIUM)
+#define MMC2_DAT0_GPIO_40       MFP_CFG_DRV(GPIO40, AF1, MEDIUM)
+#define MMC2_CMD_GPIO_41        MFP_CFG_DRV(GPIO41, AF1, MEDIUM)
+#define MMC2_CLK_GPIO_42        MFP_CFG_DRV(GPIO42, AF1, VERY_SLOW)
+
 /* PWM */
 #define GPIO27_PWM3_AF2		MFP_CFG(GPIO27, AF2)
 #define GPIO51_PWM2_OUT		MFP_CFG(GPIO51, AF2)
diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index 473e0bc..01be50f 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -17,6 +17,8 @@
 #include <linux/interrupt.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
+#include <linux/mmc/sdhci.h>
+#include <linux/err.h>

 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -60,6 +62,24 @@ static unsigned long ttc_dkb_pin_config[] __initdata = {
 	DF_REn_DF_REn,
 	DF_RDY0_DF_RDY0,

+	/*sdh MMC0*/
+	MMC1_DAT3_MMC1_DAT3,
+	MMC1_DAT2_MMC1_DAT2,
+	MMC1_DAT1_MMC1_DAT1,
+	MMC1_DAT0_MMC1_DAT0,
+	MMC1_CMD_MMC1_CMD,
+	MMC1_CLK_MMC1_CLK,
+	MMC1_CD_MMC1_CD | MFP_PULL_HIGH,
+	MMC1_WP_MMC1_WP,
+
+	/*sdh MMC1*/
+	MMC2_DAT3_GPIO_37,
+	MMC2_DAT2_GPIO_38,
+	MMC2_DAT1_GPIO_39,
+	MMC2_DAT0_GPIO_40,
+	MMC2_CMD_GPIO_41,
+	MMC2_CLK_GPIO_42,
+
 	/* 2V8 SD/MMC regulator */
 	GPIO15_GPIO,
 };
@@ -149,12 +169,23 @@ static struct platform_device dkb_mmc_2v8_device = {
 	},
 };

+/* MMC0 controller for SD-MMC */
+static struct sdhci_pxa_platdata pxa910_sdh_platdata_mmc0 = {
+	.quirks                 = SDHCI_QUIRK_BROKEN_ADMA,
+};
+/* MMC1 controller for SDIO */
+static struct sdhci_pxa_platdata pxa910_sdh_platdata_mmc1 = {
+	.quirks                 = SDHCI_QUIRK_BROKEN_ADMA,
+};
+
 static void __init ttc_dkb_init(void)
 {
 	mfp_config(ARRAY_AND_SIZE(ttc_dkb_pin_config));

 	/* on-chip devices */
 	pxa910_add_uart(1);
+	pxa910_add_sdhost(0, &pxa910_sdh_platdata_mmc0);
+	pxa910_add_sdhost(1, &pxa910_sdh_platdata_mmc1);

 	/* off-chip devices */
 	platform_add_devices(ARRAY_AND_SIZE(ttc_dkb_devices));
-- 
1.7.0.4

--20cf307d0418edff4f04a1640fb6
Content-Type: text/x-diff; charset=US-ASCII; 
	name="0003-ARM-mmp-support-mmc-on-pxa910-dkb-board.patch"
Content-Disposition: attachment; 
	filename="0003-ARM-mmp-support-mmc-on-pxa910-dkb-board.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gmr15dhm0

RnJvbSA3NTllNjVlYjI0N2U1OWFmNGRlYmQ3YTdkMjU4ZmFkMGU4NThkMzZmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKdW4gTmllIDxuanVuQG1hcnZlbGwuY29tPgpEYXRlOiBUaHUs
IDIxIEFwciAyMDExIDA5OjMyOjA3ICswODAwClN1YmplY3Q6IFtQQVRDSCAzLzNdIEFSTTogbW1w
OiBzdXBwb3J0IG1tYyBvbiBweGE5MTAgZGtiIGJvYXJkCgpTaWduZWQtb2ZmLWJ5OiBKdW4gTmll
IDxuanVuQG1hcnZlbGwuY29tPgotLS0KIGFyY2gvYXJtL21hY2gtbW1wL2luY2x1ZGUvbWFjaC9t
ZnAtcHhhOTEwLmggfCAgIDEyICsrKysrKysrKysKIGFyY2gvYXJtL21hY2gtbW1wL3R0Y19ka2Iu
YyAgICAgICAgICAgICAgICAgfCAgIDMxICsrKysrKysrKysrKysrKysrKysrKysrKysrKwogMiBm
aWxlcyBjaGFuZ2VkLCA0MyBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2FyY2gvYXJtL21hY2gtbW1wL2luY2x1ZGUvbWFjaC9tZnAtcHhhOTEwLmggYi9hcmNoL2Fy
bS9tYWNoLW1tcC9pbmNsdWRlL21hY2gvbWZwLXB4YTkxMC5oCmluZGV4IGQxMTUwYWIuLjQ1Zjk3
Y2QgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtbW1wL2luY2x1ZGUvbWFjaC9tZnAtcHhhOTEw
LmgKKysrIGIvYXJjaC9hcm0vbWFjaC1tbXAvaW5jbHVkZS9tYWNoL21mcC1weGE5MTAuaApAQCAt
MTU5LDYgKzE1OSwxOCBAQAogI2RlZmluZSBNTUMxX0NEX01NQzFfQ0QJCU1GUF9DRkdfRFJWKE1N
QzFfQ0QsIEFGMCwgTUVESVVNKQogI2RlZmluZSBNTUMxX1dQX01NQzFfV1AJCU1GUF9DRkdfRFJW
KE1NQzFfV1AsIEFGMCwgTUVESVVNKQogCisvKiBNTUMyICovCisjZGVmaW5lIE1NQzJfREFUM19H
UElPXzMzICAgICAgIE1GUF9DRkdfRFJWKEdQSU8zMywgQUYxLCBNRURJVU0pCisjZGVmaW5lIE1N
QzJfREFUM19HUElPXzM0ICAgICAgIE1GUF9DRkdfRFJWKEdQSU8zNCwgQUYxLCBNRURJVU0pCisj
ZGVmaW5lIE1NQzJfREFUM19HUElPXzM1ICAgICAgIE1GUF9DRkdfRFJWKEdQSU8zNSwgQUYxLCBN
RURJVU0pCisjZGVmaW5lIE1NQzJfREFUM19HUElPXzM2ICAgICAgIE1GUF9DRkdfRFJWKEdQSU8z
NiwgQUYxLCBNRURJVU0pCisjZGVmaW5lIE1NQzJfREFUM19HUElPXzM3ICAgICAgIE1GUF9DRkdf
RFJWKEdQSU8zNywgQUYxLCBNRURJVU0pCisjZGVmaW5lIE1NQzJfREFUMl9HUElPXzM4ICAgICAg
IE1GUF9DRkdfRFJWKEdQSU8zOCwgQUYxLCBNRURJVU0pCisjZGVmaW5lIE1NQzJfREFUMV9HUElP
XzM5ICAgICAgIE1GUF9DRkdfRFJWKEdQSU8zOSwgQUYxLCBNRURJVU0pCisjZGVmaW5lIE1NQzJf
REFUMF9HUElPXzQwICAgICAgIE1GUF9DRkdfRFJWKEdQSU80MCwgQUYxLCBNRURJVU0pCisjZGVm
aW5lIE1NQzJfQ01EX0dQSU9fNDEgICAgICAgIE1GUF9DRkdfRFJWKEdQSU80MSwgQUYxLCBNRURJ
VU0pCisjZGVmaW5lIE1NQzJfQ0xLX0dQSU9fNDIgICAgICAgIE1GUF9DRkdfRFJWKEdQSU80Miwg
QUYxLCBWRVJZX1NMT1cpCisKIC8qIFBXTSAqLwogI2RlZmluZSBHUElPMjdfUFdNM19BRjIJCU1G
UF9DRkcoR1BJTzI3LCBBRjIpCiAjZGVmaW5lIEdQSU81MV9QV00yX09VVAkJTUZQX0NGRyhHUElP
NTEsIEFGMikKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtbW1wL3R0Y19ka2IuYyBiL2FyY2gv
YXJtL21hY2gtbW1wL3R0Y19ka2IuYwppbmRleCA0NzNlMGJjLi4wMWJlNTBmIDEwMDY0NAotLS0g
YS9hcmNoL2FybS9tYWNoLW1tcC90dGNfZGtiLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1tbXAvdHRj
X2RrYi5jCkBAIC0xNyw2ICsxNyw4IEBACiAjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+CiAj
aW5jbHVkZSA8bGludXgvcmVndWxhdG9yL21hY2hpbmUuaD4KICNpbmNsdWRlIDxsaW51eC9yZWd1
bGF0b3IvZml4ZWQuaD4KKyNpbmNsdWRlIDxsaW51eC9tbWMvc2RoY2kuaD4KKyNpbmNsdWRlIDxs
aW51eC9lcnIuaD4KIAogI2luY2x1ZGUgPGFzbS9tYWNoLXR5cGVzLmg+CiAjaW5jbHVkZSA8YXNt
L21hY2gvYXJjaC5oPgpAQCAtNjAsNiArNjIsMjQgQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgdHRj
X2RrYl9waW5fY29uZmlnW10gX19pbml0ZGF0YSA9IHsKIAlERl9SRW5fREZfUkVuLAogCURGX1JE
WTBfREZfUkRZMCwKIAorCS8qc2RoIE1NQzAqLworCU1NQzFfREFUM19NTUMxX0RBVDMsCisJTU1D
MV9EQVQyX01NQzFfREFUMiwKKwlNTUMxX0RBVDFfTU1DMV9EQVQxLAorCU1NQzFfREFUMF9NTUMx
X0RBVDAsCisJTU1DMV9DTURfTU1DMV9DTUQsCisJTU1DMV9DTEtfTU1DMV9DTEssCisJTU1DMV9D
RF9NTUMxX0NEIHwgTUZQX1BVTExfSElHSCwKKwlNTUMxX1dQX01NQzFfV1AsCisKKwkvKnNkaCBN
TUMxKi8KKwlNTUMyX0RBVDNfR1BJT18zNywKKwlNTUMyX0RBVDJfR1BJT18zOCwKKwlNTUMyX0RB
VDFfR1BJT18zOSwKKwlNTUMyX0RBVDBfR1BJT180MCwKKwlNTUMyX0NNRF9HUElPXzQxLAorCU1N
QzJfQ0xLX0dQSU9fNDIsCisKIAkvKiAyVjggU0QvTU1DIHJlZ3VsYXRvciAqLwogCUdQSU8xNV9H
UElPLAogfTsKQEAgLTE0OSwxMiArMTY5LDIzIEBAIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlIGRrYl9tbWNfMnY4X2RldmljZSA9IHsKIAl9LAogfTsKIAorLyogTU1DMCBjb250cm9sbGVy
IGZvciBTRC1NTUMgKi8KK3N0YXRpYyBzdHJ1Y3Qgc2RoY2lfcHhhX3BsYXRkYXRhIHB4YTkxMF9z
ZGhfcGxhdGRhdGFfbW1jMCA9IHsKKwkucXVpcmtzICAgICAgICAgICAgICAgICA9IFNESENJX1FV
SVJLX0JST0tFTl9BRE1BLAorfTsKKy8qIE1NQzEgY29udHJvbGxlciBmb3IgU0RJTyAqLworc3Rh
dGljIHN0cnVjdCBzZGhjaV9weGFfcGxhdGRhdGEgcHhhOTEwX3NkaF9wbGF0ZGF0YV9tbWMxID0g
eworCS5xdWlya3MgICAgICAgICAgICAgICAgID0gU0RIQ0lfUVVJUktfQlJPS0VOX0FETUEsCit9
OworCiBzdGF0aWMgdm9pZCBfX2luaXQgdHRjX2RrYl9pbml0KHZvaWQpCiB7CiAJbWZwX2NvbmZp
ZyhBUlJBWV9BTkRfU0laRSh0dGNfZGtiX3Bpbl9jb25maWcpKTsKIAogCS8qIG9uLWNoaXAgZGV2
aWNlcyAqLwogCXB4YTkxMF9hZGRfdWFydCgxKTsKKwlweGE5MTBfYWRkX3NkaG9zdCgwLCAmcHhh
OTEwX3NkaF9wbGF0ZGF0YV9tbWMwKTsKKwlweGE5MTBfYWRkX3NkaG9zdCgxLCAmcHhhOTEwX3Nk
aF9wbGF0ZGF0YV9tbWMxKTsKIAogCS8qIG9mZi1jaGlwIGRldmljZXMgKi8KIAlwbGF0Zm9ybV9h
ZGRfZGV2aWNlcyhBUlJBWV9BTkRfU0laRSh0dGNfZGtiX2RldmljZXMpKTsKLS0gCjEuNy4wLjQK
Cg==
--20cf307d0418edff4f04a1640fb6--
