From: erin.lo@mediatek.com (Erin Lo)
Date: Tue, 17 May 2016 13:05:02 +0800
Subject: [PATCH v8 01/10] clk: fix initial state of critical clock's parents
In-Reply-To: <1463461511-25019-1-git-send-email-erin.lo@mediatek.com>
References: <1463461511-25019-1-git-send-email-erin.lo@mediatek.com>
Message-ID: <1463461511-25019-2-git-send-email-erin.lo@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: James Liao <jamesjj.liao@mediatek.com>

This patch fixed wrong state of parent clocks if they are registered
after critical clocks.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
 drivers/clk/clk.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index ce39add..bf80e39 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2388,8 +2388,15 @@ static int __clk_core_init(struct clk_core *core)
 	hlist_for_each_entry_safe(orphan, tmp2, &clk_orphan_list, child_node) {
 		struct clk_core *parent = __clk_init_parent(orphan);
 
-		if (parent)
+		if (parent) {
 			clk_core_reparent(orphan, parent);
+
+			if (orphan->prepare_count)
+				clk_core_prepare(parent);
+
+			if (orphan->enable_count)
+				clk_core_enable(parent);
+		}
 	}
 
 	/*
-- 
1.9.1
