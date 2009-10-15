From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 15 Oct 2009 13:26:07 +0100
Subject: [PATCH] Check whether the SCU was already initialised
Message-ID: <20091015122606.1025.41512.stgit@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If Linux is running in non-secure mode, this register may have been
already initialised and writing to the control register not allowed.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/kernel/smp_scu.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
index d3831f6..9ab4149 100644
--- a/arch/arm/kernel/smp_scu.c
+++ b/arch/arm/kernel/smp_scu.c
@@ -37,6 +37,10 @@ void __init scu_enable(void __iomem *scu_base)
 	u32 scu_ctrl;
 
 	scu_ctrl = __raw_readl(scu_base + SCU_CTRL);
+	/* already enabled? */
+	if (scu_ctrl & 1)
+		return;
+
 	scu_ctrl |= 1;
 	__raw_writel(scu_ctrl, scu_base + SCU_CTRL);
 
