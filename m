From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Tue, 19 Jan 2016 14:51:33 +0000
Subject: [RFC 2/9] clk: bcm2835: add support for parent selection in DT
In-Reply-To: <1453215100-2382-1-git-send-email-kernel@martin.sperl.org>
References: <1453215100-2382-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1453215100-2382-3-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Allow for a per clock custom selection of clocks in the device tree.

Basic setup in dt looks like this:
  clock at BCM2835_CLOCK_PCM {
    reg = <BCM2835_CLOCK_PCM>;
    parent-clock-names = "xosc", "plld_per", "plla_per", "pll_aux_per";
  };

Special care had to be taken when only a single clock is assigned,
as then set_parent_rate is not called - so the register has to get
set up immediately.

To allow for custom order of the clocks (giving preference)
an additional mapping between IDs is required when handling
get/set parent.

The default parent clocks are assumed to be all available clocks
against which the "selected" parents are checked.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c |  124 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 119 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 1c714d0..8fccbd3 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -702,6 +702,7 @@ struct bcm2835_clock_data {
 
 	const char *const *parents;
 	int num_mux_parents;
+	u8 *parents_idx;
 
 	u32 ctl_reg;
 	u32 div_reg;
@@ -1706,15 +1707,30 @@ static int bcm2835_clock_determine_rate(struct clk_hw *hw,
 	return 0;
 }
 
+static int _bcm2835_clk_set_parent(struct bcm2835_cprman *cprman,
+				   const struct bcm2835_clock_data *data,
+				   u8 index)
+{
+	u8 src;
+
+	/* map the index if we got a map */
+	if (data->parents_idx)
+		index = data->parents_idx[index];
+
+	/* calc the source */
+	src = (index << CM_SRC_SHIFT) & CM_SRC_MASK;
+
+	cprman_write(cprman, data->ctl_reg, src);
+	return 0;
+}
+
 static int bcm2835_clock_set_parent(struct clk_hw *hw, u8 index)
 {
 	struct bcm2835_clock *clock = bcm2835_clock_from_hw(hw);
 	struct bcm2835_cprman *cprman = clock->cprman;
 	const struct bcm2835_clock_data *data = clock->data;
-	u8 src = (index << CM_SRC_SHIFT) & CM_SRC_MASK;
 
-	cprman_write(cprman, data->ctl_reg, src);
-	return 0;
+	return _bcm2835_clk_set_parent(cprman, data, index);
 }
 
 static u8 bcm2835_clock_get_parent(struct clk_hw *hw)
@@ -1723,10 +1739,23 @@ static u8 bcm2835_clock_get_parent(struct clk_hw *hw)
 	struct bcm2835_cprman *cprman = clock->cprman;
 	const struct bcm2835_clock_data *data = clock->data;
 	u32 src = cprman_read(cprman, data->ctl_reg);
+	int i;
 
-	return (src & CM_SRC_MASK) >> CM_SRC_SHIFT;
-}
+	/* translate src to default index */
+	src = (src & CM_SRC_MASK) >> CM_SRC_SHIFT;
+
+	/* without overrides overrides return the value */
+	if (!data->parents_idx)
+		return src;
 
+	/* otherwise iterate over fields to find it */
+	for (i = 0; i < data->num_mux_parents ; i++)
+		if (data->parents_idx[i] == src)
+			return i;
+
+	/* if not found */
+	return -EINVAL;
+}
 
 static const struct clk_ops bcm2835_clock_clk_ops = {
 	.is_prepared = bcm2835_clock_is_on,
@@ -1874,6 +1903,88 @@ bcm2835_register_pll_divider(struct bcm2835_cprman *cprman,
 	return clk;
 }
 
+static void bcm2835_register_clock_of_parents(
+	struct bcm2835_cprman *cprman,
+	struct bcm2835_clock_data *data,
+	struct device_node *nc)
+{
+	struct device *dev = cprman->dev;
+	u8 *parents_idx;
+	const char **parents;
+	const char *name;
+	int err, names, i, j;
+
+	/* check number of strings */
+	names = of_property_count_strings(nc, "parent-clock-names");
+	if (names < 0)
+		return;
+	if (names > data->num_mux_parents) {
+		dev_err(dev,
+			"%s: dt-property parent-clock-names has more entries (%d) than available parent clocks (%d)\n",
+			of_node_full_name(nc), names, data->num_mux_parents);
+		return;
+	}
+
+	/* allocate parents */
+	parents = devm_kzalloc(dev, sizeof(*parents) * names, GFP_KERNEL);
+	if (!parents)
+		return;
+
+	/* allocate parents index */
+	parents_idx = devm_kzalloc(dev, sizeof(*parents_idx) * names,
+				   GFP_KERNEL);
+	if (!parents_idx) {
+		devm_kfree(dev, parents);
+		return;
+	}
+
+	/* and check the parents against list of allowed parents */
+	for (i = 0; i < names; i++) {
+		/* get the string */
+		err = of_property_read_string_index(nc, "parent-clock-names",
+						    i, &name);
+		if (err) {
+			devm_kfree(dev, parents_idx);
+			devm_kfree(dev, parents);
+			dev_err(dev,
+				"%s: could not get parent-clock-names[%d] - %d\n",
+				of_node_full_name(nc), i, err);
+			return;
+		}
+		/* check against available parents - the default list */
+		for (j = 0; j < data->num_mux_parents; j++) {
+			if (strcmp(data->parents[j],  name) == 0) {
+				parents[i] = data->parents[j];
+				parents_idx[i] = j;
+				break;
+			}
+		}
+		/* if there was no match */
+		if (!parents[i]) {
+			devm_kfree(dev, parents_idx);
+			devm_kfree(dev, parents);
+			dev_err(dev,
+				"%s: could not find %s in list of allowed parent clocks\n",
+				of_node_full_name(nc), name);
+			return;
+		}
+	}
+
+	/* finally assign it */
+	data->num_mux_parents = names;
+	data->parents = parents;
+	data->parents_idx = parents_idx;
+
+	/*
+	 * if there is only one parent, then use that one immediately,
+	 * as with only one parent clock_set_parent does not get called
+	 * and it is assumed that everything is set up, so
+	 * we need to do that before anything else...
+	 */
+	if (names == 1)
+		_bcm2835_clk_set_parent(cprman, data, 0);
+}
+
 static const struct bcm2835_clock_data *bcm2835_register_clock_of(
 	struct bcm2835_cprman *cprman,
 	const struct bcm2835_clock_data *data_orig,
@@ -1894,6 +2005,9 @@ static const struct bcm2835_clock_data *bcm2835_register_clock_of(
 		return data_orig;
 	memcpy(data, data_orig, sizeof(*data));
 
+	/* apply overrides */
+	bcm2835_register_clock_of_parents(cprman, data, nc);
+
 	/* and return the result */
 	return data;
 }
-- 
1.7.10.4
