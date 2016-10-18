From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 18 Oct 2016 20:31:38 +0100
Subject: [PATCH 2/3] ARM: convert to generated system call tables
Message-ID: <E1bwa6s-0004ZY-4k@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert ARM to use a similar mechanism to x86 to generate the unistd.h
system call numbers and the various kernel system call tables.  This
means that rather than having to edit three places (asm/unistd.h for
the total number of system calls, uapi/asm/unistd.h for the system call
numbers, and arch/arm/kernel/calls.S for the call table) we have only
one place to edit, making the process much more simple.

The scripts have knowledge of the table padding requirements, so there's
no need to worry about __NR_syscalls not fitting within the immediate
constant field of ALU instructions anymore.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/Makefile                  |   3 +
 arch/arm/include/asm/Kbuild        |   1 +
 arch/arm/include/asm/unistd.h      |  26 ++-
 arch/arm/include/uapi/asm/Kbuild   |   3 +
 arch/arm/include/uapi/asm/unistd.h | 421 +-----------------------------------
 arch/arm/kernel/calls.S            | 412 -----------------------------------
 arch/arm/kernel/entry-common.S     |  76 ++++---
 arch/arm/tools/Makefile            |  62 +++++-
 arch/arm/tools/syscall.tbl         | 428 +++++++++++++++++++++++++++++++++++++
 arch/arm/tools/syscallhdr.sh       |  30 +++
 arch/arm/tools/syscallnr.sh        |  33 +++
 arch/arm/tools/syscalltbl.sh       |  21 ++
 12 files changed, 643 insertions(+), 873 deletions(-)
 delete mode 100644 arch/arm/kernel/calls.S
 create mode 100644 arch/arm/tools/syscall.tbl
 create mode 100644 arch/arm/tools/syscallhdr.sh
 create mode 100644 arch/arm/tools/syscallnr.sh
 create mode 100644 arch/arm/tools/syscalltbl.sh

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 2208a73ba1d4..5a26576fba9a 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -311,6 +311,9 @@ all:	$(KBUILD_IMAGE) $(KBUILD_DTBS)
 
 boot := arch/arm/boot
 
+archheaders:
+	$(Q)$(MAKE) $(build)=arch/arm/tools uapi
+
 archprepare:
 	$(Q)$(MAKE) $(build)=arch/arm/tools kapi
 
diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index 5b06064946ce..b7960e3956b2 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -41,3 +41,4 @@ generic-y += trace_clock.h
 generic-y += unaligned.h
 
 generated-y += mach-types.h
+generated-y += unistd-nr.h
diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
index 194b69923389..076090d2dbf5 100644
--- a/arch/arm/include/asm/unistd.h
+++ b/arch/arm/include/asm/unistd.h
@@ -14,12 +14,7 @@
 #define __ASM_ARM_UNISTD_H
 
 #include <uapi/asm/unistd.h>
-
-/*
- * This may need to be greater than __NR_last_syscall+1 in order to
- * account for the padding in the syscall table
- */
-#define __NR_syscalls  (396)
+#include <asm/unistd-nr.h>
 
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_GETHOSTNAME
@@ -52,4 +47,23 @@
 #define __IGNORE_fadvise64_64
 #define __IGNORE_migrate_pages
 
+#ifdef __ARM_EABI__
+/*
+ * The following syscalls are obsolete and no longer available for EABI:
+ *  __NR_time
+ *  __NR_umount
+ *  __NR_stime
+ *  __NR_alarm
+ *  __NR_utime
+ *  __NR_getrlimit
+ *  __NR_select
+ *  __NR_readdir
+ *  __NR_mmap
+ *  __NR_socketcall
+ *  __NR_syscall
+ *  __NR_ipc
+ */
+#define __IGNORE_getrlimit
+#endif
+
 #endif /* __ASM_ARM_UNISTD_H */
diff --git a/arch/arm/include/uapi/asm/Kbuild b/arch/arm/include/uapi/asm/Kbuild
index a1c05f93d920..46a76cd6acb6 100644
--- a/arch/arm/include/uapi/asm/Kbuild
+++ b/arch/arm/include/uapi/asm/Kbuild
@@ -18,3 +18,6 @@ header-y += stat.h
 header-y += statfs.h
 header-y += swab.h
 header-y += unistd.h
+genhdr-y += unistd-common.h
+genhdr-y += unistd-oabi.h
+genhdr-y += unistd-eabi.h
diff --git a/arch/arm/include/uapi/asm/unistd.h b/arch/arm/include/uapi/asm/unistd.h
index 2cb9dc770e1d..28bd456494a3 100644
--- a/arch/arm/include/uapi/asm/unistd.h
+++ b/arch/arm/include/uapi/asm/unistd.h
@@ -17,409 +17,14 @@
 
 #if defined(__thumb__) || defined(__ARM_EABI__)
 #define __NR_SYSCALL_BASE	0
+#include <asm/unistd-eabi.h>
 #else
 #define __NR_SYSCALL_BASE	__NR_OABI_SYSCALL_BASE
+#include <asm/unistd-oabi.h>
 #endif
 
-/*
- * This file contains the system call numbers.
- */
-
-#define __NR_restart_syscall		(__NR_SYSCALL_BASE+  0)
-#define __NR_exit			(__NR_SYSCALL_BASE+  1)
-#define __NR_fork			(__NR_SYSCALL_BASE+  2)
-#define __NR_read			(__NR_SYSCALL_BASE+  3)
-#define __NR_write			(__NR_SYSCALL_BASE+  4)
-#define __NR_open			(__NR_SYSCALL_BASE+  5)
-#define __NR_close			(__NR_SYSCALL_BASE+  6)
-					/* 7 was sys_waitpid */
-#define __NR_creat			(__NR_SYSCALL_BASE+  8)
-#define __NR_link			(__NR_SYSCALL_BASE+  9)
-#define __NR_unlink			(__NR_SYSCALL_BASE+ 10)
-#define __NR_execve			(__NR_SYSCALL_BASE+ 11)
-#define __NR_chdir			(__NR_SYSCALL_BASE+ 12)
-#define __NR_time			(__NR_SYSCALL_BASE+ 13)
-#define __NR_mknod			(__NR_SYSCALL_BASE+ 14)
-#define __NR_chmod			(__NR_SYSCALL_BASE+ 15)
-#define __NR_lchown			(__NR_SYSCALL_BASE+ 16)
-					/* 17 was sys_break */
-					/* 18 was sys_stat */
-#define __NR_lseek			(__NR_SYSCALL_BASE+ 19)
-#define __NR_getpid			(__NR_SYSCALL_BASE+ 20)
-#define __NR_mount			(__NR_SYSCALL_BASE+ 21)
-#define __NR_umount			(__NR_SYSCALL_BASE+ 22)
-#define __NR_setuid			(__NR_SYSCALL_BASE+ 23)
-#define __NR_getuid			(__NR_SYSCALL_BASE+ 24)
-#define __NR_stime			(__NR_SYSCALL_BASE+ 25)
-#define __NR_ptrace			(__NR_SYSCALL_BASE+ 26)
-#define __NR_alarm			(__NR_SYSCALL_BASE+ 27)
-					/* 28 was sys_fstat */
-#define __NR_pause			(__NR_SYSCALL_BASE+ 29)
-#define __NR_utime			(__NR_SYSCALL_BASE+ 30)
-					/* 31 was sys_stty */
-					/* 32 was sys_gtty */
-#define __NR_access			(__NR_SYSCALL_BASE+ 33)
-#define __NR_nice			(__NR_SYSCALL_BASE+ 34)
-					/* 35 was sys_ftime */
-#define __NR_sync			(__NR_SYSCALL_BASE+ 36)
-#define __NR_kill			(__NR_SYSCALL_BASE+ 37)
-#define __NR_rename			(__NR_SYSCALL_BASE+ 38)
-#define __NR_mkdir			(__NR_SYSCALL_BASE+ 39)
-#define __NR_rmdir			(__NR_SYSCALL_BASE+ 40)
-#define __NR_dup			(__NR_SYSCALL_BASE+ 41)
-#define __NR_pipe			(__NR_SYSCALL_BASE+ 42)
-#define __NR_times			(__NR_SYSCALL_BASE+ 43)
-					/* 44 was sys_prof */
-#define __NR_brk			(__NR_SYSCALL_BASE+ 45)
-#define __NR_setgid			(__NR_SYSCALL_BASE+ 46)
-#define __NR_getgid			(__NR_SYSCALL_BASE+ 47)
-					/* 48 was sys_signal */
-#define __NR_geteuid			(__NR_SYSCALL_BASE+ 49)
-#define __NR_getegid			(__NR_SYSCALL_BASE+ 50)
-#define __NR_acct			(__NR_SYSCALL_BASE+ 51)
-#define __NR_umount2			(__NR_SYSCALL_BASE+ 52)
-					/* 53 was sys_lock */
-#define __NR_ioctl			(__NR_SYSCALL_BASE+ 54)
-#define __NR_fcntl			(__NR_SYSCALL_BASE+ 55)
-					/* 56 was sys_mpx */
-#define __NR_setpgid			(__NR_SYSCALL_BASE+ 57)
-					/* 58 was sys_ulimit */
-					/* 59 was sys_olduname */
-#define __NR_umask			(__NR_SYSCALL_BASE+ 60)
-#define __NR_chroot			(__NR_SYSCALL_BASE+ 61)
-#define __NR_ustat			(__NR_SYSCALL_BASE+ 62)
-#define __NR_dup2			(__NR_SYSCALL_BASE+ 63)
-#define __NR_getppid			(__NR_SYSCALL_BASE+ 64)
-#define __NR_getpgrp			(__NR_SYSCALL_BASE+ 65)
-#define __NR_setsid			(__NR_SYSCALL_BASE+ 66)
-#define __NR_sigaction			(__NR_SYSCALL_BASE+ 67)
-					/* 68 was sys_sgetmask */
-					/* 69 was sys_ssetmask */
-#define __NR_setreuid			(__NR_SYSCALL_BASE+ 70)
-#define __NR_setregid			(__NR_SYSCALL_BASE+ 71)
-#define __NR_sigsuspend			(__NR_SYSCALL_BASE+ 72)
-#define __NR_sigpending			(__NR_SYSCALL_BASE+ 73)
-#define __NR_sethostname		(__NR_SYSCALL_BASE+ 74)
-#define __NR_setrlimit			(__NR_SYSCALL_BASE+ 75)
-#define __NR_getrlimit			(__NR_SYSCALL_BASE+ 76)	/* Back compat 2GB limited rlimit */
-#define __NR_getrusage			(__NR_SYSCALL_BASE+ 77)
-#define __NR_gettimeofday		(__NR_SYSCALL_BASE+ 78)
-#define __NR_settimeofday		(__NR_SYSCALL_BASE+ 79)
-#define __NR_getgroups			(__NR_SYSCALL_BASE+ 80)
-#define __NR_setgroups			(__NR_SYSCALL_BASE+ 81)
-#define __NR_select			(__NR_SYSCALL_BASE+ 82)
-#define __NR_symlink			(__NR_SYSCALL_BASE+ 83)
-					/* 84 was sys_lstat */
-#define __NR_readlink			(__NR_SYSCALL_BASE+ 85)
-#define __NR_uselib			(__NR_SYSCALL_BASE+ 86)
-#define __NR_swapon			(__NR_SYSCALL_BASE+ 87)
-#define __NR_reboot			(__NR_SYSCALL_BASE+ 88)
-#define __NR_readdir			(__NR_SYSCALL_BASE+ 89)
-#define __NR_mmap			(__NR_SYSCALL_BASE+ 90)
-#define __NR_munmap			(__NR_SYSCALL_BASE+ 91)
-#define __NR_truncate			(__NR_SYSCALL_BASE+ 92)
-#define __NR_ftruncate			(__NR_SYSCALL_BASE+ 93)
-#define __NR_fchmod			(__NR_SYSCALL_BASE+ 94)
-#define __NR_fchown			(__NR_SYSCALL_BASE+ 95)
-#define __NR_getpriority		(__NR_SYSCALL_BASE+ 96)
-#define __NR_setpriority		(__NR_SYSCALL_BASE+ 97)
-					/* 98 was sys_profil */
-#define __NR_statfs			(__NR_SYSCALL_BASE+ 99)
-#define __NR_fstatfs			(__NR_SYSCALL_BASE+100)
-					/* 101 was sys_ioperm */
-#define __NR_socketcall			(__NR_SYSCALL_BASE+102)
-#define __NR_syslog			(__NR_SYSCALL_BASE+103)
-#define __NR_setitimer			(__NR_SYSCALL_BASE+104)
-#define __NR_getitimer			(__NR_SYSCALL_BASE+105)
-#define __NR_stat			(__NR_SYSCALL_BASE+106)
-#define __NR_lstat			(__NR_SYSCALL_BASE+107)
-#define __NR_fstat			(__NR_SYSCALL_BASE+108)
-					/* 109 was sys_uname */
-					/* 110 was sys_iopl */
-#define __NR_vhangup			(__NR_SYSCALL_BASE+111)
-					/* 112 was sys_idle */
-#define __NR_syscall			(__NR_SYSCALL_BASE+113) /* syscall to call a syscall! */
-#define __NR_wait4			(__NR_SYSCALL_BASE+114)
-#define __NR_swapoff			(__NR_SYSCALL_BASE+115)
-#define __NR_sysinfo			(__NR_SYSCALL_BASE+116)
-#define __NR_ipc			(__NR_SYSCALL_BASE+117)
-#define __NR_fsync			(__NR_SYSCALL_BASE+118)
-#define __NR_sigreturn			(__NR_SYSCALL_BASE+119)
-#define __NR_clone			(__NR_SYSCALL_BASE+120)
-#define __NR_setdomainname		(__NR_SYSCALL_BASE+121)
-#define __NR_uname			(__NR_SYSCALL_BASE+122)
-					/* 123 was sys_modify_ldt */
-#define __NR_adjtimex			(__NR_SYSCALL_BASE+124)
-#define __NR_mprotect			(__NR_SYSCALL_BASE+125)
-#define __NR_sigprocmask		(__NR_SYSCALL_BASE+126)
-					/* 127 was sys_create_module */
-#define __NR_init_module		(__NR_SYSCALL_BASE+128)
-#define __NR_delete_module		(__NR_SYSCALL_BASE+129)
-					/* 130 was sys_get_kernel_syms */
-#define __NR_quotactl			(__NR_SYSCALL_BASE+131)
-#define __NR_getpgid			(__NR_SYSCALL_BASE+132)
-#define __NR_fchdir			(__NR_SYSCALL_BASE+133)
-#define __NR_bdflush			(__NR_SYSCALL_BASE+134)
-#define __NR_sysfs			(__NR_SYSCALL_BASE+135)
-#define __NR_personality		(__NR_SYSCALL_BASE+136)
-					/* 137 was sys_afs_syscall */
-#define __NR_setfsuid			(__NR_SYSCALL_BASE+138)
-#define __NR_setfsgid			(__NR_SYSCALL_BASE+139)
-#define __NR__llseek			(__NR_SYSCALL_BASE+140)
-#define __NR_getdents			(__NR_SYSCALL_BASE+141)
-#define __NR__newselect			(__NR_SYSCALL_BASE+142)
-#define __NR_flock			(__NR_SYSCALL_BASE+143)
-#define __NR_msync			(__NR_SYSCALL_BASE+144)
-#define __NR_readv			(__NR_SYSCALL_BASE+145)
-#define __NR_writev			(__NR_SYSCALL_BASE+146)
-#define __NR_getsid			(__NR_SYSCALL_BASE+147)
-#define __NR_fdatasync			(__NR_SYSCALL_BASE+148)
-#define __NR__sysctl			(__NR_SYSCALL_BASE+149)
-#define __NR_mlock			(__NR_SYSCALL_BASE+150)
-#define __NR_munlock			(__NR_SYSCALL_BASE+151)
-#define __NR_mlockall			(__NR_SYSCALL_BASE+152)
-#define __NR_munlockall			(__NR_SYSCALL_BASE+153)
-#define __NR_sched_setparam		(__NR_SYSCALL_BASE+154)
-#define __NR_sched_getparam		(__NR_SYSCALL_BASE+155)
-#define __NR_sched_setscheduler		(__NR_SYSCALL_BASE+156)
-#define __NR_sched_getscheduler		(__NR_SYSCALL_BASE+157)
-#define __NR_sched_yield		(__NR_SYSCALL_BASE+158)
-#define __NR_sched_get_priority_max	(__NR_SYSCALL_BASE+159)
-#define __NR_sched_get_priority_min	(__NR_SYSCALL_BASE+160)
-#define __NR_sched_rr_get_interval	(__NR_SYSCALL_BASE+161)
-#define __NR_nanosleep			(__NR_SYSCALL_BASE+162)
-#define __NR_mremap			(__NR_SYSCALL_BASE+163)
-#define __NR_setresuid			(__NR_SYSCALL_BASE+164)
-#define __NR_getresuid			(__NR_SYSCALL_BASE+165)
-					/* 166 was sys_vm86 */
-					/* 167 was sys_query_module */
-#define __NR_poll			(__NR_SYSCALL_BASE+168)
-#define __NR_nfsservctl			(__NR_SYSCALL_BASE+169)
-#define __NR_setresgid			(__NR_SYSCALL_BASE+170)
-#define __NR_getresgid			(__NR_SYSCALL_BASE+171)
-#define __NR_prctl			(__NR_SYSCALL_BASE+172)
-#define __NR_rt_sigreturn		(__NR_SYSCALL_BASE+173)
-#define __NR_rt_sigaction		(__NR_SYSCALL_BASE+174)
-#define __NR_rt_sigprocmask		(__NR_SYSCALL_BASE+175)
-#define __NR_rt_sigpending		(__NR_SYSCALL_BASE+176)
-#define __NR_rt_sigtimedwait		(__NR_SYSCALL_BASE+177)
-#define __NR_rt_sigqueueinfo		(__NR_SYSCALL_BASE+178)
-#define __NR_rt_sigsuspend		(__NR_SYSCALL_BASE+179)
-#define __NR_pread64			(__NR_SYSCALL_BASE+180)
-#define __NR_pwrite64			(__NR_SYSCALL_BASE+181)
-#define __NR_chown			(__NR_SYSCALL_BASE+182)
-#define __NR_getcwd			(__NR_SYSCALL_BASE+183)
-#define __NR_capget			(__NR_SYSCALL_BASE+184)
-#define __NR_capset			(__NR_SYSCALL_BASE+185)
-#define __NR_sigaltstack		(__NR_SYSCALL_BASE+186)
-#define __NR_sendfile			(__NR_SYSCALL_BASE+187)
-					/* 188 reserved */
-					/* 189 reserved */
-#define __NR_vfork			(__NR_SYSCALL_BASE+190)
-#define __NR_ugetrlimit			(__NR_SYSCALL_BASE+191)	/* SuS compliant getrlimit */
-#define __NR_mmap2			(__NR_SYSCALL_BASE+192)
-#define __NR_truncate64			(__NR_SYSCALL_BASE+193)
-#define __NR_ftruncate64		(__NR_SYSCALL_BASE+194)
-#define __NR_stat64			(__NR_SYSCALL_BASE+195)
-#define __NR_lstat64			(__NR_SYSCALL_BASE+196)
-#define __NR_fstat64			(__NR_SYSCALL_BASE+197)
-#define __NR_lchown32			(__NR_SYSCALL_BASE+198)
-#define __NR_getuid32			(__NR_SYSCALL_BASE+199)
-#define __NR_getgid32			(__NR_SYSCALL_BASE+200)
-#define __NR_geteuid32			(__NR_SYSCALL_BASE+201)
-#define __NR_getegid32			(__NR_SYSCALL_BASE+202)
-#define __NR_setreuid32			(__NR_SYSCALL_BASE+203)
-#define __NR_setregid32			(__NR_SYSCALL_BASE+204)
-#define __NR_getgroups32		(__NR_SYSCALL_BASE+205)
-#define __NR_setgroups32		(__NR_SYSCALL_BASE+206)
-#define __NR_fchown32			(__NR_SYSCALL_BASE+207)
-#define __NR_setresuid32		(__NR_SYSCALL_BASE+208)
-#define __NR_getresuid32		(__NR_SYSCALL_BASE+209)
-#define __NR_setresgid32		(__NR_SYSCALL_BASE+210)
-#define __NR_getresgid32		(__NR_SYSCALL_BASE+211)
-#define __NR_chown32			(__NR_SYSCALL_BASE+212)
-#define __NR_setuid32			(__NR_SYSCALL_BASE+213)
-#define __NR_setgid32			(__NR_SYSCALL_BASE+214)
-#define __NR_setfsuid32			(__NR_SYSCALL_BASE+215)
-#define __NR_setfsgid32			(__NR_SYSCALL_BASE+216)
-#define __NR_getdents64			(__NR_SYSCALL_BASE+217)
-#define __NR_pivot_root			(__NR_SYSCALL_BASE+218)
-#define __NR_mincore			(__NR_SYSCALL_BASE+219)
-#define __NR_madvise			(__NR_SYSCALL_BASE+220)
-#define __NR_fcntl64			(__NR_SYSCALL_BASE+221)
-					/* 222 for tux */
-					/* 223 is unused */
-#define __NR_gettid			(__NR_SYSCALL_BASE+224)
-#define __NR_readahead			(__NR_SYSCALL_BASE+225)
-#define __NR_setxattr			(__NR_SYSCALL_BASE+226)
-#define __NR_lsetxattr			(__NR_SYSCALL_BASE+227)
-#define __NR_fsetxattr			(__NR_SYSCALL_BASE+228)
-#define __NR_getxattr			(__NR_SYSCALL_BASE+229)
-#define __NR_lgetxattr			(__NR_SYSCALL_BASE+230)
-#define __NR_fgetxattr			(__NR_SYSCALL_BASE+231)
-#define __NR_listxattr			(__NR_SYSCALL_BASE+232)
-#define __NR_llistxattr			(__NR_SYSCALL_BASE+233)
-#define __NR_flistxattr			(__NR_SYSCALL_BASE+234)
-#define __NR_removexattr		(__NR_SYSCALL_BASE+235)
-#define __NR_lremovexattr		(__NR_SYSCALL_BASE+236)
-#define __NR_fremovexattr		(__NR_SYSCALL_BASE+237)
-#define __NR_tkill			(__NR_SYSCALL_BASE+238)
-#define __NR_sendfile64			(__NR_SYSCALL_BASE+239)
-#define __NR_futex			(__NR_SYSCALL_BASE+240)
-#define __NR_sched_setaffinity		(__NR_SYSCALL_BASE+241)
-#define __NR_sched_getaffinity		(__NR_SYSCALL_BASE+242)
-#define __NR_io_setup			(__NR_SYSCALL_BASE+243)
-#define __NR_io_destroy			(__NR_SYSCALL_BASE+244)
-#define __NR_io_getevents		(__NR_SYSCALL_BASE+245)
-#define __NR_io_submit			(__NR_SYSCALL_BASE+246)
-#define __NR_io_cancel			(__NR_SYSCALL_BASE+247)
-#define __NR_exit_group			(__NR_SYSCALL_BASE+248)
-#define __NR_lookup_dcookie		(__NR_SYSCALL_BASE+249)
-#define __NR_epoll_create		(__NR_SYSCALL_BASE+250)
-#define __NR_epoll_ctl			(__NR_SYSCALL_BASE+251)
-#define __NR_epoll_wait			(__NR_SYSCALL_BASE+252)
-#define __NR_remap_file_pages		(__NR_SYSCALL_BASE+253)
-					/* 254 for set_thread_area */
-					/* 255 for get_thread_area */
-#define __NR_set_tid_address		(__NR_SYSCALL_BASE+256)
-#define __NR_timer_create		(__NR_SYSCALL_BASE+257)
-#define __NR_timer_settime		(__NR_SYSCALL_BASE+258)
-#define __NR_timer_gettime		(__NR_SYSCALL_BASE+259)
-#define __NR_timer_getoverrun		(__NR_SYSCALL_BASE+260)
-#define __NR_timer_delete		(__NR_SYSCALL_BASE+261)
-#define __NR_clock_settime		(__NR_SYSCALL_BASE+262)
-#define __NR_clock_gettime		(__NR_SYSCALL_BASE+263)
-#define __NR_clock_getres		(__NR_SYSCALL_BASE+264)
-#define __NR_clock_nanosleep		(__NR_SYSCALL_BASE+265)
-#define __NR_statfs64			(__NR_SYSCALL_BASE+266)
-#define __NR_fstatfs64			(__NR_SYSCALL_BASE+267)
-#define __NR_tgkill			(__NR_SYSCALL_BASE+268)
-#define __NR_utimes			(__NR_SYSCALL_BASE+269)
-#define __NR_arm_fadvise64_64		(__NR_SYSCALL_BASE+270)
-#define __NR_pciconfig_iobase		(__NR_SYSCALL_BASE+271)
-#define __NR_pciconfig_read		(__NR_SYSCALL_BASE+272)
-#define __NR_pciconfig_write		(__NR_SYSCALL_BASE+273)
-#define __NR_mq_open			(__NR_SYSCALL_BASE+274)
-#define __NR_mq_unlink			(__NR_SYSCALL_BASE+275)
-#define __NR_mq_timedsend		(__NR_SYSCALL_BASE+276)
-#define __NR_mq_timedreceive		(__NR_SYSCALL_BASE+277)
-#define __NR_mq_notify			(__NR_SYSCALL_BASE+278)
-#define __NR_mq_getsetattr		(__NR_SYSCALL_BASE+279)
-#define __NR_waitid			(__NR_SYSCALL_BASE+280)
-#define __NR_socket			(__NR_SYSCALL_BASE+281)
-#define __NR_bind			(__NR_SYSCALL_BASE+282)
-#define __NR_connect			(__NR_SYSCALL_BASE+283)
-#define __NR_listen			(__NR_SYSCALL_BASE+284)
-#define __NR_accept			(__NR_SYSCALL_BASE+285)
-#define __NR_getsockname		(__NR_SYSCALL_BASE+286)
-#define __NR_getpeername		(__NR_SYSCALL_BASE+287)
-#define __NR_socketpair			(__NR_SYSCALL_BASE+288)
-#define __NR_send			(__NR_SYSCALL_BASE+289)
-#define __NR_sendto			(__NR_SYSCALL_BASE+290)
-#define __NR_recv			(__NR_SYSCALL_BASE+291)
-#define __NR_recvfrom			(__NR_SYSCALL_BASE+292)
-#define __NR_shutdown			(__NR_SYSCALL_BASE+293)
-#define __NR_setsockopt			(__NR_SYSCALL_BASE+294)
-#define __NR_getsockopt			(__NR_SYSCALL_BASE+295)
-#define __NR_sendmsg			(__NR_SYSCALL_BASE+296)
-#define __NR_recvmsg			(__NR_SYSCALL_BASE+297)
-#define __NR_semop			(__NR_SYSCALL_BASE+298)
-#define __NR_semget			(__NR_SYSCALL_BASE+299)
-#define __NR_semctl			(__NR_SYSCALL_BASE+300)
-#define __NR_msgsnd			(__NR_SYSCALL_BASE+301)
-#define __NR_msgrcv			(__NR_SYSCALL_BASE+302)
-#define __NR_msgget			(__NR_SYSCALL_BASE+303)
-#define __NR_msgctl			(__NR_SYSCALL_BASE+304)
-#define __NR_shmat			(__NR_SYSCALL_BASE+305)
-#define __NR_shmdt			(__NR_SYSCALL_BASE+306)
-#define __NR_shmget			(__NR_SYSCALL_BASE+307)
-#define __NR_shmctl			(__NR_SYSCALL_BASE+308)
-#define __NR_add_key			(__NR_SYSCALL_BASE+309)
-#define __NR_request_key		(__NR_SYSCALL_BASE+310)
-#define __NR_keyctl			(__NR_SYSCALL_BASE+311)
-#define __NR_semtimedop			(__NR_SYSCALL_BASE+312)
-#define __NR_vserver			(__NR_SYSCALL_BASE+313)
-#define __NR_ioprio_set			(__NR_SYSCALL_BASE+314)
-#define __NR_ioprio_get			(__NR_SYSCALL_BASE+315)
-#define __NR_inotify_init		(__NR_SYSCALL_BASE+316)
-#define __NR_inotify_add_watch		(__NR_SYSCALL_BASE+317)
-#define __NR_inotify_rm_watch		(__NR_SYSCALL_BASE+318)
-#define __NR_mbind			(__NR_SYSCALL_BASE+319)
-#define __NR_get_mempolicy		(__NR_SYSCALL_BASE+320)
-#define __NR_set_mempolicy		(__NR_SYSCALL_BASE+321)
-#define __NR_openat			(__NR_SYSCALL_BASE+322)
-#define __NR_mkdirat			(__NR_SYSCALL_BASE+323)
-#define __NR_mknodat			(__NR_SYSCALL_BASE+324)
-#define __NR_fchownat			(__NR_SYSCALL_BASE+325)
-#define __NR_futimesat			(__NR_SYSCALL_BASE+326)
-#define __NR_fstatat64			(__NR_SYSCALL_BASE+327)
-#define __NR_unlinkat			(__NR_SYSCALL_BASE+328)
-#define __NR_renameat			(__NR_SYSCALL_BASE+329)
-#define __NR_linkat			(__NR_SYSCALL_BASE+330)
-#define __NR_symlinkat			(__NR_SYSCALL_BASE+331)
-#define __NR_readlinkat			(__NR_SYSCALL_BASE+332)
-#define __NR_fchmodat			(__NR_SYSCALL_BASE+333)
-#define __NR_faccessat			(__NR_SYSCALL_BASE+334)
-#define __NR_pselect6			(__NR_SYSCALL_BASE+335)
-#define __NR_ppoll			(__NR_SYSCALL_BASE+336)
-#define __NR_unshare			(__NR_SYSCALL_BASE+337)
-#define __NR_set_robust_list		(__NR_SYSCALL_BASE+338)
-#define __NR_get_robust_list		(__NR_SYSCALL_BASE+339)
-#define __NR_splice			(__NR_SYSCALL_BASE+340)
-#define __NR_arm_sync_file_range	(__NR_SYSCALL_BASE+341)
+#include <asm/unistd-common.h>
 #define __NR_sync_file_range2		__NR_arm_sync_file_range
-#define __NR_tee			(__NR_SYSCALL_BASE+342)
-#define __NR_vmsplice			(__NR_SYSCALL_BASE+343)
-#define __NR_move_pages			(__NR_SYSCALL_BASE+344)
-#define __NR_getcpu			(__NR_SYSCALL_BASE+345)
-#define __NR_epoll_pwait		(__NR_SYSCALL_BASE+346)
-#define __NR_kexec_load			(__NR_SYSCALL_BASE+347)
-#define __NR_utimensat			(__NR_SYSCALL_BASE+348)
-#define __NR_signalfd			(__NR_SYSCALL_BASE+349)
-#define __NR_timerfd_create		(__NR_SYSCALL_BASE+350)
-#define __NR_eventfd			(__NR_SYSCALL_BASE+351)
-#define __NR_fallocate			(__NR_SYSCALL_BASE+352)
-#define __NR_timerfd_settime		(__NR_SYSCALL_BASE+353)
-#define __NR_timerfd_gettime		(__NR_SYSCALL_BASE+354)
-#define __NR_signalfd4			(__NR_SYSCALL_BASE+355)
-#define __NR_eventfd2			(__NR_SYSCALL_BASE+356)
-#define __NR_epoll_create1		(__NR_SYSCALL_BASE+357)
-#define __NR_dup3			(__NR_SYSCALL_BASE+358)
-#define __NR_pipe2			(__NR_SYSCALL_BASE+359)
-#define __NR_inotify_init1		(__NR_SYSCALL_BASE+360)
-#define __NR_preadv			(__NR_SYSCALL_BASE+361)
-#define __NR_pwritev			(__NR_SYSCALL_BASE+362)
-#define __NR_rt_tgsigqueueinfo		(__NR_SYSCALL_BASE+363)
-#define __NR_perf_event_open		(__NR_SYSCALL_BASE+364)
-#define __NR_recvmmsg			(__NR_SYSCALL_BASE+365)
-#define __NR_accept4			(__NR_SYSCALL_BASE+366)
-#define __NR_fanotify_init		(__NR_SYSCALL_BASE+367)
-#define __NR_fanotify_mark		(__NR_SYSCALL_BASE+368)
-#define __NR_prlimit64			(__NR_SYSCALL_BASE+369)
-#define __NR_name_to_handle_at		(__NR_SYSCALL_BASE+370)
-#define __NR_open_by_handle_at		(__NR_SYSCALL_BASE+371)
-#define __NR_clock_adjtime		(__NR_SYSCALL_BASE+372)
-#define __NR_syncfs			(__NR_SYSCALL_BASE+373)
-#define __NR_sendmmsg			(__NR_SYSCALL_BASE+374)
-#define __NR_setns			(__NR_SYSCALL_BASE+375)
-#define __NR_process_vm_readv		(__NR_SYSCALL_BASE+376)
-#define __NR_process_vm_writev		(__NR_SYSCALL_BASE+377)
-#define __NR_kcmp			(__NR_SYSCALL_BASE+378)
-#define __NR_finit_module		(__NR_SYSCALL_BASE+379)
-#define __NR_sched_setattr		(__NR_SYSCALL_BASE+380)
-#define __NR_sched_getattr		(__NR_SYSCALL_BASE+381)
-#define __NR_renameat2			(__NR_SYSCALL_BASE+382)
-#define __NR_seccomp			(__NR_SYSCALL_BASE+383)
-#define __NR_getrandom			(__NR_SYSCALL_BASE+384)
-#define __NR_memfd_create		(__NR_SYSCALL_BASE+385)
-#define __NR_bpf			(__NR_SYSCALL_BASE+386)
-#define __NR_execveat			(__NR_SYSCALL_BASE+387)
-#define __NR_userfaultfd		(__NR_SYSCALL_BASE+388)
-#define __NR_membarrier			(__NR_SYSCALL_BASE+389)
-#define __NR_mlock2			(__NR_SYSCALL_BASE+390)
-#define __NR_copy_file_range		(__NR_SYSCALL_BASE+391)
-#define __NR_preadv2			(__NR_SYSCALL_BASE+392)
-#define __NR_pwritev2			(__NR_SYSCALL_BASE+393)
 
 /*
  * The following SWIs are ARM private.
@@ -431,24 +36,4 @@
 #define __ARM_NR_usr32			(__ARM_NR_BASE+4)
 #define __ARM_NR_set_tls		(__ARM_NR_BASE+5)
 
-/*
- * The following syscalls are obsolete and no longer available for EABI.
- */
-#if !defined(__KERNEL__)
-#if defined(__ARM_EABI__)
-#undef __NR_time
-#undef __NR_umount
-#undef __NR_stime
-#undef __NR_alarm
-#undef __NR_utime
-#undef __NR_getrlimit
-#undef __NR_select
-#undef __NR_readdir
-#undef __NR_mmap
-#undef __NR_socketcall
-#undef __NR_syscall
-#undef __NR_ipc
-#endif
-#endif
-
 #endif /* _UAPI__ASM_ARM_UNISTD_H */
diff --git a/arch/arm/kernel/calls.S b/arch/arm/kernel/calls.S
deleted file mode 100644
index 703fa0f3cd8f..000000000000
--- a/arch/arm/kernel/calls.S
+++ /dev/null
@@ -1,412 +0,0 @@
-/*
- *  linux/arch/arm/kernel/calls.S
- *
- *  Copyright (C) 1995-2005 Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- *  This file is included thrice in entry-common.S
- */
-/* 0 */		CALL(sys_restart_syscall)
-		CALL(sys_exit)
-		CALL(sys_fork)
-		CALL(sys_read)
-		CALL(sys_write)
-/* 5 */		CALL(sys_open)
-		CALL(sys_close)
-		CALL(sys_ni_syscall)		/* was sys_waitpid */
-		CALL(sys_creat)
-		CALL(sys_link)
-/* 10 */	CALL(sys_unlink)
-		CALL(sys_execve)
-		CALL(sys_chdir)
-		CALL(OBSOLETE(sys_time))	/* used by libc4 */
-		CALL(sys_mknod)
-/* 15 */	CALL(sys_chmod)
-		CALL(sys_lchown16)
-		CALL(sys_ni_syscall)		/* was sys_break */
-		CALL(sys_ni_syscall)		/* was sys_stat */
-		CALL(sys_lseek)
-/* 20 */	CALL(sys_getpid)
-		CALL(sys_mount)
-		CALL(OBSOLETE(sys_oldumount))	/* used by libc4 */
-		CALL(sys_setuid16)
-		CALL(sys_getuid16)
-/* 25 */	CALL(OBSOLETE(sys_stime))
-		CALL(sys_ptrace)
-		CALL(OBSOLETE(sys_alarm))	/* used by libc4 */
-		CALL(sys_ni_syscall)		/* was sys_fstat */
-		CALL(sys_pause)
-/* 30 */	CALL(OBSOLETE(sys_utime))	/* used by libc4 */
-		CALL(sys_ni_syscall)		/* was sys_stty */
-		CALL(sys_ni_syscall)		/* was sys_getty */
-		CALL(sys_access)
-		CALL(sys_nice)
-/* 35 */	CALL(sys_ni_syscall)		/* was sys_ftime */
-		CALL(sys_sync)
-		CALL(sys_kill)
-		CALL(sys_rename)
-		CALL(sys_mkdir)
-/* 40 */	CALL(sys_rmdir)
-		CALL(sys_dup)
-		CALL(sys_pipe)
-		CALL(sys_times)
-		CALL(sys_ni_syscall)		/* was sys_prof */
-/* 45 */	CALL(sys_brk)
-		CALL(sys_setgid16)
-		CALL(sys_getgid16)
-		CALL(sys_ni_syscall)		/* was sys_signal */
-		CALL(sys_geteuid16)
-/* 50 */	CALL(sys_getegid16)
-		CALL(sys_acct)
-		CALL(sys_umount)
-		CALL(sys_ni_syscall)		/* was sys_lock */
-		CALL(sys_ioctl)
-/* 55 */	CALL(sys_fcntl)
-		CALL(sys_ni_syscall)		/* was sys_mpx */
-		CALL(sys_setpgid)
-		CALL(sys_ni_syscall)		/* was sys_ulimit */
-		CALL(sys_ni_syscall)		/* was sys_olduname */
-/* 60 */	CALL(sys_umask)
-		CALL(sys_chroot)
-		CALL(sys_ustat)
-		CALL(sys_dup2)
-		CALL(sys_getppid)
-/* 65 */	CALL(sys_getpgrp)
-		CALL(sys_setsid)
-		CALL(sys_sigaction)
-		CALL(sys_ni_syscall)		/* was sys_sgetmask */
-		CALL(sys_ni_syscall)		/* was sys_ssetmask */
-/* 70 */	CALL(sys_setreuid16)
-		CALL(sys_setregid16)
-		CALL(sys_sigsuspend)
-		CALL(sys_sigpending)
-		CALL(sys_sethostname)
-/* 75 */	CALL(sys_setrlimit)
-		CALL(OBSOLETE(sys_old_getrlimit)) /* used by libc4 */
-		CALL(sys_getrusage)
-		CALL(sys_gettimeofday)
-		CALL(sys_settimeofday)
-/* 80 */	CALL(sys_getgroups16)
-		CALL(sys_setgroups16)
-		CALL(OBSOLETE(sys_old_select))	/* used by libc4 */
-		CALL(sys_symlink)
-		CALL(sys_ni_syscall)		/* was sys_lstat */
-/* 85 */	CALL(sys_readlink)
-		CALL(sys_uselib)
-		CALL(sys_swapon)
-		CALL(sys_reboot)
-		CALL(OBSOLETE(sys_old_readdir))	/* used by libc4 */
-/* 90 */	CALL(OBSOLETE(sys_old_mmap))	/* used by libc4 */
-		CALL(sys_munmap)
-		CALL(sys_truncate)
-		CALL(sys_ftruncate)
-		CALL(sys_fchmod)
-/* 95 */	CALL(sys_fchown16)
-		CALL(sys_getpriority)
-		CALL(sys_setpriority)
-		CALL(sys_ni_syscall)		/* was sys_profil */
-		CALL(sys_statfs)
-/* 100 */	CALL(sys_fstatfs)
-		CALL(sys_ni_syscall)		/* sys_ioperm */
-		CALL(OBSOLETE(ABI(sys_socketcall, sys_oabi_socketcall)))
-		CALL(sys_syslog)
-		CALL(sys_setitimer)
-/* 105 */	CALL(sys_getitimer)
-		CALL(sys_newstat)
-		CALL(sys_newlstat)
-		CALL(sys_newfstat)
-		CALL(sys_ni_syscall)		/* was sys_uname */
-/* 110 */	CALL(sys_ni_syscall)		/* was sys_iopl */
-		CALL(sys_vhangup)
-		CALL(sys_ni_syscall)
-		CALL(OBSOLETE(sys_syscall))	/* call a syscall */
-		CALL(sys_wait4)
-/* 115 */	CALL(sys_swapoff)
-		CALL(sys_sysinfo)
-		CALL(OBSOLETE(ABI(sys_ipc, sys_oabi_ipc)))
-		CALL(sys_fsync)
-		CALL(sys_sigreturn_wrapper)
-/* 120 */	CALL(sys_clone)
-		CALL(sys_setdomainname)
-		CALL(sys_newuname)
-		CALL(sys_ni_syscall)		/* modify_ldt */
-		CALL(sys_adjtimex)
-/* 125 */	CALL(sys_mprotect)
-		CALL(sys_sigprocmask)
-		CALL(sys_ni_syscall)		/* was sys_create_module */
-		CALL(sys_init_module)
-		CALL(sys_delete_module)
-/* 130 */	CALL(sys_ni_syscall)		/* was sys_get_kernel_syms */
-		CALL(sys_quotactl)
-		CALL(sys_getpgid)
-		CALL(sys_fchdir)
-		CALL(sys_bdflush)
-/* 135 */	CALL(sys_sysfs)
-		CALL(sys_personality)
-		CALL(sys_ni_syscall)		/* reserved for afs_syscall */
-		CALL(sys_setfsuid16)
-		CALL(sys_setfsgid16)
-/* 140 */	CALL(sys_llseek)
-		CALL(sys_getdents)
-		CALL(sys_select)
-		CALL(sys_flock)
-		CALL(sys_msync)
-/* 145 */	CALL(sys_readv)
-		CALL(sys_writev)
-		CALL(sys_getsid)
-		CALL(sys_fdatasync)
-		CALL(sys_sysctl)
-/* 150 */	CALL(sys_mlock)
-		CALL(sys_munlock)
-		CALL(sys_mlockall)
-		CALL(sys_munlockall)
-		CALL(sys_sched_setparam)
-/* 155 */	CALL(sys_sched_getparam)
-		CALL(sys_sched_setscheduler)
-		CALL(sys_sched_getscheduler)
-		CALL(sys_sched_yield)
-		CALL(sys_sched_get_priority_max)
-/* 160 */	CALL(sys_sched_get_priority_min)
-		CALL(sys_sched_rr_get_interval)
-		CALL(sys_nanosleep)
-		CALL(sys_mremap)
-		CALL(sys_setresuid16)
-/* 165 */	CALL(sys_getresuid16)
-		CALL(sys_ni_syscall)		/* vm86 */
-		CALL(sys_ni_syscall)		/* was sys_query_module */
-		CALL(sys_poll)
-		CALL(sys_ni_syscall)		/* was nfsservctl */
-/* 170 */	CALL(sys_setresgid16)
-		CALL(sys_getresgid16)
-		CALL(sys_prctl)
-		CALL(sys_rt_sigreturn_wrapper)
-		CALL(sys_rt_sigaction)
-/* 175 */	CALL(sys_rt_sigprocmask)
-		CALL(sys_rt_sigpending)
-		CALL(sys_rt_sigtimedwait)
-		CALL(sys_rt_sigqueueinfo)
-		CALL(sys_rt_sigsuspend)
-/* 180 */	CALL(ABI(sys_pread64, sys_oabi_pread64))
-		CALL(ABI(sys_pwrite64, sys_oabi_pwrite64))
-		CALL(sys_chown16)
-		CALL(sys_getcwd)
-		CALL(sys_capget)
-/* 185 */	CALL(sys_capset)
-		CALL(sys_sigaltstack)
-		CALL(sys_sendfile)
-		CALL(sys_ni_syscall)		/* getpmsg */
-		CALL(sys_ni_syscall)		/* putpmsg */
-/* 190 */	CALL(sys_vfork)
-		CALL(sys_getrlimit)
-		CALL(sys_mmap2)
-		CALL(ABI(sys_truncate64, sys_oabi_truncate64))
-		CALL(ABI(sys_ftruncate64, sys_oabi_ftruncate64))
-/* 195 */	CALL(ABI(sys_stat64, sys_oabi_stat64))
-		CALL(ABI(sys_lstat64, sys_oabi_lstat64))
-		CALL(ABI(sys_fstat64, sys_oabi_fstat64))
-		CALL(sys_lchown)
-		CALL(sys_getuid)
-/* 200 */	CALL(sys_getgid)
-		CALL(sys_geteuid)
-		CALL(sys_getegid)
-		CALL(sys_setreuid)
-		CALL(sys_setregid)
-/* 205 */	CALL(sys_getgroups)
-		CALL(sys_setgroups)
-		CALL(sys_fchown)
-		CALL(sys_setresuid)
-		CALL(sys_getresuid)
-/* 210 */	CALL(sys_setresgid)
-		CALL(sys_getresgid)
-		CALL(sys_chown)
-		CALL(sys_setuid)
-		CALL(sys_setgid)
-/* 215 */	CALL(sys_setfsuid)
-		CALL(sys_setfsgid)
-		CALL(sys_getdents64)
-		CALL(sys_pivot_root)
-		CALL(sys_mincore)
-/* 220 */	CALL(sys_madvise)
-		CALL(ABI(sys_fcntl64, sys_oabi_fcntl64))
-		CALL(sys_ni_syscall) /* TUX */
-		CALL(sys_ni_syscall)
-		CALL(sys_gettid)
-/* 225 */	CALL(ABI(sys_readahead, sys_oabi_readahead))
-		CALL(sys_setxattr)
-		CALL(sys_lsetxattr)
-		CALL(sys_fsetxattr)
-		CALL(sys_getxattr)
-/* 230 */	CALL(sys_lgetxattr)
-		CALL(sys_fgetxattr)
-		CALL(sys_listxattr)
-		CALL(sys_llistxattr)
-		CALL(sys_flistxattr)
-/* 235 */	CALL(sys_removexattr)
-		CALL(sys_lremovexattr)
-		CALL(sys_fremovexattr)
-		CALL(sys_tkill)
-		CALL(sys_sendfile64)
-/* 240 */	CALL(sys_futex)
-		CALL(sys_sched_setaffinity)
-		CALL(sys_sched_getaffinity)
-		CALL(sys_io_setup)
-		CALL(sys_io_destroy)
-/* 245 */	CALL(sys_io_getevents)
-		CALL(sys_io_submit)
-		CALL(sys_io_cancel)
-		CALL(sys_exit_group)
-		CALL(sys_lookup_dcookie)
-/* 250 */	CALL(sys_epoll_create)
-		CALL(ABI(sys_epoll_ctl, sys_oabi_epoll_ctl))
-		CALL(ABI(sys_epoll_wait, sys_oabi_epoll_wait))
-		CALL(sys_remap_file_pages)
-		CALL(sys_ni_syscall)	/* sys_set_thread_area */
-/* 255 */	CALL(sys_ni_syscall)	/* sys_get_thread_area */
-		CALL(sys_set_tid_address)
-		CALL(sys_timer_create)
-		CALL(sys_timer_settime)
-		CALL(sys_timer_gettime)
-/* 260 */	CALL(sys_timer_getoverrun)
-		CALL(sys_timer_delete)
-		CALL(sys_clock_settime)
-		CALL(sys_clock_gettime)
-		CALL(sys_clock_getres)
-/* 265 */	CALL(sys_clock_nanosleep)
-		CALL(sys_statfs64_wrapper)
-		CALL(sys_fstatfs64_wrapper)
-		CALL(sys_tgkill)
-		CALL(sys_utimes)
-/* 270 */	CALL(sys_arm_fadvise64_64)
-		CALL(sys_pciconfig_iobase)
-		CALL(sys_pciconfig_read)
-		CALL(sys_pciconfig_write)
-		CALL(sys_mq_open)
-/* 275 */	CALL(sys_mq_unlink)
-		CALL(sys_mq_timedsend)
-		CALL(sys_mq_timedreceive)
-		CALL(sys_mq_notify)
-		CALL(sys_mq_getsetattr)
-/* 280 */	CALL(sys_waitid)
-		CALL(sys_socket)
-		CALL(ABI(sys_bind, sys_oabi_bind))
-		CALL(ABI(sys_connect, sys_oabi_connect))
-		CALL(sys_listen)
-/* 285 */	CALL(sys_accept)
-		CALL(sys_getsockname)
-		CALL(sys_getpeername)
-		CALL(sys_socketpair)
-		CALL(sys_send)
-/* 290 */	CALL(ABI(sys_sendto, sys_oabi_sendto))
-		CALL(sys_recv)
-		CALL(sys_recvfrom)
-		CALL(sys_shutdown)
-		CALL(sys_setsockopt)
-/* 295 */	CALL(sys_getsockopt)
-		CALL(ABI(sys_sendmsg, sys_oabi_sendmsg))
-		CALL(sys_recvmsg)
-		CALL(ABI(sys_semop, sys_oabi_semop))
-		CALL(sys_semget)
-/* 300 */	CALL(sys_semctl)
-		CALL(sys_msgsnd)
-		CALL(sys_msgrcv)
-		CALL(sys_msgget)
-		CALL(sys_msgctl)
-/* 305 */	CALL(sys_shmat)
-		CALL(sys_shmdt)
-		CALL(sys_shmget)
-		CALL(sys_shmctl)
-		CALL(sys_add_key)
-/* 310 */	CALL(sys_request_key)
-		CALL(sys_keyctl)
-		CALL(ABI(sys_semtimedop, sys_oabi_semtimedop))
-/* vserver */	CALL(sys_ni_syscall)
-		CALL(sys_ioprio_set)
-/* 315 */	CALL(sys_ioprio_get)
-		CALL(sys_inotify_init)
-		CALL(sys_inotify_add_watch)
-		CALL(sys_inotify_rm_watch)
-		CALL(sys_mbind)
-/* 320 */	CALL(sys_get_mempolicy)
-		CALL(sys_set_mempolicy)
-		CALL(sys_openat)
-		CALL(sys_mkdirat)
-		CALL(sys_mknodat)
-/* 325 */	CALL(sys_fchownat)
-		CALL(sys_futimesat)
-		CALL(ABI(sys_fstatat64,  sys_oabi_fstatat64))
-		CALL(sys_unlinkat)
-		CALL(sys_renameat)
-/* 330 */	CALL(sys_linkat)
-		CALL(sys_symlinkat)
-		CALL(sys_readlinkat)
-		CALL(sys_fchmodat)
-		CALL(sys_faccessat)
-/* 335 */	CALL(sys_pselect6)
-		CALL(sys_ppoll)
-		CALL(sys_unshare)
-		CALL(sys_set_robust_list)
-		CALL(sys_get_robust_list)
-/* 340 */	CALL(sys_splice)
-		CALL(sys_sync_file_range2)
-		CALL(sys_tee)
-		CALL(sys_vmsplice)
-		CALL(sys_move_pages)
-/* 345 */	CALL(sys_getcpu)
-		CALL(sys_epoll_pwait)
-		CALL(sys_kexec_load)
-		CALL(sys_utimensat)
-		CALL(sys_signalfd)
-/* 350 */	CALL(sys_timerfd_create)
-		CALL(sys_eventfd)
-		CALL(sys_fallocate)
-		CALL(sys_timerfd_settime)
-		CALL(sys_timerfd_gettime)
-/* 355 */	CALL(sys_signalfd4)
-		CALL(sys_eventfd2)
-		CALL(sys_epoll_create1)
-		CALL(sys_dup3)
-		CALL(sys_pipe2)
-/* 360 */	CALL(sys_inotify_init1)
-		CALL(sys_preadv)
-		CALL(sys_pwritev)
-		CALL(sys_rt_tgsigqueueinfo)
-		CALL(sys_perf_event_open)
-/* 365 */	CALL(sys_recvmmsg)
-		CALL(sys_accept4)
-		CALL(sys_fanotify_init)
-		CALL(sys_fanotify_mark)
-		CALL(sys_prlimit64)
-/* 370 */	CALL(sys_name_to_handle_at)
-		CALL(sys_open_by_handle_at)
-		CALL(sys_clock_adjtime)
-		CALL(sys_syncfs)
-		CALL(sys_sendmmsg)
-/* 375 */	CALL(sys_setns)
-		CALL(sys_process_vm_readv)
-		CALL(sys_process_vm_writev)
-		CALL(sys_kcmp)
-		CALL(sys_finit_module)
-/* 380 */	CALL(sys_sched_setattr)
-		CALL(sys_sched_getattr)
-		CALL(sys_renameat2)
-		CALL(sys_seccomp)
-		CALL(sys_getrandom)
-/* 385 */	CALL(sys_memfd_create)
-		CALL(sys_bpf)
-		CALL(sys_execveat)
-		CALL(sys_userfaultfd)
-		CALL(sys_membarrier)
-/* 390 */	CALL(sys_mlock2)
-		CALL(sys_copy_file_range)
-		CALL(sys_preadv2)
-		CALL(sys_pwritev2)
-#ifndef syscalls_counted
-.equ syscalls_padding, ((NR_syscalls + 3) & ~3) - NR_syscalls
-#define syscalls_counted
-#endif
-.rept syscalls_padding
-		CALL(sys_ni_syscall)
-.endr
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 10c3283d6c19..eb5cd77bf1d8 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -12,6 +12,11 @@
 #include <asm/unistd.h>
 #include <asm/ftrace.h>
 #include <asm/unwind.h>
+#ifdef CONFIG_AEABI
+#include <asm/unistd-oabi.h>
+#endif
+
+	.equ	NR_syscalls, __NR_syscalls
 
 #ifdef CONFIG_NEED_RET_TO_USER
 #include <mach/entry-macro.S>
@@ -120,21 +125,6 @@ ENTRY(ret_from_fork)
 	b	ret_slow_syscall
 ENDPROC(ret_from_fork)
 
-	.equ NR_syscalls,0
-#define CALL(x) .equ NR_syscalls,NR_syscalls+1
-#include "calls.S"
-
-/*
- * Ensure that the system call table is equal to __NR_syscalls,
- * which is the value the rest of the system sees
- */
-.ifne NR_syscalls - __NR_syscalls
-.error "__NR_syscalls is not equal to the size of the syscall table"
-.endif
-
-#undef CALL
-#define CALL(x) .long x
-
 /*=============================================================================
  * SWI handler
  *-----------------------------------------------------------------------------
@@ -291,22 +281,48 @@ ENDPROC(vector_swi)
 #endif
 	.ltorg
 
+	.macro	syscall_table_start, sym
+	.equ	__sys_nr, 0
+	.type	\sym, #object
+ENTRY(\sym)
+	.endm
+
+	.macro	syscall, nr, func
+	.ifgt	__sys_nr - \nr
+	.error	"Duplicated/unorded system call entry"
+	.endif
+	.rept	\nr - __sys_nr
+	.long	sys_ni_syscall
+	.endr
+	.long	\func
+	.equ	__sys_nr, \nr + 1
+	.endm
+
+	.macro	syscall_table_end, sym
+	.ifgt	__sys_nr - __NR_syscalls
+	.error	"System call table too big"
+	.endif
+	.rept	__NR_syscalls - __sys_nr
+	.long	sys_ni_syscall
+	.endr
+	.size	\sym, . - \sym
+	.endm
+
+#define NATIVE(nr, func) syscall nr, func
+
 /*
  * This is the syscall table declaration for native ABI syscalls.
  * With EABI a couple syscalls are obsolete and defined as sys_ni_syscall.
  */
-#define ABI(native, compat) native
+	syscall_table_start sys_call_table
+#define COMPAT(nr, native, compat) syscall nr, native
 #ifdef CONFIG_AEABI
-#define OBSOLETE(syscall) sys_ni_syscall
+#include <calls-eabi.S>
 #else
-#define OBSOLETE(syscall) syscall
+#include <calls-oabi.S>
 #endif
-
-	.type	sys_call_table, #object
-ENTRY(sys_call_table)
-#include "calls.S"
-#undef ABI
-#undef OBSOLETE
+#undef COMPAT
+	syscall_table_end sys_call_table
 
 /*============================================================================
  * Special system call wrappers
@@ -407,14 +423,10 @@ ENDPROC(sys_oabi_readahead)
  * Let's declare a second syscall table for old ABI binaries
  * using the compatibility syscall entries.
  */
-#define ABI(native, compat) compat
-#define OBSOLETE(syscall) syscall
-
-	.type	sys_oabi_call_table, #object
-ENTRY(sys_oabi_call_table)
-#include "calls.S"
-#undef ABI
-#undef OBSOLETE
+	syscall_table_start sys_oabi_call_table
+#define COMPAT(nr, native, compat) syscall nr, compat
+#include <calls-oabi.S>
+	syscall_table_end sys_oabi_call_table
 
 #endif
 
diff --git a/arch/arm/tools/Makefile b/arch/arm/tools/Makefile
index bdf48e4949ad..92eb5c3b486c 100644
--- a/arch/arm/tools/Makefile
+++ b/arch/arm/tools/Makefile
@@ -6,17 +6,31 @@
 
 gen := arch/$(ARCH)/include/generated
 kapi := $(gen)/asm
+uapi := $(gen)/uapi/asm
+syshdr := $(srctree)/$(src)/syscallhdr.sh
+sysnr := $(srctree)/$(src)/syscallnr.sh
+systbl := $(srctree)/$(src)/syscalltbl.sh
+syscall := $(srctree)/$(src)/syscall.tbl
 
-kapi-hdrs-y := $(kapi)/mach-types.h
+gen-y := $(gen)/calls-oabi.S
+gen-y += $(gen)/calls-eabi.S
+kapi-hdrs-y := $(kapi)/unistd-nr.h
+kapi-hdrs-y += $(kapi)/mach-types.h
+uapi-hdrs-y := $(uapi)/unistd-common.h
+uapi-hdrs-y += $(uapi)/unistd-oabi.h
+uapi-hdrs-y += $(uapi)/unistd-eabi.h
 
-targets += $(addprefix ../../../,$(kapi-hdrs-y))
+targets += $(addprefix ../../../,$(gen-y) $(kapi-hdrs-y) $(uapi-hdrs-y))
 
-PHONY += kapi
+PHONY += kapi uapi
 
-kapi:	$(kapi-hdrs-y)
+kapi:	$(kapi-hdrs-y) $(gen-y)
+
+uapi:	$(uapi-hdrs-y)
 
 # Create output directory if not already present
-_dummy := $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
+_dummy := $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)') \
+          $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')
 
 quiet_cmd_gen_mach = GEN     $@
       cmd_gen_mach = mkdir -p $(dir $@) && \
@@ -25,3 +39,41 @@ quiet_cmd_gen_mach = GEN     $@
 
 $(kapi)/mach-types.h: $(src)/gen-mach-types $(src)/mach-types FORCE
 	$(call if_changed,gen_mach)
+
+quiet_cmd_syshdr = SYSHDR  $@
+      cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@' \
+		   '$(syshdr_abi_$(basetarget))' \
+		   '$(syshdr_pfx_$(basetarget))' \
+		   '__NR_SYSCALL_BASE'
+
+quiet_cmd_systbl = SYSTBL  $@
+      cmd_systbl = $(CONFIG_SHELL) '$(systbl)' '$<' '$@' \
+		   '$(systbl_abi_$(basetarget))'
+
+quiet_cmd_sysnr  = SYSNR   $@
+      cmd_sysnr  = $(CONFIG_SHELL) '$(sysnr)' '$<' '$@' \
+		   '$(syshdr_abi_$(basetarget))'
+
+syshdr_abi_unistd-common := common
+$(uapi)/unistd-common.h: $(syscall) $(syshdr) FORCE
+	$(call if_changed,syshdr)
+
+syshdr_abi_unistd-oabi := oabi
+$(uapi)/unistd-oabi.h: $(syscall) $(syshdr) FORCE
+	$(call if_changed,syshdr)
+
+syshdr_abi_unistd-eabi := eabi
+$(uapi)/unistd-eabi.h: $(syscall) $(syshdr) FORCE
+	$(call if_changed,syshdr)
+
+sysnr_abi_unistd-nr := common,oabi,eabi,compat
+$(kapi)/unistd-nr.h: $(syscall) $(sysnr) FORCE
+	$(call if_changed,sysnr)
+
+systbl_abi_calls-oabi := common,oabi
+$(gen)/calls-oabi.S: $(syscall) $(systbl) FORCE
+	$(call if_changed,systbl)
+
+systbl_abi_calls-eabi := common,eabi
+$(gen)/calls-eabi.S: $(syscall) $(systbl) FORCE
+	$(call if_changed,systbl)
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
new file mode 100644
index 000000000000..62285cbd09c0
--- /dev/null
+++ b/arch/arm/tools/syscall.tbl
@@ -0,0 +1,428 @@
+#
+# Linux system call numbers and entry vectors
+#
+# The format is:
+# <num>	<abi>	<name>			<entry point>			<oabi compat entry point>
+#
+# Where abi is:
+#  common - for system calls shared between oabi and eabi
+#  oabi   - for oabi-only system calls (may have compat)
+#  eabi   - for eabi-only system calls
+#
+# For each syscall number, "common" is mutually exclusive with oabi and eabi
+#
+0	common	restart_syscall		sys_restart_syscall
+1	common	exit			sys_exit
+2	common	fork			sys_fork
+3	common	read			sys_read
+4	common	write			sys_write
+5	common	open			sys_open
+6	common	close			sys_close
+# 7 was sys_waitpid
+8	common	creat			sys_creat
+9	common	link			sys_link
+10	common	unlink			sys_unlink
+11	common	execve			sys_execve
+12	common	chdir			sys_chdir
+13	oabi	time			sys_time
+14	common	mknod			sys_mknod
+15	common	chmod			sys_chmod
+16	common	lchown			sys_lchown16
+# 17 was sys_break
+# 18 was sys_stat
+19	common	lseek			sys_lseek
+20	common	getpid			sys_getpid
+21	common	mount			sys_mount
+22	oabi	umount			sys_oldumount
+23	common	setuid			sys_setuid16
+24	common	getuid			sys_getuid16
+25	oabi	stime			sys_stime
+26	common	ptrace			sys_ptrace
+27	oabi	alarm			sys_alarm
+# 28 was sys_fstat
+29	common	pause			sys_pause
+30	oabi	utime			sys_utime
+# 31 was sys_stty
+# 32 was sys_gtty
+33	common	access			sys_access
+34	common	nice			sys_nice
+# 35 was sys_ftime
+36	common	sync			sys_sync
+37	common	kill			sys_kill
+38	common	rename			sys_rename
+39	common	mkdir			sys_mkdir
+40	common	rmdir			sys_rmdir
+41	common	dup			sys_dup
+42	common	pipe			sys_pipe
+43	common	times			sys_times
+# 44 was sys_prof
+45	common	brk			sys_brk
+46	common	setgid			sys_setgid16
+47	common	getgid			sys_getgid16
+# 48 was sys_signal
+49	common	geteuid			sys_geteuid16
+50	common	getegid			sys_getegid16
+51	common	acct			sys_acct
+52	common	umount2			sys_umount
+# 53 was sys_lock
+54	common	ioctl			sys_ioctl
+55	common	fcntl			sys_fcntl
+# 56 was sys_mpx
+57	common	setpgid			sys_setpgid
+# 58 was sys_ulimit
+# 59 was sys_olduname
+60	common	umask			sys_umask
+61	common	chroot			sys_chroot
+62	common	ustat			sys_ustat
+63	common	dup2			sys_dup2
+64	common	getppid			sys_getppid
+65	common	getpgrp			sys_getpgrp
+66	common	setsid			sys_setsid
+67	common	sigaction		sys_sigaction
+# 68 was sys_sgetmask
+# 69 was sys_ssetmask
+70	common	setreuid		sys_setreuid16
+71	common	setregid		sys_setregid16
+72	common	sigsuspend		sys_sigsuspend
+73	common	sigpending		sys_sigpending
+74	common	sethostname		sys_sethostname
+75	common	setrlimit		sys_setrlimit
+# Back compat 2GB limited rlimit
+76	oabi	getrlimit		sys_old_getrlimit
+77	common	getrusage		sys_getrusage
+78	common	gettimeofday		sys_gettimeofday
+79	common	settimeofday		sys_settimeofday
+80	common	getgroups		sys_getgroups16
+81	common	setgroups		sys_setgroups16
+82	oabi	select			sys_old_select
+83	common	symlink			sys_symlink
+# 84 was sys_lstat
+85	common	readlink		sys_readlink
+86	common	uselib			sys_uselib
+87	common	swapon			sys_swapon
+88	common	reboot			sys_reboot
+89	oabi	readdir			sys_old_readdir
+90	oabi	mmap			sys_old_mmap
+91	common	munmap			sys_munmap
+92	common	truncate		sys_truncate
+93	common	ftruncate		sys_ftruncate
+94	common	fchmod			sys_fchmod
+95	common	fchown			sys_fchown16
+96	common	getpriority		sys_getpriority
+97	common	setpriority		sys_setpriority
+# 98 was sys_profil
+99	common	statfs			sys_statfs
+100	common	fstatfs			sys_fstatfs
+# 101 was sys_ioperm
+102	oabi	socketcall		sys_socketcall		sys_oabi_socketcall
+103	common	syslog			sys_syslog
+104	common	setitimer		sys_setitimer
+105	common	getitimer		sys_getitimer
+106	common	stat			sys_newstat
+107	common	lstat			sys_newlstat
+108	common	fstat			sys_newfstat
+# 109 was sys_uname
+# 110 was sys_iopl
+111	common	vhangup			sys_vhangup
+# 112 was sys_idle
+# syscall to call a syscall!
+113	oabi	syscall			sys_syscall
+114	common	wait4			sys_wait4
+115	common	swapoff			sys_swapoff
+116	common	sysinfo			sys_sysinfo
+117	oabi	ipc			sys_ipc			sys_oabi_ipc
+118	common	fsync			sys_fsync
+119	common	sigreturn		sys_sigreturn_wrapper
+120	common	clone			sys_clone
+121	common	setdomainname		sys_setdomainname
+122	common	uname			sys_newuname
+# 123 was sys_modify_ldt
+124	common	adjtimex		sys_adjtimex
+125	common	mprotect		sys_mprotect
+126	common	sigprocmask		sys_sigprocmask
+# 127 was sys_create_module
+128	common	init_module		sys_init_module
+129	common	delete_module		sys_delete_module
+# 130 was sys_get_kernel_syms
+131	common	quotactl		sys_quotactl
+132	common	getpgid			sys_getpgid
+133	common	fchdir			sys_fchdir
+134	common	bdflush			sys_bdflush
+135	common	sysfs			sys_sysfs
+136	common	personality		sys_personality
+# 137 was sys_afs_syscall
+138	common	setfsuid		sys_setfsuid16
+139	common	setfsgid		sys_setfsgid16
+140	common	_llseek			sys_llseek
+141	common	getdents		sys_getdents
+142	common	_newselect		sys_select
+143	common	flock			sys_flock
+144	common	msync			sys_msync
+145	common	readv			sys_readv
+146	common	writev			sys_writev
+147	common	getsid			sys_getsid
+148	common	fdatasync		sys_fdatasync
+149	common	_sysctl			sys_sysctl
+150	common	mlock			sys_mlock
+151	common	munlock			sys_munlock
+152	common	mlockall		sys_mlockall
+153	common	munlockall		sys_munlockall
+154	common	sched_setparam		sys_sched_setparam
+155	common	sched_getparam		sys_sched_getparam
+156	common	sched_setscheduler	sys_sched_setscheduler
+157	common	sched_getscheduler	sys_sched_getscheduler
+158	common	sched_yield		sys_sched_yield
+159	common	sched_get_priority_max	sys_sched_get_priority_max
+160	common	sched_get_priority_min	sys_sched_get_priority_min
+161	common	sched_rr_get_interval	sys_sched_rr_get_interval
+162	common	nanosleep		sys_nanosleep
+163	common	mremap			sys_mremap
+164	common	setresuid		sys_setresuid16
+165	common	getresuid		sys_getresuid16
+# 166 was sys_vm86
+# 167 was sys_query_module
+168	common	poll			sys_poll
+169	common	nfsservctl
+170	common	setresgid		sys_setresgid16
+171	common	getresgid		sys_getresgid16
+172	common	prctl			sys_prctl
+173	common	rt_sigreturn		sys_rt_sigreturn_wrapper
+174	common	rt_sigaction		sys_rt_sigaction
+175	common	rt_sigprocmask		sys_rt_sigprocmask
+176	common	rt_sigpending		sys_rt_sigpending
+177	common	rt_sigtimedwait		sys_rt_sigtimedwait
+178	common	rt_sigqueueinfo		sys_rt_sigqueueinfo
+179	common	rt_sigsuspend		sys_rt_sigsuspend
+180	oabi	pread64			sys_pread64		sys_oabi_pread64
+180	eabi	pread64			sys_pread64
+181	oabi	pwrite64		sys_pwrite64		sys_oabi_pwrite64
+181	eabi	pwrite64		sys_pwrite64
+182	common	chown			sys_chown16
+183	common	getcwd			sys_getcwd
+184	common	capget			sys_capget
+185	common	capset			sys_capset
+186	common	sigaltstack		sys_sigaltstack
+187	common	sendfile		sys_sendfile
+# 188 reserved
+# 189 reserved
+190	common	vfork			sys_vfork
+# SuS compliant getrlimit
+191	common	ugetrlimit		sys_getrlimit
+192	common	mmap2			sys_mmap2
+193	oabi	truncate64		sys_truncate64		sys_oabi_truncate64
+193	eabi	truncate64		sys_truncate64
+194	oabi	ftruncate64		sys_ftruncate64		sys_oabi_ftruncate64
+194	eabi	ftruncate64		sys_ftruncate64
+195	oabi	stat64			sys_stat64		sys_oabi_stat64
+195	eabi	stat64			sys_stat64
+196	oabi	lstat64			sys_lstat64		sys_oabi_lstat64
+196	eabi	lstat64			sys_lstat64
+197	oabi	fstat64			sys_fstat64		sys_oabi_fstat64
+197	eabi	fstat64			sys_fstat64
+198	common	lchown32		sys_lchown
+199	common	getuid32		sys_getuid
+200	common	getgid32		sys_getgid
+201	common	geteuid32		sys_geteuid
+202	common	getegid32		sys_getegid
+203	common	setreuid32		sys_setreuid
+204	common	setregid32		sys_setregid
+205	common	getgroups32		sys_getgroups
+206	common	setgroups32		sys_setgroups
+207	common	fchown32		sys_fchown
+208	common	setresuid32		sys_setresuid
+209	common	getresuid32		sys_getresuid
+210	common	setresgid32		sys_setresgid
+211	common	getresgid32		sys_getresgid
+212	common	chown32			sys_chown
+213	common	setuid32		sys_setuid
+214	common	setgid32		sys_setgid
+215	common	setfsuid32		sys_setfsuid
+216	common	setfsgid32		sys_setfsgid
+217	common	getdents64		sys_getdents64
+218	common	pivot_root		sys_pivot_root
+219	common	mincore			sys_mincore
+220	common	madvise			sys_madvise
+221	oabi	fcntl64			sys_fcntl64		sys_oabi_fcntl64
+221	eabi	fcntl64			sys_fcntl64
+# 222 for tux
+# 223 is unused
+224	common	gettid			sys_gettid
+225	oabi	readahead		sys_readahead		sys_oabi_readahead
+225	eabi	readahead		sys_readahead
+226	common	setxattr		sys_setxattr
+227	common	lsetxattr		sys_lsetxattr
+228	common	fsetxattr		sys_fsetxattr
+229	common	getxattr		sys_getxattr
+230	common	lgetxattr		sys_lgetxattr
+231	common	fgetxattr		sys_fgetxattr
+232	common	listxattr		sys_listxattr
+233	common	llistxattr		sys_llistxattr
+234	common	flistxattr		sys_flistxattr
+235	common	removexattr		sys_removexattr
+236	common	lremovexattr		sys_lremovexattr
+237	common	fremovexattr		sys_fremovexattr
+238	common	tkill			sys_tkill
+239	common	sendfile64		sys_sendfile64
+240	common	futex			sys_futex
+241	common	sched_setaffinity	sys_sched_setaffinity
+242	common	sched_getaffinity	sys_sched_getaffinity
+243	common	io_setup		sys_io_setup
+244	common	io_destroy		sys_io_destroy
+245	common	io_getevents		sys_io_getevents
+246	common	io_submit		sys_io_submit
+247	common	io_cancel		sys_io_cancel
+248	common	exit_group		sys_exit_group
+249	common	lookup_dcookie		sys_lookup_dcookie
+250	common	epoll_create		sys_epoll_create
+251	oabi	epoll_ctl		sys_epoll_ctl		sys_oabi_epoll_ctl
+251	eabi	epoll_ctl		sys_epoll_ctl
+252	oabi	epoll_wait		sys_epoll_wait		sys_oabi_epoll_wait
+252	eabi	epoll_wait		sys_epoll_wait
+253	common	remap_file_pages	sys_remap_file_pages
+# 254 for set_thread_area
+# 255 for get_thread_area
+256	common	set_tid_address		sys_set_tid_address
+257	common	timer_create		sys_timer_create
+258	common	timer_settime		sys_timer_settime
+259	common	timer_gettime		sys_timer_gettime
+260	common	timer_getoverrun	sys_timer_getoverrun
+261	common	timer_delete		sys_timer_delete
+262	common	clock_settime		sys_clock_settime
+263	common	clock_gettime		sys_clock_gettime
+264	common	clock_getres		sys_clock_getres
+265	common	clock_nanosleep		sys_clock_nanosleep
+266	common	statfs64		sys_statfs64_wrapper
+267	common	fstatfs64		sys_fstatfs64_wrapper
+268	common	tgkill			sys_tgkill
+269	common	utimes			sys_utimes
+270	common	arm_fadvise64_64	sys_arm_fadvise64_64
+271	common	pciconfig_iobase	sys_pciconfig_iobase
+272	common	pciconfig_read		sys_pciconfig_read
+273	common	pciconfig_write		sys_pciconfig_write
+274	common	mq_open			sys_mq_open
+275	common	mq_unlink		sys_mq_unlink
+276	common	mq_timedsend		sys_mq_timedsend
+277	common	mq_timedreceive		sys_mq_timedreceive
+278	common	mq_notify		sys_mq_notify
+279	common	mq_getsetattr		sys_mq_getsetattr
+280	common	waitid			sys_waitid
+281	common	socket			sys_socket
+282	oabi	bind			sys_bind		sys_oabi_bind
+282	eabi	bind			sys_bind
+283	oabi	connect			sys_connect		sys_oabi_connect
+283	eabi	connect			sys_connect
+284	common	listen			sys_listen
+285	common	accept			sys_accept
+286	common	getsockname		sys_getsockname
+287	common	getpeername		sys_getpeername
+288	common	socketpair		sys_socketpair
+289	common	send			sys_send
+290	oabi	sendto			sys_sendto		sys_oabi_sendto
+290	eabi	sendto			sys_sendto
+291	common	recv			sys_recv
+292	common	recvfrom		sys_recvfrom
+293	common	shutdown		sys_shutdown
+294	common	setsockopt		sys_setsockopt
+295	common	getsockopt		sys_getsockopt
+296	oabi	sendmsg			sys_sendmsg		sys_oabi_sendmsg
+296	eabi	sendmsg			sys_sendmsg
+297	common	recvmsg			sys_recvmsg
+298	oabi	semop			sys_semop		sys_oabi_semop
+298	eabi	semop			sys_semop
+299	common	semget			sys_semget
+300	common	semctl			sys_semctl
+301	common	msgsnd			sys_msgsnd
+302	common	msgrcv			sys_msgrcv
+303	common	msgget			sys_msgget
+304	common	msgctl			sys_msgctl
+305	common	shmat			sys_shmat
+306	common	shmdt			sys_shmdt
+307	common	shmget			sys_shmget
+308	common	shmctl			sys_shmctl
+309	common	add_key			sys_add_key
+310	common	request_key		sys_request_key
+311	common	keyctl			sys_keyctl
+312	oabi	semtimedop		sys_semtimedop		sys_oabi_semtimedop
+312	eabi	semtimedop		sys_semtimedop
+313	common	vserver
+314	common	ioprio_set		sys_ioprio_set
+315	common	ioprio_get		sys_ioprio_get
+316	common	inotify_init		sys_inotify_init
+317	common	inotify_add_watch	sys_inotify_add_watch
+318	common	inotify_rm_watch	sys_inotify_rm_watch
+319	common	mbind			sys_mbind
+320	common	get_mempolicy		sys_get_mempolicy
+321	common	set_mempolicy		sys_set_mempolicy
+322	common	openat			sys_openat
+323	common	mkdirat			sys_mkdirat
+324	common	mknodat			sys_mknodat
+325	common	fchownat		sys_fchownat
+326	common	futimesat		sys_futimesat
+327	oabi	fstatat64		sys_fstatat64		sys_oabi_fstatat64
+327	eabi	fstatat64		sys_fstatat64
+328	common	unlinkat		sys_unlinkat
+329	common	renameat		sys_renameat
+330	common	linkat			sys_linkat
+331	common	symlinkat		sys_symlinkat
+332	common	readlinkat		sys_readlinkat
+333	common	fchmodat		sys_fchmodat
+334	common	faccessat		sys_faccessat
+335	common	pselect6		sys_pselect6
+336	common	ppoll			sys_ppoll
+337	common	unshare			sys_unshare
+338	common	set_robust_list		sys_set_robust_list
+339	common	get_robust_list		sys_get_robust_list
+340	common	splice			sys_splice
+341	common	arm_sync_file_range	sys_sync_file_range2
+342	common	tee			sys_tee
+343	common	vmsplice		sys_vmsplice
+344	common	move_pages		sys_move_pages
+345	common	getcpu			sys_getcpu
+346	common	epoll_pwait		sys_epoll_pwait
+347	common	kexec_load		sys_kexec_load
+348	common	utimensat		sys_utimensat
+349	common	signalfd		sys_signalfd
+350	common	timerfd_create		sys_timerfd_create
+351	common	eventfd			sys_eventfd
+352	common	fallocate		sys_fallocate
+353	common	timerfd_settime		sys_timerfd_settime
+354	common	timerfd_gettime		sys_timerfd_gettime
+355	common	signalfd4		sys_signalfd4
+356	common	eventfd2		sys_eventfd2
+357	common	epoll_create1		sys_epoll_create1
+358	common	dup3			sys_dup3
+359	common	pipe2			sys_pipe2
+360	common	inotify_init1		sys_inotify_init1
+361	common	preadv			sys_preadv
+362	common	pwritev			sys_pwritev
+363	common	rt_tgsigqueueinfo	sys_rt_tgsigqueueinfo
+364	common	perf_event_open		sys_perf_event_open
+365	common	recvmmsg		sys_recvmmsg
+366	common	accept4			sys_accept4
+367	common	fanotify_init		sys_fanotify_init
+368	common	fanotify_mark		sys_fanotify_mark
+369	common	prlimit64		sys_prlimit64
+370	common	name_to_handle_at	sys_name_to_handle_at
+371	common	open_by_handle_at	sys_open_by_handle_at
+372	common	clock_adjtime		sys_clock_adjtime
+373	common	syncfs			sys_syncfs
+374	common	sendmmsg		sys_sendmmsg
+375	common	setns			sys_setns
+376	common	process_vm_readv	sys_process_vm_readv
+377	common	process_vm_writev	sys_process_vm_writev
+378	common	kcmp			sys_kcmp
+379	common	finit_module		sys_finit_module
+380	common	sched_setattr		sys_sched_setattr
+381	common	sched_getattr		sys_sched_getattr
+382	common	renameat2		sys_renameat2
+383	common	seccomp			sys_seccomp
+384	common	getrandom		sys_getrandom
+385	common	memfd_create		sys_memfd_create
+386	common	bpf			sys_bpf
+387	common	execveat		sys_execveat
+388	common	userfaultfd		sys_userfaultfd
+389	common	membarrier		sys_membarrier
+390	common	mlock2			sys_mlock2
+391	common	copy_file_range		sys_copy_file_range
+392	common	preadv2			sys_preadv2
+393	common	pwritev2		sys_pwritev2
diff --git a/arch/arm/tools/syscallhdr.sh b/arch/arm/tools/syscallhdr.sh
new file mode 100644
index 000000000000..72d4b2e3bdec
--- /dev/null
+++ b/arch/arm/tools/syscallhdr.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+in="$1"
+out="$2"
+my_abis=`echo "($3)" | tr ',' '|'`
+prefix="$4"
+offset="$5"
+
+fileguard=_ASM_ARM_`basename "$out" | sed \
+    -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
+    -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
+if echo $out | grep -q uapi; then
+    fileguard="_UAPI$fileguard"
+fi
+grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
+    echo "#ifndef ${fileguard}"
+    echo "#define ${fileguard} 1"
+    echo ""
+
+    while read nr abi name entry ; do
+	if [ -z "$offset" ]; then
+	    echo "#define __NR_${prefix}${name} $nr"
+	else
+	    echo "#define __NR_${prefix}${name} ($offset + $nr)"
+        fi
+    done
+
+    echo ""
+    echo "#endif /* ${fileguard} */"
+) > "$out"
diff --git a/arch/arm/tools/syscallnr.sh b/arch/arm/tools/syscallnr.sh
new file mode 100644
index 000000000000..d2971296469a
--- /dev/null
+++ b/arch/arm/tools/syscallnr.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+in="$1"
+out="$2"
+my_abis=`echo "($3)" | tr ',' '|'`
+align=1
+
+fileguard=_ASM_ARM_`basename "$out" | sed \
+    -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
+    -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
+
+grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | tail -n1 | (
+    echo "#ifndef ${fileguard}
+#define ${fileguard} 1
+
+/*
+ * This needs to be greater than __NR_last_syscall+1 in order to account
+ * for the padding in the syscall table.
+ */
+"
+
+    while read nr abi name entry; do
+        nr=$(($nr + 1))
+        while [ "$(($nr / (256 * $align) ))" -gt 0 ]; do
+            align=$(( $align * 4 ))
+        done
+        nr=$(( ($nr + $align - 1) & ~($align - 1) ))
+        echo "/* aligned to $align */"
+        echo "#define __NR_syscalls $nr"
+    done
+
+    echo ""
+    echo "#endif /* ${fileguard} */"
+) > "$out"
diff --git a/arch/arm/tools/syscalltbl.sh b/arch/arm/tools/syscalltbl.sh
new file mode 100644
index 000000000000..5ca834545ed3
--- /dev/null
+++ b/arch/arm/tools/syscalltbl.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+in="$1"
+out="$2"
+my_abis=`echo "($3)" | tr ',' '|'`
+
+grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
+    while read nr abi name entry compat; do
+        if [ "$abi" = "eabi" -a -n "$compat" ]; then
+            echo "$in: error: a compat entry for an EABI syscall ($name) makes no sense" >&2
+            exit 1
+        fi
+
+	if [ -n "$entry" ]; then
+            if [ -z "$compat" ]; then
+                echo "NATIVE($nr, $entry)"
+            else
+                echo "COMPAT($nr, $entry, $compat)"
+            fi
+        fi
+    done
+) > "$out"
-- 
2.1.0
