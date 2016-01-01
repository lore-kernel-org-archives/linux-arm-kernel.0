From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 01 Jan 2016 14:42:52 +0100
Subject: [PATCH] [BUG] clk: rockchip: don't mark clock names as initconst
Message-ID: <2791943.MBZ53mI7Gp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The latest changes to the rockchip clk implementation cause
tons of warnings and/or errors (depending on the configuration):

WARNING: vmlinux.o(.data+0x125394): Section mismatch in reference from the variable __compound_literal.125 to the (unknown reference) .init.rodata:(unknown)

The reason is a compount literal in a macro that refers to an
object in the .init.rodata section:

 #define COMPOSITE_FRACMUX(_id, cname, pname, f, mo, df, go, gs, gf, ch) \
        {                                                       \
		...
                .child          = &(struct rockchip_clk_branch)ch, \
        }

'ch' here is placed in .data, and I could find no way to override that
using an attribute or pragma because there is no identifier associated
with it.

This patch avoids the warning by placing the names in .rodata rather than
.init.rodata. However, it is not an ideal solution because we really
want all those data structures to be discarded along with the initdata.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 8ca1ca8f6039 ("clk: rockchip: handle mux dependency of fractional dividers")

diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 3f71ee5d1bc9..5cadf5e3fb16 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -244,7 +244,7 @@ struct clk *rockchip_clk_register_inverter(const char *name,
 				void __iomem *reg, int shift, int flags,
 				spinlock_t *lock);
 
-#define PNAME(x) static const char *const x[] __initconst
+#define PNAME(x) static const char *const x[]
 
 enum rockchip_clk_branch_type {
 	branch_composite,
