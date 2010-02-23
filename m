From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 23 Feb 2010 17:58:35 +0000
Subject: [PATCH 1/4] ARM: Change the mandatory barriers implementation
In-Reply-To: <20100223173334.GA13519@n2100.arm.linux.org.uk>
References: <20100223110105.11048.8143.stgit@e102109-lin.cambridge.arm.com>
	<20100223173334.GA13519@n2100.arm.linux.org.uk>
Message-ID: <1266947915.3123.150.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-02-23 at 17:33 +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 23, 2010 at 11:01:05AM +0000, Catalin Marinas wrote:
> > The mandatory barriers (mb, rmb, wmb) are used even on uniprocessor
> > systems for things like ordering Normal Non-cacheable memory accesses
> > with DMA transfer (via Device memory writes). The current implementation
> > uses dmb() for mb() and friends but this is not sufficient. The DMB only
> > ensures the ordering of accesses with regards to a single observer
> > accessing the same memory.
> 
> Erm, I also don't think your statement here is right.  DMB is defined in
> the ARM ARM to be by default a full-system, read/write memory barrier.
> It has this property:
> 
>   If the required shareability is Full system then the operation applies
>   to all observers within the system.
> ...
>   Any observer with the same required shareability domain as Pe observes
>   all members of Group A before it observes any member of Group B to the
>   extent that those group members are required to be observed, as
>   determined by the shareability and cacheability of the memory locations
>   accessed by the group members.  Where members of Group A and Group B
>   access the same memory-mapped peripheral, all members of Group A will
>   be visible at the memory-mapped peripheral before any members of Group
>   B are visible at that peripheral.
> 
> This most definitely is not "single observer" - it's all observers within
> the same "shareability domain".  That may encompass all CPUs and not
> devices and DMA agents.

Yes, that's correct but see below (the issue is the definition of
"observability").

> I'd go further - in the case of:
> 
>         write to non-cacheable memory
>         dmb();
>         write to peripheral
> 
> then, because the dmb() is a full system dmb, all observers within the
> system should see the write to non-cacheable memory before the write to
> peripheral.
> 
> Either that or the ARM ARM is unclear/wrong about what "all observers"
> means.

The ARM ARM wasn't clear to me either but the answer I got from Richard
G on this issue is that the "write to peripheral" above doesn't count as
"observed" since the "observability" definition only applies to master
accesses. In the above case, the CPU writes to a slave port of the
peripheral and the DMB has no effect on when such event would be
observed (if the device is mapped as strongly ordered, there are some
stricter requirements). You could ask RG directly, he would probably be
happy to clarify this for you.

Linux doesn't have a barrier defined to flush the write buffer, even
though the Documentation/DMA-API.txt mention that the user of coherent
DMA mappings may need to do this. Since many drivers use wmb/mb for this
situation, I find this barrier as the best place to put a DSB.

IMHO, mb() has at least the smp_mb() semantics and it can be safely used
in the IPI case you mentioned instead of the smp_* one (when implemented
as DSB).

-- 
Catalin
