From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 2 Jun 2014 10:51:50 +0200
Subject: TASK_SIZE for !MMU
In-Reply-To: <20140429100028.GH28564@pengutronix.de>
References: <20140429100028.GH28564@pengutronix.de>
Message-ID: <20140602085150.GA31147@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

[expand Cc: a bit]

On Tue, Apr 29, 2014 at 12:00:28PM +0200, Uwe Kleine-K?nig wrote:
> I grepped through the kernel (v3.15-rc1) for usages of TASK_SIZE to
> check if/how it is used on !MMU ARM machines. Most open questions also
> affect the other !MMU platforms, so I put the blackfin, c6x, frv and
> m32r, m68k, microblaze and xtensa lists on Cc:. (Did I miss a platform
> that cares for !MMU ?)
> 
> Most occurences are fine, see the list at the end of this mail. However
> some are not or are unclear to me. Here is the complete list[1] apart from
> the definition of TASK_SIZE for !MMU in arch/arm/include/asm/memory.h:
> 
>  - Probably this should be explict s/TASK_SIZE/CONFIG_DRAM_SIZE/. This
>    is generic code however while CONFIG_DRAM_SIZE is ARM only.
>         mm/nommu.c:     if (!rlen || rlen > TASK_SIZE)
> 
>  - The issue the patch by Rabin is addressing (Subject: [PATCH] ARM: fix
>    string functions on !MMU), alternatively make TASK_SIZE ~0UL.
>         arch/arm/include/asm/uaccess.h:#define user_addr_max() \
>         arch/arm/include/asm/uaccess.h: (segment_eq(get_fs(), USER_DS) ? TASK_SIZE : ~0UL)
[reference: http://www.spinics.net/lists/arm-kernel/msg324112.html ]
 
>  - probably bearable if broken:
>         drivers/misc/lkdtm.c:           if (user_addr >= TASK_SIZE) {
>         lib/test_user_copy.c:   user_addr = vm_mmap(...)
>         lib/test_user_copy.c:   if (user_addr >= (unsigned long)(TASK_SIZE)) {
>         lib/test_user_copy.c:           pr_warn("Failed to allocate user memory\n");
>         lib/test_user_copy.c:           return -ENOMEM;
> 
>  - unclear to me:
>         fs/exec.c:      current->mm->task_size = TASK_SIZE;
>    - depends on PERF_EVENTS
>         kernel/events/core.c:   if (!addr || addr >= TASK_SIZE)
>         kernel/events/core.c:   return TASK_SIZE - addr;
>         kernel/events/uprobes.c:                area->vaddr = get_unmapped_area(NULL, TASK_SIZE - PAGE_SIZE,
>    - depends on (PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7)):
>         arch/arm/kernel/hw_breakpoint.c:        return (va >= TASK_SIZE) && ((va + len - 1) >= TASK_SIZE);
>    - seems to cope with big TASK_SIZE
>         fs/namespace.c:        size = TASK_SIZE - (unsigned long)data;
>         fs/namespace.c:        if (size > PAGE_SIZE)
>         fs/namespace.c:                size = PAGE_SIZE;
>    - depends on PLAT_S5P || ARCH_EXYNOS, this looks wrong
>         drivers/media/platform/s5p-mfc/s5p_mfc_common.h:#define DST_QUEUE_OFF_BASE      (TASK_SIZE / 2)
>    - used for prctl(PR_SET_MM, ...)
>         kernel/sys.c:   if (addr >= TASK_SIZE || addr < mmap_min_addr)
> 
> Any help to judge if these are OK is appreciated (even from Will :-)
> 
> I think it would be OK to define TASK_SIZE to 0xffffffff for !MMU.
> blackfin, frv and m68k also do this. c6x does define it to 0xFFFFF000 to
> leave space for error codes.
> 
> Thoughts?
The problem is that current linus/master (and also next) doesn't boot on
my ARM-nommu machine because the user string functions (strnlen_user,
strncpy_from_user et al.) refuse to work on strings above TASK_SIZE
which in my case also includes the XIP kernel image.

Maybe someone of the mm people can bring light into the unclear points
above and the question what TASK_SIZE is supposed to be on no-MMU
machines?

Best regards
Uwe

> [1] complete as in "skip everything below arch/ but arch/arm" :-)
> 
[removed the list, if you're interested, it's available at
http://mid.gmane.org/20140429100028.GH28564 at pengutronix.de]

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
