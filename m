From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Mon, 2 Nov 2009 14:02:21 -0500
Subject: [PATCH] pxa: fix system resume issue on pxa27x and pxa3xx
Message-ID: <mailman.103.1257214808.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since interrupt handler is changed to use interrupt priority, we also need to
save and restore these interrupt controller registers in suspend/resume
routine.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Tested-by: Daniel Mack <daniel@caiaq.de>
Acked-by: Pavel Machek <pavel@ucw.cz>
Tested-by: Pavel Machek <pavel@ucw.cz>
Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/irq.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index d694ce2..7f6f26c 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -28,6 +28,7 @@
 #define IRQ_BIT(n)	(((n) - PXA_IRQ(0)) & 0x1f)
 #define _ICMR(n)	(*((((n) - PXA_IRQ(0)) & ~0x1f) ? &ICMR2 : &ICMR))
 #define _ICLR(n)	(*((((n) - PXA_IRQ(0)) & ~0x1f) ? &ICLR2 : &ICLR))
+#define MAX_INTERNAL_IRQS	128

 /*
  * This is for peripheral IRQs internal to the PXA chip.
@@ -122,23 +123,27 @@ void __init pxa_init_irq(int irq_nr, set_wake_t fn)
 {
 	int irq, i;

-	pxa_internal_irq_nr = irq_nr;
-
 	for (irq = PXA_IRQ(0); irq < PXA_IRQ(irq_nr); irq += 32) {
 		_ICMR(irq) = 0;	/* disable all IRQs */
 		_ICLR(irq) = 0;	/* all IRQs are IRQ, not FIQ */
 	}

+	/* irq_nr shouldn't exceed MAX_INTERNAL_IRQS */
+	if (irq_nr > MAX_INTERNAL_IRQS)
+		pxa_internal_irq_nr = MAX_INTERNAL_IRQS;
+	else
+		pxa_internal_irq_nr = irq_nr;
+
 	/* initialize interrupt priority */
 	if (cpu_is_pxa27x() || cpu_is_pxa3xx()) {
-		for (i = 0; i < irq_nr; i++)
+		for (i = 0; i < pxa_internal_irq_nr; i++)
 			IPR(i) = i | (1 << 31);
 	}

 	/* only unmasked interrupts kick us out of idle */
 	ICCR = 1;

-	for (irq = PXA_IRQ(0); irq < PXA_IRQ(irq_nr); irq++) {
+	for (irq = PXA_IRQ(0); irq < PXA_IRQ(pxa_internal_irq_nr); irq++) {
 		set_irq_chip(irq, &pxa_internal_irq_chip);
 		set_irq_handler(irq, handle_level_irq);
 		set_irq_flags(irq, IRQF_VALID);
@@ -150,6 +155,7 @@ void __init pxa_init_irq(int irq_nr, set_wake_t fn)

 #ifdef CONFIG_PM
 static unsigned long saved_icmr[2];
+static unsigned long saved_ipr[MAX_INTERNAL_IRQS];

 static int pxa_irq_suspend(struct sys_device *dev, pm_message_t state)
 {
@@ -159,6 +165,8 @@ static int pxa_irq_suspend(struct sys_device *dev,
pm_message_t state)
 		saved_icmr[i] = _ICMR(irq);
 		_ICMR(irq) = 0;
 	}
+	for (i = 0; i < pxa_internal_irq_nr; i++)
+		saved_ipr[i] = IPR(i);

 	return 0;
 }
@@ -171,6 +179,8 @@ static int pxa_irq_resume(struct sys_device *dev)
 		_ICMR(irq) = saved_icmr[i];
 		_ICLR(irq) = 0;
 	}
+	for (i = 0; i < pxa_internal_irq_nr; i++)
+		IPR(i) = saved_ipr[i];

 	ICCR = 1;
 	return 0;
-- 
1.5.6.5

--00151774051c77fae704776e216f
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-pxa-fix-system-resume-issue-on-pxa27x-and-pxa3xx.patch"
Content-Disposition: attachment; 
	filename="0001-pxa-fix-system-resume-issue-on-pxa27x-and-pxa3xx.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g1ki04450

RnJvbSBjOWRkNTQ0YzE5MjMyNmE3ZTc1NjY5MjNlMTkwNTdiOGM2YzNkNWUwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVs
bC5jb20+CkRhdGU6IE1vbiwgMiBOb3YgMjAwOSAxNDowMjoyMSAtMDUwMApTdWJqZWN0OiBbUEFU
Q0hdIHB4YTogZml4IHN5c3RlbSByZXN1bWUgaXNzdWUgb24gcHhhMjd4IGFuZCBweGEzeHgKClNp
bmNlIGludGVycnVwdCBoYW5kbGVyIGlzIGNoYW5nZWQgdG8gdXNlIGludGVycnVwdCBwcmlvcml0
eSwgd2UgYWxzbyBuZWVkIHRvCnNhdmUgYW5kIHJlc3RvcmUgdGhlc2UgaW50ZXJydXB0IGNvbnRy
b2xsZXIgcmVnaXN0ZXJzIGluIHN1c3BlbmQvcmVzdW1lCnJvdXRpbmUuCgpTaWduZWQtb2ZmLWJ5
OiBIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVsbC5jb20+ClRlc3RlZC1ieTog
RGFuaWVsIE1hY2sgPGRhbmllbEBjYWlhcS5kZT4KQWNrZWQtYnk6IFBhdmVsIE1hY2hlayA8cGF2
ZWxAdWN3LmN6PgpUZXN0ZWQtYnk6IFBhdmVsIE1hY2hlayA8cGF2ZWxAdWN3LmN6PgpUZXN0ZWQt
Ynk6IFJvYmVydCBKYXJ6bWlrIDxyb2JlcnQuamFyem1pa0BmcmVlLmZyPgotLS0KIGFyY2gvYXJt
L21hY2gtcHhhL2lycS5jIHwgICAxOCArKysrKysrKysrKysrKy0tLS0KIDEgZmlsZXMgY2hhbmdl
ZCwgMTQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2Fy
bS9tYWNoLXB4YS9pcnEuYyBiL2FyY2gvYXJtL21hY2gtcHhhL2lycS5jCmluZGV4IGQ2OTRjZTIu
LjdmNmYyNmMgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtcHhhL2lycS5jCisrKyBiL2FyY2gv
YXJtL21hY2gtcHhhL2lycS5jCkBAIC0yOCw2ICsyOCw3IEBACiAjZGVmaW5lIElSUV9CSVQobikJ
KCgobikgLSBQWEFfSVJRKDApKSAmIDB4MWYpCiAjZGVmaW5lIF9JQ01SKG4pCSgqKCgoKG4pIC0g
UFhBX0lSUSgwKSkgJiB+MHgxZikgPyAmSUNNUjIgOiAmSUNNUikpCiAjZGVmaW5lIF9JQ0xSKG4p
CSgqKCgoKG4pIC0gUFhBX0lSUSgwKSkgJiB+MHgxZikgPyAmSUNMUjIgOiAmSUNMUikpCisjZGVm
aW5lIE1BWF9JTlRFUk5BTF9JUlFTCTEyOAogCiAvKgogICogVGhpcyBpcyBmb3IgcGVyaXBoZXJh
bCBJUlFzIGludGVybmFsIHRvIHRoZSBQWEEgY2hpcC4KQEAgLTEyMiwyMyArMTIzLDI3IEBAIHZv
aWQgX19pbml0IHB4YV9pbml0X2lycShpbnQgaXJxX25yLCBzZXRfd2FrZV90IGZuKQogewogCWlu
dCBpcnEsIGk7CiAKLQlweGFfaW50ZXJuYWxfaXJxX25yID0gaXJxX25yOwotCiAJZm9yIChpcnEg
PSBQWEFfSVJRKDApOyBpcnEgPCBQWEFfSVJRKGlycV9ucik7IGlycSArPSAzMikgewogCQlfSUNN
UihpcnEpID0gMDsJLyogZGlzYWJsZSBhbGwgSVJRcyAqLwogCQlfSUNMUihpcnEpID0gMDsJLyog
YWxsIElSUXMgYXJlIElSUSwgbm90IEZJUSAqLwogCX0KIAorCS8qIGlycV9uciBzaG91bGRuJ3Qg
ZXhjZWVkIE1BWF9JTlRFUk5BTF9JUlFTICovCisJaWYgKGlycV9uciA+IE1BWF9JTlRFUk5BTF9J
UlFTKQorCQlweGFfaW50ZXJuYWxfaXJxX25yID0gTUFYX0lOVEVSTkFMX0lSUVM7CisJZWxzZQor
CQlweGFfaW50ZXJuYWxfaXJxX25yID0gaXJxX25yOworCiAJLyogaW5pdGlhbGl6ZSBpbnRlcnJ1
cHQgcHJpb3JpdHkgKi8KIAlpZiAoY3B1X2lzX3B4YTI3eCgpIHx8IGNwdV9pc19weGEzeHgoKSkg
ewotCQlmb3IgKGkgPSAwOyBpIDwgaXJxX25yOyBpKyspCisJCWZvciAoaSA9IDA7IGkgPCBweGFf
aW50ZXJuYWxfaXJxX25yOyBpKyspCiAJCQlJUFIoaSkgPSBpIHwgKDEgPDwgMzEpOwogCX0KIAog
CS8qIG9ubHkgdW5tYXNrZWQgaW50ZXJydXB0cyBraWNrIHVzIG91dCBvZiBpZGxlICovCiAJSUND
UiA9IDE7CiAKLQlmb3IgKGlycSA9IFBYQV9JUlEoMCk7IGlycSA8IFBYQV9JUlEoaXJxX25yKTsg
aXJxKyspIHsKKwlmb3IgKGlycSA9IFBYQV9JUlEoMCk7IGlycSA8IFBYQV9JUlEocHhhX2ludGVy
bmFsX2lycV9ucik7IGlycSsrKSB7CiAJCXNldF9pcnFfY2hpcChpcnEsICZweGFfaW50ZXJuYWxf
aXJxX2NoaXApOwogCQlzZXRfaXJxX2hhbmRsZXIoaXJxLCBoYW5kbGVfbGV2ZWxfaXJxKTsKIAkJ
c2V0X2lycV9mbGFncyhpcnEsIElSUUZfVkFMSUQpOwpAQCAtMTUwLDYgKzE1NSw3IEBAIHZvaWQg
X19pbml0IHB4YV9pbml0X2lycShpbnQgaXJxX25yLCBzZXRfd2FrZV90IGZuKQogCiAjaWZkZWYg
Q09ORklHX1BNCiBzdGF0aWMgdW5zaWduZWQgbG9uZyBzYXZlZF9pY21yWzJdOworc3RhdGljIHVu
c2lnbmVkIGxvbmcgc2F2ZWRfaXByW01BWF9JTlRFUk5BTF9JUlFTXTsKIAogc3RhdGljIGludCBw
eGFfaXJxX3N1c3BlbmQoc3RydWN0IHN5c19kZXZpY2UgKmRldiwgcG1fbWVzc2FnZV90IHN0YXRl
KQogewpAQCAtMTU5LDYgKzE2NSw4IEBAIHN0YXRpYyBpbnQgcHhhX2lycV9zdXNwZW5kKHN0cnVj
dCBzeXNfZGV2aWNlICpkZXYsIHBtX21lc3NhZ2VfdCBzdGF0ZSkKIAkJc2F2ZWRfaWNtcltpXSA9
IF9JQ01SKGlycSk7CiAJCV9JQ01SKGlycSkgPSAwOwogCX0KKwlmb3IgKGkgPSAwOyBpIDwgcHhh
X2ludGVybmFsX2lycV9ucjsgaSsrKQorCQlzYXZlZF9pcHJbaV0gPSBJUFIoaSk7CiAKIAlyZXR1
cm4gMDsKIH0KQEAgLTE3MSw2ICsxNzksOCBAQCBzdGF0aWMgaW50IHB4YV9pcnFfcmVzdW1lKHN0
cnVjdCBzeXNfZGV2aWNlICpkZXYpCiAJCV9JQ01SKGlycSkgPSBzYXZlZF9pY21yW2ldOwogCQlf
SUNMUihpcnEpID0gMDsKIAl9CisJZm9yIChpID0gMDsgaSA8IHB4YV9pbnRlcm5hbF9pcnFfbnI7
IGkrKykKKwkJSVBSKGkpID0gc2F2ZWRfaXByW2ldOwogCiAJSUNDUiA9IDE7CiAJcmV0dXJuIDA7
Ci0tIAoxLjUuNi41Cgo=
--00151774051c77fae704776e216f--
