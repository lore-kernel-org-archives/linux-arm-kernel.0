From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Thu, 24 Nov 2016 02:25:27 -0800
Subject: [PATCH 1/3] of: Support parsing phandle argument lists through a
 nexus node
In-Reply-To: <20161124102529.20212-1-stephen.boyd@linaro.org>
References: <20161124102529.20212-1-stephen.boyd@linaro.org>
Message-ID: <20161124102529.20212-2-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Platforms like 96boards have a standardized connector/expansion
slot that exposes signals like GPIOs to expansion boards in an
SoC agnostic way. We'd like the DT overlays for the expansion
boards to be written once without knowledge of the SoC on the
other side of the connector. This avoids the unscalable
combinatorial explosion of a different DT overlay for each
expansion board and SoC pair.

We need a way to describe the GPIOs routed through the connector
in an SoC agnostic way. Let's introduce nexus property parsing
into the OF core to do this. This is largely based on the
interrupt nexus support we already have. This allows us to remap
a phandle list in a consumer node (e.g. reset-gpios) through a
connector in a generic way (e.g. via gpio-map). Do this in a
generic routine so that we can remap any sort of variable length
phandle list.

Taking GPIOs as an example, the connector would be a GPIO nexus,
supporting the remapping of a GPIO specifier space to multiple
GPIO providers on the SoC. DT would look as shown below, where
'soc_gpio1' and 'soc_gpio2' are inside the SoC, 'connector' is an
expansion port where boards can be plugged in, and
'expansion_device' is a device on the expansion board.

	soc {
		soc_gpio1: gpio-controller1 {
			#gpio-cells = <2>;
		};

		soc_gpio2: gpio-controller2 {
			#gpio-cells = <2>;
		};
	};

	connector: connector {
		#gpio-cells = <2>;
		gpio-map = <0 GPIO_ACTIVE_LOW &soc_gpio1 1 GPIO_ACTIVE_LOW>,
			   <1 GPIO_ACTIVE_LOW &soc_gpio2 4 GPIO_ACTIVE_LOW>,
			   <2 GPIO_ACTIVE_LOW &soc_gpio1 3 GPIO_ACTIVE_LOW>,
			   <3 GPIO_ACTIVE_LOW &soc_gpio2 2 GPIO_ACTIVE_LOW>;
		gpio-map-mask = <0xf 0x1>;
	};

	expansion_device {
		reset-gpios = <&connector 2 GPIO_ACTIVE_LOW>;
	};

The GPIO core would use of_parse_phandle_with_args_map() instead
of of_parse_phandle_with_args() and arrive at the same type of
result, a phandle and argument list. The difference is that the
phandle and arguments will be remapped through the nexus node to
the underlying SoC GPIO controller node. In the example above,
we would remap 'reset-gpios' from <&connector 2 GPIO_ACTIVE_LOW>
to <&soc_gpio1 3 GPIO_ACTIVE_LOW>.

Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/of/base.c  | 146 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h |  14 +++++
 2 files changed, 160 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index d687e6de24a0..693b73f33675 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1772,6 +1772,152 @@ int of_parse_phandle_with_args(const struct device_node *np, const char *list_na
 EXPORT_SYMBOL(of_parse_phandle_with_args);
 
 /**
+ * of_parse_phandle_with_args_map() - Find a node pointed by phandle in a list and remap it
+ * @np:		pointer to a device tree node containing a list
+ * @list_name:	property name that contains a list
+ * @cells_name:	property name that specifies phandles' arguments count
+ * @index:	index of a phandle to parse out
+ * @out_args:	optional pointer to output arguments structure (will be filled)
+ *
+ * This function is useful to parse lists of phandles and their arguments.
+ * Returns 0 on success and fills out_args, on error returns appropriate
+ * errno value.
+ *
+ * Caller is responsible to call of_node_put() on the returned out_args->np
+ * pointer.
+ *
+ * Example:
+ *
+ * phandle1: node1 {
+ *	#list-cells = <2>;
+ * }
+ *
+ * phandle2: node2 {
+ *	#list-cells = <1>;
+ * }
+ *
+ * phandle3: node3 {
+ * 	#list-cells = <1>;
+ * 	list-map = <0 &phandle2 3>,
+ * 		   <1 &phandle2 2>,
+ * 		   <2 &phandle1 5 1>;
+ *	list-map-mask = <0x3>;
+ * };
+ *
+ * node4 {
+ *	list = <&phandle1 1 2 &phandle3 0>;
+ * }
+ *
+ * To get a device_node of the `node2' node you may call this:
+ * of_parse_phandle_with_args(node4, "list", "#list-cells", "list-map",
+ * 			      "list-map-mask", 1, &args);
+ */
+int of_parse_phandle_with_args_map(const struct device_node *np,
+				   const char *list_name,
+				   const char *cells_name,
+				   const char *map_name,
+				   const char *mask_name,
+				   int index, struct of_phandle_args *out_args)
+{
+	struct device_node *cur, *new = NULL;
+	const __be32 *map, *mask, *tmp;
+	const __be32 dummy_mask[] = { [0 ... MAX_PHANDLE_ARGS] = ~0 };
+	__be32 initial_match_array[MAX_PHANDLE_ARGS];
+	const __be32 *match_array = initial_match_array;
+	int i, ret, map_len, match;
+	u32 list_size, new_size;
+
+	if (index < 0)
+		return -EINVAL;
+
+	ret = __of_parse_phandle_with_args(np, list_name, cells_name, 0, index,
+					   out_args);
+	if (ret)
+		return ret;
+
+	/* Get the #<list>-cells property */
+	cur = out_args->np;
+	ret = of_property_read_u32(cur, cells_name, &list_size);
+	if (ret < 0)
+		goto fail;
+
+	/* Precalculate the match array - this simplifies match loop */
+	for (i = 0; i < list_size; i++)
+		initial_match_array[i] = cpu_to_be32(out_args->args[i]);
+
+	while (cur) {
+		/* Get the <list>-map property */
+		map = of_get_property(cur, map_name, &map_len);
+		if (!map)
+			return 0;
+		map_len /= sizeof(u32);
+
+		/* Get the <list>-map-mask property (optional) */
+		mask = of_get_property(cur, mask_name, NULL);
+		if (!mask)
+			mask = dummy_mask;
+
+		/* Iterate through <list>-map property */
+		match = 0;
+		while (map_len > (list_size + 1) && !match) {
+			/* Compare specifiers */
+			match = 1;
+			for (i = 0; i < list_size; i++, map_len--)
+				match &= !((match_array[i] ^ *map++) & mask[i]);
+
+			of_node_put(new);
+			new = of_find_node_by_phandle(be32_to_cpup(map));
+			map++;
+			map_len--;
+
+			/* Check if not found */
+			if (!new)
+				goto fail;
+
+			if (!of_device_is_available(new))
+				match = 0;
+
+			tmp = of_get_property(new, cells_name, NULL);
+			if (!tmp)
+				goto fail;
+
+			new_size = be32_to_cpu(*tmp);
+
+			/* Check for malformed properties */
+			if (WARN_ON(new_size > MAX_PHANDLE_ARGS))
+				goto fail;
+			if (map_len < new_size)
+				goto fail;
+
+			/* Move forward by new node's #<list>-cells amount */
+			map += new_size;
+			map_len -= new_size;
+		}
+		if (!match)
+			goto fail;
+
+		/*
+		 * Successfully parsed a <list>-map translation; copy new
+		 * specifier into the out_args structure.
+		 */
+		match_array = map - new_size;
+		for (i = 0; i < new_size; i++)
+			out_args->args[i] = be32_to_cpup(map - new_size + i);
+		out_args->args_count = list_size = new_size;
+		/* Iterate again with new provider */
+		out_args->np = new;
+		of_node_put(cur);
+		cur = new;
+	}
+fail:
+	of_node_put(cur);
+	of_node_put(new);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(of_parse_phandle_with_args_map);
+
+/**
  * of_parse_phandle_with_fixed_args() - Find a node pointed by phandle in a list
  * @np:		pointer to a device tree node containing a list
  * @list_name:	property name that contains a list
diff --git a/include/linux/of.h b/include/linux/of.h
index d3a9c2e69001..65ff306403a2 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -344,6 +344,9 @@ extern struct device_node *of_parse_phandle(const struct device_node *np,
 extern int of_parse_phandle_with_args(const struct device_node *np,
 	const char *list_name, const char *cells_name, int index,
 	struct of_phandle_args *out_args);
+extern int of_parse_phandle_with_args_map(const struct device_node *np,
+	const char *list_name, const char *cells_name, const char *map_name,
+	const char *mask_name, int index, struct of_phandle_args *out_args);
 extern int of_parse_phandle_with_fixed_args(const struct device_node *np,
 	const char *list_name, int cells_count, int index,
 	struct of_phandle_args *out_args);
@@ -738,6 +741,17 @@ static inline int of_parse_phandle_with_args(const struct device_node *np,
 	return -ENOSYS;
 }
 
+static inline int of_parse_phandle_with_args_map(const struct device_node *np,
+						 const char *list_name,
+						 const char *cells_name,
+						 const char *map_name,
+						 const char *mask_name,
+						 int index,
+						 struct of_phandle_args *out_args)
+{
+	return -ENOSYS;
+}
+
 static inline int of_parse_phandle_with_fixed_args(const struct device_node *np,
 	const char *list_name, int cells_count, int index,
 	struct of_phandle_args *out_args)
-- 
2.10.0.297.gf6727b0
