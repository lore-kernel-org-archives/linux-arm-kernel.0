From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:14 -0700
Subject: [PATCH 10/46] davinci: enable easy top down traversal of clock tree
In-Reply-To: <1255720190-7452-11-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-4-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-5-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-6-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-7-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-8-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-9-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-10-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-11-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-12-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

Achieve easy top down traversal of clock tree by keeping
track of each clock's list of children.

This is useful in supporting DVFS where clock rates of
all children need to be updated in an efficient manner.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/clock.c |   10 +++++++---
 arch/arm/mach-davinci/clock.h |    2 ++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index 83d54d5..f8c4ef0 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -123,8 +123,12 @@ int clk_register(struct clk *clk)
 			clk->name, clk->parent->name))
 		return -EINVAL;
 
+	INIT_LIST_HEAD(&clk->children);
+
 	mutex_lock(&clocks_mutex);
 	list_add_tail(&clk->node, &clocks);
+	if (clk->parent)
+		list_add_tail(&clk->childnode, &clk->parent->children);
 	mutex_unlock(&clocks_mutex);
 
 	/* If rate is already set, use it */
@@ -146,6 +150,7 @@ void clk_unregister(struct clk *clk)
 
 	mutex_lock(&clocks_mutex);
 	list_del(&clk->node);
+	list_del(&clk->childnode);
 	mutex_unlock(&clocks_mutex);
 }
 EXPORT_SYMBOL(clk_unregister);
@@ -352,9 +357,8 @@ dump_clock(struct seq_file *s, unsigned nest, struct clk *parent)
 	/* REVISIT show device associations too */
 
 	/* cost is now small, but not linear... */
-	list_for_each_entry(clk, &clocks, node) {
-		if (clk->parent == parent)
-			dump_clock(s, nest + NEST_DELTA, clk);
+	list_for_each_entry(clk, &parent->children, childnode) {
+		dump_clock(s, nest + NEST_DELTA, clk);
 	}
 }
 
diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
index 27233cb..f88794d 100644
--- a/arch/arm/mach-davinci/clock.h
+++ b/arch/arm/mach-davinci/clock.h
@@ -69,6 +69,8 @@ struct clk {
 	u8			lpsc;
 	u8			psc_ctlr;
 	struct clk              *parent;
+	struct list_head	children; 	/* list of children */
+	struct list_head	childnode;	/* parent's child list node */
 	struct pll_data         *pll_data;
 	u32                     div_reg;
 };
-- 
1.6.4.3
