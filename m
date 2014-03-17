From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:16:55 +0000
Subject: [PATCH 40/44] ARM: l2c: ux500: implement dummy write_sec method
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLEd-0002ea-Mb@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ux500 can't write to any of the secure registers on the L2C controllers,
so provide a dummy handler which ignores all writes.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-ux500/cache-l2x0.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
index 264f894c0e3d..5cc7e3625d8c 100644
--- a/arch/arm/mach-ux500/cache-l2x0.c
+++ b/arch/arm/mach-ux500/cache-l2x0.c
@@ -35,6 +35,14 @@ static int __init ux500_l2x0_unlock(void)
 	return 0;
 }
 
+static void ux500_l2c310_write_sec(unsigned long val, unsigned reg)
+{
+	/*
+	 * We can't write to secure registers as we are in non-secure
+	 * mode, until we have some SMI service available.
+	 */
+}
+
 static int __init ux500_l2x0_init(void)
 {
 	u32 aux_val = 0x3e000000;
@@ -56,21 +64,14 @@ static int __init ux500_l2x0_init(void)
 		/* 64KB way size */
 		aux_val |= (0x3 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT);
 
+	outer_cache.write_sec = ux500_l2c310_write_sec;
+
 	/* 64KB way size, 8 way associativity, force WA */
 	if (of_have_populated_dt())
 		l2x0_of_init(aux_val, 0xc0000fff);
 	else
 		l2x0_init(l2x0_base, aux_val, 0xc0000fff);
 
-	/*
-	 * We can't disable l2 as we are in non secure mode, currently
-	 * this seems be called only during kexec path. So let's
-	 * override outer.disable with nasty assignment until we have
-	 * some SMI service available.
-	 */
-	outer_cache.disable = NULL;
-	outer_cache.set_debug = NULL;
-
 	return 0;
 }
 
-- 
1.8.3.1
