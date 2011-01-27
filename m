From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 27 Jan 2011 17:10:34 +0530
Subject: [PATCH] omap4: Enable ARM local timers with OMAP4430 es1.0
Message-ID: <mailman.149.1298052701.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

exception

On OMAP4430 ES1.0 the local timers are gated by security. Enable the
CONFIG_LOCAL_TIMERS for omap2plus build and handle the OMAP4430 es1.0
exception case.

This patch has dependency on the first patch in this series.
	ARM: smp: Select local timers vs dummy timer support runtime

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig     |    1 +
 arch/arm/mach-omap2/timer-mpu.c |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 1a2cf62..f285dd7 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -44,6 +44,7 @@ config ARCH_OMAP4
 	depends on ARCH_OMAP2PLUS
 	select CPU_V7
 	select ARM_GIC
+	select LOCAL_TIMERS
 	select PL310_ERRATA_588369
 	select ARM_ERRATA_720789
 	select ARCH_HAS_OPP
diff --git a/arch/arm/mach-omap2/timer-mpu.c
b/arch/arm/mach-omap2/timer-mpu.c
index 09c73dc..31c0ac4 100644
--- a/arch/arm/mach-omap2/timer-mpu.c
+++ b/arch/arm/mach-omap2/timer-mpu.c
@@ -28,6 +28,10 @@
  */
 int __cpuinit local_timer_setup(struct clock_event_device *evt)
 {
+	/* Local timers are not supprted on OMAP4430 ES1.0 */
+	if (omap_rev() == OMAP4430_REV_ES1_0)
+		return -ENXIO;
+
 	evt->irq = OMAP44XX_IRQ_LOCALTIMER;
 	twd_timer_setup(evt);
 	return 0;
-- 
1.6.0.4

--001636832066d46fc4049c9271ba
Content-Type: application/octet-stream; 
	name="0002-omap4-Enable-ARM-local-timers-with-OMAP4430-es1.0-e.patch"
Content-Disposition: attachment; 
	filename="0002-omap4-Enable-ARM-local-timers-with-OMAP4430-es1.0-e.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: fcbda469665a3c28_0.1

RnJvbSBmNzZmMGVmZmZhZmNjZjc2YmU3ZDgyMGYyZjc3NTMxMWIwNjA4N2JkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW50b3NoIFNoaWxpbWthciA8c2FudG9zaC5zaGlsaW1rYXJA
dGkuY29tPgpEYXRlOiBUaHUsIDI3IEphbiAyMDExIDE3OjEwOjM0ICswNTMwClN1YmplY3Q6IFtQ
QVRDSF0gb21hcDQ6IEVuYWJsZSBBUk0gbG9jYWwgdGltZXJzIHdpdGggT01BUDQ0MzAgZXMxLjAg
ZXhjZXB0aW9uCgpPbiBPTUFQNDQzMCBFUzEuMCB0aGUgbG9jYWwgdGltZXJzIGFyZSBnYXRlZCBi
eSBzZWN1cml0eS4gRW5hYmxlIHRoZQpDT05GSUdfTE9DQUxfVElNRVJTIGZvciBvbWFwMnBsdXMg
YnVpbGQgYW5kIGhhbmRsZSB0aGUgT01BUDQ0MzAgZXMxLjAKZXhjZXB0aW9uIGNhc2UuCgpUaGlz
IHBhdGNoIGhhcyBkZXBlbmRlbmN5IG9uIHRoZSBmaXJzdCBwYXRjaCBpbiB0aGlzIHNlcmllcy4K
CUFSTTogc21wOiBTZWxlY3QgbG9jYWwgdGltZXJzIHZzIGR1bW15IHRpbWVyIHN1cHBvcnQgcnVu
dGltZQoKU2lnbmVkLW9mZi1ieTogU2FudG9zaCBTaGlsaW1rYXIgPHNhbnRvc2guc2hpbGlta2Fy
QHRpLmNvbT4KQWNrZWQtYnk6IFRvbnkgTGluZGdyZW4gPHRvbnlAYXRvbWlkZS5jb20+Ci0tLQog
YXJjaC9hcm0vbWFjaC1vbWFwMi9LY29uZmlnICAgICB8ICAgIDEgKwogYXJjaC9hcm0vbWFjaC1v
bWFwMi90aW1lci1tcHUuYyB8ICAgIDQgKysrKwogMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9L
Y29uZmlnIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9LY29uZmlnCmluZGV4IDFhMmNmNjIuLmYyODVk
ZDcgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtb21hcDIvS2NvbmZpZworKysgYi9hcmNoL2Fy
bS9tYWNoLW9tYXAyL0tjb25maWcKQEAgLTQ0LDYgKzQ0LDcgQEAgY29uZmlnIEFSQ0hfT01BUDQK
IAlkZXBlbmRzIG9uIEFSQ0hfT01BUDJQTFVTCiAJc2VsZWN0IENQVV9WNwogCXNlbGVjdCBBUk1f
R0lDCisJc2VsZWN0IExPQ0FMX1RJTUVSUyBpZiBTTVAKIAlzZWxlY3QgUEwzMTBfRVJSQVRBXzU4
ODM2OQogCXNlbGVjdCBBUk1fRVJSQVRBXzcyMDc4OQogCXNlbGVjdCBBUkNIX0hBU19PUFAKZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvdGltZXItbXB1LmMgYi9hcmNoL2FybS9tYWNo
LW9tYXAyL3RpbWVyLW1wdS5jCmluZGV4IDA5YzczZGMuLjMxYzBhYzQgMTAwNjQ0Ci0tLSBhL2Fy
Y2gvYXJtL21hY2gtb21hcDIvdGltZXItbXB1LmMKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi90
aW1lci1tcHUuYwpAQCAtMjgsNiArMjgsMTAgQEAKICAqLwogaW50IF9fY3B1aW5pdCBsb2NhbF90
aW1lcl9zZXR1cChzdHJ1Y3QgY2xvY2tfZXZlbnRfZGV2aWNlICpldnQpCiB7CisJLyogTG9jYWwg
dGltZXJzIGFyZSBub3Qgc3VwcHJ0ZWQgb24gT01BUDQ0MzAgRVMxLjAgKi8KKwlpZiAob21hcF9y
ZXYoKSA9PSBPTUFQNDQzMF9SRVZfRVMxXzApCisJCXJldHVybiAtRU5YSU87CisKIAlldnQtPmly
cSA9IE9NQVA0NFhYX0lSUV9MT0NBTFRJTUVSOwogCXR3ZF90aW1lcl9zZXR1cChldnQpOwogCXJl
dHVybiAwOwotLSAKMS42LjAuNAoK
--001636832066d46fc4049c9271ba--
