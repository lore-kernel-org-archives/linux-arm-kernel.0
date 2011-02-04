From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Fri, 4 Feb 2011 11:59:26 +0530
Subject: [PATCH] ARM: perf_event: support dual-core with single PMU IRQ
Message-ID: <mailman.138.1297058214.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DB8500 (dual-core) has the PMU interrupts of both cores ORed into one.  Sup=
port
this by keeping the interrupt directed at Core0 and IPIing Core1 when Core0
receives the interrupt and finds that its counter has not overflowed.

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/kernel/perf_event.c |   48 ++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 47 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 5efa264..a97e50f 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/uaccess.h>
+#include <linux/smp.h>

 #include <asm/cputype.h>
 #include <asm/irq.h>
@@ -377,9 +378,40 @@ validate_group(struct perf_event *event)
 	return 0;
 }

+static irqreturn_t armpmu_core2_irqret;
+
+/* Called via IPI on the second core */
+static void armpmu_kick(void *data)
+{
+	int irq =3D (int) data;
+
+	armpmu_core2_irqret =3D armpmu->handle_irq(irq, NULL);
+	smp_wmb();
+}
+
+static irqreturn_t armpmu_single_interrupt(int irq, void *dev)
+{
+	irqreturn_t irqret =3D armpmu->handle_irq(irq, dev);
+	int err;
+
+	if (irqret !=3D IRQ_NONE)
+		return irqret;
+
+	local_irq_enable();
+	err =3D smp_call_function_single(1, armpmu_kick, (void *) irq, true);
+	local_irq_disable();
+
+	if (err)
+		return irqret;
+
+	smp_rmb();
+	return armpmu_core2_irqret;
+}
+
 static int
 armpmu_reserve_hardware(void)
 {
+	irq_handler_t irq_handler =3D armpmu->handle_irq;
 	int i, err =3D -ENODEV, irq;

 	pmu_device =3D reserve_pmu(ARM_PMU_DEVICE_CPU);
@@ -395,12 +427,26 @@ armpmu_reserve_hardware(void)
 		return -ENODEV;
 	}

+	/*
+	 * Some SoCs have the PMU IRQ lines of two cores wired together into a
+	 * single interrupt.  Support these by poking the second core with an
+	 * IPI when its counters overflow.
+	 */
+	if (pmu_device->num_resources < num_online_cpus()) {
+		if (num_online_cpus() > 2) {
+			pr_err(">2 cpus not supported for single-irq workaround");
+			return -ENODEV;
+		}
+
+		irq_handler =3D armpmu_single_interrupt;
+	}
+
 	for (i =3D 0; i < pmu_device->num_resources; ++i) {
 		irq =3D platform_get_irq(pmu_device, i);
 		if (irq < 0)
 			continue;

-		err =3D request_irq(irq, armpmu->handle_irq,
+		err =3D request_irq(irq, irq_handler,
 				  IRQF_DISABLED | IRQF_NOBALANCING,
 				  "armpmu", NULL);
 		if (err) {
--=20
1.7.2.dirty

--0016e6d7efd7e78534049baae5b4
Content-Type: application/octet-stream; 
	name="0001-ARM-perf_event-support-dual-core-with-single-PMU-IRQ.patch"
Content-Disposition: attachment; 
	filename="0001-ARM-perf_event-support-dual-core-with-single-PMU-IRQ.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gjuywsfn0

RnJvbSA4NGU1OTM2ZjkyODVmYjAzODQ1YWMwNDgwMTQzMDc2MmMxYzliNjBkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYWJpbiBWaW5jZW50IDxyYWJpbi52aW5jZW50QHN0ZXJpY3Nz
b24uY29tPgpEYXRlOiBGcmksIDQgRmViIDIwMTEgMTE6NTk6MjYgKzA1MzAKU3ViamVjdDogW1BB
VENIXSBBUk06IHBlcmZfZXZlbnQ6IHN1cHBvcnQgZHVhbC1jb3JlIHdpdGggc2luZ2xlIFBNVSBJ
UlEKCkRCODUwMCAoZHVhbC1jb3JlKSBoYXMgdGhlIFBNVSBpbnRlcnJ1cHRzIG9mIGJvdGggY29y
ZXMgT1JlZCBpbnRvIG9uZS4gIFN1cHBvcnQKdGhpcyBieSBrZWVwaW5nIHRoZSBpbnRlcnJ1cHQg
ZGlyZWN0ZWQgYXQgQ29yZTAgYW5kIElQSWluZyBDb3JlMSB3aGVuIENvcmUwCnJlY2VpdmVzIHRo
ZSBpbnRlcnJ1cHQgYW5kIGZpbmRzIHRoYXQgaXRzIGNvdW50ZXIgaGFzIG5vdCBvdmVyZmxvd2Vk
LgoKU2lnbmVkLW9mZi1ieTogUmFiaW4gVmluY2VudCA8cmFiaW4udmluY2VudEBzdGVyaWNzc29u
LmNvbT4KLS0tCiBhcmNoL2FybS9rZXJuZWwvcGVyZl9ldmVudC5jIHwgICA0OCArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0KIDEgZmlsZXMgY2hhbmdlZCwgNDcgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9rZXJuZWwv
cGVyZl9ldmVudC5jIGIvYXJjaC9hcm0va2VybmVsL3BlcmZfZXZlbnQuYwppbmRleCA1ZWZhMjY0
Li5hOTdlNTBmIDEwMDY0NAotLS0gYS9hcmNoL2FybS9rZXJuZWwvcGVyZl9ldmVudC5jCisrKyBi
L2FyY2gvYXJtL2tlcm5lbC9wZXJmX2V2ZW50LmMKQEAgLTE5LDYgKzE5LDcgQEAKICNpbmNsdWRl
IDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4KICNpbmNsdWRlIDxsaW51eC9zcGlubG9jay5oPgog
I2luY2x1ZGUgPGxpbnV4L3VhY2Nlc3MuaD4KKyNpbmNsdWRlIDxsaW51eC9zbXAuaD4KIAogI2lu
Y2x1ZGUgPGFzbS9jcHV0eXBlLmg+CiAjaW5jbHVkZSA8YXNtL2lycS5oPgpAQCAtMzc3LDkgKzM3
OCw0MCBAQCB2YWxpZGF0ZV9ncm91cChzdHJ1Y3QgcGVyZl9ldmVudCAqZXZlbnQpCiAJcmV0dXJu
IDA7CiB9CiAKK3N0YXRpYyBpcnFyZXR1cm5fdCBhcm1wbXVfY29yZTJfaXJxcmV0OworCisvKiBD
YWxsZWQgdmlhIElQSSBvbiB0aGUgc2Vjb25kIGNvcmUgKi8KK3N0YXRpYyB2b2lkIGFybXBtdV9r
aWNrKHZvaWQgKmRhdGEpCit7CisJaW50IGlycSA9IChpbnQpIGRhdGE7CisKKwlhcm1wbXVfY29y
ZTJfaXJxcmV0ID0gYXJtcG11LT5oYW5kbGVfaXJxKGlycSwgTlVMTCk7CisJc21wX3dtYigpOwor
fQorCitzdGF0aWMgaXJxcmV0dXJuX3QgYXJtcG11X3NpbmdsZV9pbnRlcnJ1cHQoaW50IGlycSwg
dm9pZCAqZGV2KQoreworCWlycXJldHVybl90IGlycXJldCA9IGFybXBtdS0+aGFuZGxlX2lycShp
cnEsIGRldik7CisJaW50IGVycjsKKworCWlmIChpcnFyZXQgIT0gSVJRX05PTkUpCisJCXJldHVy
biBpcnFyZXQ7CisKKwlsb2NhbF9pcnFfZW5hYmxlKCk7CisJZXJyID0gc21wX2NhbGxfZnVuY3Rp
b25fc2luZ2xlKDEsIGFybXBtdV9raWNrLCAodm9pZCAqKSBpcnEsIHRydWUpOworCWxvY2FsX2ly
cV9kaXNhYmxlKCk7CisKKwlpZiAoZXJyKQorCQlyZXR1cm4gaXJxcmV0OworCisJc21wX3JtYigp
OworCXJldHVybiBhcm1wbXVfY29yZTJfaXJxcmV0OworfQorCiBzdGF0aWMgaW50CiBhcm1wbXVf
cmVzZXJ2ZV9oYXJkd2FyZSh2b2lkKQogeworCWlycV9oYW5kbGVyX3QgaXJxX2hhbmRsZXIgPSBh
cm1wbXUtPmhhbmRsZV9pcnE7CiAJaW50IGksIGVyciA9IC1FTk9ERVYsIGlycTsKIAogCXBtdV9k
ZXZpY2UgPSByZXNlcnZlX3BtdShBUk1fUE1VX0RFVklDRV9DUFUpOwpAQCAtMzk1LDEyICs0Mjcs
MjYgQEAgYXJtcG11X3Jlc2VydmVfaGFyZHdhcmUodm9pZCkKIAkJcmV0dXJuIC1FTk9ERVY7CiAJ
fQogCisJLyoKKwkgKiBTb21lIFNvQ3MgaGF2ZSB0aGUgUE1VIElSUSBsaW5lcyBvZiB0d28gY29y
ZXMgd2lyZWQgdG9nZXRoZXIgaW50byBhCisJICogc2luZ2xlIGludGVycnVwdC4gIFN1cHBvcnQg
dGhlc2UgYnkgcG9raW5nIHRoZSBzZWNvbmQgY29yZSB3aXRoIGFuCisJICogSVBJIHdoZW4gaXRz
IGNvdW50ZXJzIG92ZXJmbG93LgorCSAqLworCWlmIChwbXVfZGV2aWNlLT5udW1fcmVzb3VyY2Vz
IDwgbnVtX29ubGluZV9jcHVzKCkpIHsKKwkJaWYgKG51bV9vbmxpbmVfY3B1cygpID4gMikgewor
CQkJcHJfZXJyKCI+MiBjcHVzIG5vdCBzdXBwb3J0ZWQgZm9yIHNpbmdsZS1pcnEgd29ya2Fyb3Vu
ZCIpOworCQkJcmV0dXJuIC1FTk9ERVY7CisJCX0KKworCQlpcnFfaGFuZGxlciA9IGFybXBtdV9z
aW5nbGVfaW50ZXJydXB0OworCX0KKwogCWZvciAoaSA9IDA7IGkgPCBwbXVfZGV2aWNlLT5udW1f
cmVzb3VyY2VzOyArK2kpIHsKIAkJaXJxID0gcGxhdGZvcm1fZ2V0X2lycShwbXVfZGV2aWNlLCBp
KTsKIAkJaWYgKGlycSA8IDApCiAJCQljb250aW51ZTsKIAotCQllcnIgPSByZXF1ZXN0X2lycShp
cnEsIGFybXBtdS0+aGFuZGxlX2lycSwKKwkJZXJyID0gcmVxdWVzdF9pcnEoaXJxLCBpcnFfaGFu
ZGxlciwKIAkJCQkgIElSUUZfRElTQUJMRUQgfCBJUlFGX05PQkFMQU5DSU5HLAogCQkJCSAgImFy
bXBtdSIsIE5VTEwpOwogCQlpZiAoZXJyKSB7Ci0tIAoxLjcuMi5kaXJ0eQoK
--0016e6d7efd7e78534049baae5b4--
