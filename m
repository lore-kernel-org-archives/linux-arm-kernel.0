From: ynorov@caviumnetworks.com (Yury Norov)
Date: Sun, 11 Dec 2016 18:26:41 +0530
Subject: [PATCH 2/3] sys_mmap64()
In-Reply-To: <1481461003-14361-1-git-send-email-ynorov@caviumnetworks.com>
References: <1481461003-14361-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1481461003-14361-3-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 include/linux/syscalls.h          |  3 +++
 include/uapi/asm-generic/unistd.h |  4 +++-
 mm/mmap.c                         | 25 +++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 91a740f..869ca76 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -857,6 +857,9 @@ asmlinkage long sys_perf_event_open(
 asmlinkage long sys_mmap_pgoff(unsigned long addr, unsigned long len,
 			unsigned long prot, unsigned long flags,
 			unsigned long fd, unsigned long pgoff);
+asmlinkage long sys_mmap64(unsigned long addr, unsigned long len,
+			unsigned long prot, unsigned long flags,
+			unsigned long fd, unsigned long long *offset);
 asmlinkage long sys_old_mmap(struct mmap_arg_struct __user *arg);
 asmlinkage long sys_name_to_handle_at(int dfd, const char __user *name,
 				      struct file_handle __user *handle,
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index d65e232..f9ca919 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -734,9 +734,11 @@ __SYSCALL(__NR_pkey_mprotect, sys_pkey_mprotect)
 __SYSCALL(__NR_pkey_alloc,    sys_pkey_alloc)
 #define __NR_pkey_free 290
 __SYSCALL(__NR_pkey_free,     sys_pkey_free)
+#define __NR_mmap64 291
+__SYSCALL(__NR_mmap64, sys_mmap64)
 
 #undef __NR_syscalls
-#define __NR_syscalls 291
+#define __NR_syscalls 292
 
 /*
  * All syscalls below here should go away really,
diff --git a/mm/mmap.c b/mm/mmap.c
index fc1c943..6c6b95a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1504,6 +1504,31 @@ static int mmap_pgoff_prepare(struct file **f, unsigned long *l,
 	return 0;
 }
 
+SYSCALL_DEFINE6(mmap64, unsigned long, addr, unsigned long, len,
+		unsigned long, prot, unsigned long, flags,
+		unsigned long, fd, unsigned long long __user *, offset)
+{
+	int err;
+	unsigned long long koffset;
+	unsigned long retval;
+	struct file *file = NULL;
+
+	if (copy_from_user(&koffset, offset, sizeof(koffset)))
+		return -EFAULT;
+	if (offset_in_page(koffset))
+		return -EINVAL;
+
+	err = mmap_pgoff_prepare(&file, &len, &flags, fd);
+	if (err)
+		return err;
+
+	retval = vm_mmap_pgoff(file, addr, len, prot,
+			flags, koffset >> PAGE_SHIFT);
+	if (file)
+		fput(file);
+	return retval;
+}
+
 SYSCALL_DEFINE6(mmap_pgoff, unsigned long, addr, unsigned long, len,
 		unsigned long, prot, unsigned long, flags,
 		unsigned long, fd, unsigned long, pgoff)
-- 
2.7.4
