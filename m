From: ynorov@caviumnetworks.com (Yury Norov)
Date: Thu, 14 Jan 2016 20:23:17 +0300
Subject: [PATCH v6 20/21] all: s390: make compat wrappers the generic solution
In-Reply-To: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1452792198-10718-21-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The problem that makes us to use wrappers is that some compat
architectures allows user code to access top halves of registers.
This is not a problem for syscalls that are already handled by compat
code, or for that who has types of the same size in kernel and
userspace. In case of lp64/ilp32 the problem is in pointer types, long,
unsigned long.

S390 folks already have the solution for it. In this patch,
it is turned to be general, as arm64/ilp32 needs it too.

Build-tested on s390.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/Kconfig                           |   4 +
 arch/s390/Kconfig                      |   1 +
 arch/s390/include/asm/compat_wrapper.h |  25 +++
 arch/s390/kernel/Makefile              |   2 +-
 arch/s390/kernel/compat_linux.c        |   6 +
 arch/s390/kernel/compat_wrapper.c      | 179 ----------------------
 include/linux/compat_wrapper.h         | 270 +++++++++++++++++++++++++++++++++
 include/uapi/asm-generic/unistd.h      | 224 +++++++++++++--------------
 kernel/Makefile                        |   1 +
 kernel/compat_wrapper.c                | 167 ++++++++++++++++++++
 10 files changed, 589 insertions(+), 290 deletions(-)
 create mode 100644 arch/s390/include/asm/compat_wrapper.h
 delete mode 100644 arch/s390/kernel/compat_wrapper.c
 create mode 100644 include/linux/compat_wrapper.h
 create mode 100644 kernel/compat_wrapper.c

diff --git a/arch/Kconfig b/arch/Kconfig
index 4e949e5..ab7692e 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -518,6 +518,10 @@ config HAVE_COPY_THREAD_TLS
 	  normal C parameter passing, rather than extracting the syscall
 	  argument from pt_regs.
 
+config COMPAT_WRAPPER
+	bool
+	depends on COMPAT
+
 #
 # ABI hall of shame
 #
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 3a55f49..88f48b0 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -336,6 +336,7 @@ config COMPAT
 	select COMPAT_BINFMT_ELF if BINFMT_ELF
 	select ARCH_WANT_OLD_COMPAT_IPC
 	select COMPAT_OLD_SIGACTION
+	select COMPAT_WRAPPER
 	depends on MULTIUSER
 	help
 	  Select this option if you want to enable your system kernel to
diff --git a/arch/s390/include/asm/compat_wrapper.h b/arch/s390/include/asm/compat_wrapper.h
new file mode 100644
index 0000000..d5a5c36
--- /dev/null
+++ b/arch/s390/include/asm/compat_wrapper.h
@@ -0,0 +1,25 @@
+#ifndef __ASM_COMPAT_WRAPPER
+#define __ASM_COMPAT_WRAPPER
+
+/*
+ *  Compat system call wrappers.
+ *
+ *    Copyright IBM Corp. 2014
+ */
+
+#define __SC_COMPAT_CAST(t, a)						\
+({									\
+	long __ReS = a;							\
+									\
+	BUILD_BUG_ON((sizeof(t) > 4) && !__TYPE_IS_L(t) &&		\
+		     !__TYPE_IS_UL(t) && !__TYPE_IS_PTR(t));		\
+	if (__TYPE_IS_L(t))						\
+		__ReS = (s32)a;						\
+	if (__TYPE_IS_UL(t))						\
+		__ReS = (u32)a;						\
+	if (__TYPE_IS_PTR(t))						\
+		__ReS = a & 0x7fffffff;					\
+	(t)__ReS;							\
+})
+
+#endif /* __ASM_COMPAT_WRAPPER */
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index dc167a2..185cd88 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -55,7 +55,7 @@ obj-$(CONFIG_HIBERNATION)	+= suspend.o swsusp.o
 obj-$(CONFIG_AUDIT)		+= audit.o
 compat-obj-$(CONFIG_AUDIT)	+= compat_audit.o
 obj-$(CONFIG_COMPAT)		+= compat_linux.o compat_signal.o
-obj-$(CONFIG_COMPAT)		+= compat_wrapper.o $(compat-obj-y)
+obj-$(CONFIG_COMPAT)		+= $(compat-obj-y)
 
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index 437e611..22416a8 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -44,6 +44,7 @@
 #include <linux/binfmts.h>
 #include <linux/capability.h>
 #include <linux/compat.h>
+#include <linux/compat_wrapper.h>
 #include <linux/vfs.h>
 #include <linux/ptrace.h>
 #include <linux/fadvise.h>
@@ -86,6 +87,11 @@
 #define SET_STAT_UID(stat, uid)		(stat).st_uid = high2lowuid(uid)
 #define SET_STAT_GID(stat, gid)		(stat).st_gid = high2lowgid(gid)
 
+COMPAT_SYSCALL_WRAP3(s390_pci_mmio_write, const unsigned long,
+		mmio_addr, const void __user *, user_buffer, const size_t, length);
+COMPAT_SYSCALL_WRAP3(s390_pci_mmio_read, const unsigned long,
+		mmio_addr, void __user *, user_buffer, const size_t, length);
+
 COMPAT_SYSCALL_DEFINE3(s390_chown16, const char __user *, filename,
 		       u16, user, u16, group)
 {
diff --git a/arch/s390/kernel/compat_wrapper.c b/arch/s390/kernel/compat_wrapper.c
deleted file mode 100644
index fac4eed..0000000
--- a/arch/s390/kernel/compat_wrapper.c
+++ /dev/null
@@ -1,179 +0,0 @@
-/*
- *  Compat system call wrappers.
- *
- *    Copyright IBM Corp. 2014
- */
-
-#include <linux/syscalls.h>
-#include <linux/compat.h>
-#include "entry.h"
-
-#define COMPAT_SYSCALL_WRAP1(name, ...) \
-	COMPAT_SYSCALL_WRAPx(1, _##name, __VA_ARGS__)
-#define COMPAT_SYSCALL_WRAP2(name, ...) \
-	COMPAT_SYSCALL_WRAPx(2, _##name, __VA_ARGS__)
-#define COMPAT_SYSCALL_WRAP3(name, ...) \
-	COMPAT_SYSCALL_WRAPx(3, _##name, __VA_ARGS__)
-#define COMPAT_SYSCALL_WRAP4(name, ...) \
-	COMPAT_SYSCALL_WRAPx(4, _##name, __VA_ARGS__)
-#define COMPAT_SYSCALL_WRAP5(name, ...) \
-	COMPAT_SYSCALL_WRAPx(5, _##name, __VA_ARGS__)
-#define COMPAT_SYSCALL_WRAP6(name, ...) \
-	COMPAT_SYSCALL_WRAPx(6, _##name, __VA_ARGS__)
-
-#define __SC_COMPAT_TYPE(t, a) \
-	__typeof(__builtin_choose_expr(sizeof(t) > 4, 0L, (t)0)) a
-
-#define __SC_COMPAT_CAST(t, a)						\
-({									\
-	long __ReS = a;							\
-									\
-	BUILD_BUG_ON((sizeof(t) > 4) && !__TYPE_IS_L(t) &&		\
-		     !__TYPE_IS_UL(t) && !__TYPE_IS_PTR(t));		\
-	if (__TYPE_IS_L(t))						\
-		__ReS = (s32)a;						\
-	if (__TYPE_IS_UL(t))						\
-		__ReS = (u32)a;						\
-	if (__TYPE_IS_PTR(t))						\
-		__ReS = a & 0x7fffffff;					\
-	(t)__ReS;							\
-})
-
-/*
- * The COMPAT_SYSCALL_WRAP macro generates system call wrappers to be used by
- * compat tasks. These wrappers will only be used for system calls where only
- * the system call arguments need sign or zero extension or zeroing of the upper
- * 33 bits of pointers.
- * Note: since the wrapper function will afterwards call a system call which
- * again performs zero and sign extension for all system call arguments with
- * a size of less than eight bytes, these compat wrappers only touch those
- * system call arguments with a size of eight bytes ((unsigned) long and
- * pointers). Zero and sign extension for e.g. int parameters will be done by
- * the regular system call wrappers.
- */
-#define COMPAT_SYSCALL_WRAPx(x, name, ...)					\
-asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));			\
-asmlinkage long notrace compat_sys##name(__MAP(x,__SC_COMPAT_TYPE,__VA_ARGS__));\
-asmlinkage long notrace compat_sys##name(__MAP(x,__SC_COMPAT_TYPE,__VA_ARGS__))	\
-{										\
-	return sys##name(__MAP(x,__SC_COMPAT_CAST,__VA_ARGS__));		\
-}
-
-COMPAT_SYSCALL_WRAP2(creat, const char __user *, pathname, umode_t, mode);
-COMPAT_SYSCALL_WRAP2(link, const char __user *, oldname, const char __user *, newname);
-COMPAT_SYSCALL_WRAP1(unlink, const char __user *, pathname);
-COMPAT_SYSCALL_WRAP1(chdir, const char __user *, filename);
-COMPAT_SYSCALL_WRAP3(mknod, const char __user *, filename, umode_t, mode, unsigned, dev);
-COMPAT_SYSCALL_WRAP2(chmod, const char __user *, filename, umode_t, mode);
-COMPAT_SYSCALL_WRAP1(oldumount, char __user *, name);
-COMPAT_SYSCALL_WRAP2(access, const char __user *, filename, int, mode);
-COMPAT_SYSCALL_WRAP2(rename, const char __user *, oldname, const char __user *, newname);
-COMPAT_SYSCALL_WRAP2(mkdir, const char __user *, pathname, umode_t, mode);
-COMPAT_SYSCALL_WRAP1(rmdir, const char __user *, pathname);
-COMPAT_SYSCALL_WRAP1(pipe, int __user *, fildes);
-COMPAT_SYSCALL_WRAP1(brk, unsigned long, brk);
-COMPAT_SYSCALL_WRAP2(signal, int, sig, __sighandler_t, handler);
-COMPAT_SYSCALL_WRAP1(acct, const char __user *, name);
-COMPAT_SYSCALL_WRAP2(umount, char __user *, name, int, flags);
-COMPAT_SYSCALL_WRAP1(chroot, const char __user *, filename);
-COMPAT_SYSCALL_WRAP3(sigsuspend, int, unused1, int, unused2, old_sigset_t, mask);
-COMPAT_SYSCALL_WRAP2(sethostname, char __user *, name, int, len);
-COMPAT_SYSCALL_WRAP2(symlink, const char __user *, old, const char __user *, new);
-COMPAT_SYSCALL_WRAP3(readlink, const char __user *, path, char __user *, buf, int, bufsiz);
-COMPAT_SYSCALL_WRAP1(uselib, const char __user *, library);
-COMPAT_SYSCALL_WRAP2(swapon, const char __user *, specialfile, int, swap_flags);
-COMPAT_SYSCALL_WRAP4(reboot, int, magic1, int, magic2, unsigned int, cmd, void __user *, arg);
-COMPAT_SYSCALL_WRAP2(munmap, unsigned long, addr, size_t, len);
-COMPAT_SYSCALL_WRAP3(syslog, int, type, char __user *, buf, int, len);
-COMPAT_SYSCALL_WRAP1(swapoff, const char __user *, specialfile);
-COMPAT_SYSCALL_WRAP2(setdomainname, char __user *, name, int, len);
-COMPAT_SYSCALL_WRAP1(newuname, struct new_utsname __user *, name);
-COMPAT_SYSCALL_WRAP3(mprotect, unsigned long, start, size_t, len, unsigned long, prot);
-COMPAT_SYSCALL_WRAP3(init_module, void __user *, umod, unsigned long, len, const char __user *, uargs);
-COMPAT_SYSCALL_WRAP2(delete_module, const char __user *, name_user, unsigned int, flags);
-COMPAT_SYSCALL_WRAP4(quotactl, unsigned int, cmd, const char __user *, special, qid_t, id, void __user *, addr);
-COMPAT_SYSCALL_WRAP2(bdflush, int, func, long, data);
-COMPAT_SYSCALL_WRAP3(sysfs, int, option, unsigned long, arg1, unsigned long, arg2);
-COMPAT_SYSCALL_WRAP5(llseek, unsigned int, fd, unsigned long, high, unsigned long, low, loff_t __user *, result, unsigned int, whence);
-COMPAT_SYSCALL_WRAP3(msync, unsigned long, start, size_t, len, int, flags);
-COMPAT_SYSCALL_WRAP2(mlock, unsigned long, start, size_t, len);
-COMPAT_SYSCALL_WRAP2(munlock, unsigned long, start, size_t, len);
-COMPAT_SYSCALL_WRAP2(sched_setparam, pid_t, pid, struct sched_param __user *, param);
-COMPAT_SYSCALL_WRAP2(sched_getparam, pid_t, pid, struct sched_param __user *, param);
-COMPAT_SYSCALL_WRAP3(sched_setscheduler, pid_t, pid, int, policy, struct sched_param __user *, param);
-COMPAT_SYSCALL_WRAP5(mremap, unsigned long, addr, unsigned long, old_len, unsigned long, new_len, unsigned long, flags, unsigned long, new_addr);
-COMPAT_SYSCALL_WRAP3(poll, struct pollfd __user *, ufds, unsigned int, nfds, int, timeout);
-COMPAT_SYSCALL_WRAP5(prctl, int, option, unsigned long, arg2, unsigned long, arg3, unsigned long, arg4, unsigned long, arg5);
-COMPAT_SYSCALL_WRAP2(getcwd, char __user *, buf, unsigned long, size);
-COMPAT_SYSCALL_WRAP2(capget, cap_user_header_t, header, cap_user_data_t, dataptr);
-COMPAT_SYSCALL_WRAP2(capset, cap_user_header_t, header, const cap_user_data_t, data);
-COMPAT_SYSCALL_WRAP3(lchown, const char __user *, filename, uid_t, user, gid_t, group);
-COMPAT_SYSCALL_WRAP2(getgroups, int, gidsetsize, gid_t __user *, grouplist);
-COMPAT_SYSCALL_WRAP2(setgroups, int, gidsetsize, gid_t __user *, grouplist);
-COMPAT_SYSCALL_WRAP3(getresuid, uid_t __user *, ruid, uid_t __user *, euid, uid_t __user *, suid);
-COMPAT_SYSCALL_WRAP3(getresgid, gid_t __user *, rgid, gid_t __user *, egid, gid_t __user *, sgid);
-COMPAT_SYSCALL_WRAP3(chown, const char __user *, filename, uid_t, user, gid_t, group);
-COMPAT_SYSCALL_WRAP2(pivot_root, const char __user *, new_root, const char __user *, put_old);
-COMPAT_SYSCALL_WRAP3(mincore, unsigned long, start, size_t, len, unsigned char __user *, vec);
-COMPAT_SYSCALL_WRAP3(madvise, unsigned long, start, size_t, len, int, behavior);
-COMPAT_SYSCALL_WRAP5(setxattr, const char __user *, path, const char __user *, name, const void __user *, value, size_t, size, int, flags);
-COMPAT_SYSCALL_WRAP5(lsetxattr, const char __user *, path, const char __user *, name, const void __user *, value, size_t, size, int, flags);
-COMPAT_SYSCALL_WRAP5(fsetxattr, int, fd, const char __user *, name, const void __user *, value, size_t, size, int, flags);
-COMPAT_SYSCALL_WRAP3(getdents64, unsigned int, fd, struct linux_dirent64 __user *, dirent, unsigned int, count);
-COMPAT_SYSCALL_WRAP4(getxattr, const char __user *, path, const char __user *, name, void __user *, value, size_t, size);
-COMPAT_SYSCALL_WRAP4(lgetxattr, const char __user *, path, const char __user *, name, void __user *, value, size_t, size);
-COMPAT_SYSCALL_WRAP4(fgetxattr, int, fd, const char __user *, name, void __user *, value, size_t, size);
-COMPAT_SYSCALL_WRAP3(listxattr, const char __user *, path, char __user *, list, size_t, size);
-COMPAT_SYSCALL_WRAP3(llistxattr, const char __user *, path, char __user *, list, size_t, size);
-COMPAT_SYSCALL_WRAP3(flistxattr, int, fd, char __user *, list, size_t, size);
-COMPAT_SYSCALL_WRAP2(removexattr, const char __user *, path, const char __user *, name);
-COMPAT_SYSCALL_WRAP2(lremovexattr, const char __user *, path, const char __user *, name);
-COMPAT_SYSCALL_WRAP2(fremovexattr, int, fd, const char __user *, name);
-COMPAT_SYSCALL_WRAP1(set_tid_address, int __user *, tidptr);
-COMPAT_SYSCALL_WRAP4(epoll_ctl, int, epfd, int, op, int, fd, struct epoll_event __user *, event);
-COMPAT_SYSCALL_WRAP4(epoll_wait, int, epfd, struct epoll_event __user *, events, int, maxevents, int, timeout);
-COMPAT_SYSCALL_WRAP1(io_destroy, aio_context_t, ctx);
-COMPAT_SYSCALL_WRAP3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb, struct io_event __user *, result);
-COMPAT_SYSCALL_WRAP1(mq_unlink, const char __user *, name);
-COMPAT_SYSCALL_WRAP5(add_key, const char __user *, tp, const char __user *, dsc, const void __user *, pld, size_t, len, key_serial_t, id);
-COMPAT_SYSCALL_WRAP4(request_key, const char __user *, tp, const char __user *, dsc, const char __user *, info, key_serial_t, id);
-COMPAT_SYSCALL_WRAP5(remap_file_pages, unsigned long, start, unsigned long, size, unsigned long, prot, unsigned long, pgoff, unsigned long, flags);
-COMPAT_SYSCALL_WRAP3(inotify_add_watch, int, fd, const char __user *, path, u32, mask);
-COMPAT_SYSCALL_WRAP3(mkdirat, int, dfd, const char __user *, pathname, umode_t, mode);
-COMPAT_SYSCALL_WRAP4(mknodat, int, dfd, const char __user *, filename, umode_t, mode, unsigned, dev);
-COMPAT_SYSCALL_WRAP5(fchownat, int, dfd, const char __user *, filename, uid_t, user, gid_t, group, int, flag);
-COMPAT_SYSCALL_WRAP3(unlinkat, int, dfd, const char __user *, pathname, int, flag);
-COMPAT_SYSCALL_WRAP4(renameat, int, olddfd, const char __user *, oldname, int, newdfd, const char __user *, newname);
-COMPAT_SYSCALL_WRAP5(linkat, int, olddfd, const char __user *, oldname, int, newdfd, const char __user *, newname, int, flags);
-COMPAT_SYSCALL_WRAP3(symlinkat, const char __user *, oldname, int, newdfd, const char __user *, newname);
-COMPAT_SYSCALL_WRAP4(readlinkat, int, dfd, const char __user *, path, char __user *, buf, int, bufsiz);
-COMPAT_SYSCALL_WRAP3(fchmodat, int, dfd, const char __user *, filename, umode_t, mode);
-COMPAT_SYSCALL_WRAP3(faccessat, int, dfd, const char __user *, filename, int, mode);
-COMPAT_SYSCALL_WRAP1(unshare, unsigned long, unshare_flags);
-COMPAT_SYSCALL_WRAP6(splice, int, fd_in, loff_t __user *, off_in, int, fd_out, loff_t __user *, off_out, size_t, len, unsigned int, flags);
-COMPAT_SYSCALL_WRAP4(tee, int, fdin, int, fdout, size_t, len, unsigned int, flags);
-COMPAT_SYSCALL_WRAP3(getcpu, unsigned __user *, cpu, unsigned __user *, node, struct getcpu_cache __user *, cache);
-COMPAT_SYSCALL_WRAP2(pipe2, int __user *, fildes, int, flags);
-COMPAT_SYSCALL_WRAP5(perf_event_open, struct perf_event_attr __user *, attr_uptr, pid_t, pid, int, cpu, int, group_fd, unsigned long, flags);
-COMPAT_SYSCALL_WRAP5(clone, unsigned long, newsp, unsigned long, clone_flags, int __user *, parent_tidptr, int __user *, child_tidptr, unsigned long, tls);
-COMPAT_SYSCALL_WRAP4(prlimit64, pid_t, pid, unsigned int, resource, const struct rlimit64 __user *, new_rlim, struct rlimit64 __user *, old_rlim);
-COMPAT_SYSCALL_WRAP5(name_to_handle_at, int, dfd, const char __user *, name, struct file_handle __user *, handle, int __user *, mnt_id, int, flag);
-COMPAT_SYSCALL_WRAP5(kcmp, pid_t, pid1, pid_t, pid2, int, type, unsigned long, idx1, unsigned long, idx2);
-COMPAT_SYSCALL_WRAP3(finit_module, int, fd, const char __user *, uargs, int, flags);
-COMPAT_SYSCALL_WRAP3(sched_setattr, pid_t, pid, struct sched_attr __user *, attr, unsigned int, flags);
-COMPAT_SYSCALL_WRAP4(sched_getattr, pid_t, pid, struct sched_attr __user *, attr, unsigned int, size, unsigned int, flags);
-COMPAT_SYSCALL_WRAP5(renameat2, int, olddfd, const char __user *, oldname, int, newdfd, const char __user *, newname, unsigned int, flags);
-COMPAT_SYSCALL_WRAP3(seccomp, unsigned int, op, unsigned int, flags, const char __user *, uargs)
-COMPAT_SYSCALL_WRAP3(getrandom, char __user *, buf, size_t, count, unsigned int, flags)
-COMPAT_SYSCALL_WRAP2(memfd_create, const char __user *, uname, unsigned int, flags)
-COMPAT_SYSCALL_WRAP3(bpf, int, cmd, union bpf_attr *, attr, unsigned int, size);
-COMPAT_SYSCALL_WRAP3(s390_pci_mmio_write, const unsigned long, mmio_addr, const void __user *, user_buffer, const size_t, length);
-COMPAT_SYSCALL_WRAP3(s390_pci_mmio_read, const unsigned long, mmio_addr, void __user *, user_buffer, const size_t, length);
-COMPAT_SYSCALL_WRAP4(socketpair, int, family, int, type, int, protocol, int __user *, usockvec);
-COMPAT_SYSCALL_WRAP3(bind, int, fd, struct sockaddr __user *, umyaddr, int, addrlen);
-COMPAT_SYSCALL_WRAP3(connect, int, fd, struct sockaddr __user *, uservaddr, int, addrlen);
-COMPAT_SYSCALL_WRAP4(accept4, int, fd, struct sockaddr __user *, upeer_sockaddr, int __user *, upeer_addrlen, int, flags);
-COMPAT_SYSCALL_WRAP3(getsockname, int, fd, struct sockaddr __user *, usockaddr, int __user *, usockaddr_len);
-COMPAT_SYSCALL_WRAP3(getpeername, int, fd, struct sockaddr __user *, usockaddr, int __user *, usockaddr_len);
-COMPAT_SYSCALL_WRAP6(sendto, int, fd, void __user *, buff, size_t, len, unsigned int, flags, struct sockaddr __user *, addr, int, addr_len);
-COMPAT_SYSCALL_WRAP3(mlock2, unsigned long, start, size_t, len, int, flags);
diff --git a/include/linux/compat_wrapper.h b/include/linux/compat_wrapper.h
new file mode 100644
index 0000000..6f22732
--- /dev/null
+++ b/include/linux/compat_wrapper.h
@@ -0,0 +1,270 @@
+#ifndef __COMPAT_WRAPPER
+#define __COMPAT_WRAPPER
+
+#include <asm/compat_wrapper.h>
+
+#define COMPAT_SYSCALL_WRAP1(name, ...) \
+	COMPAT_SYSCALL_WRAPx(1, _##name, __VA_ARGS__)
+#define COMPAT_SYSCALL_WRAP2(name, ...) \
+	COMPAT_SYSCALL_WRAPx(2, _##name, __VA_ARGS__)
+#define COMPAT_SYSCALL_WRAP3(name, ...) \
+	COMPAT_SYSCALL_WRAPx(3, _##name, __VA_ARGS__)
+#define COMPAT_SYSCALL_WRAP4(name, ...) \
+	COMPAT_SYSCALL_WRAPx(4, _##name, __VA_ARGS__)
+#define COMPAT_SYSCALL_WRAP5(name, ...) \
+	COMPAT_SYSCALL_WRAPx(5, _##name, __VA_ARGS__)
+#define COMPAT_SYSCALL_WRAP6(name, ...) \
+	COMPAT_SYSCALL_WRAPx(6, _##name, __VA_ARGS__)
+
+#ifndef __SC_COMPAT_TYPE
+#define __SC_COMPAT_TYPE(t, a) \
+	__typeof(__builtin_choose_expr(sizeof(t) > 4, 0L, (t)0)) a
+#endif
+
+#ifndef __SC_COMPAT_CAST
+#define __SC_COMPAT_CAST(t, a)	((t)(long) ((t)(-1) < 0 ? (s32)(a) : (u32)(a)))
+#endif
+/*
+ * The COMPAT_SYSCALL_WRAP macro generates system call wrappers to be used by
+ * compat tasks. These wrappers will only be used for system calls where only
+ * the system call arguments need sign or zero extension or zeroing of the upper
+ * 33 bits of pointers.
+ * Note: since the wrapper function will afterwards call a system call which
+ * again performs zero and sign extension for all system call arguments with
+ * a size of less than eight bytes, these compat wrappers only touch those
+ * system call arguments with a size of eight bytes ((unsigned) long and
+ * pointers). Zero and sign extension for e.g. int parameters will be done by
+ * the regular system call wrappers.
+ */
+#ifndef COMPAT_SYSCALL_WRAPx
+#define COMPAT_SYSCALL_WRAPx(x, name, ...)						\
+asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));				\
+asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))			\
+		__attribute__((alias(__stringify(compat_SyS##name))));			\
+asmlinkage long notrace compat_SyS##name(__MAP(x,__SC_COMPAT_TYPE,__VA_ARGS__));	\
+asmlinkage long notrace compat_SyS##name(__MAP(x,__SC_COMPAT_TYPE,__VA_ARGS__))		\
+{											\
+	return sys##name(__MAP(x,__SC_COMPAT_CAST,__VA_ARGS__));			\
+}
+#endif
+
+asmlinkage long compat_sys_creat(const char __user *pathname, umode_t mode);
+asmlinkage long compat_sys_link(const char __user *oldname,
+				const char __user *newname);
+asmlinkage long compat_sys_chdir(const char __user *filename);
+asmlinkage long compat_sys_mknod(const char __user *filename, umode_t mode,
+				unsigned dev);
+asmlinkage long compat_sys_chmod(const char __user *filename, umode_t mode);
+asmlinkage long compat_sys_oldumount(char __user *name);
+asmlinkage long compat_sys_access(const char __user *filename, int mode);
+asmlinkage long compat_sys_rename(const char __user *oldname,
+				const char __user *newname);
+asmlinkage long compat_sys_mkdir(const char __user *pathname, umode_t mode);
+asmlinkage long compat_sys_rmdir(const char __user *pathname);
+asmlinkage long compat_sys_pipe(int __user *fildes);
+asmlinkage long compat_sys_brk(unsigned long brk);
+asmlinkage long compat_sys_signal(int sig, __sighandler_t handler);
+asmlinkage long compat_sys_acct(const char __user *name);
+asmlinkage long compat_sys_umount(char __user *name, int flags);
+asmlinkage long compat_sys_chroot(const char __user *filename);
+
+#ifdef CONFIG_OLD_SIGSUSPEND
+asmlinkage long compat_sys_sigsuspend(old_sigset_t mask);
+#endif
+
+#ifdef CONFIG_OLD_SIGSUSPEND3
+asmlinkage long compat_sys_sigsuspend(int unused1, int unused2, old_sigset_t mask);
+#endif
+
+asmlinkage long compat_sys_sethostname(char __user *name, int len);
+asmlinkage long compat_sys_symlink(const char __user *old, const char __user *new);
+asmlinkage long compat_sys_readlink(const char __user *path,
+				char __user *buf, int bufsiz);
+asmlinkage long compat_sys_uselib(const char __user *library);
+asmlinkage long compat_sys_swapon(const char __user *specialfile, int swap_flags);
+asmlinkage long compat_sys_reboot(int magic1, int magic2, unsigned int cmd,
+				void __user *arg);
+asmlinkage long compat_sys_munmap(unsigned long addr, size_t len);
+asmlinkage long compat_sys_munmap(unsigned long addr, size_t len);
+asmlinkage long compat_sys_syslog(int type, char __user *buf, int len);
+asmlinkage long compat_sys_swapoff(const char __user *specialfile);
+asmlinkage long compat_sys_setdomainname(char __user *name, int len);
+asmlinkage long compat_sys_newuname(struct new_utsname __user *name);
+asmlinkage long compat_sys_mprotect(unsigned long start, size_t len,
+				unsigned long prot);
+asmlinkage long compat_sys_init_module(void __user *umod, unsigned long len,
+				const char __user *uargs);
+asmlinkage long compat_sys_delete_module(const char __user *name_user,
+				unsigned int flags);
+asmlinkage long compat_sys_quotactl(unsigned int cmd, const char __user *special,
+				qid_t id, void __user *addr);
+asmlinkage long compat_sys_bdflush(int func, long data);
+asmlinkage long compat_sys_sysfs(int option,
+				unsigned long arg1, unsigned long arg2);
+asmlinkage long compat_sys_llseek(unsigned int fd, unsigned long offset_high,
+			unsigned long offset_low, loff_t __user *result,
+			unsigned int whence);
+asmlinkage long compat_sys_msync(unsigned long start, size_t len, int flags);
+asmlinkage long compat_sys_mlock(unsigned long start, size_t len);
+asmlinkage long compat_sys_munlock(unsigned long start, size_t len);
+asmlinkage long compat_sys_sched_setparam(pid_t pid,
+					struct sched_param __user *param);
+asmlinkage long compat_sys_sched_getparam(pid_t pid,
+					struct sched_param __user *param);
+asmlinkage long compat_sys_sched_setscheduler(pid_t pid, int policy,
+					struct sched_param __user *param);
+asmlinkage long compat_sys_mremap(unsigned long addr,
+			   unsigned long old_len, unsigned long new_len,
+			   unsigned long flags, unsigned long new_addr);
+asmlinkage long compat_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
+				int timeout);
+asmlinkage long compat_sys_prctl(int option, unsigned long arg2, unsigned long arg3,
+			unsigned long arg4, unsigned long arg5);
+asmlinkage long compat_sys_getcwd(char __user *buf, unsigned long size);
+asmlinkage long compat_sys_capget(cap_user_header_t header,
+				cap_user_data_t dataptr);
+asmlinkage long compat_sys_capset(cap_user_header_t header,
+				const cap_user_data_t data);
+asmlinkage long compat_sys_lchown(const char __user *filename,
+				uid_t user, gid_t group);
+asmlinkage long compat_sys_getgroups(int gidsetsize, gid_t __user *grouplist);
+asmlinkage long compat_sys_setgroups(int gidsetsize, gid_t __user *grouplist);
+asmlinkage long compat_sys_getresuid(uid_t __user *ruid, uid_t __user *euid, uid_t __user *suid);
+asmlinkage long compat_sys_getresgid(gid_t __user *rgid, gid_t __user *egid, gid_t __user *sgid);
+asmlinkage long compat_sys_chown(const char __user *filename,
+				uid_t user, gid_t group);
+asmlinkage long compat_sys_pivot_root(const char __user *new_root,
+				const char __user *put_old);
+asmlinkage long compat_sys_mincore(unsigned long start, size_t len,
+				unsigned char __user * vec);
+asmlinkage long compat_sys_madvise(unsigned long start, size_t len, int behavior);
+asmlinkage long compat_sys_setxattr(const char __user *path, const char __user *name,
+			     const void __user *value, size_t size, int flags);
+asmlinkage long compat_sys_lsetxattr(const char __user *path, const char __user *name,
+			      const void __user *value, size_t size, int flags);
+asmlinkage long compat_sys_fsetxattr(int fd, const char __user *name,
+			      const void __user *value, size_t size, int flags);
+asmlinkage long compat_sys_getdents64(unsigned int fd,
+				struct linux_dirent64 __user *dirent,
+				unsigned int count);
+asmlinkage long compat_sys_getxattr(const char __user *path, const char __user *name,
+			     void __user *value, size_t size);
+asmlinkage long compat_sys_lgetxattr(const char __user *path, const char __user *name,
+			      void __user *value, size_t size);
+asmlinkage long compat_sys_fgetxattr(int fd, const char __user *name,
+			      void __user *value, size_t size);
+asmlinkage long compat_sys_listxattr(const char __user *path, char __user *list,
+			      size_t size);
+asmlinkage long compat_sys_llistxattr(const char __user *path, char __user *list,
+			       size_t size);
+asmlinkage long compat_sys_flistxattr(int fd, char __user *list, size_t size);
+asmlinkage long compat_sys_listxattr(const char __user *path, char __user *list,
+			      size_t size);
+asmlinkage long compat_sys_llistxattr(const char __user *path, char __user *list,
+			       size_t size);
+asmlinkage long compat_sys_flistxattr(int fd, char __user *list, size_t size);
+asmlinkage long compat_sys_removexattr(const char __user *path,
+				const char __user *name);
+asmlinkage long compat_sys_lremovexattr(const char __user *path,
+				 const char __user *name);
+asmlinkage long compat_sys_fremovexattr(int fd, const char __user *name);
+asmlinkage long compat_sys_set_tid_address(int __user *tidptr);
+asmlinkage long compat_sys_epoll_ctl(int epfd, int op, int fd,
+				struct epoll_event __user *event);
+asmlinkage long compat_sys_epoll_wait(int epfd, struct epoll_event __user *events,
+				int maxevents, int timeout);
+asmlinkage long compat_sys_io_destroy(aio_context_t ctx);
+asmlinkage long compat_sys_io_cancel(aio_context_t ctx_id, struct iocb __user *iocb,
+			      struct io_event __user *result);
+asmlinkage long compat_sys_mq_unlink(const char __user *name);
+asmlinkage long compat_sys_add_key(const char __user *_type,
+			    const char __user *_description,
+			    const void __user *_payload,
+			    size_t plen,
+			    key_serial_t destringid);
+asmlinkage long compat_sys_request_key(const char __user *_type,
+				const char __user *_description,
+				const char __user *_callout_info,
+				key_serial_t destringid);
+asmlinkage long compat_sys_remap_file_pages(unsigned long start, unsigned long size,
+			unsigned long prot, unsigned long pgoff,
+			unsigned long flags);
+asmlinkage long compat_sys_inotify_add_watch(int fd, const char __user *path,
+					u32 mask);
+asmlinkage long compat_sys_mknodat(int dfd, const char __user * filename, umode_t mode,
+			    unsigned dev);
+asmlinkage long compat_sys_mkdirat(int dfd, const char __user * pathname, umode_t mode);
+asmlinkage long compat_sys_fchownat(int dfd, const char __user *filename, uid_t user,
+			     gid_t group, int flag);
+asmlinkage long compat_sys_unlinkat(int dfd, const char __user * pathname, int flag);
+asmlinkage long compat_sys_renameat(int olddfd, const char __user * oldname,
+			     int newdfd, const char __user * newname);
+asmlinkage long compat_sys_symlinkat(const char __user * oldname,
+			      int newdfd, const char __user * newname);
+asmlinkage long compat_sys_linkat(int olddfd, const char __user *oldname,
+			   int newdfd, const char __user *newname, int flags);
+asmlinkage long compat_sys_readlinkat(int dfd, const char __user *path, char __user *buf,
+			       int bufsiz);
+asmlinkage long compat_sys_fchmodat(int dfd, const char __user * filename,
+			     umode_t mode);
+asmlinkage long compat_sys_faccessat(int dfd, const char __user *filename, int mode);
+asmlinkage long compat_sys_unshare(unsigned long unshare_flags);
+asmlinkage long compat_sys_splice(int fd_in, loff_t __user *off_in,
+			   int fd_out, loff_t __user *off_out,
+			   size_t len, unsigned int flags);
+asmlinkage long compat_sys_tee(int fdin, int fdout, size_t len, unsigned int flags);
+asmlinkage long compat_sys_getcpu(unsigned __user *cpu, unsigned __user *node, struct getcpu_cache __user *cache);
+asmlinkage long compat_sys_pipe2(int __user *fildes, int flags);
+asmlinkage long compat_sys_perf_event_open(
+		struct perf_event_attr __user *attr_uptr,
+		pid_t pid, int cpu, int group_fd, unsigned long flags);
+
+#ifdef CONFIG_CLONE_BACKWARDS
+asmlinkage long compat_sys_clone(unsigned long, unsigned long, int __user *, unsigned long,
+	       int __user *);
+#else
+#ifdef CONFIG_CLONE_BACKWARDS3
+asmlinkage long compat_sys_clone(unsigned long, unsigned long, int, int __user *,
+			  int __user *, unsigned long);
+#else
+asmlinkage long compat_sys_clone(unsigned long, unsigned long, int __user *,
+	       int __user *, unsigned long);
+#endif
+#endif
+
+asmlinkage long compat_sys_prlimit64(pid_t pid, unsigned int resource,
+				const struct rlimit64 __user *new_rlim,
+				struct rlimit64 __user *old_rlim);
+asmlinkage long compat_sys_name_to_handle_at(int dfd, const char __user *name,
+				      struct file_handle __user *handle,
+				      int __user *mnt_id, int flag);
+asmlinkage long compat_sys_kcmp(pid_t pid1, pid_t pid2, int type,
+			 unsigned long idx1, unsigned long idx2);
+asmlinkage long compat_sys_finit_module(int fd, const char __user *uargs, int flags);
+asmlinkage long compat_sys_sched_setattr(pid_t pid,
+					struct sched_attr __user *attr,
+					unsigned int flags);
+asmlinkage long compat_sys_sched_getattr(pid_t pid,
+					struct sched_attr __user *attr,
+					unsigned int size,
+					unsigned int flags);
+asmlinkage long compat_sys_renameat2(int olddfd, const char __user *oldname,
+			      int newdfd, const char __user *newname,
+			      unsigned int flags);
+asmlinkage long compat_sys_seccomp(unsigned int op, unsigned int flags,
+			    const char __user *uargs);
+asmlinkage long compat_sys_getrandom(char __user *buf, size_t count,
+			      unsigned int flags);
+asmlinkage long compat_sys_memfd_create(const char __user *uname_ptr, unsigned int flags);
+asmlinkage long compat_sys_bpf(int cmd, union bpf_attr *attr, unsigned int size);
+asmlinkage long compat_sys_socketpair(int, int, int, int __user *);
+asmlinkage long compat_sys_bind(int, struct sockaddr __user *, int);
+asmlinkage long compat_sys_connect(int, struct sockaddr __user *, int);
+asmlinkage long compat_sys_accept4(int, struct sockaddr __user *, int __user *, int);
+asmlinkage long compat_sys_getsockname(int, struct sockaddr __user *, int __user *);
+asmlinkage long compat_sys_getpeername(int, struct sockaddr __user *, int __user *);
+asmlinkage long compat_sys_sendto(int, void __user *, size_t, unsigned,
+				struct sockaddr __user *, int);
+asmlinkage long compat_sys_mlock2(unsigned long start, size_t len, int flags);
+
+#endif  /*__COMPAT_WRAPPER */
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 1324b02..5a5c53c 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -29,46 +29,50 @@
 #define __SC_COMP_3264(_nr, _32, _64, _comp) __SC_3264(_nr, _32, _64)
 #endif
 
+#ifndef __SC_WRAP
+#define __SC_WRAP(x,y) __SYSCALL(x, y)
+#endif
+
 #define __NR_io_setup 0
 __SC_COMP(__NR_io_setup, sys_io_setup, compat_sys_io_setup)
 #define __NR_io_destroy 1
-__SYSCALL(__NR_io_destroy, sys_io_destroy)
+__SC_WRAP(__NR_io_destroy, sys_io_destroy)
 #define __NR_io_submit 2
 __SC_COMP(__NR_io_submit, sys_io_submit, compat_sys_io_submit)
 #define __NR_io_cancel 3
-__SYSCALL(__NR_io_cancel, sys_io_cancel)
+__SC_WRAP(__NR_io_cancel, sys_io_cancel)
 #define __NR_io_getevents 4
 __SC_COMP(__NR_io_getevents, sys_io_getevents, compat_sys_io_getevents)
 
 /* fs/xattr.c */
 #define __NR_setxattr 5
-__SYSCALL(__NR_setxattr, sys_setxattr)
+__SC_WRAP(__NR_setxattr, sys_setxattr)
 #define __NR_lsetxattr 6
-__SYSCALL(__NR_lsetxattr, sys_lsetxattr)
+__SC_WRAP(__NR_lsetxattr, sys_lsetxattr)
 #define __NR_fsetxattr 7
-__SYSCALL(__NR_fsetxattr, sys_fsetxattr)
+__SC_WRAP(__NR_fsetxattr, sys_fsetxattr)
 #define __NR_getxattr 8
-__SYSCALL(__NR_getxattr, sys_getxattr)
+__SC_WRAP(__NR_getxattr, sys_getxattr)
 #define __NR_lgetxattr 9
-__SYSCALL(__NR_lgetxattr, sys_lgetxattr)
+__SC_WRAP(__NR_lgetxattr, sys_lgetxattr)
 #define __NR_fgetxattr 10
-__SYSCALL(__NR_fgetxattr, sys_fgetxattr)
+__SC_WRAP(__NR_fgetxattr, sys_fgetxattr)
 #define __NR_listxattr 11
-__SYSCALL(__NR_listxattr, sys_listxattr)
+__SC_WRAP(__NR_listxattr, sys_listxattr)
 #define __NR_llistxattr 12
-__SYSCALL(__NR_llistxattr, sys_llistxattr)
+__SC_WRAP(__NR_llistxattr, sys_llistxattr)
 #define __NR_flistxattr 13
-__SYSCALL(__NR_flistxattr, sys_flistxattr)
+__SC_WRAP(__NR_flistxattr, sys_flistxattr)
 #define __NR_removexattr 14
-__SYSCALL(__NR_removexattr, sys_removexattr)
+__SC_WRAP(__NR_removexattr, sys_removexattr)
 #define __NR_lremovexattr 15
-__SYSCALL(__NR_lremovexattr, sys_lremovexattr)
+__SC_WRAP(__NR_lremovexattr, sys_lremovexattr)
 #define __NR_fremovexattr 16
-__SYSCALL(__NR_fremovexattr, sys_fremovexattr)
+__SC_WRAP(__NR_fremovexattr, sys_fremovexattr)
 
 /* fs/dcache.c */
 #define __NR_getcwd 17
-__SYSCALL(__NR_getcwd, sys_getcwd)
+__SC_WRAP(__NR_getcwd, sys_getcwd)
 
 /* fs/cookies.c */
 #define __NR_lookup_dcookie 18
@@ -82,7 +86,7 @@ __SYSCALL(__NR_eventfd2, sys_eventfd2)
 #define __NR_epoll_create1 20
 __SYSCALL(__NR_epoll_create1, sys_epoll_create1)
 #define __NR_epoll_ctl 21
-__SYSCALL(__NR_epoll_ctl, sys_epoll_ctl)
+__SC_WRAP(__NR_epoll_ctl, sys_epoll_ctl)
 #define __NR_epoll_pwait 22
 __SC_COMP(__NR_epoll_pwait, sys_epoll_pwait, compat_sys_epoll_pwait)
 
@@ -98,7 +102,7 @@ __SC_COMP_3264(__NR3264_fcntl, sys_fcntl64, sys_fcntl, compat_sys_fcntl64)
 #define __NR_inotify_init1 26
 __SYSCALL(__NR_inotify_init1, sys_inotify_init1)
 #define __NR_inotify_add_watch 27
-__SYSCALL(__NR_inotify_add_watch, sys_inotify_add_watch)
+__SC_WRAP(__NR_inotify_add_watch, sys_inotify_add_watch)
 #define __NR_inotify_rm_watch 28
 __SYSCALL(__NR_inotify_rm_watch, sys_inotify_rm_watch)
 
@@ -118,17 +122,17 @@ __SYSCALL(__NR_flock, sys_flock)
 
 /* fs/namei.c */
 #define __NR_mknodat 33
-__SYSCALL(__NR_mknodat, sys_mknodat)
+__SC_WRAP(__NR_mknodat, sys_mknodat)
 #define __NR_mkdirat 34
-__SYSCALL(__NR_mkdirat, sys_mkdirat)
+__SC_WRAP(__NR_mkdirat, sys_mkdirat)
 #define __NR_unlinkat 35
-__SYSCALL(__NR_unlinkat, sys_unlinkat)
+__SC_WRAP(__NR_unlinkat, sys_unlinkat)
 #define __NR_symlinkat 36
-__SYSCALL(__NR_symlinkat, sys_symlinkat)
+__SC_WRAP(__NR_symlinkat, sys_symlinkat)
 #define __NR_linkat 37
-__SYSCALL(__NR_linkat, sys_linkat)
+__SC_WRAP(__NR_linkat, sys_linkat)
 #define __NR_renameat 38
-__SYSCALL(__NR_renameat, sys_renameat)
+__SC_WRAP(__NR_renameat, sys_renameat)
 
 /* fs/namespace.c */
 #define __NR_umount2 39
@@ -136,7 +140,7 @@ __SYSCALL(__NR_umount2, sys_umount)
 #define __NR_mount 40
 __SC_COMP(__NR_mount, sys_mount, compat_sys_mount)
 #define __NR_pivot_root 41
-__SYSCALL(__NR_pivot_root, sys_pivot_root)
+__SC_WRAP(__NR_pivot_root, sys_pivot_root)
 
 /* fs/nfsctl.c */
 #define __NR_nfsservctl 42
@@ -159,19 +163,19 @@ __SC_COMP_3264(__NR3264_ftruncate, sys_ftruncate64, sys_ftruncate, \
 #define __NR_fallocate 47
 __SC_COMP(__NR_fallocate, sys_fallocate, compat_sys_fallocate)
 #define __NR_faccessat 48
-__SYSCALL(__NR_faccessat, sys_faccessat)
+__SC_WRAP(__NR_faccessat, sys_faccessat)
 #define __NR_chdir 49
-__SYSCALL(__NR_chdir, sys_chdir)
+__SC_WRAP(__NR_chdir, sys_chdir)
 #define __NR_fchdir 50
 __SYSCALL(__NR_fchdir, sys_fchdir)
 #define __NR_chroot 51
-__SYSCALL(__NR_chroot, sys_chroot)
+__SC_WRAP(__NR_chroot, sys_chroot)
 #define __NR_fchmod 52
 __SYSCALL(__NR_fchmod, sys_fchmod)
 #define __NR_fchmodat 53
-__SYSCALL(__NR_fchmodat, sys_fchmodat)
+__SC_WRAP(__NR_fchmodat, sys_fchmodat)
 #define __NR_fchownat 54
-__SYSCALL(__NR_fchownat, sys_fchownat)
+__SC_WRAP(__NR_fchownat, sys_fchownat)
 #define __NR_fchown 55
 __SYSCALL(__NR_fchown, sys_fchown)
 #define __NR_openat 56
@@ -183,11 +187,11 @@ __SYSCALL(__NR_vhangup, sys_vhangup)
 
 /* fs/pipe.c */
 #define __NR_pipe2 59
-__SYSCALL(__NR_pipe2, sys_pipe2)
+__SC_WRAP(__NR_pipe2, sys_pipe2)
 
 /* fs/quota.c */
 #define __NR_quotactl 60
-__SYSCALL(__NR_quotactl, sys_quotactl)
+__SC_WRAP(__NR_quotactl, sys_quotactl)
 
 /* fs/readdir.c */
 #define __NR_getdents64 61
@@ -232,13 +236,13 @@ __SC_COMP(__NR_signalfd4, sys_signalfd4, compat_sys_signalfd4)
 #define __NR_vmsplice 75
 __SC_COMP(__NR_vmsplice, sys_vmsplice, compat_sys_vmsplice)
 #define __NR_splice 76
-__SYSCALL(__NR_splice, sys_splice)
+__SC_WRAP(__NR_splice, sys_splice)
 #define __NR_tee 77
-__SYSCALL(__NR_tee, sys_tee)
+__SC_WRAP(__NR_tee, sys_tee)
 
 /* fs/stat.c */
 #define __NR_readlinkat 78
-__SYSCALL(__NR_readlinkat, sys_readlinkat)
+__SC_WRAP(__NR_readlinkat, sys_readlinkat)
 #define __NR3264_fstatat 79
 __SC_3264(__NR3264_fstatat, sys_fstatat64, sys_newfstatat)
 #define __NR3264_fstat 80
@@ -277,13 +281,13 @@ __SC_COMP(__NR_utimensat, sys_utimensat, compat_sys_utimensat)
 
 /* kernel/acct.c */
 #define __NR_acct 89
-__SYSCALL(__NR_acct, sys_acct)
+__SC_WRAP(__NR_acct, sys_acct)
 
 /* kernel/capability.c */
 #define __NR_capget 90
-__SYSCALL(__NR_capget, sys_capget)
+__SC_WRAP(__NR_capget, sys_capget)
 #define __NR_capset 91
-__SYSCALL(__NR_capset, sys_capset)
+__SC_WRAP(__NR_capset, sys_capset)
 
 /* kernel/exec_domain.c */
 #define __NR_personality 92
@@ -299,9 +303,9 @@ __SC_COMP(__NR_waitid, sys_waitid, compat_sys_waitid)
 
 /* kernel/fork.c */
 #define __NR_set_tid_address 96
-__SYSCALL(__NR_set_tid_address, sys_set_tid_address)
+__SC_WRAP(__NR_set_tid_address, sys_set_tid_address)
 #define __NR_unshare 97
-__SYSCALL(__NR_unshare, sys_unshare)
+__SC_WRAP(__NR_unshare, sys_unshare)
 
 /* kernel/futex.c */
 #define __NR_futex 98
@@ -329,9 +333,9 @@ __SC_COMP(__NR_kexec_load, sys_kexec_load, compat_sys_kexec_load)
 
 /* kernel/module.c */
 #define __NR_init_module 105
-__SYSCALL(__NR_init_module, sys_init_module)
+__SC_WRAP(__NR_init_module, sys_init_module)
 #define __NR_delete_module 106
-__SYSCALL(__NR_delete_module, sys_delete_module)
+__SC_WRAP(__NR_delete_module, sys_delete_module)
 
 /* kernel/posix-timers.c */
 #define __NR_timer_create 107
@@ -356,7 +360,7 @@ __SC_COMP(__NR_clock_nanosleep, sys_clock_nanosleep, \
 
 /* kernel/printk.c */
 #define __NR_syslog 116
-__SYSCALL(__NR_syslog, sys_syslog)
+__SC_WRAP(__NR_syslog, sys_syslog)
 
 /* kernel/ptrace.c */
 #define __NR_ptrace 117
@@ -364,13 +368,13 @@ __SYSCALL(__NR_ptrace, sys_ptrace)
 
 /* kernel/sched/core.c */
 #define __NR_sched_setparam 118
-__SYSCALL(__NR_sched_setparam, sys_sched_setparam)
+__SC_WRAP(__NR_sched_setparam, sys_sched_setparam)
 #define __NR_sched_setscheduler 119
-__SYSCALL(__NR_sched_setscheduler, sys_sched_setscheduler)
+__SC_WRAP(__NR_sched_setscheduler, sys_sched_setscheduler)
 #define __NR_sched_getscheduler 120
 __SYSCALL(__NR_sched_getscheduler, sys_sched_getscheduler)
 #define __NR_sched_getparam 121
-__SYSCALL(__NR_sched_getparam, sys_sched_getparam)
+__SC_WRAP(__NR_sched_getparam, sys_sched_getparam)
 #define __NR_sched_setaffinity 122
 __SC_COMP(__NR_sched_setaffinity, sys_sched_setaffinity, \
 	  compat_sys_sched_setaffinity)
@@ -421,7 +425,7 @@ __SYSCALL(__NR_setpriority, sys_setpriority)
 #define __NR_getpriority 141
 __SYSCALL(__NR_getpriority, sys_getpriority)
 #define __NR_reboot 142
-__SYSCALL(__NR_reboot, sys_reboot)
+__SC_WRAP(__NR_reboot, sys_reboot)
 #define __NR_setregid 143
 __SYSCALL(__NR_setregid, sys_setregid)
 #define __NR_setgid 144
@@ -433,11 +437,11 @@ __SYSCALL(__NR_setuid, sys_setuid)
 #define __NR_setresuid 147
 __SYSCALL(__NR_setresuid, sys_setresuid)
 #define __NR_getresuid 148
-__SYSCALL(__NR_getresuid, sys_getresuid)
+__SC_WRAP(__NR_getresuid, sys_getresuid)
 #define __NR_setresgid 149
 __SYSCALL(__NR_setresgid, sys_setresgid)
 #define __NR_getresgid 150
-__SYSCALL(__NR_getresgid, sys_getresgid)
+__SC_WRAP(__NR_getresgid, sys_getresgid)
 #define __NR_setfsuid 151
 __SYSCALL(__NR_setfsuid, sys_setfsuid)
 #define __NR_setfsgid 152
@@ -453,15 +457,15 @@ __SYSCALL(__NR_getsid, sys_getsid)
 #define __NR_setsid 157
 __SYSCALL(__NR_setsid, sys_setsid)
 #define __NR_getgroups 158
-__SYSCALL(__NR_getgroups, sys_getgroups)
+__SC_WRAP(__NR_getgroups, sys_getgroups)
 #define __NR_setgroups 159
-__SYSCALL(__NR_setgroups, sys_setgroups)
+__SC_WRAP(__NR_setgroups, sys_setgroups)
 #define __NR_uname 160
-__SYSCALL(__NR_uname, sys_newuname)
+__SC_WRAP(__NR_uname, sys_newuname)
 #define __NR_sethostname 161
-__SYSCALL(__NR_sethostname, sys_sethostname)
+__SC_WRAP(__NR_sethostname, sys_sethostname)
 #define __NR_setdomainname 162
-__SYSCALL(__NR_setdomainname, sys_setdomainname)
+__SC_WRAP(__NR_setdomainname, sys_setdomainname)
 #define __NR_getrlimit 163
 __SC_COMP(__NR_getrlimit, sys_getrlimit, compat_sys_getrlimit)
 #define __NR_setrlimit 164
@@ -471,9 +475,9 @@ __SC_COMP(__NR_getrusage, sys_getrusage, compat_sys_getrusage)
 #define __NR_umask 166
 __SYSCALL(__NR_umask, sys_umask)
 #define __NR_prctl 167
-__SYSCALL(__NR_prctl, sys_prctl)
+__SC_WRAP(__NR_prctl, sys_prctl)
 #define __NR_getcpu 168
-__SYSCALL(__NR_getcpu, sys_getcpu)
+__SC_WRAP(__NR_getcpu, sys_getcpu)
 
 /* kernel/time.c */
 #define __NR_gettimeofday 169
@@ -505,7 +509,7 @@ __SC_COMP(__NR_sysinfo, sys_sysinfo, compat_sys_sysinfo)
 #define __NR_mq_open 180
 __SC_COMP(__NR_mq_open, sys_mq_open, compat_sys_mq_open)
 #define __NR_mq_unlink 181
-__SYSCALL(__NR_mq_unlink, sys_mq_unlink)
+__SC_WRAP(__NR_mq_unlink, sys_mq_unlink)
 #define __NR_mq_timedsend 182
 __SC_COMP(__NR_mq_timedsend, sys_mq_timedsend, compat_sys_mq_timedsend)
 #define __NR_mq_timedreceive 183
@@ -550,21 +554,21 @@ __SYSCALL(__NR_shmdt, sys_shmdt)
 #define __NR_socket 198
 __SYSCALL(__NR_socket, sys_socket)
 #define __NR_socketpair 199
-__SYSCALL(__NR_socketpair, sys_socketpair)
+__SC_WRAP(__NR_socketpair, sys_socketpair)
 #define __NR_bind 200
-__SYSCALL(__NR_bind, sys_bind)
+__SC_WRAP(__NR_bind, sys_bind)
 #define __NR_listen 201
 __SYSCALL(__NR_listen, sys_listen)
 #define __NR_accept 202
 __SYSCALL(__NR_accept, sys_accept)
 #define __NR_connect 203
-__SYSCALL(__NR_connect, sys_connect)
+__SC_WRAP(__NR_connect, sys_connect)
 #define __NR_getsockname 204
-__SYSCALL(__NR_getsockname, sys_getsockname)
+__SC_WRAP(__NR_getsockname, sys_getsockname)
 #define __NR_getpeername 205
-__SYSCALL(__NR_getpeername, sys_getpeername)
+__SC_WRAP(__NR_getpeername, sys_getpeername)
 #define __NR_sendto 206
-__SYSCALL(__NR_sendto, sys_sendto)
+__SC_WRAP(__NR_sendto, sys_sendto)
 #define __NR_recvfrom 207
 __SC_COMP(__NR_recvfrom, sys_recvfrom, compat_sys_recvfrom)
 #define __NR_setsockopt 208
@@ -584,23 +588,23 @@ __SC_COMP(__NR_readahead, sys_readahead, compat_sys_readahead)
 
 /* mm/nommu.c, also with MMU */
 #define __NR_brk 214
-__SYSCALL(__NR_brk, sys_brk)
+__SC_WRAP(__NR_brk, sys_brk)
 #define __NR_munmap 215
-__SYSCALL(__NR_munmap, sys_munmap)
+__SC_WRAP(__NR_munmap, sys_munmap)
 #define __NR_mremap 216
-__SYSCALL(__NR_mremap, sys_mremap)
+__SC_WRAP(__NR_mremap, sys_mremap)
 
 /* security/keys/keyctl.c */
 #define __NR_add_key 217
-__SYSCALL(__NR_add_key, sys_add_key)
+__SC_WRAP(__NR_add_key, sys_add_key)
 #define __NR_request_key 218
-__SYSCALL(__NR_request_key, sys_request_key)
+__SC_WRAP(__NR_request_key, sys_request_key)
 #define __NR_keyctl 219
 __SC_COMP(__NR_keyctl, sys_keyctl, compat_sys_keyctl)
 
 /* arch/example/kernel/sys_example.c */
 #define __NR_clone 220
-__SYSCALL(__NR_clone, sys_clone)
+__SC_WRAP(__NR_clone, sys_clone)
 #define __NR_execve 221
 __SC_COMP(__NR_execve, sys_execve, compat_sys_execve)
 
@@ -613,27 +617,27 @@ __SC_COMP(__NR3264_fadvise64, sys_fadvise64_64, compat_sys_fadvise64_64)
 /* mm/, CONFIG_MMU only */
 #ifndef __ARCH_NOMMU
 #define __NR_swapon 224
-__SYSCALL(__NR_swapon, sys_swapon)
+__SC_WRAP(__NR_swapon, sys_swapon)
 #define __NR_swapoff 225
-__SYSCALL(__NR_swapoff, sys_swapoff)
+__SC_WRAP(__NR_swapoff, sys_swapoff)
 #define __NR_mprotect 226
-__SYSCALL(__NR_mprotect, sys_mprotect)
+__SC_WRAP(__NR_mprotect, sys_mprotect)
 #define __NR_msync 227
-__SYSCALL(__NR_msync, sys_msync)
+__SC_WRAP(__NR_msync, sys_msync)
 #define __NR_mlock 228
-__SYSCALL(__NR_mlock, sys_mlock)
+__SC_WRAP(__NR_mlock, sys_mlock)
 #define __NR_munlock 229
-__SYSCALL(__NR_munlock, sys_munlock)
+__SC_WRAP(__NR_munlock, sys_munlock)
 #define __NR_mlockall 230
 __SYSCALL(__NR_mlockall, sys_mlockall)
 #define __NR_munlockall 231
 __SYSCALL(__NR_munlockall, sys_munlockall)
 #define __NR_mincore 232
-__SYSCALL(__NR_mincore, sys_mincore)
+__SC_WRAP(__NR_mincore, sys_mincore)
 #define __NR_madvise 233
-__SYSCALL(__NR_madvise, sys_madvise)
+__SC_WRAP(__NR_madvise, sys_madvise)
 #define __NR_remap_file_pages 234
-__SYSCALL(__NR_remap_file_pages, sys_remap_file_pages)
+__SC_WRAP(__NR_remap_file_pages, sys_remap_file_pages)
 #define __NR_mbind 235
 __SC_COMP(__NR_mbind, sys_mbind, compat_sys_mbind)
 #define __NR_get_mempolicy 236
@@ -650,9 +654,9 @@ __SC_COMP(__NR_move_pages, sys_move_pages, compat_sys_move_pages)
 __SC_COMP(__NR_rt_tgsigqueueinfo, sys_rt_tgsigqueueinfo, \
 	  compat_sys_rt_tgsigqueueinfo)
 #define __NR_perf_event_open 241
-__SYSCALL(__NR_perf_event_open, sys_perf_event_open)
+__SC_WRAP(__NR_perf_event_open, sys_perf_event_open)
 #define __NR_accept4 242
-__SYSCALL(__NR_accept4, sys_accept4)
+__SC_WRAP(__NR_accept4, sys_accept4)
 #define __NR_recvmmsg 243
 __SC_COMP(__NR_recvmmsg, sys_recvmmsg, compat_sys_recvmmsg)
 
@@ -665,13 +669,13 @@ __SC_COMP(__NR_recvmmsg, sys_recvmmsg, compat_sys_recvmmsg)
 #define __NR_wait4 260
 __SC_COMP(__NR_wait4, sys_wait4, compat_sys_wait4)
 #define __NR_prlimit64 261
-__SYSCALL(__NR_prlimit64, sys_prlimit64)
+__SC_WRAP(__NR_prlimit64, sys_prlimit64)
 #define __NR_fanotify_init 262
 __SYSCALL(__NR_fanotify_init, sys_fanotify_init)
 #define __NR_fanotify_mark 263
 __SYSCALL(__NR_fanotify_mark, sys_fanotify_mark)
 #define __NR_name_to_handle_at         264
-__SYSCALL(__NR_name_to_handle_at, sys_name_to_handle_at)
+__SC_WRAP(__NR_name_to_handle_at, sys_name_to_handle_at)
 #define __NR_open_by_handle_at         265
 __SC_COMP(__NR_open_by_handle_at, sys_open_by_handle_at, \
 	  compat_sys_open_by_handle_at)
@@ -690,23 +694,23 @@ __SC_COMP(__NR_process_vm_readv, sys_process_vm_readv, \
 __SC_COMP(__NR_process_vm_writev, sys_process_vm_writev, \
           compat_sys_process_vm_writev)
 #define __NR_kcmp 272
-__SYSCALL(__NR_kcmp, sys_kcmp)
+__SC_WRAP(__NR_kcmp, sys_kcmp)
 #define __NR_finit_module 273
-__SYSCALL(__NR_finit_module, sys_finit_module)
+__SC_WRAP(__NR_finit_module, sys_finit_module)
 #define __NR_sched_setattr 274
-__SYSCALL(__NR_sched_setattr, sys_sched_setattr)
+__SC_WRAP(__NR_sched_setattr, sys_sched_setattr)
 #define __NR_sched_getattr 275
-__SYSCALL(__NR_sched_getattr, sys_sched_getattr)
+__SC_WRAP(__NR_sched_getattr, sys_sched_getattr)
 #define __NR_renameat2 276
-__SYSCALL(__NR_renameat2, sys_renameat2)
+__SC_WRAP(__NR_renameat2, sys_renameat2)
 #define __NR_seccomp 277
-__SYSCALL(__NR_seccomp, sys_seccomp)
+__SC_WRAP(__NR_seccomp, sys_seccomp)
 #define __NR_getrandom 278
-__SYSCALL(__NR_getrandom, sys_getrandom)
+__SC_WRAP(__NR_getrandom, sys_getrandom)
 #define __NR_memfd_create 279
-__SYSCALL(__NR_memfd_create, sys_memfd_create)
+__SC_WRAP(__NR_memfd_create, sys_memfd_create)
 #define __NR_bpf 280
-__SYSCALL(__NR_bpf, sys_bpf)
+__SC_WRAP(__NR_bpf, sys_bpf)
 #define __NR_execveat 281
 __SC_COMP(__NR_execveat, sys_execveat, compat_sys_execveat)
 #define __NR_userfaultfd 282
@@ -714,7 +718,7 @@ __SYSCALL(__NR_userfaultfd, sys_userfaultfd)
 #define __NR_membarrier 283
 __SYSCALL(__NR_membarrier, sys_membarrier)
 #define __NR_mlock2 284
-__SYSCALL(__NR_mlock2, sys_mlock2)
+__SC_WRAP(__NR_mlock2, sys_mlock2)
 
 #undef __NR_syscalls
 #define __NR_syscalls 285
@@ -731,29 +735,29 @@ __SYSCALL(__NR_mlock2, sys_mlock2)
 #define __NR_open 1024
 __SYSCALL(__NR_open, sys_open)
 #define __NR_link 1025
-__SYSCALL(__NR_link, sys_link)
+__SC_WRAP(__NR_link, sys_link)
 #define __NR_unlink 1026
-__SYSCALL(__NR_unlink, sys_unlink)
+__SC_WRAP(__NR_unlink, sys_unlink)
 #define __NR_mknod 1027
-__SYSCALL(__NR_mknod, sys_mknod)
+__SC_WRAP(__NR_mknod, sys_mknod)
 #define __NR_chmod 1028
-__SYSCALL(__NR_chmod, sys_chmod)
+__SC_WRAP(__NR_chmod, sys_chmod)
 #define __NR_chown 1029
-__SYSCALL(__NR_chown, sys_chown)
+__SC_WRAP(__NR_chown, sys_chown)
 #define __NR_mkdir 1030
-__SYSCALL(__NR_mkdir, sys_mkdir)
+__SC_WRAP(__NR_mkdir, sys_mkdir)
 #define __NR_rmdir 1031
-__SYSCALL(__NR_rmdir, sys_rmdir)
+__SC_WRAP(__NR_rmdir, sys_rmdir)
 #define __NR_lchown 1032
-__SYSCALL(__NR_lchown, sys_lchown)
+__SC_WRAP(__NR_lchown, sys_lchown)
 #define __NR_access 1033
-__SYSCALL(__NR_access, sys_access)
+__SC_WRAP(__NR_access, sys_access)
 #define __NR_rename 1034
-__SYSCALL(__NR_rename, sys_rename)
+__SC_WRAP(__NR_rename, sys_rename)
 #define __NR_readlink 1035
-__SYSCALL(__NR_readlink, sys_readlink)
+__SC_WRAP(__NR_readlink, sys_readlink)
 #define __NR_symlink 1036
-__SYSCALL(__NR_symlink, sys_symlink)
+__SC_WRAP(__NR_symlink, sys_symlink)
 #define __NR_utimes 1037
 __SYSCALL(__NR_utimes, sys_utimes)
 #define __NR3264_stat 1038
@@ -767,7 +771,7 @@ __SC_3264(__NR3264_lstat, sys_lstat64, sys_newlstat)
 
 #ifdef __ARCH_WANT_SYSCALL_NO_FLAGS
 #define __NR_pipe 1040
-__SYSCALL(__NR_pipe, sys_pipe)
+__SC_WRAP(__NR_pipe, sys_pipe)
 #define __NR_dup2 1041
 __SYSCALL(__NR_dup2, sys_dup2)
 #define __NR_epoll_create 1042
@@ -837,7 +841,7 @@ __SYSCALL(__NR_time, sys_time)
 __SYSCALL(__NR_utime, sys_utime)
 
 #define __NR_creat 1064
-__SYSCALL(__NR_creat, sys_creat)
+__SC_WRAP(__NR_creat, sys_creat)
 #define __NR_getdents 1065
 #define __ARCH_WANT_SYS_GETDENTS
 __SYSCALL(__NR_getdents, sys_getdents)
@@ -847,9 +851,9 @@ __SYSCALL(__NR_futimesat, sys_futimesat)
 #define __ARCH_WANT_SYS_SELECT
 __SYSCALL(__NR_select, sys_select)
 #define __NR_poll 1068
-__SYSCALL(__NR_poll, sys_poll)
+__SC_WRAP(__NR_poll, sys_poll)
 #define __NR_epoll_wait 1069
-__SYSCALL(__NR_epoll_wait, sys_epoll_wait)
+__SC_WRAP(__NR_epoll_wait, sys_epoll_wait)
 #define __NR_ustat 1070
 __SYSCALL(__NR_ustat, sys_ustat)
 #define __NR_vfork 1071
@@ -861,12 +865,12 @@ __SYSCALL(__NR_recv, sys_recv)
 #define __NR_send 1074
 __SYSCALL(__NR_send, sys_send)
 #define __NR_bdflush 1075
-__SYSCALL(__NR_bdflush, sys_bdflush)
+__SC_WRAP(__NR_bdflush, sys_bdflush)
 #define __NR_umount 1076
-__SYSCALL(__NR_umount, sys_oldumount)
+__SC_WRAP(__NR_umount, sys_oldumount)
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __NR_uselib 1077
-__SYSCALL(__NR_uselib, sys_uselib)
+__SC_WRAP(__NR_uselib, sys_uselib)
 #define __NR__sysctl 1078
 __SYSCALL(__NR__sysctl, sys_sysctl)
 
diff --git a/kernel/Makefile b/kernel/Makefile
index 53abf00..4c0dc0e 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_TRACEPOINTS) += tracepoint.o
 obj-$(CONFIG_LATENCYTOP) += latencytop.o
 obj-$(CONFIG_BINFMT_ELF) += elfcore.o
 obj-$(CONFIG_COMPAT_BINFMT_ELF) += elfcore.o
+obj-$(CONFIG_COMPAT_WRAPPER)	+= compat_wrapper.o
 obj-$(CONFIG_BINFMT_ELF_FDPIC) += elfcore.o
 obj-$(CONFIG_FUNCTION_TRACER) += trace/
 obj-$(CONFIG_TRACING) += trace/
diff --git a/kernel/compat_wrapper.c b/kernel/compat_wrapper.c
new file mode 100644
index 0000000..4a99811
--- /dev/null
+++ b/kernel/compat_wrapper.c
@@ -0,0 +1,167 @@
+/*
+ *  Compat system call wrappers.
+ *
+ *    Copyright IBM Corp. 2014
+ */
+
+#include <linux/syscalls.h>
+#include <linux/compat.h>
+#include <linux/compat_wrapper.h>
+
+COMPAT_SYSCALL_WRAP2(creat, const char __user *, pathname, umode_t, mode);
+COMPAT_SYSCALL_WRAP2(link, const char __user *, oldname, const char __user *, newname);
+COMPAT_SYSCALL_WRAP1(unlink, const char __user *, pathname);
+COMPAT_SYSCALL_WRAP1(chdir, const char __user *, filename);
+COMPAT_SYSCALL_WRAP3(mknod, const char __user *, filename, umode_t, mode, unsigned, dev);
+COMPAT_SYSCALL_WRAP2(chmod, const char __user *, filename, umode_t, mode);
+
+#ifdef __ARCH_WANT_SYS_OLDUMOUNT
+COMPAT_SYSCALL_WRAP1(oldumount, char __user *, name);
+#endif
+
+COMPAT_SYSCALL_WRAP2(access, const char __user *, filename, int, mode);
+COMPAT_SYSCALL_WRAP2(rename, const char __user *, oldname, const char __user *, newname);
+COMPAT_SYSCALL_WRAP2(mkdir, const char __user *, pathname, umode_t, mode);
+COMPAT_SYSCALL_WRAP1(rmdir, const char __user *, pathname);
+COMPAT_SYSCALL_WRAP1(pipe, int __user *, fildes);
+COMPAT_SYSCALL_WRAP1(brk, unsigned long, brk);
+
+#ifdef __ARCH_WANT_SYS_SIGNAL
+COMPAT_SYSCALL_WRAP2(signal, int, sig, __sighandler_t, handler);
+#endif
+
+COMPAT_SYSCALL_WRAP1(acct, const char __user *, name);
+COMPAT_SYSCALL_WRAP2(umount, char __user *, name, int, flags);
+COMPAT_SYSCALL_WRAP1(chroot, const char __user *, filename);
+COMPAT_SYSCALL_WRAP3(sigsuspend, int, unused1, int, unused2, old_sigset_t, mask);
+COMPAT_SYSCALL_WRAP2(sethostname, char __user *, name, int, len);
+COMPAT_SYSCALL_WRAP2(symlink, const char __user *, old, const char __user *, new);
+COMPAT_SYSCALL_WRAP3(readlink, const char __user *, path, char __user *, buf, int, bufsiz);
+COMPAT_SYSCALL_WRAP1(uselib, const char __user *, library);
+COMPAT_SYSCALL_WRAP2(swapon, const char __user *, specialfile, int, swap_flags);
+COMPAT_SYSCALL_WRAP4(reboot, int, magic1, int, magic2, unsigned int, cmd, void __user *, arg);
+COMPAT_SYSCALL_WRAP2(munmap, unsigned long, addr, size_t, len);
+COMPAT_SYSCALL_WRAP3(syslog, int, type, char __user *, buf, int, len);
+COMPAT_SYSCALL_WRAP1(swapoff, const char __user *, specialfile);
+COMPAT_SYSCALL_WRAP2(setdomainname, char __user *, name, int, len);
+COMPAT_SYSCALL_WRAP1(newuname, struct new_utsname __user *, name);
+COMPAT_SYSCALL_WRAP3(mprotect, unsigned long, start, size_t, len, unsigned long, prot);
+COMPAT_SYSCALL_WRAP3(init_module, void __user *, umod, unsigned long, len, const char __user *, uargs);
+COMPAT_SYSCALL_WRAP2(delete_module, const char __user *, name_user, unsigned int, flags);
+COMPAT_SYSCALL_WRAP4(quotactl, unsigned int, cmd, const char __user *, special, qid_t, id, void __user *, addr);
+COMPAT_SYSCALL_WRAP2(bdflush, int, func, long, data);
+COMPAT_SYSCALL_WRAP3(sysfs, int, option, unsigned long, arg1, unsigned long, arg2);
+
+#ifdef __ARCH_WANT_SYS_LLSEEK
+COMPAT_SYSCALL_WRAP5(llseek, unsigned int, fd, unsigned long, high, unsigned long, low, loff_t __user *, result, unsigned int, whence);
+#endif
+
+COMPAT_SYSCALL_WRAP3(msync, unsigned long, start, size_t, len, int, flags);
+COMPAT_SYSCALL_WRAP2(mlock, unsigned long, start, size_t, len);
+COMPAT_SYSCALL_WRAP2(munlock, unsigned long, start, size_t, len);
+COMPAT_SYSCALL_WRAP2(sched_setparam, pid_t, pid, struct sched_param __user *, param);
+COMPAT_SYSCALL_WRAP2(sched_getparam, pid_t, pid, struct sched_param __user *, param);
+COMPAT_SYSCALL_WRAP3(sched_setscheduler, pid_t, pid, int, policy, struct sched_param __user *, param);
+COMPAT_SYSCALL_WRAP5(mremap, unsigned long, addr, unsigned long, old_len, unsigned long, new_len, unsigned long, flags, unsigned long, new_addr);
+COMPAT_SYSCALL_WRAP3(poll, struct pollfd __user *, ufds, unsigned int, nfds, int, timeout);
+COMPAT_SYSCALL_WRAP5(prctl, int, option, unsigned long, arg2, unsigned long, arg3, unsigned long, arg4, unsigned long, arg5);
+COMPAT_SYSCALL_WRAP2(getcwd, char __user *, buf, unsigned long, size);
+COMPAT_SYSCALL_WRAP2(capget, cap_user_header_t, header, cap_user_data_t, dataptr);
+COMPAT_SYSCALL_WRAP2(capset, cap_user_header_t, header, const cap_user_data_t, data);
+COMPAT_SYSCALL_WRAP3(lchown, const char __user *, filename, uid_t, user, gid_t, group);
+COMPAT_SYSCALL_WRAP2(getgroups, int, gidsetsize, gid_t __user *, grouplist);
+COMPAT_SYSCALL_WRAP2(setgroups, int, gidsetsize, gid_t __user *, grouplist);
+COMPAT_SYSCALL_WRAP3(getresuid, uid_t __user *, ruid, uid_t __user *, euid, uid_t __user *, suid);
+COMPAT_SYSCALL_WRAP3(getresgid, gid_t __user *, rgid, gid_t __user *, egid, gid_t __user *, sgid);
+COMPAT_SYSCALL_WRAP3(chown, const char __user *, filename, uid_t, user, gid_t, group);
+COMPAT_SYSCALL_WRAP2(pivot_root, const char __user *, new_root, const char __user *, put_old);
+COMPAT_SYSCALL_WRAP3(mincore, unsigned long, start, size_t, len, unsigned char __user *, vec);
+COMPAT_SYSCALL_WRAP3(madvise, unsigned long, start, size_t, len, int, behavior);
+COMPAT_SYSCALL_WRAP5(setxattr, const char __user *, path, const char __user *, name, const void __user *, value, size_t, size, int, flags);
+COMPAT_SYSCALL_WRAP5(lsetxattr, const char __user *, path, const char __user *, name, const void __user *, value, size_t, size, int, flags);
+COMPAT_SYSCALL_WRAP5(fsetxattr, int, fd, const char __user *, name, const void __user *, value, size_t, size, int, flags);
+
+#ifndef __ARCH_WANT_COMPAT_SYS_GETDENTS64
+COMPAT_SYSCALL_WRAP3(getdents64, unsigned int, fd, struct linux_dirent64 __user *, dirent, unsigned int, count);
+#endif
+
+COMPAT_SYSCALL_WRAP4(getxattr, const char __user *, path, const char __user *, name, void __user *, value, size_t, size);
+COMPAT_SYSCALL_WRAP4(lgetxattr, const char __user *, path, const char __user *, name, void __user *, value, size_t, size);
+COMPAT_SYSCALL_WRAP4(fgetxattr, int, fd, const char __user *, name, void __user *, value, size_t, size);
+COMPAT_SYSCALL_WRAP3(listxattr, const char __user *, path, char __user *, list, size_t, size);
+COMPAT_SYSCALL_WRAP3(llistxattr, const char __user *, path, char __user *, list, size_t, size);
+COMPAT_SYSCALL_WRAP3(flistxattr, int, fd, char __user *, list, size_t, size);
+COMPAT_SYSCALL_WRAP2(removexattr, const char __user *, path, const char __user *, name);
+COMPAT_SYSCALL_WRAP2(lremovexattr, const char __user *, path, const char __user *, name);
+COMPAT_SYSCALL_WRAP2(fremovexattr, int, fd, const char __user *, name);
+COMPAT_SYSCALL_WRAP1(set_tid_address, int __user *, tidptr);
+COMPAT_SYSCALL_WRAP4(epoll_ctl, int, epfd, int, op, int, fd, struct epoll_event __user *, event);
+COMPAT_SYSCALL_WRAP4(epoll_wait, int, epfd, struct epoll_event __user *, events, int, maxevents, int, timeout);
+COMPAT_SYSCALL_WRAP1(io_destroy, aio_context_t, ctx);
+COMPAT_SYSCALL_WRAP3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb, struct io_event __user *, result);
+COMPAT_SYSCALL_WRAP1(mq_unlink, const char __user *, name);
+COMPAT_SYSCALL_WRAP5(add_key, const char __user *, tp, const char __user *, dsc, const void __user *, pld, size_t, len, key_serial_t, id);
+COMPAT_SYSCALL_WRAP4(request_key, const char __user *, tp, const char __user *, dsc, const char __user *, info, key_serial_t, id);
+COMPAT_SYSCALL_WRAP5(remap_file_pages, unsigned long, start, unsigned long, size, unsigned long, prot, unsigned long, pgoff, unsigned long, flags);
+COMPAT_SYSCALL_WRAP3(inotify_add_watch, int, fd, const char __user *, path, u32, mask);
+COMPAT_SYSCALL_WRAP3(mkdirat, int, dfd, const char __user *, pathname, umode_t, mode);
+COMPAT_SYSCALL_WRAP4(mknodat, int, dfd, const char __user *, filename, umode_t, mode, unsigned, dev);
+COMPAT_SYSCALL_WRAP5(fchownat, int, dfd, const char __user *, filename, uid_t, user, gid_t, group, int, flag);
+COMPAT_SYSCALL_WRAP3(unlinkat, int, dfd, const char __user *, pathname, int, flag);
+COMPAT_SYSCALL_WRAP4(renameat, int, olddfd, const char __user *, oldname, int, newdfd, const char __user *, newname);
+COMPAT_SYSCALL_WRAP5(linkat, int, olddfd, const char __user *, oldname, int, newdfd, const char __user *, newname, int, flags);
+COMPAT_SYSCALL_WRAP3(symlinkat, const char __user *, oldname, int, newdfd, const char __user *, newname);
+COMPAT_SYSCALL_WRAP4(readlinkat, int, dfd, const char __user *, path, char __user *, buf, int, bufsiz);
+COMPAT_SYSCALL_WRAP3(fchmodat, int, dfd, const char __user *, filename, umode_t, mode);
+COMPAT_SYSCALL_WRAP3(faccessat, int, dfd, const char __user *, filename, int, mode);
+COMPAT_SYSCALL_WRAP1(unshare, unsigned long, unshare_flags);
+COMPAT_SYSCALL_WRAP6(splice, int, fd_in, loff_t __user *, off_in, int, fd_out, loff_t __user *, off_out, size_t, len, unsigned int, flags);
+COMPAT_SYSCALL_WRAP4(tee, int, fdin, int, fdout, size_t, len, unsigned int, flags);
+COMPAT_SYSCALL_WRAP3(getcpu, unsigned __user *, cpu, unsigned __user *, node, struct getcpu_cache __user *, cache);
+COMPAT_SYSCALL_WRAP2(pipe2, int __user *, fildes, int, flags);
+COMPAT_SYSCALL_WRAP5(perf_event_open, struct perf_event_attr __user *, attr_uptr, pid_t, pid, int, cpu, int, group_fd, unsigned long, flags);
+
+#ifdef __ARCH_WANT_SYS_CLONE
+#ifdef CONFIG_CLONE_BACKWARDS
+COMPAT_SYSCALL_WRAP5(clone, unsigned long, clone_flags, unsigned long, newsp,
+		 int __user *, parent_tidptr,
+		 unsigned long, tls,
+		 int __user *, child_tidptr);
+#elif defined(CONFIG_CLONE_BACKWARDS2)
+COMPAT_SYSCALL_WRAP5(clone, unsigned long, newsp, unsigned long, clone_flags,
+		 int __user *, parent_tidptr,
+		 int __user *, child_tidptr,
+		 unsigned long, tls);
+#elif defined(CONFIG_CLONE_BACKWARDS3)
+COMPAT_SYSCALL_WRAP6(clone, unsigned long, clone_flags, unsigned long, newsp,
+		int, stack_size,
+		int __user *, parent_tidptr,
+		int __user *, child_tidptr,
+		unsigned long, tls);
+#else
+COMPAT_SYSCALL_WRAP5(clone, unsigned long, clone_flags, unsigned long, newsp,
+		 int __user *, parent_tidptr,
+		 int __user *, child_tidptr,
+		 unsigned long, tls);
+#endif
+#endif
+
+COMPAT_SYSCALL_WRAP4(prlimit64, pid_t, pid, unsigned int, resource, const struct rlimit64 __user *, new_rlim, struct rlimit64 __user *, old_rlim);
+COMPAT_SYSCALL_WRAP5(name_to_handle_at, int, dfd, const char __user *, name, struct file_handle __user *, handle, int __user *, mnt_id, int, flag);
+COMPAT_SYSCALL_WRAP5(kcmp, pid_t, pid1, pid_t, pid2, int, type, unsigned long, idx1, unsigned long, idx2);
+COMPAT_SYSCALL_WRAP3(finit_module, int, fd, const char __user *, uargs, int, flags);
+COMPAT_SYSCALL_WRAP3(sched_setattr, pid_t, pid, struct sched_attr __user *, attr, unsigned int, flags);
+COMPAT_SYSCALL_WRAP4(sched_getattr, pid_t, pid, struct sched_attr __user *, attr, unsigned int, size, unsigned int, flags);
+COMPAT_SYSCALL_WRAP5(renameat2, int, olddfd, const char __user *, oldname, int, newdfd, const char __user *, newname, unsigned int, flags);
+COMPAT_SYSCALL_WRAP3(seccomp, unsigned int, op, unsigned int, flags, const char __user *, uargs)
+COMPAT_SYSCALL_WRAP3(getrandom, char __user *, buf, size_t, count, unsigned int, flags)
+COMPAT_SYSCALL_WRAP2(memfd_create, const char __user *, uname, unsigned int, flags)
+COMPAT_SYSCALL_WRAP3(bpf, int, cmd, union bpf_attr *, attr, unsigned int, size);
+COMPAT_SYSCALL_WRAP4(socketpair, int, family, int, type, int, protocol, int __user *, usockvec);
+COMPAT_SYSCALL_WRAP3(bind, int, fd, struct sockaddr __user *, umyaddr, int, addrlen);
+COMPAT_SYSCALL_WRAP3(connect, int, fd, struct sockaddr __user *, uservaddr, int, addrlen);
+COMPAT_SYSCALL_WRAP4(accept4, int, fd, struct sockaddr __user *, upeer_sockaddr, int __user *, upeer_addrlen, int, flags);
+COMPAT_SYSCALL_WRAP3(getsockname, int, fd, struct sockaddr __user *, usockaddr, int __user *, usockaddr_len);
+COMPAT_SYSCALL_WRAP3(getpeername, int, fd, struct sockaddr __user *, usockaddr, int __user *, usockaddr_len);
+COMPAT_SYSCALL_WRAP6(sendto, int, fd, void __user *, buff, size_t, len, unsigned int, flags, struct sockaddr __user *, addr, int, addr_len);
+COMPAT_SYSCALL_WRAP3(mlock2, unsigned long, start, size_t, len, int, flags);
-- 
2.5.0
