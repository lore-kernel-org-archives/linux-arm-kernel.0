From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Sat, 18 Jun 2016 17:31:03 -0700
Subject: [PATCH v3 1/5] i.MX: system.c: Convert goto to if statement
In-Reply-To: <1466296268-27099-1-git-send-email-andrew.smirnov@gmail.com>
References: <1466296268-27099-1-git-send-email-andrew.smirnov@gmail.com>
Message-ID: <1466296268-27099-3-git-send-email-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using goto here doesn't bring any advantages and only makes the code
flow less clear. No functional changes.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/mach-imx/system.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
index 105d1ce..d9f8b0e 100644
--- a/arch/arm/mach-imx/system.c
+++ b/arch/arm/mach-imx/system.c
@@ -106,26 +106,24 @@ void __init imx_init_l2cache(void)
 		goto out;
 	}
 
-	if (readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN)
-		goto skip_if_enabled;
-
-	/* Configure the L2 PREFETCH and POWER registers */
-	val = readl_relaxed(l2x0_base + L310_PREFETCH_CTRL);
-	val |= 0x70800000;
-	/*
-	 * The L2 cache controller(PL310) version on the i.MX6D/Q is r3p1-50rel0
-	 * The L2 cache controller(PL310) version on the i.MX6DL/SOLO/SL is r3p2
-	 * But according to ARM PL310 errata: 752271
-	 * ID: 752271: Double linefill feature can cause data corruption
-	 * Fault Status: Present in: r3p0, r3p1, r3p1-50rel0. Fixed in r3p2
-	 * Workaround: The only workaround to this erratum is to disable the
-	 * double linefill feature. This is the default behavior.
-	 */
-	if (cpu_is_imx6q())
-		val &= ~(1 << 30 | 1 << 23);
-	writel_relaxed(val, l2x0_base + L310_PREFETCH_CTRL);
+	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN)) {
+		/* Configure the L2 PREFETCH and POWER registers */
+		val = readl_relaxed(l2x0_base + L310_PREFETCH_CTRL);
+		val |= 0x70800000;
+		/*
+		 * The L2 cache controller(PL310) version on the i.MX6D/Q is r3p1-50rel0
+		 * The L2 cache controller(PL310) version on the i.MX6DL/SOLO/SL is r3p2
+		 * But according to ARM PL310 errata: 752271
+		 * ID: 752271: Double linefill feature can cause data corruption
+		 * Fault Status: Present in: r3p0, r3p1, r3p1-50rel0. Fixed in r3p2
+		 * Workaround: The only workaround to this erratum is to disable the
+		 * double linefill feature. This is the default behavior.
+		 */
+		if (cpu_is_imx6q())
+			val &= ~(1 << 30 | 1 << 23);
+		writel_relaxed(val, l2x0_base + L310_PREFETCH_CTRL);
+	}
 
-skip_if_enabled:
 	iounmap(l2x0_base);
 	of_node_put(np);
 
-- 
2.5.5
