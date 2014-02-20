From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 20 Feb 2014 19:06:50 +0100
Subject: [PATCH RFC 4/5] Add sample C-based generic bindings
In-Reply-To: <1392919611-10746-1-git-send-email-t.figa@samsung.com>
References: <1392919611-10746-1-git-send-email-t.figa@samsung.com>
Message-ID: <1392919611-10746-5-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 Makefile.dtc                              |   7 +-
 schemas/clock/clock.c                     |  77 +++++
 schemas/gpio/gpio.c                       |  93 ++++++
 schemas/i2c/i2c.c                         |  42 +++
 schemas/interrupt-controller/interrupts.c | 452 ++++++++++++++++++++++++++++++
 schemas/mmio-bus.c                        |  97 +++++++
 6 files changed, 767 insertions(+), 1 deletion(-)
 create mode 100644 schemas/clock/clock.c
 create mode 100644 schemas/gpio/gpio.c
 create mode 100644 schemas/i2c/i2c.c
 create mode 100644 schemas/interrupt-controller/interrupts.c
 create mode 100644 schemas/mmio-bus.c

diff --git a/Makefile.dtc b/Makefile.dtc
index bf19564..b75da69 100644
--- a/Makefile.dtc
+++ b/Makefile.dtc
@@ -13,7 +13,12 @@ DTC_SRCS = \
 	srcpos.c \
 	treesource.c \
 	util.c \
-	schemas/schema.c
+	schemas/mmio-bus.c \
+	schemas/schema.c \
+	schemas/clock/clock.c \
+	schemas/gpio/gpio.c \
+	schemas/i2c/i2c.c \
+	schemas/interrupt-controller/interrupts.c \
 
 DTC_GEN_SRCS = dtc-lexer.lex.c dtc-parser.tab.c dtss-lexer.lex.c dtss-parser.tab.c
 DTC_OBJS = $(DTC_SRCS:%.c=%.o) $(DTC_GEN_SRCS:%.c=%.o)
diff --git a/schemas/clock/clock.c b/schemas/clock/clock.c
new file mode 100644
index 0000000..d22b759
--- /dev/null
+++ b/schemas/clock/clock.c
@@ -0,0 +1,77 @@
+#include "dtc.h"
+#include "schema.h"
+
+static void clocks_check_names(struct node *root, struct node *node,
+			       struct property *names, bool optional)
+{
+	const char *name = NULL;
+	struct property *clocks, *clock_names;
+
+	clocks = require_property(node, "clocks");
+	clock_names = require_property(node, "clock-names");
+
+	if (!clocks || !clock_names)
+		return;
+
+	for_each_propval_string(names, name) {
+		struct of_phandle_args args;
+		int ret;
+
+		ret = propval_match_string(clock_names, name);
+		if (ret < 0) {
+			if (optional)
+				continue;
+
+			pr_err("clock '%s' not specified in node '%s'\n",
+				name, node->fullpath);
+			continue;
+		}
+
+		ret = propval_parse_phandle_with_args(root, clocks,
+							"#clock-cells", ret,
+							&args);
+		if (ret < 0)
+			pr_err("failed to parse specifier of clock '%s' in node '%s'\n",
+				name, node->fullpath);
+	}
+}
+
+static void clocks_check_count(struct node *root, struct node *node,
+			       struct property *count_prop)
+{
+	struct property *clocks;
+	cell_t count = propval_cell(count_prop);
+	int ret;
+
+	clocks = require_property(node, "clocks");
+	if (!clocks)
+		return;
+
+	ret = propval_count_phandle_with_args(root, clocks, "#clock-cells");
+	if (ret < 0)
+		pr_err("failed to parse clocks property\n");
+	else if (ret < count)
+		pr_err("not enough clock specifiers (expected %u, got %d)\n",
+			count, ret);
+}
+
+static void generic_checkfn_clocks(const struct generic_schema *schema,
+				   struct node *root, struct node *node,
+				   struct node *params, bool required)
+{
+	struct property *prop;
+
+	if (!params) {
+		pr_err("schema clocks requires arguments\n");
+		return;
+	}
+
+	prop = get_property(params, "names");
+	if (prop)
+		clocks_check_names(root, node, prop, !required);
+
+	prop = get_property(params, "count");
+	if (prop)
+		clocks_check_count(root, node, prop);
+}
+GENERIC_SCHEMA("clocks", clocks);
diff --git a/schemas/gpio/gpio.c b/schemas/gpio/gpio.c
new file mode 100644
index 0000000..9100c95
--- /dev/null
+++ b/schemas/gpio/gpio.c
@@ -0,0 +1,93 @@
+#include "schema.h"
+
+static void check_gpios_named(const struct generic_schema *schema,
+			      struct node *root, struct node *node,
+			      struct node *params, bool required,
+			      const char *prop_name)
+{
+	struct property *prop;
+	cell_t count;
+	int ret;
+	int i;
+
+	ret = schema_get_param_cell(params, "count", &count);
+	if (ret < 0) {
+		schema_err(schema, "missing schema argument: 'count'\n");
+		return;
+	}
+
+	if (required)
+		prop = require_property(node, prop_name);
+	else
+		prop = get_property(node, prop_name);
+	if (!prop)
+		return;
+
+	for (i = 0; i < count; ++i) {
+		struct of_phandle_args args;
+
+		ret = propval_parse_phandle_with_args(root, prop,
+						"#gpio-cells", i, &args);
+		if (ret < 0)
+			pr_err("failed to parse gpio specifier %d in '%s' property of node '%s'\n",
+				i, prop_name, node->fullpath);
+	}
+}
+
+static void generic_checkfn_gpios(const struct generic_schema *schema,
+				  struct node *root, struct node *node,
+				  struct node *params, bool required)
+{
+	check_gpios_named(schema, root, node, params, required, "gpios");
+}
+GENERIC_SCHEMA("gpios", gpios);
+
+static void generic_checkfn_named_gpios(const struct generic_schema *schema,
+					struct node *root, struct node *node,
+					struct node *params, bool required)
+{
+	struct property *prop;
+	const char *name;
+
+	prop = schema_get_param(params, "name");
+	if (!prop) {
+		schema_err(schema, "missing schema argument: 'name'\n");
+		return;
+	}
+
+	name = propval_next_string(prop, NULL);
+
+	check_gpios_named(schema, root, node, params, required, name);
+}
+GENERIC_SCHEMA("named-gpios", named_gpios);
+
+static void generic_checkfn_gpio_provider(const struct generic_schema *schema,
+					  struct node *root, struct node *node,
+					  struct node *params, bool required)
+{
+	struct property *prop;
+	cell_t cells, val;
+	int ret;
+
+	ret = schema_get_param_cell(params, "cells", &cells);
+	if (ret < 0) {
+		schema_err(schema, "missing schema argument: 'cells'\n");
+		return;
+	}
+
+	prop = require_property(node, "gpio-controller");
+	if (!prop)
+		return;
+
+	prop = require_property(node, "#gpio-cells");
+	if (!prop)
+		return;
+
+	val = propval_cell(prop);
+	if (val != cells) {
+		pr_err("wrong value of #interrupt-cells property in node '%s' (expected %u, got %u)\n",
+			node->fullpath, cells, val);
+		return;
+	}
+}
+GENERIC_SCHEMA("gpio-provider", gpio_provider);
diff --git a/schemas/i2c/i2c.c b/schemas/i2c/i2c.c
new file mode 100644
index 0000000..ba8fd34
--- /dev/null
+++ b/schemas/i2c/i2c.c
@@ -0,0 +1,42 @@
+#include "schema.h"
+
+static void generic_checkfn_i2c_device(const struct generic_schema *schema,
+				       struct node *root, struct node *node,
+				       struct node *params, bool required)
+{
+	struct property *prop;
+	prop = require_property(node, "reg");
+	if (!prop)
+		return;
+
+	if (prop->val.len != sizeof(cell_t))
+		node_err(node, "i2c-bus expects reg property to be a single cell\n");
+
+	/* TODO: Check if parent device is an i2c bus. */
+}
+GENERIC_SCHEMA("i2c-device", i2c_device);
+
+static void generic_checkfn_i2c_bus(const struct generic_schema *schema,
+				    struct node *root, struct node *node,
+				    struct node *params, bool required)
+{
+	struct property *prop;
+	cell_t val;
+
+	prop = require_property(node, "#address-cells");
+	if (!prop)
+		return;
+
+	val = propval_cell(prop);
+	if (val != 1)
+		node_err(node, "i2c-bus requires #address-cells == 1\n");
+
+	prop = require_property(node, "#size-cells");
+	if (!prop)
+		return;
+
+	val = propval_cell(prop);
+	if (val != 0)
+		node_err(node, "i2c-bus requires #size-cells == 0\n");
+}
+GENERIC_SCHEMA("i2c-bus", i2c_bus);
diff --git a/schemas/interrupt-controller/interrupts.c b/schemas/interrupt-controller/interrupts.c
new file mode 100644
index 0000000..7eda441
--- /dev/null
+++ b/schemas/interrupt-controller/interrupts.c
@@ -0,0 +1,452 @@
+#include "schema.h"
+
+/*******************************************************************************
+ * Copypasta from kernel's drivers/of/irq.c starts here.
+ * (Well, maybe with some minor changes to make it compile here.)
+ ******************************************************************************/
+
+/* Adaptation glue... */
+
+#define pr_debug(...)
+typedef cell_t __be32;
+typedef cell_t phandle;
+#define of_node_get(node)	(node)
+#define of_node_put(node)
+#define of_irq_workarounds	(0)
+#define OF_IMAP_OLDWORLD_MAC	0x00000001
+#define OF_IMAP_NO_PHANDLE	0x00000002
+#define of_irq_dflt_pic		(NULL)
+#define be32_to_cpu(val)	fdt32_to_cpu((val))
+#define be32_to_cpup(ptr)	be32_to_cpu(*(ptr))
+#define cpu_to_be32(val)	cpu_to_fdt32(val)
+#define raw_spin_lock_irqsave(...)
+#define raw_spin_unlock_irqrestore(...)
+typedef uint32_t u32;
+#define WARN_ON(x)		(x)
+#define of_irq_parse_oldworld(...)	(-EINVAL)
+#define of_node_full_name(x)	((x)->fullpath)
+
+static const cell_t dummy = 0;
+
+static const void *of_get_property(struct node *np, const char *name,
+				     int *lenp)
+{
+	struct property *prop;
+
+	prop = get_property(np, name);
+	if(!prop)
+		return NULL;
+
+	if (lenp)
+		*lenp = prop->val.len;
+
+	if (!prop->val.val)
+		return &dummy;
+
+	return prop->val.val;
+}
+
+static struct node *of_get_parent(const struct node *node)
+{
+	return node ? node->parent : NULL;
+}
+
+static int of_device_is_available(struct node *device)
+{
+	const char *status;
+	int statlen;
+
+	if (!device)
+		return 0;
+
+	status = of_get_property(device, "status", &statlen);
+	if (status == NULL)
+		return 1;
+
+	if (statlen > 0) {
+		if (!strcmp(status, "okay") || !strcmp(status, "ok"))
+			return 1;
+	}
+
+	return 0;
+}
+
+/* End of adaptation glue. */
+
+/**
+ * of_irq_find_parent - Given a device node, find its interrupt parent node
+ * @child: pointer to device node
+ *
+ * Returns a pointer to the interrupt parent node, or NULL if the interrupt
+ * parent could not be determined.
+ */
+static struct node *of_irq_find_parent(struct node *root, struct node *child)
+{
+	struct node *p;
+	const __be32 *parp;
+
+	if (!of_node_get(child))
+		return NULL;
+
+	do {
+		parp = of_get_property(child, "interrupt-parent", NULL);
+		if (parp == NULL)
+			p = of_get_parent(child);
+		else {
+			if (of_irq_workarounds & OF_IMAP_NO_PHANDLE)
+				p = of_node_get(of_irq_dflt_pic);
+			else
+				p = get_node_by_phandle(root,
+							be32_to_cpup(parp));
+		}
+		of_node_put(child);
+		child = p;
+	} while (p && of_get_property(p, "#interrupt-cells", NULL) == NULL);
+
+	return p;
+}
+
+/**
+ * of_irq_parse_raw - Low level interrupt tree parsing
+ * @parent:	the device interrupt parent
+ * @addr:	address specifier (start of "reg" property of the device) in be32 format
+ * @out_irq:	structure of_irq updated by this function
+ *
+ * Returns 0 on success and a negative number on error
+ *
+ * This function is a low-level interrupt tree walking function. It
+ * can be used to do a partial walk with synthetized reg and interrupts
+ * properties, for example when resolving PCI interrupts when no device
+ * node exist for the parent. It takes an interrupt specifier structure as
+ * input, walks the tree looking for any interrupt-map properties, translates
+ * the specifier for each map, and then returns the translated map.
+ */
+static int of_irq_parse_raw(struct node *root,
+			    const __be32 *addr, struct of_phandle_args *out_irq)
+{
+	struct node *ipar, *tnode, *old = NULL, *newpar = NULL;
+	__be32 initial_match_array[MAX_PHANDLE_ARGS];
+	const __be32 *match_array = initial_match_array;
+	const __be32 *tmp, *imap, *imask, dummy_imask[] = { [0 ... MAX_PHANDLE_ARGS] = ~0 };
+	u32 intsize = 1, addrsize, newintsize = 0, newaddrsize = 0;
+	int imaplen, match, i;
+
+#ifdef DEBUG
+	of_print_phandle_args("of_irq_parse_raw: ", out_irq);
+#endif
+
+	ipar = of_node_get(out_irq->np);
+
+	/* First get the #interrupt-cells property of the current cursor
+	 * that tells us how to interpret the passed-in intspec. If there
+	 * is none, we are nice and just walk up the tree
+	 */
+	do {
+		tmp = of_get_property(ipar, "#interrupt-cells", NULL);
+		if (tmp != NULL) {
+			intsize = be32_to_cpu(*tmp);
+			break;
+		}
+		tnode = ipar;
+		ipar = of_irq_find_parent(root, ipar);
+		of_node_put(tnode);
+	} while (ipar);
+	if (ipar == NULL) {
+		pr_debug(" -> no parent found !\n");
+		goto fail;
+	}
+
+	pr_debug("of_irq_parse_raw: ipar=%s, size=%d\n", of_node_full_name(ipar), intsize);
+
+	if (out_irq->args_count != intsize)
+		return -EINVAL;
+
+	/* Look for this #address-cells. We have to implement the old linux
+	 * trick of looking for the parent here as some device-trees rely on it
+	 */
+	old = of_node_get(ipar);
+	do {
+		tmp = of_get_property(old, "#address-cells", NULL);
+		tnode = of_get_parent(old);
+		of_node_put(old);
+		old = tnode;
+	} while (old && tmp == NULL);
+	of_node_put(old);
+	old = NULL;
+	addrsize = (tmp == NULL) ? 2 : be32_to_cpu(*tmp);
+
+	pr_debug(" -> addrsize=%d\n", addrsize);
+
+	/* Range check so that the temporary buffer doesn't overflow */
+	if (WARN_ON(addrsize + intsize > MAX_PHANDLE_ARGS))
+		goto fail;
+
+	/* Precalculate the match array - this simplifies match loop */
+	for (i = 0; i < addrsize; i++)
+		initial_match_array[i] = addr ? addr[i] : 0;
+	for (i = 0; i < intsize; i++)
+		initial_match_array[addrsize + i] = cpu_to_be32(out_irq->args[i]);
+
+	/* Now start the actual "proper" walk of the interrupt tree */
+	while (ipar != NULL) {
+		/* Now check if cursor is an interrupt-controller and if it is
+		 * then we are done
+		 */
+		if (of_get_property(ipar, "interrupt-controller", NULL) !=
+				NULL) {
+			pr_debug(" -> got it !\n");
+			return 0;
+		}
+
+		/*
+		 * interrupt-map parsing does not work without a reg
+		 * property when #address-cells != 0
+		 */
+		if (addrsize && !addr) {
+			pr_debug(" -> no reg passed in when needed !\n");
+			goto fail;
+		}
+
+		/* Now look for an interrupt-map */
+		imap = of_get_property(ipar, "interrupt-map", &imaplen);
+		/* No interrupt map, check for an interrupt parent */
+		if (imap == NULL) {
+			pr_debug(" -> no map, getting parent\n");
+			newpar = of_irq_find_parent(root, ipar);
+			goto skiplevel;
+		}
+		imaplen /= sizeof(u32);
+
+		/* Look for a mask */
+		imask = of_get_property(ipar, "interrupt-map-mask", NULL);
+		if (!imask)
+			imask = dummy_imask;
+
+		/* Parse interrupt-map */
+		match = 0;
+		while (imaplen > (addrsize + intsize + 1) && !match) {
+			/* Compare specifiers */
+			match = 1;
+			for (i = 0; i < (addrsize + intsize); i++, imaplen--)
+				match &= !((match_array[i] ^ *imap++) & imask[i]);
+
+			pr_debug(" -> match=%d (imaplen=%d)\n", match, imaplen);
+
+			/* Get the interrupt parent */
+			if (of_irq_workarounds & OF_IMAP_NO_PHANDLE)
+				newpar = of_node_get(of_irq_dflt_pic);
+			else
+				newpar = get_node_by_phandle(root,
+							be32_to_cpup(imap));
+			imap++;
+			--imaplen;
+
+			/* Check if not found */
+			if (newpar == NULL) {
+				pr_debug(" -> imap parent not found !\n");
+				goto fail;
+			}
+
+			if (!of_device_is_available(newpar))
+				match = 0;
+
+			/* Get #interrupt-cells and #address-cells of new
+			 * parent
+			 */
+			tmp = of_get_property(newpar, "#interrupt-cells", NULL);
+			if (tmp == NULL) {
+				pr_debug(" -> parent lacks #interrupt-cells!\n");
+				goto fail;
+			}
+			newintsize = be32_to_cpu(*tmp);
+			tmp = of_get_property(newpar, "#address-cells", NULL);
+			newaddrsize = (tmp == NULL) ? 0 : be32_to_cpu(*tmp);
+
+			pr_debug(" -> newintsize=%d, newaddrsize=%d\n",
+			    newintsize, newaddrsize);
+
+			/* Check for malformed properties */
+			if (WARN_ON(newaddrsize + newintsize > MAX_PHANDLE_ARGS))
+				goto fail;
+			if (imaplen < (newaddrsize + newintsize))
+				goto fail;
+
+			imap += newaddrsize + newintsize;
+			imaplen -= newaddrsize + newintsize;
+
+			pr_debug(" -> imaplen=%d\n", imaplen);
+		}
+		if (!match)
+			goto fail;
+
+		/*
+		 * Successfully parsed an interrrupt-map translation; copy new
+		 * interrupt specifier into the out_irq structure
+		 */
+		out_irq->np = newpar;
+
+		match_array = imap - newaddrsize - newintsize;
+		for (i = 0; i < newintsize; i++)
+			out_irq->args[i] = be32_to_cpup(imap - newintsize + i);
+		out_irq->args_count = intsize = newintsize;
+		addrsize = newaddrsize;
+
+	skiplevel:
+		/* Iterate again with new parent */
+		pr_debug(" -> new parent: %s\n", of_node_full_name(newpar));
+		of_node_put(ipar);
+		ipar = newpar;
+		newpar = NULL;
+	}
+ fail:
+	of_node_put(ipar);
+	of_node_put(newpar);
+
+	return -EINVAL;
+}
+
+/**
+ * of_irq_parse_one - Resolve an interrupt for a device
+ * @device: the device whose interrupt is to be resolved
+ * @index: index of the interrupt to resolve
+ * @out_irq: structure of_irq filled by this function
+ *
+ * This function resolves an interrupt for a node by walking the interrupt tree,
+ * finding which interrupt controller node it is attached to, and returning the
+ * interrupt specifier that can be used to retrieve a Linux IRQ number.
+ */
+static int of_irq_parse_one(struct node *root, struct node *device,
+			    int index, struct of_phandle_args *out_irq)
+{
+	struct node *p;
+	const __be32 *intspec, *tmp, *addr;
+	u32 intsize, intlen;
+	int i, res = -EINVAL;
+
+	pr_debug("of_irq_parse_one: dev=%s, index=%d\n", of_node_full_name(device), index);
+
+	/* OldWorld mac stuff is "special", handle out of line */
+	if (of_irq_workarounds & OF_IMAP_OLDWORLD_MAC)
+		return of_irq_parse_oldworld(device, index, out_irq);
+
+	/* Get the reg property (if any) */
+	addr = of_get_property(device, "reg", NULL);
+
+	/* Get the interrupts property */
+	intspec = of_get_property(device, "interrupts", (int *)&intlen);
+	if (intspec == NULL) {
+		struct property *prop;
+
+		prop = get_property(device, "interrupts-extended");
+		if (!prop)
+			return -EINVAL;
+
+		/* Try the new-style interrupts-extended */
+		res = propval_parse_phandle_with_args(root, prop,
+							"#interrupt-cells",
+							index, out_irq);
+		if (res)
+			return -EINVAL;
+		return of_irq_parse_raw(root, addr, out_irq);
+	}
+	intlen /= sizeof(*intspec);
+
+	pr_debug(" intspec=%d intlen=%d\n", be32_to_cpup(intspec), intlen);
+
+	/* Look for the interrupt parent. */
+	p = of_irq_find_parent(root, device);
+	if (p == NULL)
+		return -EINVAL;
+
+	/* Get size of interrupt specifier */
+	tmp = of_get_property(p, "#interrupt-cells", NULL);
+	if (tmp == NULL)
+		goto out;
+	intsize = be32_to_cpu(*tmp);
+
+	pr_debug(" intsize=%d intlen=%d\n", intsize, intlen);
+
+	/* Check index */
+	if ((index + 1) * intsize > intlen)
+		goto out;
+
+	/* Copy intspec into irq structure */
+	intspec += index * intsize;
+	out_irq->np = p;
+	out_irq->args_count = intsize;
+	for (i = 0; i < intsize; i++)
+		out_irq->args[i] = be32_to_cpup(intspec++);
+
+	/* Check if there are any interrupt-map translations to process */
+	res = of_irq_parse_raw(root, addr, out_irq);
+ out:
+	of_node_put(p);
+	return res;
+}
+
+/*******************************************************************************
+ * Copypasta ends here.
+ ******************************************************************************/
+
+static void generic_checkfn_interrupts(const struct generic_schema *schema,
+				       struct node *root, struct node *node,
+				       struct node *params, bool required)
+{
+	struct of_phandle_args irq;
+	cell_t count;
+	int ret;
+	int i;
+
+	ret = schema_get_param_cell(params, "count", &count);
+	if (ret < 0) {
+		schema_err(schema, "missing schema argument: 'count'\n");
+		return;
+	}
+
+	if (!required
+	    && !get_property(node, "interrupts")
+	    && !get_property(node, "interrupts-extended"))
+		return;
+
+	for (i = 0; i < count; ++i) {
+		ret = of_irq_parse_one(root, node, i, &irq);
+		if (ret < 0)
+			pr_err("failed to parse interrupt entry %d of node '%s'\n",
+				i, node->fullpath);
+	}
+}
+GENERIC_SCHEMA("interrupts", interrupts);
+
+static void generic_checkfn_interrupt_controller(
+					const struct generic_schema *schema,
+					struct node *root,
+					struct node *node,
+					struct node *params,
+					bool required)
+{
+	struct property *prop;
+	cell_t cells, val;
+	int ret;
+
+	ret = schema_get_param_cell(params, "cells", &cells);
+	if (ret < 0) {
+		schema_err(schema, "missing schema argument: 'cells'\n");
+		return;
+	}
+
+	prop = require_property(node, "interrupt-controller");
+	if (!prop)
+		return;
+
+	prop = require_property(node, "#interrupt-cells");
+	if (!prop)
+		return;
+
+	val = propval_cell(prop);
+	if (val != cells) {
+		pr_err("wrong value of #interrupt-cells property in node '%s' (expected %u, got %u)\n",
+			node->fullpath, cells, val);
+		return;
+	}
+}
+GENERIC_SCHEMA("interrupt-controller", interrupt_controller);
diff --git a/schemas/mmio-bus.c b/schemas/mmio-bus.c
new file mode 100644
index 0000000..bd7888d
--- /dev/null
+++ b/schemas/mmio-bus.c
@@ -0,0 +1,97 @@
+#include "schema.h"
+
+static unsigned int get_address_cells(struct node *node)
+{
+	struct property *prop;
+
+	prop = get_property(node->parent, "#address-cells");
+	if (!prop) {
+		pr_warn("missing #address-cells property, assuming 2\n");
+		return 2;
+	}
+
+	return propval_cell(prop);
+}
+
+static unsigned int get_size_cells(struct node *node)
+{
+	struct property *prop;
+
+	prop = get_property(node->parent, "#size-cells");
+	if (!prop) {
+		pr_warn("missing #size-cells property, assuming 1\n");
+		return 1;
+	}
+
+	return propval_cell(prop);
+}
+
+static void generic_checkfn_mmio_device(const struct generic_schema *schema,
+					struct node *root, struct node *node,
+					struct node *params, bool required)
+{
+	struct property *prop;
+	cell_t count;
+	unsigned int address_cells, size_cells;
+
+	if (!params) {
+		pr_err("schema mmio-device requires arguments\n");
+		return;
+	}
+
+	prop = get_property(params, "reg-count");
+	if (!prop) {
+		pr_err("schema mmio-device requires reg-count argument\n");
+		return;
+	}
+
+	count = propval_cell(prop);
+	if (!count) {
+		pr_err("wrong number of reg entries requested\n");
+		return;
+	}
+
+	if (!node->parent) {
+		pr_err("root node can not be an mmio-device\n");
+		return;
+	}
+
+	address_cells = get_address_cells(node);
+	size_cells = get_size_cells(node);
+
+	prop = require_property(node, "reg");
+	if (!prop)
+		return;
+
+	if (prop->val.len % (address_cells + size_cells))
+		pr_err("malformed reg property - not a multiple of (#address-cells + #size-cells)\n");
+
+	if (prop->val.len < count * (address_cells + size_cells))
+		pr_err("not enough entries in reg property - expected %u\n", count);
+}
+GENERIC_SCHEMA("mmio-device", mmio_device);
+
+static void generic_checkfn_mmio_bus(const struct generic_schema *schema,
+				     struct node *root, struct node *node,
+				     struct node *params, bool required)
+{
+	struct property *prop;
+	cell_t val;
+
+	prop = require_property(node, "#address-cells");
+	if (!prop)
+		return;
+
+	val = propval_cell(prop);
+	if (val < 1)
+		pr_err("mmio-bus requires positive #address-cells value\n");
+
+	prop = require_property(node, "#size-cells");
+	if (!prop)
+		return;
+
+	val = propval_cell(prop);
+	if (val < 1)
+		pr_err("mmio-bus requires positive #size-cells value\n");
+}
+GENERIC_SCHEMA("mmio-bus", mmio_bus);
-- 
1.8.5.2
