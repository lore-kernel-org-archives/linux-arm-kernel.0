From: david@gibson.dropbear.id.au (David Gibson)
Date: Sat, 26 Oct 2013 10:29:51 +1100
Subject: [RFC PATCH dtc] C-based DT schema checker integrated into dtc
In-Reply-To: <1382651488-9696-1-git-send-email-swarren@wwwdotorg.org>
References: <1382651488-9696-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131025232951.GD17659@voom.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 10:51:28PM +0100, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> This is a very quick proof-of-concept re: how a DT schema checker might
> look if written in C, and integrated into dtc.

So, this is much closer in outline than previous suggestions to how I
think schema checking should be integrated into dtc.

[snip]
> diff --git a/checks.c b/checks.c
> index ee96a25..49143b3 100644
> --- a/checks.c
> +++ b/checks.c
> @@ -19,6 +19,7 @@
>   */
>  
>  #include "dtc.h"
> +#include "schemas/schema.h"
>  
>  #ifdef TRACE_CHECKS
>  #define TRACE(c, ...) \
> @@ -236,6 +237,14 @@ static void check_is_cell(struct check *c, struct node *root,
>   * Structural check functions
>   */
>  
> +static void check_schema(struct check *c, struct node *dt,
> +				       struct node *node)
> +{
> +	if (schema_check_node(node))
> +		FAIL(c, "Schema check failed for %s", node->fullpath);
> +}
> +NODE_ERROR(schema, NULL);

So, I think the better approach is to pull each schema in as a
seperate check, rather than have a single 'check_schema'.  Way back
when I implemented 'checks' I did put a fair bit of thought into what
"schema checking" would need, even if I didn't think of it in those
terms at the time.

As seperate checks, multiple schemas can be checked, each printing
their own errors.  It tracks which ones failed and which ones passed.
We already have the -W and -E options to control which schemas/checks
are enabled/disabled.  It has the prerequisites mechanism - that can
simplify the checking code, because it lets you right code which might
segfault if the required check didn't succeed.

As/when we implement loading schemas dynamically, we'll need to extend
the checks mechanism from the static table it uses now, but that
should be straightforward enough.

>  static void check_duplicate_node_names(struct check *c, struct node *dt,
>  				       struct node *node)
>  {
> @@ -652,6 +661,8 @@ static void check_obsolete_chosen_interrupt_controller(struct check *c,
>  TREE_WARNING(obsolete_chosen_interrupt_controller, NULL);
>  
>  static struct check *check_table[] = {
> +	&schema,

As a rough guideline, this table is laid out with the most basic,
structural checks first, and the more complex semantic checks lower
down, so the schema check(s) should probably go at the bottom.

>  	&duplicate_node_names, &duplicate_property_names,
>  	&node_name_chars, &node_name_format, &property_name_chars,
>  	&name_is_string, &name_properties,
> diff --git a/schemas/clock/clock.c b/schemas/clock/clock.c
> new file mode 100644
> index 0000000..0b9ca1f
> --- /dev/null
> +++ b/schemas/clock/clock.c
> @@ -0,0 +1,16 @@
> +#include "schema.h"
> +
> +void is_a_clock_provider(struct node *node, int clock_cells)
> +{
> +	required_integer_property(node, "#clock-cells", clock_cells);
> +}
> +
> +void is_a_clock_consumer_by_name(struct node *node, int clock_count)
> +{
> +	required_property(node, "clock-names");
> +	/* FIXME: validate all required names are present */
> +	/* FIXME: validate all names present are in list of valid names */
> +	required_property(node, "clocks");
> +	/* FIXME: validate phandle, specifier list in property */
> +	/* FIXME: validate len(clocks) =~ len(clock-names) * #clock-cells */
> +}
> diff --git a/schemas/gpio/gpio.c b/schemas/gpio/gpio.c
> new file mode 100644
> index 0000000..e52f161
> --- /dev/null
> +++ b/schemas/gpio/gpio.c
> @@ -0,0 +1,13 @@
> +#include "schema.h"
> +
> +void is_a_gpio_provider(struct node *node, int gpio_cells)
> +{
> +	required_boolean_property(node, "gpio-controller");
> +	required_integer_property(node, "#gpio-cells", gpio_cells);
> +}
> +
> +void is_a_gpio_consumer(struct node *node, const char *propname)
> +{
> +	required_property(node, propname);
> +	/* FIXME: validate phandle, specifier list in property */
> +}
> diff --git a/schemas/i2c/i2c.c b/schemas/i2c/i2c.c
> new file mode 100644
> index 0000000..0772ea3
> --- /dev/null
> +++ b/schemas/i2c/i2c.c
> @@ -0,0 +1,17 @@
> +#include "../schema.h"
> +
> +void is_an_i2c_bus(struct node *node)
> +{
> +	printf("INFO: %s()\n", __FUNCTION__);
> +
> +	is_an_mmio_bus(node, 1, 0);
> +	required_property(node, "#address-cells");
> +	required_property(node, "#size-cells");
> +	optional_property(node, "clock-frequency");
> +	/* FIXME: set internal tag on *node to mark it as an I2C bus */
> +}
> +
> +void is_an_i2c_bus_child(struct node *node)
> +{
> +	/* FIXME: validate that is_an_i2c_bus() was called on node->parent */
> +}
> diff --git a/schemas/i2c/nvidia,tegra20-i2c.c b/schemas/i2c/nvidia,tegra20-i2c.c
> new file mode 100644
> index 0000000..c616f33
> --- /dev/null
> +++ b/schemas/i2c/nvidia,tegra20-i2c.c
> @@ -0,0 +1,20 @@
> +#include "../schema.h"
> +
> +static const char *compats_nvidia_tegra20_i2c[] = {
> +	"nvidia,tegra20-i2c",
> +	"nvidia,tegra30-i2c",
> +	"nvidia,tegra114-i2c",
> +	"nvidia,tegra124-i2c",
> +	NULL,
> +};
> +
> +static void checkfn_nvidia_tegra20_i2c(struct node *node)
> +{
> +	printf("INFO: %s()\n", __FUNCTION__);
> +
> +	is_an_mmio_bus_child(node, 1);
> +	is_an_i2c_bus(node);
> +	is_an_interrupt_consumer_by_index(node, 1);
> +	is_a_clock_consumer_by_name(node, 2);
> +}
> +SCHEMA_MATCH_COMPATIBLE(nvidia_tegra20_i2c);
> diff --git a/schemas/interrupt-controller/interrupts.c b/schemas/interrupt-controller/interrupts.c
> new file mode 100644
> index 0000000..39191a8
> --- /dev/null
> +++ b/schemas/interrupt-controller/interrupts.c
> @@ -0,0 +1,14 @@
> +#include "schema.h"
> +
> +void is_an_interrupt_provider(struct node *node, int int_cells)
> +{
> +	required_boolean_property(node, "interrupt-controller");
> +	required_integer_property(node, "#interrupt-cells", int_cells);
> +}
> +
> +void is_an_interrupt_consumer_by_index(struct node *node, int int_count)
> +{
> +	required_property(node, "interrupts");
> +	/* FIXME: validate phandle, specifier list in property */
> +	/* FIXME: validate len(interrupts) =~ int_count * #interrupt-cells */
> +}
> diff --git a/schemas/mmio-bus.c b/schemas/mmio-bus.c
> new file mode 100644
> index 0000000..74b5410
> --- /dev/null
> +++ b/schemas/mmio-bus.c
> @@ -0,0 +1,15 @@
> +#include "schema.h"
> +
> +void is_an_mmio_bus(struct node *node, int address_cells, int size_cells)
> +{
> +	required_integer_property(node, "#address-cells", address_cells);
> +	required_integer_property(node, "#size-cells", size_cells);
> +	/* FIXME: set internal tag on *node to mark it as an MMIO bus */
> +}
> +
> +void is_an_mmio_bus_child(struct node *node, int reg_count)
> +{
> +	/* FIXME: validate that is_an_mmio_bus() was called on node->parent */
> +	required_property(node, "reg");
> +	/* FIXME: validate len(reg) == reg_count * (#address-+#size-cells) */
> +}
> diff --git a/schemas/root-node.c b/schemas/root-node.c
> new file mode 100644
> index 0000000..c6ab0c7
> --- /dev/null
> +++ b/schemas/root-node.c
> @@ -0,0 +1,27 @@
> +#include "schema.h"
> +
> +static void checkfn_root_node(struct node *node)
> +{
> +	printf("INFO: %s()\n", __FUNCTION__);
> +
> +	/*
> +	 * FIXME: Need to allow is_an_mmio_bus() that allows any values of
> +	 * #address-cells/#size-cells
> +	 */
> +	is_an_mmio_bus(node, 1, 1);
> +	/*
> +	 * FIXME: call required_string_property() here instead, or perhaps
> +	 * required_property(node, "compatible", check_propval_string);
> +	 * where check_propval_string() is a function that performs additional
> +	 * checks on the property value.
> +	 */
> +	required_property(node, "compatible");
> +	/*
> +	 * FIXME: call optional_string_property() here instead, or perhaps
> +	 * optional_property(node, "compatible", check_propval_string);
> +	 * where check_propval_string() is a function that performs additional
> +	 * checks on the property value.
> +	 */
> +	optional_property(node, "model");
> +}
> +SCHEMA_MATCH_PATH(root_node, "/");
> diff --git a/schemas/schema.c b/schemas/schema.c
> new file mode 100644
> index 0000000..cb78170
> --- /dev/null
> +++ b/schemas/schema.c
> @@ -0,0 +1,119 @@
> +#include "schema.h"
> +
> +/* FIXME: automate this table... */
> +extern struct schema_checker schema_checker_root_node;
> +extern struct schema_checker schema_checker_nvidia_tegra20_i2c;
> +extern struct schema_checker schema_checker_wlf_wm8903;
> +static const struct schema_checker *schema_checkers[] = {
> +	&schema_checker_root_node,
> +	&schema_checker_nvidia_tegra20_i2c,
> +	&schema_checker_wlf_wm8903,
> +};
> +
> +int schema_check_node(struct node *node)
> +{
> +	int i;
> +	const struct schema_checker *checker, *best_checker = NULL;
> +	int match, best_match = 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(schema_checkers); i++) {
> +		checker = schema_checkers[i];
> +		match = checker->matchfn(node, checker);
> +		if (match) {
> +			printf("INFO: Node %s matches checker %s at level %d\n",
> +				node->fullpath, checker->name, match);
> +			if (!best_checker || (match > best_match)) {
> +				best_match = match;
> +				best_checker = checker;
> +			}
> +		}
> +	}
> +
> +	if (!best_checker) {
> +		printf("WARNING: no schema for node %s\n", node->fullpath);
> +		return 0;
> +	}
> +
> +	printf("INFO: Node %s selected checker %s\n", node->fullpath,
> +		best_checker->name);
> +
> +	best_checker->checkfn(node);

IMO, thinking in terms of "the" schema for a node is a mistake.
Instead, think in terms of a bunch of schemas, which "known" what
nodes they're relevant for.  Often that will be determined by
compatible, but it could also be determined by other things (presence
of 'interrupts', parent node, explicitly implied by another schema).

> +	/*
> +	 * FIXME: grab validation state from global somewhere.
> +	 * Using global state avoids having check return values after every
> +	 * function call, thus making the code less verbose and appear more
> +	 * assertion-based.
> +	 */

So.. this is why the checks mechanism is structured as it is.  The
'check' structure is passed down everywhere as a context where this
global state can be saved to.

> +	return 0;
> +}
> +
> +int schema_match_path(struct node *node, const struct schema_checker *checker)
> +{
> +	return !strcmp(node->fullpath, checker->u.path.path);
> +}
> +
> +int schema_match_compatible(struct node *node,
> +				const struct schema_checker *checker)
> +{
> +	struct property *compat_prop;
> +	int index;
> +	const char *node_compat;
> +	const char **test_compats;
> +
> +	compat_prop = get_property(node, "compatible");
> +	if (!compat_prop)
> +		return 0;
> +
> +	/*
> +	 * The best_match logic here is to find the checker entry that matches
> +	 * the first compatible value in the node, then if there's no match,
> +	 * fall back to finding the checker that matches the second compatible
> +	 * value, etc. Perhaps we want to run all checkers instead? Especially,
> +	 * we might want to run all different types of checker (by path name,
> +	 * by compatible).
> +	 */
> +	for (node_compat = compat_prop->val.val, index = 0;
> +			*node_compat;
> +			node_compat += strlen(node_compat) + 1, index++) {
> +		for (test_compats = checker->u.compatible.compats;
> +				*test_compats; test_compats++) {
> +			if (!strcmp(node_compat, *test_compats))
> +				return -(index + 1);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +void required_property(struct node *node, const char *propname)
> +{
> +	struct property *prop;
> +
> +	prop = get_property(node, propname);
> +	if (!prop) {
> +		/*
> +		 * FIXME: set global error state. The same comment applies
> +		 * everywhere.
> +		 */

Right, this is why you want one-check-per-schema, and you pass the
check structure down everywhere.  Then you can use the FAIL() macro to
set that state.  That's what it was designed for :).

> +		printf("ERROR: node %s missing property %s\n", node->fullpath,
> +			propname);
> +	}
> +}
> +
> +void required_boolean_property(struct node *node, const char *propname)
> +{
> +	required_property(node, propname);
> +	/* FIXME: Validate it's length is zero if present */
> +}
> +
> +void required_integer_property(struct node *node, const char *propname,
> +				int value)
> +{
> +	required_property(node, propname);
> +	/* FIXME: Validate it's length is 1 cell, and value matches */
> +}
> +
> +void optional_property(struct node *node, const char *propname)
> +{
> +}
> diff --git a/schemas/schema.h b/schemas/schema.h
> new file mode 100644
> index 0000000..74e9931
> --- /dev/null
> +++ b/schemas/schema.h
> @@ -0,0 +1,68 @@
> +#ifndef _SCHEMAS_SCHEMA_H
> +#define _SCHEMAS_SCHEMA_H
> +
> +#include "dtc.h"
> +
> +struct schema_checker;
> +
> +typedef int (schema_matcher_func)(struct node *node,
> +					const struct schema_checker *checker);
> +typedef void (schema_checker_func)(struct node *node);
> +
> +struct schema_checker {
> +	const char *name;
> +	schema_matcher_func *matchfn;
> +	schema_checker_func *checkfn;
> +	union {
> +		struct {
> +			const char *path;
> +		} path;
> +		struct {
> +			const char **compats;
> +		} compatible;
> +	} u;
> +};
> +
> +int schema_check_node(struct node *node);
> +
> +int schema_match_path(struct node *node, const struct schema_checker *checker);
> +int schema_match_compatible(struct node *node,
> +				const struct schema_checker *checker);
> +
> +#define SCHEMA_MATCH_PATH(_name_, _path_) \
> +	struct schema_checker schema_checker_##_name_ = { \
> +		.name = #_name_, \
> +		.matchfn = schema_match_path, \
> +		.checkfn = checkfn_##_name_, \
> +		.u.path.path = _path_, \
> +	};
> +
> +#define SCHEMA_MATCH_COMPATIBLE(_name_) \
> +	struct schema_checker schema_checker_##_name_ = { \
> +		.name = #_name_, \
> +		.matchfn = schema_match_compatible, \
> +		.checkfn = checkfn_##_name_, \
> +		.u.compatible.compats = compats_##_name_, \
> +	};
> +
> +void required_property(struct node *node, const char *propname);
> +void required_boolean_property(struct node *node, const char *propname);
> +void required_integer_property(struct node *node, const char *propname,
> +				int value);
> +void optional_property(struct node *node, const char *propname);
> +void is_an_mmio_bus(struct node *node, int address_cells, int size_cells);
> +void is_an_mmio_bus_child(struct node *node, int reg_count);
> +void is_an_i2c_bus(struct node *node);
> +void is_an_i2c_bus_child(struct node *node);
> +void is_a_gpio_provider(struct node *node, int gpio_cells);
> +void is_a_gpio_consumer(struct node *node, const char *propname);
> +void is_an_interrupt_provider(struct node *node, int int_cells);
> +void is_an_interrupt_consumer_by_index(struct node *node, int int_count);
> +void is_a_clock_provider(struct node *node, int clock_cells);
> +/*
> + * FIXME: pass in a list of required and optional clock names instead of a
> + * count
> + */
> +void is_a_clock_consumer_by_name(struct node *node, int clock_count);
> +
> +#endif
> diff --git a/schemas/sound/wlf,wm8903.c b/schemas/sound/wlf,wm8903.c
> new file mode 100644
> index 0000000..f6ac49d
> --- /dev/null
> +++ b/schemas/sound/wlf,wm8903.c
> @@ -0,0 +1,20 @@
> +#include "../schema.h"
> +
> +static const char *compats_wlf_wm8903[] = {
> +	"wlf,wm8903",
> +	NULL,
> +};
> +
> +static void checkfn_wlf_wm8903(struct node *node)
> +{
> +	printf("INFO: %s()\n", __FUNCTION__);
> +
> +	is_an_mmio_bus_child(node, 1);
> +	is_an_i2c_bus_child(node);
> +	is_an_interrupt_consumer_by_index(node, 1);
> +	is_a_gpio_provider(node, 2);
> +	optional_property(node, "micdet-cfg");
> +	optional_property(node, "micdet-delay");
> +	optional_property(node, "gpio-cfg");
> +}
> +SCHEMA_MATCH_COMPATIBLE(wlf_wm8903);
> diff --git a/test-schema.dts b/test-schema.dts
> new file mode 100644
> index 0000000..02e1fdc
> --- /dev/null
> +++ b/test-schema.dts
> @@ -0,0 +1,45 @@
> +/dts-v1/;
> +
> +/ {
> +	model = "NVIDIA Tegra20 Harmony evaluation board";
> +	compatible = "nvidia,harmony", "nvidia,tegra20";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	aliases {
> +	};
> +
> +	chosen {
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x40000000>;
> +	};
> +
> +	i2c at 7000c000 {
> +		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
> +		reg = <0x7000c000 0x100>;
> +		interrupts = <0 38 0>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clocks = <0 0>, <0 1>;
> +		clock-names = "div-clk", "fast-clk";
> +		status = "okay";
> +		clock-frequency = <400000>;
> +
> +		wm8903: wm8903 at 1a {
> +			compatible = "wlf,wm8903";
> +			reg = <0x1a>;
> +			interrupt-parent = <0>;
> +			interrupts = <5 0>;
> +
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +
> +			micdet-cfg = <0>;
> +			micdet-delay = <100>;
> +			gpio-cfg = <0xffffffff 0xffffffff 0 0xffffffff 0xffffffff>;
> +		};
> +	};
> +};

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131026/f700ef61/attachment-0001.sig>
