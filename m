From: mrosenberg@mozilla.com (Martin Rosenberg)
Date: Wed, 15 Aug 2012 15:08:29 -0700 (PDT)
Subject: Discontiguous memory and cacheflush
In-Reply-To: <20120813160008.GA30302@n2100.arm.linux.org.uk>
Message-ID: <1822556972.575011.1345068509111.JavaMail.root@mozilla.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



----- Original Message -----
From: "Russell King - ARM Linux" <linux@arm.linux.org.uk>
To: "Jonathan Austin" <jonathan.austin@arm.com>
Cc: "Martin Rosenberg" <mrosenberg@mozilla.com>, "Will Deacon" <will.deacon@arm.com>, linux-arm-kernel at lists.infradead.org
Sent: Monday, August 13, 2012 9:00:08 AM
Subject: Re: Discontiguous memory and cacheflush


> It's intention is to support self-modifying userspace code only and also
> intended to be used over a _short_ range of addresses only - it works by
> flushing each _individual_ cache line over the range of addreses
> requested.
Documenting the current behavior would mostly be acceptable, but it is rather confusing (and took quite some time to track down)

> If it's going to be used for significantly larger areas, then we need to
> think about imposing a limit, upon which we just flush the entire cache
> and be done with it.

I found that there was still a net win making fewer syscalls, even with the overhead of flushing extra cache lines.
In the cases where the range is discontiguous, I usually need to do something silly, like flush 20 individual instructions that are scattered throughout several hundred MB of memory.  I think the fastest method for flushing in this case would be to shave a different call, with a different api, where userspace can provide an array of addresses that need to be flushed, but that sounds like material for a new thread.  Thanks --Marty
