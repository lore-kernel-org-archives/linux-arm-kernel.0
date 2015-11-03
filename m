From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 03 Nov 2015 14:43:58 +0100
Subject: [PATCH] xfs: only modify ACLs if CONFIG_XFS_POSIX_ACL enabled
Message-ID: <4425824.kIWhRaBxBZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent bug fix added a call to forget_cached_acl(), but that
function is not always available, so we can get a build error
here:

fs/xfs/xfs_xattr.c: In function 'xfs_xattr_set':
fs/xfs/xfs_xattr.c:84:4: error: implicit declaration of function 'forget_cached_acl' [-Werror=implicit-function-declaration]

This changes the code to use the same #ifdef that we already
use to encapsule the existing ACL handling.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 6caa105651cb ("xfs: invalidate cached acl if set directly via xattr")
---
This started breaking ARM davinci_all_defconfig today in linux-next

diff --git a/fs/xfs/xfs_xattr.c b/fs/xfs/xfs_xattr.c
index 2e1eb80d5374..6229325abdd3 100644
--- a/fs/xfs/xfs_xattr.c
+++ b/fs/xfs/xfs_xattr.c
@@ -73,6 +73,7 @@ xfs_xattr_set(struct dentry *dentry, const char *name, const void *value,
 		return xfs_attr_remove(ip, (unsigned char *)name, xflags);
 	error = xfs_attr_set(ip, (unsigned char *)name,
 				(void *)value, size, xflags);
+#ifdef CONFIG_XFS_POSIX_ACL
 	/*
 	 * Invalidate any cached ACLs if the user has bypassed the ACL
 	 * interface. We don't validate the content whatsoever so it is caller
@@ -85,6 +86,7 @@ xfs_xattr_set(struct dentry *dentry, const char *name, const void *value,
 		else if (!strncmp(name, SGI_ACL_DEFAULT, strlen(name)))
 			forget_cached_acl(VFS_I(ip), ACL_TYPE_DEFAULT);
 	}
+#endif
 
 	return error;
 }
