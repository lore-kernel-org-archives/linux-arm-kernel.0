From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Dec 2009 19:36:36 -0000
Subject: [PATCH 3/5] arm: use the spinlocked, generic atomic64 support
In-Reply-To: <alpine.LFD.2.00.0912141156200.23173@xanadu.home>
References: <1260799481-29951-1-git-send-email-jamie.iles@picochip.com>	<1260799481-29951-2-git-send-email-jamie.iles@picochip.com>	<1260799481-29951-3-git-send-email-jamie.iles@picochip.com>	<1260799481-29951-4-git-send-email-jamie.iles@picochip.com>
	<alpine.LFD.2.00.0912141156200.23173@xanadu.home>
Message-ID: <001301ca7cf4$c04481a0$40cd84e0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

*Nicolas Pitre wrote:

> Can't a variant of include/linux/cnt32_to_63.h be used here?> 
> typedef struct {
> 	atomic_t low;
> 	u32 high;
> } atomic64_t;
> 
> static inline void atomic64_set(atomic64_t *ptr, u64 new_val)
> {
> 	u32 low = new_val;
> 	u32 high = new_val >> 32;
> 	BUG_ON(high & 0x80000000);
> 	atomic_set(&ptr->low, low);
> 	ptr->high = (high & 0x7fffffff) | (low & 0x80000000);
> }

How do you ensure that this is atomic? To me it looks like one CPU
could write the lower 32-bits and another could write the upper 32,
leaving the memory location in an inconsistent state.

> static inline u64 atomic64_read(atomic64_t *ptr)
> {
> 	u32 high, low;
> 	high = ptr->high;
> 	smp_rmb();
> 	low = atomic_read(&ptr->low);
> 	if (unlikely((s32)(high ^ low) < 0))
> 		ptr->high = high = (high ^ 0x80000000) + (high >> 31);
> 	return ((u64)(high & 0x7fffffff) << 32) | low;
> }
> 
> static inline u64 atomic64_inc_return(atomic64_t *ptr)
> {
> 	atomic_inc(&ptr->low);
> 	return atomic64_read(ptr);
> }
> 
> The atomic64_add_return() could be implemented the same way, however the
> added value would have to be smaller than 31 bits for the algorythm to
> work.

I posted a patch to this list on Friday which provides 64-bit atomic
operations for ARM using exclusive loads and stores:

http://lists.infradead.org/pipermail/linux-arm-kernel/2009-December/005934.html

Once this patch has been successfully reviewed, these routines should be used
instead. For now it makes sense to use the generic spinlocks version as a
placeholder.

Will
