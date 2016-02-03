From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  3 Feb 2016 22:59:51 +0100
Subject: [PATCH 1/2] of: always define of_node_cmp() and other functions
Message-ID: <1454536806-3755190-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ti-vpe driver started using of_node_cmp(), and it can
be used when CONFIG_OF is disabled, which results in a
build failure:

drivers/media/platform/ti-vpe/cal.c: In function 'of_get_next_port':
drivers/media/platform/ti-vpe/cal.c:1655:12: error: implicit declaration of function 'of_node_cmp' [-Werror=implicit-function-declaration]

There is no reason for this, we can simply move the definition
outside of the #ifdef CONFIG_OF section without any downsides.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/of.h | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index dc6e39696b64..f8d9b558f9bd 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -128,6 +128,23 @@ extern raw_spinlock_t devtree_lock;
 
 #define OF_BAD_ADDR	((u64)-1)
 
+#if defined(CONFIG_SPARC)
+#include <asm/prom.h>
+#endif
+
+/* Default #address and #size cells.  Allow arch asm/prom.h to override */
+#if !defined(OF_ROOT_NODE_ADDR_CELLS_DEFAULT)
+#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT 1
+#define OF_ROOT_NODE_SIZE_CELLS_DEFAULT 1
+#endif
+
+/* Default string compare functions, Allow arch asm/prom.h to override */
+#if !defined(of_compat_cmp)
+#define of_compat_cmp(s1, s2, l)	strcasecmp((s1), (s2))
+#define of_prop_cmp(s1, s2)		strcmp((s1), (s2))
+#define of_node_cmp(s1, s2)		strcasecmp((s1), (s2))
+#endif
+
 #ifdef CONFIG_OF
 void of_core_init(void);
 
@@ -211,23 +228,6 @@ static inline unsigned long of_read_ulong(const __be32 *cell, int size)
 	return of_read_number(cell, size);
 }
 
-#if defined(CONFIG_SPARC)
-#include <asm/prom.h>
-#endif
-
-/* Default #address and #size cells.  Allow arch asm/prom.h to override */
-#if !defined(OF_ROOT_NODE_ADDR_CELLS_DEFAULT)
-#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT 1
-#define OF_ROOT_NODE_SIZE_CELLS_DEFAULT 1
-#endif
-
-/* Default string compare functions, Allow arch asm/prom.h to override */
-#if !defined(of_compat_cmp)
-#define of_compat_cmp(s1, s2, l)	strcasecmp((s1), (s2))
-#define of_prop_cmp(s1, s2)		strcmp((s1), (s2))
-#define of_node_cmp(s1, s2)		strcasecmp((s1), (s2))
-#endif
-
 #define OF_IS_DYNAMIC(x) test_bit(OF_DYNAMIC, &x->_flags)
 #define OF_MARK_DYNAMIC(x) set_bit(OF_DYNAMIC, &x->_flags)
 
-- 
2.7.0
