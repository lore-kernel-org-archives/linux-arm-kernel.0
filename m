From: arnd@arndb.de (Arnd Bergmann)
Date: Mon,  2 May 2016 12:59:19 +0200
Subject: [PATCH] of: include errno.h in of_graph.h
Message-ID: <1462186769-2205767-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_OF is disabled, we have to include linux/errno.h before
including of_graph.h, or get build errors like in the newly added
sun4i drm driver:

In file included from ../drivers/gpu/drm/sun4i/sun4i_drv.c:14:0:
include/linux/of_graph.h: In function 'of_graph_parse_endpoint':
include/linux/of_graph.h:58:10: error: 'ENOSYS' undeclared (first use in this function)

A better solution is to ensure that the header can be included
by itself, so let's include linux/errno.h here to fix the error
we just got, and any similar future error.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 9026e0d122ac ("drm: Add Allwinner A10 Display Engine support")
---
 include/linux/of_graph.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/of_graph.h b/include/linux/of_graph.h
index f8bcd0e21a26..bb3a5a2cd570 100644
--- a/include/linux/of_graph.h
+++ b/include/linux/of_graph.h
@@ -15,6 +15,7 @@
 #define __LINUX_OF_GRAPH_H
 
 #include <linux/types.h>
+#include <linux/errno.h>
 
 /**
  * struct of_endpoint - the OF graph endpoint data structure
-- 
2.7.0
