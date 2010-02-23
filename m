From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Feb 2010 17:33:34 +0000
Subject: [PATCH 1/4] ARM: Change the mandatory barriers implementation
In-Reply-To: <20100223110105.11048.8143.stgit@e102109-lin.cambridge.arm.com>
References: <20100223110105.11048.8143.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100223173334.GA13519@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2010 at 11:01:05AM +0000, Catalin Marinas wrote:
> The mandatory barriers (mb, rmb, wmb) are used even on uniprocessor
> systems for things like ordering Normal Non-cacheable memory accesses
> with DMA transfer (via Device memory writes). The current implementation
> uses dmb() for mb() and friends but this is not sufficient. The DMB only
> ensures the ordering of accesses with regards to a single observer
> accessing the same memory.

Erm, I also don't think your statement here is right.  DMB is defined in
the ARM ARM to be by default a full-system, read/write memory barrier.
It has this property:

  If the required shareability is Full system then the operation applies
  to all observers within the system.
...
  Any observer with the same required shareability domain as Pe observes
  all members of Group A before it observes any member of Group B to the
  extent that those group members are required to be observed, as
  determined by the shareability and cacheability of the memory locations
  accessed by the group members.  Where members of Group A and Group B
  access the same memory-mapped peripheral, all members of Group A will
  be visible at the memory-mapped peripheral before any members of Group
  B are visible at that peripheral.

This most definitely is not "single observer" - it's all observers within
the same "shareability domain".  That may encompass all CPUs and not
devices and DMA agents.

I'd go further - in the case of:

	write to non-cacheable memory
	dmb();
	write to peripheral

then, because the dmb() is a full system dmb, all observers within the
system should see the write to non-cacheable memory before the write to
peripheral.

Either that or the ARM ARM is unclear/wrong about what "all observers"
means.
