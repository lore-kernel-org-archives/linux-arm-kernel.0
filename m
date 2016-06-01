From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed,  1 Jun 2016 16:15:05 -0700
Subject: [PATCH 06/34] clk: bcm: kona: Migrate to clk_hw based registration
 and OF APIs
In-Reply-To: <20160601231533.9354-1-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
Message-ID: <20160601231533.9354-7-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we can use clk_hw pointers we don't need to have two
duplicate arrays holding the same mapping of clk index to clk_hw
pointer. Implement a custom clk_hw provider function to map the
OF specifier to the clk_hw instance for it.

Cc: Alex Elder <elder@linaro.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

See commit 58657d189a2f and it's children for details on this
new registration API.

 drivers/clk/bcm/clk-kona-setup.c | 76 ++++++++++++++++++----------------------
 drivers/clk/bcm/clk-kona.c       |  9 +++--
 drivers/clk/bcm/clk-kona.h       |  7 ++--
 3 files changed, 41 insertions(+), 51 deletions(-)

diff --git a/drivers/clk/bcm/clk-kona-setup.c b/drivers/clk/bcm/clk-kona-setup.c
index 526b0b0e9a9f..f2359b3b73bc 100644
--- a/drivers/clk/bcm/clk-kona-setup.c
+++ b/drivers/clk/bcm/clk-kona-setup.c
@@ -696,77 +696,69 @@ static void bcm_clk_teardown(struct kona_clk *bcm_clk)
 	bcm_clk->type = bcm_clk_none;
 }
 
-static void kona_clk_teardown(struct clk *clk)
+static void kona_clk_teardown(struct clk_hw *hw)
 {
-	struct clk_hw *hw;
 	struct kona_clk *bcm_clk;
 
-	if (!clk)
+	if (!hw)
 		return;
 
-	hw = __clk_get_hw(clk);
-	if (!hw) {
-		pr_err("%s: clk %p has null hw pointer\n", __func__, clk);
-		return;
-	}
-	clk_unregister(clk);
+	clk_hw_unregister(hw);
 
 	bcm_clk = to_kona_clk(hw);
 	bcm_clk_teardown(bcm_clk);
 }
 
-struct clk *kona_clk_setup(struct kona_clk *bcm_clk)
+static int kona_clk_setup(struct kona_clk *bcm_clk)
 {
+	int ret;
 	struct clk_init_data *init_data = &bcm_clk->init_data;
-	struct clk *clk = NULL;
 
 	switch (bcm_clk->type) {
 	case bcm_clk_peri:
-		if (peri_clk_setup(bcm_clk->u.data, init_data))
-			return NULL;
+		ret = peri_clk_setup(bcm_clk->u.data, init_data);
+		if (ret)
+			return ret;
 		break;
 	default:
 		pr_err("%s: clock type %d invalid for %s\n", __func__,
 			(int)bcm_clk->type, init_data->name);
-		return NULL;
+		return -EINVAL;
 	}
 
 	/* Make sure everything makes sense before we set it up */
 	if (!kona_clk_valid(bcm_clk)) {
 		pr_err("%s: clock data invalid for %s\n", __func__,
 			init_data->name);
+		ret = -EINVAL;
 		goto out_teardown;
 	}
 
 	bcm_clk->hw.init = init_data;
-	clk = clk_register(NULL, &bcm_clk->hw);
-	if (IS_ERR(clk)) {
-		pr_err("%s: error registering clock %s (%ld)\n", __func__,
-			init_data->name, PTR_ERR(clk));
+	ret = clk_hw_register(NULL, &bcm_clk->hw);
+	if (ret) {
+		pr_err("%s: error registering clock %s (%d)\n", __func__,
+			init_data->name, ret);
 		goto out_teardown;
 	}
-	BUG_ON(!clk);
 
-	return clk;
+	return 0;
 out_teardown:
 	bcm_clk_teardown(bcm_clk);
 
-	return NULL;
+	return ret;
 }
 
 static void ccu_clks_teardown(struct ccu_data *ccu)
 {
 	u32 i;
 
-	for (i = 0; i < ccu->clk_data.clk_num; i++)
-		kona_clk_teardown(ccu->clk_data.clks[i]);
-	kfree(ccu->clk_data.clks);
+	for (i = 0; i < ccu->clk_num; i++)
+		kona_clk_teardown(&ccu->kona_clks[i].hw);
 }
 
 static void kona_ccu_teardown(struct ccu_data *ccu)
 {
-	kfree(ccu->clk_data.clks);
-	ccu->clk_data.clks = NULL;
 	if (!ccu->base)
 		return;
 
@@ -793,6 +785,20 @@ static bool ccu_data_valid(struct ccu_data *ccu)
 	return true;
 }
 
+static struct clk_hw *
+of_clk_kona_onecell_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct ccu_data *ccu = data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx >= ccu->clk_num) {
+		pr_err("%s: invalid index %u\n", __func__, idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return &ccu->kona_clks[idx].hw;
+}
+
 /*
  * Set up a CCU.  Call the provided ccu_clks_setup callback to
  * initialize the array of clocks provided by the CCU.
@@ -805,18 +811,6 @@ void __init kona_dt_ccu_setup(struct ccu_data *ccu,
 	unsigned int i;
 	int ret;
 
-	if (ccu->clk_data.clk_num) {
-		size_t size;
-
-		size = ccu->clk_data.clk_num * sizeof(*ccu->clk_data.clks);
-		ccu->clk_data.clks = kzalloc(size, GFP_KERNEL);
-		if (!ccu->clk_data.clks) {
-			pr_err("%s: unable to allocate %u clocks for %s\n",
-				__func__, ccu->clk_data.clk_num, node->name);
-			return;
-		}
-	}
-
 	ret = of_address_to_resource(node, 0, &res);
 	if (ret) {
 		pr_err("%s: no valid CCU registers found for %s\n", __func__,
@@ -851,13 +845,13 @@ void __init kona_dt_ccu_setup(struct ccu_data *ccu,
 	 * the clock framework clock array (in ccu->data).  Then
 	 * register as a provider for these clocks.
 	 */
-	for (i = 0; i < ccu->clk_data.clk_num; i++) {
+	for (i = 0; i < ccu->clk_num; i++) {
 		if (!ccu->kona_clks[i].ccu)
 			continue;
-		ccu->clk_data.clks[i] = kona_clk_setup(&ccu->kona_clks[i]);
+		kona_clk_setup(&ccu->kona_clks[i]);
 	}
 
-	ret = of_clk_add_provider(node, of_clk_src_onecell_get, &ccu->clk_data);
+	ret = of_clk_add_hw_provider(node, of_clk_kona_onecell_get, ccu);
 	if (ret) {
 		pr_err("%s: error adding ccu %s as provider (%d)\n", __func__,
 				node->name, ret);
diff --git a/drivers/clk/bcm/clk-kona.c b/drivers/clk/bcm/clk-kona.c
index 3a15347b4233..eee64b9e5d10 100644
--- a/drivers/clk/bcm/clk-kona.c
+++ b/drivers/clk/bcm/clk-kona.c
@@ -1256,19 +1256,18 @@ bool __init kona_ccu_init(struct ccu_data *ccu)
 {
 	unsigned long flags;
 	unsigned int which;
-	struct clk **clks = ccu->clk_data.clks;
 	struct kona_clk *kona_clks = ccu->kona_clks;
 	bool success = true;
 
 	flags = ccu_lock(ccu);
 	__ccu_write_enable(ccu);
 
-	for (which = 0; which < ccu->clk_data.clk_num; which++) {
-		struct kona_clk *bcm_clk;
+	for (which = 0; which < ccu->clk_num; which++) {
+		struct kona_clk *bcm_clk = &kona_clks[which];
 
-		if (!clks[which])
+		if (!bcm_clk->ccu)
 			continue;
-		bcm_clk = &kona_clks[which];
+
 		success &= __kona_clk_init(bcm_clk);
 	}
 
diff --git a/drivers/clk/bcm/clk-kona.h b/drivers/clk/bcm/clk-kona.h
index 906576ec97b6..f4b39bb5558a 100644
--- a/drivers/clk/bcm/clk-kona.h
+++ b/drivers/clk/bcm/clk-kona.h
@@ -481,7 +481,7 @@ struct ccu_data {
 	bool write_enabled;	/* write access is currently enabled */
 	struct ccu_policy policy;
 	struct device_node *node;
-	struct clk_onecell_data clk_data;
+	size_t clk_num;
 	const char *name;
 	u32 range;		/* byte range of address space */
 	struct kona_clk kona_clks[];	/* must be last */
@@ -491,9 +491,7 @@ struct ccu_data {
 #define KONA_CCU_COMMON(_prefix, _name, _ccuname)			    \
 	.name		= #_name "_ccu",				    \
 	.lock		= __SPIN_LOCK_UNLOCKED(_name ## _ccu_data.lock),    \
-	.clk_data	= {						    \
-		.clk_num = _prefix ## _ ## _ccuname ## _CCU_CLOCK_COUNT,    \
-	}
+	.clk_num	= _prefix ## _ ## _ccuname ## _CCU_CLOCK_COUNT
 
 /* Exported globals */
 
@@ -505,7 +503,6 @@ extern u64 scaled_div_max(struct bcm_clk_div *div);
 extern u64 scaled_div_build(struct bcm_clk_div *div, u32 div_value,
 				u32 billionths);
 
-extern struct clk *kona_clk_setup(struct kona_clk *bcm_clk);
 extern void __init kona_dt_ccu_setup(struct ccu_data *ccu,
 				struct device_node *node);
 extern bool __init kona_ccu_init(struct ccu_data *ccu);
-- 
2.7.4
