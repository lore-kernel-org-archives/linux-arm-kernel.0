From: jreiser@bitwagon.com (John Reiser)
Date: Sun, 09 Jun 2013 17:05:24 -0700
Subject: ARM cacheflush syscall with range that spans multiple vma
Message-ID: <51B51844.9050108@bitwagon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Why does the ARM cacheflush syscall stop after the lowest vma
which intersects the user-requested range?  The range could
span more than one vma having contiguous addresses, such as
two files MAP_SHARED into adjacent pages; or even a region
that contains holes (pages not present.)

The code path in arch/arm/kernel/traps.c is:

arm_syscall():
        case NR(cacheflush):
                return do_cache_op(regs->ARM_r0, regs->ARM_r1, regs->ARM_r2);

do_cache_op() contains no loop for more than one vma:
        vma = find_vma(mm, start);

-- 
