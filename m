From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 18 Nov 2015 00:16:56 +0300
Subject: [PATCH v6 16/19] aarch64: ilp32: use generic stat64 structure
In-Reply-To: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1447795019-30176-17-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Generic 32-bit and AARCH32 stat64 structures has same names.
ILP32 needs generic stat64. So we can either make ILP32 mutual
exclusive with AARCH32, or duplicate generic cp_new_stat64 code
and struct stat64 to sys_ilp32.c. We choose second because it's
more flexible to have independend support for ABIs.

Reviewed-by: David Daney <ddaney@caviumnetworks.com>

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/kernel/sys_ilp32.c | 86 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/arm64/kernel/sys_ilp32.c b/arch/arm64/kernel/sys_ilp32.c
index a2596f4..c5bc712 100644
--- a/arch/arm64/kernel/sys_ilp32.c
+++ b/arch/arm64/kernel/sys_ilp32.c
@@ -117,6 +117,92 @@ asmlinkage long ilp32_sys_semctl(int first, int second, int third, int arg)
 }
 #define compat_sys_semctl	ilp32_sys_semctl
 
+struct ilp32_stat {
+	unsigned long st_dev;
+
+	unsigned long st_ino;
+
+	unsigned int st_mode;
+	unsigned int st_nlink;
+
+	unsigned int st_uid;
+	unsigned int st_gid;
+
+	unsigned long st_rdev;
+	unsigned long __st_rdev_pad;
+
+	long st_size;
+
+	unsigned int st_blksize;
+	unsigned int __st_blksize_pad;
+
+	unsigned long st_blocks;
+
+	unsigned int st_atime;
+	unsigned int st_atime_nsec;
+
+	unsigned int st_mtime;
+	unsigned int st_mtime_nsec;
+
+	unsigned int st_ctime;
+	unsigned int st_ctime_nsec;
+
+	unsigned int __unused[2];
+};
+
+static long ilp32_cp_stat(struct kstat *stat,
+			  struct ilp32_stat __user *statbuf)
+{
+	struct ilp32_stat tmp = {
+		.st_dev = huge_encode_dev(stat->dev),
+		.st_ino = stat->ino,
+		.st_mode = stat->mode,
+		.st_nlink = stat->nlink,
+		.st_uid = from_kuid_munged(current_user_ns(), stat->uid),
+		.st_gid = from_kgid_munged(current_user_ns(), stat->gid),
+		.st_rdev = huge_encode_dev(stat->rdev),
+		.__st_rdev_pad = 0,
+		.st_size = stat->size,
+		.st_blksize = stat->blksize,
+		.__st_blksize_pad = 0,
+		.st_blocks = stat->blocks,
+		.st_atime = stat->atime.tv_sec,
+		.st_atime_nsec = stat->atime.tv_nsec,
+		.st_mtime = stat->mtime.tv_sec,
+		.st_mtime_nsec = stat->mtime.tv_nsec,
+		.st_ctime = stat->ctime.tv_sec,
+		.st_ctime_nsec = stat->ctime.tv_nsec,
+		.__unused = { 0, 0 }
+	};
+
+	return copy_to_user(statbuf, &tmp, sizeof(tmp)) ? -EFAULT : 0;
+}
+
+asmlinkage long ilp32_sys_fstat64(unsigned int fd,
+				struct ilp32_stat __user *statbuf)
+{
+	struct kstat stat;
+	int error = vfs_fstat(fd, &stat);
+
+	if (!error)
+		error = ilp32_cp_stat(&stat, statbuf);
+	return error;
+}
+#define sys_fstat64		ilp32_sys_fstat64
+
+asmlinkage long ilp32_sys_fstatat64(unsigned int dfd,
+				  const char __user *filename,
+				  struct ilp32_stat __user *statbuf, int flag)
+{
+	struct kstat stat;
+	int error = vfs_fstatat(dfd, filename, &stat, flag);
+
+	if (!error)
+		error = ilp32_cp_stat(&stat, statbuf);
+	return error;
+}
+#define sys_fstatat64		ilp32_sys_fstatat64
+
 #include <asm/syscall.h>
 
 #undef __SYSCALL
-- 
2.1.4
