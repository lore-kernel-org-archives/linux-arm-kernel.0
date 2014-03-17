From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:15:13 +0000
Subject: [PATCH 20/44] ARM: l2c: split L2C-310 enable function from l2x0 code
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLCz-0002dC-2A@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide a L2C-310 specific enable function.  The L2C-310 has 8 unlock
registers.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 37dd74c9e61a..e6913bc67c34 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -410,6 +410,12 @@ static const struct l2c_init_data l2x0_init_fns __initconst = {
  *	Affects: store buffer
  *	store buffer is not automatically drained.
  */
+static void l2c310_enable(void __iomem *base, u32 aux)
+{
+	/* PL310 has 8 lock registers */
+	l2c_enable(base, aux, 8);
+}
+
 static void __init l2c310_fixup(void __iomem *base, u32 cache_id,
 	struct outer_cache_fns *fns)
 {
@@ -440,7 +446,7 @@ static void __init l2c310_fixup(void __iomem *base, u32 cache_id,
 }
 
 static const struct l2c_init_data l2c310_init_fns __initconst = {
-	.enable = l2x0_enable,
+	.enable = l2c310_enable,
 	.fixup = l2c310_fixup,
 	.outer_cache = {
 		.inv_range = l2x0_inv_range,
@@ -725,7 +731,7 @@ static void pl310_resume(void)
 
 static const struct l2c_init_data of_pl310_data __initconst = {
 	.of_parse = pl310_of_parse,
-	.enable = l2x0_enable,
+	.enable = l2c310_enable,
 	.fixup = l2c310_fixup,
 	.save  = pl310_save,
 	.outer_cache = {
@@ -1071,7 +1077,7 @@ static void bcm_flush_range(unsigned long start, unsigned long end)
 
 static const struct l2c_init_data of_bcm_l2x0_data __initconst = {
 	.of_parse = pl310_of_parse,
-	.enable = l2x0_enable,
+	.enable = l2c310_enable,
 	.fixup = l2c310_fixup,
 	.save  = pl310_save,
 	.outer_cache = {
-- 
1.8.3.1
