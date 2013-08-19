From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 19 Aug 2013 10:48:02 +1000
Subject: [patch v2 3/3] mm: page_alloc: fair zone allocator policy
In-Reply-To: <8738q9b8xg.fsf@kernel.org>
References: <1375457846-21521-1-git-send-email-hannes@cmpxchg.org>
 <1375457846-21521-4-git-send-email-hannes@cmpxchg.org>
 <20130807145828.GQ2296@suse.de> <20130807153743.GH715@cmpxchg.org>
 <20130808041623.GL1845@cmpxchg.org> <87haepblo2.fsf@kernel.org>
 <20130816201814.GA26409@cmpxchg.org> <8738q9b8xg.fsf@kernel.org>
Message-ID: <20130819104802.e5a8088d87ba81c5ad0d2a66@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Fri, 16 Aug 2013 14:52:11 -0700 Kevin Hilman <khilman@linaro.org> wrote:
>
> Johannes Weiner <hannes@cmpxchg.org> writes:
> 
> > On Fri, Aug 16, 2013 at 10:17:01AM -0700, Kevin Hilman wrote:
> >> Johannes Weiner <hannes@cmpxchg.org> writes:
> >> > On Wed, Aug 07, 2013 at 11:37:43AM -0400, Johannes Weiner wrote:
> >> > Subject: [patch] mm: page_alloc: use vmstats for fair zone allocation batching
> >> >
> >> > Avoid dirtying the same cache line with every single page allocation
> >> > by making the fair per-zone allocation batch a vmstat item, which will
> >> > turn it into batched percpu counters on SMP.
> >> >
> >> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> >> 
> >> I bisected several boot failures on various ARM platform in
> >> next-20130816 down to this patch (commit 67131f9837 in linux-next.)
> >> 
> >> Simply reverting it got things booting again on top of -next.  Example
> >> boot crash below.
> >
> > Thanks for the bisect and report!
> 
> You're welcome.  Thanks for the quick fix!
> 
> > I deref the percpu pointers before initializing them properly.  It
> > didn't trigger on x86 because the percpu offset added to the pointer
> > is big enough so that it does not fall into PFN 0, but it probably
> > ended up corrupting something...
> >
> > Could you try this patch on top of linux-next instead of the revert?
> 
> Yup, that change fixes it.
> 
> Tested-by: Kevin Hilman <khilman@linaro.org>

> Tested-by: Stephen Warren <swarren@nvidia.com>

I will add that into the akpm-current tree in linux-next today (unless
Andrew releases a new mmotm in the mean time).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130819/9b117b24/attachment.sig>
