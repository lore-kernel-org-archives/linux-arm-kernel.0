From: nitin.garg@freescale.com (Nitin Garg)
Date: Mon, 31 Mar 2014 18:29:24 -0500
Subject: [PATCH] ARM: errata: Fix the workaround for erratum 764369
Message-ID: <1396308564-4613-1-git-send-email-nitin.garg@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SCU diagnostic control register at offset 0x30 is
write-only register, so do not do read-modify write.

Signed-off-by: Nitin Garg <nitin.garg@freescale.com>
---
 arch/arm/kernel/smp_scu.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
index 1aafa0d..b0cca7e 100644
--- a/arch/arm/kernel/smp_scu.c
+++ b/arch/arm/kernel/smp_scu.c
@@ -42,9 +42,7 @@ void scu_enable(void __iomem *scu_base)
 #ifdef CONFIG_ARM_ERRATA_764369
 	/* Cortex-A9 only */
 	if ((read_cpuid_id() & 0xff0ffff0) == 0x410fc090) {
-		scu_ctrl = readl_relaxed(scu_base + 0x30);
-		if (!(scu_ctrl & 1))
-			writel_relaxed(scu_ctrl | 0x1, scu_base + 0x30);
+		writel_relaxed(0x1, scu_base + 0x30);
 	}
 #endif
 
-- 
1.7.4.1
