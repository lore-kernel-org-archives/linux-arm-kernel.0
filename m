From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Fri, 4 Feb 2011 11:59:26 +0530
Subject: [PATCH] ARM: perf_event: support dual-core with single PMU IRQ
Message-ID: <mailman.137.1297057779.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DB8500 (dual-core) has the PMU interrupts of both cores ORed into one.  Support
this by setting the affinity of the interrupt to the other core when the
current core finds that its counter has not overflowed when an interrupt
occurred.

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/kernel/perf_event.c |   33 ++++++++++++++++++++++++++++++++-
 1 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 5efa264..d07990e 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -377,9 +377,27 @@ validate_group(struct perf_event *event)
 	return 0;
 }

+static irqreturn_t armpmu_bounce_interrupt(int irq, void *dev)
+{
+	irqreturn_t ret = armpmu->handle_irq(irq, dev);
+
+	if (ret == IRQ_NONE) {
+		int other = !smp_processor_id();
+		irq_set_affinity(irq, cpumask_of(other));
+	}
+
+	/*
+	 * We should be able to get away with the amount of IRQ_NONEs we give,
+	 * while still having the spurious IRQ detection code kick in if the
+	 * interrupt really starts hitting spuriously.
+	 */
+	return ret;
+}
+
 static int
 armpmu_reserve_hardware(void)
 {
+	irq_handler_t irq_handler = armpmu->handle_irq;
 	int i, err = -ENODEV, irq;

 	pmu_device = reserve_pmu(ARM_PMU_DEVICE_CPU);
@@ -395,12 +413,25 @@ armpmu_reserve_hardware(void)
 		return -ENODEV;
 	}

+	/*
+	 * Some SoCs have the PMU IRQ lines of two cores wired together into a
+	 * single interrupt.
+	 */
+	if (pmu_device->num_resources < num_online_cpus()) {
+		if (num_online_cpus() > 2) {
+			pr_err(">2 cpus not supported for single-irq workaround");
+			return -ENODEV;
+		}
+
+		irq_handler = armpmu_bounce_interrupt;
+	}
+
 	for (i = 0; i < pmu_device->num_resources; ++i) {
 		irq = platform_get_irq(pmu_device, i);
 		if (irq < 0)
 			continue;

-		err = request_irq(irq, armpmu->handle_irq,
+		err = request_irq(irq, irq_handler,
 				  IRQF_DISABLED | IRQF_NOBALANCING,
 				  "armpmu", NULL);
 		if (err) {

--001636c5aa55c3c736049baacb0b
Content-Type: application/octet-stream; 
	name="0001-ARM-perf_event-support-dual-core-with-single-PMU-IRQ.patch"
Content-Disposition: attachment; 
	filename="0001-ARM-perf_event-support-dual-core-with-single-PMU-IRQ.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gjuykx4u0

RnJvbSA0MTBlZTgzMWRkNjk2OWVjMDQ3YmE5OGIxY2QzMmFjMjA0NGYxNWNlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYWJpbiBWaW5jZW50IDxyYWJpbi52aW5jZW50QHN0ZXJpY3Nz
b24uY29tPgpEYXRlOiBGcmksIDQgRmViIDIwMTEgMTE6NTk6MjYgKzA1MzAKU3ViamVjdDogW1BB
VENIXSBBUk06IHBlcmZfZXZlbnQ6IHN1cHBvcnQgZHVhbC1jb3JlIHdpdGggc2luZ2xlIFBNVSBJ
UlEKCkRCODUwMCAoZHVhbC1jb3JlKSBoYXMgdGhlIFBNVSBpbnRlcnJ1cHRzIG9mIGJvdGggY29y
ZXMgT1JlZCBpbnRvIG9uZS4gIFN1cHBvcnQKdGhpcyBieSBzZXR0aW5nIHRoZSBhZmZpbml0eSBv
ZiB0aGUgaW50ZXJydXB0IHRvIHRoZSBvdGhlciBjb3JlIHdoZW4gdGhlCmN1cnJlbnQgY29yZSBm
aW5kcyB0aGF0IGl0cyBjb3VudGVyIGhhcyBub3Qgb3ZlcmZsb3dlZCB3aGVuIGFuIGludGVycnVw
dApvY2N1cnJlZC4KClNpZ25lZC1vZmYtYnk6IFJhYmluIFZpbmNlbnQgPHJhYmluLnZpbmNlbnRA
c3Rlcmljc3Nvbi5jb20+Ci0tLQogYXJjaC9hcm0va2VybmVsL3BlcmZfZXZlbnQuYyB8ICAgMzMg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystCiAxIGZpbGVzIGNoYW5nZWQsIDMyIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0va2VybmVs
L3BlcmZfZXZlbnQuYyBiL2FyY2gvYXJtL2tlcm5lbC9wZXJmX2V2ZW50LmMKaW5kZXggNWVmYTI2
NC4uZDA3OTkwZSAxMDA2NDQKLS0tIGEvYXJjaC9hcm0va2VybmVsL3BlcmZfZXZlbnQuYworKysg
Yi9hcmNoL2FybS9rZXJuZWwvcGVyZl9ldmVudC5jCkBAIC0zNzcsOSArMzc3LDI3IEBAIHZhbGlk
YXRlX2dyb3VwKHN0cnVjdCBwZXJmX2V2ZW50ICpldmVudCkKIAlyZXR1cm4gMDsKIH0KIAorc3Rh
dGljIGlycXJldHVybl90IGFybXBtdV9ib3VuY2VfaW50ZXJydXB0KGludCBpcnEsIHZvaWQgKmRl
dikKK3sKKwlpcnFyZXR1cm5fdCByZXQgPSBhcm1wbXUtPmhhbmRsZV9pcnEoaXJxLCBkZXYpOwor
CisJaWYgKHJldCA9PSBJUlFfTk9ORSkgeworCQlpbnQgb3RoZXIgPSAhc21wX3Byb2Nlc3Nvcl9p
ZCgpOworCQlpcnFfc2V0X2FmZmluaXR5KGlycSwgY3B1bWFza19vZihvdGhlcikpOworCX0KKwor
CS8qCisJICogV2Ugc2hvdWxkIGJlIGFibGUgdG8gZ2V0IGF3YXkgd2l0aCB0aGUgYW1vdW50IG9m
IElSUV9OT05FcyB3ZSBnaXZlLAorCSAqIHdoaWxlIHN0aWxsIGhhdmluZyB0aGUgc3B1cmlvdXMg
SVJRIGRldGVjdGlvbiBjb2RlIGtpY2sgaW4gaWYgdGhlCisJICogaW50ZXJydXB0IHJlYWxseSBz
dGFydHMgaGl0dGluZyBzcHVyaW91c2x5LgorCSAqLworCXJldHVybiByZXQ7Cit9CisKIHN0YXRp
YyBpbnQKIGFybXBtdV9yZXNlcnZlX2hhcmR3YXJlKHZvaWQpCiB7CisJaXJxX2hhbmRsZXJfdCBp
cnFfaGFuZGxlciA9IGFybXBtdS0+aGFuZGxlX2lycTsKIAlpbnQgaSwgZXJyID0gLUVOT0RFViwg
aXJxOwogCiAJcG11X2RldmljZSA9IHJlc2VydmVfcG11KEFSTV9QTVVfREVWSUNFX0NQVSk7CkBA
IC0zOTUsMTIgKzQxMywyNSBAQCBhcm1wbXVfcmVzZXJ2ZV9oYXJkd2FyZSh2b2lkKQogCQlyZXR1
cm4gLUVOT0RFVjsKIAl9CiAKKwkvKgorCSAqIFNvbWUgU29DcyBoYXZlIHRoZSBQTVUgSVJRIGxp
bmVzIG9mIHR3byBjb3JlcyB3aXJlZCB0b2dldGhlciBpbnRvIGEKKwkgKiBzaW5nbGUgaW50ZXJy
dXB0LgorCSAqLworCWlmIChwbXVfZGV2aWNlLT5udW1fcmVzb3VyY2VzIDwgbnVtX29ubGluZV9j
cHVzKCkpIHsKKwkJaWYgKG51bV9vbmxpbmVfY3B1cygpID4gMikgeworCQkJcHJfZXJyKCI+MiBj
cHVzIG5vdCBzdXBwb3J0ZWQgZm9yIHNpbmdsZS1pcnEgd29ya2Fyb3VuZCIpOworCQkJcmV0dXJu
IC1FTk9ERVY7CisJCX0KKworCQlpcnFfaGFuZGxlciA9IGFybXBtdV9ib3VuY2VfaW50ZXJydXB0
OworCX0KKwogCWZvciAoaSA9IDA7IGkgPCBwbXVfZGV2aWNlLT5udW1fcmVzb3VyY2VzOyArK2kp
IHsKIAkJaXJxID0gcGxhdGZvcm1fZ2V0X2lycShwbXVfZGV2aWNlLCBpKTsKIAkJaWYgKGlycSA8
IDApCiAJCQljb250aW51ZTsKIAotCQllcnIgPSByZXF1ZXN0X2lycShpcnEsIGFybXBtdS0+aGFu
ZGxlX2lycSwKKwkJZXJyID0gcmVxdWVzdF9pcnEoaXJxLCBpcnFfaGFuZGxlciwKIAkJCQkgIElS
UUZfRElTQUJMRUQgfCBJUlFGX05PQkFMQU5DSU5HLAogCQkJCSAgImFybXBtdSIsIE5VTEwpOwog
CQlpZiAoZXJyKSB7Ci0tIAoxLjcuMi5kaXJ0eQoK
--001636c5aa55c3c736049baacb0b--
