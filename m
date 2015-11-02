From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 3 Nov 2015 02:30:43 +0300
Subject: [PATCH v6 14/17] aarch64: ilp32: use generic stat64 structure
In-Reply-To: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1446507046-24604-15-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Generic 32-bit and AARCH32 stat64 structures has same names.
ILP32 needs generic stat64. So we can either make ILP32 mutual
exclusive with AARCH32, or introduce __stat64, and where needed,
cast stat64 to it with #define.

Second option requires to duplicate cp_new_stat64 code. But we
choose it, because it's more flexible to have independend support
for ABIs.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Reviewed-by: David Daney <david.daney@cavium.com>
---
 arch/arm64/kernel/sys_ilp32.c   | 57 +++++++++++++++++++++++++++++++++++++++++
 include/uapi/asm-generic/stat.h |  8 +++---
 2 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/sys_ilp32.c b/arch/arm64/kernel/sys_ilp32.c
index 6c7d274..889f1d3 100644
--- a/arch/arm64/kernel/sys_ilp32.c
+++ b/arch/arm64/kernel/sys_ilp32.c
@@ -205,6 +205,63 @@ long ilp32_sys_sigaltstack(const stack_t __user *uss_ptr,
    for stack_t might not be non-zero. */
 #define sys_sigaltstack		ilp32_sys_sigaltstack
 
+/* fs */
+
+#define sys_fcntl		compat_sys_fcntl
+
+static long __cp_new_stat64(struct kstat *stat, struct __stat64 __user *statbuf)
+{
+	struct __stat64 tmp;
+
+	memset(&tmp, 0, sizeof(tmp));
+	tmp.st_dev = huge_encode_dev(stat->dev);
+	tmp.st_rdev = huge_encode_dev(stat->rdev);
+
+	tmp.st_ino = stat->ino;
+	if (sizeof(tmp.st_ino) < sizeof(stat->ino) && tmp.st_ino != stat->ino)
+		return -EOVERFLOW;
+	tmp.st_mode = stat->mode;
+	tmp.st_nlink = stat->nlink;
+	tmp.st_uid = from_kuid_munged(current_user_ns(), stat->uid);
+	tmp.st_gid = from_kgid_munged(current_user_ns(), stat->gid);
+	tmp.st_atime = stat->atime.tv_sec;
+	tmp.st_atime_nsec = stat->atime.tv_nsec;
+	tmp.st_mtime = stat->mtime.tv_sec;
+	tmp.st_mtime_nsec = stat->mtime.tv_nsec;
+	tmp.st_ctime = stat->ctime.tv_sec;
+	tmp.st_ctime_nsec = stat->ctime.tv_nsec;
+	tmp.st_size = stat->size;
+	tmp.st_blocks = stat->blocks;
+	tmp.st_blksize = stat->blksize;
+	return copy_to_user(statbuf,&tmp,sizeof(tmp)) ? -EFAULT : 0;
+}
+
+long ilp32_sys_fstat64(int fd, struct __stat64 __user * statbuf)
+{
+	struct kstat stat;
+	int error = vfs_fstat(fd, &stat);
+
+	if (!error)
+		error = __cp_new_stat64(&stat, statbuf);
+
+	return error;
+}
+
+#define sys_newfstat ilp32_sys_fstat64
+
+long ilp32_sys_fstatat64(int dfd, const char __user * filename,
+		struct __stat64 __user * statbuf, int flag)
+{
+	struct kstat stat;
+	int error;
+
+	error = vfs_fstatat(dfd, filename, &stat, flag);
+	if (error)
+		return error;
+	return __cp_new_stat64(&stat, statbuf);
+}
+
+#define sys_newfstatat ilp32_sys_fstatat64
 
 #include <asm/syscall.h>
 
diff --git a/include/uapi/asm-generic/stat.h b/include/uapi/asm-generic/stat.h
index bd8cad2..ae81e73 100644
--- a/include/uapi/asm-generic/stat.h
+++ b/include/uapi/asm-generic/stat.h
@@ -43,9 +43,7 @@ struct stat {
 	unsigned int	__unused5;
 };
 
-/* This matches struct stat64 in glibc2.1. Only used for 32 bit. */
-#if __BITS_PER_LONG != 64 || defined(__ARCH_WANT_STAT64)
-struct stat64 {
+struct __stat64 {
 	unsigned long long st_dev;	/* Device.  */
 	unsigned long long st_ino;	/* File serial number.  */
 	unsigned int	st_mode;	/* File mode.  */
@@ -67,6 +65,10 @@ struct stat64 {
 	unsigned int	__unused4;
 	unsigned int	__unused5;
 };
+
+#if __BITS_PER_LONG != 64 || defined(__ARCH_WANT_STAT64)
+/* This matches struct stat64 in glibc2.1. Only used for 32 bit. */
+#define stat64 __stat64
 #endif
 
 #endif /* __ASM_GENERIC_STAT_H */
-- 
2.1.4
