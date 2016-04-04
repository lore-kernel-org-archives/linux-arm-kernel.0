From: joro@8bytes.org (Joerg Roedel)
Date: Mon,  4 Apr 2016 17:49:21 +0200
Subject: [PATCH 5/6] of: Introduce of_phandle_iterator_args()
In-Reply-To: <1459784962-9808-1-git-send-email-joro@8bytes.org>
References: <1459784962-9808-1-git-send-email-joro@8bytes.org>
Message-ID: <1459784962-9808-6-git-send-email-joro@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joerg Roedel <jroedel@suse.de>

This helper function can be used to copy the arguments of a
phandle to an array.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Acked-by: Rob Herring <robh@kernel.org>
---
 drivers/of/base.c  | 29 +++++++++++++++++++++++------
 include/linux/of.h | 10 ++++++++++
 2 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index ea5a13d..e87e21d 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1534,6 +1534,23 @@ err:
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
@@ -1557,13 +1574,13 @@ static int __of_parse_phandle_with_args(const struct device_node *np,
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
index b0b8071..71e1c35 100644
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
