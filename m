From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Fri, 16 Mar 2012 18:35:43 +0100
Subject: [RFC/PATCH 0/4] pxa: attempt at switch to common clock framework
Message-ID: <1331919343.31118.19.camel@flow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have made an attempt at an initial conversion of PXA clocks to the
common clock framework (http://lkml.org/lkml/2012/3/16/25), and I'd
like to know if somebody is already working on this, or if I am
heading in the general right direction.

Unfortunately, this set still hangs during boot on hx4700 (pxa270),
unless I also disable the calls to __clk_lookup in drivers/clk/clk.c
completely (or apply the patch below). I'll investigate once I get
access to my serial cable and hx4700 charger, but I'd be grateful if
somebody could spot any embarassingly obvious errors.
For pxa25x and pxa3xx, it's compile-tested only.

regards
Philipp

---
 drivers/clk/clk.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c7c3bc5..79b46af 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -336,14 +336,15 @@ static struct clk *__clk_lookup_subtree(const char *name, struct clk *clk)
 	struct hlist_node *tmp;
 
 	if (!strcmp(clk->name, name))
-		return clk;
+		return NULL;
 
+#if 0
 	hlist_for_each_entry(child, tmp, &clk->children, child_node) {
 		ret = __clk_lookup_subtree(name, child);
 		if (ret)
 			return ret;
 	}
-
+#endif
 	return NULL;
 }
 
-- 
1.7.9.1
