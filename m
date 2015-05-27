From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 27 May 2015 18:40:53 +0100
Subject: [PATCH 4/5] ARM: l2c: only unlock caches if NS_LOCKDOWN bit is set
In-Reply-To: <1432731613.2781.13.camel@collabora.co.uk>
References: <1432731613.2781.13.camel@collabora.co.uk>
Message-ID: <E1YxfK1-00047o-1P@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some L2C caches have a bit which allows non-secure software to control
the cache lockdown.  Some platforms are unable to set this bit.  To
avoid receiving an abort while trying to unlock the cache lines, check
the state of this bit before unlocking.  We do this by providing a new
method in the l2c_init_data to perform the unlocking.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 2864a7bcc24b..95f33620353b 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -42,6 +42,7 @@ struct l2c_init_data {
 	void (*fixup)(void __iomem *, u32, struct outer_cache_fns *);
 	void (*save)(void __iomem *);
 	void (*configure)(void __iomem *);
+	void (*unlock)(void __iomem *, unsigned);
 	struct outer_cache_fns outer_cache;
 };
 
@@ -128,7 +129,7 @@ static void l2c_enable(void __iomem *base, u32 aux, unsigned num_lock)
 	else
 		l2x0_data->configure(base);
 
-	l2c_unlock(base, num_lock);
+	l2x0_data->unlock(base, num_lock);
 
 	local_irq_save(flags);
 	__l2c_op_way(base + L2X0_INV_WAY);
@@ -249,6 +250,7 @@ static const struct l2c_init_data l2c210_data __initconst = {
 	.enable = l2c_enable,
 	.save = l2c_save,
 	.configure = l2c_configure,
+	.unlock = l2c_unlock,
 	.outer_cache = {
 		.inv_range = l2c210_inv_range,
 		.clean_range = l2c210_clean_range,
@@ -400,6 +402,12 @@ static void l2c220_enable(void __iomem *base, u32 aux, unsigned num_lock)
 	l2c_enable(base, aux, num_lock);
 }
 
+static void l2c220_unlock(void __iomem *base, unsigned num_lock)
+{
+	if (readl_relaxed(base + L2X0_AUX_CTRL) & L220_AUX_CTRL_NS_LOCKDOWN)
+		l2c_unlock(base, num_lock);
+}
+
 static const struct l2c_init_data l2c220_data = {
 	.type = "L2C-220",
 	.way_size_0 = SZ_8K,
@@ -407,6 +415,7 @@ static const struct l2c_init_data l2c220_data = {
 	.enable = l2c220_enable,
 	.save = l2c_save,
 	.configure = l2c_configure,
+	.unlock = l2c220_unlock,
 	.outer_cache = {
 		.inv_range = l2c220_inv_range,
 		.clean_range = l2c220_clean_range,
@@ -755,6 +764,12 @@ static void l2c310_resume(void)
 		set_auxcr(get_auxcr() | BIT(3) | BIT(2) | BIT(1));
 }
 
+static void l2c310_unlock(void __iomem *base, unsigned num_lock)
+{
+	if (readl_relaxed(base + L2X0_AUX_CTRL) & L310_AUX_CTRL_NS_LOCKDOWN)
+		l2c_unlock(base, num_lock);
+}
+
 static const struct l2c_init_data l2c310_init_fns __initconst = {
 	.type = "L2C-310",
 	.way_size_0 = SZ_8K,
@@ -763,6 +778,7 @@ static const struct l2c_init_data l2c310_init_fns __initconst = {
 	.fixup = l2c310_fixup,
 	.save = l2c310_save,
 	.configure = l2c310_configure,
+	.unlock = l2c310_unlock,
 	.outer_cache = {
 		.inv_range = l2c210_inv_range,
 		.clean_range = l2c210_clean_range,
@@ -1067,6 +1083,7 @@ static const struct l2c_init_data of_l2c210_data __initconst = {
 	.enable = l2c_enable,
 	.save = l2c_save,
 	.configure = l2c_configure,
+	.unlock = l2c_unlock,
 	.outer_cache = {
 		.inv_range   = l2c210_inv_range,
 		.clean_range = l2c210_clean_range,
@@ -1086,6 +1103,7 @@ static const struct l2c_init_data of_l2c220_data __initconst = {
 	.enable = l2c220_enable,
 	.save = l2c_save,
 	.configure = l2c_configure,
+	.unlock = l2c220_unlock,
 	.outer_cache = {
 		.inv_range   = l2c220_inv_range,
 		.clean_range = l2c220_clean_range,
@@ -1213,6 +1231,7 @@ static const struct l2c_init_data of_l2c310_data __initconst = {
 	.fixup = l2c310_fixup,
 	.save  = l2c310_save,
 	.configure = l2c310_configure,
+	.unlock = l2c310_unlock,
 	.outer_cache = {
 		.inv_range   = l2c210_inv_range,
 		.clean_range = l2c210_clean_range,
@@ -1242,6 +1261,7 @@ static const struct l2c_init_data of_l2c310_coherent_data __initconst = {
 	.fixup = l2c310_fixup,
 	.save  = l2c310_save,
 	.configure = l2c310_configure,
+	.unlock = l2c310_unlock,
 	.outer_cache = {
 		.inv_range   = l2c210_inv_range,
 		.clean_range = l2c210_clean_range,
@@ -1419,6 +1439,7 @@ static const struct l2c_init_data of_aurora_with_outer_data __initconst = {
 	.fixup = aurora_fixup,
 	.save  = aurora_save,
 	.configure = l2c_configure,
+	.unlock = l2c_unlock,
 	.outer_cache = {
 		.inv_range   = aurora_inv_range,
 		.clean_range = aurora_clean_range,
@@ -1439,6 +1460,7 @@ static const struct l2c_init_data of_aurora_no_outer_data __initconst = {
 	.fixup = aurora_fixup,
 	.save  = aurora_save,
 	.configure = l2c_configure,
+	.unlock = l2c_unlock,
 	.outer_cache = {
 		.resume      = l2c_resume,
 	},
@@ -1589,6 +1611,7 @@ static const struct l2c_init_data of_bcm_l2x0_data __initconst = {
 	.enable = l2c310_enable,
 	.save  = l2c310_save,
 	.configure = l2c310_configure,
+	.unlock = l2c310_unlock,
 	.outer_cache = {
 		.inv_range   = bcm_inv_range,
 		.clean_range = bcm_clean_range,
@@ -1626,6 +1649,7 @@ static const struct l2c_init_data of_tauros3_data __initconst = {
 	.enable = l2c_enable,
 	.save  = tauros3_save,
 	.configure = tauros3_configure,
+	.unlock = l2c_unlock,
 	/* Tauros3 broadcasts L1 cache operations to L2 */
 	.outer_cache = {
 		.resume      = l2c_resume,
-- 
2.1.0
