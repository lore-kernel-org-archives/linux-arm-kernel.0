From: zhangfei.gao@marvell.com (Zhangfei Gao)
Date: Wed, 29 Sep 2010 16:18:51 -0400
Subject: [PATCH 1/2] ARM: mmp2: add mmc resource
Message-ID: <mailman.10.1288775142.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 arch/arm/mach-mmp/include/mach/mmp2.h      |   22 +++++++++++++++++
 arch/arm/mach-mmp/include/mach/regs-apmu.h |    2 +
 arch/arm/mach-mmp/mmp2.c                   |   35 ++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/mmp2.h
b/arch/arm/mach-mmp/include/mach/mmp2.h
index dbba6e8..3c09cfb 100644
--- a/arch/arm/mach-mmp/include/mach/mmp2.h
+++ b/arch/arm/mach-mmp/include/mach/mmp2.h
@@ -1,6 +1,8 @@
 #ifndef __ASM_MACH_MMP2_H
 #define __ASM_MACH_MMP2_H

+#include <plat/sdhci.h>
+
 struct sys_timer;

 extern struct sys_timer mmp2_timer;
@@ -22,6 +24,10 @@ extern struct pxa_device_desc mmp2_device_twsi3;
 extern struct pxa_device_desc mmp2_device_twsi4;
 extern struct pxa_device_desc mmp2_device_twsi5;
 extern struct pxa_device_desc mmp2_device_twsi6;
+extern struct pxa_device_desc mmp2_device_sdh0;
+extern struct pxa_device_desc mmp2_device_sdh1;
+extern struct pxa_device_desc mmp2_device_sdh2;
+extern struct pxa_device_desc mmp2_device_sdh3;

 static inline int mmp2_add_uart(int id)
 {
@@ -63,5 +69,21 @@ static inline int mmp2_add_twsi(int id, struct
i2c_pxa_platform_data *data,
 	return pxa_register_device(d, data, sizeof(*data));
 }

+static inline int mmp2_add_sdh(int id, struct sdhci_pxa_platdata *data)
+{
+	struct pxa_device_desc *d = NULL;
+
+	switch (id) {
+	case 0: d = &mmp2_device_sdh0; break;
+	case 1: d = &mmp2_device_sdh1; break;
+	case 2: d = &mmp2_device_sdh2; break;
+	case 3: d = &mmp2_device_sdh3; break;
+	default:
+		return -EINVAL;
+	}
+
+	return pxa_register_device(d, data, sizeof(*data));
+}
+
 #endif /* __ASM_MACH_MMP2_H */

diff --git a/arch/arm/mach-mmp/include/mach/regs-apmu.h
b/arch/arm/mach-mmp/include/mach/regs-apmu.h
index ac47023..f7011ef 100644
--- a/arch/arm/mach-mmp/include/mach/regs-apmu.h
+++ b/arch/arm/mach-mmp/include/mach/regs-apmu.h
@@ -27,6 +27,8 @@
 #define APMU_DMA	APMU_REG(0x064)
 #define APMU_GEU	APMU_REG(0x068)
 #define APMU_BUS	APMU_REG(0x06c)
+#define APMU_SDH2	APMU_REG(0x0e8)
+#define APMU_SDH3	APMU_REG(0x0ec)

 #define APMU_FNCLK_EN	(1 << 4)
 #define APMU_AXICLK_EN	(1 << 3)
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index daf3993..9ed3cd2 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -115,6 +115,29 @@ void __init mmp2_init_irq(void)
 	mmp2_init_gpio();
 }

+static void sdhc_clk_enable(struct clk *clk)
+{
+	uint32_t clk_rst;
+
+	clk_rst  =  __raw_readl(clk->clk_rst);
+	clk_rst |= clk->enable_val;
+	__raw_writel(clk_rst, clk->clk_rst);
+}
+
+static void sdhc_clk_disable(struct clk *clk)
+{
+	uint32_t clk_rst;
+
+	clk_rst  =  __raw_readl(clk->clk_rst);
+	clk_rst &= ~clk->enable_val;
+	__raw_writel(clk_rst, clk->clk_rst);
+}
+
+struct clkops sdhc_clk_ops = {
+	.enable		= sdhc_clk_enable,
+	.disable	= sdhc_clk_disable,
+};
+
 /* APB peripheral clocks */
 static APBC_CLK(uart1, MMP2_UART1, 1, 26000000);
 static APBC_CLK(uart2, MMP2_UART2, 1, 26000000);
@@ -129,6 +152,10 @@ static APBC_CLK(twsi6, MMP2_TWSI6, 0, 26000000);
 static APBC_CLK(rtc, MMP2_RTC, 0, 32768);

 static APMU_CLK(nand, NAND, 0xbf, 100000000);
+static APMU_CLK_OPS(sdh0, SDH0, 0x1b, 200000000, &sdhc_clk_ops);
+static APMU_CLK_OPS(sdh1, SDH1, 0x1b, 200000000, &sdhc_clk_ops);
+static APMU_CLK_OPS(sdh2, SDH2, 0x1b, 200000000, &sdhc_clk_ops);
+static APMU_CLK_OPS(sdh3, SDH3, 0x1b, 200000000, &sdhc_clk_ops);

 static struct clk_lookup mmp2_clkregs[] = {
 	INIT_CLKREG(&clk_uart1, "pxa2xx-uart.0", NULL),
@@ -142,6 +169,10 @@ static struct clk_lookup mmp2_clkregs[] = {
 	INIT_CLKREG(&clk_twsi5, "pxa2xx-i2c.4", NULL),
 	INIT_CLKREG(&clk_twsi6, "pxa2xx-i2c.5", NULL),
 	INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
+	INIT_CLKREG(&clk_sdh0, "sdhci-pxa.0", "PXA-SDHCLK"),
+	INIT_CLKREG(&clk_sdh1, "sdhci-pxa.1", "PXA-SDHCLK"),
+	INIT_CLKREG(&clk_sdh2, "sdhci-pxa.2", "PXA-SDHCLK"),
+	INIT_CLKREG(&clk_sdh3, "sdhci-pxa.3", "PXA-SDHCLK"),
 };

 static int __init mmp2_init(void)
@@ -192,4 +223,8 @@ MMP2_DEVICE(twsi4, "pxa2xx-i2c", 3, TWSI4,
0xd4033000, 0x70);
 MMP2_DEVICE(twsi5, "pxa2xx-i2c", 4, TWSI5, 0xd4033800, 0x70);
 MMP2_DEVICE(twsi6, "pxa2xx-i2c", 5, TWSI6, 0xd4034000, 0x70);
 MMP2_DEVICE(nand, "pxa3xx-nand", -1, NAND, 0xd4283000, 0x100, 28, 29);
+MMP2_DEVICE(sdh0, "sdhci-pxa", 0, MMC, 0xd4280000, 0x120);
+MMP2_DEVICE(sdh1, "sdhci-pxa", 1, MMC2, 0xd4280800, 0x120);
+MMP2_DEVICE(sdh2, "sdhci-pxa", 2, MMC3, 0xd4281000, 0x120);
+MMP2_DEVICE(sdh3, "sdhci-pxa", 3, MMC4, 0xd4281800, 0x120);

-- 
1.7.0.4

--20cf30433ee81fb7f9049422582f
Content-Type: text/x-patch; charset=US-ASCII; name="0001-ARM-mmp2-add-mmc-resource.patch"
Content-Disposition: attachment; 
	filename="0001-ARM-mmp2-add-mmc-resource.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gg1ze4l40

RnJvbSBlZTdjMTEzNTE2NGFiZDFmNzY1MjQ2MmYxNzk3MmNhZDNkOTZjNzk1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNv
bT4KRGF0ZTogV2VkLCAyOSBTZXAgMjAxMCAxNjoxODo1MSAtMDQwMApTdWJqZWN0OiBbUEFUQ0gg
MS8yXSBBUk06IG1tcDI6IGFkZCBtbWMgcmVzb3VyY2UKClNpZ25lZC1vZmYtYnk6IFpoYW5nZmVp
IEdhbyA8emhhbmdmZWkuZ2FvQG1hcnZlbGwuY29tPgotLS0KIGFyY2gvYXJtL21hY2gtbW1wL2lu
Y2x1ZGUvbWFjaC9tbXAyLmggICAgICB8ICAgMjIgKysrKysrKysrKysrKysrKysKIGFyY2gvYXJt
L21hY2gtbW1wL2luY2x1ZGUvbWFjaC9yZWdzLWFwbXUuaCB8ICAgIDIgKwogYXJjaC9hcm0vbWFj
aC1tbXAvbW1wMi5jICAgICAgICAgICAgICAgICAgIHwgICAzNSArKysrKysrKysrKysrKysrKysr
KysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDU5IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1tbXAvaW5jbHVkZS9tYWNoL21tcDIuaCBi
L2FyY2gvYXJtL21hY2gtbW1wL2luY2x1ZGUvbWFjaC9tbXAyLmgKaW5kZXggZGJiYTZlOC4uM2Mw
OWNmYiAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1tbXAvaW5jbHVkZS9tYWNoL21tcDIuaAor
KysgYi9hcmNoL2FybS9tYWNoLW1tcC9pbmNsdWRlL21hY2gvbW1wMi5oCkBAIC0xLDYgKzEsOCBA
QAogI2lmbmRlZiBfX0FTTV9NQUNIX01NUDJfSAogI2RlZmluZSBfX0FTTV9NQUNIX01NUDJfSAog
CisjaW5jbHVkZSA8cGxhdC9zZGhjaS5oPgorCiBzdHJ1Y3Qgc3lzX3RpbWVyOwogCiBleHRlcm4g
c3RydWN0IHN5c190aW1lciBtbXAyX3RpbWVyOwpAQCAtMjIsNiArMjQsMTAgQEAgZXh0ZXJuIHN0
cnVjdCBweGFfZGV2aWNlX2Rlc2MgbW1wMl9kZXZpY2VfdHdzaTM7CiBleHRlcm4gc3RydWN0IHB4
YV9kZXZpY2VfZGVzYyBtbXAyX2RldmljZV90d3NpNDsKIGV4dGVybiBzdHJ1Y3QgcHhhX2Rldmlj
ZV9kZXNjIG1tcDJfZGV2aWNlX3R3c2k1OwogZXh0ZXJuIHN0cnVjdCBweGFfZGV2aWNlX2Rlc2Mg
bW1wMl9kZXZpY2VfdHdzaTY7CitleHRlcm4gc3RydWN0IHB4YV9kZXZpY2VfZGVzYyBtbXAyX2Rl
dmljZV9zZGgwOworZXh0ZXJuIHN0cnVjdCBweGFfZGV2aWNlX2Rlc2MgbW1wMl9kZXZpY2Vfc2Ro
MTsKK2V4dGVybiBzdHJ1Y3QgcHhhX2RldmljZV9kZXNjIG1tcDJfZGV2aWNlX3NkaDI7CitleHRl
cm4gc3RydWN0IHB4YV9kZXZpY2VfZGVzYyBtbXAyX2RldmljZV9zZGgzOwogCiBzdGF0aWMgaW5s
aW5lIGludCBtbXAyX2FkZF91YXJ0KGludCBpZCkKIHsKQEAgLTYzLDUgKzY5LDIxIEBAIHN0YXRp
YyBpbmxpbmUgaW50IG1tcDJfYWRkX3R3c2koaW50IGlkLCBzdHJ1Y3QgaTJjX3B4YV9wbGF0Zm9y
bV9kYXRhICpkYXRhLAogCXJldHVybiBweGFfcmVnaXN0ZXJfZGV2aWNlKGQsIGRhdGEsIHNpemVv
ZigqZGF0YSkpOwogfQogCitzdGF0aWMgaW5saW5lIGludCBtbXAyX2FkZF9zZGgoaW50IGlkLCBz
dHJ1Y3Qgc2RoY2lfcHhhX3BsYXRkYXRhICpkYXRhKQoreworCXN0cnVjdCBweGFfZGV2aWNlX2Rl
c2MgKmQgPSBOVUxMOworCisJc3dpdGNoIChpZCkgeworCWNhc2UgMDogZCA9ICZtbXAyX2Rldmlj
ZV9zZGgwOyBicmVhazsKKwljYXNlIDE6IGQgPSAmbW1wMl9kZXZpY2Vfc2RoMTsgYnJlYWs7CisJ
Y2FzZSAyOiBkID0gJm1tcDJfZGV2aWNlX3NkaDI7IGJyZWFrOworCWNhc2UgMzogZCA9ICZtbXAy
X2RldmljZV9zZGgzOyBicmVhazsKKwlkZWZhdWx0OgorCQlyZXR1cm4gLUVJTlZBTDsKKwl9CisK
KwlyZXR1cm4gcHhhX3JlZ2lzdGVyX2RldmljZShkLCBkYXRhLCBzaXplb2YoKmRhdGEpKTsKK30K
KwogI2VuZGlmIC8qIF9fQVNNX01BQ0hfTU1QMl9IICovCiAKZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L21hY2gtbW1wL2luY2x1ZGUvbWFjaC9yZWdzLWFwbXUuaCBiL2FyY2gvYXJtL21hY2gtbW1wL2lu
Y2x1ZGUvbWFjaC9yZWdzLWFwbXUuaAppbmRleCBhYzQ3MDIzLi5mNzAxMWVmIDEwMDY0NAotLS0g
YS9hcmNoL2FybS9tYWNoLW1tcC9pbmNsdWRlL21hY2gvcmVncy1hcG11LmgKKysrIGIvYXJjaC9h
cm0vbWFjaC1tbXAvaW5jbHVkZS9tYWNoL3JlZ3MtYXBtdS5oCkBAIC0yNyw2ICsyNyw4IEBACiAj
ZGVmaW5lIEFQTVVfRE1BCUFQTVVfUkVHKDB4MDY0KQogI2RlZmluZSBBUE1VX0dFVQlBUE1VX1JF
RygweDA2OCkKICNkZWZpbmUgQVBNVV9CVVMJQVBNVV9SRUcoMHgwNmMpCisjZGVmaW5lIEFQTVVf
U0RIMglBUE1VX1JFRygweDBlOCkKKyNkZWZpbmUgQVBNVV9TREgzCUFQTVVfUkVHKDB4MGVjKQog
CiAjZGVmaW5lIEFQTVVfRk5DTEtfRU4JKDEgPDwgNCkKICNkZWZpbmUgQVBNVV9BWElDTEtfRU4J
KDEgPDwgMykKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtbW1wL21tcDIuYyBiL2FyY2gvYXJt
L21hY2gtbW1wL21tcDIuYwppbmRleCBkYWYzOTkzLi45ZWQzY2QyIDEwMDY0NAotLS0gYS9hcmNo
L2FybS9tYWNoLW1tcC9tbXAyLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1tbXAvbW1wMi5jCkBAIC0x
MTUsNiArMTE1LDI5IEBAIHZvaWQgX19pbml0IG1tcDJfaW5pdF9pcnEodm9pZCkKIAltbXAyX2lu
aXRfZ3BpbygpOwogfQogCitzdGF0aWMgdm9pZCBzZGhjX2Nsa19lbmFibGUoc3RydWN0IGNsayAq
Y2xrKQoreworCXVpbnQzMl90IGNsa19yc3Q7CisKKwljbGtfcnN0ICA9ICBfX3Jhd19yZWFkbChj
bGstPmNsa19yc3QpOworCWNsa19yc3QgfD0gY2xrLT5lbmFibGVfdmFsOworCV9fcmF3X3dyaXRl
bChjbGtfcnN0LCBjbGstPmNsa19yc3QpOworfQorCitzdGF0aWMgdm9pZCBzZGhjX2Nsa19kaXNh
YmxlKHN0cnVjdCBjbGsgKmNsaykKK3sKKwl1aW50MzJfdCBjbGtfcnN0OworCisJY2xrX3JzdCAg
PSAgX19yYXdfcmVhZGwoY2xrLT5jbGtfcnN0KTsKKwljbGtfcnN0ICY9IH5jbGstPmVuYWJsZV92
YWw7CisJX19yYXdfd3JpdGVsKGNsa19yc3QsIGNsay0+Y2xrX3JzdCk7Cit9CisKK3N0cnVjdCBj
bGtvcHMgc2RoY19jbGtfb3BzID0geworCS5lbmFibGUJCT0gc2RoY19jbGtfZW5hYmxlLAorCS5k
aXNhYmxlCT0gc2RoY19jbGtfZGlzYWJsZSwKK307CisKIC8qIEFQQiBwZXJpcGhlcmFsIGNsb2Nr
cyAqLwogc3RhdGljIEFQQkNfQ0xLKHVhcnQxLCBNTVAyX1VBUlQxLCAxLCAyNjAwMDAwMCk7CiBz
dGF0aWMgQVBCQ19DTEsodWFydDIsIE1NUDJfVUFSVDIsIDEsIDI2MDAwMDAwKTsKQEAgLTEyOSw2
ICsxNTIsMTAgQEAgc3RhdGljIEFQQkNfQ0xLKHR3c2k2LCBNTVAyX1RXU0k2LCAwLCAyNjAwMDAw
MCk7CiBzdGF0aWMgQVBCQ19DTEsocnRjLCBNTVAyX1JUQywgMCwgMzI3NjgpOwogCiBzdGF0aWMg
QVBNVV9DTEsobmFuZCwgTkFORCwgMHhiZiwgMTAwMDAwMDAwKTsKK3N0YXRpYyBBUE1VX0NMS19P
UFMoc2RoMCwgU0RIMCwgMHgxYiwgMjAwMDAwMDAwLCAmc2RoY19jbGtfb3BzKTsKK3N0YXRpYyBB
UE1VX0NMS19PUFMoc2RoMSwgU0RIMSwgMHgxYiwgMjAwMDAwMDAwLCAmc2RoY19jbGtfb3BzKTsK
K3N0YXRpYyBBUE1VX0NMS19PUFMoc2RoMiwgU0RIMiwgMHgxYiwgMjAwMDAwMDAwLCAmc2RoY19j
bGtfb3BzKTsKK3N0YXRpYyBBUE1VX0NMS19PUFMoc2RoMywgU0RIMywgMHgxYiwgMjAwMDAwMDAw
LCAmc2RoY19jbGtfb3BzKTsKIAogc3RhdGljIHN0cnVjdCBjbGtfbG9va3VwIG1tcDJfY2xrcmVn
c1tdID0gewogCUlOSVRfQ0xLUkVHKCZjbGtfdWFydDEsICJweGEyeHgtdWFydC4wIiwgTlVMTCks
CkBAIC0xNDIsNiArMTY5LDEwIEBAIHN0YXRpYyBzdHJ1Y3QgY2xrX2xvb2t1cCBtbXAyX2Nsa3Jl
Z3NbXSA9IHsKIAlJTklUX0NMS1JFRygmY2xrX3R3c2k1LCAicHhhMnh4LWkyYy40IiwgTlVMTCks
CiAJSU5JVF9DTEtSRUcoJmNsa190d3NpNiwgInB4YTJ4eC1pMmMuNSIsIE5VTEwpLAogCUlOSVRf
Q0xLUkVHKCZjbGtfbmFuZCwgInB4YTN4eC1uYW5kIiwgTlVMTCksCisJSU5JVF9DTEtSRUcoJmNs
a19zZGgwLCAic2RoY2ktcHhhLjAiLCAiUFhBLVNESENMSyIpLAorCUlOSVRfQ0xLUkVHKCZjbGtf
c2RoMSwgInNkaGNpLXB4YS4xIiwgIlBYQS1TREhDTEsiKSwKKwlJTklUX0NMS1JFRygmY2xrX3Nk
aDIsICJzZGhjaS1weGEuMiIsICJQWEEtU0RIQ0xLIiksCisJSU5JVF9DTEtSRUcoJmNsa19zZGgz
LCAic2RoY2ktcHhhLjMiLCAiUFhBLVNESENMSyIpLAogfTsKIAogc3RhdGljIGludCBfX2luaXQg
bW1wMl9pbml0KHZvaWQpCkBAIC0xOTIsNCArMjIzLDggQEAgTU1QMl9ERVZJQ0UodHdzaTQsICJw
eGEyeHgtaTJjIiwgMywgVFdTSTQsIDB4ZDQwMzMwMDAsIDB4NzApOwogTU1QMl9ERVZJQ0UodHdz
aTUsICJweGEyeHgtaTJjIiwgNCwgVFdTSTUsIDB4ZDQwMzM4MDAsIDB4NzApOwogTU1QMl9ERVZJ
Q0UodHdzaTYsICJweGEyeHgtaTJjIiwgNSwgVFdTSTYsIDB4ZDQwMzQwMDAsIDB4NzApOwogTU1Q
Ml9ERVZJQ0UobmFuZCwgInB4YTN4eC1uYW5kIiwgLTEsIE5BTkQsIDB4ZDQyODMwMDAsIDB4MTAw
LCAyOCwgMjkpOworTU1QMl9ERVZJQ0Uoc2RoMCwgInNkaGNpLXB4YSIsIDAsIE1NQywgMHhkNDI4
MDAwMCwgMHgxMjApOworTU1QMl9ERVZJQ0Uoc2RoMSwgInNkaGNpLXB4YSIsIDEsIE1NQzIsIDB4
ZDQyODA4MDAsIDB4MTIwKTsKK01NUDJfREVWSUNFKHNkaDIsICJzZGhjaS1weGEiLCAyLCBNTUMz
LCAweGQ0MjgxMDAwLCAweDEyMCk7CitNTVAyX0RFVklDRShzZGgzLCAic2RoY2ktcHhhIiwgMywg
TU1DNCwgMHhkNDI4MTgwMCwgMHgxMjApOwogCi0tIAoxLjcuMC40Cgo=
--20cf30433ee81fb7f9049422582f--
