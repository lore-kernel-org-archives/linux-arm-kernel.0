From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 16 Aug 2012 09:27:26 +0100
Subject: Discontiguous memory and cacheflush
In-Reply-To: <1822556972.575011.1345068509111.JavaMail.root@mozilla.com>
References: <20120813160008.GA30302@n2100.arm.linux.org.uk>
 <1822556972.575011.1345068509111.JavaMail.root@mozilla.com>
Message-ID: <20120816082726.GA2101@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 03:08:29PM -0700, Martin Rosenberg wrote:
> 
> 
> ----- Original Message -----
> From: "Russell King - ARM Linux" <linux@arm.linux.org.uk>
> To: "Jonathan Austin" <jonathan.austin@arm.com>
> Cc: "Martin Rosenberg" <mrosenberg@mozilla.com>, "Will Deacon" <will.deacon@arm.com>, linux-arm-kernel at lists.infradead.org
> Sent: Monday, August 13, 2012 9:00:08 AM
> Subject: Re: Discontiguous memory and cacheflush
> 
> 
> > It's intention is to support self-modifying userspace code only and also
> > intended to be used over a _short_ range of addresses only - it works by
> > flushing each _individual_ cache line over the range of addreses
> > requested.
> Documenting the current behavior would mostly be acceptable, but it is rather confusing (and took quite some time to track down)
> 
> > If it's going to be used for significantly larger areas, then we need to
> > think about imposing a limit, upon which we just flush the entire cache
> > and be done with it.
> 
> I found that there was still a net win making fewer syscalls, even with the overhead of flushing extra cache lines.
> In the cases where the range is discontiguous, I usually need to do something silly, like flush 20 individual instructions that are scattered throughout several hundred MB of memory.  I think the fastest method for flushing in this case would be to shave a different call, with a different api, where userspace can provide an array of addresses that need to be flushed, but that sounds like material for a new thread.  Thanks --Marty

Could we use the currently must-be-zero flags parameter to add new
functionality to this syscall, or are there legacy uses of that
parameter (or history of userspace not bothering to zero it?)

For example, we could have something like

do_cache_op(struct iovec *iov, int iovcnt, CF_IOVEC)

to flush a discontiguous set of ranges described by an iovec (though we
can of course also describe the ranges in other ways)

Cheers
---Dave
