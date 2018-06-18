From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 Jun 2018 13:03:05 +0100
Subject: [PATCHv3 14/19] kernel: add kcompat_sys_{f,}statfs64()
In-Reply-To: <20180618120310.39527-1-mark.rutland@arm.com>
References: <20180618120310.39527-1-mark.rutland@arm.com>
Message-ID: <20180618120310.39527-15-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using this helper allows us to avoid the in-kernel calls to the
compat_sys_{f,}statfs64() sycalls, as are necessary for parameter
mangling in arm64's compat handling.

Following the example of ksys_* functions, kcompat_sys_* functions are
intended to be a drop-in replacement for their compat_sys_*
counterparts, with the same calling convention.

This is necessary to enable conversion of arm64's syscall handling to
use pt_regs wrappers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel at vger.kernel.org
---
 fs/statfs.c            | 14 ++++++++++++--
 include/linux/compat.h | 11 +++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/statfs.c b/fs/statfs.c
index 5b2a24f0f263..f0216629621d 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -335,7 +335,7 @@ static int put_compat_statfs64(struct compat_statfs64 __user *ubuf, struct kstat
 	return 0;
 }
 
-COMPAT_SYSCALL_DEFINE3(statfs64, const char __user *, pathname, compat_size_t, sz, struct compat_statfs64 __user *, buf)
+int kcompat_sys_statfs64(const char __user * pathname, compat_size_t sz, struct compat_statfs64 __user * buf)
 {
 	struct kstatfs tmp;
 	int error;
@@ -349,7 +349,12 @@ COMPAT_SYSCALL_DEFINE3(statfs64, const char __user *, pathname, compat_size_t, s
 	return error;
 }
 
-COMPAT_SYSCALL_DEFINE3(fstatfs64, unsigned int, fd, compat_size_t, sz, struct compat_statfs64 __user *, buf)
+COMPAT_SYSCALL_DEFINE3(statfs64, const char __user *, pathname, compat_size_t, sz, struct compat_statfs64 __user *, buf)
+{
+	return kcompat_sys_statfs64(pathname, sz, buf);
+}
+
+int kcompat_sys_fstatfs64(unsigned int fd, compat_size_t sz, struct compat_statfs64 __user * buf)
 {
 	struct kstatfs tmp;
 	int error;
@@ -363,6 +368,11 @@ COMPAT_SYSCALL_DEFINE3(fstatfs64, unsigned int, fd, compat_size_t, sz, struct co
 	return error;
 }
 
+COMPAT_SYSCALL_DEFINE3(fstatfs64, unsigned int, fd, compat_size_t, sz, struct compat_statfs64 __user *, buf)
+{
+	return kcompat_sys_fstatfs64(fd, sz, buf);
+}
+
 /*
  * This is a copy of sys_ustat, just dealing with a structure layout.
  * Given how simple this syscall is that apporach is more maintainable
diff --git a/include/linux/compat.h b/include/linux/compat.h
index b1a5562b3215..a9ead4a9d7fc 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -1022,6 +1022,17 @@ static inline struct compat_timeval ns_to_compat_timeval(s64 nsec)
 	return ctv;
 }
 
+/*
+ * Kernel code should not call compat syscalls (i.e., compat_sys_xyzyyz())
+ * directly.  Instead, use one of the functions which work equivalently, such
+ * as the kcompat_sys_xyzyyz() functions prototyped below.
+ */
+
+int kcompat_sys_statfs64(const char __user * pathname, compat_size_t sz,
+		     struct compat_statfs64 __user * buf);
+int kcompat_sys_fstatfs64(unsigned int fd, compat_size_t sz,
+			  struct compat_statfs64 __user * buf);
+
 #else /* !CONFIG_COMPAT */
 
 #define is_compat_task() (0)
-- 
2.11.0
