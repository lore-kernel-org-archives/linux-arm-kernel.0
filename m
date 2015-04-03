From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 03 Apr 2015 18:13:08 +0100
Subject: [PATCH 09/14] ARM: lpc32xx: convert to use clkdev_add_table()
In-Reply-To: <20150403171149.GC13898@n2100.arm.linux.org.uk>
References: <20150403171149.GC13898@n2100.arm.linux.org.uk>
Message-ID: <E1Ye59Y-0001BV-NY@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have always had an efficient way of registering a table of clock
lookups - it's called clkdev_add_table().  However, some people seem
to really love writing inefficient and unnecessary code.

Convert LPC32xx to use the correct interface.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-lpc32xx/clock.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
index dd5d6f532e8c..661c8f4b2310 100644
--- a/arch/arm/mach-lpc32xx/clock.c
+++ b/arch/arm/mach-lpc32xx/clock.c
@@ -1238,10 +1238,7 @@ static struct clk_lookup lookups[] = {
 
 static int __init clk_init(void)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(lookups); i++)
-		clkdev_add(&lookups[i]);
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
 	/*
 	 * Setup muxed SYSCLK for HCLK PLL base -this selects the
-- 
1.8.3.1
