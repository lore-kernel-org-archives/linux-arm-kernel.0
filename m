From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri,  7 Jun 2013 13:47:42 -0300
Subject: [PATCH 05/14] bus: mvebu-mbus: Update the mbus-compatible node's
 ranges property
In-Reply-To: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1370623671-7748-6-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ideally 'ranges' entry should be added in device tree source files.
However, since those properties do not inherit the entries from included
files it would be a duplication hell, which means a nightmare to
maintain.

So, instead of hardcoding the required translation entries, we update
them programatically, whenever a decoding window is allocated.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/bus/mvebu-mbus.c | 177 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 160 insertions(+), 17 deletions(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index ac4115a..1779f27 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -53,6 +53,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/mbus.h>
 #include <linux/io.h>
@@ -144,6 +145,7 @@ struct mvebu_mbus_state {
 	struct dentry *debugfs_devs;
 	const struct mvebu_mbus_soc_data *soc;
 	int hw_io_coherency;
+	struct device_node *node;
 };
 
 static struct mvebu_mbus_state mbus_state;
@@ -315,29 +317,155 @@ static int mvebu_mbus_setup_window(struct mvebu_mbus_state *mbus,
 	return 0;
 }
 
+#define WINDOWID(target, attr) ((target << 24) | (attr << 16))
+
+static int mvebu_mbus_update_ranges(u32 base, u32 size, u32 target, u32 attr)
+{
+	int ranges_cells, addr_cells, c_addr_cells, c_size_cells;
+	int ranges_len, ret;
+	const __be32 *prop;
+	void *value;
+	struct property *old, *new;
+	struct device_node *node = mbus_state.node;
+
+	addr_cells = of_n_addr_cells(node);
+	prop = of_get_property(node, "#address-cells", NULL);
+	c_addr_cells = be32_to_cpup(prop);
+	prop = of_get_property(node, "#size-cells", NULL);
+	c_size_cells = be32_to_cpup(prop);
+
+	ranges_cells = c_addr_cells + addr_cells + c_size_cells;
+
+	pr_debug("add translation: base %x, size %x - target %x, attr %x\n",
+		 base, size, target, attr);
+
+	/* DT nodes always have ranges property */
+	old = of_find_property(node, "ranges", &ranges_len);
+	if (!old)
+		return -EINVAL;
+
+	of_node_get(node);
+
+	/* Allocate new property */
+	new = kzalloc(sizeof(struct property), GFP_KERNEL);
+	if (!new) {
+		ret = -ENOMEM;
+		goto out_put_node;
+	}
+
+	new->name = "ranges";
+	value = kzalloc(old->length + (ranges_cells * sizeof(__be32)),
+			GFP_KERNEL);
+	if (!value) {
+		ret = -ENOMEM;
+		goto out_free_prop;
+	}
+
+	new->value = value;
+	new->length = old->length + ranges_cells * sizeof(__be32);
+	if (old->length) {
+		memcpy(value, old->value, old->length);
+		value = value + old->length;
+	}
+
+	/* Sanity check */
+	if (c_addr_cells != 2 && addr_cells > 2) {
+		ret = -EINVAL;
+		goto out_free_value;
+	}
+
+	/*
+	 * The new ranges entry will look like this:
+	 * <windowid child_base {0} base size>
+	 *
+	 * The extra zeroed-cell is needed if the addressing
+	 * is 64-bit wide.
+	 */
+
+	if (addr_cells > 1) {
+		struct {
+			__be32 windowid;
+			__be32 child_base;
+			__be32 base_high;
+			__be32 base_low;
+			__be32 size;
+		} *r = value;
+
+		r->windowid   = cpu_to_be32(WINDOWID(target, attr));
+		r->child_base = cpu_to_be32(base);
+		r->base_high  = cpu_to_be32(0);
+		r->base_low   = cpu_to_be32(base);
+		r->size       = cpu_to_be32(size);
+	} else {
+		struct {
+			__be32 windowid;
+			__be32 child_base;
+			__be32 base;
+			__be32 size;
+		} *r = value;
+
+		r->windowid   = cpu_to_be32(WINDOWID(target, attr));
+		r->child_base = cpu_to_be32(base);
+		r->base       = cpu_to_be32(base);
+		r->size       = cpu_to_be32(size);
+	}
+
+	ret = of_update_property(node, new);
+	if (ret < 0)
+		goto out_free_value;
+
+	of_node_put(node);
+	return 0;
+
+out_free_value:
+	kfree(new->value);
+out_free_prop:
+	kfree(new);
+out_put_node:
+	of_node_put(node);
+	return ret;
+}
+
 static int mvebu_mbus_alloc_window(struct mvebu_mbus_state *mbus,
 				   phys_addr_t base, size_t size,
 				   phys_addr_t remap, u8 target,
 				   u8 attr)
 {
-	int win;
+	int win, ret = -ENOMEM;
+	bool found = false;
 
 	if (remap == MVEBU_MBUS_NO_REMAP) {
 		for (win = mbus->soc->num_remappable_wins;
 		     win < mbus->soc->num_wins; win++)
-			if (mvebu_mbus_window_is_free(mbus, win))
-				return mvebu_mbus_setup_window(mbus, win, base,
-							       size, remap,
-							       target, attr);
+			if (mvebu_mbus_window_is_free(mbus, win)) {
+				found = true;
+				break;
+			}
 	}
 
+	/*
+	 * Either what we need is a remappable window, or a
+	 * non-remappable window but no such window is available so we
+	 * fallback to using a remappable window.
+	 */
+	if (!found) {
+		for (win = 0; win < mbus->soc->num_wins; win++) {
+			if (mvebu_mbus_window_is_free(mbus, win)) {
+				found = true;
+				break;
+			}
+		}
+	}
 
-	for (win = 0; win < mbus->soc->num_wins; win++)
-		if (mvebu_mbus_window_is_free(mbus, win))
-			return mvebu_mbus_setup_window(mbus, win, base, size,
-						       remap, target, attr);
+	/* No window found */
+	if (!found)
+		return -ENOMEM;
 
-	return -ENOMEM;
+	ret = mvebu_mbus_setup_window(mbus, win, base, size, remap,
+				      target, attr);
+	if (ret < 0)
+		return ret;
+	return mvebu_mbus_update_ranges(base, size, target, attr);
 }
 
 /*
@@ -902,11 +1030,26 @@ static int __init mbus_dt_setup_win(struct mvebu_mbus_state *mbus,
 	const char *name;
 	int i;
 
-	/* Special case for the identity mapping */
-	if (target == 0xff && attr == 0xff)
+	/*
+	 * The identity mapping needs a translation entry@the
+	 * mbus node level. The entry makes this translation:
+	 *   {target/attr base} -> {base}
+	 *
+	 * In other words, it maps the fictitious address space
+	 * that contains a field to encode the target/attribute tuple,
+	 * into the 'true' MBus address space.
+	 */
+	if (target == 0xff && attr == 0xff) {
+		mvebu_mbus_update_ranges(base, size, target, attr);
 		return 0;
+	}
 
-	/* Special case for the internal registers */
+	/*
+	 * Special case for the internal registers:
+	 * There's nothing to do in this case, since
+	 * the internal-regs base address is specified in the
+	 * DT by means of an address translation entry.
+	 */
 	if (target == 0x00 && attr == 0x00)
 		return 0;
 
@@ -938,8 +1081,7 @@ static int __init mbus_dt_setup_win(struct mvebu_mbus_state *mbus,
 	return 0;
 }
 
-static int __init mbus_dt_setup(struct mvebu_mbus_state *mbus,
-				struct device_node *np)
+static int __init mbus_dt_setup(struct mvebu_mbus_state *mbus)
 {
 	struct device_node *child;
 	int ranges_len, tuple_len;
@@ -947,7 +1089,7 @@ static int __init mbus_dt_setup(struct mvebu_mbus_state *mbus,
 	int cell_count;
 	const __be32 *r, *ranges_start, *ranges_end, *prop;
 
-	for_each_available_child_of_node(np, child) {
+	for_each_available_child_of_node(mbus_state.node, child) {
 
 		addr_cells = of_n_addr_cells(child);
 
@@ -1004,6 +1146,7 @@ int __init mvebu_mbus_dt_init(void)
 
 	of_id = of_match_node(of_mvebu_mbus_ids, np);
 	mbus_state.soc = of_id->data;
+	mbus_state.node = np;
 
 	if (of_address_to_resource(np, 0, &mbuswins_res)) {
 		pr_err("cannot get MBUS register address\n");
@@ -1024,6 +1167,6 @@ int __init mvebu_mbus_dt_init(void)
 		return ret;
 
 	/* Setup statically declared windows in the DT */
-	return mbus_dt_setup(&mbus_state, np);
+	return mbus_dt_setup(&mbus_state);
 }
 #endif
-- 
1.8.1.5
