From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 21 Jul 2014 15:45:54 +0800
Subject: [PATCH 2/3] ARM: smp_scu: enable SCU standby support
In-Reply-To: <1405928755-19413-1-git-send-email-shawn.guo@freescale.com>
References: <1405928755-19413-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1405928755-19413-3-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With SCU standby enabled, SCU CLK will be turned off when all processors
are in WFI mode.  And the clock will be turned on when any processor
leaves WFI mode.

This behavior should be preferable in terms of power efficiency of
system idle.  So let's set the SCU standby bit to enable the support in
function scu_enable().

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/kernel/smp_scu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
index c947508f84e6..9f29d167d02c 100644
--- a/arch/arm/kernel/smp_scu.c
+++ b/arch/arm/kernel/smp_scu.c
@@ -18,6 +18,7 @@
 
 #define SCU_CTRL		0x00
 #define SCU_ENABLE		(1 << 0)
+#define SCU_STANDBY_ENABLE	(1 << 5)
 #define SCU_CONFIG		0x04
 #define SCU_CPU_STATUS		0x08
 #define SCU_INVALIDATE		0x0c
@@ -54,7 +55,7 @@ void scu_enable(void __iomem *scu_base)
 	if (scu_ctrl & SCU_ENABLE)
 		return;
 
-	scu_ctrl |= SCU_ENABLE;
+	scu_ctrl |= SCU_ENABLE | SCU_STANDBY_ENABLE;
 	writel_relaxed(scu_ctrl, scu_base + SCU_CTRL);
 
 	/*
-- 
1.9.1
