From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:16:45 +0000
Subject: [PATCH 38/44] ARM: l2c: OMAP: implement new write_sec method
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLET-0002eS-Ev@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the write_sec method, we no longer need to override the default
L2C disable method, and we no longer need the L2C set_debug method.
Both of these can be handled via the write_sec method.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/omap4-common.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 6cd3f3772ecf..07b4efd23078 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -166,17 +166,29 @@ void __iomem *omap4_get_l2cache_base(void)
 	return l2cache_base;
 }
 
-static void omap4_l2x0_disable(void)
+static void omap4_l2c310_write_sec(unsigned long val, unsigned reg)
 {
-	outer_flush_all();
-	/* Disable PL310 L2 Cache controller */
-	omap_smc1(0x102, 0x0);
-}
+	unsigned smc_op;
 
-static void omap4_l2x0_set_debug(unsigned long val)
-{
-	/* Program PL310 L2 Cache controller debug register */
-	omap_smc1(0x100, val);
+	switch (reg) {
+	case L2X0_CTRL:
+		smc_op = 0x102;
+		break;
+
+	case L2X0_AUX_CTRL:
+		smc_op = 0x109;
+		break;
+
+	case L2X0_DEBUG_CTRL:
+		smc_op = 0x100:
+		break;
+
+	default:
+		WARN_ONCE(1, "OMAP L2C310: ignoring write to reg 0x%x\n", reg);
+		return;
+	}
+
+	omap_smc1(smc_op, val);
 }
 
 static int __init omap_l2_cache_init(void)
@@ -220,18 +232,12 @@ static int __init omap_l2_cache_init(void)
 	/* Enable PL310 L2 Cache controller */
 	omap_smc1(0x102, 0x1);
 
+	outer_cache.write_sec = omap4_l2c310_write_sec;
 	if (of_have_populated_dt())
 		l2x0_of_init(aux_ctrl, L2X0_AUX_CTRL_MASK);
 	else
 		l2x0_init(l2cache_base, aux_ctrl, L2X0_AUX_CTRL_MASK);
 
-	/*
-	 * Override default outer_cache.disable with a OMAP4
-	 * specific one
-	*/
-	outer_cache.disable = omap4_l2x0_disable;
-	outer_cache.set_debug = omap4_l2x0_set_debug;
-
 	return 0;
 }
 omap_early_initcall(omap_l2_cache_init);
-- 
1.8.3.1
