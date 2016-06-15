From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Tue, 14 Jun 2016 18:29:50 -0700
Subject: [PATCH v2 3/6] i.MX: system.c: Replace magic numbers
In-Reply-To: <1465954193-5894-1-git-send-email-andrew.smirnov@gmail.com>
References: <1465954193-5894-1-git-send-email-andrew.smirnov@gmail.com>
Message-ID: <1465954193-5894-4-git-send-email-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/include/asm/hardware/cache-l2x0.h | 1 +
 arch/arm/mach-imx/system.c                 | 5 ++++-
 arch/arm/mm/cache-l2x0.c                   | 6 ++++--
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index 3a5ec1c..e0ce59c 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -121,6 +121,7 @@
 #define L310_AUX_CTRL_STORE_LIMITATION		BIT(11)	/* R2P0+ */
 #define L310_AUX_CTRL_EXCLUSIVE_CACHE		BIT(12)
 #define L310_AUX_CTRL_ASSOCIATIVITY_16		BIT(16)
+
 #define L310_AUX_CTRL_CACHE_REPLACE_RR		BIT(25)	/* R2P0+ */
 #define L310_AUX_CTRL_NS_LOCKDOWN		BIT(26)
 #define L310_AUX_CTRL_NS_INT_CTRL		BIT(27)
diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
index b153376..f0a9787 100644
--- a/arch/arm/mach-imx/system.c
+++ b/arch/arm/mach-imx/system.c
@@ -109,7 +109,10 @@ void __init imx_init_l2cache(void)
 	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN)) {
 		/* Configure the L2 PREFETCH and POWER registers */
 		val = readl_relaxed(l2x0_base + L310_PREFETCH_CTRL);
-		val |= 0x70800000;
+		val |=  L310_PREFETCH_CTRL_DBL_LINEFILL |
+		        L310_PREFETCH_CTRL_INSTR_PREFETCH |
+			L310_PREFETCH_CTRL_DATA_PREFETCH |
+			L310_PREFETCH_CTRL_DBL_LINEFILL_INCR;
 		writel_relaxed(val, l2x0_base + L310_PREFETCH_CTRL);
 	}
 
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 9f9d542..30e2012 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -716,8 +716,10 @@ static void __init l2c310_fixup(void __iomem *base, u32 cache_id,
 	    revision < L310_CACHE_ID_RTL_R3P2) {
 		u32 val = l2x0_saved_regs.prefetch_ctrl;
 		/* I don't think bit23 is required here... but iMX6 does so */
-		if (val & (BIT(30) | BIT(23))) {
-			val &= ~(BIT(30) | BIT(23));
+		if (val & (L310_PREFETCH_CTRL_DBL_LINEFILL |
+			   L310_PREFETCH_CTRL_DBL_LINEFILL_INCR)) {
+			val &= ~(L310_PREFETCH_CTRL_DBL_LINEFILL |
+				 L310_PREFETCH_CTRL_DBL_LINEFILL_INCR);
 			l2x0_saved_regs.prefetch_ctrl = val;
 			errata[n++] = "752271";
 		}
-- 
2.5.5
