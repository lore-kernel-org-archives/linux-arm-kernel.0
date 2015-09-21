From: emilio.lopez@collabora.co.uk (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 21 Sep 2015 10:38:20 -0300
Subject: [PATCH 1/4] sysfs: Support is_visible() on binary attributes
In-Reply-To: <1442842703-5309-1-git-send-email-emilio.lopez@collabora.co.uk>
References: <1442842703-5309-1-git-send-email-emilio.lopez@collabora.co.uk>
Message-ID: <1442842703-5309-2-git-send-email-emilio.lopez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the sysfs header file:

    "The returned value will replace static permissions defined in
     struct attribute or struct bin_attribute."

but this isn't the case, as is_visible is only called on struct attribute
only. This patch introduces a new is_bin_visible() function to implement
the same functionality for binary attributes, and updates documentation
accordingly.

Note that to keep functionality and code similar to that of normal
attributes, the mode is now checked as well to ensure it contains only
read/write permissions or SYSFS_PREALLOC.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Emilio L?pez <emilio.lopez@collabora.co.uk>
---

Changes from v1:
 - Don't overload is_visible, introduce is_bin_visible instead as
   discussed on the list.

Changes from v2:
 - Note change in mode checking on the commit log
 - Add Guenter's reviewed-by

 fs/sysfs/group.c      | 17 +++++++++++++++--
 include/linux/sysfs.h | 18 ++++++++++++++----
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 39a0199..51b56e6 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -73,13 +73,26 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 	}
 
 	if (grp->bin_attrs) {
-		for (bin_attr = grp->bin_attrs; *bin_attr; bin_attr++) {
+		for (i = 0, bin_attr = grp->bin_attrs; *bin_attr; i++, bin_attr++) {
+			umode_t mode = (*bin_attr)->attr.mode;
+
 			if (update)
 				kernfs_remove_by_name(parent,
 						(*bin_attr)->attr.name);
+			if (grp->is_bin_visible) {
+				mode = grp->is_bin_visible(kobj, *bin_attr, i);
+				if (!mode)
+					continue;
+			}
+
+			WARN(mode & ~(SYSFS_PREALLOC | 0664),
+			     "Attribute %s: Invalid permissions 0%o\n",
+			     (*bin_attr)->attr.name, mode);
+
+			mode &= SYSFS_PREALLOC | 0664;
 			error = sysfs_add_file_mode_ns(parent,
 					&(*bin_attr)->attr, true,
-					(*bin_attr)->attr.mode, NULL);
+					mode, NULL);
 			if (error)
 				break;
 		}
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 9f65758..2f66050 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -64,10 +64,18 @@ do {							\
  *		a new subdirectory with this name.
  * @is_visible:	Optional: Function to return permissions associated with an
  *		attribute of the group. Will be called repeatedly for each
- *		attribute in the group. Only read/write permissions as well as
- *		SYSFS_PREALLOC are accepted. Must return 0 if an attribute is
- *		not visible. The returned value will replace static permissions
- *		defined in struct attribute or struct bin_attribute.
+ *		non-binary attribute in the group. Only read/write
+ *		permissions as well as SYSFS_PREALLOC are accepted. Must
+ *		return 0 if an attribute is not visible. The returned value
+ *		will replace static permissions defined in struct attribute.
+ * @is_bin_visible:
+ *		Optional: Function to return permissions associated with a
+ *		binary attribute of the group. Will be called repeatedly
+ *		for each binary attribute in the group. Only read/write
+ *		permissions as well as SYSFS_PREALLOC are accepted. Must
+ *		return 0 if a binary attribute is not visible. The returned
+ *		value will replace static permissions defined in
+ *		struct bin_attribute.
  * @attrs:	Pointer to NULL terminated list of attributes.
  * @bin_attrs:	Pointer to NULL terminated list of binary attributes.
  *		Either attrs or bin_attrs or both must be provided.
@@ -76,6 +84,8 @@ struct attribute_group {
 	const char		*name;
 	umode_t			(*is_visible)(struct kobject *,
 					      struct attribute *, int);
+	umode_t			(*is_bin_visible)(struct kobject *,
+						  struct bin_attribute *, int);
 	struct attribute	**attrs;
 	struct bin_attribute	**bin_attrs;
 };
-- 
2.1.4
