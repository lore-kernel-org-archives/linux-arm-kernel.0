From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Dec 2014 21:23:14 +0100
Subject: Data Synchronization Barrier (DSB)
In-Reply-To: <547F384A.1030809@free.fr>
References: <547F384A.1030809@free.fr>
Message-ID: <3745883.NFX517mvTa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 December 2014 17:20:26 Mason wrote:
> 
> In fact, on ARM platforms, __raw_readl does not insert any memory
> barrier (or compiler barrier for that matter, the only constraints
> are those imposed by the "volatile" keyword)
> 
> static inline u32 __raw_readl(const volatile void __iomem *addr)
> {
>         u32 val;
>         asm volatile("ldr %1, %0"
>                      : "+Qo" (*(volatile u32 __force *)addr),
>                        "=r" (val));
>         return val;
> }
> 
> If I understand correctly, accessing memory-mapped registers without
> using memory barriers can lead to subtle bugs, from memory reordering?
> (This part is really unclear for me.)

The "asm volatile" makes the compiler emit the accesses in the order
that is given in source code, and we rely on the CPU to send them
to the bus in the same order, which on ARM is enforced through the
page table attributes that ioremap sets.

The barriers are needed only to ensure ordering between MMIO accesses
and memory accesses, in particular memory that is seen by a DMA
bus master device that is controlled using this MMIO.

The classic example for this is writing to a DMA buffer from the
CPU and then telling a device using writel to fetch the data.
Without the barrier, that data may still be in a CPU buffer
by the time that a device reads it.

> Should I alias my primitives to ioread32 and iowrite32?
> 
> NOTE: iowrite32 calls outer_sync() which seems to have somewhat high
> of an overhead. If I'm writing to 4 consecutive MM registers, do I
> need to sync after each write?

I think readl_relaxed() is enough for you in this case, as long as
there are no DMAs.

	Arnd
