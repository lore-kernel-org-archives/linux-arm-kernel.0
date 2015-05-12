From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Tue, 12 May 2015 09:39:14 +0200
Subject: [PATCH 1/2] ARM: cache-l2c: Detect whether it's safe to unlock
In-Reply-To: <1431416355-7693-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1431416355-7693-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <1431416355-7693-2-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The L2C cache should only be unlocked when the cache is setup to allow
that. In the common case the l2x0 driver sets up the cache for that to
be the case (e.g. setting L310_AUX_CTRL_NS_LOCKDOWN on L2C-310), making
unlock safe. However when a secure firmware is in use, it may not be
possible for the L2c to be configured that way making unlocking unsafe.

To handle that, for caches where special configuration is needed to allow
unlocking, check whether this has been setup before unlocking.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---
 arch/arm/mm/cache-l2x0.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index e309c8f..2563458 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -42,6 +42,7 @@ struct l2c_init_data {
 	void (*fixup)(void __iomem *, u32, struct outer_cache_fns *);
 	void (*save)(void __iomem *);
 	void (*configure)(void __iomem *);
+	bool (*can_unlock)(void __iomem *);
 	struct outer_cache_fns outer_cache;
 };
 
@@ -100,6 +101,9 @@ static inline void l2c_unlock(void __iomem *base, unsigned num)
 {
 	unsigned i;
 
+	if (l2x0_data->can_unlock && !l2x0_data->can_unlock(base))
+		return;
+
 	for (i = 0; i < num; i++) {
 		writel_relaxed(0, base + L2X0_LOCKDOWN_WAY_D_BASE +
 			       i * L2X0_LOCKDOWN_STRIDE);
@@ -403,12 +407,18 @@ static void l2c220_enable(void __iomem *base, u32 aux, unsigned num_lock)
 	l2c_enable(base, aux, num_lock);
 }
 
+static bool l2c220_can_unlock(void __iomem *base)
+{
+	return readl_relaxed(base + L2X0_AUX_CTRL) & L220_AUX_CTRL_NS_LOCKDOWN;
+}
+
 static const struct l2c_init_data l2c220_data = {
 	.type = "L2C-220",
 	.way_size_0 = SZ_8K,
 	.num_lock = 1,
 	.enable = l2c220_enable,
 	.save = l2c_save,
+	.can_unlock = l2c220_can_unlock,
 	.outer_cache = {
 		.inv_range = l2c220_inv_range,
 		.clean_range = l2c220_clean_range,
@@ -681,6 +691,11 @@ static void __init l2c310_enable(void __iomem *base, u32 aux, unsigned num_lock)
 	}
 }
 
+static bool l2c310_can_unlock(void __iomem *base)
+{
+	return readl_relaxed(base + L2X0_AUX_CTRL) & L310_AUX_CTRL_NS_LOCKDOWN;
+}
+
 static void __init l2c310_fixup(void __iomem *base, u32 cache_id,
 	struct outer_cache_fns *fns)
 {
@@ -763,6 +778,7 @@ static const struct l2c_init_data l2c310_init_fns __initconst = {
 	.fixup = l2c310_fixup,
 	.save = l2c310_save,
 	.configure = l2c310_configure,
+	.can_unlock = l2c310_can_unlock,
 	.outer_cache = {
 		.inv_range = l2c210_inv_range,
 		.clean_range = l2c210_clean_range,
@@ -1084,6 +1100,7 @@ static const struct l2c_init_data of_l2c220_data __initconst = {
 	.of_parse = l2x0_of_parse,
 	.enable = l2c220_enable,
 	.save = l2c_save,
+	.can_unlock = l2c220_can_unlock,
 	.outer_cache = {
 		.inv_range   = l2c220_inv_range,
 		.clean_range = l2c220_clean_range,
@@ -1211,6 +1228,7 @@ static const struct l2c_init_data of_l2c310_data __initconst = {
 	.fixup = l2c310_fixup,
 	.save  = l2c310_save,
 	.configure = l2c310_configure,
+	.can_unlock = l2c310_can_unlock,
 	.outer_cache = {
 		.inv_range   = l2c210_inv_range,
 		.clean_range = l2c210_clean_range,
@@ -1240,6 +1258,7 @@ static const struct l2c_init_data of_l2c310_coherent_data __initconst = {
 	.fixup = l2c310_fixup,
 	.save  = l2c310_save,
 	.configure = l2c310_configure,
+	.can_unlock = l2c310_can_unlock,
 	.outer_cache = {
 		.inv_range   = l2c210_inv_range,
 		.clean_range = l2c210_clean_range,
@@ -1585,6 +1604,7 @@ static const struct l2c_init_data of_bcm_l2x0_data __initconst = {
 	.enable = l2c310_enable,
 	.save  = l2c310_save,
 	.configure = l2c310_configure,
+	.can_unlock = l2c310_can_unlock,
 	.outer_cache = {
 		.inv_range   = bcm_inv_range,
 		.clean_range = bcm_clean_range,
-- 
2.1.4
