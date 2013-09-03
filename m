From: jiada_wang@mentor.com (jiada_wang at mentor.com)
Date: Tue,  3 Sep 2013 03:52:56 -0700
Subject: [PATCH] gcov: add support to GCC 4.7
In-Reply-To: <1378205576-28467-1-git-send-email-jiada_wang@mentor.com>
References: <1378205576-28467-1-git-send-email-jiada_wang@mentor.com>
Message-ID: <1378205576-28467-2-git-send-email-jiada_wang@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiada Wang <jiada_wang@mentor.com>

from GCC 4.7 gcov infrastrucs have been changed,
add gcc_4_7.c to support GCC 4.7 toolchain.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 kernel/gcov/Makefile   |    2 +-
 kernel/gcov/base.c     |   38 +++++
 kernel/gcov/fs.c       |    6 +
 kernel/gcov/gcc_3_4.c  |  174 +++++++------------
 kernel/gcov/gcc_4_7.c  |  434 ++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/gcov/gcov.h     |  142 ++++++++++------
 kernel/gcov/gcov_3_4.h |   77 +++++++++
 kernel/gcov/gcov_4_7.h |   77 +++++++++
 8 files changed, 787 insertions(+), 163 deletions(-)
 create mode 100644 kernel/gcov/gcc_4_7.c
 create mode 100644 kernel/gcov/gcov_3_4.h
 create mode 100644 kernel/gcov/gcov_4_7.h

diff --git a/kernel/gcov/Makefile b/kernel/gcov/Makefile
index e97ca59..6bfa06a 100644
--- a/kernel/gcov/Makefile
+++ b/kernel/gcov/Makefile
@@ -1,3 +1,3 @@
 ccflags-y := -DSRCTREE='"$(srctree)"' -DOBJTREE='"$(objtree)"'
 
-obj-$(CONFIG_GCOV_KERNEL) := base.o fs.o gcc_3_4.o
+obj-$(CONFIG_GCOV_KERNEL) := base.o fs.o gcc_3_4.o gcc_4_7.o
diff --git a/kernel/gcov/base.c b/kernel/gcov/base.c
index 9b22d03..3258aae 100644
--- a/kernel/gcov/base.c
+++ b/kernel/gcov/base.c
@@ -24,6 +24,18 @@ static struct gcov_info *gcov_info_head;
 static int gcov_events_enabled;
 static DEFINE_MUTEX(gcov_lock);
 
+struct gcov_iterator *(*gcov_iter_new)(struct gcov_info *);
+void (*gcov_iter_free)(struct gcov_iterator *);
+void (*gcov_iter_start)(struct gcov_iterator *);
+int (*gcov_iter_next)(struct gcov_iterator *);
+int (*gcov_iter_write)(struct gcov_iterator *, struct seq_file *);
+struct gcov_info *(*gcov_iter_get_info)(struct gcov_iterator *);
+void (*gcov_info_reset)(struct gcov_info *);
+int (*gcov_info_is_compatible)(struct gcov_info *, struct gcov_info *);
+void (*gcov_info_add)(struct gcov_info *, struct gcov_info *);
+struct gcov_info *(*gcov_info_dup)(struct gcov_info *);
+void (*gcov_info_free)(struct gcov_info *);
+
 /*
  * __gcov_init is called by gcc-generated constructor code for each object
  * file compiled with -fprofile-arcs.
@@ -40,6 +52,32 @@ void __gcov_init(struct gcov_info *info)
 		 * incompatibility reports.
 		 */
 		pr_info("version magic: 0x%x\n", gcov_version);
+		/* depends on GCOV version, fill function pointers */
+		if (gcov_version >= GCOV_VERSION_407) {
+			gcov_iter_free = gcov_iter_free_47;
+			gcov_iter_new = gcov_iter_new_47;
+			gcov_iter_start = gcov_iter_start_47;
+			gcov_iter_next = gcov_iter_next_47;
+			gcov_iter_write = gcov_iter_write_47;
+			gcov_iter_get_info = gcov_iter_get_info_47;
+			gcov_info_reset = gcov_info_reset_47;
+			gcov_info_is_compatible = gcov_info_is_compatible_47;
+			gcov_info_add = gcov_info_add_47;
+			gcov_info_dup = gcov_info_dup_47;
+			gcov_info_free = gcov_info_free_47;
+		} else {
+			gcov_iter_free = gcov_iter_free_34;
+			gcov_iter_new = gcov_iter_new_34;
+			gcov_iter_start = gcov_iter_start_34;
+			gcov_iter_next = gcov_iter_next_34;
+			gcov_iter_write = gcov_iter_write_34;
+			gcov_iter_get_info = gcov_iter_get_info_34;
+			gcov_info_reset = gcov_info_reset_34;
+			gcov_info_is_compatible = gcov_info_is_compatible_34;
+			gcov_info_add = gcov_info_add_34;
+			gcov_info_dup = gcov_info_dup_34;
+			gcov_info_free = gcov_info_free_34;
+		}
 	}
 	/*
 	 * Add new profiling data structure to list and inform event
diff --git a/kernel/gcov/fs.c b/kernel/gcov/fs.c
index 9bd0934..0c661bf 100644
--- a/kernel/gcov/fs.c
+++ b/kernel/gcov/fs.c
@@ -70,6 +70,12 @@ static DEFINE_MUTEX(node_lock);
 /* If non-zero, keep copies of profiling data for unloaded modules. */
 static int gcov_persist = 1;
 
+/* Symbolic links to be created for each profiling data file. */
+const struct gcov_link gcov_link[] = {
+	{ OBJ_TREE, "gcno" },   /* Link to .gcno file in $(objtree). */
+	{ 0, NULL},
+};
+
 static int __init gcov_persist_setup(char *str)
 {
 	unsigned long val;
diff --git a/kernel/gcov/gcc_3_4.c b/kernel/gcov/gcc_3_4.c
index ae5bb42..43da07d 100644
--- a/kernel/gcov/gcc_3_4.c
+++ b/kernel/gcov/gcc_3_4.c
@@ -19,25 +19,19 @@
 #include <linux/string.h>
 #include <linux/seq_file.h>
 #include <linux/vmalloc.h>
-#include "gcov.h"
-
-/* Symbolic links to be created for each profiling data file. */
-const struct gcov_link gcov_link[] = {
-	{ OBJ_TREE, "gcno" },	/* Link to .gcno file in $(objtree). */
-	{ 0, NULL},
-};
+#include "gcov_3_4.h"
 
 /*
  * Determine whether a counter is active. Based on gcc magic. Doesn't change
  * at run-time.
  */
-static int counter_active(struct gcov_info *info, unsigned int type)
+static int counter_active(struct gcov_info_34 *info, unsigned int type)
 {
 	return (1 << type) & info->ctr_mask;
 }
 
 /* Determine number of active counters. Based on gcc magic. */
-static unsigned int num_counter_active(struct gcov_info *info)
+static unsigned int num_counter_active(struct gcov_info_34 *info)
 {
 	unsigned int i;
 	unsigned int result = 0;
@@ -50,54 +44,57 @@ static unsigned int num_counter_active(struct gcov_info *info)
 }
 
 /**
- * gcov_info_reset - reset profiling data to zero
+ * gcov_info_reset_34 - reset profiling data to zero
  * @info: profiling data set
  */
-void gcov_info_reset(struct gcov_info *info)
+void gcov_info_reset_34(struct gcov_info *info)
 {
-	unsigned int active = num_counter_active(info);
+	struct gcov_info_34 *ginfo = (struct gcov_info_34 *)info;
+	unsigned int active = num_counter_active(ginfo);
 	unsigned int i;
 
 	for (i = 0; i < active; i++) {
-		memset(info->counts[i].values, 0,
-		       info->counts[i].num * sizeof(gcov_type));
+		memset(ginfo->counts[i].values, 0,
+		       ginfo->counts[i].num * sizeof(gcov_type));
 	}
 }
 
 /**
- * gcov_info_is_compatible - check if profiling data can be added
+ * gcov_info_is_compatible_34 - check if profiling data can be added
  * @info1: first profiling data set
  * @info2: second profiling data set
  *
  * Returns non-zero if profiling data can be added, zero otherwise.
  */
-int gcov_info_is_compatible(struct gcov_info *info1, struct gcov_info *info2)
+int gcov_info_is_compatible_34(struct gcov_info *info1, struct gcov_info *info2)
 {
 	return (info1->stamp == info2->stamp);
 }
 
 /**
- * gcov_info_add - add up profiling data
+ * gcov_info_add_34 - add up profiling data
  * @dest: profiling data set to which data is added
  * @source: profiling data set which is added
  *
  * Adds profiling counts of @source to @dest.
  */
-void gcov_info_add(struct gcov_info *dest, struct gcov_info *source)
+void gcov_info_add_34(struct gcov_info *dest, struct gcov_info *source)
 {
+	struct gcov_info_34 *gdest = (struct gcov_info_34 *)dest;
+	struct gcov_info_34 *gsource = (struct gcov_info_34 *)source;
 	unsigned int i;
 	unsigned int j;
 
-	for (i = 0; i < num_counter_active(dest); i++) {
-		for (j = 0; j < dest->counts[i].num; j++) {
-			dest->counts[i].values[j] +=
-				source->counts[i].values[j];
+	for (i = 0; i < num_counter_active(gdest); i++) {
+		for (j = 0; j < gdest->counts[i].num; j++) {
+			gdest->counts[i].values[j] +=
+				gsource->counts[i].values[j];
 		}
 	}
 }
 
 /* Get size of function info entry. Based on gcc magic. */
-static size_t get_fn_size(struct gcov_info *info)
+static size_t get_fn_size(struct gcov_info_34 *info)
 {
 	size_t size;
 
@@ -109,46 +106,47 @@ static size_t get_fn_size(struct gcov_info *info)
 }
 
 /* Get address of function info entry. Based on gcc magic. */
-static struct gcov_fn_info *get_fn_info(struct gcov_info *info, unsigned int fn)
+static struct gcov_fn_info *get_fn_info(struct gcov_info_34 *info, unsigned int fn)
 {
 	return (struct gcov_fn_info *)
 		((char *) info->functions + fn * get_fn_size(info));
 }
 
 /**
- * gcov_info_dup - duplicate profiling data set
+ * gcov_info_dup_34 - duplicate profiling data set
  * @info: profiling data set to duplicate
  *
  * Return newly allocated duplicate on success, %NULL on error.
  */
-struct gcov_info *gcov_info_dup(struct gcov_info *info)
+struct gcov_info *gcov_info_dup_34(struct gcov_info *info)
 {
-	struct gcov_info *dup;
+	struct gcov_info_34 *ginfo = (struct gcov_info_34 *)info;
+	struct gcov_info_34 *dup;
 	unsigned int i;
 	unsigned int active;
 
 	/* Duplicate gcov_info. */
-	active = num_counter_active(info);
-	dup = kzalloc(sizeof(struct gcov_info) +
+	active = num_counter_active(ginfo);
+	dup = kzalloc(sizeof(struct gcov_info_34) +
 		      sizeof(struct gcov_ctr_info) * active, GFP_KERNEL);
 	if (!dup)
 		return NULL;
-	dup->version		= info->version;
-	dup->stamp		= info->stamp;
-	dup->n_functions	= info->n_functions;
-	dup->ctr_mask		= info->ctr_mask;
+	dup->version		= ginfo->version;
+	dup->stamp		= ginfo->stamp;
+	dup->n_functions	= ginfo->n_functions;
+	dup->ctr_mask		= ginfo->ctr_mask;
 	/* Duplicate filename. */
-	dup->filename		= kstrdup(info->filename, GFP_KERNEL);
+	dup->filename		= kstrdup(ginfo->filename, GFP_KERNEL);
 	if (!dup->filename)
 		goto err_free;
 	/* Duplicate table of functions. */
-	dup->functions = kmemdup(info->functions, info->n_functions *
-				 get_fn_size(info), GFP_KERNEL);
+	dup->functions = kmemdup(ginfo->functions, ginfo->n_functions *
+				 get_fn_size(ginfo), GFP_KERNEL);
 	if (!dup->functions)
 		goto err_free;
 	/* Duplicate counter arrays. */
 	for (i = 0; i < active ; i++) {
-		struct gcov_ctr_info *ctr = &info->counts[i];
+		struct gcov_ctr_info *ctr = &ginfo->counts[i];
 		size_t size = ctr->num * sizeof(gcov_type);
 
 		dup->counts[i].num = ctr->num;
@@ -158,79 +156,33 @@ struct gcov_info *gcov_info_dup(struct gcov_info *info)
 			goto err_free;
 		memcpy(dup->counts[i].values, ctr->values, size);
 	}
-	return dup;
+	return (struct gcov_info *)dup;
 
 err_free:
-	gcov_info_free(dup);
+	gcov_info_free_34((struct gcov_info *)dup);
 	return NULL;
 }
 
 /**
- * gcov_info_free - release memory for profiling data set duplicate
+ * gcov_info_free_34 - release memory for profiling data set duplicate
  * @info: profiling data set duplicate to free
  */
-void gcov_info_free(struct gcov_info *info)
+void gcov_info_free_34(struct gcov_info *info)
 {
-	unsigned int active = num_counter_active(info);
+	struct gcov_info_34 *ginfo = (struct gcov_info_34 *)info;
+	unsigned int active = num_counter_active(ginfo);
 	unsigned int i;
 
 	for (i = 0; i < active ; i++)
-		vfree(info->counts[i].values);
-	kfree(info->functions);
-	kfree(info->filename);
-	kfree(info);
+		vfree(ginfo->counts[i].values);
+	kfree(ginfo->functions);
+	kfree(ginfo->filename);
+	kfree(ginfo);
 }
 
-/**
- * struct type_info - iterator helper array
- * @ctr_type: counter type
- * @offset: index of the first value of the current function for this type
- *
- * This array is needed to convert the in-memory data format into the in-file
- * data format:
- *
- * In-memory:
- *   for each counter type
- *     for each function
- *       values
- *
- * In-file:
- *   for each function
- *     for each counter type
- *       values
- *
- * See gcc source gcc/gcov-io.h for more information on data organization.
- */
-struct type_info {
-	int ctr_type;
-	unsigned int offset;
-};
-
-/**
- * struct gcov_iterator - specifies current file position in logical records
- * @info: associated profiling data
- * @record: record type
- * @function: function number
- * @type: counter type
- * @count: index into values array
- * @num_types: number of counter types
- * @type_info: helper array to get values-array offset for current function
- */
-struct gcov_iterator {
-	struct gcov_info *info;
-
-	int record;
-	unsigned int function;
-	unsigned int type;
-	unsigned int count;
-
-	int num_types;
-	struct type_info type_info[0];
-};
-
 static struct gcov_fn_info *get_func(struct gcov_iterator *iter)
 {
-	return get_fn_info(iter->info, iter->function);
+	return get_fn_info((struct gcov_info_34 *)iter->info, iter->function);
 }
 
 static struct type_info *get_type(struct gcov_iterator *iter)
@@ -239,17 +191,18 @@ static struct type_info *get_type(struct gcov_iterator *iter)
 }
 
 /**
- * gcov_iter_new - allocate and initialize profiling data iterator
+ * gcov_iter_new_34 - allocate and initialize profiling data iterator
  * @info: profiling data set to be iterated
  *
  * Return file iterator on success, %NULL otherwise.
  */
-struct gcov_iterator *gcov_iter_new(struct gcov_info *info)
+struct gcov_iterator *gcov_iter_new_34(struct gcov_info *info)
 {
+	struct gcov_info_34 *ginfo = (struct gcov_info_34 *)info;
 	struct gcov_iterator *iter;
 
 	iter = kzalloc(sizeof(struct gcov_iterator) +
-		       num_counter_active(info) * sizeof(struct type_info),
+		       num_counter_active(ginfo) * sizeof(struct type_info),
 		       GFP_KERNEL);
 	if (iter)
 		iter->info = info;
@@ -258,28 +211,28 @@ struct gcov_iterator *gcov_iter_new(struct gcov_info *info)
 }
 
 /**
- * gcov_iter_free - release memory for iterator
+ * gcov_iter_free_34 - release memory for iterator
  * @iter: file iterator to free
  */
-void gcov_iter_free(struct gcov_iterator *iter)
+void gcov_iter_free_34(struct gcov_iterator *iter)
 {
 	kfree(iter);
 }
 
 /**
- * gcov_iter_get_info - return profiling data set for given file iterator
+ * gcov_iter_get_info_34 - return profiling data set for given file iterator
  * @iter: file iterator
  */
-struct gcov_info *gcov_iter_get_info(struct gcov_iterator *iter)
+struct gcov_info *gcov_iter_get_info_34(struct gcov_iterator *iter)
 {
 	return iter->info;
 }
 
 /**
- * gcov_iter_start - reset file iterator to starting position
+ * gcov_iter_start_34 - reset file iterator to starting position
  * @iter: file iterator
  */
-void gcov_iter_start(struct gcov_iterator *iter)
+void gcov_iter_start_34(struct gcov_iterator *iter)
 {
 	int i;
 
@@ -289,7 +242,7 @@ void gcov_iter_start(struct gcov_iterator *iter)
 	iter->count = 0;
 	iter->num_types = 0;
 	for (i = 0; i < GCOV_COUNTERS; i++) {
-		if (counter_active(iter->info, i)) {
+		if (counter_active((struct gcov_info_34 *)iter->info, i)) {
 			iter->type_info[iter->num_types].ctr_type = i;
 			iter->type_info[iter->num_types++].offset = 0;
 		}
@@ -309,12 +262,12 @@ void gcov_iter_start(struct gcov_iterator *iter)
 #define RECORD_COUNT		9
 
 /**
- * gcov_iter_next - advance file iterator to next logical record
+ * gcov_iter_next_34 - advance file iterator to next logical record
  * @iter: file iterator
  *
  * Return zero if new position is valid, non-zero if iterator has reached end.
  */
-int gcov_iter_next(struct gcov_iterator *iter)
+int gcov_iter_next_34(struct gcov_iterator *iter)
 {
 	switch (iter->record) {
 	case RECORD_FILE_MAGIC:
@@ -350,7 +303,8 @@ int gcov_iter_next(struct gcov_iterator *iter)
 		iter->function++;
 		/* fall through */
 	case RECORD_TIME_STAMP:
-		if (iter->function < iter->info->n_functions)
+		if (iter->function <
+		    ((struct gcov_info_34 *)iter->info)->n_functions)
 			iter->record = 3;
 		else
 			iter->record = -1;
@@ -397,13 +351,13 @@ static int seq_write_gcov_u64(struct seq_file *seq, u64 v)
 }
 
 /**
- * gcov_iter_write - write data for current pos to seq_file
+ * gcov_iter_write_34 - write data for current pos to seq_file
  * @iter: file iterator
  * @seq: seq_file handle
  *
  * Return zero on success, non-zero otherwise.
  */
-int gcov_iter_write(struct gcov_iterator *iter, struct seq_file *seq)
+int gcov_iter_write_34(struct gcov_iterator *iter, struct seq_file *seq)
 {
 	int rc = -EINVAL;
 
@@ -439,7 +393,7 @@ int gcov_iter_write(struct gcov_iterator *iter, struct seq_file *seq)
 		break;
 	case RECORD_COUNT:
 		rc = seq_write_gcov_u64(seq,
-			iter->info->counts[iter->type].
+			((struct gcov_info_34 *)iter->info)->counts[iter->type].
 				values[iter->count + get_type(iter)->offset]);
 		break;
 	}
diff --git a/kernel/gcov/gcc_4_7.c b/kernel/gcov/gcc_4_7.c
new file mode 100644
index 0000000..b218d75
--- /dev/null
+++ b/kernel/gcov/gcc_4_7.c
@@ -0,0 +1,434 @@
+/*
+ *  This code provides functions to handle gcc's profiling data format
+ *  introduced with gcc 3.4. Future versions of gcc may change the gcov
+ *  format (as happened before), so all format-specific information needs
+ *  to be kept modular and easily exchangeable.
+ *
+ *  This file is based on gcc-internal definitions. Functions and data
+ *  structures are defined to be compatible with gcc counterparts.
+ *  For a better understanding, refer to gcc source: gcc/gcov-io.h.
+ *
+ *    Copyright Mentor Graphics Corp. 2013
+ *    Author(s): Jiada Wang <jiada_wang@mentor.com>
+ *
+ *    Uses gcc-internal data definitions.
+ */
+
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/seq_file.h>
+#include <linux/vmalloc.h>
+#include "gcov_4_7.h"
+
+/*
+ * Determine whether a counter is active. Based on gcc magic. Doesn't change
+ * at run-time.
+ */
+static int counter_active(struct gcov_info_47 *info, unsigned int type)
+{
+	return info->merge[type] != NULL;
+}
+
+/* Determine number of active counters. Based on gcc magic. */
+static unsigned int num_counter_active(struct gcov_info_47 *info)
+{
+	unsigned int i;
+	unsigned int result = 0;
+
+	for (i = 0; i < GCOV_COUNTERS; i++) {
+		if (counter_active(info, i))
+			result++;
+	}
+	return result;
+}
+
+/**
+ * gcov_info_reset_47 - reset profiling data to zero
+ * @info: profiling data set
+ */
+void gcov_info_reset_47(struct gcov_info *info)
+{
+	struct gcov_info_47 *ginfo = (struct gcov_info_47 *)info;
+	unsigned int active = num_counter_active(ginfo);
+	unsigned int i, j;
+
+	for (i = 0; i < ginfo->n_functions; i++) {
+		for (j = 0; j < active; j++) {
+			memset(ginfo->functions[i]->ctrs[j].values, 0,
+			       ginfo->functions[i]->ctrs[j].num *
+			       sizeof(gcov_type));
+		}
+	}
+}
+
+/**
+ * gcov_info_is_compatible_47 - check if profiling data can be added
+ * @info1: first profiling data set
+ * @info2: second profiling data set
+ *
+ * Returns non-zero if profiling data can be added, zero otherwise.
+ */
+int gcov_info_is_compatible_47(struct gcov_info *info1, struct gcov_info *info2)
+{
+	return (info1->stamp == info2->stamp);
+}
+
+/**
+ * gcov_info_add_47 - add up profiling data
+ * @dest: profiling data set to which data is added
+ * @source: profiling data set which is added
+ *
+ * Adds profiling counts of @source to @dest.
+ */
+void gcov_info_add_47(struct gcov_info *dest, struct gcov_info *source)
+{
+	struct gcov_info_47 *gdest = (struct gcov_info_47 *)dest;
+	struct gcov_info_47 *gsource = (struct gcov_info_47 *)source;
+	unsigned int i, j, k;
+
+	for (i = 0; i < gdest->n_functions; i++) {
+		for (j = 0; j < num_counter_active(gdest); j++) {
+			for (k = 0; k < gdest->functions[i]->ctrs[j].num; k++) {
+				gdest->functions[i]->ctrs[j].values[k] +=
+				gsource->functions[i]->ctrs[j].values[k];
+			}
+		}
+	}
+}
+
+/* Get size of function info entry. Based on gcc magic. */
+static size_t get_fn_size(struct gcov_info_47 *info)
+{
+	size_t size;
+
+	size = sizeof(struct gcov_fn_info) + num_counter_active(info) *
+	       sizeof(struct gcov_ctr_info);
+	if (__alignof__(struct gcov_fn_info) > sizeof(struct gcov_ctr_info))
+		size = ALIGN(size, __alignof__(struct gcov_fn_info));
+	return size;
+}
+
+/* Get address of function info entry. Based on gcc magic. */
+static struct gcov_fn_info *get_fn_info(struct gcov_info_47 *info,
+					   unsigned int fn)
+{
+	return (struct gcov_fn_info *)
+		((char *) info->functions[fn]);
+}
+
+/**
+ * gcov_info_dup_47 - duplicate profiling data set
+ * @info: profiling data set to duplicate
+ *
+ * Return newly allocated duplicate on success, %NULL on error.
+ */
+struct gcov_info *gcov_info_dup_47(struct gcov_info *info)
+{
+	struct gcov_info_47 *ginfo = (struct gcov_info_47 *)info;
+	struct gcov_info_47 *dup;
+	unsigned int i, j;
+	unsigned int active;
+	size_t fn_size = 0;
+
+	/* Duplicate gcov_info. */
+	active = num_counter_active(ginfo);
+	dup = kzalloc(sizeof(struct gcov_info_47), GFP_KERNEL);
+	if (!dup)
+		return NULL;
+	dup->version		= ginfo->version;
+	dup->stamp		= ginfo->stamp;
+	dup->n_functions	= ginfo->n_functions;
+	/* Duplicate filename. */
+	dup->filename		= kstrdup(ginfo->filename, GFP_KERNEL);
+	if (!dup->filename)
+		goto err_free;
+
+	for (i = 0; i < GCOV_COUNTERS; i++)
+		dup->merge[i] = ginfo->merge[i];
+
+	/* Duplicate table of functions. */
+	fn_size = get_fn_size(ginfo);
+	dup->functions = vmalloc(ginfo->n_functions *
+				 sizeof(struct gcov_fn_info *));
+	if (!dup->functions)
+		goto err_free;
+
+	for (i = 0; i < ginfo->n_functions; i++) {
+		struct gcov_fn_info *function = ginfo->functions[i];
+		dup->functions[i] = vmalloc(fn_size);
+		if (!dup->functions[i])
+			goto err_free;
+
+		dup->functions[i]->key = dup;
+		dup->functions[i]->ident = function->ident;
+		dup->functions[i]->lineno_checksum = function->lineno_checksum;
+		dup->functions[i]->cfg_checksum = function->cfg_checksum;
+
+		for (j = 0; j < active; j++) {
+			size_t size = function->ctrs[j].num * sizeof(gcov_type);
+			dup->functions[i]->ctrs[j].values = vmalloc(size);
+			if (!dup->functions[i]->ctrs[j].values)
+				goto err_free;
+
+			memcpy(dup->functions[i]->ctrs[j].values,
+			       function->ctrs[j].values, size);
+			dup->functions[i]->ctrs[j].num = function->ctrs[j].num;
+		}
+	}
+
+	return (struct gcov_info *)dup;
+
+err_free:
+	gcov_info_free_47((struct gcov_info *)dup);
+	return NULL;
+}
+
+/**
+ * gcov_info_free_47 - release memory for profiling data set duplicate
+ * @info: profiling data set duplicate to free
+ */
+void gcov_info_free_47(struct gcov_info *info)
+{
+	struct gcov_info_47 *ginfo = (struct gcov_info_47 *)info;
+	unsigned int active = num_counter_active(ginfo);
+	unsigned int i, j;
+
+	for (i = 0; i < ginfo->n_functions; i++) {
+		struct gcov_fn_info *function = get_fn_info(ginfo, i);
+
+		for (j = 0; j < active ; j++)
+			vfree(function->ctrs[j].values);
+
+		vfree(function);
+	}
+
+	vfree(ginfo->functions);
+	kfree(ginfo->filename);
+	kfree(ginfo);
+}
+
+static struct gcov_fn_info *get_func(struct gcov_iterator *iter)
+{
+	return get_fn_info((struct gcov_info_47 *)iter->info, iter->function);
+}
+
+static struct type_info *get_type(struct gcov_iterator *iter)
+{
+	return &iter->type_info[iter->type];
+}
+
+/**
+ * gcov_iter_new_47 - allocate and initialize profiling data iterator
+ * @info: profiling data set to be iterated
+ *
+ * Return file iterator on success, %NULL otherwise.
+ */
+struct gcov_iterator *gcov_iter_new_47(struct gcov_info *info)
+{
+	struct gcov_info_47 *ginfo = (struct gcov_info_47 *)info;
+	struct gcov_iterator *iter;
+
+	iter = kzalloc(sizeof(struct gcov_iterator) +
+		       num_counter_active(ginfo) * sizeof(struct type_info),
+		       GFP_KERNEL);
+	if (iter)
+		iter->info = info;
+
+	return iter;
+}
+
+/**
+ * gcov_iter_free_47 - release memory for iterator
+ * @iter: file iterator to free
+ */
+void gcov_iter_free_47(struct gcov_iterator *iter)
+{
+	kfree(iter);
+}
+
+/**
+ * gcov_iter_get_info_47 - return profiling data set for given file iterator
+ * @iter: file iterator
+ */
+struct gcov_info *gcov_iter_get_info_47(struct gcov_iterator *iter)
+{
+	return iter->info;
+}
+
+/**
+ * gcov_iter_start_47 - reset file iterator to starting position
+ * @iter: file iterator
+ */
+void gcov_iter_start_47(struct gcov_iterator *iter)
+{
+	int i;
+
+	iter->record = 0;
+	iter->function = 0;
+	iter->type = 0;
+	iter->count = 0;
+	iter->num_types = 0;
+	for (i = 0; i < GCOV_COUNTERS; i++) {
+		if (counter_active((struct gcov_info_47 *)iter->info, i)) {
+			iter->type_info[iter->num_types].ctr_type = i;
+			iter->type_info[iter->num_types++].offset = 0;
+		}
+	}
+}
+
+/* Mapping of logical record number to actual file content. */
+#define RECORD_FILE_MAGIC		0
+#define RECORD_GCOV_VERSION		1
+#define RECORD_TIME_STAMP		2
+#define RECORD_FUNCTION_TAG		3
+#define RECORD_FUNCTON_TAG_LEN		4
+#define RECORD_FUNCTION_IDENT		5
+#define RECORD_FUNCTION_CHECK_LINE	6
+#define RECORD_FUNCTION_CHECK_CFG	7
+#define RECORD_COUNT_TAG		8
+#define RECORD_COUNT_LEN		9
+#define RECORD_COUNT			10
+
+/**
+ * gcov_iter_next_47 - advance file iterator to next logical record
+ * @iter: file iterator
+ *
+ * Return zero if new position is valid, non-zero if iterator has reached end.
+ */
+int gcov_iter_next_47(struct gcov_iterator *iter)
+{
+	switch (iter->record) {
+	case RECORD_FILE_MAGIC:
+	case RECORD_GCOV_VERSION:
+	case RECORD_FUNCTION_TAG:
+	case RECORD_FUNCTON_TAG_LEN:
+	case RECORD_FUNCTION_IDENT:
+	case RECORD_FUNCTION_CHECK_LINE:
+	case RECORD_COUNT_TAG:
+		/* Advance to next record */
+		iter->record++;
+		break;
+	case RECORD_COUNT:
+		/* Advance to next count */
+		iter->count++;
+		/* fall through */
+	case RECORD_COUNT_LEN:
+		if (iter->count < get_func(iter)->ctrs[iter->type].num) {
+			iter->record = 10;
+			break;
+		}
+		/* Advance to next counter type */
+
+		get_type(iter)->offset += iter->count;
+		iter->count = 0;
+		iter->type++;
+		/* fall through */
+	case RECORD_FUNCTION_CHECK_CFG:
+		if (iter->type < iter->num_types) {
+			iter->record = 8;
+			break;
+		}
+		/* Advance to next function */
+		iter->type = 0;
+		iter->function++;
+		/* fall through */
+	case RECORD_TIME_STAMP:
+		if (iter->function <
+		    ((struct gcov_info_47 *)iter->info)->n_functions)
+			iter->record = 3;
+		else
+			iter->record = -1;
+		break;
+	}
+	/* Check for EOF. */
+	if (iter->record == -1)
+		return -EINVAL;
+	else
+		return 0;
+}
+
+/**
+ * seq_write_gcov_u32 - write 32 bit number in gcov format to seq_file
+ * @seq: seq_file handle
+ * @v: value to be stored
+ *
+ * Number format defined by gcc: numbers are recorded in the 32 bit
+ * unsigned binary form of the endianness of the machine generating the
+ * file.
+ */
+static int seq_write_gcov_u32(struct seq_file *seq, u32 v)
+{
+	return seq_write(seq, &v, sizeof(v));
+}
+
+/**
+ * seq_write_gcov_u64 - write 64 bit number in gcov format to seq_file
+ * @seq: seq_file handle
+ * @v: value to be stored
+ *
+ * Number format defined by gcc: numbers are recorded in the 32 bit
+ * unsigned binary form of the endianness of the machine generating the
+ * file. 64 bit numbers are stored as two 32 bit numbers, the low part
+ * first.
+ */
+static int seq_write_gcov_u64(struct seq_file *seq, u64 v)
+{
+	u32 data[2];
+
+	data[0] = (v & 0xffffffffUL);
+	data[1] = (v >> 32);
+	return seq_write(seq, data, sizeof(data));
+}
+
+/**
+ * gcov_iter_write_47 - write data for current pos to seq_file
+ * @iter: file iterator
+ * @seq: seq_file handle
+ *
+ * Return zero on success, non-zero otherwise.
+ */
+int gcov_iter_write_47(struct gcov_iterator *iter, struct seq_file *seq)
+{
+	int rc = -EINVAL;
+
+	switch (iter->record) {
+	case RECORD_FILE_MAGIC:
+		rc = seq_write_gcov_u32(seq, GCOV_DATA_MAGIC);
+		break;
+	case RECORD_GCOV_VERSION:
+		rc = seq_write_gcov_u32(seq, iter->info->version);
+		break;
+	case RECORD_TIME_STAMP:
+		rc = seq_write_gcov_u32(seq, iter->info->stamp);
+		break;
+	case RECORD_FUNCTION_TAG:
+		rc = seq_write_gcov_u32(seq, GCOV_TAG_FUNCTION);
+		break;
+	case RECORD_FUNCTON_TAG_LEN:
+		rc = seq_write_gcov_u32(seq, 3);
+		break;
+	case RECORD_FUNCTION_IDENT:
+		rc = seq_write_gcov_u32(seq, get_func(iter)->ident);
+		break;
+	case RECORD_FUNCTION_CHECK_LINE:
+		rc = seq_write_gcov_u32(seq, get_func(iter)->lineno_checksum);
+		break;
+	case RECORD_FUNCTION_CHECK_CFG:
+		rc = seq_write_gcov_u32(seq, get_func(iter)->cfg_checksum);
+		break;
+	case RECORD_COUNT_TAG:
+		rc = seq_write_gcov_u32(seq,
+			GCOV_TAG_FOR_COUNTER(get_type(iter)->ctr_type));
+		break;
+	case RECORD_COUNT_LEN:
+		rc = seq_write_gcov_u32(seq,
+				get_func(iter)->ctrs[iter->type].num * 2);
+		break;
+	case RECORD_COUNT:
+		rc = seq_write_gcov_u64(seq,
+			get_func(iter)->ctrs[iter->type].values[iter->count]);
+		break;
+	}
+	return rc;
+}
diff --git a/kernel/gcov/gcov.h b/kernel/gcov/gcov.h
index 060073e..ca78ae3 100644
--- a/kernel/gcov/gcov.h
+++ b/kernel/gcov/gcov.h
@@ -21,7 +21,7 @@
  * gcc and need to be kept as close to the original definition as possible to
  * remain compatible.
  */
-#define GCOV_COUNTERS		5
+#define GCOV_VERSION_407	((unsigned int) 0x3430372a)
 #define GCOV_DATA_MAGIC		((unsigned int) 0x67636461)
 #define GCOV_TAG_FUNCTION	((unsigned int) 0x01000000)
 #define GCOV_TAG_COUNTER_BASE	((unsigned int) 0x01a10000)
@@ -35,45 +35,11 @@ typedef long long gcov_type;
 #endif
 
 /**
- * struct gcov_fn_info - profiling meta data per function
- * @ident: object file-unique function identifier
- * @checksum: function checksum
- * @n_ctrs: number of values per counter type belonging to this function
- *
- * This data is generated by gcc during compilation and doesn't change
- * at run-time.
- */
-struct gcov_fn_info {
-	unsigned int ident;
-	unsigned int checksum;
-	unsigned int n_ctrs[0];
-};
-
-/**
- * struct gcov_ctr_info - profiling data per counter type
- * @num: number of counter values for this type
- * @values: array of counter values for this type
- * @merge: merge function for counter values of this type (unused)
- *
- * This data is generated by gcc during compilation and doesn't change
- * at run-time with the exception of the values array.
- */
-struct gcov_ctr_info {
-	unsigned int	num;
-	gcov_type	*values;
-	void		(*merge)(gcov_type *, unsigned int);
-};
-
-/**
- * struct gcov_info - profiling data per object file
+ * struct gcov_info - comman part of profiling data per object file for all GCC versions
  * @version: gcov version magic indicating the gcc version used for compilation
  * @next: list head for a singly-linked list
  * @stamp: time stamp
  * @filename: name of the associated gcov data file
- * @n_functions: number of instrumented functions
- * @functions: function data
- * @ctr_mask: mask specifying which counter types are active
- * @counts: counter data per counter type
  *
  * This data is generated by gcc during compilation and doesn't change
  * at run-time with the exception of the next pointer.
@@ -83,10 +49,53 @@ struct gcov_info {
 	struct gcov_info		*next;
 	unsigned int			stamp;
 	const char			*filename;
-	unsigned int			n_functions;
-	const struct gcov_fn_info	*functions;
-	unsigned int			ctr_mask;
-	struct gcov_ctr_info		counts[0];
+};
+
+/**
+ * struct type_info - iterator helper array
+ * @ctr_type: counter type
+ * @offset: index of the first value of the current function for this type
+ *
+ * This array is needed to convert the in-memory data format into the in-file
+ * data format:
+ *
+ * In-memory:
+ *   for each counter type
+ *     for each function
+ *       values
+ *
+ * In-file:
+ *   for each function
+ *     for each counter type
+ *       values
+ *
+ * See gcc source gcc/gcov-io.h for more information on data organization.
+ */
+struct type_info {
+	int ctr_type;
+	unsigned int offset;
+};
+
+/**
+ * struct gcov_iterator - specifies current file position in logical records
+ * @info: associated profiling data
+ * @record: record type
+ * @function: function number
+ * @type: counter type
+ * @count: index into values array
+ * @num_types: number of counter types
+ * @type_info: helper array to get values-array offset for current function
+ */
+struct gcov_iterator {
+	struct gcov_info *info;
+
+	int record;
+	unsigned int function;
+	unsigned int type;
+	unsigned int count;
+
+	int num_types;
+	struct type_info type_info[0];
 };
 
 /* Base interface. */
@@ -100,21 +109,50 @@ void gcov_enable_events(void);
 
 /* Iterator control. */
 struct seq_file;
-struct gcov_iterator;
 
-struct gcov_iterator *gcov_iter_new(struct gcov_info *info);
-void gcov_iter_free(struct gcov_iterator *iter);
-void gcov_iter_start(struct gcov_iterator *iter);
-int gcov_iter_next(struct gcov_iterator *iter);
-int gcov_iter_write(struct gcov_iterator *iter, struct seq_file *seq);
-struct gcov_info *gcov_iter_get_info(struct gcov_iterator *iter);
+extern struct gcov_iterator *(*gcov_iter_new)(struct gcov_info *);
+extern void (*gcov_iter_free)(struct gcov_iterator *);
+extern void (*gcov_iter_start)(struct gcov_iterator *);
+extern int (*gcov_iter_next)(struct gcov_iterator *);
+extern int (*gcov_iter_write)(struct gcov_iterator *, struct seq_file *);
+extern struct gcov_info *(*gcov_iter_get_info)(struct gcov_iterator *);
+
+/* GCC 3.4 Iterator control. */
+struct gcov_iterator *gcov_iter_new_34(struct gcov_info *info);
+void gcov_iter_free_34(struct gcov_iterator *iter);
+void gcov_iter_start_34(struct gcov_iterator *iter);
+int gcov_iter_next_34(struct gcov_iterator *iter);
+int gcov_iter_write_34(struct gcov_iterator *iter, struct seq_file *seq);
+struct gcov_info *gcov_iter_get_info_34(struct gcov_iterator *iter);
+
+/* GCC 4.7 Iterator control. */
+struct gcov_iterator *gcov_iter_new_47(struct gcov_info *info);
+void gcov_iter_free_47(struct gcov_iterator *iter);
+void gcov_iter_start_47(struct gcov_iterator *iter);
+int gcov_iter_next_47(struct gcov_iterator *iter);
+int gcov_iter_write_47(struct gcov_iterator *iter, struct seq_file *seq);
+struct gcov_info *gcov_iter_get_info_47(struct gcov_iterator *iter);
 
 /* gcov_info control. */
-void gcov_info_reset(struct gcov_info *info);
-int gcov_info_is_compatible(struct gcov_info *info1, struct gcov_info *info2);
-void gcov_info_add(struct gcov_info *dest, struct gcov_info *source);
-struct gcov_info *gcov_info_dup(struct gcov_info *info);
-void gcov_info_free(struct gcov_info *info);
+extern void (*gcov_info_reset)(struct gcov_info *);
+extern int (*gcov_info_is_compatible)(struct gcov_info *, struct gcov_info *);
+extern void (*gcov_info_add)(struct gcov_info *, struct gcov_info *);
+extern struct gcov_info *(*gcov_info_dup)(struct gcov_info *);
+extern void (*gcov_info_free)(struct gcov_info *);
+
+/* GCC 3.4 gcov_info control. */
+void gcov_info_reset_34(struct gcov_info *info);
+int gcov_info_is_compatible_34(struct gcov_info *info1, struct gcov_info *info2);
+void gcov_info_add_34(struct gcov_info *dest, struct gcov_info *source);
+struct gcov_info *gcov_info_dup_34(struct gcov_info *info);
+void gcov_info_free_34(struct gcov_info *info);
+
+/* GCC 4.7 gcov_info control. */
+void gcov_info_reset_47(struct gcov_info *info);
+int gcov_info_is_compatible_47(struct gcov_info *info1, struct gcov_info *info2);
+void gcov_info_add_47(struct gcov_info *dest, struct gcov_info *source);
+struct gcov_info *gcov_info_dup_47(struct gcov_info *info);
+void gcov_info_free_47(struct gcov_info *info);
 
 struct gcov_link {
 	enum {
diff --git a/kernel/gcov/gcov_3_4.h b/kernel/gcov/gcov_3_4.h
new file mode 100644
index 0000000..39c51be
--- /dev/null
+++ b/kernel/gcov/gcov_3_4.h
@@ -0,0 +1,77 @@
+/*
+ *  Profiling infrastructure declarations.
+ *
+ *  This file is based on gcc-internal definitions. Data structures are
+ *  defined to be compatible with gcc counterparts. For a better
+ *  understanding, refer to gcc source: gcc/gcov-io.h.
+ *
+ *    Copyright IBM Corp. 2009
+ *    Author(s): Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
+ *
+ *    Uses gcc-internal data definitions.
+ */
+
+#ifndef GCOV_3_4_H
+#define GCOV_3_4_H GCOV_3_4_H
+
+#include <linux/types.h>
+#include "gcov.h"
+
+#define GCOV_COUNTERS		5
+
+/**
+ * struct gcov_fn_info - profiling meta data per function
+ * @ident: object file-unique function identifier
+ * @checksum: function checksum
+ * @n_ctrs: number of values per counter type belonging to this function
+ *
+ * This data is generated by gcc during compilation and doesn't change
+ * at run-time.
+ */
+struct gcov_fn_info {
+	unsigned int ident;
+	unsigned int checksum;
+	unsigned int n_ctrs[0];
+};
+
+/**
+ * struct gcov_ctr_info - profiling data per counter type
+ * @num: number of counter values for this type
+ * @values: array of counter values for this type
+ * @merge: merge function for counter values of this type (unused)
+ *
+ * This data is generated by gcc during compilation and doesn't change
+ * at run-time with the exception of the values array.
+ */
+struct gcov_ctr_info {
+	unsigned int	num;
+	gcov_type	*values;
+	void		(*merge)(gcov_type *, unsigned int);
+};
+
+/**
+ * struct gcov_info_34 - profiling data per object file for gcc before 4.7
+ * @version: gcov version magic indicating the gcc version used for compilation
+ * @next: list head for a singly-linked list
+ * @stamp: time stamp
+ * @filename: name of the associated gcov data file
+ * @n_functions: number of instrumented functions
+ * @functions: function data
+ * @ctr_mask: mask specifying which counter types are active
+ * @counts: counter data per counter type
+ *
+ * This data is generated by gcc during compilation and doesn't change
+ * at run-time with the exception of the next pointer.
+ */
+struct gcov_info_34 {
+	unsigned int			version;
+	struct gcov_info		*next;
+	unsigned int			stamp;
+	const char			*filename;
+	unsigned int			n_functions;
+	const struct gcov_fn_info	*functions;
+	unsigned int			ctr_mask;
+	struct gcov_ctr_info		counts[0];
+};
+
+#endif /* GCOV_3_4_H */
diff --git a/kernel/gcov/gcov_4_7.h b/kernel/gcov/gcov_4_7.h
new file mode 100644
index 0000000..760ab72
--- /dev/null
+++ b/kernel/gcov/gcov_4_7.h
@@ -0,0 +1,77 @@
+/*
+ *  Profiling infrastructure declarations.
+ *
+ *  This file is based on gcc-internal definitions. Data structures are
+ *  defined to be compatible with gcc counterparts. For a better
+ *  understanding, refer to gcc source: gcc/gcov-io.h.
+ *
+ *    Copyright Mentor Graphics Corp. 2013
+ *    Author(s): Jiada Wang <jiada_wang@mentor.com>
+ *
+ *    Uses gcc-internal data definitions.
+ */
+
+#ifndef GCOV_4_7_H
+#define GCOV_4_7_H GCOV_4_7_H
+
+#include <linux/types.h>
+#include "gcov.h"
+
+#define GCOV_COUNTERS		8
+
+/**
+ * struct gcov_ctr_info - profiling data per counter type
+ * @num: number of counter values for this type
+ * @values: array of counter values for this type
+ *
+ * This data is generated by gcc during compilation and doesn't change
+ * at run-time with the exception of the values array.
+ */
+struct gcov_ctr_info {
+	unsigned int	num;
+	gcov_type	*values;
+};
+
+/**
+ * struct gcov_fn_info - profiling meta data per function
+ * @key: comdat key
+ * @ident: object file-unique function identifier
+ * @lineno_checksum: function lineo_checksum
+ * @cfg_checksum: function cfg checksum
+ * @ctrs: instrumented counters
+ *
+ * This data is generated by gcc during compilation and doesn't change
+ * at run-time.
+ */
+struct gcov_fn_info {
+	const struct gcov_info_47 *key;
+	unsigned int ident;
+	unsigned int lineno_checksum;
+	unsigned int cfg_checksum;
+	struct gcov_ctr_info ctrs[0];
+};
+
+/**
+ * struct gcov_info_47 - profiling data per object file for gcc 4.7 and later
+ * @version: gcov version magic indicating the gcc version used for compilation
+ * @next: list head for a singly-linked list
+ * @stamp: time stamp
+ * @filename: name of the associated gcov data file
+ * @merge: merge functions (null for unused)
+ * @n_functions: number of instrumented functions
+ * @functions: pointer to pointers to function information
+ *
+ * This data is generated by gcc during compilation and doesn't change
+ * at run-time with the exception of the next pointer.
+ */
+struct gcov_info_47 {
+	unsigned int                    version;
+	struct gcov_info                *next;
+	unsigned int                    stamp;
+	const char                      *filename;
+	void                            (*merge[GCOV_COUNTERS])(gcov_type *, unsigned int);
+	unsigned int			n_functions;
+	struct gcov_fn_info		**functions;
+};
+
+#endif /* GCOV_4_7_H */
-- 
1.7.9.5
