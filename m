From: mpeg.blue@free.fr (Mason)
Date: Wed, 03 Dec 2014 17:20:26 +0100
Subject: Data Synchronization Barrier (DSB)
Message-ID: <547F384A.1030809@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

I have several naive questions about memory barriers.
I've glanced at memory-barriers.txt
https://www.kernel.org/doc/Documentation/memory-barriers.txt

QUESTION 1
Are memory ordering issues and caching orthogonal?
In other words, are memory barriers needed even when accessing
non-cached memory (actual memory or device registers)?

QUESTION 1.1
These days, CPUs feature multiple cores, but they often share
the last level of cache. (Implied assumption: the cores are more
tightly-coupled than yesterday's SMP systems) Do multi-core
systems change the need for memory barriers? (Compared to a
unicore system.)


QUESTION 2

On my platform, the MMIO primitives are aliased to __raw_readl
and __raw_writel.

#define IO_ADDRESS(x)  (0xf0000000 +(x))
#define gbus_read_reg32(r)      __raw_readl((volatile void __iomem *)IO_ADDRESS(r))
#define gbus_write_reg32(r, v)  __raw_writel(v, (volatile void __iomem *)IO_ADDRESS(r))

Arnd Bergmann has already pointed out:
"don't use __raw_readl in driver code, use readl or readl_relaxed"

In fact, on ARM platforms, __raw_readl does not insert any memory
barrier (or compiler barrier for that matter, the only constraints
are those imposed by the "volatile" keyword)

static inline u32 __raw_readl(const volatile void __iomem *addr)
{
	u32 val;
	asm volatile("ldr %1, %0"
		     : "+Qo" (*(volatile u32 __force *)addr),
		       "=r" (val));
	return val;
}

If I understand correctly, accessing memory-mapped registers without
using memory barriers can lead to subtle bugs, from memory reordering?
(This part is really unclear for me.)

Should I alias my primitives to ioread32 and iowrite32?

NOTE: iowrite32 calls outer_sync() which seems to have somewhat high
of an overhead. If I'm writing to 4 consecutive MM registers, do I
need to sync after each write?

Regards.



Notes for my own reference...

Comment from barrier.h

/*
  * Force strict CPU ordering. And yes, this is required on UP too when we're
  * talking to devices.
  *
  * Fall back to compiler barriers if nothing better is provided.
  */

/* IO barriers */
#ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE /* y */
#include <asm/barrier.h>
#define __iormb()		rmb()
#define __iowmb()		wmb()

#elif defined(CONFIG_ARM_DMA_MEM_BUFFERABLE) || defined(CONFIG_SMP)
#define mb()		do { dsb(); outer_sync(); } while (0)
#define rmb()		dsb()
#define wmb()		do { dsb(st); outer_sync(); } while (0)

#if __LINUX_ARM_ARCH__ >= 7
#define dsb(option) __asm__ __volatile__ ("dsb " #option : : : "memory")

#ifdef CONFIG_OUTER_CACHE_SYNC
static inline void outer_sync(void)
{
	if (outer_cache.sync)
		outer_cache.sync();
}

static void l2x0_cache_sync(void)
{
	unsigned long flags;

	raw_spin_lock_irqsave(&l2x0_lock, flags);
	cache_sync();
	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
}

static inline void cache_sync(void)
{
	void __iomem *base = l2x0_base;

	writel_relaxed(0, base + sync_reg_offset);
	cache_wait(base + L2X0_CACHE_SYNC, 1);
}
