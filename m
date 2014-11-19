From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Nov 2014 15:11:24 +0100
Subject: [PATCH] isofs: avoid unused function warning
Message-ID: <1744765.FITJHBjs5L@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the isofs_hash() function removed, isofs_hash_ms() is the only user
of isofs_hash_common(), but it's defined inside of an #ifdef, which triggers
this gcc warning in ARM axm55xx_defconfig starting with v3.18-rc3:

fs/isofs/inode.c:177:1: warning: 'isofs_hash_common' defined but not used [-Wunused-function]

This patch moves the function inside of the same #ifdef section to avoid that
warning, which seems the best compromise of a relatively harmless patch for
a late -rc.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: b0afd8e5db7b ("isofs: don't bother with ->d_op for normal case")
---

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index fe839b915116..d67a16f2a45d 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -174,27 +174,6 @@ struct iso9660_options{
  * Compute the hash for the isofs name corresponding to the dentry.
  */
 static int
-isofs_hash_common(struct qstr *qstr, int ms)
-{
-	const char *name;
-	int len;
-
-	len = qstr->len;
-	name = qstr->name;
-	if (ms) {
-		while (len && name[len-1] == '.')
-			len--;
-	}
-
-	qstr->hash = full_name_hash(name, len);
-
-	return 0;
-}
-
-/*
- * Compute the hash for the isofs name corresponding to the dentry.
- */
-static int
 isofs_hashi_common(struct qstr *qstr, int ms)
 {
 	const char *name;
@@ -263,6 +242,27 @@ isofs_dentry_cmpi(const struct dentry *parent, const struct dentry *dentry,
 }
 
 #ifdef CONFIG_JOLIET
+/*
+ * Compute the hash for the isofs name corresponding to the dentry.
+ */
+static int
+isofs_hash_common(struct qstr *qstr, int ms)
+{
+	const char *name;
+	int len;
+
+	len = qstr->len;
+	name = qstr->name;
+	if (ms) {
+		while (len && name[len-1] == '.')
+			len--;
+	}
+
+	qstr->hash = full_name_hash(name, len);
+
+	return 0;
+}
+
 static int
 isofs_hash_ms(const struct dentry *dentry, struct qstr *qstr)
 {
