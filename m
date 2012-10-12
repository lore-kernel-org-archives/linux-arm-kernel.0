From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Oct 2012 11:14:52 +0000
Subject: [PATCH] ARM: s3c: mark s3c2440_clk_add as __init_refok
Message-ID: <201210121114.52348.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s3c2440_clk_add is a subsys_interface method and calls clkdev_add_table,
which is marked as __init. The modpost script complains about this
because we must not call an __init function from a function in the .text
section, and we cannot reference an __init function from a subsys_interface
pointer.

I have verified that the only code path into s3c2440_clk_add() is
from "int __init s3c2440_init(void)", so s3c2440_clk_add can be marked
__init_refok instead.

Without this patch, building mini2440_defconfig results in:

WARNING: vmlinux.o(.text+0x9848): Section mismatch in reference from the function s3c2440_clk_add() to the function .init.text:clkdev_add_table()
The function s3c2440_clk_add() references
the function __init clkdev_add_table().
This is often because s3c2440_clk_add lacks a __init
annotation or the annotation of clkdev_add_table is wrong.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
---

I'll put this into arm-soc/fixes unless I hear objections. This replaces the
earlier "clk: don't mark clkdev_add_table as init" as suggested by Russell.

diff --git a/arch/arm/mach-s3c24xx/clock-s3c2440.c b/arch/arm/mach-s3c24xx/clock-s3c2440.c
index 749220f..4407b17 100644
--- a/arch/arm/mach-s3c24xx/clock-s3c2440.c
+++ b/arch/arm/mach-s3c24xx/clock-s3c2440.c
@@ -163,7 +163,7 @@ static struct clk_lookup s3c2440_clk_lookup[] = {
 	CLKDEV_INIT(NULL, "clk_uart_baud3", &s3c2440_clk_fclk_n),
 };
 
-static int s3c2440_clk_add(struct device *dev, struct subsys_interface *sif)
+static int __init_refok s3c2440_clk_add(struct device *dev, struct subsys_interface *sif)
 {
 	struct clk *clock_upll;
 	struct clk *clock_h;
