From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 14 Jan 2016 13:33:06 +0900
Subject: [PATCH] of: drop symbols declared by _OF_DECLARE() from modules
Message-ID: <1452745987-22146-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The users of this macro (OF_EARLYCON_DECLARE, CLK_OF_DECLARE,
IRQCHIP_DECLARE, etc.) are only parsed in the early boot stage.

Such symbols contained in modules are never used.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

OF_EARLYCON_DECLARE() is declared in several tristate drivers.

This patch makes each low-level driver be free from
taking care of it.

See this patch
https://patchwork.kernel.org/patch/8028771/


 include/linux/of.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index dd10626..dc6e396 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -929,7 +929,7 @@ static inline int of_get_available_child_count(const struct device_node *np)
 	return num;
 }
 
-#ifdef CONFIG_OF
+#if defined(CONFIG_OF) && !defined(MODULE)
 #define _OF_DECLARE(table, name, compat, fn, fn_type)			\
 	static const struct of_device_id __of_table_##name		\
 		__used __section(__##table##_of_table)			\
-- 
1.9.1
