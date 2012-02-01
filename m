From: will.deacon@arm.com (Will Deacon)
Date: Wed,  1 Feb 2012 13:52:33 +0000
Subject: [PATCH 1/2] ARM: errata: update workaround for A9 erratum #743622
In-Reply-To: <1328104354-7553-1-git-send-email-will.deacon@arm.com>
References: <1328104354-7553-1-git-send-email-will.deacon@arm.com>
Message-ID: <1328104354-7553-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Erratum #743622 affects all r2 variants of the Cortex-A9 processor, so
ensure that the workaround is applied regardless of the revision.

Reported-by: Russell King - ARM Linux <linux@arm.linux.org.uk>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig      |    2 +-
 arch/arm/mm/proc-v7.S |    4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 24626b0..5133128 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1282,7 +1282,7 @@ config ARM_ERRATA_743622
 	depends on CPU_V7
 	help
 	  This option enables the workaround for the 743622 Cortex-A9
-	  (r2p0..r2p2) erratum. Under very rare conditions, a faulty
+	  (r2p*) erratum. Under very rare conditions, a faulty
 	  optimisation in the Cortex-A9 Store Buffer may lead to data
 	  corruption. This workaround sets a specific bit in the diagnostic
 	  register of the Cortex-A9 which disables the Store Buffer
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 7e9b5bf..a4d5a76 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -234,9 +234,7 @@ __v7_setup:
 	mcreq	p15, 0, r10, c15, c0, 1		@ write diagnostic register
 #endif
 #ifdef CONFIG_ARM_ERRATA_743622
-	teq	r6, #0x20			@ present in r2p0
-	teqne	r6, #0x21			@ present in r2p1
-	teqne	r6, #0x22			@ present in r2p2
+	teq	r5, #0x00200000			@ only present in r2p*
 	mrceq	p15, 0, r10, c15, c0, 1		@ read diagnostic register
 	orreq	r10, r10, #1 << 6		@ set bit #6
 	mcreq	p15, 0, r10, c15, c0, 1		@ write diagnostic register
-- 
1.7.4.1
