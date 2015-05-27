From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 27 May 2015 18:40:47 +0100
Subject: [PATCH 3/5] ARM: l2c: clean up l2c_configure()
In-Reply-To: <1432731613.2781.13.camel@collabora.co.uk>
References: <1432731613.2781.13.camel@collabora.co.uk>
Message-ID: <E1YxfJv-00047i-Tg@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

l2c_configure() does not follow the pattern of other l2c_* functions.
Fix this so that it does to avoid future confusion.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 977eb9f4f77e..2864a7bcc24b 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -110,15 +110,7 @@ static inline void l2c_unlock(void __iomem *base, unsigned num)
 
 static void l2c_configure(void __iomem *base)
 {
-	if (outer_cache.configure) {
-		outer_cache.configure(&l2x0_saved_regs);
-		return;
-	}
-
 	l2c_write_sec(l2x0_saved_regs.aux_ctrl, base, L2X0_AUX_CTRL);
-
-	if (l2x0_data->configure)
-		l2x0_data->configure(base);
 }
 
 /*
@@ -130,7 +122,11 @@ static void l2c_enable(void __iomem *base, u32 aux, unsigned num_lock)
 	unsigned long flags;
 
 	l2x0_saved_regs.aux_ctrl = aux;
-	l2c_configure(base);
+
+	if (outer_cache.configure)
+		outer_cache.configure(&l2x0_saved_regs);
+	else
+		l2x0_data->configure(base);
 
 	l2c_unlock(base, num_lock);
 
@@ -252,6 +248,7 @@ static const struct l2c_init_data l2c210_data __initconst = {
 	.num_lock = 1,
 	.enable = l2c_enable,
 	.save = l2c_save,
+	.configure = l2c_configure,
 	.outer_cache = {
 		.inv_range = l2c210_inv_range,
 		.clean_range = l2c210_clean_range,
@@ -409,6 +406,7 @@ static const struct l2c_init_data l2c220_data = {
 	.num_lock = 1,
 	.enable = l2c220_enable,
 	.save = l2c_save,
+	.configure = l2c_configure,
 	.outer_cache = {
 		.inv_range = l2c220_inv_range,
 		.clean_range = l2c220_clean_range,
@@ -569,6 +567,8 @@ static void l2c310_configure(void __iomem *base)
 {
 	unsigned revision;
 
+	l2c_configure(base);
+
 	/* restore pl310 setup */
 	l2c_write_sec(l2x0_saved_regs.tag_latency, base,
 		      L310_TAG_LATENCY_CTRL);
@@ -1066,6 +1066,7 @@ static const struct l2c_init_data of_l2c210_data __initconst = {
 	.of_parse = l2x0_of_parse,
 	.enable = l2c_enable,
 	.save = l2c_save,
+	.configure = l2c_configure,
 	.outer_cache = {
 		.inv_range   = l2c210_inv_range,
 		.clean_range = l2c210_clean_range,
@@ -1084,6 +1085,7 @@ static const struct l2c_init_data of_l2c220_data __initconst = {
 	.of_parse = l2x0_of_parse,
 	.enable = l2c220_enable,
 	.save = l2c_save,
+	.configure = l2c_configure,
 	.outer_cache = {
 		.inv_range   = l2c220_inv_range,
 		.clean_range = l2c220_clean_range,
@@ -1416,6 +1418,7 @@ static const struct l2c_init_data of_aurora_with_outer_data __initconst = {
 	.enable = l2c_enable,
 	.fixup = aurora_fixup,
 	.save  = aurora_save,
+	.configure = l2c_configure,
 	.outer_cache = {
 		.inv_range   = aurora_inv_range,
 		.clean_range = aurora_clean_range,
@@ -1435,6 +1438,7 @@ static const struct l2c_init_data of_aurora_no_outer_data __initconst = {
 	.enable = aurora_enable_no_outer,
 	.fixup = aurora_fixup,
 	.save  = aurora_save,
+	.configure = l2c_configure,
 	.outer_cache = {
 		.resume      = l2c_resume,
 	},
@@ -1608,6 +1612,7 @@ static void __init tauros3_save(void __iomem *base)
 
 static void tauros3_configure(void __iomem *base)
 {
+	l2c_configure(base);
 	writel_relaxed(l2x0_saved_regs.aux2_ctrl,
 		       base + TAUROS3_AUX2_CTRL);
 	writel_relaxed(l2x0_saved_regs.prefetch_ctrl,
-- 
2.1.0
