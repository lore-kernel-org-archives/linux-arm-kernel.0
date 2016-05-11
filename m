From: matija.glavinic-pecotic.ext@nokia.com (Matija Glavinic Pecotic)
Date: Wed, 11 May 2016 22:33:51 +0200
Subject: [PATCH] [ARM] Fix A15 798181 errata initialization
Message-ID: <5733972F.9040502@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current errata initialization doesn't take properly revision and REVIDR
into account. Depending on the core revision, revidr bits should not be
taken into account. Errata misleadingly declares r3p3 to be error-free,
but this is not the case. Include rp3p3 in errata initialization.

Here are possible fixes defined in revidr register for r2 and r3 [1,2]:

r0p0-r2p1: No fixes applied

r2p2,r2p3:

REVIDR[4]: 798181 Moving a virtual page that is being accessed by
	   an active process can lead to unexpected behavior
REVIDR[9]: Not defined

r2p4,r3p0,r3p1,r3p2:

REVIDR[4]: 798181 Moving a virtual page that is being accessed by
	   an active process can lead to unexpected behavior
REVIDR[9]: 798181 Moving a virtual page that is being accessed by
	   an active process can lead to unexpected behavior
	   - This is an update to a previously released ECO.

r3p3:

REVIDR[4]: Reserved
REVIDR[9]: 798181 Moving a virtual page that is being accessed by
	   an active process can lead to unexpected behavior
	   - This is an update to a previously released ECO.

And here is proposed handling from the same documents [1,2]:

* In r3p2 and earlier versions with REVIDR[4]= 0,the full workaround is
  required.
* In r3p2 and earlier versions with REVIDR[4]=1, REVIDR[9]=0, only the
  portion of the workaround up to the end of step 6 is required.
* In r3p2 and earlier versions with REVIDR[4]=1, REVIDR[9]=1, no
  workaround is required.
* In r3p3, if REVIDR[9]=0, only the portion of the workaround up
  to the end of step 6 is required.
* In r3p3, if REVIDR[9]=1, no workaround is required.

These imply following:

REVIDR[9] set -> No WA
REVIDR[4] set, REVIDR[9] cleared -> Partial WA
Both cleared -> Full WA

Where certain bits should and should not be taken into account
depending on whether they are defined for the revision.

Although not explicitly mentioned in the errata note, REVIDR[9] set,
with REVIDR[4] cleared is valid combination which requires no WA. This
is confirmed by ARM support and errata will be updated.

[1] ARM CortexTM-A15 MPCore - NEON
    Product revision r3
    Software Developers Errata Notice
    ARM-EPM-028093 v20.0 Released

[2] ARM CortexTM-A15 MPCore - NEON
    Product Revision r2
    Software Developers Errata Notice
    ARM-EPM-028090 v19.3 Released

Signed-off-by: Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/arm/kernel/smp_tlb.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/smp_tlb.c b/arch/arm/kernel/smp_tlb.c
index 2e72be4..b624758 100644
--- a/arch/arm/kernel/smp_tlb.c
+++ b/arch/arm/kernel/smp_tlb.c
@@ -93,17 +93,30 @@ void erratum_a15_798181_init(void)
 	unsigned int revidr = read_cpuid(CPUID_REVIDR);
 
 	/* Brahma-B15 r0p0..r0p2 affected
-	 * Cortex-A15 r0p0..r3p2 w/o ECO fix affected */
-	if ((midr & 0xff0ffff0) == 0x420f00f0 && midr <= 0x420f00f2)
+	 * Cortex-A15 r0p0..r3p3 w/o ECO fix affected
+	 */
+	if ((midr & 0xff0ffff0) == 0x420f00f0 && midr <= 0x420f00f2) {
 		erratum_a15_798181_handler = erratum_a15_798181_broadcast;
-	else if ((midr & 0xff0ffff0) == 0x410fc0f0 && midr <= 0x413fc0f2 &&
-		 (revidr & 0x210) != 0x210) {
+	} else if ((midr & 0xff0ffff0) == 0x410fc0f0 && midr < 0x412fc0f2) {
+		erratum_a15_798181_handler = erratum_a15_798181_broadcast;
+	} else if ((midr & 0xff0ffff0) == 0x410fc0f0 && midr < 0x412fc0f4) {
 		if (revidr & 0x10)
 			erratum_a15_798181_handler =
 				erratum_a15_798181_partial;
 		else
 			erratum_a15_798181_handler =
 				erratum_a15_798181_broadcast;
+	} else if ((midr & 0xff0ffff0) == 0x410fc0f0 && midr < 0x413fc0f3) {
+		if ((revidr & 0x210) == 0)
+			erratum_a15_798181_handler =
+				erratum_a15_798181_broadcast;
+		else if (revidr & 0x10)
+			erratum_a15_798181_handler =
+				erratum_a15_798181_partial;
+	} else if ((midr & 0xff0ffff0) == 0x410fc0f0 && midr < 0x414fc0f0) {
+		if ((revidr & 0x200) == 0)
+			erratum_a15_798181_handler =
+				erratum_a15_798181_partial;
 	}
 }
 #endif
-- 
2.1.4
