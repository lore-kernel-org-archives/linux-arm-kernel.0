From: ananaza@iki.fi (Antti P Miettinen)
Date: Mon, 18 Jun 2012 20:41:46 +0300
Subject: [PATCH 6/6] ARM: l2x0: Optimise the range based operations
References: <1283846243-11600-1-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-2-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-3-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-4-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-5-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-6-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-7-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <874nq8y0th.fsf@amiettinen-lnx.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> For the big buffers which are in excess of cache size, the maintaince
> operations by PA are very slow. For such buffers the maintainace
> operations can be speeded up by using the WAY based method.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm/mm/cache-l2x0.c |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
[..]
> @@ -208,6 +225,11 @@ static void l2x0_flush_range(unsigned long start, unsigned long end)
>  	void __iomem *base = l2x0_base;
>  	unsigned long flags;
>  
> +	if ((end - start) >= l2x0_size) {
> +		l2x0_flush_all();
> +		return;
> +	}
> +
>  	spin_lock_irqsave(&l2x0_lock, flags);
>  	start &= ~(CACHE_LINE_SIZE - 1);
>  	while (start < end) {

I wonder if this is safe. Are the L2 controller clean&invalidate
operations atomic in relation to CPU stores? The PL310 TRM says that
clean and invalidate by way is a background operation. About background
operations the TRM says that the targeted ways are locked for
allocations but read or write hits are permitted to access the way. So
is the following sequence possible?

1. L2 controller cleans a way
2. A CPU writes to the same way
3. L2 controller invalidates the way

This would result in loss of data. This would mean that the optimization
is not safe if several cores are active.

--
Antti P Miettinen
http://www.iki.fi/~ananaza/
