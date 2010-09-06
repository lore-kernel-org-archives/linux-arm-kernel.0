From: m.nazarewicz@samsung.com (Michal Nazarewicz)
Date: Mon, 06 Sep 2010 08:33:51 +0200
Subject: [RFCv5 1/9] lib: rbtree: rb_root_init() function added
In-Reply-To: <cover.1283749231.git.mina86@mina86.com>
References: <cover.1283749231.git.mina86@mina86.com>
Message-ID: <77e08b611d45c8b830d59a7d111105d3a597fc5c.1283749231.git.mina86@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added a rb_root_init() function which initialises a rb_root
structure as a red-black tree with at most one element.  The
rationale is that using rb_root_init(root, node) is more
straightforward and cleaner then first initialising and
empty tree followed by an insert operation.

Signed-off-by: Michal Nazarewicz <m.nazarewicz@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 include/linux/rbtree.h |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index 7066acb..5b6dc66 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -130,6 +130,17 @@ static inline void rb_set_color(struct rb_node *rb, int color)
 }
 
 #define RB_ROOT	(struct rb_root) { NULL, }
+
+static inline void rb_root_init(struct rb_root *root, struct rb_node *node)
+{
+	root->rb_node = node;
+	if (node) {
+		node->rb_parent_color = RB_BLACK; /* black, no parent */
+		node->rb_left  = NULL;
+		node->rb_right = NULL;
+	}
+}
+
 #define	rb_entry(ptr, type, member) container_of(ptr, type, member)
 
 #define RB_EMPTY_ROOT(root)	((root)->rb_node == NULL)
-- 
1.7.1
