From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 29 Apr 2014 12:00:28 +0200
Subject: TASK_SIZE for !MMU
Message-ID: <20140429100028.GH28564@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I grepped through the kernel (v3.15-rc1) for usages of TASK_SIZE to
check if/how it is used on !MMU ARM machines. Most open questions also
affect the other !MMU platforms, so I put the blackfin, c6x, frv and
m32r, m68k, microblaze and xtensa lists on Cc:. (Did I miss a platform
that cares for !MMU ?)

Most occurences are fine, see the list at the end of this mail. However
some are not or are unclear to me. Here is the complete list[1] apart from
the definition of TASK_SIZE for !MMU in arch/arm/include/asm/memory.h:

 - Probably this should be explict s/TASK_SIZE/CONFIG_DRAM_SIZE/. This
   is generic code however while CONFIG_DRAM_SIZE is ARM only.
        mm/nommu.c:     if (!rlen || rlen > TASK_SIZE)

 - The issue the patch by Rabin is addressing (Subject: [PATCH] ARM: fix
   string functions on !MMU), alternatively make TASK_SIZE ~0UL.
        arch/arm/include/asm/uaccess.h:#define user_addr_max() \
        arch/arm/include/asm/uaccess.h: (segment_eq(get_fs(), USER_DS) ? TASK_SIZE : ~0UL)

 - probably bearable if broken:
        drivers/misc/lkdtm.c:           if (user_addr >= TASK_SIZE) {
        lib/test_user_copy.c:   user_addr = vm_mmap(...)
        lib/test_user_copy.c:   if (user_addr >= (unsigned long)(TASK_SIZE)) {
        lib/test_user_copy.c:           pr_warn("Failed to allocate user memory\n");
        lib/test_user_copy.c:           return -ENOMEM;

 - unclear to me:
        fs/exec.c:      current->mm->task_size = TASK_SIZE;
   - depends on PERF_EVENTS
        kernel/events/core.c:   if (!addr || addr >= TASK_SIZE)
        kernel/events/core.c:   return TASK_SIZE - addr;
        kernel/events/uprobes.c:                area->vaddr = get_unmapped_area(NULL, TASK_SIZE - PAGE_SIZE,
   - depends on (PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7)):
        arch/arm/kernel/hw_breakpoint.c:        return (va >= TASK_SIZE) && ((va + len - 1) >= TASK_SIZE);
   - seems to cope with big TASK_SIZE
        fs/namespace.c:        size = TASK_SIZE - (unsigned long)data;
        fs/namespace.c:        if (size > PAGE_SIZE)
        fs/namespace.c:                size = PAGE_SIZE;
   - depends on PLAT_S5P || ARCH_EXYNOS, this looks wrong
        drivers/media/platform/s5p-mfc/s5p_mfc_common.h:#define DST_QUEUE_OFF_BASE      (TASK_SIZE / 2)
   - used for prctl(PR_SET_MM, ...)
        kernel/sys.c:   if (addr >= TASK_SIZE || addr < mmap_min_addr)

Any help to judge if these are OK is appreciated (even from Will :-)

I think it would be OK to define TASK_SIZE to 0xffffffff for !MMU.
blackfin, frv and m68k also do this. c6x does define it to 0xFFFFF000 to
leave space for error codes.

Thoughts?

Best regards
Uwe

[1] complete as in "skip everything below arch/ but arch/arm" :-)

======= These occurences are fine =======
mmu-only:
        arch/arm/include/asm/memory.h: * TASK_SIZE - the maximum size of a user space task.
        arch/arm/include/asm/memory.h:#define TASK_SIZE         (UL(CONFIG_PAGE_OFFSET) - UL(SZ_16M))
        arch/arm/include/asm/memory.h:#define TASK_UNMAPPED_BASE        ALIGN(TASK_SIZE / 3, SZ_16M)
        arch/arm/include/asm/memory.h:#define TASK_SIZE_26              (UL(1) << 26)
        arch/arm/include/asm/memory.h: * The module space lives between the addresses given by TASK_SIZE
        arch/arm/include/asm/memory.h:#if TASK_SIZE > MODULES_VADDR
        arch/arm/include/asm/pgtable-2level.h:#define USER_PTRS_PER_PGD (TASK_SIZE / PGDIR_SIZE)
        arch/arm/include/asm/pgtable-3level.h:  BUG_ON(addr >= TASK_SIZE);
        arch/arm/include/asm/pgtable.h: * Use TASK_SIZE as the ceiling argument for free_pgtables() and
        arch/arm/include/asm/pgtable.h:#define USER_PGTABLES_CEILING    TASK_SIZE
        arch/arm/include/asm/pgtable.h: if (addr < TASK_SIZE && pte_valid_user(pteval)) {
        arch/arm/include/asm/tlb.h:             tlb->range_start = TASK_SIZE;
        arch/arm/include/asm/tlb.h:             tlb->range_start = TASK_SIZE;
        arch/arm/kernel/entry-armv.S:   cmp     r4, #TASK_SIZE
        arch/arm/mm/fault.c:    if (addr < TASK_SIZE)
        arch/arm/mm/init.c:     BUILD_BUG_ON(TASK_SIZE                          > MODULES_VADDR);
        arch/arm/mm/init.c:     BUG_ON(TASK_SIZE                                > MODULES_VADDR);
        arch/arm/mm/mmap.c:#define MAX_GAP ((TASK_SIZE)/6*5)
        arch/arm/mm/mmap.c:     return PAGE_ALIGN(TASK_SIZE - gap - rnd);
        arch/arm/mm/mmap.c:     if (len > TASK_SIZE)
        arch/arm/mm/mmap.c:             if (TASK_SIZE - len >= addr &&
        arch/arm/mm/mmap.c:     info.high_limit = TASK_SIZE;
        arch/arm/mm/mmap.c:     if (len > TASK_SIZE)
        arch/arm/mm/mmap.c:             if (TASK_SIZE - len >= addr &&
        arch/arm/mm/mmap.c:             info.high_limit = TASK_SIZE;
        arch/arm/mm/mmu.c:      if (md->virtual != vectors_base() && md->virtual < TASK_SIZE) {
        arch/arm/include/asm/uaccess.h:#define USER_DS          TASK_SIZE
        mm/memory.c:                    if (pg > TASK_SIZE)
        mm/mlock.c:             mm_populate(0, TASK_SIZE);
        mm/mmap.c:      if (len > TASK_SIZE - mmap_min_addr)
        mm/mmap.c:              if (TASK_SIZE - len >= addr && addr >= mmap_min_addr &&
        mm/mmap.c:      info.high_limit = TASK_SIZE;
        mm/mmap.c:      if (len > TASK_SIZE - mmap_min_addr)
        mm/mmap.c:              if (TASK_SIZE - len >= addr && addr >= mmap_min_addr &&
        mm/mmap.c:              info.high_limit = TASK_SIZE;
        mm/mmap.c:      if (len > TASK_SIZE)
        mm/mmap.c:      if (addr > TASK_SIZE - len)
        mm/mmap.c:      if ((start & ~PAGE_MASK) || start > TASK_SIZE || len > TASK_SIZE
        mm/mremap.c:    if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)

enabled by CONFIG_NUMA, unavailable on ARM:
        mm/mempolicy.c:         pvma.vm_end = TASK_SIZE;        /* policy covers entire

Only used in fs/exec.c in #ifdef CONFIG_MMU:
        arch/arm/include/asm/processor.h:#define STACK_TOP_MAX  TASK_SIZE

Used in:
 - fs/binfmt_aout.c (HAVE_AOUT=n on ARM)
 - fs/binfmt_elf.c (depends on MMU)
 - fs/binfmt_som.c (BINFMT_SOM depends on PARISC && HPUX)
 - fs/exec.c (#ifdef CONFIG_MMU)
        arch/arm/include/asm/processor.h:#define STACK_TOP       ((current->personality & ADDR_LIMIT_32BIT) ? \
        arch/arm/include/asm/processor.h:                        TASK_SIZE : TASK_SIZE_26)

Only used in fs/{,compat_}binfmt_elf.c, depends on MMU
        arch/arm/include/asm/elf.h:#define ELF_ET_DYN_BASE      (2 * TASK_SIZE / 3)

fs/binfmt_aout.c (HAVE_AOUT=n on ARM)
        fs/binfmt_aout.c:#define BAD_ADDR(x)    ((unsigned long)(x) >= TASK_SIZE)
fs/binfmt_elf.c (depends on MMU)
        fs/binfmt_elf.c:#define BAD_ADDR(x) ((unsigned long)(x) >= TASK_SIZE)
        fs/binfmt_elf.c:                            eppnt->p_memsz > TASK_SIZE ||
        fs/binfmt_elf.c:                            TASK_SIZE - eppnt->p_memsz < k) {
        fs/binfmt_elf.c:                    elf_ppnt->p_memsz > TASK_SIZE ||
        fs/binfmt_elf.c:                    TASK_SIZE - elf_ppnt->p_memsz < k) {

HUGETLBFS depends on !ARM || ARM_LPAE || BROKEN, LPAE depends on MMU
        fs/hugetlbfs/inode.c:   if (len > TASK_SIZE)
        fs/hugetlbfs/inode.c:           if (TASK_SIZE - len >= addr &&
        fs/hugetlbfs/inode.c:   info.high_limit = TASK_SIZE;

USER_DS is defined in arch/arm/include/asm/uaccess.h:
        include/asm-generic/uaccess.h:#ifndef USER_DS
        include/asm-generic/uaccess.h:#define USER_DS           MAKE_MM_SEG(TASK_SIZE -
        include/asm-generic/uaccess.h:#endif

Only used in fs/proc/task_mmu.c, depends on CONFIG_MMU
        include/linux/sched.h:#define TASK_SIZE_OF(tsk) TASK_SIZE

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
