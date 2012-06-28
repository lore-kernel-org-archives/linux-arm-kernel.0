From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 28 Jun 2012 13:50:16 -0400 (EDT)
Subject: [PATCH] [RESEND] arm: limit memblock base address for
 early_pte_alloc
In-Reply-To: <20120628090827.GH19026@n2100.arm.linux.org.uk>
References: <1338880312-17561-1-git-send-email-minchan@kernel.org>
 <20120627161224.GB2310@linaro.org>
 <alpine.LFD.2.02.1206280019160.31003@xanadu.home>
 <20120628090827.GH19026@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1206281338170.31003@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Jun 2012, Russell King - ARM Linux wrote:

> Err, I don't think you understand what's going on here.
> 
> The sequence is:
> 
> 1. setup the initial mappings so we can run the kernel in virtual space.
> 2. provide the memory areas to memblock
> 3. ask the platform to reserve whatever memory it wants from memblock
>    [this means using memblock_reserve or arm_memblock_steal).  The
>    reserved memory is *not* expected to be mapped at this point, and is
>    therefore inaccessible.
> 4. Setup the lowmem mappings.

I do understand that pretty well so far.

> And when we're setting up the lowmem mappings, we do *not* expect to
> create any non-section page mappings, which again means we have no reason
> to use the memblock allocator to obtain memory that we want to immediately
> use.

And why does this have to remain so?

> So I don't know where you're claim of being "fragile" is coming from.

It doesn't come from anything you've described so far. It comes from 
those previous attempts at lifting this limitation.  I think that my 
proposal is much less fragile than the other ones.

> What is fragile is people wanting to use arm_memblock_steal() without
> following the rules for it I layed down.

What about enhancing your rules if the technical limitations they were 
based on are lifted?


Nicolas
