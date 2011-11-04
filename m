From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 04 Nov 2011 11:31:13 +0000
Subject: [PATCH 2/2] ARM: PXA: eseries: fix eseries_register_clks section
	mismatch warning
In-Reply-To: <20111104113032.GY12913@n2100.arm.linux.org.uk>
References: <20111104113032.GY12913@n2100.arm.linux.org.uk>
Message-ID: <E1RMHzN-0001qi-9C@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix:

WARNING: vmlinux.o(.text+0x1a820): Section mismatch in reference from the function eseries_register_clks() to the function .init.text:clkdev_add_table()
The function eseries_register_clks() references
the function __init clkdev_add_table().
This is often because eseries_register_clks lacks a __init
annotation or the annotation of clkdev_add_table is wrong.

by adding the __init annotation to eseries_register_clks() - this
function is only called from other __init-marked functions.  While
we're here, mark it static as it's only called from within eseries.c.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-pxa/eseries.c |    2 +-
 arch/arm/mach-pxa/eseries.h |    1 -
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
index e4a1f4d..55f8e3f 100644
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -144,7 +144,7 @@ static struct clk_lookup eseries_clkregs[] = {
 	INIT_CLKREG(&tmio_dummy_clk, NULL, "CLK_CK32K"),
 };
 
-void eseries_register_clks(void)
+static void __init eseries_register_clks(void)
 {
 	clkdev_add_table(eseries_clkregs, ARRAY_SIZE(eseries_clkregs));
 }
diff --git a/arch/arm/mach-pxa/eseries.h b/arch/arm/mach-pxa/eseries.h
index be92196..b96949d 100644
--- a/arch/arm/mach-pxa/eseries.h
+++ b/arch/arm/mach-pxa/eseries.h
@@ -11,5 +11,4 @@ extern int eseries_tmio_resume(struct platform_device *dev);
 extern void eseries_get_tmio_gpios(void);
 extern struct resource eseries_tmio_resources[];
 extern struct platform_device e300_tc6387xb_device;
-extern void eseries_register_clks(void);
 
-- 
1.7.4.4
