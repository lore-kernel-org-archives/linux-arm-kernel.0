From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 19 Jun 2013 13:36:43 +0100
Subject: [PATCH 07/10] ARM: smp_scu: data endian fixes
In-Reply-To: <1371645406-16873-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1371645406-16873-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1371645406-16873-8-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The smp_scu driver needs to use the relaxed readl/write accessors
to avoid any issues with the endian mode the processor core is in.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/kernel/smp_scu.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
index 5bc1a63..0fcd0ce 100644
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
 
@@ -41,20 +41,20 @@ void scu_enable(void __iomem *scu_base)
 
 #ifdef CONFIG_ARM_ERRATA_764369
 	/* Cortex-A9 only */
-	if ((read_cpuid_id() & 0xff0ffff0) == 0x410fc090) {
-		scu_ctrl = __raw_readl(scu_base + 0x30);
+	if ((read_cpuid(CPUID_ID) & 0xff0ffff0) == 0x410fc090) {
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
