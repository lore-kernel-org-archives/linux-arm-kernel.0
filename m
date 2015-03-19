From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 19 Mar 2015 14:54:15 +0100
Subject: [PATCH] ARM: smp_scu: enable coherent speculative linefills
Message-ID: <1426773255-23349-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the ARM TRM, about the SCU Control Register, bit 3
(Speculative linefills enable) :

  When set, coherent linefill requests are sent speculatively to the
  PL310 in parallel with the tag lookup. If the tag lookup misses, the
  confirmed linefill is sent to the PL310 and gets Rdata earlier
  because the data request was already initiated by the speculative
  request. This feature works only if the PL310 is present in the
  design.

This feature may improve the overall system performance.

Since the public ARM web site only documents Cortex-A9 revisions r2p0
and later, we err on the safe side and only enable this bit on >= r2p0
platforms, like the standby bit.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/kernel/smp_scu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
index 72f9241..227bb86 100644
--- a/arch/arm/kernel/smp_scu.c
+++ b/arch/arm/kernel/smp_scu.c
@@ -18,6 +18,7 @@
 
 #define SCU_CTRL		0x00
 #define SCU_ENABLE		(1 << 0)
+#define SCU_SPEC_LINEFILL	(1 << 3)
 #define SCU_STANDBY_ENABLE	(1 << 5)
 #define SCU_CONFIG		0x04
 #define SCU_CPU_STATUS		0x08
@@ -57,10 +58,13 @@ void scu_enable(void __iomem *scu_base)
 
 	scu_ctrl |= SCU_ENABLE;
 
-	/* Cortex-A9 earlier than r2p0 has no standby bit in SCU */
+	/*
+	 * Cortex-A9 earlier than r2p0 has no standby / speculative
+	 * line fills bits in SCU
+	 */
 	if ((read_cpuid_id() & 0xff0ffff0) == 0x410fc090 &&
 	    (read_cpuid_id() & 0x00f0000f) >= 0x00200000)
-		scu_ctrl |= SCU_STANDBY_ENABLE;
+		scu_ctrl |= SCU_STANDBY_ENABLE | SCU_SPEC_LINEFILL;
 
 	writel_relaxed(scu_ctrl, scu_base + SCU_CTRL);
 
-- 
2.1.0
