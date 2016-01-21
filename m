From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 22 Jan 2016 01:33:51 +0900
Subject: [PATCH v2] of: drop symbols declared by _OF_DECLARE() from modules
Message-ID: <1453394031-16578-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The users of this macro (OF_EARLYCON_DECLARE, CLK_OF_DECLARE,
IRQCHIP_DECLARE, etc.) are only parsed in the early boot stage.
Such symbols contained in modules are never used.

This commit fixes the link error introduced by commit b8d20e06eaad
("serial: 8250_uniphier: add earlycon support"); the combination
of CONFIG_SERIAL_8250_UNIPHIER=m and CONFIG_SERIAL_8250_CONSOLE=y
fails to link:

ERROR: "early_serial8250_setup" [drivers/tty/serial/8250/8250_uniphier.ko] undefined!

Fixes: b8d20e06eaad ("serial: 8250_uniphier: add earlycon support")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---

Changes in v2:
  - Describe the bug fixed by this commit

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
