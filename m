From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Tue,  7 Jun 2016 08:29:25 -0700
Subject: [PATCH 2/3] i.MX: system.c: Remove redundant errat 752271 code
In-Reply-To: <1465313366-5182-1-git-send-email-andrew.smirnov@gmail.com>
References: <1465313366-5182-1-git-send-email-andrew.smirnov@gmail.com>
Message-ID: <1465313366-5182-2-git-send-email-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Applying a fix for ARM errata 752271 would already be taken care by a
call to a 'fixup' hook as a part of l2x0_of_init() -> __l2c_init() call
chain. Moreso the code in 'fixup' function would do that based on the
PL310's revsion information, whereas removde code does so based on SoC
version which does not work very well on i.MX6Q+ which identifies itself
as i.MX6Q as well but is not affected by 752271.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/mach-imx/system.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
index d9f8b0e..b153376 100644
--- a/arch/arm/mach-imx/system.c
+++ b/arch/arm/mach-imx/system.c
@@ -110,17 +110,6 @@ void __init imx_init_l2cache(void)
 		/* Configure the L2 PREFETCH and POWER registers */
 		val = readl_relaxed(l2x0_base + L310_PREFETCH_CTRL);
 		val |= 0x70800000;
-		/*
-		 * The L2 cache controller(PL310) version on the i.MX6D/Q is r3p1-50rel0
-		 * The L2 cache controller(PL310) version on the i.MX6DL/SOLO/SL is r3p2
-		 * But according to ARM PL310 errata: 752271
-		 * ID: 752271: Double linefill feature can cause data corruption
-		 * Fault Status: Present in: r3p0, r3p1, r3p1-50rel0. Fixed in r3p2
-		 * Workaround: The only workaround to this erratum is to disable the
-		 * double linefill feature. This is the default behavior.
-		 */
-		if (cpu_is_imx6q())
-			val &= ~(1 << 30 | 1 << 23);
 		writel_relaxed(val, l2x0_base + L310_PREFETCH_CTRL);
 	}
 
-- 
2.5.5
