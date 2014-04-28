From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 28 Apr 2014 20:30:53 +0100
Subject: [PATCH 55/97] ARM: l2c: ux500: remove associativity and way size from
 aux_ctrl
In-Reply-To: <20140428192419.GV26756@n2100.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Message-ID: <E1WerGP-0001XU-0L@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-ux500/cache-l2x0.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
index 067c37a054fb..5b891d051054 100644
--- a/arch/arm/mach-ux500/cache-l2x0.c
+++ b/arch/arm/mach-ux500/cache-l2x0.c
@@ -45,8 +45,6 @@ static void ux500_l2c310_write_sec(unsigned long val, unsigned reg)
 
 static int __init ux500_l2x0_init(void)
 {
-	u32 aux_val = 0x3e000000;
-
 	if (cpu_is_u8500_family() || cpu_is_ux540_family())
 		l2x0_base = __io_address(U8500_L2CC_BASE);
 	else
@@ -56,21 +54,12 @@ static int __init ux500_l2x0_init(void)
 	/* Unlock before init */
 	ux500_l2x0_unlock();
 
-	/* DBx540's L2 has 128KB way size */
-	if (cpu_is_ux540_family())
-		/* 128KB way size */
-		aux_val |= L2C_AUX_CTRL_WAY_SIZE(4);
-	else
-		/* 64KB way size */
-		aux_val |= L2C_AUX_CTRL_WAY_SIZE(3);
-
 	outer_cache.write_sec = ux500_l2c310_write_sec;
 
-	/* 64KB way size, 8 way associativity, force WA */
 	if (of_have_populated_dt())
-		l2x0_of_init(aux_val, 0xc0000fff);
+		l2x0_of_init(0x3e000000, 0xc00f0fff);
 	else
-		l2x0_init(l2x0_base, aux_val, 0xc0000fff);
+		l2x0_init(l2x0_base, 0x3e000000, 0xc00f0fff);
 
 	return 0;
 }
-- 
1.8.3.1
