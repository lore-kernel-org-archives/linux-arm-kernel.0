From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 22 Mar 2016 18:58:28 +0100
Subject: [PATCH 5/6] of: Introduce of_phandle_iterator_args()
In-Reply-To: <1458669509-7178-1-git-send-email-joro@8bytes.org>
References: <1458669509-7178-1-git-send-email-joro@8bytes.org>
Message-ID: <1458669509-7178-6-git-send-email-joro@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joerg Roedel <jroedel@suse.de>

This helper function can be used to copy the arguments of a
phandle to an array.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/of/base.c  | 29 +++++++++++++++++++++++------
 include/linux/of.h | 10 ++++++++++
 2 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 471d3d9..008988b 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1533,6 +1533,23 @@ err:
 	return -EINVAL;
 }
 
+int of_phandle_iterator_args(struct of_phandle_iterator *it,
+			     uint32_t *args,
+			     int size)
+{
+	int i, count;
+
+	count = it->cur_count;
+
+	if (WARN_ON(size < count))
+		count = size;
+
+	for (i = 0; i < count; i++)
+		args[i] = be32_to_cpup(it->cur++);
+
+	return count;
+}
+
 static int __of_parse_phandle_with_args(const struct device_node *np,
 					const char *list_name,
 					const char *cells_name,
@@ -1556,13 +1573,13 @@ static int __of_parse_phandle_with_args(const struct device_node *np,
 				goto err;
 
 			if (out_args) {
-				int i;
-				if (WARN_ON(it.cur_count > MAX_PHANDLE_ARGS))
-					it.cur_count = MAX_PHANDLE_ARGS;
+				int c;
+
+				c = of_phandle_iterator_args(&it,
+							     out_args->args,
+							     MAX_PHANDLE_ARGS);
 				out_args->np = it.node;
-				out_args->args_count = it.cur_count;
-				for (i = 0; i < it.cur_count; i++)
-					out_args->args[i] = be32_to_cpup(it.cur++);
+				out_args->args_count = c;
 			} else {
 				of_node_put(it.node);
 			}
diff --git a/include/linux/of.h b/include/linux/of.h
index 05e38ed..c91f8b1 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -359,6 +359,9 @@ extern int of_phandle_iterator_init(struct of_phandle_iterator *it,
 				    int cell_count);
 
 extern int of_phandle_iterator_next(struct of_phandle_iterator *it);
+extern int of_phandle_iterator_args(struct of_phandle_iterator *it,
+				    uint32_t *args,
+				    int size);
 
 extern void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align));
 extern int of_alias_get_id(struct device_node *np, const char *stem);
@@ -648,6 +651,13 @@ static inline int of_phandle_iterator_next(struct of_phandle_iterator *it)
 	return -ENOSYS;
 }
 
+static inline int of_phandle_iterator_args(struct of_phandle_iterator *it,
+					   uint32_t *args,
+					   int size)
+{
+	return 0;
+}
+
 static inline int of_alias_get_id(struct device_node *np, const char *stem)
 {
 	return -ENOSYS;
-- 
1.9.1
