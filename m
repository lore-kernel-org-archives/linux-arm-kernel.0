From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Dec 2015 11:26:14 +0100
Subject: [PATCH v6 14/19] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <20151201004009.GB23254@yury-N73SV>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <3463212.HtU7UeIULQ@wuerfel> <20151201004009.GB23254@yury-N73SV>
Message-ID: <3538503.5d5Wa1mDgB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 December 2015 03:40:09 Yury Norov wrote:
> On Mon, Nov 30, 2015 at 10:49:43PM +0100, Arnd Bergmann wrote:
> > 
> > Could we try to get consensus on how the syscall ABI should look
> > before you start adapting glibc to another intermediate version?
> > I think that would also save you duplicate work, as it's always
> > possible that we misunderstand each other in the review. Also,
> > when someone asks you questions during a review, please reply to
> > those questions so we can get a common understanding of the facts
> > and document that in the mail archives.
> > 
> >       Arnd
> 
> This is full syscall table for ILP32, how it looks right now.
> I collected all comments here and do rework according it.
> Any comments?

It might be easier to start the other way round: rather than
annotating the things that might be wrong, remove all the overrides
and add back only the 64-bit syscalls that we want instead of the
32-bit variants when you find that they are absolutely needed.

> [0] = compat_sys_io_setup,                      
> [1] = sys_io_destroy,
> [2] = compat_sys_io_submit,
> [3] = sys_io_cancel,
> [4] = sys_io_getevents,                 wrong timespec_t and aio_context_t here
> [5] = sys_setxattr,
> [6] = sys_lsetxattr,
> [7] = sys_fsetxattr,
> [8] = sys_getxattr,
> [9] = sys_lgetxattr,
> [10] = sys_fgetxattr,
> [11] = sys_listxattr,
> [12] = sys_llistxattr,
> [13] = sys_flistxattr,
> [14] = sys_removexattr,
> [15] = sys_lremovexattr,
> [16] = sys_fremovexattr,
> [17] = sys_getcwd,
> [18] = sys_lookup_dcookie,
> [19] = sys_eventfd2,
> [20] = sys_epoll_create1,
> [21] = sys_epoll_ctl,
> [22] = sys_epoll_pwait,                 way round: takes sigset_t check BE
> [23] = sys_dup,
> [24] = sys_dup3,
> [25] = compat_sys_fcntl,                uses compat_off_t, not compat_loff_t
> [26] = sys_inotify_init1,
> [27] = sys_inotify_add_watch,

I was looking for your latest arch/arm64/kernel/sys_ilp32.c version. I'm
not that interested in the ones that are just using the normal compat API,
just the ones that you still think we have to override, and why that
override is required.

	Arnd
