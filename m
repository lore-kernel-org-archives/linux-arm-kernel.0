From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 26 Nov 2015 22:16:58 +0000
Subject: [PATCH] ARM: l2c: tauros2: use descriptive definitions for
 register bits
Message-ID: <E1a24qY-0004Vp-1G@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use descriptive definitions for the Tauros2 register bits, and while
we're here, clean up the "Tauros2: %s line fill burt8." message.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-tauros2.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/cache-tauros2.c b/arch/arm/mm/cache-tauros2.c
index 95eb524ce556..88255bea65e4 100644
--- a/arch/arm/mm/cache-tauros2.c
+++ b/arch/arm/mm/cache-tauros2.c
@@ -22,6 +22,11 @@
 #include <asm/cputype.h>
 #include <asm/hardware/cache-tauros2.h>
 
+/* CP15 PJ4 Control configuration register */
+#define CCR_L2C_PREFETCH_DISABLE	BIT(24)
+#define CCR_L2C_ECC_ENABLE		BIT(23)
+#define CCR_L2C_WAY7_4_DISABLE		BIT(21)
+#define CCR_L2C_BURST8_ENABLE		BIT(20)
 
 /*
  * When Tauros2 is used on a CPU that supports the v7 hierarchical
@@ -182,18 +187,18 @@ static void enable_extra_feature(unsigned int features)
 	u = read_extra_features();
 
 	if (features & CACHE_TAUROS2_PREFETCH_ON)
-		u &= ~0x01000000;
+		u &= ~CCR_L2C_PREFETCH_DISABLE;
 	else
-		u |= 0x01000000;
+		u |= CCR_L2C_PREFETCH_DISABLE;
 	pr_info("Tauros2: %s L2 prefetch.\n",
 			(features & CACHE_TAUROS2_PREFETCH_ON)
 			? "Enabling" : "Disabling");
 
 	if (features & CACHE_TAUROS2_LINEFILL_BURST8)
-		u |= 0x00100000;
+		u |= CCR_L2C_BURST8_ENABLE;
 	else
-		u &= ~0x00100000;
-	pr_info("Tauros2: %s line fill burt8.\n",
+		u &= ~CCR_L2C_BURST8_ENABLE;
+	pr_info("Tauros2: %s burst8 line fill.\n",
 			(features & CACHE_TAUROS2_LINEFILL_BURST8)
 			? "Enabling" : "Disabling");
 
-- 
2.1.0
