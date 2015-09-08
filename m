From: emilio.lopez@collabora.co.uk (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Tue,  8 Sep 2015 09:07:44 -0300
Subject: [PATCH 1/3] sysfs: Fix is_visible() support for binary attributes
In-Reply-To: <1441714066-5599-1-git-send-email-emilio.lopez@collabora.co.uk>
References: <1441714066-5599-1-git-send-email-emilio.lopez@collabora.co.uk>
Message-ID: <1441714066-5599-2-git-send-email-emilio.lopez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the sysfs header file:

    "The returned value will replace static permissions defined in
     struct attribute or struct bin_attribute."

but this isn't the case, as is_visible is only called on
struct attribute only. This patch adds the code paths required
to support is_visible() on binary attributes.

Signed-off-by: Emilio L?pez <emilio.lopez@collabora.co.uk>
---
 fs/sysfs/group.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 39a0199..eb6996a 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -37,10 +37,10 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 {
 	struct attribute *const *attr;
 	struct bin_attribute *const *bin_attr;
-	int error = 0, i;
+	int error = 0, i = 0;
 
 	if (grp->attrs) {
-		for (i = 0, attr = grp->attrs; *attr && !error; i++, attr++) {
+		for (attr = grp->attrs; *attr && !error; i++, attr++) {
 			umode_t mode = (*attr)->mode;
 
 			/*
@@ -73,13 +73,27 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 	}
 
 	if (grp->bin_attrs) {
-		for (bin_attr = grp->bin_attrs; *bin_attr; bin_attr++) {
+		for (bin_attr = grp->bin_attrs; *bin_attr; i++, bin_attr++) {
+			umode_t mode = (*bin_attr)->attr.mode;
+
 			if (update)
 				kernfs_remove_by_name(parent,
 						(*bin_attr)->attr.name);
+			if (grp->is_visible) {
+				mode = grp->is_visible(kobj,
+						       &(*bin_attr)->attr, i);
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
-- 
2.1.4
