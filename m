From: rabin@rab.in (Rabin Vincent)
Date: Tue, 23 Nov 2010 21:35:56 +0530
Subject: [PATCH] perf symbols: remove incorrect open-coded container_of()
Message-ID: <mailman.25.1290530293.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At least on ARM, padding is inserted between rb_node and sym in struct
symbol_name_rb_node, causing "((void *)sym) - sizeof(struct rb_node)" to
point inside rb_node rather than to the symbol_name_rb_node.  Fix this
by converting the code to use container_of().

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 tools/perf/util/symbol.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index b39f499..0500895 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -295,7 +295,9 @@ static void symbols__insert_by_name(struct rb_root *self, struct symbol *sym)
 {
 	struct rb_node **p = &self->rb_node;
 	struct rb_node *parent = NULL;
-	struct symbol_name_rb_node *symn = ((void *)sym) - sizeof(*parent), *s;
+	struct symbol_name_rb_node *symn, *s;
+
+	symn = container_of(sym, struct symbol_name_rb_node, sym);
 
 	while (*p != NULL) {
 		parent = *p;
-- 
1.7.2.3
