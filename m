From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri,  4 Nov 2016 20:43:35 +0900
Subject: [PATCH 2/3] ARM: cache-uniphier: refactor jump label to follow coding
 style guideline
In-Reply-To: <1478259816-24965-1-git-send-email-yamada.masahiro@socionext.com>
References: <1478259816-24965-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1478259816-24965-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Documentation/CodingStyle recommends to use label names which say
what the goto does or why the goto exists.

Just in case, split it up into three labels because the CodingStyle
says "one err bugs" is a common type of bug (although, I do not
believe the current code includes such a bug).

During the refactoring, iounmap(data->op_base) turned out to have no
corresponding bail-out point, so remove it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mm/cache-uniphier.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/cache-uniphier.c b/arch/arm/mm/cache-uniphier.c
index 58f2ddb..c71ab7c 100644
--- a/arch/arm/mm/cache-uniphier.c
+++ b/arch/arm/mm/cache-uniphier.c
@@ -387,21 +387,21 @@ static int __init __uniphier_cache_init(struct device_node *np,
 	if (!data->ctrl_base) {
 		pr_err("L%d: failed to map control register\n", *cache_level);
 		ret = -ENOMEM;
-		goto err;
+		goto free_mem;
 	}
 
 	data->rev_base = of_iomap(np, 1);
 	if (!data->rev_base) {
 		pr_err("L%d: failed to map revision register\n", *cache_level);
 		ret = -ENOMEM;
-		goto err;
+		goto unmap_ctrl;
 	}
 
 	data->op_base = of_iomap(np, 2);
 	if (!data->op_base) {
 		pr_err("L%d: failed to map operation register\n", *cache_level);
 		ret = -ENOMEM;
-		goto err;
+		goto unmap_rev;
 	}
 
 	data->way_ctrl_base = data->ctrl_base + 0xc00;
@@ -451,10 +451,12 @@ static int __init __uniphier_cache_init(struct device_node *np,
 	of_node_put(next_np);
 
 	return ret;
-err:
-	iounmap(data->op_base);
+
+unmap_rev:
 	iounmap(data->rev_base);
+unmap_ctrl:
 	iounmap(data->ctrl_base);
+free_mem:
 	kfree(data);
 
 	return ret;
-- 
1.9.1
