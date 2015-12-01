From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 1 Dec 2015 03:40:09 +0300
Subject: [PATCH v6 14/19] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <3463212.HtU7UeIULQ@wuerfel>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <2133692.Tueq9xZUPQ@wuerfel> <20151130202141.GA23254@yury-N73SV>
 <3463212.HtU7UeIULQ@wuerfel>
Message-ID: <20151201004009.GB23254@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2015 at 10:49:43PM +0100, Arnd Bergmann wrote:
> 
> Could we try to get consensus on how the syscall ABI should look
> before you start adapting glibc to another intermediate version?
> I think that would also save you duplicate work, as it's always
> possible that we misunderstand each other in the review. Also,
> when someone asks you questions during a review, please reply to
> those questions so we can get a common understanding of the facts
> and document that in the mail archives.
> 
> 	Arnd

This is full syscall table for ILP32, how it looks right now.
I collected all comments here and do rework according it.
Any comments?

BR,
Yury.

[0] = compat_sys_io_setup,			
[1] = sys_io_destroy,
[2] = compat_sys_io_submit,
[3] = sys_io_cancel,
[4] = sys_io_getevents,			wrong timespec_t and aio_context_t here
[5] = sys_setxattr,
[6] = sys_lsetxattr,
[7] = sys_fsetxattr,
[8] = sys_getxattr,
[9] = sys_lgetxattr,
[10] = sys_fgetxattr,
[11] = sys_listxattr,
[12] = sys_llistxattr,
[13] = sys_flistxattr,
[14] = sys_removexattr,
[15] = sys_lremovexattr,
[16] = sys_fremovexattr,
[17] = sys_getcwd,
[18] = sys_lookup_dcookie,
[19] = sys_eventfd2,
[20] = sys_epoll_create1,
[21] = sys_epoll_ctl,
[22] = sys_epoll_pwait,			way round: takes sigset_t check BE
[23] = sys_dup,
[24] = sys_dup3,
[25] = compat_sys_fcntl,		uses compat_off_t, not compat_loff_t
[26] = sys_inotify_init1,
[27] = sys_inotify_add_watch,
[28] = sys_inotify_rm_watch,
[29] = compat_sys_ioctl,
[30] = sys_ioprio_set,
[31] = sys_ioprio_get,
[32] = sys_flock,
[33] = sys_mknodat,
[34] = sys_mkdirat,
[35] = sys_unlinkat,
[36] = sys_symlinkat,
[37] = sys_linkat,
[38] = sys_renameat,
[39] = sys_umount,
[40] = compat_sys_mount,
[41] = sys_pivot_root,
[42] = sys_ni_syscall,
[43] = compat_sys_statfs64_wrapper,	check wrappers, maybe just statfs64
[44] = compat_sys_fstatfs64_wrapper,				   fstatfs64
[45] = sys_truncate,
[46] = sys_ftruncate,
[47] = sys_fallocate,
[48] = sys_faccessat,
[49] = sys_chdir,
[50] = sys_fchdir,
[51] = sys_chroot,
[52] = sys_fchmod,
[53] = sys_fchmodat,
[54] = sys_fchownat,
[55] = sys_fchown,
[56] = sys_openat,			force O_LARGEFILE in asm-generic/unistd.h
					make tile32 to use compat
[57] = sys_close,
[58] = sys_vhangup,
[59] = sys_pipe2,
[60] = sys_quotactl,
[61] = sys_getdents64,			check: glibc uses linux_dirent64 for
					32-bit architectures, so this looks wrong
[62] = sys_llseek,			use 3-argument lseek
[63] = sys_read,
[64] = sys_write,
[65] = compat_sys_readv,
[66] = compat_sys_writev,
[67] = sys_pread64,
[68] = sys_pwrite64,
[69] = compat_sys_preadv64,		use noncompat
[70] = compat_sys_pwritev64,		use noncompat
[71] = sys_sendfile64,
[72] = compat_sys_pselect6,
[73] = compat_sys_ppoll,
[74] = sys_signalfd4,			takes sigset_t, check BE
[75] = compat_sys_vmsplice,
[76] = sys_splice,
[77] = sys_tee,
[78] = sys_readlinkat,
[79] = ilp32_sys_fstatat64,		use compat. fix glibc
[80] = ilp32_sys_fstat64,		use compat. fix glibc
[81] = sys_sync,
[82] = sys_fsync,
[83] = sys_fdatasync,
[84] = sys_sync_file_range,
[85] = sys_timerfd_create,
[86] = compat_sys_timerfd_settime,
[87] = compat_sys_timerfd_gettime,
[88] = compat_sys_utimensat,
[89] = sys_acct,
[90] = sys_capget,
[91] = sys_capset,
[92] = sys_personality,
[93] = sys_exit,
[94] = sys_exit_group,
[95] = sys_waitid,			check: need a separate wrapper
					to convert rusage but not siginfo
[96] = sys_set_tid_address,
[97] = sys_unshare,
[98] = compat_sys_futex,
[99] = compat_sys_set_robust_list,
[100] = compat_sys_get_robust_list,
[101] = compat_sys_nanosleep,
[102] = compat_sys_getitimer,
[103] = compat_sys_setitimer,
[104] = compat_sys_kexec_load,
[105] = sys_init_module,
[106] = sys_delete_module,
[107] = sys_timer_create,		check 64-bit sigevent, maybe use compat
[108] = sys_timer_gettime,		timespec
[109] = sys_timer_getoverrun,
[110] = sys_timer_settime,		timespec
[111] = sys_timer_delete,
[112] = compat_sys_clock_settime,
[113] = compat_sys_clock_gettime,
[114] = sys_clock_getres,		timespec
[115] = sys_clock_nanosleep,		timespec (?)
[116] = sys_syslog,
[117] = sys_ptrace,
[118] = sys_sched_setparam,
[119] = sys_sched_setscheduler,
[120] = sys_sched_getscheduler,
[121] = sys_sched_getparam,
[122] = compat_sys_sched_setaffinity,
[123] = compat_sys_sched_getaffinity,
[124] = sys_sched_yield,
[125] = sys_sched_get_priority_max,
[126] = sys_sched_get_priority_min,
[127] = sys_sched_rr_get_interval,	timespec
[128] = sys_restart_syscall,
[129] = sys_kill,
[130] = sys_tkill,
[131] = sys_tgkill,
[132] = sys_sigaltstack,
[133] = sys_rt_sigsuspend,		takes sigset_t check BE
[134] = sys_rt_sigaction,
[135] = sys_rt_sigprocmask,		takes sigset_t check BE
[136] = sys_rt_sigpending,		takes sigset_t check BE
[137] = sys_rt_sigtimedwait,		wrapper? 64-bit siginfo but
					32-bit sigset and timespec
[138] = sys_rt_sigqueueinfo,		this is OK (?)
[139] = sys_rt_sigreturn_wrapper,
[140] = sys_setpriority,
[141] = sys_getpriority,
[142] = sys_reboot,
[143] = sys_setregid,
[144] = sys_setgid,
[145] = sys_setreuid,
[146] = sys_setuid,
[147] = sys_setresuid,
[148] = sys_getresuid,
[149] = sys_setresgid,
[150] = sys_getresgid,
[151] = sys_setfsuid,
[152] = sys_setfsgid,
[153] = compat_sys_times,
[154] = sys_setpgid,
[155] = sys_getpgid,
[156] = sys_getsid,
[157] = sys_setsid,
[158] = sys_getgroups,
[159] = sys_setgroups,
[160] = sys_newuname,
[161] = sys_sethostname,
[162] = sys_setdomainname,
[163] = compat_sys_getrlimit,
[164] = compat_sys_setrlimit,
[165] = compat_sys_getrusage,
[166] = sys_umask,
[167] = sys_prctl,
[168] = sys_getcpu,
[169] = compat_sys_gettimeofday,
[170] = compat_sys_settimeofday,
[171] = compat_sys_adjtimex,
[172] = sys_getpid,
[173] = sys_getppid,
[174] = sys_getuid,
[175] = sys_geteuid,
[176] = sys_getgid,
[177] = sys_getegid,
[178] = sys_gettid,
[179] = compat_sys_sysinfo,
[180] = sys_mq_open,			wrong struct mq_attr
[181] = sys_mq_unlink,
[182] = sys_mq_timedsend,		wrong struct mq_attr
[183] = sys_mq_timedreceive,		wrong struct mq_attr
[184] = sys_mq_notify,
[185] = sys_mq_getsetattr,		wrong struct mq_attr
[186] = sys_msgget,
[187] = ilp32_sys_msgctl,		as is, waiting for generic fix (?)
[188] = compat_sys_msgrcv,
[189] = compat_sys_msgsnd,
[190] = sys_semget,
[191] = ilp32_sys_semctl,		as is, waiting for generic fix (?)
[192] = sys_semtimedop,			timespec_t
[193] = sys_semop,
[194] = sys_shmget,
[195] = ilp32_sys_shmctl,		as is, waiting for generic fix (?)
[196] = sys_shmat,			check (shmat01 test fails if compat)
[197] = sys_shmdt,
[198] = sys_socket,
[199] = sys_socketpair,
[200] = sys_bind,
[201] = sys_listen,
[202] = sys_accept,
[203] = sys_connect,
[204] = sys_getsockname,
[205] = sys_getpeername,
[206] = sys_sendto,
[207] = compat_sys_recvfrom,
[208] = compat_sys_setsockopt,
[209] = compat_sys_getsockopt,
[210] = sys_shutdown,
[211] = compat_sys_sendmsg,
[212] = compat_sys_recvmsg,
[213] = sys_readahead,
[214] = sys_brk,
[215] = sys_munmap,
[216] = sys_mremap,
[217] = sys_add_key,
[218] = sys_request_key,
[219] = compat_sys_keyctl,
[220] = sys_clone,
[221] = compat_sys_execve,
[222] = compat_sys_mmap2_wrapper, 	check. maybe just mmap2
[223] = sys_fadvise64_64,
[224] = sys_swapon,
[225] = sys_swapoff,
[226] = sys_mprotect,
[227] = sys_msync,
[228] = sys_mlock,
[229] = sys_munlock,
[230] = sys_mlockall,
[231] = sys_munlockall,
[232] = sys_mincore,
[233] = sys_madvise,
[234] = sys_remap_file_pages,
[235] = compat_sys_mbind,
[236] = compat_sys_get_mempolicy,
[237] = compat_sys_set_mempolicy,
[238] = compat_sys_migrate_pages,
[239] = compat_sys_move_pages,
[240] = sys_rt_tgsigqueueinfo,
[241] = sys_perf_event_open,
[242] = sys_accept4,
[243] = compat_sys_recvmmsg,
[260] = compat_sys_wait4,
[261] = sys_prlimit64,
[262] = sys_fanotify_init,
[263] = sys_fanotify_mark,
[264] = sys_name_to_handle_at,
[265] = sys_open_by_handle_at,		force O_LARGEFILE in asm-generic/unistd.h
					make tile32 to use compat
[266] = sys_clock_adjtime,		wrong timex structure
[267] = sys_syncfs,
[268] = sys_setns,
[269] = compat_sys_sendmmsg,
[270] = compat_sys_process_vm_readv,
[271] = compat_sys_process_vm_writev,
[272] = sys_kcmp,
[273] = sys_finit_module,
[274] = sys_sched_setattr,
[275] = sys_sched_getattr,
[276] = sys_renameat2,
[277] = sys_seccomp,
[278] = sys_getrandom,
[279] = sys_memfd_create,
[280] = sys_bpf,
[281] = sys_execveat,			check: wrong struct user_arg_ptr
[282] = sys_userfaultfd,
[283] = sys_membarrier,
