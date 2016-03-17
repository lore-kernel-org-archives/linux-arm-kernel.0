From: david@lechnology.com (David Lechner)
Date: Wed, 16 Mar 2016 21:26:35 -0500
Subject: [PATCH v2 02/11] ARM: davinci: add set_parent callback for mux clocks
In-Reply-To: <1458181615-27782-1-git-send-email-david@lechnology.com>
References: <1458181615-27782-1-git-send-email-david@lechnology.com>
Message-ID: <1458181615-27782-3-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a set_parent callback that will be used for mux clocks, such as
the USB PHY muxes and the async3 clock domain mux.

Signed-off-by: David Lechner <david@lechnology.com>
---

v2 changes: This is a new patch in v2.


 arch/arm/mach-davinci/clock.c | 17 ++++++++++++++++-
 arch/arm/mach-davinci/clock.h |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index 3424eac6..3143e8b 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -195,6 +195,13 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 		return -EINVAL;
 
 	mutex_lock(&clocks_mutex);
+	if (clk->set_parent) {
+		int ret = clk->set_parent(clk, parent);
+		if (ret) {
+			mutex_unlock(&clocks_mutex);
+			return ret;
+		}
+	}
 	clk->parent = parent;
 	list_del_init(&clk->childnode);
 	list_add(&clk->childnode, &clk->parent->children);
@@ -224,8 +231,16 @@ int clk_register(struct clk *clk)
 
 	mutex_lock(&clocks_mutex);
 	list_add_tail(&clk->node, &clocks);
-	if (clk->parent)
+	if (clk->parent) {
+		if (clk->set_parent) {
+			int ret = clk->set_parent(clk, clk->parent);
+			if (ret) {
+				mutex_unlock(&clocks_mutex);
+				return ret;
+			}
+		}
 		list_add_tail(&clk->childnode, &clk->parent->children);
+	}
 	mutex_unlock(&clocks_mutex);
 
 	/* If rate is already set, use it */
diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
index 1e4e836..e2a5437 100644
--- a/arch/arm/mach-davinci/clock.h
+++ b/arch/arm/mach-davinci/clock.h
@@ -106,6 +106,7 @@ struct clk {
 	int (*reset) (struct clk *clk, bool reset);
 	void (*clk_enable) (struct clk *clk);
 	void (*clk_disable) (struct clk *clk);
+	int (*set_parent) (struct clk *clk, struct clk *parent);
 };
 
 /* Clock flags: SoC-specific flags start at BIT(16) */
-- 
1.9.1
