From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Nov 2015 16:34:22 +0100
Subject: [PATCH v6 14/19] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <3754277.KmO9Nk3XLD@wuerfel>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <1447795019-30176-15-git-send-email-ynorov@caviumnetworks.com>
 <3754277.KmO9Nk3XLD@wuerfel>
Message-ID: <2133692.Tueq9xZUPQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 November 2015 22:57:52 Arnd Bergmann wrote:
> On Wednesday 18 November 2015 00:16:54 Yury Norov wrote:
> > From: Andrew Pinski <apinski@cavium.com>
> > 
> > Add a separate syscall-table for ILP32, which dispatches either to native
> > LP64 system call implementation or to compat-syscalls, as appropriate.
> 
> I like it much better than the previous version, thanks for the rework!

Hi Yuri,

you must have missed my reply below. Are you still working on ilp32
or did you drop this thread because you got distracted with something
else?

	Arnd

> However, it seems that you accidentally have a lot more redirects
> than you should have:
> 
> > +/* Using non-compat syscalls where necessary */
> > +#define compat_sys_fadvise64_64        sys_fadvise64_64
> > +#define compat_sys_fallocate           sys_fallocate
> > +#define compat_sys_ftruncate64         sys_ftruncate
> > +#define compat_sys_pread64             sys_pread64
> > +#define compat_sys_pwrite64            sys_pwrite64
> > +#define compat_sys_readahead           sys_readahead
> 
> Makes sense. These of course all require the respective changes
> in glibc as discussed in the thread regarding loff_t handling.
> 
> > +#define compat_sys_rt_sigaction        sys_rt_sigaction
> > +#define compat_sys_shmat               sys_shmat
> 
> What's special about compat_sys_shmat?
> 
> > +#define compat_sys_sync_file_range     sys_sync_file_range
> > +#define compat_sys_truncate64          sys_truncate
> > +#define compat_sys_sigaltstack         sys_sigaltstack
> > +
> > +#define compat_sys_io_getevents        sys_io_getevents
> 
> io_getevents seems wrong, you are passing the wrong timespec and
> aio_context_t here.
> 
> > +#define compat_sys_lookup_dcookie      sys_lookup_dcookie
> > +#define compat_sys_epoll_pwait         sys_epoll_pwait
> 
> epoll_pwait takes sigset_t, which I'd assume is different between
> ilp32 and lp64, so this is probably wrong too, at least on big-endian.
> 
> > +#define compat_sys_fcntl64             compat_sys_fcntl
> 
> This uses compat_off_t, not compat_loff_t, and needs to be changed.
> 
> > +#define compat_sys_signalfd4           sys_signalfd4
> > +#define compat_sys_rt_sigsuspend       sys_rt_sigsuspend
> > +#define compat_sys_rt_sigprocmask      sys_rt_sigprocmask
> > +#define compat_sys_rt_sigpending       sys_rt_sigpending
> 
> sigset_t again, all four of these.
> 
> > +#define compat_sys_rt_sigqueueinfo     sys_rt_sigqueueinfo
> 
> this looks ok though, as you have the 64-bit siginfo
> 
> > +#define compat_sys_semtimedop          sys_semtimedop
> 
> timespec again
> 
> > +#define compat_sys_rt_tgsigqueueinfo   sys_rt_tgsigqueueinfo
> > +
> > +#define compat_sys_timer_create        sys_timer_create
> > +#define compat_sys_timer_gettime       sys_timer_gettime
> > +#define compat_sys_timer_settime       sys_timer_settime
> 
> timespec again for gettime/settime. create seems fine if you require
> the use of the 64-bit sigevent (why?)
> 
> > +#define compat_sys_rt_sigtimedwait     sys_rt_sigtimedwait
> 
> This one probably needs a custom wrapper as you have the 64-bit
> siginfo, but the 32-bit sigset and timespec.
> 
> > +#define compat_sys_mq_open             sys_mq_open
> > +#define compat_sys_mq_timedsend        sys_mq_timedsend
> > +#define compat_sys_mq_timedreceive     sys_mq_timedreceive
> > +#define compat_sys_mq_getsetattr       sys_mq_getsetattr
> > +#define compat_sys_mq_open             sys_mq_open
> 
> You have compat_sys_mq_open twice, and they all look wrong because
> you get the wrong struct mq_attr.
> 
> > +#define compat_sys_open_by_handle_at   sys_open_by_handle_at
> 
> The only difference here is the forced O_LARGEFILE, but that
> is set by glibc anyway, right?
> 
> > +#define compat_sys_clock_adjtime       sys_clock_adjtime
> 
> wrong timex structure
> 
> > +#define compat_sys_openat              sys_openat
> 
> same as open_by_handle_at
> 
> > +#define compat_sys_getdents64          sys_getdents64
> 
> glibc uses linux_dirent64 for 32-bit architectures, so this looks wrong
> 
> > +#define compat_sys_waitid              sys_waitid
> 
> This will probably need a separate wrapper to convert rusage but not siginfo
> 
> > +#define compat_sys_timer_settime       sys_timer_settime
> > +#define compat_sys_sched_rr_get_interval sys_sched_rr_get_interval
> 
> timespec again
> 
> > +#define compat_sys_execveat            sys_execveat
> 
> This probably gives you the wrong struct user_arg_ptr
> 
> > +#define compat_sys_mq_notify           sys_mq_notify
> 
> ok.
> 
> > +#define compat_sys_clock_nanosleep     sys_clock_nanosleep
> > +#define compat_sys_clock_getres        sys_clock_getres
> 
> timespec
> 
> > +#define sys_lseek                      sys_llseek
> 
> This seems pointless, as there is no sys_lseek
> 
> > +asmlinkage long compat_sys_mmap2_wrapper(void);
> > +#define sys_mmap2                      compat_sys_mmap2_wrapper
> > +
> > +asmlinkage long compat_sys_fstatfs64_wrapper(void);
> > +#define compat_sys_fstatfs64    compat_sys_fstatfs64_wrapper
> > +asmlinkage long compat_sys_statfs64_wrapper(void);
> > +#define compat_sys_statfs64             compat_sys_statfs64_wrapper
> 
> What are the wrappers for again? Maybe add a comment here.
> 
> > +#define compat_sys_preadv              compat_sys_preadv64
> > +#define compat_sys_pwritev	       compat_sys_pwritev64
> 
> wrong iovec.
> 
> 	Arnd
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
