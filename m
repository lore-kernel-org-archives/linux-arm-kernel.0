From: chris@sageembedded.com (Chris Cole)
Date: Tue, 06 Nov 2018 16:12:15 -0800
Subject: [PATCH] mm: improve/fix ARM v7_dma_inv_range() unaligned
 address handling
In-Reply-To: <20181106101437.GY30658@n2100.armlinux.org.uk>
References: <1541444814.537.8.camel@sageembedded.com>
 <20181106101437.GY30658@n2100.armlinux.org.uk>
Message-ID: <1541549535.537.32.camel@sageembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-11-06 at 10:14 +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 05, 2018 at 11:06:54AM -0800, Chris Cole wrote:
> > This patch addresses possible memory corruption when
> > v7_dma_inv_range(start_address, end_address) address parameters are not
> > aligned to whole cache lines. This function issues "invalidate" cache
> > management operations to all cache lines from start_address (inclusive)
> > to end_address (exclusive). When start_address and/or end_address are
> > not aligned, the start and/or end cache lines are first issued "clean &
> > invalidate" operation. The assumption is this is done to ensure that any
> > dirty data addresses outside the address range (but part of the first or
> > last cache lines) are cleaned/flushed so that data is not lost, which
> > could happen if just an invalidate is issued.
> > 
> > The problem is that these first/last partial cache lines are issued
> > "clean & invalidate" and then "invalidate". This second "invalidate" is
> > not required and worse can cause "lost" writes to addresses outside the
> > address range but part of the cache line. If another component writes to
> > its part of the cache line between the "clean & invalidate" and
> > "invalidate" operations, the write can get lost. This fix is to remove
> > the extra "invalidate" operation when unaligned addressed are used.
> > 
> > A kernel module is available that has a stress test to reproduce the
> > issue and a unit test of the updated v7_dma_inv_range(). It can be
> > downloaded from
> > http://ftp.sageembedded.com/outgoing/linux/cache-test-20181102.tgz.
> > 
> > v7_dma_inv_range() is call by dmac_[un]map_area(addr, len, direction)
> > when the direction is DMA_FROM_DEVICE. One can (I believe) successfully
> > argue that DMA from a device to main memory should use buffers aligned
> > to cache line size, because the "clean & invalidate" might overwrite
> > data that the device just wrote using DMA. But if a driver does use
> > unaligned buffers, at least this fix will prevent memory corruption
> > outside the buffer.
> > 
> > Signed-off-by: chris at sageembedded.com
> 
> I think there's a simpler patch to this:

I took a quick look at the simpler patch you provided and looks
good to me.

Note that in the case of start_address and end_address
that are both unaligned and in the same cache line there will
be two back to back "clean & invalidate" on same cache line.
This will not cause any problems though, so I am okay with it
if you are. (If doing DMA to transfer less then cache line size,
then one propably in not worried about performance impact
of extra "clean & invalidate")

I will run these changes in the kernel test module and
an application that gets glibc heap corruption due to a graphics
driver using unaligned addresses for DMA.

Let me get back to you in a couple of days after testing.

This is my first time submitting a patch to Linux, not sure
what the process is from here.

If testing of your suggesting changes is good, do I provide
a version 2 of the patch with your suggested code?
Or something else?

Thanks for reviewing this patch! (After seeing the volume
of emails on this list, I though it might note get noticed)

Chris


> 
>  arch/arm/mm/cache-v7.S | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
> index 215df435bfb9..2149b47a0c5a 100644
> --- a/arch/arm/mm/cache-v7.S
> +++ b/arch/arm/mm/cache-v7.S
> @@ -360,14 +360,16 @@ ENDPROC(v7_flush_kern_dcache_area)
>  	ALT_UP(W(nop))
>  #endif
>  	mcrne	p15, 0, r0, c7, c14, 1		@ clean & invalidate D / U line
> +	addne	r0, r0, r2			@ next cache line
>  
>  	tst	r1, r3
>  	bic	r1, r1, r3
>  	mcrne	p15, 0, r1, c7, c14, 1		@ clean & invalidate D / U line
> -1:
> -	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D / U line
> -	add	r0, r0, r2
>  	cmp	r0, r1
> +1:
> +	mcrlo	p15, 0, r0, c7, c6, 1		@ invalidate D / U line
> +	addlo	r0, r0, r2
> +	cmplo	r0, r1
>  	blo	1b
>  	dsb	st
>  	ret	lr
> 
