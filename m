From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Tue, 20 Dec 2011 17:38:09 +0900
Subject: [PATCH] ARM: errata: Faulty logic in the Store Buffer may lead to data
 corruption
In-Reply-To: <4EF04923.50203@renesas.com>
References: <4EF04923.50203@renesas.com>
Message-ID: <4EF04971.4060406@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is an update for the existing software workaround for the 743622
Cortex-A9 erratum (475d92fc6e ARM: 6416/1: errata: faulty hazard checking
in the Store Buffer may lead to data corruption).

According to the later errata notice updates, this erratum turned out
to be present not only in (r2p0..r2p2), but in all r2p* revisions.
Also the errata title is corrected to indicate that the errata leads to
data corruption, and not to a processor deadlock as sometimes mentioned
in previous revisions of the document.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
---
 arch/arm/Kconfig      |    4 ++--
 arch/arm/mm/proc-v7.S |    4 +---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 776d76b..ed474b6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1268,11 +1268,11 @@ config PL310_ERRATA_727915
 	  Invalidate by Way operation.
 
 config ARM_ERRATA_743622
-	bool "ARM errata: Faulty hazard checking in the Store Buffer may lead to data corruption"
+	bool "ARM errata: Faulty logic in the Store Buffer may lead to data corruption"
 	depends on CPU_V7
 	help
 	  This option enables the workaround for the 743622 Cortex-A9
-	  (r2p0..r2p2) erratum. Under very rare conditions, a faulty
+	  (r2p0..r2p10) erratum. Under very rare conditions, a faulty
 	  optimisation in the Cortex-A9 Store Buffer may lead to data
 	  corruption. This workaround sets a specific bit in the diagnostic
 	  register of the Cortex-A9 which disables the Store Buffer
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 8f8fced..9f1912d 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -355,9 +355,7 @@ __v7_setup:
 	mcreq	p15, 0, r10, c15, c0, 1		@ write diagnostic register
 #endif
 #ifdef CONFIG_ARM_ERRATA_743622
-	teq	r6, #0x20			@ present in r2p0
-	teqne	r6, #0x21			@ present in r2p1
-	teqne	r6, #0x22			@ present in r2p2
+	teq	r5, #0x00200000			@ present in r2p*
 	mrceq	p15, 0, r10, c15, c0, 1		@ read diagnostic register
 	orreq	r10, r10, #1 << 6		@ set bit #6
 	mcreq	p15, 0, r10, c15, c0, 1		@ write diagnostic register
-- 
1.7.8
