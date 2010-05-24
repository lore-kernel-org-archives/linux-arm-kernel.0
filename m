From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 May 2010 14:06:50 +0100
Subject: [PATCH 0/4] Patches for -next
In-Reply-To: <20100524120831.GC21117@n2100.arm.linux.org.uk>
References: <20100520142715.22202.33516.stgit@e102109-lin.cambridge.arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5667016@dbde02.ent.ti.com>
	<1274435541.11965.18.camel@e102109-lin.cambridge.arm.com>
	<20100521190456.GB11042@n2100.arm.linux.org.uk>
	<1274700664.4720.7.camel@e102109-lin.cambridge.arm.com>
	<20100524120831.GC21117@n2100.arm.linux.org.uk>
Message-ID: <1274706410.4720.34.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-05-24 at 13:08 +0100, Russell King - ARM Linux wrote:
> On Mon, May 24, 2010 at 12:31:04PM +0100, Catalin Marinas wrote:
> > So, are you ok for me to push these patches to -next?
> 
> I don't think these patches are quite ready for -next just yet.  Apart
> from my comment on patch 1, I think patch 4 is buggy in three other
> ways:
> 
> 1. VIVT cached CPUs end up with L_PTE_EXEC clear on their mappings
>    with this patch.  Luckily for us, nothing tests for this (there
>    used to be a pte_exec() helper for testing this, but I removed it
>    as there were no users in the kernel) - but even so, I think it
>    should be documented that this is the case.

The L_PTE_EXEC is only cleared in set_pte_at() if SMP. We won't have any
VIVT SMP system. I could add a comment for this.

> 2. L_PTE_EXEC is also forced-clear on non-page cache pages by this
>    patch, even if executable permission was requested.  I'm guessing
>    this will be bad for tasks which generate code on the fly.

Attributes changing via sys_mprotect() won't be handled, so this would
be a problem.

> 3. Kernel mappings are also created with set_pte_at(), and so module
>    mappings will have L_PTE_EXEC cleared, resulting in kernel modules
>    being non-executable - which is rather bad.

Yes, this was already pointed at by Santosh and fixed in the latest
version of the patch (it checks for addr < TASK_SIZE).

> Not sure what the right fix for this is at the moment - and if we're
> going to make set_pte_at() more complicated, it should be moved out
> of line.

The only way I can think of is to do the cache flushing in set_pte_at().
It would have a similar approach with clearing the exec bit, flushing
the cache and then setting it (since we may not always have a kernel
mapping). The exec/no-exec would only be done for SMP.

If we go this route, for UP and all the other cache types, should we
move the lazy cache flushing out of update_mmu_cache() as well?

A side-effect of such change is that mprotect(exec) may trigger a cache
flush, which I think it's fine.

Thanks.

-- 
Catalin
