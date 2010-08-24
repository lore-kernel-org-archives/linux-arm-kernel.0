From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Tue, 24 Aug 2010 23:00:56 +0800
Subject: [PATCH 2/3] [ARM] pxa: update cpuid of pxa168 & pxa910
Message-ID: <mailman.212.1282733075.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support more steppings of pxa168 and pxa910.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/include/mach/cputype.h |   30 ++++++++++++++++++++----------
 1 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/cputype.h
b/arch/arm/mach-mmp/include/mach/cputype.h
index 83b1872..f45cdbc 100644
--- a/arch/arm/mach-mmp/include/mach/cputype.h
+++ b/arch/arm/mach-mmp/include/mach/cputype.h
@@ -8,32 +8,42 @@
  *
  * PXA168    A0    0x41159263   0x56158400   0x00A0A333
  * PXA910    Y0    0x41159262   0x56158000   0x00F0C910
+ * PXA920    Y0                 0x56158400   0x00F2C920
+ * PXA920    A0                 0x56158400   0x00A0C920
  * MMP2	     Z0			0x560f5811
  */

+#define CHIP_ID		(AXI_VIRT_BASE + 0x82c00)
+
 #ifdef CONFIG_CPU_PXA168
-#  define __cpu_is_pxa168(id)	\
-	({ unsigned int _id = ((id) >> 8) & 0xff; _id == 0x84; })
+#define __cpu_is_pxa168(id, cid)	\
+	({ unsigned int _id = ((id) >> 8) & 0xff; \
+	   unsigned int _cid = (cid) & 0xfff; \
+	   _id == 0x84 && _cid != 0x910 && _cid != 0x920; })
 #else
-#  define __cpu_is_pxa168(id)	(0)
+#define __cpu_is_pxa168(id, cid)	(0)
 #endif

 #ifdef CONFIG_CPU_PXA910
-#  define __cpu_is_pxa910(id)	\
-	({ unsigned int _id = ((id) >> 8) & 0xff; _id == 0x80; })
+#define __cpu_is_pxa910(id, cid)	\
+	({ unsigned int _id = ((id) >> 8) & 0xff; \
+	   unsigned int _cid = (cid) & 0xfff; \
+	   (_id == 0x84 || _id == 0x80) && (_cid == 0x910 || _cid == 0x920); })
 #else
-#  define __cpu_is_pxa910(id)	(0)
+#define __cpu_is_pxa910(id, cid)	(0)
 #endif

 #ifdef CONFIG_CPU_MMP2
-#  define __cpu_is_mmp2(id)	\
+#define __cpu_is_mmp2(id)	\
 	({ unsigned int _id = ((id) >> 8) & 0xff; _id == 0x58; })
 #else
-#  define __cpu_is_mmp2(id)	(0)
+#define __cpu_is_mmp2(id)	(0)
 #endif

-#define cpu_is_pxa168()		({ __cpu_is_pxa168(read_cpuid_id()); })
-#define cpu_is_pxa910()		({ __cpu_is_pxa910(read_cpuid_id()); })
+#define cpu_is_pxa168()		({ __cpu_is_pxa168(read_cpuid_id(), \
+				__raw_readl(CHIP_ID)); })
+#define cpu_is_pxa910()		({ __cpu_is_pxa910(read_cpuid_id(), \
+				__raw_readl(CHIP_ID)); })
 #define cpu_is_mmp2()		({ __cpu_is_mmp2(read_cpuid_id()); })

 #endif /* __ASM_MACH_CPUTYPE_H */
-- 
1.5.6.5

--0016e65684e41a2cde048ea3915f
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0002--ARM-pxa-update-cpuid-of-pxa168-pxa910.patch"
Content-Disposition: attachment; 
	filename="0002--ARM-pxa-update-cpuid-of-pxa168-pxa910.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gda1wcxq0

RnJvbSA1NzQxYzgyZTY4YTk3MmJiNThhNmU4MGZhMzMwMTNmNzA2YTg2OTBmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVs
bC5jb20+CkRhdGU6IFR1ZSwgMjQgQXVnIDIwMTAgMjM6MDA6NTYgKzA4MDAKU3ViamVjdDogW1BB
VENIIDIvM10gW0FSTV0gcHhhOiB1cGRhdGUgY3B1aWQgb2YgcHhhMTY4ICYgcHhhOTEwCgpTdXBw
b3J0IG1vcmUgc3RlcHBpbmdzIG9mIHB4YTE2OCBhbmQgcHhhOTEwLgoKU2lnbmVkLW9mZi1ieTog
SGFvamlhbiBaaHVhbmcgPGhhb2ppYW4uemh1YW5nQG1hcnZlbGwuY29tPgotLS0KIGFyY2gvYXJt
L21hY2gtbW1wL2luY2x1ZGUvbWFjaC9jcHV0eXBlLmggfCAgIDMwICsrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxMCBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW1tcC9pbmNsdWRlL21hY2gvY3B1
dHlwZS5oIGIvYXJjaC9hcm0vbWFjaC1tbXAvaW5jbHVkZS9tYWNoL2NwdXR5cGUuaAppbmRleCA4
M2IxODcyLi5mNDVjZGJjIDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW1tcC9pbmNsdWRlL21h
Y2gvY3B1dHlwZS5oCisrKyBiL2FyY2gvYXJtL21hY2gtbW1wL2luY2x1ZGUvbWFjaC9jcHV0eXBl
LmgKQEAgLTgsMzIgKzgsNDIgQEAKICAqCiAgKiBQWEExNjggICAgQTAgICAgMHg0MTE1OTI2MyAg
IDB4NTYxNTg0MDAgICAweDAwQTBBMzMzCiAgKiBQWEE5MTAgICAgWTAgICAgMHg0MTE1OTI2MiAg
IDB4NTYxNTgwMDAgICAweDAwRjBDOTEwCisgKiBQWEE5MjAgICAgWTAgICAgICAgICAgICAgICAg
IDB4NTYxNTg0MDAgICAweDAwRjJDOTIwCisgKiBQWEE5MjAgICAgQTAgICAgICAgICAgICAgICAg
IDB4NTYxNTg0MDAgICAweDAwQTBDOTIwCiAgKiBNTVAyCSAgICAgWjAJCQkweDU2MGY1ODExCiAg
Ki8KIAorI2RlZmluZSBDSElQX0lECQkoQVhJX1ZJUlRfQkFTRSArIDB4ODJjMDApCisKICNpZmRl
ZiBDT05GSUdfQ1BVX1BYQTE2OAotIyAgZGVmaW5lIF9fY3B1X2lzX3B4YTE2OChpZCkJXAotCSh7
IHVuc2lnbmVkIGludCBfaWQgPSAoKGlkKSA+PiA4KSAmIDB4ZmY7IF9pZCA9PSAweDg0OyB9KQor
I2RlZmluZSBfX2NwdV9pc19weGExNjgoaWQsIGNpZCkJXAorCSh7IHVuc2lnbmVkIGludCBfaWQg
PSAoKGlkKSA+PiA4KSAmIDB4ZmY7IFwKKwkgICB1bnNpZ25lZCBpbnQgX2NpZCA9IChjaWQpICYg
MHhmZmY7IFwKKwkgICBfaWQgPT0gMHg4NCAmJiBfY2lkICE9IDB4OTEwICYmIF9jaWQgIT0gMHg5
MjA7IH0pCiAjZWxzZQotIyAgZGVmaW5lIF9fY3B1X2lzX3B4YTE2OChpZCkJKDApCisjZGVmaW5l
IF9fY3B1X2lzX3B4YTE2OChpZCwgY2lkKQkoMCkKICNlbmRpZgogCiAjaWZkZWYgQ09ORklHX0NQ
VV9QWEE5MTAKLSMgIGRlZmluZSBfX2NwdV9pc19weGE5MTAoaWQpCVwKLQkoeyB1bnNpZ25lZCBp
bnQgX2lkID0gKChpZCkgPj4gOCkgJiAweGZmOyBfaWQgPT0gMHg4MDsgfSkKKyNkZWZpbmUgX19j
cHVfaXNfcHhhOTEwKGlkLCBjaWQpCVwKKwkoeyB1bnNpZ25lZCBpbnQgX2lkID0gKChpZCkgPj4g
OCkgJiAweGZmOyBcCisJICAgdW5zaWduZWQgaW50IF9jaWQgPSAoY2lkKSAmIDB4ZmZmOyBcCisJ
ICAgKF9pZCA9PSAweDg0IHx8IF9pZCA9PSAweDgwKSAmJiAoX2NpZCA9PSAweDkxMCB8fCBfY2lk
ID09IDB4OTIwKTsgfSkKICNlbHNlCi0jICBkZWZpbmUgX19jcHVfaXNfcHhhOTEwKGlkKQkoMCkK
KyNkZWZpbmUgX19jcHVfaXNfcHhhOTEwKGlkLCBjaWQpCSgwKQogI2VuZGlmCiAKICNpZmRlZiBD
T05GSUdfQ1BVX01NUDIKLSMgIGRlZmluZSBfX2NwdV9pc19tbXAyKGlkKQlcCisjZGVmaW5lIF9f
Y3B1X2lzX21tcDIoaWQpCVwKIAkoeyB1bnNpZ25lZCBpbnQgX2lkID0gKChpZCkgPj4gOCkgJiAw
eGZmOyBfaWQgPT0gMHg1ODsgfSkKICNlbHNlCi0jICBkZWZpbmUgX19jcHVfaXNfbW1wMihpZCkJ
KDApCisjZGVmaW5lIF9fY3B1X2lzX21tcDIoaWQpCSgwKQogI2VuZGlmCiAKLSNkZWZpbmUgY3B1
X2lzX3B4YTE2OCgpCQkoeyBfX2NwdV9pc19weGExNjgocmVhZF9jcHVpZF9pZCgpKTsgfSkKLSNk
ZWZpbmUgY3B1X2lzX3B4YTkxMCgpCQkoeyBfX2NwdV9pc19weGE5MTAocmVhZF9jcHVpZF9pZCgp
KTsgfSkKKyNkZWZpbmUgY3B1X2lzX3B4YTE2OCgpCQkoeyBfX2NwdV9pc19weGExNjgocmVhZF9j
cHVpZF9pZCgpLCBcCisJCQkJX19yYXdfcmVhZGwoQ0hJUF9JRCkpOyB9KQorI2RlZmluZSBjcHVf
aXNfcHhhOTEwKCkJCSh7IF9fY3B1X2lzX3B4YTkxMChyZWFkX2NwdWlkX2lkKCksIFwKKwkJCQlf
X3Jhd19yZWFkbChDSElQX0lEKSk7IH0pCiAjZGVmaW5lIGNwdV9pc19tbXAyKCkJCSh7IF9fY3B1
X2lzX21tcDIocmVhZF9jcHVpZF9pZCgpKTsgfSkKIAogI2VuZGlmIC8qIF9fQVNNX01BQ0hfQ1BV
VFlQRV9IICovCi0tIAoxLjUuNi41Cgo=
--0016e65684e41a2cde048ea3915f--
