From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 18 Feb 2014 15:16:27 +0100
Subject: [PATCH 1/3] dtc: add ability to make nodes conditional on them being
 referenced
In-Reply-To: <10555869.uLtJmrqZh3@phil>
References: <10555869.uLtJmrqZh3@phil>
Message-ID: <1925873.9q11eLaP7L@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Heiko Stuebner <heiko.stuebner@bqreaders.com>

On i.MX, which carries a lot of pin-groups of which most are unused on
individual boards, they noticed that this plethora of nodes also results
in the runtime-lookup-performance also degrading [0].

A i.MX-specific solution defining the pingroups in the board files but
using macros to reference the pingroup-data was not well received

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

Signed-off-by: Heiko Stuebner <heiko.stuebner@bqreaders.com>
---
 scripts/dtc/checks.c     |  2 ++
 scripts/dtc/dtc-lexer.l  |  7 +++++++
 scripts/dtc/dtc-parser.y |  5 +++++
 scripts/dtc/dtc.h        |  4 ++++
 scripts/dtc/flattree.c   |  3 +++
 scripts/dtc/livetree.c   | 14 ++++++++++++++
 6 files changed, 35 insertions(+)

diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
index ee96a25..747ada8 100644
--- a/scripts/dtc/checks.c
+++ b/scripts/dtc/checks.c
@@ -472,6 +472,8 @@ static void fixup_phandle_references(struct check *c, struct node *dt,
 
 		phandle = get_node_phandle(dt, refnode);
 		*((cell_t *)(prop->val.val + m->offset)) = cpu_to_fdt32(phandle);
+
+		reference_node(refnode);
 	}
 }
 ERROR(phandle_references, NULL, NULL, fixup_phandle_references, NULL,
diff --git a/scripts/dtc/dtc-lexer.l b/scripts/dtc/dtc-lexer.l
index 3b41bfc..3b18e97 100644
--- a/scripts/dtc/dtc-lexer.l
+++ b/scripts/dtc/dtc-lexer.l
@@ -138,6 +138,13 @@ static int pop_input_file(void);
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
diff --git a/scripts/dtc/dtc-parser.y b/scripts/dtc/dtc-parser.y
index f412460..ae9108b 100644
--- a/scripts/dtc/dtc-parser.y
+++ b/scripts/dtc/dtc-parser.y
@@ -64,6 +64,7 @@ static unsigned char eval_char_literal(const char *s);
 %token DT_BITS
 %token DT_DEL_PROP
 %token DT_DEL_NODE
+%token DT_DEL_UNREFERENCED
 %token <propnodename> DT_PROPNODENAME
 %token <literal> DT_LITERAL
 %token <literal> DT_CHAR_LITERAL
@@ -461,6 +462,10 @@ subnode:
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
diff --git a/scripts/dtc/dtc.h b/scripts/dtc/dtc.h
index 264a20c..289c62b 100644
--- a/scripts/dtc/dtc.h
+++ b/scripts/dtc/dtc.h
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
 
diff --git a/scripts/dtc/flattree.c b/scripts/dtc/flattree.c
index 665dad7..a327592 100644
--- a/scripts/dtc/flattree.c
+++ b/scripts/dtc/flattree.c
@@ -266,6 +266,9 @@ static void flatten_tree(struct node *tree, struct emitter *emit,
 	if (tree->deleted)
 		return;
 
+	if (tree->needs_reference && !tree->is_referenced)
+		return;
+
 	emit->beginnode(etarget, tree->labels);
 
 	if (vi->flags & FTF_FULLPATH)
diff --git a/scripts/dtc/livetree.c b/scripts/dtc/livetree.c
index b61465f..98bb33d 100644
--- a/scripts/dtc/livetree.c
+++ b/scripts/dtc/livetree.c
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
1.8.5.3
