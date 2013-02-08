From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri,  8 Feb 2013 23:17:38 +0000
Subject: [PATCH 08/17] ARM: smp_scu: data endian fixes
In-Reply-To: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1360365467-25056-9-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The smp_scu driver needs to use the relaxed readl/write accessors
to avoid any issues with the endian mode the processor core is in.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/kernel/smp_scu.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
index 45eac87..0fcd0ce 100644
--- a/arch/arm/kernel/smp_scu.c
+++ b/arch/arm/kernel/smp_scu.c
@@ -28,7 +28,7 @@
  */
 unsigned int __init scu_get_core_count(void __iomem *scu_base)
 {
-	unsigned int ncores = __raw_readl(scu_base + SCU_CONFIG);
+	unsigned int ncores = readl_relaxed(scu_base + SCU_CONFIG);
 	return (ncores & 0x03) + 1;
 }
 
@@ -42,19 +42,19 @@ void scu_enable(void __iomem *scu_base)
 #ifdef CONFIG_ARM_ERRATA_764369
 	/* Cortex-A9 only */
 	if ((read_cpuid(CPUID_ID) & 0xff0ffff0) == 0x410fc090) {
-		scu_ctrl = __raw_readl(scu_base + 0x30);
+		scu_ctrl = readl_relaxed(scu_base + 0x30);
 		if (!(scu_ctrl & 1))
-			__raw_writel(scu_ctrl | 0x1, scu_base + 0x30);
+			writel_relaxed(scu_ctrl | 0x1, scu_base + 0x30);
 	}
 #endif
 
-	scu_ctrl = __raw_readl(scu_base + SCU_CTRL);
+	scu_ctrl = readl_relaxed(scu_base + SCU_CTRL);
 	/* already enabled? */
 	if (scu_ctrl & 1)
 		return;
 
 	scu_ctrl |= 1;
-	__raw_writel(scu_ctrl, scu_base + SCU_CTRL);
+	writel_relaxed(scu_ctrl, scu_base + SCU_CTRL);
 
 	/*
 	 * Ensure that the data accessed by CPU0 before the SCU was
@@ -80,9 +80,9 @@ int scu_power_mode(void __iomem *scu_base, unsigned int mode)
 	if (mode > 3 || mode == 1 || cpu > 3)
 		return -EINVAL;
 
-	val = __raw_readb(scu_base + SCU_CPU_STATUS + cpu) & ~0x03;
+	val = readb_relaxed(scu_base + SCU_CPU_STATUS + cpu) & ~0x03;
 	val |= mode;
-	__raw_writeb(val, scu_base + SCU_CPU_STATUS + cpu);
+	writeb_relaxed(val, scu_base + SCU_CPU_STATUS + cpu);
 
 	return 0;
 }
-- 
1.7.10.4
