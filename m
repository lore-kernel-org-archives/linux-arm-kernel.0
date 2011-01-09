From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 10 Jan 2011 02:58:39 +0530
Subject: [PATCH] ARM: smp: Introduce ARCH_SKIP_SECONDARY_CALIBRATE to
Message-ID: <mailman.122.1295345828.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

speed-up boot

On some architectures, secondary cores shares clock with primiary
core and hence scale together. Hence secondary core lpj calibration
is not necessary and can be skipped to save considerable time.

This can speed up the secondary cpu boot and hotplug cpu online
paths.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig      |   10 ++++++++++
 arch/arm/kernel/smp.c |   17 ++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5cff165..677d87f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1418,6 +1418,16 @@ config ARCH_SPARSEMEM_DEFAULT
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool ARCH_SPARSEMEM_ENABLE

+config ARCH_SKIP_SECONDARY_CALIBRATE
+	bool "Skip secondary CPU calibration"
+	depends on SMP
+	help
+	  On some architectures, secondary cores shares clock with
primiary
+	  core and hence scale together. Hence secondary core lpj
calibration
+	  is not necessary and can be skipped to save considerable time.
+
+	  If unsure, say n.
+
 config HIGHMEM
 	bool "High Memory Support (EXPERIMENTAL)"
 	depends on MMU && EXPERIMENTAL
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 4539ebc..baf2707 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -270,6 +270,20 @@ static void __cpuinit smp_store_cpu_info(unsigned int
cpuid)
 }

 /*
+ * Skip the secondary calibration on architectures sharing clock
+ * with primary cpu. Archs can use ARCH_SKIP_SECONDARY_CALIBRATE
+ * for this.
+ */
+static inline int skip_secondary_calibrate(void)
+{
+#ifdef CONFIG_ARCH_SKIP_SECONDARY_CALIBRATE
+	return 0;
+#else
+	return -ENXIO;
+#endif
+}
+
+/*
  * This is the secondary CPU boot entry.  We're using this CPUs
  * idle thread stack, but a set of temporary page tables.
  */
@@ -312,7 +326,8 @@ asmlinkage void __cpuinit secondary_start_kernel(void)
 	 */
 	percpu_timer_setup();

-	calibrate_delay();
+	if (skip_secondary_calibrate())
+		calibrate_delay();

 	smp_store_cpu_info(cpu);

-- 
1.6.0.4

--20cf30433ede5cd51b049a1c33a7
Content-Type: application/octet-stream; 
	name="0001-ARM-smp-Introduce-ARCH_SKIP_SECONDARY_CALIBRATE-to.patch"
Content-Disposition: attachment; 
	filename="0001-ARM-smp-Introduce-ARCH_SKIP_SECONDARY_CALIBRATE-to.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: 867a3d3748f4cb86_0.1

RnJvbSA0ODRhZDdiNThlNWJmN2YzNTIwNmNjYzA4OTJkY2Y2NTVmYzk1NzJmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW50b3NoIFNoaWxpbWthciA8c2FudG9zaC5zaGlsaW1rYXJA
dGkuY29tPgpEYXRlOiBNb24sIDEwIEphbiAyMDExIDAyOjU4OjM5ICswNTMwClN1YmplY3Q6IFtQ
QVRDSF0gQVJNOiBzbXA6IEludHJvZHVjZSBBUkNIX1NLSVBfU0VDT05EQVJZX0NBTElCUkFURSB0
byBzcGVlZC11cCBib290CgpPbiBzb21lIGFyY2hpdGVjdHVyZXMsIHNlY29uZGFyeSBjb3JlcyBz
aGFyZXMgY2xvY2sgd2l0aCBwcmltaWFyeQpjb3JlIGFuZCBoZW5jZSBzY2FsZSB0b2dldGhlci4g
SGVuY2Ugc2Vjb25kYXJ5IGNvcmUgbHBqIGNhbGlicmF0aW9uCmlzIG5vdCBuZWNlc3NhcnkgYW5k
IGNhbiBiZSBza2lwcGVkIHRvIHNhdmUgY29uc2lkZXJhYmxlIHRpbWUuCgpUaGlzIGNhbiBzcGVl
ZCB1cCB0aGUgc2Vjb25kYXJ5IGNwdSBib290IGFuZCBob3RwbHVnIGNwdSBvbmxpbmUKcGF0aHMu
CgpTaWduZWQtb2ZmLWJ5OiBTYW50b3NoIFNoaWxpbWthciA8c2FudG9zaC5zaGlsaW1rYXJAdGku
Y29tPgpDYzogUnVzc2VsbCBLaW5nIDxybWsra2VybmVsQGFybS5saW51eC5vcmcudWs+Ci0tLQog
YXJjaC9hcm0vS2NvbmZpZyAgICAgIHwgICAxMCArKysrKysrKysrCiBhcmNoL2FybS9rZXJuZWwv
c21wLmMgfCAgIDE3ICsrKysrKysrKysrKysrKystCiAyIGZpbGVzIGNoYW5nZWQsIDI2IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vS2NvbmZpZyBi
L2FyY2gvYXJtL0tjb25maWcKaW5kZXggNWNmZjE2NS4uNjc3ZDg3ZiAxMDA2NDQKLS0tIGEvYXJj
aC9hcm0vS2NvbmZpZworKysgYi9hcmNoL2FybS9LY29uZmlnCkBAIC0xNDE4LDYgKzE0MTgsMTYg
QEAgY29uZmlnIEFSQ0hfU1BBUlNFTUVNX0RFRkFVTFQKIGNvbmZpZyBBUkNIX1NFTEVDVF9NRU1P
UllfTU9ERUwKIAlkZWZfYm9vbCBBUkNIX1NQQVJTRU1FTV9FTkFCTEUKIAorY29uZmlnIEFSQ0hf
U0tJUF9TRUNPTkRBUllfQ0FMSUJSQVRFCisJYm9vbCAiU2tpcCBzZWNvbmRhcnkgQ1BVIGNhbGli
cmF0aW9uIgorCWRlcGVuZHMgb24gU01QCisJaGVscAorCSAgT24gc29tZSBhcmNoaXRlY3R1cmVz
LCBzZWNvbmRhcnkgY29yZXMgc2hhcmVzIGNsb2NrIHdpdGggcHJpbWlhcnkKKwkgIGNvcmUgYW5k
IGhlbmNlIHNjYWxlIHRvZ2V0aGVyLiBIZW5jZSBzZWNvbmRhcnkgY29yZSBscGogY2FsaWJyYXRp
b24KKwkgIGlzIG5vdCBuZWNlc3NhcnkgYW5kIGNhbiBiZSBza2lwcGVkIHRvIHNhdmUgY29uc2lk
ZXJhYmxlIHRpbWUuCisKKwkgIElmIHVuc3VyZSwgc2F5IG4uCisKIGNvbmZpZyBISUdITUVNCiAJ
Ym9vbCAiSGlnaCBNZW1vcnkgU3VwcG9ydCAoRVhQRVJJTUVOVEFMKSIKIAlkZXBlbmRzIG9uIE1N
VSAmJiBFWFBFUklNRU5UQUwKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2tlcm5lbC9zbXAuYyBiL2Fy
Y2gvYXJtL2tlcm5lbC9zbXAuYwppbmRleCA0NTM5ZWJjLi5iYWYyNzA3IDEwMDY0NAotLS0gYS9h
cmNoL2FybS9rZXJuZWwvc21wLmMKKysrIGIvYXJjaC9hcm0va2VybmVsL3NtcC5jCkBAIC0yNzAs
NiArMjcwLDIwIEBAIHN0YXRpYyB2b2lkIF9fY3B1aW5pdCBzbXBfc3RvcmVfY3B1X2luZm8odW5z
aWduZWQgaW50IGNwdWlkKQogfQogCiAvKgorICogU2tpcCB0aGUgc2Vjb25kYXJ5IGNhbGlicmF0
aW9uIG9uIGFyY2hpdGVjdHVyZXMgc2hhcmluZyBjbG9jaworICogd2l0aCBwcmltYXJ5IGNwdS4g
QXJjaHMgY2FuIHVzZSBBUkNIX1NLSVBfU0VDT05EQVJZX0NBTElCUkFURQorICogZm9yIHRoaXMu
CisgKi8KK3N0YXRpYyBpbmxpbmUgaW50IHNraXBfc2Vjb25kYXJ5X2NhbGlicmF0ZSh2b2lkKQor
eworI2lmZGVmIENPTkZJR19BUkNIX1NLSVBfU0VDT05EQVJZX0NBTElCUkFURQorCXJldHVybiAw
OworI2Vsc2UKKwlyZXR1cm4gLUVOWElPOworI2VuZGlmCit9CisKKy8qCiAgKiBUaGlzIGlzIHRo
ZSBzZWNvbmRhcnkgQ1BVIGJvb3QgZW50cnkuICBXZSdyZSB1c2luZyB0aGlzIENQVXMKICAqIGlk
bGUgdGhyZWFkIHN0YWNrLCBidXQgYSBzZXQgb2YgdGVtcG9yYXJ5IHBhZ2UgdGFibGVzLgogICov
CkBAIC0zMTIsNyArMzI2LDggQEAgYXNtbGlua2FnZSB2b2lkIF9fY3B1aW5pdCBzZWNvbmRhcnlf
c3RhcnRfa2VybmVsKHZvaWQpCiAJICovCiAJcGVyY3B1X3RpbWVyX3NldHVwKCk7CiAKLQljYWxp
YnJhdGVfZGVsYXkoKTsKKwlpZiAoc2tpcF9zZWNvbmRhcnlfY2FsaWJyYXRlKCkpCisJCWNhbGli
cmF0ZV9kZWxheSgpOwogCiAJc21wX3N0b3JlX2NwdV9pbmZvKGNwdSk7CiAKLS0gCjEuNi4wLjQK
Cg==
--20cf30433ede5cd51b049a1c33a7--
