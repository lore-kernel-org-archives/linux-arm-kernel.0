From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 20 Feb 2017 10:49:47 +0000
Subject: [PATCH] arm64: traps: Mark __le16, __le32, __user variables
 properly
In-Reply-To: <148758047729.2988.16966413648865610904@sboyd-linaro>
References: <20170217165112.17512-1-stephen.boyd@linaro.org>
 <20170219015808.2vc2kvpde7nlrey4@macbook.local>
 <148758047729.2988.16966413648865610904@sboyd-linaro>
Message-ID: <20170220104947.GE9003@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2017 at 12:47:57AM -0800, Stephen Boyd wrote:
> Quoting Luc Van Oostenryck (2017-02-18 17:58:09)
> > On Fri, Feb 17, 2017 at 08:51:12AM -0800, Stephen Boyd wrote:
> >  
> > > arch/arm64/kernel/traps.c:567:10: warning: Initializer entry defined twice
> > > arch/arm64/kernel/traps.c:568:10:   also defined here
> > This one I find strange. Can you tell which are those two entries?
> 
> This is:
> 
>  static const char *esr_class_str[] = {
>          [0 ... ESR_ELx_EC_MAX]          = "UNRECOGNIZED EC",
>          [ESR_ELx_EC_UNKNOWN]            = "Unknown/Uncategorized",
> 
> where we initialize the entire array to an "unknown" value once, and
> then fill in the known values after that. This isn't a very common
> pattern, but it is used from time to time to avoid having lots of lines
> to do the same thing.

FWIW, it's a fairly common trick for syscall tables, which is where I
copied it from for the above. Certainly it's not that common elsewhere.

[mark at leverpostej:~/src/linux]% tail -n 11  arch/arm64/kernel/sys.c
#undef __SYSCALL
#define __SYSCALL(nr, sym)      [nr] = sym,

/*
 * The sys_call_table array must be 4K aligned to be accessible from
 * kernel/entry.S.
 */
void * const sys_call_table[__NR_syscalls] __aligned(4096) = {
        [0 ... __NR_syscalls - 1] = sys_ni_syscall,
#include <asm/unistd.h>
};

[mark at leverpostej:~/src/linux]% git grep '\[0 \.\.\. ' | grep sys
arch/arc/kernel/sys.c:  [0 ... NR_syscalls-1] = sys_ni_syscall,
arch/arm64/kernel/sys.c:        [0 ... __NR_syscalls - 1] = sys_ni_syscall,
arch/arm64/kernel/sys32.c:      [0 ... __NR_compat_syscalls - 1] = sys_ni_syscall,
arch/c6x/kernel/sys_c6x.c:      [0 ... __NR_syscalls-1] = sys_ni_syscall,
arch/metag/kernel/sys_metag.c:  [0 ... __NR_syscalls-1] = sys_ni_syscall,
arch/tile/kernel/compat.c:      [0 ... __NR_syscalls-1] = sys_ni_syscall,
arch/tile/kernel/sys.c: [0 ... __NR_syscalls-1] = sys_ni_syscall,
arch/unicore32/kernel/sys.c:    [0 ... __NR_syscalls-1] = sys_ni_syscall,
arch/x86/entry/syscall_32.c:    [0 ... __NR_syscall_compat_max] = &sys_ni_syscall,
arch/x86/entry/syscall_64.c:    [0 ... __NR_syscall_max] = &sys_ni_syscall,
arch/x86/um/sys_call_table_32.c:        [0 ... __NR_syscall_max] = &sys_ni_syscall,
arch/x86/um/sys_call_table_64.c:        [0 ... __NR_syscall_max] = &sys_ni_syscall,
arch/xtensa/kernel/syscall.c:   [0 ... __NR_syscall_count - 1] = (syscall_t)&sys_ni_syscall,

It would be nice to make sparse aware of this somehow, even if it
requires some annotation.

Thanks,
Mark.
