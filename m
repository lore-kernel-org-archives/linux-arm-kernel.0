From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 22 Mar 2016 18:58:27 +0100
Subject: [PATCH 4/6] of: Introduce of_for_each_phandle() helper macro
In-Reply-To: <1458669509-7178-1-git-send-email-joro@8bytes.org>
References: <1458669509-7178-1-git-send-email-joro@8bytes.org>
Message-ID: <1458669509-7178-5-git-send-email-joro@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joerg Roedel <jroedel@suse.de>

With this macro any user can easily iterate over a list of
phandles. The patch also converts __of_parse_phandle_with_args()
to make use of the macro.

The of_count_phandle_with_args() function is not converted,
because the macro hides the return value of of_phandle_iterator_init(),
which is needed in there.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/of/base.c  | 7 +------
 include/linux/of.h | 6 ++++++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 15593cd..471d3d9 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1542,13 +1542,8 @@ static int __of_parse_phandle_with_args(const struct device_node *np,
 	struct of_phandle_iterator it;
 	int rc, cur_index = 0;
 
-	rc = of_phandle_iterator_init(&it, np, list_name,
-				      cells_name, cell_count);
-	if (rc)
-		return rc;
-
 	/* Loop over the phandles until all the requested entry is found */
-	while ((rc = of_phandle_iterator_next(&it)) == 0) {
+	of_for_each_phandle(&it, rc, np, list_name, cells_name, cell_count) {
 		/*
 		 * All of the error cases bail out of the loop, so at
 		 * this point, the parsing is successful. If the requested
diff --git a/include/linux/of.h b/include/linux/of.h
index d94388b0..05e38ed 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -908,6 +908,12 @@ static inline int of_property_read_s32(const struct device_node *np,
 	return of_property_read_u32(np, propname, (u32*) out_value);
 }
 
+#define of_for_each_phandle(it, err, np, ln, cn, cc)			\
+	for (of_phandle_iterator_init((it), (np), (ln), (cn), (cc)),	\
+	     err = of_phandle_iterator_next(it);			\
+	     err == 0;							\
+	     err = of_phandle_iterator_next(it))
+
 #define of_property_for_each_u32(np, propname, prop, p, u)	\
 	for (prop = of_find_property(np, propname, NULL),	\
 		p = of_prop_next_u32(prop, NULL, &u);		\
-- 
1.9.1
