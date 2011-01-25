From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 25 Jan 2011 14:26:41 +0530
Subject: [PATCH] ARM: smp_twd: Always program the loadvalue when switching
Message-ID: <mailman.130.1295971465.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

to periodic mode.

Always program the load value when switching to periodic mode so that
we don't need to save restore twd load register.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/smp_twd.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index fd91566..60636f4 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -36,6 +36,7 @@ static void twd_set_mode(enum clock_event_mode mode,
 		/* timer load already set up */
 		ctrl = TWD_TIMER_CONTROL_ENABLE |
TWD_TIMER_CONTROL_IT_ENABLE
 			| TWD_TIMER_CONTROL_PERIODIC;
+		__raw_writel(twd_timer_rate / HZ, twd_base +
TWD_TIMER_LOAD);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
 		/* period set, and timer enabled in 'next_event' hook */
@@ -81,7 +82,7 @@ int twd_timer_ack(void)

 static void __cpuinit twd_calibrate_rate(void)
 {
-	unsigned long load, count;
+	unsigned long count;
 	u64 waitjiffies;

 	/*
@@ -116,10 +117,6 @@ static void __cpuinit twd_calibrate_rate(void)
 		printk("%lu.%02luMHz.\n", twd_timer_rate / 1000000,
 			(twd_timer_rate / 1000000) % 100);
 	}
-
-	load = twd_timer_rate / HZ;
-
-	__raw_writel(load, twd_base + TWD_TIMER_LOAD);
 }

 /*
-- 
1.6.0.4

--001636c5a8605ea19c049aaddef1
Content-Type: application/octet-stream; 
	name="0001-ARM-smp_twd-Always-program-the-loadvalue-when-swit.patch"
Content-Disposition: attachment; 
	filename="0001-ARM-smp_twd-Always-program-the-loadvalue-when-swit.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: c33e3ae155501f20_0.1

RnJvbSA5MDg0ZGQzZTY4YTg1MjgxNzJkOTdmYjQ5YzQyNDM3YWU4NzNhZjQzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSdXNzZWxsIEtpbmcgPHJtaytrZXJuZWxAYXJtLmxpbnV4Lm9y
Zy51az4KRGF0ZTogVHVlLCAyNSBKYW4gMjAxMSAxNDoyNjo0MSArMDUzMApTdWJqZWN0OiBbUEFU
Q0hdIEFSTTogc21wX3R3ZDogQWx3YXlzIHByb2dyYW0gdGhlIGxvYWR2YWx1ZSB3aGVuIHN3aXRj
aGluZyB0byBwZXJpb2RpYyBtb2RlLgoKQWx3YXlzIHByb2dyYW0gdGhlIGxvYWQgdmFsdWUgd2hl
biBzd2l0Y2hpbmcgdG8gcGVyaW9kaWMgbW9kZSBzbyB0aGF0CndlIGRvbid0IG5lZWQgdG8gc2F2
ZSByZXN0b3JlIHR3ZCBsb2FkIHJlZ2lzdGVyLgoKU2lnbmVkLW9mZi1ieTogUnVzc2VsbCBLaW5n
IDxybWsra2VybmVsQGFybS5saW51eC5vcmcudWs+Ci0tLQogYXJjaC9hcm0va2VybmVsL3NtcF90
d2QuYyB8ICAgIDcgKystLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDUg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0va2VybmVsL3NtcF90d2QuYyBiL2Fy
Y2gvYXJtL2tlcm5lbC9zbXBfdHdkLmMKaW5kZXggZmQ5MTU2Ni4uNjA2MzZmNCAxMDA2NDQKLS0t
IGEvYXJjaC9hcm0va2VybmVsL3NtcF90d2QuYworKysgYi9hcmNoL2FybS9rZXJuZWwvc21wX3R3
ZC5jCkBAIC0zNiw2ICszNiw3IEBAIHN0YXRpYyB2b2lkIHR3ZF9zZXRfbW9kZShlbnVtIGNsb2Nr
X2V2ZW50X21vZGUgbW9kZSwKIAkJLyogdGltZXIgbG9hZCBhbHJlYWR5IHNldCB1cCAqLwogCQlj
dHJsID0gVFdEX1RJTUVSX0NPTlRST0xfRU5BQkxFIHwgVFdEX1RJTUVSX0NPTlRST0xfSVRfRU5B
QkxFCiAJCQl8IFRXRF9USU1FUl9DT05UUk9MX1BFUklPRElDOworCQlfX3Jhd193cml0ZWwodHdk
X3RpbWVyX3JhdGUgLyBIWiwgdHdkX2Jhc2UgKyBUV0RfVElNRVJfTE9BRCk7CiAJCWJyZWFrOwog
CWNhc2UgQ0xPQ0tfRVZUX01PREVfT05FU0hPVDoKIAkJLyogcGVyaW9kIHNldCwgYW5kIHRpbWVy
IGVuYWJsZWQgaW4gJ25leHRfZXZlbnQnIGhvb2sgKi8KQEAgLTgxLDcgKzgyLDcgQEAgaW50IHR3
ZF90aW1lcl9hY2sodm9pZCkKIAogc3RhdGljIHZvaWQgX19jcHVpbml0IHR3ZF9jYWxpYnJhdGVf
cmF0ZSh2b2lkKQogewotCXVuc2lnbmVkIGxvbmcgbG9hZCwgY291bnQ7CisJdW5zaWduZWQgbG9u
ZyBjb3VudDsKIAl1NjQgd2FpdGppZmZpZXM7CiAKIAkvKgpAQCAtMTE2LDEwICsxMTcsNiBAQCBz
dGF0aWMgdm9pZCBfX2NwdWluaXQgdHdkX2NhbGlicmF0ZV9yYXRlKHZvaWQpCiAJCXByaW50aygi
JWx1LiUwMmx1TUh6LlxuIiwgdHdkX3RpbWVyX3JhdGUgLyAxMDAwMDAwLAogCQkJKHR3ZF90aW1l
cl9yYXRlIC8gMTAwMDAwMCkgJSAxMDApOwogCX0KLQotCWxvYWQgPSB0d2RfdGltZXJfcmF0ZSAv
IEhaOwotCi0JX19yYXdfd3JpdGVsKGxvYWQsIHR3ZF9iYXNlICsgVFdEX1RJTUVSX0xPQUQpOwog
fQogCiAvKgotLSAKMS42LjAuNAoK
--001636c5a8605ea19c049aaddef1--
