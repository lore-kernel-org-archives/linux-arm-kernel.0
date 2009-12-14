From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 14 Dec 2009 12:38:33 -0500 (EST)
Subject: [PATCH 3/5] arm: use the spinlocked, generic atomic64 support
In-Reply-To: <1260799481-29951-4-git-send-email-jamie.iles@picochip.com>
References: <1260799481-29951-1-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-2-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-3-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-4-git-send-email-jamie.iles@picochip.com>
Message-ID: <alpine.LFD.2.00.0912141156200.23173@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Dec 2009, Jamie Iles wrote:

> perf events require that we can support atomic64's. There is a generic,
> spinlocked version that we can use until we have proper hardware
> support.

Can't a variant of include/linux/cnt32_to_63.h be used here?

typedef struct {
	atomic_t low;
	u32 high;
} atomic64_t;

static inline void atomic64_set(atomic64_t *ptr, u64 new_val)
{
	u32 low = new_val;
	u32 high = new_val >> 32;
	BUG_ON(high & 0x80000000);
	atomic_set(&ptr->low, low);
	ptr->high = (high & 0x7fffffff) | (low & 0x80000000);
}

static inline u64 atomic64_read(atomic64_t *ptr)
{
	u32 high, low;
	high = ptr->high;
	smp_rmb();
	low = atomic_read(&ptr->low);
	if (unlikely((s32)(high ^ low) < 0))
		ptr->high = high = (high ^ 0x80000000) + (high >> 31);
	return ((u64)(high & 0x7fffffff) << 32) | low;
}

static inline u64 atomic64_inc_return(atomic64_t *ptr)
{
	atomic_inc(&ptr->low);
	return atomic64_read(ptr);
}

The atomic64_add_return() could be implemented the same way, however the 
added value would have to be smaller than 31 bits for the algorythm to 
work.


Nicolas
