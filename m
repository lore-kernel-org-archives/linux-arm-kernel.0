From: david@gibson.dropbear.id.au (David Gibson)
Date: Sun, 9 Mar 2014 23:17:01 +1100
Subject: [PATCH RFC 3/5] Implement DT schema checker using hybrid approach
In-Reply-To: <1392919611-10746-4-git-send-email-t.figa@samsung.com>
References: <1392919611-10746-1-git-send-email-t.figa@samsung.com>
 <1392919611-10746-4-git-send-email-t.figa@samsung.com>
Message-ID: <20140309121701.GH20356@voom.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 07:06:49PM +0100, Tomasz Figa wrote:
> This patch adds a proof of concept framework to implement schema checker
> using a combined C and DTSS based approach.
> 
> Complex and generic bindings can be implemented directly in C and then
> instantiated from simple device-specific bindings using DTS-like DTSS
> language.
> 
> This is based on Stephen Warren's C based DT schema checker proof of
> concept patch.
> 
> [original C based DT schema checker proof of concept]
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
> [further development into hybrid solution]
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  Makefile         |   2 +-
>  Makefile.dtc     |   5 +-
>  checks.c         |  15 +++
>  dtc.c            |  17 ++-
>  dtc.h            |  26 +++++
>  dtss-lexer.l     | 291 +++++++++++++++++++++++++++++++++++++++++++++++
>  dtss-parser.y    | 341 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  schemas/schema.c | 311 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  schemas/schema.h |  89 +++++++++++++++
>  srcpos.h         |   2 +
>  treesource.c     |  22 ++++
>  11 files changed, 1117 insertions(+), 4 deletions(-)
>  create mode 100644 dtss-lexer.l
>  create mode 100644 dtss-parser.y
>  create mode 100644 schemas/schema.c
>  create mode 100644 schemas/schema.h
> 
> diff --git a/Makefile b/Makefile
> index 86f5ab3..0625fb8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -15,7 +15,7 @@ EXTRAVERSION =
>  LOCAL_VERSION =
>  CONFIG_LOCALVERSION =
>  
> -CPPFLAGS = -I libfdt -I .
> +CPPFLAGS = -I libfdt -I . -I schemas
>  WARNINGS = -Werror -Wall -Wpointer-arith -Wcast-qual -Wnested-externs \
>  	-Wstrict-prototypes -Wmissing-prototypes -Wredundant-decls -Wshadow
>  CFLAGS = -g -Os -fPIC -Werror $(WARNINGS)
> diff --git a/Makefile.dtc b/Makefile.dtc
> index bece49b..bf19564 100644
> --- a/Makefile.dtc
> +++ b/Makefile.dtc
> @@ -12,7 +12,8 @@ DTC_SRCS = \
>  	livetree.c \
>  	srcpos.c \
>  	treesource.c \
> -	util.c
> +	util.c \
> +	schemas/schema.c
>  
> -DTC_GEN_SRCS = dtc-lexer.lex.c dtc-parser.tab.c
> +DTC_GEN_SRCS = dtc-lexer.lex.c dtc-parser.tab.c dtss-lexer.lex.c dtss-parser.tab.c
>  DTC_OBJS = $(DTC_SRCS:%.c=%.o) $(DTC_GEN_SRCS:%.c=%.o)
> diff --git a/checks.c b/checks.c
> index 47eda65..7c85fcf 100644
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
> @@ -651,6 +652,18 @@ static void check_obsolete_chosen_interrupt_controller(struct check *c,
>  }
>  TREE_WARNING(obsolete_chosen_interrupt_controller, NULL);
>  
> +/*
> + * Schema checks
> + */
> +
> +static void check_schema(struct check *c, struct node *dt,
> +				       struct node *node)
> +{
> +	if (schema_check_node(dt, node))
> +		FAIL(c, "Schema check failed for %s", node->fullpath);
> +}
> +NODE_ERROR(schema, NULL);
> +
>  static struct check *check_table[] = {
>  	&duplicate_node_names, &duplicate_property_names,
>  	&node_name_chars, &node_name_format, &property_name_chars,
> @@ -669,6 +682,8 @@ static struct check *check_table[] = {
>  	&avoid_default_addr_size,
>  	&obsolete_chosen_interrupt_controller,
>  
> +	&schema,
> +
>  	&always_fail,
>  };

Blech.  The whole point of the checks infrastructure is to keep track
of checks for different possible problems in the tree.  It has stuff
to handle possible interdependencies, and to keep checking what it
can, even if some checks have already failed.

And you throw that all away by handling all the schemas in a single
check.  Instead, each schema should be loaded as a separate check.
This also makes the C/schema hybrid approach much more natural, as
there's no artificial distinction between a schema/check implemented
directly in C and one loaded from a script/schema parser.

> diff --git a/dtc.c b/dtc.c
> index d36ccdc..1a5913b 100644
> --- a/dtc.c
> +++ b/dtc.c
> @@ -20,6 +20,7 @@
>  
>  #include "dtc.h"
>  #include "srcpos.h"
> +#include "schemas/schema.h"
>  
>  /*
>   * Command line options
> @@ -49,7 +50,7 @@ static void fill_fullpaths(struct node *tree, const char *prefix)
>  
>  /* Usage related data. */
>  static const char usage_synopsis[] = "dtc [options] <input file>";
> -static const char usage_short_opts[] = "qI:O:o:V:d:R:S:p:fb:i:H:sW:E:hv";
> +static const char usage_short_opts[] = "qI:O:o:V:d:R:S:p:fb:i:H:sW:E:x:hv";
>  static struct option const usage_long_opts[] = {
>  	{"quiet",            no_argument, NULL, 'q'},
>  	{"in-format",         a_argument, NULL, 'I'},
> @@ -67,6 +68,7 @@ static struct option const usage_long_opts[] = {
>  	{"phandle",           a_argument, NULL, 'H'},
>  	{"warning",           a_argument, NULL, 'W'},
>  	{"error",             a_argument, NULL, 'E'},
> +	{"schema",            a_argument, NULL, 'x'},
>  	{"help",             no_argument, NULL, 'h'},
>  	{"version",          no_argument, NULL, 'v'},
>  	{NULL,               no_argument, NULL, 0x0},
> @@ -97,6 +99,7 @@ static const char * const usage_opts_help[] = {
>  	 "\t\tboth   - Both \"linux,phandle\" and \"phandle\" properties",
>  	"\n\tEnable/disable warnings (prefix with \"no-\")",
>  	"\n\tEnable/disable errors (prefix with \"no-\")",
> +	"\n\tUse schema file"
>  	"\n\tPrint this help and exit",
>  	"\n\tPrint version and exit",
>  	NULL,
> @@ -105,10 +108,12 @@ static const char * const usage_opts_help[] = {
>  int main(int argc, char *argv[])
>  {
>  	struct boot_info *bi;
> +	struct boot_info *bi_schema;

Really?  Most of the boot_info structure makes no sense when parsing
schemas rather than an actual device tree.  Even if you're trying to
use a common parser (which I think is a mistake), then at least
implement a different wrapper which uses an appropriate output type.

>  	const char *inform = "dts";
>  	const char *outform = "dts";
>  	const char *outname = "-";
>  	const char *depname = NULL;
> +	const char *schema = NULL;
>  	bool force = false, sort = false;
>  	const char *arg;
>  	int opt;
> @@ -185,6 +190,10 @@ int main(int argc, char *argv[])
>  			parse_checks_option(false, true, optarg);
>  			break;
>  
> +		case 'x':
> +			schema = optarg;
> +			break;
> +
>  		case 'h':
>  			usage(NULL);
>  		default:
> @@ -220,6 +229,12 @@ int main(int argc, char *argv[])
>  	else
>  		die("Unknown input format \"%s\"\n", inform);
>  
> +	if (schema) {
> +		bi_schema = schema_from_source(schema);
> +		//dt_to_source(stdout, bi_schema);
> +		build_schema_list(bi_schema);
> +	}
> +
>  	if (depfile) {
>  		fputc('\n', depfile);
>  		fclose(depfile);
> diff --git a/dtc.h b/dtc.h
> index 9ce9d12..19d2d24 100644
> --- a/dtc.h
> +++ b/dtc.h
> @@ -135,21 +135,43 @@ struct label {
>  	struct label *next;
>  };
>  
> +enum {
> +	PROPERTY_DATA,
> +	PROPERTY_USE,
> +	PROPERTY_REQUIRE,
> +	PROPERTY_MATCH,
> +};
> +
> +#define PROPERTY_FLAG_OPTIONAL	(1 << 0)
> +
>  struct property {
>  	bool deleted;
>  	char *name;
>  	struct data val;
> +	unsigned int type;
> +	unsigned int flags;
>  
>  	struct property *next;
>  
>  	struct label *labels;
>  };
>  
> +enum {
> +	NODE_DATA,
> +	NODE_USE,
> +	NODE_REQUIRE,
> +};
> +
> +#define NODE_FLAG_OPTIONAL	(1 << 0)
> +#define NODE_FLAG_INCOMPLETE	(1 << 1)
> +
>  struct node {
>  	bool deleted;
>  	char *name;
>  	struct property *proplist;
>  	struct node *children;
> +	int type;
> +	unsigned int flags;
>  
>  	struct node *parent;
>  	struct node *next_sibling;
> @@ -297,4 +319,8 @@ struct boot_info *dt_from_source(const char *f);
>  
>  struct boot_info *dt_from_fs(const char *dirname);
>  
> +/* Schema source */
> +
> +struct boot_info *schema_from_source(const char *fname);
> +
>  #endif /* _DTC_H */
> diff --git a/dtss-lexer.l b/dtss-lexer.l
> new file mode 100644
> index 0000000..aee41f6
> --- /dev/null
> +++ b/dtss-lexer.l
[snip]
> diff --git a/dtss-parser.y b/dtss-parser.y
> new file mode 100644
> index 0000000..1c807da
> --- /dev/null
> +++ b/dtss-parser.y
[snip]

My mistake, there is a new lexer and parser, so there's no excuse for
the duplicated boot_info structure above.  Or for the tortured schema
syntax to make it look kind of like a device tree itself.

> diff --git a/schemas/schema.c b/schemas/schema.c
> new file mode 100644
> index 0000000..e5258cf
> --- /dev/null
> +++ b/schemas/schema.c
> @@ -0,0 +1,311 @@
> +/*
> + * Copyright (C) 2013 Stephen Warren <swarren@wwwdotorg.org>
> + *
> + * Copyright (C) 2014 Samsung Electronics Co., Ltd.
> + *	Tomasz Figa <t.figa@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of the
> + * License, or (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
> + *                                                                   USA
> + */
> +
> +#include "schema.h"
> +
> +static struct schema_checker schema_list = {
> +	.next = &schema_list,
> +};
> +
> +int schema_check_node(struct node *root, struct node *node)
> +{
> +	const struct schema_checker *checker;
> +	int match;
> +	int checked = 0;
> +
> +	checker = schema_list.next;
> +	for (; checker != &schema_list; checker = checker->next) {
> +		match = checker->matchfn(node, checker);
> +		if (!match)
> +			continue;
> +
> +		pr_info("Node %s matches checker %s at level %d\n",
> +			node->fullpath, checker->name, match);
> +
> +		checker->checkfn(root, node, checker);
> +		checked = 1;
> +	}
> +
> +	/*
> +	 * FIXME: this is too noisy right now. Make it optional until schemas
> +	 * for most bindings are implemented.
> +	 */
> +	if (!checked) {
> +		pr_warn("no schema for node %s\n", node->fullpath);
> +		return 0;
> +	}
> +
> +	/*
> +	 * FIXME: grab validation state from global somewhere.
> +	 * Using global state avoids having check return values after every
> +	 * function call, thus making the code less verbose and appear more
> +	 * assertion-based.
> +	 */
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
> +	 * Match with any compatible value of schema with any compatible
> +	 * value of node being verified.
> +	 */
> +	for (node_compat = compat_prop->val.val, index = 0;
> +			*node_compat;
> +			node_compat += strlen(node_compat) + 1, index++) {
> +		for (test_compats = checker->u.compatible.compats;
> +				*test_compats; test_compats++) {
> +			if (!strcmp(node_compat, *test_compats))
> +				return 1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +struct property *schema_get_param(struct node *params, const char *name)
> +{
> +	if (!params)
> +		return NULL;
> +
> +	return get_property(params, name);
> +}
> +
> +int schema_get_param_cell(struct node *params, const char *name, cell_t *val)
> +{
> +	struct property *prop;
> +
> +	prop = schema_get_param(params, name);
> +	if (!prop)
> +		return -ENOENT;
> +
> +	if (!prop->val.len)
> +		return -EINVAL;
> +
> +	*val = propval_cell(prop);
> +	return 0;
> +}
> +
> +struct property *require_property(struct node *node, const char *name)
> +{
> +	struct property *prop;
> +
> +	prop = get_property(node, name);
> +	if (!prop) {
> +		/*
> +		 * FIXME: set global error state. The same comment applies
> +		 * everywhere.
> +		 */
> +		pr_err("node '%s' missing '%s' property\n",
> +			node->fullpath, name);
> +	}
> +
> +	return prop;
> +}
> +
> +static void check_required_property(struct node *node, struct property *schema)
> +{
> +	struct property *prop;
> +
> +	prop = require_property(node, schema->name);
> +	if (!prop)
> +		return;
> +
> +	if (schema->val.len
> +	    && (schema->val.len != prop->val.len
> +	    || memcmp(schema->val.val, prop->val.val, prop->val.len)))
> +		pr_err("node %s with wrong constant value of property %s\n",
> +			node->fullpath, schema->name);
> +}
> +
> +static void check_optional_property(struct node *node, struct property *schema)
> +{
> +	struct property *prop;
> +
> +	prop = get_property(node, schema->name);
> +	if (!prop)
> +		return;
> +
> +	check_required_property(node, schema);
> +}
> +
> +/*
> + * FIXME: Use a more generic solution, which does not rely on linker
> + * specific features.
> + */
> +extern const struct generic_schema __start_generic_schemas;
> +extern const struct generic_schema __stop_generic_schemas;
> +
> +static void check_generic_schema(struct node *root, struct node *node,
> +					const char *name,
> +					struct node *schema_node,
> +					bool required)
> +{
> +	const struct generic_schema *gs;
> +	int i;
> +	bool checked = false;
> +	unsigned int count = &__stop_generic_schemas - &__start_generic_schemas;
> +
> +	pr_info("running schema \"%s\"\n", name);
> +
> +	gs = &__start_generic_schemas;
> +	for (i = 0; i < count; ++i, ++gs) {
> +		if (strcmp(gs->name, name))
> +			continue;
> +
> +		gs->checkfn(gs, root, node, schema_node, required);
> +
> +		checked = true;
> +	}
> +
> +	if (!checked)
> +		pr_err("schema \"%s\" not found\n", name);
> +}
> +
> +static void check_dtss_schema(struct node *root, struct node *node,
> +			      const struct schema_checker *checker)
> +{
> +	struct property *prop_schema;
> +	struct node *schema = checker->node, *node_schema;
> +
> +	for_each_property(schema, prop_schema) {
> +		if (!strcmp(prop_schema->name, "compatible")
> +		    || !strcmp(prop_schema->name, "device_type"))
> +			continue;
> +
> +		switch (prop_schema->type) {
> +		case PROPERTY_DATA:
> +			if (prop_schema->flags & PROPERTY_FLAG_OPTIONAL)
> +				check_optional_property(node, prop_schema);
> +			else
> +				check_required_property(node, prop_schema);
> +			break;
> +
> +		case PROPERTY_REQUIRE:
> +			check_generic_schema(root, node, prop_schema->name,
> +						NULL, true);
> +			break;
> +
> +		case PROPERTY_USE:
> +			check_generic_schema(root, node, prop_schema->name,
> +						NULL, false);
> +			break;
> +		}
> +	}
> +
> +	for_each_child(schema, node_schema) {
> +		switch (node_schema->type) {
> +		case NODE_DATA:
> +			/* TODO: verify subnodes */
> +			break;
> +
> +		case NODE_REQUIRE:
> +			check_generic_schema(root, node, node_schema->name,
> +						node_schema, true);
> +			break;
> +
> +		case NODE_USE:
> +			check_generic_schema(root, node, node_schema->name,
> +						node_schema, false);
> +			break;
> +		}
> +	}
> +
> +	/* TODO: detect unknown properties */
> +}
> +
> +void build_schema_list(struct boot_info *schema_tree)
> +{
> +	struct node *root, *schema;
> +
> +	root = get_node_by_path(schema_tree->dt, "/");
> +	if (!root) {
> +		pr_err("schema file missing / node\n");
> +		return;
> +	}
> +
> +	for_each_child(root, schema) {
> +		struct schema_checker *sc = xmalloc(sizeof(*sc));
> +		struct property *prop;
> +
> +		sc->node = schema;
> +		sc->checkfn = check_dtss_schema;
> +		sc->name = schema->name;
> +
> +		for_each_property(schema, prop)
> +			if (prop->type == PROPERTY_MATCH)
> +				goto found_match;
> +
> +		pr_err("schema '%s' without matching key\n", sc->name);
> +		free(sc);
> +		continue;
> +
> +found_match:
> +		if (!strcmp(prop->name, "compatible")) {
> +			int count;
> +			const char **compats;
> +			const char *compat;
> +
> +			count = propval_string_count(schema, prop) + 1;
> +			compats = xmalloc(count * sizeof(*compats));
> +
> +			sc->u.compatible.compats = compats;
> +
> +			while ((compat = propval_next_string(prop, compat))) {
> +				*compats = compat;
> +				++compats;
> +			}
> +			*compats = NULL;
> +
> +			sc->matchfn = schema_match_compatible;
> +			sc->next = schema_list.next;
> +			schema_list.next = sc;
> +		} else if (!strcmp(prop->name, "device_type")) {
> +			sc->u.type.type = propval_next_string(prop, NULL);
> +			sc->next = schema_list.next;
> +			schema_list.next = sc;
> +		} else if (!strcmp(prop->name, "path")) {
> +			sc->u.path.path = propval_next_string(prop, NULL);
> +			sc->matchfn = schema_match_path;
> +			sc->next = schema_list.next;
> +			schema_list.next = sc;
> +		} else {
> +			pr_err("wrong schema key type\n");
> +			free(sc);
> +		}
> +	}
> +}
> diff --git a/schemas/schema.h b/schemas/schema.h
> new file mode 100644
> index 0000000..9972a17
> --- /dev/null
> +++ b/schemas/schema.h
> @@ -0,0 +1,89 @@
> +#ifndef _SCHEMAS_SCHEMA_H
> +#define _SCHEMAS_SCHEMA_H
> +
> +#include "dtc.h"
> +
> +struct schema_checker;
> +
> +typedef int (schema_matcher_func)(struct node *node,
> +					const struct schema_checker *checker);
> +typedef void (schema_checker_func)(struct node *root, struct node *node,
> +					const struct schema_checker *checker);
> +
> +struct schema_checker {
> +	const char *name;
> +	schema_matcher_func *matchfn;
> +	schema_checker_func *checkfn;
> +	struct node *node;
> +	union {
> +		struct {
> +			const char *path;
> +		} path;
> +		struct {
> +			const char **compats;
> +		} compatible;
> +		struct {
> +			const char *type;
> +		} type;
> +	} u;
> +	struct schema_checker *next;
> +};

AFAICT all the above is only used internally in schema.c so there's no
need for it to be in a header.

> +
> +int schema_check_node(struct node *root, struct node *node);
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
> +struct generic_schema;
> +
> +typedef void (generic_schema_checker_func)(const struct generic_schema *schema,
> +					   struct node *root, struct node *node,
> +					   struct node *params, bool required);
> +
> +struct generic_schema {
> +	const char *name;
> +	generic_schema_checker_func *checkfn;
> +};
> +
> +#define __used		__attribute__((__used__))
> +#define __section(S)	__attribute__ ((__section__(#S)))
> +
> +#define GENERIC_SCHEMA(_dt_name_, _name_)				\
> +	static const struct generic_schema generic_schema_##_name_	\
> +		__used __section(generic_schemas) = {			\
> +			.name = _dt_name_,				\
> +			.checkfn = generic_checkfn_##_name_,		\
> +	};
> +
> +struct property *require_property(struct node *node, const char *propname);
> +struct property *schema_get_param(struct node *params, const char *name);
> +int schema_get_param_cell(struct node *params, const char *name, cell_t *val);
> +
> +void build_schema_list(struct boot_info *schema_tree);
> +
> +#define schema_err(s,fmt,args...)	pr_err("%s: " fmt, (s)->name, ##args)
> +#define schema_warn(s,fmt,args...)	pr_warn("%s: " fmt, (s)->name, ##args)
> +#define schema_info(s,fmt,args...)	pr_info("%s: " fmt, (s)->name, ##args)
> +
> +#define node_err(n,fmt,args...)		pr_err("%s: " fmt, (n)->fullpath, ##args)
> +#define node_warn(n,fmt,args...)	pr_warn("%s: " fmt, (n)->fullpath, ##args)
> +#define node_info(n,fmt,args...)	pr_info("%s: " fmt, (n)->fullpath, ##args)
> +
> +#endif
> diff --git a/srcpos.h b/srcpos.h
> index f81827b..b761522 100644
> --- a/srcpos.h
> +++ b/srcpos.h
> @@ -75,7 +75,9 @@ struct srcpos {
>      struct srcfile_state *file;
>  };
>  
> +#ifndef YYLTYPE
>  #define YYLTYPE struct srcpos
> +#endif
>  
>  #define YYLLOC_DEFAULT(Current, Rhs, N)						\
>  	do {									\
> diff --git a/treesource.c b/treesource.c
> index bf7a626..e50285c 100644
> --- a/treesource.c
> +++ b/treesource.c
> @@ -25,6 +25,10 @@ extern FILE *yyin;
>  extern int yyparse(void);
>  extern YYLTYPE yylloc;
>  
> +extern FILE *dtss_yyin;
> +extern int dtss_yyparse(void);
> +extern YYLTYPE dtss_yylloc;
> +
>  struct boot_info *the_boot_info;
>  bool treesource_error;
>  
> @@ -46,6 +50,24 @@ struct boot_info *dt_from_source(const char *fname)
>  	return the_boot_info;
>  }
>  
> +struct boot_info *schema_from_source(const char *fname)
> +{
> +	the_boot_info = NULL;
> +	treesource_error = false;
> +
> +	srcfile_push(fname);
> +	dtss_yyin = current_srcfile->f;
> +	dtss_yylloc.file = current_srcfile;
> +
> +	if (dtss_yyparse() != 0)
> +		die("Unable to parse input tree\n");
> +
> +	if (treesource_error)
> +		die("Syntax error parsing input tree\n");
> +
> +	return the_boot_info;
> +}
> +
>  static void write_prefix(FILE *f, int level)
>  {
>  	int i;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140309/e265e3ec/attachment-0001.sig>
