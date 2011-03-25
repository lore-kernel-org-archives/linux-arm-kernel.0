From: lbassel@codeaurora.org (Larry Bassel)
Date: Fri, 25 Mar 2011 10:39:28 -0700
Subject: how can I cleanly exclude memory from the kernel memory allocator?
In-Reply-To: <alpine.LFD.2.00.1103241912390.11889@xanadu.home>
References: <20110324221854.GA29359@labbmf-linux.qualcomm.com>
	<alpine.LFD.2.00.1103241912390.11889@xanadu.home>
Message-ID: <20110325173928.GD29359@labbmf-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 Mar 11 19:27, Nicolas Pitre wrote:
> On Thu, 24 Mar 2011, Larry Bassel wrote:
> 
> > I want to (early in system initialization) exclude some
> > contiguous physical memory from one or more memory banks
> > so that it won't be mapped in the normal kernel 1-to-1 mapping
> > (so that it can be mapped uncached, strongly ordered, etc.
> > as needed -- I know that it is forbidden to have a cached
> > and an uncached mapping to the same memory) and so that it
> > won't be freed into the kernel memory allocator (so that
> > it won't fragment and can be allocated using genalloc).
> > 
> > I have tried to find a clean way to do this, but none of
> > the approaches I've considered seem very good:
> > 
> > 1. Add a hook to the memory tag parsing routine to (possibly)
> > change each tag before arm_add_memory() is called,
> > or alter arm_add_memory() itself.
> 
> There is already a hook for that.  In your machine descriptor you can 
> add a .fixup method to do just that.  See tag_fixup_mem32() in 
> arch/arm/mach-orion5x/common.c for a usage example.

OK, please ignore my previous mail, I see that .fixup can be
used to adjust tags. It appears to me, however, that using a
.reserve function calling memblock_reserve will be an
easier way of doing what I need.

Thanks.

> 
> 
> Nicolas

Larry
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
