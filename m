From: marc.ceeeee@gmail.com (Marc Carino)
Date: Wed, 26 Feb 2014 02:29:08 -0800
Subject: [PATCH v7 5/9] ARM: Enable erratum 798181 for Broadcom Brahma-B15
In-Reply-To: <1393410552-21497-1-git-send-email-marc.ceeeee@gmail.com>
References: <1393410552-21497-1-git-send-email-marc.ceeeee@gmail.com>
Message-ID: <1393410552-21497-6-git-send-email-marc.ceeeee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory Fong <gregory.0xf0@gmail.com>

Broadcom Brahma-B15 (r0p0..r0p2) is also affected by Cortex-A15
erratum 798181, so enable the workaround for Brahma-B15.

Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
Acked-by: Marc Carino <marc.ceeeee@gmail.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/smp_tlb.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/smp_tlb.c b/arch/arm/kernel/smp_tlb.c
index 95d0636..5518e3f 100644
--- a/arch/arm/kernel/smp_tlb.c
+++ b/arch/arm/kernel/smp_tlb.c
@@ -92,15 +92,19 @@ void erratum_a15_798181_init(void)
 	unsigned int midr = read_cpuid_id();
 	unsigned int revidr = read_cpuid(CPUID_REVIDR);
 
-	/* Cortex-A15 r0p0..r3p2 w/o ECO fix affected */
-	if ((midr & 0xff0ffff0) != 0x410fc0f0 || midr > 0x413fc0f2 ||
-	    (revidr & 0x210) == 0x210) {
-		return;
-	}
-	if (revidr & 0x10)
-		erratum_a15_798181_handler = erratum_a15_798181_partial;
-	else
+	/* Brahma-B15 r0p0..(not yet fixed) affected
+	 * Cortex-A15 r0p0..r3p2 w/o ECO fix affected */
+	if ((midr & 0xff0ffff0) == 0x420f00f0)
 		erratum_a15_798181_handler = erratum_a15_798181_broadcast;
+	else if ((midr & 0xff0ffff0) == 0x410fc0f0 && midr <= 0x413fc0f2 &&
+		 (revidr & 0x210) != 0x210) {
+		if (revidr & 0x10)
+			erratum_a15_798181_handler =
+				erratum_a15_798181_partial;
+		else
+			erratum_a15_798181_handler =
+				erratum_a15_798181_broadcast;
+	}
 }
 #endif
 
-- 
1.7.1
