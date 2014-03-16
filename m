From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 16 Mar 2014 22:22:02 +0100
Subject: [PATCH] dtc: add ability to make nodes conditional on them being
 referenced
Message-ID: <199290403.sj4aYrj8FC@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Heiko Stuebner <heiko.stuebner@bq.com>

On i.MX, which carries a lot of pin-groups of which most are unused on
individual boards, they noticed that this plethora of nodes also results
in the runtime-lookup-performance also degrading [0].

A i.MX-specific solution defining the pingroups in the board files but
using macros to reference the pingroup-data was not well received.

This patch is trying to solve this issue in a more general way, by
adding the ability to mark nodes as needing to be referenced somewhere
in the tree.

To mark a node a needing to be referenced it must be prefixed with
/delete-unreferenced/. This makes dtc check the nodes reference-status
when creating the flattened tree, dropping it if unreferenced.

For example, the i.MX6SL pingroup

	/delete-unreferenced/ pinctrl_ecspi1_1: ecspi1grp-1 {
		fsl,pins = <
			MX6SL_PAD_ECSPI1_MISO__ECSPI1_MISO 0x100b1
			MX6SL_PAD_ECSPI1_MOSI__ECSPI1_MOSI 0x100b1
			MX6SL_PAD_ECSPI1_SCLK__ECSPI1_SCLK 0x100b1
		>;
	};

would only be included in the dtb if it got referenced somewhere
as pingroup via

	node {
		pinctrl-0 <&pinctrl_ecscpi1_1>;
	};

[0] http://thread.gmane.org/gmane.linux.ports.arm.kernel/275912/

Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
---
A sample implementation using the in-tree dtc in the linux kernel can
be found at [1] and the very first rfc at [2].

[1] http://comments.gmane.org/gmane.linux.drivers.devicetree/62357
[2] http://comments.gmane.org/gmane.linux.drivers.devicetree/60145

 checks.c     |  2 ++
 dtc-lexer.l  |  7 +++++++
 dtc-parser.y |  5 +++++
 dtc.h        |  4 ++++
 flattree.c   |  3 +++
 livetree.c   | 14 ++++++++++++++
 6 files changed, 35 insertions(+)

diff --git a/checks.c b/checks.c
index 47eda65..a82ba8d 100644
--- a/checks.c
+++ b/checks.c
@@ -472,6 +472,8 @@ static void fixup_phandle_references(struct check *c, struct node *dt,
 
 		phandle = get_node_phandle(dt, refnode);
 		*((cell_t *)(prop->val.val + m->offset)) = cpu_to_fdt32(phandle);
+
+		reference_node(refnode);
 	}
 }
 ERROR(phandle_references, NULL, NULL, fixup_phandle_references, NULL,
diff --git a/dtc-lexer.l b/dtc-lexer.l
index 0821bde..6d7865d 100644
--- a/dtc-lexer.l
+++ b/dtc-lexer.l
@@ -140,6 +140,13 @@ static void lexical_error(const char *fmt, ...);
 			return DT_DEL_NODE;
 		}
 
+<*>"/delete-unreferenced/"	{
+			DPRINT("Keyword: /delete-unreferenced/\n");
+			DPRINT("<PROPNODENAME>\n");
+			BEGIN(PROPNODENAME);
+			return DT_DEL_UNREFERENCED;
+		}
+
 <*>{LABEL}:	{
 			DPRINT("Label: %s\n", yytext);
 			yylval.labelref = xstrdup(yytext);
diff --git a/dtc-parser.y b/dtc-parser.y
index ea57e0a..a203bed 100644
--- a/dtc-parser.y
+++ b/dtc-parser.y
@@ -60,6 +60,7 @@ extern bool treesource_error;
 %token DT_BITS
 %token DT_DEL_PROP
 %token DT_DEL_NODE
+%token DT_DEL_UNREFERENCED
 %token <propnodename> DT_PROPNODENAME
 %token <integer> DT_LITERAL
 %token <integer> DT_CHAR_LITERAL
@@ -450,6 +451,10 @@ subnode:
 		{
 			$$ = name_node(build_node_delete(), $2);
 		}
+	| DT_DEL_UNREFERENCED subnode
+		{
+			$$ = check_node_referenced($2);
+		}
 	| DT_LABEL subnode
 		{
 			add_label(&$2->labels, $1);
diff --git a/dtc.h b/dtc.h
index 20de073..ff45059 100644
--- a/dtc.h
+++ b/dtc.h
@@ -158,6 +158,8 @@ struct node {
 	int addr_cells, size_cells;
 
 	struct label *labels;
+
+	int needs_reference, is_referenced;
 };
 
 #define for_each_label_withdel(l0, l) \
@@ -192,6 +194,8 @@ struct property *reverse_properties(struct property *first);
 struct node *build_node(struct property *proplist, struct node *children);
 struct node *build_node_delete(void);
 struct node *name_node(struct node *node, char *name);
+struct node *check_node_referenced(struct node *node);
+struct node *reference_node(struct node *node);
 struct node *chain_node(struct node *first, struct node *list);
 struct node *merge_nodes(struct node *old_node, struct node *new_node);
 
diff --git a/flattree.c b/flattree.c
index bd99fa2..105e8fa 100644
--- a/flattree.c
+++ b/flattree.c
@@ -266,6 +266,9 @@ static void flatten_tree(struct node *tree, struct emitter *emit,
 	if (tree->deleted)
 		return;
 
+	if (tree->needs_reference && !tree->is_referenced)
+		return;
+
 	emit->beginnode(etarget, tree->labels);
 
 	if (vi->flags & FTF_FULLPATH)
diff --git a/livetree.c b/livetree.c
index b61465f..98bb33d 100644
--- a/livetree.c
+++ b/livetree.c
@@ -134,6 +134,20 @@ struct node *name_node(struct node *node, char *name)
 	return node;
 }
 
+struct node *check_node_referenced(struct node *node)
+{
+	node->needs_reference = 1;
+
+	return node;
+}
+
+struct node *reference_node(struct node *node)
+{
+	node->is_referenced = 1;
+
+	return node;
+}
+
 struct node *merge_nodes(struct node *old_node, struct node *new_node)
 {
 	struct property *new_prop, *old_prop;
-- 
1.9.0
