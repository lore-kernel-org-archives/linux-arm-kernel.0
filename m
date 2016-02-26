From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Feb 2016 13:54:10 +0100
Subject: [PATCH 2/2] orangefs: avoid time conversion function
In-Reply-To: <1456491255-1111319-1-git-send-email-arnd@arndb.de>
References: <1456491255-1111319-1-git-send-email-arnd@arndb.de>
Message-ID: <1456491255-1111319-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new orangefs code uses a helper function to read a time field to
its private structures from struct iattr. This will conflict with the
move to 64-bit timestamps in the kernel and is generally not necessary.

This replaces the conversion with a simple cast to time64_t that shows
what is going on. As the orangefs-internal representation already uses
64-bit timestamps, there should be no ambiguity to negative values,
and the cast ensures that we treat them as times before 1970 on both
32-bit and 64-bit architectures, rather than times after 2038. This
patch keeps that behavior.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/orangefs/orangefs-kernel.h |  5 -----
 fs/orangefs/orangefs-utils.c  | 12 +++++-------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
index 9d92c4fc7dbd..afb8a03b5793 100644
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -564,11 +564,6 @@ int orangefs_unmount_sb(struct super_block *sb);
 
 bool orangefs_cancel_op_in_progress(struct orangefs_kernel_op_s *op);
 
-static inline __u64 orangefs_convert_time_field(const struct timespec *ts)
-{
-	return (__u64)ts->tv_sec;
-}
-
 int orangefs_normalize_to_errno(__s32 error_code);
 
 extern struct mutex devreq_mutex;
diff --git a/fs/orangefs/orangefs-utils.c b/fs/orangefs/orangefs-utils.c
index 488f3501b09c..8ef9e9646748 100644
--- a/fs/orangefs/orangefs-utils.c
+++ b/fs/orangefs/orangefs-utils.c
@@ -202,9 +202,9 @@ static int copy_attributes_to_inode(struct inode *inode,
 
 	inode->i_uid = make_kuid(&init_user_ns, attrs->owner);
 	inode->i_gid = make_kgid(&init_user_ns, attrs->group);
-	inode->i_atime.tv_sec = (time_t) attrs->atime;
-	inode->i_mtime.tv_sec = (time_t) attrs->mtime;
-	inode->i_ctime.tv_sec = (time_t) attrs->ctime;
+	inode->i_atime.tv_sec = (time64_t) attrs->atime;
+	inode->i_mtime.tv_sec = (time64_t) attrs->mtime;
+	inode->i_ctime.tv_sec = (time64_t) attrs->ctime;
 	inode->i_atime.tv_nsec = 0;
 	inode->i_mtime.tv_nsec = 0;
 	inode->i_ctime.tv_nsec = 0;
@@ -301,16 +301,14 @@ static inline int copy_attributes_from_inode(struct inode *inode,
 	if (iattr->ia_valid & ATTR_ATIME) {
 		attrs->mask |= ORANGEFS_ATTR_SYS_ATIME;
 		if (iattr->ia_valid & ATTR_ATIME_SET) {
-			attrs->atime =
-			    orangefs_convert_time_field(&iattr->ia_atime);
+			attrs->atime = (time64_t)iattr->ia_atime.tv_sec;
 			attrs->mask |= ORANGEFS_ATTR_SYS_ATIME_SET;
 		}
 	}
 	if (iattr->ia_valid & ATTR_MTIME) {
 		attrs->mask |= ORANGEFS_ATTR_SYS_MTIME;
 		if (iattr->ia_valid & ATTR_MTIME_SET) {
-			attrs->mtime =
-			    orangefs_convert_time_field(&iattr->ia_mtime);
+			attrs->mtime = (time64_t)iattr->ia_mtime.tv_sec;
 			attrs->mask |= ORANGEFS_ATTR_SYS_MTIME_SET;
 		}
 	}
-- 
2.7.0
