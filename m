From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed,  6 Nov 2013 19:25:45 +0900
Subject: [PATCH 3/4] arm64: audit: Add AArch32 support
In-Reply-To: <1383733546-2846-1-git-send-email-takahiro.akashi@linaro.org>
References: <1383733546-2846-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1383733546-2846-4-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 arch/arm64/include/asm/audit32.h  |   12 ++
 arch/arm64/include/asm/unistd32.h |  387 +++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/Makefile        |    3 +
 arch/arm64/kernel/audit.c         |   18 ++
 arch/arm64/kernel/audit32.c       |   46 +++++
 5 files changed, 466 insertions(+)
 create mode 100644 arch/arm64/include/asm/audit32.h
 create mode 100644 arch/arm64/kernel/audit32.c

diff --git a/arch/arm64/include/asm/audit32.h b/arch/arm64/include/asm/audit32.h
new file mode 100644
index 0000000..debfe57
--- /dev/null
+++ b/arch/arm64/include/asm/audit32.h
@@ -0,0 +1,12 @@
+#ifndef __ASM_AUDIT32_H
+#define __ASM_AUDIT32_H
+
+extern unsigned aarch32_dir_class[];
+extern unsigned aarch32_read_class[];
+extern unsigned aarch32_write_class[];
+extern unsigned aarch32_chattr_class[];
+extern unsigned aarch32_signal_class[];
+
+extern int aarch32_classify_syscall(unsigned);
+
+#endif /* __ASM_AUDIT32_H */
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 58125bf..fdf5e56 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -21,6 +21,393 @@
 #define __SYSCALL(x, y)
 #endif
 
+#ifdef __AARCH32_AUDITSYSCALL
+/*
+ * FIXME: Currenty only audit uses (part of) these definitions.
+ * See audit32.c
+ */
+#define __NR_restart_syscall 0
+#define __NR_exit 1
+#define __NR_fork 2
+#define __NR_read 3
+#define __NR_write 4
+#define __NR_open 5
+#define __NR_close 6
+/* 7 was waitpid */
+#define __NR_creat 8
+#define __NR_link 9
+#define __NR_unlink 10
+#define __NR_execve 11
+#define __NR_chdir 12
+/* #define __NR_ni_syscall 13 :time */
+#define __NR_mknod 14
+#define __NR_chmod 15
+#define __NR_lchown16 16
+/* 17 was break */
+/* 18 was stat */
+#define __NR_lseek 19
+#define __NR_getpid 20
+#define __NR_mount 21
+/* #define __NR_ni_syscall 22 :umount */
+#define __NR_setuid16 23
+#define __NR_getuid16 24
+/* #define __NR_ni_syscall 25 :stime */
+#define __NR_ptrace 26
+/* #define __NR_ni_syscall 27 :alarm */
+/* 28 was fstat */
+#define __NR_pause 29
+/* #define __NR_ni_syscall 30 :utime */
+/* 31 was stty */
+/* 32 was gtty */
+#define __NR_access 33
+#define __NR_nice 34
+/* 35 was ftime */
+#define __NR_sync 36
+#define __NR_kill 37
+#define __NR_rename 38
+#define __NR_mkdir 39
+#define __NR_rmdir 40
+#define __NR_dup 41
+#define __NR_pipe 42
+#define __NR_times 43
+/* 44 was prof */
+#define __NR_brk 45
+#define __NR_setgid16 46
+#define __NR_getgid16 47
+/* 48 was signal */
+#define __NR_geteuid16 49
+#define __NR_getegid16 50
+#define __NR_acct 51
+#define __NR_umount 52
+/* 53 was lock */
+#define __NR_ioctl 54
+#define __NR_fcntl 55
+/* 56 was mpx */
+#define __NR_setpgid 57
+/* 58 was ulimit */
+/* 59 was olduname */
+#define __NR_umask 60
+#define __NR_chroot 61
+#define __NR_ustat 62
+#define __NR_dup2 63
+#define __NR_getppid 64
+#define __NR_getpgrp 65
+#define __NR_setsid 66
+#define __NR_sigaction 67
+/* 68 was sgetmask */
+/* 69 was ssetmask */
+#define __NR_setreuid16 70
+#define __NR_setregid16 71
+#define __NR_sigsuspend 72
+#define __NR_sigpending 73
+#define __NR_sethostname 74
+#define __NR_setrlimit 75
+/* #define __NR_ni_syscall 76 :getrlimit */
+#define __NR_getrusage 77
+#define __NR_gettimeofday 78
+#define __NR_settimeofday 79
+#define __NR_getgroups16 80
+#define __NR_setgroups16 81
+/* #define __NR_ni_syscall 82 :select */
+#define __NR_symlink 83
+/* 84 was lstat */
+#define __NR_readlink 85
+#define __NR_uselib 86
+#define __NR_swapon 87
+#define __NR_reboot 88
+/* #define __NR_ni_syscall 89 :readdir */
+/* #define __NR_ni_syscall 90 :mmap */
+#define __NR_munmap 91
+#define __NR_truncate 92
+#define __NR_ftruncate 93
+#define __NR_fchmod 94
+#define __NR_fchown16 95
+#define __NR_getpriority 96
+#define __NR_setpriority 97
+/* 98 was profil */
+#define __NR_statfs 99
+#define __NR_fstatfs 100
+/* 101 was ioperm */
+/* 102 was socketcall */
+#define __NR_syslog 103
+#define __NR_setitimer 104
+#define __NR_getitimer 105
+#define __NR_newstat 106
+#define __NR_newlstat 107
+#define __NR_newfstat 108
+/* 109 was uname */
+/* 110 was iopl */
+#define __NR_vhangup 111
+/* 112 was idle */
+/* #define __NR_ni_syscall 113 :syscall */
+#define __NR_wait4 114
+#define __NR_swapoff 115
+#define __NR_sysinfo 116
+/* #define __NR_ni_syscall 117 :ipc */
+#define __NR_fsync 118
+#define __NR_sigreturn 119
+#define __NR_clone 120
+#define __NR_setdomainname 121
+#define __NR_newuname 122
+/* 123 was modify_ldt */
+#define __NR_adjtimex 124
+#define __NR_mprotect 125
+#define __NR_sigprocmask 126
+/* 127 was create_module */
+#define __NR_init_module 128
+#define __NR_delete_module 129
+/* 130 was get_kernel_syms */
+#define __NR_quotactl 131
+#define __NR_getpgid 132
+#define __NR_fchdir 133
+#define __NR_bdflush 134
+#define __NR_sysfs 135
+#define __NR_personality 136
+/* 137 was afs_syscall */
+#define __NR_setfsuid16 138
+#define __NR_setfsgid16 139
+#define __NR_llseek 140
+#define __NR_getdents 141
+#define __NR_select 142
+#define __NR_flock 143
+#define __NR_msync 144
+#define __NR_readv 145
+#define __NR_writev 146
+#define __NR_getsid 147
+#define __NR_fdatasync 148
+#define __NR_sysctl 149
+#define __NR_mlock 150
+#define __NR_munlock 151
+#define __NR_mlockall 152
+#define __NR_munlockall 153
+#define __NR_sched_setparam 154
+#define __NR_sched_getparam 155
+#define __NR_sched_setscheduler 156
+#define __NR_sched_getscheduler 157
+#define __NR_sched_yield 158
+#define __NR_sched_get_priority_max 159
+#define __NR_sched_get_priority_min 160
+#define __NR_sched_rr_get_interval 161
+#define __NR_nanosleep 162
+#define __NR_mremap 163
+#define __NR_setresuid16 164
+#define __NR_getresuid16 165
+/* 166 was vm86 */
+/* 167 was query_module */
+#define __NR_poll 168
+/* #define __NR_ni_syscall 169 :nfsservctl */
+#define __NR_setresgid16 170
+#define __NR_getresgid16 171
+#define __NR_prctl 172
+#define __NR_rt_sigreturn 173
+#define __NR_rt_sigaction 174
+#define __NR_rt_sigprocmask 175
+#define __NR_rt_sigpending 176
+#define __NR_rt_sigtimedwait 177
+#define __NR_rt_sigqueueinfo 178
+#define __NR_rt_sigsuspend 179
+#define __NR_pread64 180
+#define __NR_pwrite64 181
+#define __NR_chown16 182
+#define __NR_getcwd 183
+#define __NR_capget 184
+#define __NR_capset 185
+#define __NR_sigaltstack 186
+#define __NR_sendfile 187
+/* 188 reserved */
+/* 189 reserved */
+#define __NR_vfork 190
+#define __NR_getrlimit 191
+#define __NR_mmap_pgoff 192
+#define __NR_truncate64 193
+#define __NR_ftruncate64 194
+#define __NR_stat64 195
+#define __NR_lstat64 196
+#define __NR_fstat64 197
+#define __NR_lchown 198
+#define __NR_getuid 199
+#define __NR_getgid 200
+#define __NR_geteuid 201
+#define __NR_getegid 202
+#define __NR_setreuid 203
+#define __NR_setregid 204
+#define __NR_getgroups 205
+#define __NR_setgroups 206
+#define __NR_fchown 207
+#define __NR_setresuid 208
+#define __NR_getresuid 209
+#define __NR_setresgid 210
+#define __NR_getresgid 211
+#define __NR_chown 212
+#define __NR_setuid 213
+#define __NR_setgid 214
+#define __NR_setfsuid 215
+#define __NR_setfsgid 216
+#define __NR_getdents64 217
+#define __NR_pivot_root 218
+#define __NR_mincore 219
+#define __NR_madvise 220
+#define __NR_fcntl64 221
+/* 222 was tux */
+/* 223 reserved */
+#define __NR_gettid 224
+#define __NR_readahead 225
+#define __NR_setxattr 226
+#define __NR_lsetxattr 227
+#define __NR_fsetxattr 228
+#define __NR_getxattr 229
+#define __NR_lgetxattr 230
+#define __NR_fgetxattr 231
+#define __NR_listxattr 232
+#define __NR_llistxattr 233
+#define __NR_flistxattr 234
+#define __NR_removexattr 235
+#define __NR_lremovexattr 236
+#define __NR_fremovexattr 237
+#define __NR_tkill 238
+#define __NR_sendfile64 239
+#define __NR_futex 240
+#define __NR_sched_setaffinity 241
+#define __NR_sched_getaffinity 242
+#define __NR_io_setup 243
+#define __NR_io_destroy 244
+#define __NR_io_getevents 245
+#define __NR_io_submit 246
+#define __NR_io_cancel 247
+#define __NR_exit_group 248
+#define __NR_lookup_dcookie 249
+#define __NR_epoll_create 250
+#define __NR_epoll_ctl 251
+#define __NR_epoll_wait 252
+#define __NR_remap_file_pages 253
+/* 254 was set_thread_area */
+/* 255 was get_thread_area */
+#define __NR_set_tid_address 256
+#define __NR_timer_create 257
+#define __NR_timer_settime 258
+#define __NR_timer_gettime 259
+#define __NR_timer_getoverrun 260
+#define __NR_timer_delete 261
+#define __NR_clock_settime 262
+#define __NR_clock_gettime 263
+#define __NR_clock_getres 264
+#define __NR_clock_nanosleep 265
+#define __NR_statfs64 266
+#define __NR_fstatfs64 267
+#define __NR_tgkill 268
+#define __NR_utimes 269
+#define __NR_fadvise64_64 270
+#define __NR_pciconfig_iobase 271
+#define __NR_pciconfig_read 272
+#define __NR_pciconfig_write 273
+#define __NR_mq_open 274
+#define __NR_mq_unlink 275
+#define __NR_mq_timedsend 276
+#define __NR_mq_timedreceive 277
+#define __NR_mq_notify 278
+#define __NR_mq_getsetattr 279
+#define __NR_waitid 280
+#define __NR_socket 281
+#define __NR_bind 282
+#define __NR_connect 283
+#define __NR_listen 284
+#define __NR_accept 285
+#define __NR_getsockname 286
+#define __NR_getpeername 287
+#define __NR_socketpair 288
+#define __NR_send 289
+#define __NR_sendto 290
+#define __NR_recv 291
+#define __NR_recvfrom 292
+#define __NR_shutdown 293
+#define __NR_setsockopt 294
+#define __NR_getsockopt 295
+#define __NR_sendmsg 296
+#define __NR_recvmsg 297
+#define __NR_semop 298
+#define __NR_semget 299
+#define __NR_semctl 300
+#define __NR_msgsnd 301
+#define __NR_msgrcv 302
+#define __NR_msgget 303
+#define __NR_msgctl 304
+#define __NR_shmat 305
+#define __NR_shmdt 306
+#define __NR_shmget 307
+#define __NR_shmctl 308
+#define __NR_add_key 309
+#define __NR_request_key 310
+#define __NR_keyctl 311
+#define __NR_semtimedop 312
+/* #define __NR_ni_syscall 313 :vserver */
+#define __NR_ioprio_set 314
+#define __NR_ioprio_get 315
+#define __NR_inotify_init 316
+#define __NR_inotify_add_watch 317
+#define __NR_inotify_rm_watch 318
+#define __NR_mbind 319
+#define __NR_get_mempolicy 320
+#define __NR_set_mempolicy 321
+#define __NR_openat 322
+#define __NR_mkdirat 323
+#define __NR_mknodat 324
+#define __NR_fchownat 325
+#define __NR_futimesat 326
+#define __NR_fstatat64 327
+#define __NR_unlinkat 328
+#define __NR_renameat 329
+#define __NR_linkat 330
+#define __NR_symlinkat 331
+#define __NR_readlinkat 332
+#define __NR_fchmodat 333
+#define __NR_faccessat 334
+#define __NR_pselect6 335
+#define __NR_ppoll 336
+#define __NR_unshare 337
+#define __NR_set_robust_list 338
+#define __NR_get_robust_list 339
+#define __NR_splice 340
+#define __NR_sync_file_range2 341
+#define __NR_tee 342
+#define __NR_vmsplice 343
+#define __NR_move_pages 344
+#define __NR_getcpu 345
+#define __NR_epoll_pwait 346
+#define __NR_kexec_load 347
+#define __NR_utimensat 348
+#define __NR_signalfd 349
+#define __NR_timerfd_create 350
+#define __NR_eventfd 351
+#define __NR_fallocate 352
+#define __NR_timerfd_settime 353
+#define __NR_timerfd_gettime 354
+#define __NR_signalfd4 355
+#define __NR_eventfd2 356
+#define __NR_epoll_create1 357
+#define __NR_dup3 358
+#define __NR_pipe2 359
+#define __NR_inotify_init1 360
+#define __NR_preadv 361
+#define __NR_pwritev 362
+#define __NR_rt_tgsigqueueinfo 363
+#define __NR_perf_event_open 364
+#define __NR_recvmmsg 365
+#define __NR_accept4 366
+#define __NR_fanotify_init 367
+#define __NR_fanotify_mark 368
+#define __NR_prlimit64 369
+#define __NR_name_to_handle_at 370
+#define __NR_open_by_handle_at 371
+#define __NR_clock_adjtime 372
+#define __NR_syncfs 373
+#define __NR_sendmmsg 374
+#define __NR_setns 375
+#define __NR_process_vm_readv 376
+#define __NR_process_vm_writev 377
+/* 378 was kcmp */
+/* 389 was finit_module */
+#endif
+
 __SYSCALL(0,   sys_restart_syscall)
 __SYSCALL(1,   sys_exit)
 __SYSCALL(2,   sys_fork)
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 3abab29..0286b91 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -12,6 +12,9 @@ arm64-obj-y		:= cputable.o debug-monitors.o entry.o irq.o fpsimd.o	\
 			   hyp-stub.o psci.o
 
 arm64-obj-$(CONFIG_AUDIT)		+= audit.o
+ifeq ($(CONFIG_COMPAT),y)
+arm64-obj-$(CONFIG_AUDIT)		+= audit32.o
+endif
 arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
diff --git a/arch/arm64/kernel/audit.c b/arch/arm64/kernel/audit.c
index 9aab2b3..799eb55 100644
--- a/arch/arm64/kernel/audit.c
+++ b/arch/arm64/kernel/audit.c
@@ -1,5 +1,8 @@
 #include <linux/audit.h>
 #include <linux/init.h>
+#ifdef CONFIG_COMPAT
+#include <asm/audit32.h>
+#endif
 #include <asm/unistd.h>
 
 static unsigned dir_class[] = {
@@ -29,12 +32,20 @@ static unsigned signal_class[] = {
 
 int audit_classify_arch(int arch)
 {
+#ifdef CONFIG_COMPAT
+	if (arch == AUDIT_ARCH_ARM || arch == AUDIT_ARCH_ARMEB)
+		return 1; /* 32-bit on biarch */
+#endif
 	return 0; /* native */
 }
 
 /* AUTH_PERM support */
 int audit_classify_syscall(int abi, unsigned syscall)
 {
+#ifdef CONFIG_COMPAT
+	if (abi == AUDIT_ARCH_ARM || abi == AUDIT_ARCH_ARMEB)
+		return aarch32_classify_syscall(syscall);
+#endif
 	switch(syscall) {
 	case __NR_openat:
 		return 3;
@@ -47,6 +58,13 @@ int audit_classify_syscall(int abi, unsigned syscall)
 
 static int __init audit_classes_init(void)
 {
+#ifdef CONFIG_COMPAT
+	audit_register_class(AUDIT_CLASS_DIR_WRITE_32, aarch32_dir_class);
+	audit_register_class(AUDIT_CLASS_READ_32, aarch32_read_class);
+	audit_register_class(AUDIT_CLASS_WRITE_32, aarch32_write_class);
+	audit_register_class(AUDIT_CLASS_CHATTR_32, aarch32_chattr_class);
+	audit_register_class(AUDIT_CLASS_SIGNAL_32, aarch32_signal_class);
+#endif
 	audit_register_class(AUDIT_CLASS_DIR_WRITE, dir_class);
 	audit_register_class(AUDIT_CLASS_READ, read_class);
 	audit_register_class(AUDIT_CLASS_WRITE, write_class);
diff --git a/arch/arm64/kernel/audit32.c b/arch/arm64/kernel/audit32.c
new file mode 100644
index 0000000..2aa4d7d
--- /dev/null
+++ b/arch/arm64/kernel/audit32.c
@@ -0,0 +1,46 @@
+#define __AARCH32_AUDITSYSCALL
+#include <asm/unistd32.h>
+
+unsigned aarch32_dir_class[] = {
+#include <asm-generic/audit_dir_write.h>
+~0U
+};
+
+unsigned aarch32_read_class[] = {
+#include <asm-generic/audit_read.h>
+~0U
+};
+
+unsigned aarch32_write_class[] = {
+#include <asm-generic/audit_write.h>
+~0U
+};
+
+unsigned aarch32_chattr_class[] = {
+#include <asm-generic/audit_change_attr.h>
+~0U
+};
+
+unsigned aarch32_signal_class[] = {
+#include <asm-generic/audit_signal.h>
+~0U
+};
+
+int aarch32_classify_syscall(unsigned syscall)
+{
+	switch(syscall) {
+	case __NR_open:
+		return 2;
+	case __NR_openat:
+		return 3;
+	/*
+	 * obsolute in EABI
+	 * case __NR_socketcall:
+	 *	return 4;
+	 */
+	case __NR_execve:
+		return 5;
+	default:
+		return 1; /* 32-bit on biarch */
+	}
+}
-- 
1.7.9.5
